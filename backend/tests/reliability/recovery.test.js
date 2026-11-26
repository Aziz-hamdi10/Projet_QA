const mongoose = require('mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');
const request = require('supertest');
const fs = require('fs');
const os = require('os');
const path = require('path');
const { performance } = require('perf_hooks');
const app = require('../../app');
const Size = require('../../models/size');

jest.setTimeout(120000);
let mongo, dbPath, uri, port;
const evidence = {};
const api = () => request(app);
const getSizes = () => api().get('/size/getsizes').timeout({ response: 12000, deadline: 15000 });

beforeAll(async () => {
  if (mongoose.connection.readyState !== 0) throw new Error('Unexpected existing MongoDB connection');
  dbPath = fs.mkdtempSync(path.join(os.tmpdir(), 'bridgewear-recovery-'));
  mongo = await MongoMemoryServer.create({ instance: { dbPath, storageEngine: 'wiredTiger', ip: '127.0.0.1' } });
  uri = mongo.getUri();
  port = mongo.instanceInfo.port;
  await mongoose.connect(uri, { dbName: 'bridgewear_recovery_test', serverSelectionTimeoutMS: 2500, heartbeatFrequencyMS: 500, bufferCommands: false });
  await Size.init();
});

afterAll(async () => {
  try {
    fs.mkdirSync('quality/reports', { recursive: true });
    fs.writeFileSync('quality/reports/recovery-metrics.json', JSON.stringify(evidence, null, 2));
  } finally {
    try { if (dbPath) await mongoose.disconnect(); }
    finally {
      if (mongo) await mongo.stop();
      if (dbPath) fs.rmSync(dbPath, { recursive: true, force: true, maxRetries: 5, retryDelay: 200 });
    }
  }
});

test('RT-01: controlled write failure does not prevent a later successful write', async () => {
  const name = 'Recovery simulated failure';
  const spy = jest.spyOn(Size.prototype, 'save').mockRejectedValueOnce(new Error('Injected write failure'));
  let failed;
  try { failed = await api().post('/size/addsize').send({ name }); }
  finally { spy.mockRestore(); }
  evidence.injectedWriteFailure = { httpStatus: failed.status };
  expect(failed.status).toBe(500);
  expect(await Size.countDocuments({ name })).toBe(0);
  const retry = await api().post('/size/addsize').send({ name });
  evidence.injectedWriteFailure.retryStatus = retry.status;
  expect(retry.status).toBe(201);
  expect(await Size.countDocuments({ name })).toBe(1);
});

test('RT-02: actual MongoDB shutdown and restart, automatic reconnection and data retention', async () => {
  const created = await api().post('/size/addsize').send({ name: 'Recovery persisted size' });
  expect(created.status).toBe(201);
  const id = String(created.body._id);
  expect(id).toMatch(/^[a-f0-9]{24}$/i);
  const before = await getSizes();
  expect(before.status).toBe(200);
  expect(before.body.some(s => String(s._id) === id)).toBe(true);
  evidence.mongoOutage = { beforeStatus: before.status, persistedId: id };
  // Graceful shutdown of the actual isolated mongod process; keep its files.
  await mongo.stop({ doCleanup: false, force: false });
  const outageStarted = performance.now();
  const failed = await getSizes();
  evidence.mongoOutage.duringStatus = failed.status;
  evidence.mongoOutage.failureResponseMs = Math.round(performance.now() - outageStarted);
  // Restart on the same port and data directory, without reconnecting Mongoose manually.
  const restartStarted = performance.now();
  mongo = await MongoMemoryServer.create({ instance: { dbPath, port, storageEngine: 'wiredTiger', ip: '127.0.0.1' } });
  const deadline = restartStarted + 30000;
  let recovered;
  do {
    recovered = await getSizes();
    if (recovered.status === 200) break;
    await new Promise(resolve => setTimeout(resolve, 250));
  } while (performance.now() < deadline);
  evidence.mongoOutage.afterStatus = recovered.status;
  evidence.mongoOutage.restartToFirstSuccessMs = recovered.status === 200 ? Math.round(performance.now() - restartStarted) : null;
  evidence.mongoOutage.observedOutageMs = recovered.status === 200 ? Math.round(performance.now() - outageStarted) : null;
  evidence.mongoOutage.originalRecordPreserved = recovered.status === 200 && Array.isArray(recovered.body) && recovered.body.some(s => String(s._id) === id && s.name === 'Recovery persisted size');
  expect([500, 503]).toContain(failed.status);
  expect(recovered.status).toBe(200);
  expect(evidence.mongoOutage.restartToFirstSuccessMs).toBeLessThanOrEqual(30000);
  expect(evidence.mongoOutage.originalRecordPreserved).toBe(true);
  const newWrite = await api().post('/size/addsize').send({ name: 'Recovery after restart' });
  evidence.mongoOutage.afterWriteStatus = newWrite.status;
  expect(newWrite.status).toBe(201);
  expect(await Size.countDocuments({ name: 'Recovery after restart' })).toBe(1);
});

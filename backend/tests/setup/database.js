const mongoose = require('mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');
let mongo;
let connection;
async function connectDB() {
  if (mongoose.connection.readyState !== 0) throw new Error('Unexpected existing MongoDB connection');
  mongo = await MongoMemoryServer.create();
  await mongoose.connect(mongo.getUri(), { dbName: 'bridgewear_test' });
  connection = mongoose.connection;
  await Promise.all(Object.values(mongoose.models).map(model => model.init()));
}
async function clearDB() {
  if (!connection || connection.readyState !== 1 || connection.name !== 'bridgewear_test') return;
  for (const collection of Object.values(connection.collections)) await collection.deleteMany({});
}
async function closeDB() {
  try { if (connection || mongo) await mongoose.disconnect(); }
  finally { if (mongo) await mongo.stop(); mongo = undefined; connection = undefined; }
}
module.exports = { connectDB, clearDB, closeDB };

const request = require('supertest');
const mongoose = require('mongoose');
const app = require('../../app');
const Frais = require('../../models/frais');
const Size = require('../../models/size');
const Color = require('../../models/color');
const Product = require('../../models/Product');
const Promotion = require('../../models/promotion');
const { connectDB, clearDB, closeDB } = require('../setup/database');

beforeAll(connectDB, 180000);
afterEach(clearDB, 30000);
afterAll(closeDB, 30000);

 describe('Frais HTTP + MongoDB', () => {
  test('IT-01 creates and persists fees', async () => {
    const r = await request(app).post('/frais/addfrais').send({value: 7});
    expect(r.status).toBe(201);
    expect((await Frais.findById(r.body.frais._id)).value).toBe(7);
  });
  test('IT-02 retrieves latest fees', async () => {
    await Frais.create({value: 3, dateadd: new Date('2025-01-01')}, {value: 8, dateadd: new Date('2025-02-01')});
    const r = await request(app).get('/frais/getLatestFrais');
    expect(r.status).toBe(200);
    expect(r.body.latestFrais.value).toBe(8);
  });
  test('IT-03 returns 404 when empty', async () => {
    expect((await request(app).get('/frais/getLatestFrais')).status).toBe(404);
  });
});

describe('Size HTTP + MongoDB', () => {
  test('IT-04 creates size', async () => {
    const r = await request(app).post('/size/addsize').send({name:'XL'});
    expect(r.status).toBe(201);
    expect((await Size.findById(r.body._id)).name).toBe('XL');
  });
  test('IT-05 lists sizes', async () => {
    await Size.create({name:'S'}, {name:'M'});
    const r = await request(app).get('/size/getsizes');
    expect(r.status).toBe(200);
    expect(r.body.map(x=>x.name)).toEqual(expect.arrayContaining(['S','M']));
  });
  test('IT-06 reads size by ID', async () => {
    const s = await Size.create({name:'L'});
    const r = await request(app).get('/size/getsize/'+s.id);
    expect(r.status).toBe(200); expect(r.body.name).toBe('L');
  });
  test('IT-07 updates size', async () => {
    const s = await Size.create({name:'L'});
    const r = await request(app).put('/size/updatesize/'+s.id).send({name:'XXL'});
    expect(r.status).toBe(200); expect((await Size.findById(s.id)).name).toBe('XXL');
  });
  test('IT-08 deletes size', async () => {
    const s = await Size.create({name:'L'});
    expect((await request(app).delete('/size/deletesize/'+s.id)).status).toBe(200);
    expect(await Size.findById(s.id)).toBeNull();
  });
  test('IT-09 missing size returns 404', async () => {
    expect((await request(app).get('/size/getsize/'+new mongoose.Types.ObjectId())).status).toBe(404);
  });
  test('IT-10 existing name is unavailable (case insensitive)', async () => {
    await Size.create({name:'XL'});
    const r = await request(app).get('/size/check-sizename/xl');
    expect(r.status).toBe(200); expect(r.body.available).toBe(false);
  });
});

describe('Color HTTP + MongoDB', () => {
  test('IT-11 creates color', async () => {
    const r = await request(app).post('/color/addcolor').send({name:'Blue',hexCode:'#0000FF'});
    expect(r.status).toBe(201); expect((await Color.findById(r.body._id)).hexCode).toBe('#0000FF');
  });
  test('IT-12 modifies color', async () => {
    const c = await Color.create({name:'Blue',hexCode:'#0000FF'});
    const r = await request(app).put('/color/modify-color/'+c.id).send({name:'Red',hexCode:'#FF0000'});
    expect(r.status).toBe(200); expect((await Color.findById(c.id)).hexCode).toBe('#FF0000');
  });
  test('IT-13 lists colors', async () => {
    await Color.create({name:'Blue',hexCode:'#0000FF'});
    const r = await request(app).get('/color/getcolors');
    expect(r.status).toBe(200); expect(r.body).toHaveLength(1);
  });
});

describe('Product and promotion HTTP + MongoDB', () => {
  test('IT-14 creates product with existing color and size references', async () => {
    const c = await Color.create({name:'Blue',hexCode:'#0000FF'});
    const s = await Size.create({name:'M'});
    const r = await request(app).post('/product/addproduct').send({name:'Test Shirt',sellingPrice:25,idcolor:c.id,size:s.id});
    expect(r.status).toBe(200);
    const p = await Product.findById(r.body._id);
    expect(p.sellingPrice).toBe(25); expect(String(p.idcolor)).toBe(c.id); expect(String(p.size)).toBe(s.id);
  });
  test('IT-15 creates promotion with generated code', async () => {
    const r = await request(app).post('/promotion/addpromotion').send({title:'Test promo',percentage:10});
    expect(r.status).toBe(201);
    const p = await Promotion.findById(r.body._id);
    expect(p.title).toBe('Test promo'); expect(p.codepromo).toMatch(/^\d{6}$/); expect(p.percentage).toBe(10);
  });
  test('IT-16 retrieves promotion by ID', async () => {
    const p = await Promotion.create({title:'Test promo',codepromo:'123456'});
    const r = await request(app).get('/promotion/getpromotion/'+p.id);
    expect(r.status).toBe(200); expect(r.body.title).toBe(p.title);
  });
});

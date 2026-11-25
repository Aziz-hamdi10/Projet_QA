const request = require('supertest');
const app = require('../../app');
const Size = require('../../models/size');
const Color = require('../../models/color');
const Product = require('../../models/Product');
const Order = require('../../models/order');
const User = require('../../models/user');
const Frais = require('../../models/frais');
const { connectDB, clearDB, closeDB } = require('../setup/database');

beforeAll(connectDB, 180000);
afterEach(clearDB, 30000);
afterAll(closeDB, 30000);

function statuses(responses) { return responses.map(r => r.status); }

test('CT-01 concurrent duplicate sizes: only one persisted', async () => {
  const responses = await Promise.all(Array.from({length: 10}, () => request(app).post('/size/addsize').send({name: 'Concurrent XL'})));
  console.log('CT-01 statuses:', statuses(responses));
  expect(responses.filter(r => r.status === 201)).toHaveLength(1);
  expect(await Size.countDocuments({name: 'Concurrent XL'})).toBe(1);
  // Duplicate errors should be client conflicts, not internal server errors.
  expect(responses.filter(r => r.status !== 201).map(r => r.status)).toEqual(Array(9).fill(409));
});

test('CT-02 concurrent distinct colors: no lost writes', async () => {
  const responses = await Promise.all(Array.from({length: 10}, (_, i) => request(app).post('/color/addcolor').send({name: `Concurrent color ${i}`, hexCode: '#0000FF'})));
  console.log('CT-02 statuses:', statuses(responses));
  expect(statuses(responses)).toEqual(Array(10).fill(201));
  expect(await Color.countDocuments()).toBe(10);
  expect(new Set(responses.map(r => r.body._id)).size).toBe(10);
});

test('CT-03 concurrent booking: only one order for a single available product', async () => {
  const seller = await User.create({username: 'seller'});
  const buyers = await User.create([{username:'buyer1'}, {username:'buyer2'}]);
  await Frais.create({value: 7});
  const product = await Product.create({name: 'Single item', sellingPrice:25, state:'Available', iduser:seller.id});
  const responses = await Promise.all(buyers.map(buyer => request(app).post('/order/addorder').send({product:product.id, idbuyer:buyer.id, etat:'Pending', prixtotal:32})));
  const count = await Order.countDocuments({product:product.id});
  const finalProduct = await Product.findById(product.id);
  console.log('CT-03 statuses:', statuses(responses), 'orders:', count, 'product state:', finalProduct.state);
  expect({accepted: responses.filter(r => r.status === 201).length, orders: count, state: finalProduct.state}).toEqual({accepted:1, orders:1, state:'booked'});
  expect(responses.filter(r => r.status !== 201).map(r => r.status)).toEqual([409]);
});

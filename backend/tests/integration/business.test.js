const request = require('supertest');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
// Test-only key; set before importing application modules.
process.env.JWT_SECRET = crypto.randomBytes(32).toString('hex');
const app = require('../../app');
const User = require('../../models/user');
const Product = require('../../models/Product');
const Order = require('../../models/order');
const Frais = require('../../models/frais');
const { connectDB, clearDB, closeDB } = require('../setup/database');
const password = 'Fixture-Only-Password!42';
let admin, moderator, client, seller;
const auth = token => `Bearer ${token}`;
async function login(user, pass = password) {
  return request(app).post('/user/login').send({email:user.email,password:pass});
}
async function tokenFor(user) {
  const r = await login(user); expect(r.status).toBe(200);
  expect(typeof r.body.mytoken).toBe('string'); return r.body.mytoken;
}
beforeAll(connectDB, 180000);
beforeEach(async () => {
  await clearDB();
  const hash = await bcrypt.hash(password, 4);
  [admin, moderator, client, seller] = await User.create(...['admin','Moderator','client','client'].map((role,i)=>({role,email:`qa${i}@example.invalid`,username:`qa${i}`,firstname:'QA',secondname:`${i}`,state:'active',password:hash})));
});
afterAll(closeDB, 30000);

describe('Authentication', () => {
  test('AUTH-01 valid credentials and real token access', async()=>{
    const token=await tokenFor(client);
    const r=await request(app).get('/user/getuserbytoken').set('Authorization',auth(token));
    expect(r.status).toBe(200); expect(r.body._id).toBe(client.id);
  });
  test('AUTH-02 wrong password rejected',async()=>{expect([400,401,403]).toContain((await login(client,'wrong')).status);});
  test('AUTH-03 unknown account rejected',async()=>{expect([400,401,404]).toContain((await login({email:'missing@example.invalid'})).status);});
  test('AUTH-04 missing token rejected',async()=>{expect((await request(app).get('/user/getuserbytoken')).status).toBe(401);});
  test('AUTH-05 malformed token rejected',async()=>{expect((await request(app).get('/user/getuserbytoken').set('Authorization',auth('invalid'))).status).toBe(401);});
  test('AUTH-06 expired token rejected',async()=>{
    const valid=await tokenFor(client); jwt.verify(valid,process.env.JWT_SECRET); // ensures key matches app
    const expired=jwt.sign({userId:client.id},process.env.JWT_SECRET,{expiresIn:-60});
    expect((await request(app).get('/user/getuserbytoken').set('Authorization',auth(expired))).status).toBe(401);
  });
  test('AUTH-07 no password hash in login response',async()=>{
    const r=await login(client); expect(r.status).toBe(200); expect(r.body.user).toBeDefined(); expect(r.body.user).not.toHaveProperty('password');
  });
  test('AUTH-08 no password hash in authenticated profile',async()=>{
    const r=await request(app).get('/user/getuserbytoken').set('Authorization',auth(await tokenFor(client)));
    expect(r.status).toBe(200); expect(r.body).not.toHaveProperty('password');
  });
});
describe('Role permissions — expected secure behavior',()=>{
  test.each(['admin','Moderator'])('RBAC privileged %s can list clients',async(role)=>{
    const u=role==='admin'?admin:moderator;
    const r=await request(app).get('/user/getusers/'+u.id).set('Authorization',auth(await tokenFor(u)));
    expect(r.status).toBe(200); expect(Array.isArray(r.body)).toBe(true); expect(r.body.map(x=>x._id)).toContain(client.id);
  });
  test('RBAC-03 client cannot list clients using own ID',async()=>{
    const r=await request(app).get('/user/getusers/'+client.id).set('Authorization',auth(await tokenFor(client)));
    expect([401,403,404]).toContain(r.status);
  });
  test('RBAC-04 anonymous caller cannot use admin ID',async()=>{
    const r=await request(app).get('/user/getusers/'+admin.id); expect([401,403,404]).toContain(r.status);
  });
  test('RBAC-05 client cannot impersonate admin via URL',async()=>{
    const r=await request(app).get('/user/getusers/'+admin.id).set('Authorization',auth(await tokenFor(client))); expect([401,403,404]).toContain(r.status);
  });
});
async function fixture(){
  await Frais.create({value:7});
  return Product.create({name:'QA Shirt',sellingPrice:25,state:'Available',iduser:seller.id});
}
async function reserve(p){return request(app).post('/order/addorder').set('Authorization',auth(await tokenFor(client))).send({product:p.id,idbuyer:client.id,etat:'Pending',prixtotal:32});}
describe('Workflow and business rules',()=>{
  test('WF-01 reserve available product and persist order',async()=>{
    const p=await fixture(); const r=await reserve(p); expect(r.status).toBe(201);
    expect((await Product.findById(p.id)).state).toBe('booked'); const o=await Order.findById(r.body._id); expect(String(o.product)).toBe(p.id); expect(o.etat).toBe('Pending');
  });
  test('WF-02 second reservation must be rejected',async()=>{
    const p=await fixture(); expect((await reserve(p)).status).toBe(201); expect([400,409,422]).toContain((await reserve(p)).status); expect(await Order.countDocuments({product:p.id})).toBe(1);
  });
  test('WF-03 cancellation releases reserved product',async()=>{
    const p=await fixture(); const r=await reserve(p); expect(r.status).toBe(201);
    const a=await request(app).put('/order/update-state/'+r.body._id).set('Authorization',auth(await tokenFor(admin))).send({newState:'Canceled'});
    expect(a.status).toBe(200); expect((await Order.findById(r.body._id)).etat).toBe('Canceled'); expect((await Product.findById(p.id)).state).toBe('Available');
  });
  test('WF-04 invalid state must be rejected without changing DB',async()=>{
    const p=await fixture(); const r=await reserve(p); expect(r.status).toBe(201);
    const a=await request(app).put('/order/update-state/'+r.body._id).set('Authorization',auth(await tokenFor(admin))).send({newState:'INVALID_QA_STATE'});
    expect([400,409,422]).toContain(a.status); expect((await Order.findById(r.body._id)).etat).toBe('Pending');
  });
  test('WF-05 state update requires token',async()=>{
    const p=await fixture(); const r=await reserve(p); expect(r.status).toBe(201);
    expect((await request(app).put('/order/update-state/'+r.body._id).send({newState:'Finished'})).status).toBe(401);
    expect((await Order.findById(r.body._id)).etat).toBe('Pending');
  });
  test('DB-01 role aggregation counts seeded clients',async()=>{
    const r=await request(app).post('/user/count-users-by-role').set('Authorization',auth(await tokenFor(admin))).send({role:'client'});
    expect(r.status).toBe(200); expect(r.body.userCount).toBe(2);
  });
});

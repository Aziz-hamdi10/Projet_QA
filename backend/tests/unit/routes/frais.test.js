const Frais = require('../../../models/frais');
const router = require('../../../routes/frais');
function handler(path, method) {return router.stack.find(l=>l.route?.path===path && l.route.methods[method]).route.stack[0].handle;}
let res;
beforeEach(()=>{res={status:jest.fn().mockReturnThis(),json:jest.fn()};});
test('creates fees',async()=>{jest.spyOn(Frais.prototype,'save').mockResolvedValue();await handler('/addfrais','post')({body:{value:12}},res);expect(res.status).toHaveBeenCalledWith(201);expect(res.json.mock.calls[0][0].frais.value).toBe(12);});
test('returns latest fees',async()=>{const value={value:12};const sort=jest.fn().mockReturnValue({exec:jest.fn().mockResolvedValue(value)});jest.spyOn(Frais,'findOne').mockReturnValue({sort});await handler('/getLatestFrais','get')({},res);expect(sort).toHaveBeenCalledWith({dateadd:-1});expect(res.status).toHaveBeenCalledWith(200);expect(res.json).toHaveBeenCalledWith({latestFrais:value});});
test('returns 404 when no fees exist',async()=>{jest.spyOn(Frais,'findOne').mockReturnValue({sort:()=>({exec:async()=>null})});await handler('/getLatestFrais','get')({},res);expect(res.status).toHaveBeenCalledWith(404);});
test('handles database error',async()=>{jest.spyOn(console,'error').mockImplementation(()=>{});jest.spyOn(Frais,'findOne').mockReturnValue({sort:()=>({exec:async()=>{throw Error('test failure');}})});await handler('/getLatestFrais','get')({},res);expect(res.status).toHaveBeenCalledWith(500);});

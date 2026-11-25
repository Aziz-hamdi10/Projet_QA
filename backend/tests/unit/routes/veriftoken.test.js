const jwt = require('jsonwebtoken');
const middleware = require('../../../routes/veriftoken');
jest.mock('jsonwebtoken', () => ({verify:jest.fn()}));
let res, next;
beforeEach(() => {res={status:jest.fn().mockReturnThis(),json:jest.fn()};next=jest.fn();});
test('rejects missing token', () => {middleware({header:()=>undefined},res,next);expect(res.status).toHaveBeenCalledWith(401);expect(jwt.verify).not.toHaveBeenCalled();expect(next).not.toHaveBeenCalled();});
test('rejects invalid token', () => {jwt.verify.mockImplementationOnce((token,key,cb)=>cb(new Error('invalid')));middleware({header:()=> 'Bearer invalid'},res,next);expect(res.status).toHaveBeenCalledWith(401);expect(next).not.toHaveBeenCalled();});
test('sets userId and continues for verified token', () => {jwt.verify.mockImplementationOnce((token,key,cb)=>cb(null,{userId:'test-user'}));const req={header:()=> 'Bearer sample'};middleware(req,res,next);expect(jwt.verify.mock.calls[0][0]).toBe('sample');expect(req.userId).toBe('test-user');expect(next).toHaveBeenCalledTimes(1);expect(res.status).not.toHaveBeenCalled();});

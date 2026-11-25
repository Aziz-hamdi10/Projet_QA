const Subscription = require('../../../models/Subscription');
const router = require('../../../routes/Subscription');
const handler = router.stack.find(l=>l.route?.path==='/check-following').route.stack[0].handle;
let res;
const req={body:{currentUser:'user-a',targetUser:'user-b'}};
beforeEach(()=>{res={status:jest.fn().mockReturnThis(),json:jest.fn()};});
test.each([[{},true],[null,false]])('returns following status for %p',async (record,expected)=>{const find=jest.spyOn(Subscription,'findOne').mockResolvedValue(record);await handler(req,res);expect(find).toHaveBeenCalledWith({subscriber:'user-a',subscribedTo:'user-b'});expect(res.json).toHaveBeenCalledWith({isFollowing:expected});});
test('handles subscription lookup failure',async()=>{jest.spyOn(console,'error').mockImplementation(()=>{});jest.spyOn(Subscription,'findOne').mockRejectedValue(new Error('test failure'));await handler(req,res);expect(res.status).toHaveBeenCalledWith(500);expect(res.json).toHaveBeenCalledWith({error:'Internal Server Error'});});

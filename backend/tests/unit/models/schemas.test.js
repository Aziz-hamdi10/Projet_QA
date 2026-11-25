const mongoose = require('mongoose');
const id = new mongoose.Types.ObjectId();
const cases = [
  ['Subscription', { subscriber:id, subscribedTo:id }, ['subscriber','subscribedTo']],
  ['avis', {content:'Good',rating:4}, ['content','rating']],
  ['brand', {title:'Brand',image:'brand.png'}, ['title','image']],
  ['color', {name:'Blue',hexCode:'#0000ff'}, ['name','hexCode']],
  ['commentaire', {userid:id,message:'Hello'}, ['userid','message']],
  ['departement', {title:'Shoes',image:'shoes.png'}, ['title','image']],
  ['frais', {value:5}, ['value']],
  ['notification', {message:'Hello',title:'Notice'}, ['message','title']],
  ['order', {etat:'pending',prixtotal:50}, ['etat','prixtotal']],
  ['promotion', {title:'Sale',codepromo:'SALE'}, ['title','codepromo']],
  ['size', {name:'M'}, ['name']]
];
for (const [name, valid, required] of cases) {
  describe(`${name} schema`, () => {
    const Model = require(`../../../models/${name}`);
    test('accepts valid document', () => expect(new Model(valid).validateSync()).toBeUndefined());
    for (const field of required) {
      test(`rejects missing ${field}`, () => {
        const input = {...valid}; delete input[field];
        expect(new Model(input).validateSync().errors[field].kind).toBe('required');
      });
    }
  });
}
describe('Schema casting and defaults', () => {
  const Order = require('../../../models/order');
  const Product = require('../../../models/Product');
  const User = require('../../../models/user');
  test('order timestamps start null', () => {
    const order = new Order({etat:'pending',prixtotal:50});
    for (const field of ['dateconfirm','datedelievry','datefinished','datetaked','datecancel']) expect(order[field]).toBeNull();
    expect(order.dateadd).toBeInstanceOf(Date);
  });
  test('order rejects invalid total type', () => expect(new Order({etat:'pending',prixtotal:'abc'}).validateSync().errors.prixtotal.name).toBe('CastError'));
  test('product casts numeric price', () => expect(new Product({sellingPrice:'25'}).sellingPrice).toBe(25));
  test('product rejects invalid category ObjectId', () => expect(new Product({idcateg:'bad'}).validateSync().errors.idcateg.name).toBe('CastError'));
  test('user datecode defaults to a date', () => expect(new User().datecode).toBeInstanceOf(Date));
});

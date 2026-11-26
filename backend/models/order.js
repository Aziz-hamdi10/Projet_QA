const mongoose=require('mongoose');
const order=mongoose.model('order',{
  
      product: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Product'
      },
      dateadd: {
        type: Date,
        default: Date.now
      },
      etat: {
        type: String,
        required: true
      },
      dateconfirm: {
        type: Date,
        default: null
      },
      datedelievry: {
        type: Date,
        default: null
      },
      datefinished: {
        type: Date,
        default: null
      },
      datetaked: {
        type: Date,
        default: null
      },
      datecancel: {
        type: Date,
        default: null
      },
      postal_code: {
        type: String,

      },
      street: {
        type: String,

      },
      city: {
        type: String,

      },
      state: {
        type: String,

      },
      prixtotal: {
        type: Number,
        required: true
      },
      idbuyer:{
        type: mongoose.Schema.Types.ObjectId,
        ref:'user'
    
      },
      idliv:{
        type: mongoose.Schema.Types.ObjectId,
        ref:'user'
    
      },
      frais:{
        type: mongoose.Schema.Types.ObjectId,
        ref:'frais'
    
      }

}
);
module.exports=order;

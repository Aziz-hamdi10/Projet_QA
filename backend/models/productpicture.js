const mongoose=require('mongoose');
const Schema = mongoose.Schema;

const Productpicture=mongoose.model('Productpicture',{
    productid: {
        type: Schema.Types.ObjectId,
        ref: 'Product', 
    },
  
   
    image:{
        type:String
    }
})
module.exports=Productpicture;
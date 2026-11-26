const mongoose = require('mongoose');

const wishlist = mongoose.model('Wishlist', {
   
  
    

    iduser :{
        type: mongoose.Schema.Types.ObjectId,  
        ref: 'user'

    },
    
    idproduct :{
        type: mongoose.Schema.Types.ObjectId,  
        ref: 'product'

    },
   
    
    date :{
        type: Date,
        ref: 'user'

    }
});
module.exports = wishlist;

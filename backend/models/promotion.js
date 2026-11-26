const mongoose = require('mongoose');

const promotionshema = new mongoose.Schema({
    title: {
        type: String,
        required: true,
        unique: true
    },
    codepromo: {
      type: String,
      required: true,
      unique: true
  },
    datestart: {
        type: Date,
      },
      dateend: {
        type: Date,
      },
      state: {
        type: String,
      },
      percentage: {
        type: Number,
      },
      iddepartement :{
        type: mongoose.Schema.Types.ObjectId,  
        ref: 'departement'

}
});

const promotion = mongoose.model('promotion', promotionshema);

module.exports = promotion;
const mongoose = require('mongoose');

const commentairenotification = new mongoose.Schema({
  userid: { type: mongoose.Schema.Types.ObjectId, ref: 'user', required: true }, 
  message: { type: String, required: true },
  productid: {   type: mongoose.Schema.Types.ObjectId,
    ref: 'Product'},

  date: { type: Date, default: Date.now } 

});

const Commentaire = mongoose.model('Commentaire', commentairenotification);

module.exports = Commentaire;
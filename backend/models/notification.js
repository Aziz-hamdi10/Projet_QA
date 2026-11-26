const mongoose = require('mongoose');

const notificationSchema = new mongoose.Schema({

  message: { type: String, required: true },
  title: { type: String, required: true },
  senderid: {   type: mongoose.Schema.Types.ObjectId,
    ref: 'user'},
    ownerId: {   type: mongoose.Schema.Types.ObjectId,
      ref: 'user'},
    link :{
      type:String,  

  },

  date: { type: Date, default: Date.now } 

});

const Notification = mongoose.model('Notification', notificationSchema);

module.exports = Notification;
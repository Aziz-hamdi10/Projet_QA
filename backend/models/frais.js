const mongoose = require('mongoose');

const fraisshema = new mongoose.Schema({
    value: {
        type: Number,
        required: true,
    },
    dateadd: {
        type: Date,
        default: Date.now
      },    
});

const frais = mongoose.model('frais', fraisshema);

module.exports = frais;

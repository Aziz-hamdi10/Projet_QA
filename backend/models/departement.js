const mongoose = require('mongoose');

const departementshema = new mongoose.Schema({
    title: {
        type: String,
        required: true,
        unique: true
    },
    image: {
        type: String,
        required: true
    },
    dateadd: {
        type: Date,
        default: Date.now
      },
});

const departement = mongoose.model('departement', departementshema);

module.exports = departement;
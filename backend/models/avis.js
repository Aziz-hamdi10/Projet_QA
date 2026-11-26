const mongoose = require('mongoose');

const avisShema = new mongoose.Schema({
    content: {
        type: String,
        required: true,
        unique: true
    },
    rating: {
        type: Number,
        required: true,
        unique: true
    },
    idorder: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'order'
    },
    date: {
        type: Date,
        default: Date.now
    },
 
});

const avis = mongoose.model('avis', avisShema);

module.exports = avis;
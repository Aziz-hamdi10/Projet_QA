const mongoose = require('mongoose');

const colorSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        unique: true
    },
    hexCode: {
        type: String,
        required: true
    },
    dateadd: {
        type: Date,
        default: Date.now
      },
});

const Color = mongoose.model('color', colorSchema);

module.exports = Color;
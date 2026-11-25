const mongoose = require('mongoose');

const sizeSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        unique: true
    },
    dateadd: {
        type: Date,
        default: Date.now
      },
});

const Size = mongoose.model('Size', sizeSchema);

module.exports = Size;

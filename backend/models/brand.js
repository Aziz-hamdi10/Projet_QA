const mongoose = require('mongoose');

const brandshema = new mongoose.Schema({
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

const brand = mongoose.model('brand', brandshema);
brandshema.pre('remove', async function(next) {
    try {
      const deletedBrandId = this._id;
  
      // Your logic to update associated products with a default brand ID
  
      next(); // Continue with the brand deletion
    } catch (error) {
      next(error); // Pass any error to the next middleware or error handler
    }
  });
module.exports = brand;
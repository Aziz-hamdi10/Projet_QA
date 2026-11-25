const mongoose = require('mongoose');

const subscriptionSchema = new mongoose.Schema({
    subscriber: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'user', 
        required: true
    },
    subscribedTo: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'user', 
        required: true
    },
});

const Subscription = mongoose.model('Subscription', subscriptionSchema);

module.exports = Subscription;

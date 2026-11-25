const express = require('express');
const router = express.Router();
const Subscription = require('../models/Subscription');
const Notification = require('../models/notification');

router.post('/addSubscription', async (req, res) => {
    const { subscriberId, subscribedToId } = req.body;

    try {
        const subscription = await Subscription.create({ subscriber: subscriberId, subscribedTo: subscribedToId });
        res.status(201).json(subscription);
        const notification = new Notification({
            senderid: subscriberId,
            message: 'Started following you ',
            link:subscriberId,
            title: 'follow',
            ownerId: subscribedToId,
        });
        await notification.save();
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.delete('/removeSubscription', async (req, res) => {
    const { subscriberId, subscribedToId } = req.body;

    try {
        const deletedSubscription = await Subscription.findOneAndDelete({ subscriber: subscriberId, subscribedTo: subscribedToId });
        res.status(200).json(deletedSubscription);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});
router.get('/subscribers/:userId', async (req, res) => {
    const { userId } = req.params;

    try {
        const numberOfSubscribers = await Subscription.countDocuments({ subscribedTo: userId });
        res.json({ numberOfSubscribers });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});
router.get('/getsubscribers/:userId', async (req, res) => {
    const { userId } = req.params;
    const page = parseInt(req.query.page) || 1; 
    const limit = parseInt(req.query.limit) || 10;

    try {
        const totalFollows = await Subscription.countDocuments({ subscribedTo: userId });
        const totalPages = Math.ceil(totalFollows / limit);

        const follows = await Subscription.find({ subscribedTo: userId })
            .populate('subscriber')
            .skip((page - 1) * limit)
            .limit(limit);

            res.json(follows.map(subscription => subscription.subscriber));
        
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});
router.post('/check-following', async (req, res) => {
    const { currentUser, targetUser } = req.body;

    try {
        const subscription = await Subscription.findOne({
            subscriber: currentUser,
            subscribedTo: targetUser
        });

        if (subscription) {
            res.json({ isFollowing: true });
        } else {
            res.json({ isFollowing: false });
        }
    } catch (error) {
        console.error("Error checking subscription:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

router.get('/follows/:userId', async (req, res) => {
    const { userId } = req.params;

    try {
        const numberOfFollows = await Subscription.countDocuments({ subscriber: userId });
        res.json({ numberOfFollows });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});
router.get('/getfollowing/:userId', async (req, res) => {
    const { userId } = req.params;
    const page = parseInt(req.query.page) || 1; 
    const limit = parseInt(req.query.limit) || 10;

    try {
        const totalFollows = await Subscription.countDocuments({ subscriber: userId });
        const totalPages = Math.ceil(totalFollows / limit);

        const follows = await Subscription.find({ subscriber: userId })
            .populate('subscribedTo')
            .skip((page - 1) * limit)
            .limit(limit);

            res.json(follows.map(subscription => subscription.subscribedTo));

    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});


module.exports = router;

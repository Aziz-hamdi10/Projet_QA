const express = require('express');
const router = express.Router();
const Notification = require('../models/notification');
const Product = require('../models/Product');

router.get('/getnotification/:userid', async (req, res) => {
  const userid = req.params.userid;
  try {
   


    const notifications = await Notification.find({ ownerId: userid })
  .populate({
    path: 'senderid',
  })
  .populate({
    path: 'ownerId',
  });

     
    

    if (notifications.length === 0) {
      return res.status(404).json({ error: 'Notifications not found for the user' });
    }

    res.status(200).json(notifications);
  } catch (error) {
    console.error('Error fetching notifications:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

  
  

module.exports = router;

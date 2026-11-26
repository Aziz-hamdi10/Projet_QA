const express = require('express');
const router = express.Router();
const Commentaire = require('../models/commentaire');
const Notification = require('../models/notification'); 
const product = require('../models/Product');
const veriftoken = require('./veriftoken');

router.post('/addcommentaire', async (req, res) => {
  try {
      const data = req.body;
      const newcommentaire = new Commentaire(data);

      const savedcmt = await newcommentaire.save();

      const populatedCmt = await Commentaire.findById(savedcmt._id).populate('userid');

      const prd = await product.findById(newcommentaire.productid);

      const notification = new Notification({
          message: `Has been placed a comment for your Product "${prd.name}"`,
          title: 'Comment',
          link: newcommentaire.productid,
          ownerId: prd.iduser,
          senderid: newcommentaire.userid
      });

      await notification.save();

      res.status(201).json(populatedCmt);
  } catch (err) {
      console.error(err);
      res.status(500).send({ error: 'Internal Server Error' });
  }
});
router.put('/updatecommentaire', async (req, res) => {
  try {
      const { commentId, newContent } = req.body;

      const updatedComment = await Commentaire.findByIdAndUpdate(
          commentId,
          { message: newContent },
          { new: true }
      ).populate('userid');

      if (!updatedComment) {
          return res.status(404).send({ error: 'Comment not found' });
      }

      const prd = await product.findById(updatedComment.productid);

      if (!prd) {
          return res.status(404).send({ error: 'Product not found' });
      }

      const notification = new Notification({
          message: `A comment on your product "${prd.name}" has been updated.`,
          title: 'Comment Updated',
          link: updatedComment.productid,
          ownerId: prd.iduser,
          senderid: updatedComment.userid
      });

      await notification.save();

      res.status(200).json(updatedComment);
  } catch (err) {
      console.error(err);
      res.status(500).send({ error: 'Internal Server Error' });
  }
});

router.get('/getcommentaires/:prdid',veriftoken, async (req, res) => {
    const prdid = req.params.prdid;
  
    try {
      const Commentaires = await Commentaire.find({ productid: prdid })
      .populate({
     
          path: 'userid',
          
        
      });
      
      if (!Commentaires || Commentaires.length === 0) {
        return res.status(404).json({ error: 'Commentaires not found' });
      }
  
      res.status(200).json(Commentaires);
    } catch (error) {
      console.error('Error fetching notification:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  
router.delete('/deletecommentaire/:commentaireId', async (req, res) => {
    const commentaireId = req.params.commentaireId;
    console.log(commentaireId);
    try {
      const result = await Commentaire.findByIdAndDelete(commentaireId);
  
      if (!result) {
        return res.status(404).json({ error: 'Commentaire not found' });
      }
  
      res.status(200).json({ message: 'Commentaire deleted successfully' });
    } catch (error) {
      console.error('Error deleting commentaire:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });

module.exports = router;

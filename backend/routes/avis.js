const express = require('express');
const router = express.Router();
const Avis = require('../models/avis');
const Product = require('../models/Product');
const order = require('../models/order');

router.get('/getavis/:idorder', async (req, res) => {
    const idorder = req.params.idorder;
    try {
      const avis = await Avis.findOne({ idorder: idorder });
      if (!avis) {

        return res.status(200).json(null); 
      }

      res.status(200).json(avis);
    } catch (error) {
      console.error('Error fetching avis:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });

  router.get('/getavisiduser/:iduser', async (req, res) => {

    const iduser = req.params.iduser;
    try {
        const products = await Product.find({iduser:iduser});
        const productIds = products.map(product => product._id);
        const orders = await order.find({ product: { $in: productIds } },{
            state:"Finished"||"Canceled"
        }); 
        if(orders!=null)
        {const orderids = orders.map(order => order._id);

             const avis = await Avis.find({ idorder:  { $in: orderids } });
      if (!avis) {

        return res.status(200).json(null); 
      }
      res.status(200).json(avis);}
      else{
        return res.status(200).json(null); 

      }
    } catch (error) {
      console.error('Error fetching avis:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });

   router.get('/getavisiduser/:iduser', async (req, res) => {
    const iduser = req.params.iduser;
    try {
        const products = await Product.find({iduser:iduser});
        const productIds = products.map(product => product._id);
        const orders = await order.find({ product: { $in: productIds } },{
            state:"Finished"||"Canceled"
        }); 
        if(orders!=null)
        {const orderids = orders.map(order => order._id);

             const avis = await Avis.find({ idorder:  { $in: orderids } });
      if (!avis) {

        return res.status(200).json(null); 
      }
      res.status(200).json(avis);}
      else{
        return res.status(200).json(null); 

      }
    } catch (error) {
      console.error('Error fetching avis:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  router.post('/addavis', async (req, res) => {
    const { idorder,content, rating } = req.body; 
  
    try {
      const newAvis = new Avis({
        idorder: idorder,
        content: content,
        rating: rating,
  
      });
  
      const savedAvis = await newAvis.save();
  
      res.status(201).json(savedAvis); // Return the newly created avis
    } catch (error) {
      console.error('Error adding avis:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  
  
  

module.exports = router;

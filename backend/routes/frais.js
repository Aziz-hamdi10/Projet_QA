const express = require('express');
const router = express.Router();
const frais = require('../models/frais');
router.post('/addfrais', async (req, res) => {
    try {
      const { value } = req.body;
  
      const newFrais = new frais({
        value: value
      });
  
      await newFrais.save();
  
      res.status(201).json({ message: 'Frais added successfully', frais: newFrais });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'An error occurred while adding frais' });
    }
  });
  
router.get('/getLatestFrais', async (req, res) => {
    try {
      const latestFrais = await frais.findOne().sort({ dateadd: -1 }).exec();
  
      if (!latestFrais) {
        return res.status(404).json({ message: 'No frais found' });
      }
  
      res.status(200).json({ latestFrais });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'An error occurred while fetching frais' });
    }
  });
  module.exports=router;
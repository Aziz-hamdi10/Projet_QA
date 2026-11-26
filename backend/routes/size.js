const express = require('express');
const router = express.Router();
const Size = require('../models/size');

router.post('/addsize', async (req, res) => {
    try {
        const { name } = req.body;

        // Validate the size name
        if (typeof name !== 'string' || !name.trim()) {
            return res.status(400).json({
                error: 'Size name is required'
            });
        }

        const newSize = new Size({
            name: name.trim()
        });

        const savedSize = await newSize.save();

        return res.status(201).json(savedSize);

    } catch (error) {

        // Handle duplicate key error
        if (error.code === 11000) {
            return res.status(409).json({
                error: 'Size already exists'
            });
        }

        // Handle validation errors
        if (error.name === 'ValidationError') {
            return res.status(400).json({
                error: error.message
            });
        }

        console.error(error);

        return res.status(500).json({
            error: 'Internal Server Error'
        });
    }
});
router.get('/getsizes', (req, res) => {
    Size.find()
        .then(sizes => {
            res.json(sizes);
        })
        .catch(err => {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });
});
router.get('/getsize/:sizeId', (req, res) => {
    const sizeId = req.params.sizeId;

    Size.findById(sizeId)
        .then(size => {
            if (size) {
                res.json(size);
            } else {
                res.status(404).json({ message: 'Size not found' });
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});
router.put('/updatesize/:sizeId', (req, res) => {
    const sizeId = req.params.sizeId;
    const { name } = req.body;

    Size.findByIdAndUpdate(sizeId, { name }, { new: true })
        .then(updatedSize => {
            if (updatedSize) {
                res.json(updatedSize);
            } else {
                res.status(404).json({ message: 'Size not found' });
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});
router.delete('/deletesize/:sizeId', (req, res) => {
    const sizeId = req.params.sizeId;

    Size.findByIdAndRemove(sizeId)
        .then(deletedSize => {
            if (deletedSize) {
                res.json({ message: 'Size deleted successfully' });
            } else {
                res.status(404).json({ message: 'Size not found' });
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});
router.get('/check-sizename/:sizename', async (req, res) => {
    const { sizename } = req.params;
    try {
        const existingUser = await Size.findOne({ name: { $regex: new RegExp(`^${sizename}$`, 'i') } });
        if (existingUser) {
        res.json({ available: false });

      } else {
        res.json({ available: true });

      }

    } catch (error) {
      console.error('Error checking sizename:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  
  module.exports = router;
  
module.exports = router;

const express = require('express');
const router = express.Router();
const Color = require('../models/color');
router.get('/getcolor/:colorId', (req, res) => {
    const colorId = req.params.colorId;

    Color.findById(colorId)
        .then(color => {
            if (color) {
                res.json(color);
            } else {
                res.status(404).json({ message: 'Color not found' });
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});
router.post('/addcolor', (req, res) => {
    const { name, hexCode } = req.body;

    const newColor = new Color({
        name,
        hexCode
    });

    newColor.save()
        .then(savedColor => {
            res.status(201).json(savedColor);
        })
        .catch(err => {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });
});
router.get('/getcolors', (req, res) => {
    Color.find()
        .then(colors => {
            res.json(colors);
        })
        .catch(err => {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });
});
router.put('/updatecolor/:colorId', (req, res) => {
    const colorId = req.params.colorId;
    const { name, code } = req.body;

    Color.findByIdAndUpdate(colorId, { name, code }, { new: true })
        .then(updatedColor => {
            if (updatedColor) {
                res.json(updatedColor);
            } else {
                res.status(404).json({ message: 'Color not found' });
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});
router.delete('/deletecolor/:colorId', (req, res) => {
    const colorId = req.params.colorId;

    Color.findByIdAndRemove(colorId)
        .then(deletedColor => {
            if (deletedColor) {
                res.json({ message: 'Color deleted successfully' });
            } else {
                res.status(404).json({ message: 'Color not found' });
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});
router.get('/check-colorname/:colorname', async (req, res) => {
    const { colorname } = req.params;
    try {
        const existingUser = await Color.findOne({ name: { $regex: new RegExp(`^${colorname}$`, 'i') } });
        if (existingUser) {
        res.json({ available: false });

      } else {
        res.json({ available: true });

      }

    } catch (error) {
      console.error('Error checking brandname:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
module.exports = router;
router.put('/modify-color/:id', async (req, res) => {
    const colorid = req.params.id;
    const { name,hexCode } = req.body;
  
   
    try {
      const newcolor = await Color.findByIdAndUpdate(
        colorid,
        { name, hexCode },
        { new: true } 
      );
  
      if (!newcolor) {
        return res.status(404).json({ error: 'Color not found' });
      }
  
      res.json(newcolor);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  
const express = require('express');
const router = express.Router();
const departement = require('../models/departement');
const multer = require('multer');

const mystorage = multer.diskStorage({
    destination: './uploads',
    filename: (req, file, redirect) => {
        let date = Date.now();
        let f1 = date + '.' + file.mimetype.split('/')[1];
        redirect(null, f1);
        filename = f1;
    }
});

const upload = multer({ storage: mystorage });
router.post('/adddepartement', upload.any('departementimage'), (req, res) => {
    const data = req.body;
    const newdepartement = new departement(data);
    newdepartement.image = filename;
    filename = '';

    newdepartement.save()
        .then(saveddepartement => {
            res.status(201).json(saveddepartement);
        })
        .catch(err => {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });
});
router.get('/getdepartements', (req, res) => {
    departement.find()
        .then(departements => {
            res.json(departements);
        })
        .catch(err => {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });
});
router.put('/modify-departement/:id', upload.single('departementimage'), async (req, res) => {
    const departementid = req.params.id;
    const { title } = req.body;
    let image;
  
    if (req.file) {
      image = filename; 
    }
  
    try {
      const newdepartement = await departement.findByIdAndUpdate(
        departementid,
        { title, image },
        { new: true } 
      );
  
      if (!newdepartement) {
        return res.status(404).json({ error: 'departement not found' });
      }
  
      res.json(newdepartement);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  router.delete('/delete-departement/:id', async (req, res) => {
    const categoryid = req.params.id;
  
    try {
      const deletedcat = await departement.findByIdAndDelete(categoryid);
  
      if (!deletedcat) {
        return res.status(404).json({ error: 'Category not found' });
      }
  
      res.json({ message: 'Category deleted successfully' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  router.get('/check-departmentname/:departmentname', async (req, res) => {
    const { departmentname } = req.params;
    try {
      const existingUser = await departement.findOne({ title: { $regex: new RegExp(`^${departmentname}$`, 'i') } });
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

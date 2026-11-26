const express = require('express');
const router = express.Router();
const brand = require('../models/brand');
const multer = require('multer');
const Product = require('../models/Product');

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
router.post('/addbrand', upload.any('brandname'), (req, res) => {
    const data = req.body;
    const newbrand = new brand(data);
    newbrand.image = filename;
    filename = '';

    newbrand.save()
        .then(savedSize => {
            res.status(201).json(savedSize);
        })
        .catch(err => {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });
});
router.get('/getbrands',upload.any('brandname'), (req, res) => {
    brand.find()
        .then(brands => {
            res.json(brands);
        })
        .catch(err => {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });
});
router.get('/getbrandscount', upload.any('brandname'), async (req, res) => {
  try {
      const brands = await brand.find();
      const brandCounts = await Promise.all(brands.map(async (brand) => {
          const count = await Product.countDocuments({ idbrand: brand.title });
          return { productCount: count };
      }));

      res.json(brandCounts);
  } catch (err) {
      console.error(err);
      res.status(500).send({ error: 'Internal Server Error' });
  }
});
router.put('/modify-brand/:id', upload.single('image'), async (req, res) => {
    const brandId = req.params.id;
    const { title } = req.body;
    let image;
  
    if (req.file) {
      image = filename; 
    }
  
    try {
      const newbrand = await brand.findByIdAndUpdate(
        brandId,
        { title, image },
        { new: true } 
      );
  
      if (!brand) {
        return res.status(404).json({ error: 'Brand not found' });
      }
  
      res.json(newbrand);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  router.delete('/delete-brand/:id', async (req, res) => {
    const brandId = req.params.id;
  
    try {
      const deletedBrand = await brand.findByIdAndDelete(brandId);
  
      if (!deletedBrand) {
        return res.status(404).json({ error: 'Brand not found' });
      }
  
      res.json({ message: 'Brand deleted successfully' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  router.get('/check-brandname/:brandname', async (req, res) => {
    const { brandname } = req.params;
    try {
      const existingUser = await brand.findOne({ title: { $regex: new RegExp(`^${brandname}$`, 'i') } });
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

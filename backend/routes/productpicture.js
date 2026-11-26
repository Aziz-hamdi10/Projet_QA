const express = require('express');
const router = express.Router();
const productpicture = require('../models/productpicture');
const Product = require('../models/Product');

module.exports = router;

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


router.get('/getimages/:productId', async (req, res) => {
    try {
        const productId = req.params.productId;

        // Find all images associated with the given product ID
        const images = await productpicture.find({productid: productId });

        res.json(images);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});


router.put('/updateImage/:productId', upload.single('image'), async (req, res) => {
    try {
        const productId = req.params.productId;
        const product = await Product.findById(productId);
        if (!product) {
            return res.status(404).json({ message: 'Product not found' });
        }
        const newImage = req.file.filename;
        const existingPicture = await productpicture.findOne({ productid: productId });
        if (!existingPicture) {
            return res.status(404).json({ message: 'Product picture not found' });
        }
        existingPicture.image = newImage;
        existingPicture.save()
            .then(updatedPicture => {
                res.status(200).json({ message: 'Image updated successfully', updatedPicture });
            })
            .catch(err => {
                console.log(err);
                res.status(500).json({ error: 'Internal Server Error' });
            });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

router.post('/addImage/:productId', upload.single('image'), async (req, res) => {
    try {
        const productId = req.params.productId;

        const product = await Product.findById(productId);

        if (!product) {
            return res.status(404).json({ message: 'Product not found' });
        }

        const image = req.file.filename;

        const productpicturenew = new productpicture({ productid: productId, image: image });

        productpicturenew.save()
            .then(savedpicture => {
                res.status(201).json({ message: 'Image added successfully', savedpicture });
            })
            .catch(err => {
                console.log(err);
                res.status(500).send({ error: 'Internal Server Error' });
            });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});
router.post('/addImages/:productId', upload.array('images'), async (req, res) => {
    try {
      const productId = req.params.productId;
  
      const product = await Product.findById(productId);
  
      if (!product) {
        return res.status(404).json({ message: 'Product not found' });
      }
  
      const images = req.files.map(file => ({ productId, image: file.filename }));
  
      // Save product pictures to the ProductPicture collection
      const savedPictures = await ProductPicture.insertMany(images);
  
      res.status(201).json({ message: 'Images added successfully', pictures: savedPictures });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Internal Server Error' });
    }
  });



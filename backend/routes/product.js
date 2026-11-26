const express = require('express');
const router = express.Router();
const product = require('../models/Product');
const productpicture = require('../models/productpicture');
const size = require('../models/size');
const color = require('../models/color');
const mongoose = require('mongoose');
const Wishlist = require('../models/wishlist');
const Comment = require('../models/commentaire');
const Notification = require('../models/notification');
const fs = require('fs');
module.exports = router;

const multer = require('multer');
const Productpicture = require('../models/productpicture');
const Commentaire = require('../models/commentaire');
const veriftoken = require('./veriftoken');

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
function deleteFile(filePath) {
    return new Promise((resolve, reject) => {
      fs.unlink(filePath, (err) => {
        if (err) {
          console.error('Error deleting file:', err);
          reject(err); 
          return;
        }
        console.log('File deleted successfully');
        resolve();
      });
    });
  }
router.post('/addproduct',  (req, res) => {
    data = req.body;
    const newproduct = new product(data);
    filename = '';

    newproduct.save()
        .then(newproduct => {
            res.send(newproduct); 
        })
        .catch(err => {
            console.log(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });
});
router.get('/getlikedproducts/:iduser', async (req, res) => {
    const iduser = req.params.iduser;
    try {
        const wishlistItems = await Wishlist.find({ iduser: iduser });

        if (!wishlistItems || wishlistItems.length === 0) {
            return res.status(404).send({ error: 'No liked products found for the given user ID' });
        }

        const productIds = wishlistItems.map(item => item.idproduct);

        const likedProducts = await product.find({ _id: { $in: productIds } }).populate({
            path: 'iduser',
           
          });

        const promises = likedProducts.map(async productItem => {
            const productPicture = await productpicture.findOne({ productid: productItem._id });
            const Color = await color.findById(productItem.idcolor);

            return {
                id: productItem._id,
                productName: productItem.name,
                sellingPrice: productItem.sellingPrice,
                originalPrice: productItem.originalPrice,
                productImage: productPicture,
                color: Color,
                user:productItem.iduser
            };
        });

        Promise.all(promises)
            .then(results => {
                res.send(results);
            })
            .catch(err => {
                console.log(err);
                res.status(500).send({ error: 'Internal Server Error' });
            });
    } catch (error) {
        console.error(error);
        res.status(500).send({ error: 'Internal Server Error' });
    }
});
router.post('/modify-product', upload.array('images'), async (req, res) => {
    try {
        const {productId, name, description, originalPrice, sellingPrice, numberLikes, category, department, size, state,idcolor,idcateg,idbrand,iduser,imagenames } = req.body;
    
        const existingProduct = await product.findById(productId);
        if (!existingProduct) {
            return res.status(404).send("Product not found");
        }
        if(req.body.imageNames)
            {
                const imageNames = req.body.imageNames.split(','); 
                const oldimage = await productpicture.find({productid: existingProduct._id });
        
                for (const image of oldimage) {
                    b=false;
                    for(const x of imageNames)
                    {
                        if(x==image.image){
                            b=true;
                        }
                    }
                    if(!b)
                    image.deleteOne();
                }
            }
        
        
        existingProduct.name = name ;
        existingProduct.description = description ;
        existingProduct.originalPrice = originalPrice ;
        existingProduct.sellingPrice = sellingPrice ;
        existingProduct.idcolor = idcolor ;
        existingProduct.idcateg = idcateg ;
        existingProduct.department = department;
        existingProduct.idbrand = idbrand ;
        existingProduct.size = size ;
        existingProduct.state = state ;
 
        if (req.files) {
            const images = req.files;

            const imageDocuments = [];
    
            for (const image of images) {
                const productImage = new productpicture({
    
                    productid: existingProduct._id, 
                    image: image.filename 
                });
                imageDocuments.push(productImage);
            }
            await productpicture.insertMany(imageDocuments);
    
        }

        await existingProduct.save();
        const productItem = await product.findById(productId).populate({
            path:'iduser'
        }).populate({
            path:'idcateg'
        }).populate(
            {        path:'idcolor'
            }
                ).populate(
                    {        path:'idbrand'
                    }
                        ).populate(
                            {        path:'size'
                            }
                                );
        if (!productItem) {
            return res.status(404).send({ error: 'Product not found' });
        }

        const productPicture = await productpicture.find({ productid: productId });
        const productColor = await color.findById(productItem.idcolor);

        const comments = await Comment.find({ productid: productId }).populate({
            path: 'userid',
           
          });

        const likes = await Wishlist.find({ idproduct: productId });

        const result = {
            product: productItem,
            productPictures: productPicture,
            color: productColor,
            comments: comments,
            likes: likes.length,
        };
        console.log(result);
        return res.status(200).json(result);
    } catch (err) {
        console.error(err);
        res.status(500).send({ error: 'Internal Server Error' });
    }
});

router.post('/addProductWithImages', upload.array('images'), async (req, res) => {
    try {
        const { name, description, originalPrice, sellingPrice, numberLikes, category, department, brand, size, state,idcolor,idcateg,idbrand,iduser } = req.body;
        const Product = new product({
            name,
            description,
            originalPrice,
            sellingPrice,
            numberLikes,
            category,
            department,
            brand,
            size,
            state,
            idcolor,
            idcateg,
            idbrand,
            iduser
        });

        const savedProduct = await Product.save();

        const images = req.files;

        const imageDocuments = [];

        for (const image of images) {
            const productImage = new productpicture({

                productid: savedProduct._id, 
                image: image.filename 
            });
            imageDocuments.push(productImage);
        }
        await productpicture.insertMany(imageDocuments);

        res.status(201).json({ message: 'Product added successfully', product: savedProduct });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});
router.get('/getproducts/:iduser', async (req, res) => {
    const userId = req.params.iduser;
    try {
        const products = await product.find({ iduser: { $ne: userId },
            state: "Available"    }).populate({
            path:'iduser'
        }
    ).populate(
{        path:'idcateg'
}
    ).populate(
        {        path:'size'
        }
            ).populate(
                {        path:'idbrand'
                }
                    ).populate(
                        {        path:'idcolor'
                        }
                            );
        

        if (!products || products.length === 0) {
            return res.status(404).send({ error: 'No products found for users other than the given user' });
        }

        const promises = products.map(product => {
            const productPromise = productpicture.find({ productid: product._id });
            const colorPromise = color.findById(product.idcolor);
            const likeCountPromise = Wishlist.countDocuments({ idproduct: product._id });
            
            const commentsPromise = Comment.find({ productid: product._id }).populate({
                path: 'userid',
               
              });

            return Promise.all([productPromise, colorPromise, likeCountPromise, commentsPromise])
                .then(([productPictures, color, likes, comments]) => ({
                    product,
                    productPictures,
                    color,
                    likes,
                    comments
                }));
        });

        Promise.all(promises)
            .then(results => {
                res.send(results);
            })
            .catch(err => {
                console.error(err);
                res.status(500).send({ error: 'Internal Server Error' });
            });
    } catch (err) {
        console.error(err);
        res.status(500).send({ error: 'Internal Server Error' });
    }
});
router.get('/getproductsgeneral/',veriftoken, async (req, res) => {
    const userId = req.userId;

    try {
        const products = await product.find({ iduser: { $ne: userId } ,            state: "Available" 
    }).populate({
            path: 'iduser',
           
          });

        if (!products || products.length === 0) {
            return res.status(404).send({ error: 'No products found for users other than the given user' });
        }

        const promises = products.map(async productItem => {
            const productPicture = await productpicture.findOne({ productid: productItem._id });
            const Color = await color.findById(productItem.idcolor);

            return {
                id: productItem._id,
                state:productItem.state,
                productName: productItem.name,
                sellingPrice:productItem.sellingPrice,
                originalPrice:productItem.originalPrice,
                user:productItem.iduser,

                productImage: productPicture ,
                color: Color ,
            };
        });

        Promise.all(promises)
            .then(results => {
                res.send(results);
            })
            .catch(err => {
                console.error(err);
                res.status(500).send({ error: 'Internal Server Error' });
            });
    } catch (err) {
        console.error(err);
        res.status(500).send({ error: 'Internal Server Error' });
    }
});

router.get('/getproductsbyid/:iduser',async (req, res) => {
    const userId = req.params.iduser;

    try {
        const products = await product.find({ iduser :userId  }).populate({
            path: 'iduser',
           
          });

        if (!products || products.length === 0) {
            return res.status(404).send({ error: 'No products found for users other than the given user' });
        }

        const promises = products.map(async productItem => {
            const productPicture = await productpicture.findOne({ productid: productItem._id });
            const Color = await color.findById(productItem.idcolor);

            return {
                id: productItem._id,

                productName: productItem.name,
                sellingPrice:productItem.sellingPrice,
                originalPrice:productItem.originalPrice,
                user:productItem.iduser,

                productImage: productPicture ,
                color: Color ,
            };
        });

        Promise.all(promises)
            .then(results => {
                res.send(results);
            })
            .catch(err => {
                console.error(err);
                res.status(500).send({ error: 'Internal Server Error' });
            });
    } catch (err) {
        console.error(err);
        res.status(500).send({ error: 'Internal Server Error' });
    }
});


router.get('/getproductbyidprd/:id', async (req, res) => {
    const productId = req.params.id;

    try {
        const productItem = await product.findById(productId).populate({
            path:'iduser'
        }
    ).populate(
{        path:'idcateg'
}
    ).populate(
{        path:'idcolor'
}    ).populate(
    {        path:'size'
    }
        ).populate(
            {        path:'idbrand'
            }
                );
        if (!productItem) {
            return res.status(404).send({ error: 'Product not found' });
        }

        const productPicture = await productpicture.find({ productid: productId });
        const productColor = await color.findById(productItem.idcolor);

        const comments = await Comment.find({ productid: productId }).populate({
            path: 'userid',
           
          });

        const likes = await Wishlist.find({ idproduct: productId });

        const result = {
            product: productItem,
            productPictures: productPicture,
            color: productColor,
            comments: comments,
            likes: likes.length,
        };

        return res.status(200).json(result);
    } catch (err) {
        console.error(err);
        res.status(500).send({ error: 'Internal Server Error' });
    }
});


router.delete('/deleteproduct/:id', async (req, res) => {
    const productid = req.params.id;

    try {
        const deletedProduct = await product.findOneAndDelete({ _id: productid });
        if (!deletedProduct) {
            return res.status(404).send({ error: 'Product not found' });
        }

        await Productpicture.deleteMany({ productid: productid });
        await Notification.deleteMany({ link: productid });
        await Commentaire.deleteMany({ productid: productid });

        return res.status(200).json(deletedProduct);
    } catch (err) {
        console.error(err);
        return res.status(500).json({ error: 'Internal Server Error' });
    }
});


router.put('/updateProduct/:id', (req, res) => {
    const productId = req.params.id;
    const data = req.body;

    product.findByIdAndUpdate({ _id: productId }, data, { new: true })
        .then(updatedProduct => {
            if (!updatedProduct) {
                return res.status(404).send({ error: 'Product not found' });
            }

            res.send(updatedProduct);
        })
        .catch(err => {
            console.log(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });
});


const express = require('express');
const router = express.Router();
const wishlist = require('../models/wishlist');
const Notification = require('../models/notification');
const Product = require('../models/Product');

router.get('/getwishlistbyiduser/:iduser', async (req, res) => {
    const userId = req.params.iduser;

    try {
        const wishlists = await wishlist.find({ iduser: userId });
        
        if (!wishlists || wishlists.length === 0) {
            return res.status(404).send({ error: 'No products found for the given user ID' });
        }

        res.status(200).send(wishlists);
    } catch (error) {
        console.error(error);
        res.status(500).send({ error: 'Internal Server Error' });
    }
});
router.post('/addtowishlist', async (req, res) => {
    const { iduser, idproduct } = req.body;
   
    try {
        const wishlists = await wishlist.find({ iduser: iduser, idproduct: idproduct });
        if (!wishlists || wishlists.length === 0) {
            const wishlistItem = new wishlist({
                iduser: iduser,
                idproduct: idproduct
            });
    
            await wishlistItem.save();
            res.status(201).send({ message: 'Product added to wishlist successfully.' });     
            
            const product = await Product.findById(idproduct);
            if (!product) {
                return res.status(404).send({ error: 'Product not found.' });
            }
            
            const notification = new Notification({
                senderid: iduser,
                message: 'Liked your product " '+product.name+' "',
                link:product._id,
                title: 'like',
                ownerId: product.iduser,
            });
            await notification.save();
        } else {
            try {
                await wishlist.deleteOne({ iduser: iduser, idproduct: idproduct });
                res.status(200).send({ message: 'Product removed from wishlist successfully.' });
            } catch (error) {
                console.error(error);
                res.status(500).send({ error: 'Internal Server Error' });
            }
        }
      
    } catch (error) {
        console.error(error);
        res.status(500).send({ error: 'Internal Server Error' });
    }
});


router.delete('/removefromwishlist', async (req, res) => {
    const { userId, productId } = req.body;

    try {
        await Wishlist.deleteOne({ iduser: userId, idproduct: productId });
        res.status(200).send({ message: 'Product removed from wishlist successfully.' });
    } catch (error) {
        console.error(error);
        res.status(500).send({ error: 'Internal Server Error' });
    }
});
router.get('/numberlikes/:idproduct', async (req, res) => {
    const { idproduct } = req.params;

    try {
        const numberOflikes= await wishlist.countDocuments({ idproduct: idproduct });
        res.json({ numberOflikes });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});
module.exports = router;

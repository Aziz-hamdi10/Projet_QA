const express = require('express');
const router = express.Router();
const order = require('../models/order');
const product = require('../models/Product');
const Productpicture = require('../models/productpicture');

const Notification = require('../models/notification'); 
const veriftoken = require('./veriftoken');
const user = require('../models/user');
const frais = require('../models/frais');
router.post('/addorder', async (req, res) => {
  let reservedProduct = null;
  let savedOrder = null;

  try {

    // 1. Vérifier le produit demandé
    const productId = req.body.product;

    if (!productId || !/^[a-fA-F0-9]{24}$/.test(productId)) {
      return res.status(400).json({
        error: 'Invalid product ID'
      });
    }

    // 2. Récupérer les frais
    const latestFrais = await frais
      .findOne()
      .sort({ dateadd: -1 })
      .exec();

    if (!latestFrais) {
      return res.status(400).json({
        error: 'Delivery fees not configured'
      });
    }

    // 3. Préparer et valider la commande
    const newOrder = new order(req.body);
    newOrder.frais = latestFrais._id;

    await newOrder.validate();

    // 4. Réserver le produit de manière atomique
    reservedProduct = await product.findOneAndUpdate(
      {
        _id: productId,
        state: 'Available'
      },
      {
        $set: { state: 'booked' }
      },
      {
        new: true
      }
    );

    // 5. Vérifier le résultat de la réservation
    if (!reservedProduct) {

      const existingProduct = await product.findById(productId);

      if (!existingProduct) {
        return res.status(404).json({
          error: 'Product not found'
        });
      }

      return res.status(409).json({
        error: 'Product is no longer available'
      });
    }

    // 6. Enregistrer la commande
    savedOrder = await newOrder.save();

    // 7. Envoyer les notifications
    try {

      const prd = reservedProduct;

      const idmoderators = await user.find({
        role: 'Moderator'
      });

      for (const moderator of idmoderators) {

        const notification = new Notification({
          iduser: prd.iduser,
          message:
            'Has been placed an Order for Product "' +
            prd.name + '"',
          title: 'order',
          link: savedOrder._id,
          ownerId: moderator._id,
          senderid: savedOrder.idbuyer
        });

        await notification.save();
      }

      const notification = new Notification({
        iduser: prd.iduser,
        message:
          'Has been placed an Order for your Product "' +
          prd.name + '"',
        title: 'command',
        link: savedOrder._id,
        ownerId: prd.iduser,
        senderid: savedOrder.idbuyer
      });

      await notification.save();

    } catch (notificationError) {

      // Une erreur de notification ne doit pas
      // annuler une commande déjà enregistrée.

      console.error(
        'Notification error:',
        notificationError
      );
    }

    // 8. Retourner la commande créée
    return res.status(201).json(savedOrder);

  } catch (error) {

    // 9. Libérer le produit si la commande
    // n'a pas été enregistrée.

    if (reservedProduct && !savedOrder) {

      try {

        await product.findOneAndUpdate(
          {
            _id: reservedProduct._id,
            state: 'booked'
          },
          {
            $set: { state: 'Available' }
          }
        );

      } catch (rollbackError) {
        console.error('Rollback error:', rollbackError);
      }
    }

    console.error(error);

    if (error.name === 'ValidationError') {
      return res.status(400).json({
        error: error.message
      });
    }

    return res.status(500).json({
      error: 'Internal Server Error'
    });
  }
});
router.get('/getAllorders', async (req, res) => {
  try {
    const allorders = await order.find().populate({
      path: 'product',
      populate: [
        { path: 'idcolor' },
        { path: 'idbrand' },
        { path: 'size' },
        { path: 'idcateg' },
        { path: 'iduser' }
      ]
  }).populate({
    path: 'frais',
   
 
  });

    const promises = allorders.map(order => {
      return Productpicture.find({ productid: order.product._id })
        .then(productPictures => ({ order, productPictures }))
    });

    Promise.all(promises)
    .then(results => {
        res.send(results);
    })
    .catch(err => {
        res.status(500).send({ error: 'Internal Server Error' });
    });
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});

router.get('/getAllorders', async (req, res) => {

  try {
    const allorders = await order.find().populate({
      path: 'product',
      populate: [
          { path: 'idcolor' },
          { path: 'iduser' }
      ]
  }).populate({
    path: 'frais',
   
 
  });;

    const promises = allorders.map(order => {
      return Productpicture.find({ productid: order.product._id })
        .then(productPictures => ({ order, productPictures }))
    });

    Promise.all(promises)
    .then(results => {
        res.send(results);
    })
    .catch(err => {
        res.status(500).send({ error: 'Internal Server Error' });
    });
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});
router.get('/getAllOrdersbyidbystate',veriftoken, async (req, res) => {
  const {  etat } = req.query;
  const userId= req.userId;
  try {
    if(etat!="all")
      {
        if(etat=="Confirmed")
          {
            
            const allOrders = await order.find({
              etat: etat

            }).populate({
              path: 'product',
              populate: [
                { path: 'idcolor' },
                { path: 'idbrand' },
                { path: 'size' },
                { path: 'idcateg' },
                { path: 'iduser' }
              ]
            }).populate(
              {
                path: 'frais',
        
              }
            );
            const promises = allOrders.map(order => {
              return Productpicture.find({ productid: order.product._id })
                .then(productPictures => ({ order, productPictures }))
            });
        
            Promise.all(promises)
              .then(results => {
                res.send(results);
              })
              .catch(err => {
                console.error(err);
                res.status(500).send({ error: 'Internal Server Error' });
              });
          }
          
        else
        {
        const allOrders = await order.find({
          idliv: userId,
          etat: etat
        }).populate({
          path: 'product',
          populate: [
            { path: 'idcolor' },
            { path: 'idbrand' },
            { path: 'size' },
            { path: 'idcateg' },
            { path: 'iduser' }
          ]
        }).populate(
          {
            path: 'frais',
    
          }
        );
        const promises = allOrders.map(order => {
          return Productpicture.find({ productid: order.product._id })
            .then(productPictures => ({ order, productPictures }))
        });
    
        Promise.all(promises)
          .then(results => {
            res.send(results);
          })
          .catch(err => {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
          });
      }
    }
      else{
            const allOrders = await order.find({
          idliv: userId  ,
        }).populate({
          path: 'product',
          populate: [
            { path: 'idcolor' },
            { path: 'idbrand' },
            { path: 'size' },
            { path: 'idcateg' },
            { path: 'iduser' }
          ]
        }).populate(
          {
            path: 'frais',
    
          }
        );
        const promises = allOrders.map(order => {
          return Productpicture.find({ productid: order.product._id })
            .then(productPictures => ({ order, productPictures }))
        });
    
        Promise.all(promises)
          .then(results => {
            res.send(results);
          })
          .catch(err => {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
          });
      }
        
      
        
    
     

   
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});
router.get('/getcmddulr/:id',veriftoken, async (req, res) => {
  const { id } = req.params;
  try {
    
    const allOrders = await order.find({
      idliv: id

    }).populate({
      path: 'product',
      populate: [
        { path: 'idcolor' },
        { path: 'idbrand' },
        { path: 'size' },
        { path: 'idcateg' },
        { path: 'iduser' }
      ]
    }).populate(
      {
        path: 'frais',

      }
    );
    const promises = allOrders.map(order => {
      return Productpicture.find({ productid: order.product._id })
        .then(productPictures => ({ order, productPictures }))
    });

    Promise.all(promises)
      .then(results => {
        res.send(results);
      })
      .catch(err => {
        console.error(err);
        res.status(500).send({ error: 'Internal Server Error' });
      });
      
        
      
        
    
     

   
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});

router.get('/getallorderssbyiduser/:id', async (req, res) => {
  const { id } = req.params;
  try {
      const allorders = await order.find({ idbuyer: id }).populate({
        path: 'product',
        populate: [
            { path: 'idcolor' },
            { path: 'idbrand' },
            { path: 'size' },
            { path: 'idcateg' },
            { path: 'iduser' }
        ]
    }).populate(
      {
        path: 'frais',

      }
    );
  
      const promises = allorders.map(order => {
        return Productpicture.find({ productid: order.product._id })
          .then(productPictures => ({ order, productPictures }))
      });
  
      Promise.all(promises)
      .then(results => {
          res.send(results);
      })
      .catch(err => {
          res.status(500).send({ error: 'Internal Server Error' });
      });
    } catch (error) {
      console.error(error);
      res.status(500).send({ error: 'Internal Server Error' });
    }
  });
  
  
  router.get('/getorderssales/:id', async (req, res) => {
    const { id } = req.params;
  
    try {
      const products = await product.find({ iduser: id });
      const productIds = products.map(product => product._id);
   
      const allorders = await order.find({ product: { $in: productIds } }).populate({
        path: 'product',
        populate: [
            { path: 'idcolor' },
            { path: 'idbrand' },
            { path: 'size' },
            { path: 'idcateg' },
            { path: 'iduser' }
        ]
    }).populate({
      path: 'frais',
     
   
    });
  
      const promises = allorders.map(order => {
        return Productpicture.find({ productid: order.product._id })
          .then(productPictures => ({ order, productPictures }))
      });
  
      Promise.all(promises)
      .then(results => {
          res.send(results);
      })
      .catch(err => {
          res.status(500).send({ error: 'Internal Server Error' });
      });
    } catch (error) {
      console.error(error);
      res.status(500).send({ error: 'Internal Server Error' });
    }
  });

router.get('/getorderById/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const order1 = await order.findById(id).populate({
      path: 'product',
      populate: [
        { path: 'idcolor' },
        { path: 'iduser' },
        { path: 'idcateg' },
        { path: 'idbrand' },
        { path: 'size' },

      ]
    }).populate({
      path: 'frais',
     
   
    });

    if (!order1) {
      return res.status(404).send({ error: 'Order not found' });
    }

    const productPictures1 = await Productpicture.find({ productid: order1.product._id });

    res.send({ order:order1, productPictures:productPictures1 });
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});

router.put('/update-state/:orderId',veriftoken, async (req, res) => {
  const { orderId } = req.params;
  const { newState } = req.body;
  const iduser=req.userId;
  try {
    if (newState == "Canceled") {
      const foundOrder = await order.findByIdAndUpdate(orderId, { etat: newState ,datecancel:Date.now()});
      if (!foundOrder) {
        return res.status(404).json({ message: "La commande n'a pas été trouvée." });
      }
      const prd=await product.findByIdAndUpdate(foundOrder.product, { $set: { state: 'Available' } });

      return res.status(200).json({ message: "L'état de la commande a été mis à jour avec succès.", order: foundOrder });
   
    }
    else{
      if (newState == "Confirmed") {
     
      const foundOrder = await order.findByIdAndUpdate(orderId, { etat: newState,dateconfirm: Date.now() });
      const livreurs=await user.find({
        "role":"delievry"
      });
      for(mod in livreurs){
        const notification = new Notification({
          message: 'has Confirmed an Order !',
          title:'command',
          link:foundOrder._id,
          ownerId:livreurs[mod]._id,
          senderid:iduser
        });
        notification.save();
      }
      if (!foundOrder) {
        return res.status(404).json({ message: "La commande n'a pas été trouvée." });
      }
  
      return res.status(200).json({ message: "L'état de la commande a été mis à jour avec succès.", order: foundOrder });
   
    }
  else{
    if(newState=="On delievry"){
      const foundOrder = await order.findByIdAndUpdate(orderId, { etat: newState,datedelievry: Date.now() });
      if (!foundOrder) {
        return res.status(404).json({ message: "La commande n'a pas été trouvée." });
      }
  
      return res.status(200).json({ message: "L'état de la commande a été mis à jour avec succès.", order: foundOrder });
   
    }else{
      if(newState=="Finished"){
        const foundOrder = await order.findByIdAndUpdate(orderId, { etat: newState,datefinished: Date.now() });
        if (!foundOrder) {
          return res.status(404).json({ message: "La commande n'a pas été trouvée." });
        }
        const prd=await product.findByIdAndUpdate(foundOrder.product, { $set: { state: 'Saled' } });

        return res.status(200).json({ message: "L'état de la commande a été mis à jour avec succès.", order: foundOrder });
     
      }else{
        const foundOrder = await order.findByIdAndUpdate(orderId, { etat: newState,datetaked: Date.now() ,idliv:iduser});
        if (!foundOrder) {
          return res.status(404).json({ message: "La commande n'a pas été trouvée." });
        }
    
        return res.status(200).json({ message: "L'état de la commande a été mis à jour avec succès.", order: foundOrder });
     
      }
    }

  }
  }

 } catch (error) {
    console.error("Une erreur s'est produite lors de la mise à jour de l'état de la commande :", error);
    return res.status(500).json({ message: "Une erreur s'est produite lors de la mise à jour de l'état de la commande." });
  }
});
router.delete('/deleteorder/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const deletedorder = await order.findByIdAndDelete(id);
    if (!deletedorder) {
      return res.status(404).send({ error: 'order not found' });
    }
    res.json(deletedorder);
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});
router.get('/total-selling-price', async (req, res) => {
  try {
    const finishedOrders = await order.find({ etat: { $regex: 'finished', $options: 'i' } });

      let totalSellingPrice = 0;

      for (const order of finishedOrders) {
          const p = await product.findById(order.product);
          if (p) {
              totalSellingPrice += p.sellingPrice;
          }
      }

      res.json({ totalSellingPrice });
  } catch (error) {
      console.error('Error fetching total selling price:', error);
      res.status(500).json({ error: 'Internal Server Error' });
  }
});
router.get('/total-selling-profit', async (req, res) => {
  try {
    const finishedOrders = await order.find({ etat: { $regex: 'finished', $options: 'i' } }).populate('frais');

    let totalprofil = 0;
    
    for (const order of finishedOrders) {
        const p = await product.findById(order.product);
        if (p) {
            totalprofil +=  order.frais.value;
        }
    }
    

      res.json({ totalprofil });
  } catch (error) {
      console.error('Error fetching total selling price:', error);
      res.status(500).json({ error: 'Internal Server Error' });
  }
});
router.get('/count-orders', async (req, res) => {
  try {
    const orderCount = await order.countDocuments();
    res.json({ orderCount });
  } catch (error) {
    console.error('Error counting orders:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
router.post('/count-order-by-etat', async (req, res) => {
  try {
    const { etat } = req.body;
     ordercount=0;
    if(etat!="all"){
      ordercount = await order.countDocuments({ etat: etat });

    }
    else{
      ordercount = await order.countDocuments();

    }

    res.json({ ordercount });
  } catch (error) {
    console.error('Error counting Order:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
router.get('/getuser/:idcmd', async (req, res) => {
  const idcmd = req.params.idcmd;
  try {
    const orders = await order.findById(idcmd);

    if(orders){
        const User =await user.findOne(orders.idbuyer);

        res.json({ User });

    }
  } catch (error) {
    console.error('Error counting orders:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
router.get('/getBuyerLastOrderDetails/:buyerId', async (req, res) => {
  const buyerId = req.params.buyerId;

  try {
    const lastOrder = await order.findOne({ 'idbuyer': buyerId })
      .sort({ createdAt: -1 })
     ;

    if (!lastOrder) {
      return res.status(404).send({ error: 'No orders found for this buyer' });
    }
    const addressDetails = {
      codepostal: lastOrder.postal_code,
      adresse: lastOrder.state,
      street: lastOrder.street,
      city: lastOrder.city
    };
    return res.status(200).json(addressDetails);
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});
module.exports = router;

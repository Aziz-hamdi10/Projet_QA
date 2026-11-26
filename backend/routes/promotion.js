const express = require('express');
const router = express.Router();
const promotion = require('../models/promotion');
router.get('/getpromotion/:promotionid', (req, res) => {
    const promotionid = req.params.promotionid;

    promotion.findById(promotionid)
        .then(promotion => {
            if (promotion) {
                res.json(promotion);
            } else {
                res.status(404).json({ message: 'Color not found' });
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});
const generateRandomCode = () => {
    const min = 100000;
    const max = 999999;
    return Math.floor(Math.random() * (max - min + 1)) + min;
  };
router.post('/addpromotion', (req, res) => {
    const { title,datestart,dateend,iddepartement ,percentage} = req.body;
    const codepromo =   generateRandomCode();

    const newpromotion = new promotion({
        title,
        datestart,
        dateend,
        iddepartement,
        percentage,
        codepromo,

    });
  
    newpromotion.save()
        .then(savedpromotion => {
            res.status(201).json(savedpromotion);
        })
        .catch(err => {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });
});
router.get('/getpromotions/:promotionid', (req, res) => {
    const promotionid = req.params.promotionid;

   promotion.find({iddepartement:promotionid})
        .then(promotions => {

            res.json(promotions);
        })
        .catch(err => {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });
});
router.put('/updatepromotion/:promotionid', (req, res) => {
    const promotionid = req.params.promotionid;
    const { title, datestart,dateend } = req.body;

    promotion.findByIdAndUpdate(promotionid, { title, datestart,dateend }, { new: true })
        .then(updatedprm => {
            if (updatedprm) {
                res.json(updatedprm);
            } else {
                res.status(404).json({ message: 'Promotion not found' });
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});
router.delete('/deletepromotion/:promotionid', (req, res) => {
    const promotionid = req.params.promotionid;

    promotion.findByIdAndRemove(promotionid)
        .then(deletedPromotion=> {
            if (deletedPromotion) {
                res.json({ message: 'Promotion deleted successfully' });
            } else {
                res.status(404).json({ message: 'Promotion not found' });
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});
module.exports = router;
router.put('/modify-promotion/:id', async (req, res) => {
    const promotionid = req.params.id;
    const { title,datestart,dateend,percentage } = req.body;
  
   
    try {
        const updatedPromotion = await promotion.findByIdAndUpdate(
            promotionid,
            { title, datestart: datestart, dateend: dateend, percentage: percentage },
            { new: true } 
          );
  
      if (!updatedPromotion) {
        return res.status(404).json({ error: 'Color not found' });
      }
  
      res.json(updatedPromotion);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  router.get('/check-promotionname/:promotionname', async (req, res) => {
    const { promotionname } = req.params;
    try {
        const existingUser = await promotion.findOne({ title: { $regex: new RegExp(`^${promotionname}$`, 'i') } });
        if (existingUser) {
        res.json({ available: false });

      } else {
        res.json({ available: true });

      }

    } catch (error) {
      console.error('Error checking promotionname:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  router.get('/getpromotionsactive', (req, res) => {
    const currentDate = new Date();

    promotion.find({
        datestart: { $lte: currentDate },
        dateend: { $gte: currentDate }
    }).populate(
        {            path:'iddepartement'    }
    )
    .then(promotions => {
        res.json(promotions);
    })
    .catch(err => {
        console.error(err);
        res.status(500).send({ error: 'Internal Server Error' });
    });
});

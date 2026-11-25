const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());


app.use('/getimage', express.static('./uploads'));


app.use(express.json());

const productrouter=require('./routes/product');
app.use('/product',productrouter); 

const userrouter=require('./routes/user');
app.use('/user',userrouter); 
const productpicturerouter=require('./routes/productpicture');
app.use('/productpicture',productpicturerouter); 
const sizerouter=require('./routes/size');
app.use('/size',sizerouter); 
const colorrouter=require('./routes/color');
app.use('/color',colorrouter); 
const wishlistrouter=require('./routes/wishlist');
app.use('/wishlist',wishlistrouter); 

const orderrouter=require('./routes/order');
app.use('/order',orderrouter); 
const subscriptionrouter=require('./routes/Subscription');
app.use('/subscription',subscriptionrouter); 
const notificationrouter=require('./routes/notifcation');
app.use('/notification',notificationrouter); 
const commentairerouter=require('./routes/commentaire');
app.use('/commentaire',commentairerouter); 
const brandrouter=require('./routes/brand');
app.use('/brand',brandrouter); 
const departementrouter=require('./routes/departement');
app.use('/departement',departementrouter);
const promotionrouter=require('./routes/promotion');
app.use('/promotion',promotionrouter);
const avisrouter=require('./routes/avis');
app.use('/avis',avisrouter);
const paymententrouter=require('./routes/payment');
app.use('/payment',paymententrouter);
const fraisrouter=require('./routes/frais');
app.use('/frais',fraisrouter);

module.exports = app;

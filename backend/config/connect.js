const mongoose=require('mongoose');
mongoose.connect('mongodb://127.0.0.1:27017/BridgeWear').then(()=>{console.log('Connect !');})
.catch((err)=>{console.log(err);})
module.exports=mongoose;
// Dedicated disposable E2E fixture. Only login and read-only local routes are exposed.
const crypto=require('crypto');
process.env.JWT_SECRET=crypto.randomBytes(32).toString('hex');
const express=require('express');
const bcrypt=require('bcrypt');
const app=require('../../app');
const User=require('../../models/user');
const {connectDB,closeDB}=require('../../tests/setup/database');
const wrapper=express();
const reads=/^\/(user\/(getuserbytoken|getuser\/[^/]+)|product\/(getproducts\/[^/]+|getproductsgeneral\/?|getproductsbyid\/[^/]+|getproductbyidprd\/[^/]+)|size\/getsizes|color\/getcolors|frais\/getLatestFrais|getimage\/.*)$/;
wrapper.use((req,res,next)=>{
 if(req.method==='OPTIONS'||(req.method==='POST'&&req.path==='/user/login')||(req.method==='GET'&&reads.test(req.path))) return next();
 return res.status(403).json({error:'Route outside E2E login fixture'});
});
wrapper.use(app);
let server;
(async()=>{
 await connectDB();
 await User.create({email:'qa-client@example.invalid',username:'qa-client',firstname:'QA',secondname:'Client',role:'client',state:'active',password:await bcrypt.hash('Fixture-Only-Password!42',4)});
 server=wrapper.listen(3001,'127.0.0.1',()=>console.log('Isolated login fixture: http://127.0.0.1:3001'));
})().catch(async e=>{console.error(e);await closeDB();process.exitCode=1;});
process.on('SIGINT',()=>{if(server)server.close(async()=>{await closeDB();process.exit(0);});else process.exit(1);});

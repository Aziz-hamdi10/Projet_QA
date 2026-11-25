

const express=require('express');
const router =express.Router();
const user = require('../models/user');
const bcrypt = require('bcrypt');
const jwt=require('jsonwebtoken')
const multer = require('multer');
var nodemailer = require('nodemailer');
const Notification = require('../models/notification')
const product = require('../models/Product')
const veriftokn = require('../routes/veriftoken');

const sendemail=async (option)=>{
var transport = nodemailer.createTransport({
  host: "sandbox.smtp.mailtrap.io",
  port: 2525,
  auth: {
    user: "efa13a9d6fba49",
    pass: "f20eebbf215126"
  }
});
  const emailoptions ={
      from :'Cineflix support<support@cineflix.com>',
      to: option.email,
      subject: option.subject,
      text: option.message,

  }
  await transport.sendMail(emailoptions);
}
const generateRandomCode = () => {
  const min = 100000;
  const max = 999999;
  return Math.floor(Math.random() * (max - min + 1)) + min;
};
const calculateExpirationTime = () => {
  const now = new Date();
  return new Date(now.getTime() + 5 * 60 * 1000); 
};

const mystorage = multer.diskStorage({
    destination: './uploads',
    filename: (req, file, redirect) => {
        let date = Date.now();
        let f1 = date + '.' + file.mimetype.split('/')[1];
        redirect(null, f1);
        filename = f1;
    }
});
router.get('/getusers/:userId', async (req, res) => {
  const userId = req.params.userId;

  try {
    const User = await user.findById(userId);
    
    if (!User) {
      return res.status(404).json({ error: 'User not found' });
    }
if(User.role=="admin"||User.role=="Moderator")
{
const Users = await user.find({ role: { $in: ["client", ""] } });

  res.status(200).json(Users);

}
else{
  return res.status(404).json({ error: 'User not allowed' });

}
  } catch (error) {
    console.error('Error fetching user:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
router.get('/getmoderateurs/:userId', async (req, res) => {
  const userId = req.params.userId;

  try {
    const User = await user.findById(userId);
    
    if (!User) {
      return res.status(404).json({ error: 'User not found' });
    }
if(User.role=="admin"||User.role=="Moderator")
{
const Users = await user.find({ role: { $in: ["Moderator"] } });

  res.status(200).json(Users);

}
else{
  return res.status(404).json({ error: 'User not allowed' });

}
  } catch (error) {
    console.error('Error fetching user:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
router.get('/getdeleivry/:userId', async (req, res) => {
  const userId = req.params.userId;
  try {
    const User = await user.findById(userId);
    
    if (!User) {
      return res.status(404).json({ error: 'User not found' });
    }
if(User.role=="admin"||User.role=="Moderator")
{
const Users = await user.find({ role: "delievry" });

  res.status(200).json(Users);

}
else{
  return res.status(404).json({ error: 'User not allowed' });

}
  } catch (error) {
    console.error('Error fetching user:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
router.get('/getuser/:userId', async (req, res) => {
    const userId = req.params.userId;
  
    try {
      const User = await user.findById(userId);
      
      if (!User) {
        return res.status(404).json({ error: 'User not found' });
      }
  
      res.status(200).json(User);
    } catch (error) {
      console.error('Error fetching user:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  
const upload = multer({ storage: mystorage });
router.post('/register', upload.any('Profilepicture'),async(req,res)=>{
   try{
    const data = req.body;
    const usr = new user(data);
    user1= await user.findOne({"email": data.email} )
    if (user1) {
        return res.status(404).send("Email Used");

    }
    
    const saltRounds = 10;

    const salt = await bcrypt.genSalt(saltRounds);

    const cryptpass = await bcrypt.hash(data.password, salt);

    usr.password=cryptpass;
    usr.Profilepicture = "user.jpg";

    filename = '';
    const code = generateRandomCode();
    const expirationTime = calculateExpirationTime(); 

    await sendemail({
      email: usr.email,
      subject: "BridgeWear - Code de confirmation",
      message: `Votre code de confirmation est : ${code}. Il expirera à ${expirationTime.toLocaleString()}.`,
  });
      console.log("email sender to "+usr.email);

    usr.code=code;
    usr.datecode=expirationTime;
    usr.state="notActive";
    usr.save()
        .then(saveduser => {
            res.send(saveduser); 
        })
        .catch(err => {
            console.log(err);
            res.status(500).send({ error: 'Internal Server Error' });
        });

   }
   catch(err){
    res.send(err)
   }
   
    
});
router.post('/adduser', upload.any('Profilepicture'),async(req,res)=>{
  try{
   const data = req.body;
   const usr = new user(data);
   user1= await user.findOne({"email": data.email} )
 
   if (user1) {
       return res.status(404).send("Email Used");

   }
   
   const saltRounds = 10;

   const salt = await bcrypt.genSalt(saltRounds);

   const cryptpass = await bcrypt.hash(data.password, salt);

   usr.password=cryptpass;
   usr.Profilepicture = "user.jpg";

   filename = '';
   const code = generateRandomCode();
   const expirationTime = calculateExpirationTime(); 
   usr.code=code;
   usr.datecode=expirationTime;
   usr.state="notActive";
   usr.save()
       .then(saveduser => {
           res.send(saveduser); 
       })
       .catch(err => {
           console.log(err);
           res.status(500).send({ error: 'Internal Server Error' });
       });

  }
  catch(err){
   res.send(err)
  }
  
   
});
router.post('/activate', async (req, res) => {
  try {
    const { email, code } = req.body;
      const existingUser = await user.findOne({ email });
    if (!existingUser) {
      return res.status(404).json({ error: 'User not found' });
    }
      if (existingUser.code !== code ) {
      return res.status(400).json({ error: 'Invalid Code' });
    }
    if ( new Date(existingUser.datecode)<Date.now()) {
      return res.status(400).json({ error: 'Code Expired' });
    }

    existingUser.state = 'active'; 

    await existingUser.save();
    res.status(200).json({ message: 'User activated successfully' });
    
  } catch (error) {
    console.error('Error activating user:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
router.post('/sendcode',async(req,res)=>{
  try{
    const { email } = req.body;
   user1= await user.findOne({"email": email} )
 
   if (!user1) {
    return res.status(404).json({ error: 'User not found' });

   }
   
   const code = generateRandomCode();
   const expirationTime = calculateExpirationTime(); 
       console.log("email sender to ");

   await sendemail({
     email: user1.email,
     subject: "BridgeWear - Code de confirmation",
     message: `Votre code d'activation est : ${code}. Il expirera à ${expirationTime.toLocaleString()}.`,
 });
       console.log("email sender to "+user1.email);

   user1.code=code;
   user1.datecode=expirationTime;
   user1.save()
       .then(saveduser => {
           res.send(saveduser); 
       })
       .catch(err => {
           console.log(err);
           res.status(500).send({ error: 'Internal Server Error' });
       });

  }
  catch(err){
   res.send(err)
  }
  
   
});
router.post('/forget-password', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    const existingUser = await user.findOne({ email: email });
    
    if (!existingUser || existingUser.length === 0) {
      return res.status(404).send("User not found");
    }

    if (password) {
      const saltRounds = 10;
      const salt = await bcrypt.genSalt(saltRounds);
      const hashedPassword = await bcrypt.hash(password, salt);

      await user.updateOne({ email: email }, { password: hashedPassword },{state:"active"});
    }
    res.status(200).json({ message: "Password modified successfully" });


  } catch (err) {
    console.error(err);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});
router.post('/modify-password', async (req, res) => {
  try {
    const { id,email, currentPassword, newPassword } = req.body;
    if(id)
     existingUser = await user.findById(id);
    else
     existingUser = await user.findOne({"email":email});

    if (!existingUser || !(await bcrypt.compare(currentPassword, existingUser.password))) {
      return res.status(404).send("Invalid  current password");
    }

    const saltRounds = 10;

    const salt = await bcrypt.genSalt(saltRounds);

    const cryptpass = await bcrypt.hash(newPassword, salt);
    await existingUser.updateOne({ password: cryptpass });

 
    res.status(200).json({ message: "Password modified successfully" });
  } catch (err) {
    console.error(err);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});
router.post('/modify-profile', upload.single('Profilepicture'), async (req, res) => {
  try {
    const { id, email, password, firstname, secondname, phone } = req.body;
    
    const existingUser = await user.findById(id);
    if (!existingUser) {
        return res.status(404).send("User not found");
    }

    if (password) {
        const saltRounds = 10;
        const salt = await bcrypt.genSalt(saltRounds);
        const hashedPassword = await bcrypt.hash(password, salt);
        existingUser.password = hashedPassword;
    }
    if (firstname) {
        existingUser.firstname = firstname;
    }
    if (secondname) {
        existingUser.secondname = secondname;
    }
    if (phone) {
        existingUser.phone = phone;
    }
    if (req.file) {
        existingUser.Profilepicture = req.file.filename; 
    }

    await existingUser.save();
    res.send(existingUser);

  } catch (err) {
    console.error(err);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});
router.get('/check-username/:username', async (req, res) => {
    const { username } = req.params;
    try {
      const existingUser = await user.findOne({ username });
      if (existingUser) {
        res.json({ available: false });

      } else {
        res.json({ available: true });

      }

    } catch (error) {
      console.error('Error checking username:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  
  router.get('/check-email/:email', async (req, res) => {
    const { email } = req.params;
    
    try {
      const existingUser = await user.findOne({ email: { $regex: new RegExp(`^${email}$`, 'i') } });

      if (existingUser) {
        res.json({ available: false });

      } else {
        res.json({ available: true });

      }

    } catch (error) {
      console.error('Error checking email:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  router.post('/check-password/', async (req, res) => {
    const { id,password } = req.body;
    try {
        const existingUser = await user.findById(id);

        if (!existingUser) {
            res.json({ available: false });
            return;
        }
        const passwordMatch = await bcrypt.compare(password, existingUser.password);
        if (passwordMatch) {
            res.json({ available: true });
        } else {
            res.json({ available: false });
        }
    } catch (error) {
        console.error('Error checking password:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});


router.post('/login', async (req, res) => {
  try {
    const data = req.body;

    const user1 = await user.findOne({ email: data.email });
    if (!user1) {
      return res.status(404).send("Email incorrect");
    }

    const validPass = await bcrypt.compare(data.password, user1.password);
    if (!validPass) {
      return res.status(401).send("Password invalid");
    }

    const token = jwt.sign(
      { userId: user1._id },
      '0000',
      { expiresIn: '24h' }
    );

    return res.status(200).json({
      user: user1,
      mytoken: token
    });

  } catch (error) {
    console.error(error);
    return res.status(500).send("Internal Server Error");
  }
});

router.get('/getuserbytoken',veriftokn, async (req, res) => {

  try {
    
    const userId = req.userId;

    const fetchedUser =   await user.findById(userId);

    if (!fetchedUser) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.status(200).json(fetchedUser);
  } catch (error) {
    console.error('Error fetching user:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
router.post('/forgetpassword', async (req, res) => {
    try {
        const data = req.body;

        let user1 = await user.findOne({ email: data.email });

        if (!user1) {
            const user2=await user.findOne({ username: data.username });
            if(!user2){
                return res.status(404).send("Email or username Incorrect invalid");

            }
            else{
                user1=await user.findOne({ username: data.username });
            }
        }


    

    
    
        const mailOptions = {
          from: 'hamdiaziz7111@gmail.com',
          to: user1.email,
          subject: 'Password Reset',
          text: `Click the following link to reset your password: http://localhost:3000/user/resetpassword/`,
        };
        transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              console.error(error);cons
              res.status(500).json({ error: 'Error sending reset email' });
            } else {
              res.status(200).json({ message: 'Reset email sent successfully' });
            }
          });
    } catch (error) {
        console.error(error);
        res.status(500).send("Internal Server Error");
    }
});

function generateResetToken() {
  }
  router.delete('/deleteuser/:userid', (req, res) => {
    const userid = req.params.userid;
    user.findByIdAndRemove(userid)
        .then(deleteduser => {
            if (deleteduser) {
                res.json({ message: 'User deleted successfully' });
            } else {
                res.status(404).json({ message: 'User not found' });
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});
router.post('/count-users-by-role', async (req, res) => {
  try {
    const { role } = req.body;
     userCount=0;
    if(role!="all"){
       userCount = await user.countDocuments({ role: role });

    }
    else{
      userCount = await user.countDocuments();

    }

    res.json({ userCount });
  } catch (error) {
    console.error('Error counting users:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
router.put('/update-state/:usesrid', async (req, res) => {
  const { usesrid } = req.params;
  const { newState,idmod } = req.body;

  try {
      
      const founduser = await user.findByIdAndUpdate(usesrid, { state: newState });
      if(idmod!=null){
        const User= await user.findOne({"role":"admin"} );
        const notification = new Notification({
          senderid: idmod,
          message: 'Has blocked '+newState+" "+founduser.firstname+' '+founduser.secondname,
          link:founduser._id,
          title: newState,
          ownerId: User._id,
      });
      await notification.save();        }
      if (!founduser) {
        return res.status(404).json({ message: "L'utilisateur n'a pas été trouvée." });
      }
  
      return res.status(200).json({ message: "l'utilisateur est modifier", User: founduser });
   
    

 } catch (error) {
    console.error("Une erreur s'est produite lors de la mise à jour de l'état de la commande :", error);
    return res.status(500).json({ message: "Une erreur s'est produite lors de la mise à jour de l'état de la commande." });
  }
});
module.exports=router;
const mongoose=require('mongoose');
const user=mongoose.model('user',{
    firstname:{
        type:String
    },
    secondname:{
        type:String
    },
    username:{
        type:String
    },
    phone:{
        type:String
    },
    email:{
        type:String

    },
   
    Profilepicture:{
        type:String
    },
    password:{
        type:String
    },
    role:{
        type:String
    },
    code:{
        type:String
    },
    datecode:{
        type: Date,
        default: Date.now
    },
    state:{
        type:String
    }
}
);
module.exports=user;
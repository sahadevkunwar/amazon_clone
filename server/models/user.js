const mongoose=require("mongoose")
 
const userSchema=mongoose.Schema({
    name:{
        required:true,
        type:String,
        trim:true
    },
    email:{
        required:true,
        type:String,
        trim:true,
        validate:{
            validator:(value)=>{
                const regex=/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return value.match(regex);
            },
            message:"Please enter a valid email address",
        }
    },
    password:{
        required:true,
        type:String,
    },
    address:{
        type:String,
        default:"",
    },
    type:{
        type:String,
        default:"user",
    }
})

const User=mongoose.model("User",userSchema);
module.exports=User;
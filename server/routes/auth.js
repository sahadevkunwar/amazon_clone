const express=require("express")
const bcyrptjs=require("bcryptjs");
const User=require("../models/user")
const jwt=require("jsonwebtoken");
const authRouter=express.Router()



authRouter.post("/api/signup", async (req, res) => {
    try {
        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ error: "User with email already exists" });
        }
        const hashedPassword = await bcyrptjs.hash(password, 8);
        let user = new User({ email, password: hashedPassword, name });
        user = await user.save();
        res.json(user);
    } catch (e) {
        // Handle all types of errors here
        res.status(500).json({error:e.message});
    }
});


authRouter.post("/api/signin",async(req,res)=>{
    try {
        const {email,password}=req.body;
        const user=await User.findOne({email});
        if (!user) {
            return res.status(400).json({error:"User with this email does not exist"});
        }
        const isMatch=await bcyrptjs.compare(password,user.password);
        if (!isMatch) {
            return res.status(400).json({error:"Password does not match"});
        }
        const token=jwt.sign({id:user._id},"passwordKey");
        res.json({token,...user._doc});
    } catch (e) {
        res.status(500).json({error:e.message});
    }
})


module.exports=authRouter;
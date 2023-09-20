const express=require("express")

const authRouter=express.Router()

authRouter.get("/name",(req,res)=>{res.json({name:"bam kunwar"})})

module.exports=authRouter;
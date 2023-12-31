//import from packages
const express = require("express");
const mongoose = require("mongoose");
require('dotenv');
var cors = require('cors')

//mongodatabase
 const DB = "mongodb+srv://sahadev:sawdev@cluster0.hk8hk8o.mongodb.net/Amazon_clone?retryWrites=true&w=majority"
//const DB=process.env.mongoDB;
//import from other files
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
const User = require("./models/user");


//initialize
const PORT = 3000;
const app = express();

//middleware
app.use(cors())
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

app.use(User);




//connections
mongoose.connect(DB).then(() => { console.log("Database Connection successful"); })

//creating an api
//app.get("/hello-world", (req, res) => { res.json({hi:"hello world"},) },)

app.listen(PORT, () => {
    console.log(`connected at port ${PORT} `);
})
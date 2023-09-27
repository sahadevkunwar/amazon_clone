//import from packages
const express = require("express");
const mongoose = require("mongoose");
var cors = require('cors')

//mongodatabase
const DB="mongodb+srv://sahadev:sawdev@cluster0.hk8hk8o.mongodb.net/?retryWrites=true&w=majority"

//import from other files
const authRouter = require("./routes/auth")


//initialize
const PORT = 3000;
const app = express();

//middleware
app.use(cors()) 
app.use(express.json());
app.use(authRouter);


//connections
mongoose.connect(DB).then(() => { console.log("Connection successful"); })

//creating an api
//app.get("/hello-world", (req, res) => { res.json({hi:"hello world"},) },)

app.listen(PORT, () => {
    console.log(`connected at port ${PORT} `);
})

//import from packages
const express = require("express");

//import from other files
const authRouter=require("./routes/auth")

//initialize
const PORT = 3000;
const app = express();

//middleware
app.use(authRouter)

//creating an api
//app.get("/hello-world", (req, res) => { res.json({hi:"hello world"},) },)

app.listen(PORT, () => {
    console.log(`connected at port ${PORT} `);
})

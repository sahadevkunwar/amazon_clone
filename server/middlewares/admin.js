const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = async(req, res, next) => {
    try {
        const token = req.header("x-auth-token");
        //[Start] const tokenHeader = req.headers["x-auth-token"];
        // const token = tokenHeader.split(" ")[1];[End]

        //[Start] const authHeader = req.header("Authorization");
        // if (!authHeader || !authHeader.startsWith("Bearer ")) {
        //     return res.status(401).json({ error: "No Bearer token - Access denied" });
        // }
        // const token = authHeader.split(" ")[1];[End]

        if (!token)
            return res.status(401).json({ error: "No auth token- Access denied" });
        const verified = jwt.verify(token, "passwordKey");
        if (!verified)
            return res.status(401).json({ error: "Token verification failed.Authorization denied" });
        const user = await User.findById(verified.id);
        if (user.type == "user" || user.type == "seller") {
            return res.status(401).json({ error: "Your are not an admin" });
        }
        req.user = verified.id;
        req.token = token;
        next();
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}
module.exports = admin;
const jwt = require("jsonwebtoken");

const auth = async(req, res, next) => {
    try {
        const token = req.header("x-auth-token");
        if (!token)
            return res.status(401).json({ error: "No auth token-Access dedied" });
        const verified = jwt.verify(token, "passwordKey");
        if (!verified)
            return res.status(401).json({ error: "Token verification failed.Authorization denied" });
        req.user = verified.id;
        req.token = token;
        next();
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}
module.exports = auth;
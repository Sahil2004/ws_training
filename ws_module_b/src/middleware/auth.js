export async function auth(req, res, next) {
    let pwd = req.query?.pwd ?? req.body?.pwd;
    if (pwd === "admin") {
        return next();
    } else {
        res.sendStatus(401)
    }
}
export async function auth(req, res, next) {
    const pwd = req.query?.pwd ?? req.body?.pwd;
    if (pwd === "admin") {
        return next()
    } else {
        return res.sendStatus(401)
    }
}
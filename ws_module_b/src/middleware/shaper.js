export function createCompanyShaper(req, res, next) {
    const { ownerName, ownerEmail, ownerMobile, contactName, contactEmail, contactMobile, ...body } = req.body;
    delete body.pwd
    body.Owner = {
        create: {
            name: ownerName,
            email: ownerEmail,
            mobile: ownerMobile
        }
    }
    body.Contact = {
        create: {
            name: contactName,
            email: contactEmail,
            mobile: contactMobile
        }
    }
    req.body = body
    next()
}
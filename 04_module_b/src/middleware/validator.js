import { fields } from "../db/fields.js";

export const companyCreateValidator = (req, res, next) => {
    const { pwd, ownerName, ownerEmail, ownerMobile, contactName, contactEmail, contactMobile, ...body } = req.body;
    const newBody = {
        ...body,
        Owner: {
            create: {
                name: ownerName,
                email: ownerEmail,
                mobile: ownerMobile
            }
        },
        Contact: {
            create: {
                name: contactName,
                email: contactEmail,
                mobile: contactMobile
            }
        }
    }
    req.body = newBody;
    return next()
}

export const companyUpdateValidator = (req, res, next) => {
    const { pwd, ownerName, ownerEmail, ownerMobile, contactName, contactEmail, contactMobile, ...body } = req.body;
    const newBody = {
        ...body,
        Owner: {
            update: {
                name: ownerName,
                email: ownerEmail,
                mobile: ownerMobile
            }
        },
        Contact: {
            update: {
                name: contactName,
                email: contactEmail,
                mobile: contactMobile
            }
        }
    }
    req.body = newBody;
    return next()
}


export const productsCreateValidator = (req, res, next) => {
    let { pwd, ...body } = req.body;
    body.image = req.file?.path ?? "uploads/default.jpeg";
    if (body.GTIN.length > 14 || body.GTIN.length < 13) {
        return res.render("new", {
            title: "Products",
            fields: fields["Products"],
            other: "Company",
            error: "GTIN length should be between 13 and 14 digits"
        })
    }
    body.GTIN = parseInt(body.GTIN)
    body.grossWeight = parseInt(body.grossWeight)
    body.netWeight = parseInt(body.netWeight)
    req.body = body;
    return next()
}
import { Router } from "express";
import multer from "multer";
import { auth } from "../middleware/auth.js";
import { handler } from "../controllers/handler.js";
import { companyCreateValidator, companyUpdateValidator, productsCreateValidator } from "../middleware/validator.js";
import { companyTransformer, productsTransformer } from "../transformer/transformer.js";

const router = Router()

const upload = multer({ dest: 'uploads/' })

router.get("/login", (req, res) => {
    res.render("login")
})

router.get("/company", auth, handler("Company", {
    include: {
        Contact: true,
        Owner: true
    },
    other: "Products",
    render: "dashboard",
    transformer: companyTransformer
}).findMany)

router.get("/company/new", auth, handler("Company", {
    render: "new",
    include: {
        Contact: true,
        Owner: true
    },
}).fields)

router.get("/company/:id/update", auth, handler("Company", {
    include: {
        Contact: true,
        Owner: true
    },
    render: "new",
    transformer: companyTransformer
}).fields)

router.post("/company/:id/update", upload.none(), auth, companyUpdateValidator, handler("Company", {
    include: {
        Contact: true,
        Owner: true
    },
    other: "Products",
    errRender: "new",
    transformer: companyTransformer,
    render: "dashboard"
}).update)


router.post("/company", upload.none(), auth, companyCreateValidator, handler("Company", {
    render: "dashboard",
    errRender: "new",
    other: "Products",
    include: {
        Contact: true,
        Owner: true,
    },
    transformer: companyTransformer
}).create)


router.get("/products", auth, handler("Products", {
    include: {
        Company: true
    },
    other: "Company",
    render: "dashboard",
    transformer: productsTransformer
}).findMany)

router.get("/products/new", auth, handler("Products", {
    include: {
        Company: true,
    },
    select: {
        name: "Company",
        fields: {
            id: true,
            name: true
        }
    },
    render: "new"
}).fields)

router.get("/products/:id/update", auth, handler("Products", {
    include: {
        Company: true,
    },
    select: {
        name: "Company",
        fields: {
            id: true,
            name: true
        }
    },
    render: "new"
}).fields)

router.post("/products/:id/update", upload.single("image"), auth, productsCreateValidator, handler("Products", {
    include: {
        Company: true,
    },
    other: "Company",
    errRender: "new",
    transformer: productsTransformer,
    select: {
        name: "Company",
        fields: {
            id: true,
            name: true
        }
    },
    render: "dashboard"
}).update)


router.post("/products", upload.single("image"), auth, productsCreateValidator, handler("Products", {
    render: "dashboard",
    errRender: "new",
    other: "Company",
    include: {
        Company: true
    },
    transformer: productsTransformer
}).create)



export { router as mainRouter }
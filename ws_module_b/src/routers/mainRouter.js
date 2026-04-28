import { Router } from "express";
import { handler } from "../controllers/handler.js";
import { auth } from "../middleware/auth.js";
import multer from "multer"
import { createCompanyShaper } from "../middleware/shaper.js"
import { companyTransformer } from "../transformers/transformer.js";

const uplaod = multer({ dest: "uploads/" })

const router = Router()

router.get("/login", (req, res) => {
    res.render("login")
})

const loginHandler = handler("Company", {
    include: {
        Contact: true,
        Owner: true
    },
    transformer: companyTransformer,
    render: "dashboard"
}).fetchAll
router.get("/company", auth, loginHandler)

const newCompHandler = handler("Company", {
    render: "new"
}).getFields
router.get("/company/new", auth, newCompHandler)

const createCompanyHandler = handler("Company", {
    render: "dashboard",
    include: {
        Contact: true,
        Owner: true
    },
    transformer: companyTransformer
}).create
router.post("/company", uplaod.none(), auth, createCompanyShaper, createCompanyHandler)

const productsHandler = handler("Product", {
    include: {
        Company: true
    },
    render: "dashboard"
}).fetchAll
router.get("/products", auth, productsHandler)

const newProdHandler = handler("Product", {
    render: "new"
}).getFields
router.get("/products/new", auth, newProdHandler)

const createProductHandler = handler("Product").create
router.post("/products", uplaod.single("image"), auth, createProductHandler)

export { router as mainRouter }
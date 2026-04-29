import { Router } from "express";
import multer from "multer";
import { auth } from "../middleware/auth.js";
import { handler } from "../controllers/handler.js";

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
    render: "dashboard"
}).findMany)

router.get("/company/new", auth, handler("Company", {
    render: "new",
    include: {
        Contact: true,
        Owner: true
    },
}).fields)


router.get("/products", auth, handler("Products", {
    include: {
        Company: true
    },
    other: "Company",
    render: "dashboard"
}).findMany)



export { router as mainRouter }
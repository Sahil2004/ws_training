import { Router } from "express";
import { body, validationResult } from "express-validator";
import { prisma } from "./db.js"

const router = Router()

router.post("/contact", body('name').notEmpty(), body('email').isEmail(), body('country').notEmpty(), body('interests').notEmpty(), async (req, res) => {
    const result = validationResult(req)
    if (!result.isEmpty()) {
        return res.status(300).json({
            success: false,
            message: "Validation Failed"
        })
    }
    const data = await prisma.submission.create({
        data: req.body
    })
    return res.status(201).json({
        success: true,
        message: "Travel inquiry has been received."
    })
})

export { router as mainRouter }
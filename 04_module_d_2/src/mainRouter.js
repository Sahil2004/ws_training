import { Router } from "express";
import { body, validationResult } from "express-validator";
import { prisma } from "./db.js";

const router = Router();

router.get("/", async (req, res) => {
  const practicalInfo = await prisma.infoItems.findMany({});
  const regionsInfo = await prisma.regions.findMany({
    include: {
      attractions: true,
    },
  });
  return res.render("main", {
    infoItems: practicalInfo,
    regionsInfo: regionsInfo,
  });
});

router.post(
  "/submission",
  body("name").notEmpty(),
  body("message").notEmpty(),
  body("email").isEmail(),
  async (req, res) => {
    const result = validationResult(req);
    if (!result.isEmpty()) {
      return res.render("main", {
        of: "contact",
        success: false,
        message: "Validation Failed!",
      });
    }
    try {
      await prisma.submissions.create({
        data: req.body,
      });
      const practicalInfo = await prisma.infoItems.findMany({});
      const regionsInfo = await prisma.regions.findMany({
        include: {
          attractions: true,
        },
      });
      return res.render("main", {
        of: "contact",
        success: true,
        message:
          "Thanks! We've received your request. We'll reach out with tips for the region.",
        infoItems: practicalInfo,
        regionsInfo: regionsInfo,
      });
    } catch (err) {
      return res.render("main", {
        of: "contact",
        success: false,
        message: "Internal Server Error",
      });
    }
  },
);

export { router as mainRouter };

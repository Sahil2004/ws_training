import { Router } from "express";
import { prisma } from "./db.js";
import { body, validationResult } from "express-validator";

const router = Router();

router.get("/", async (req, res) => {
  const regions = await prisma.regions.findMany({
    include: {
      attractions: true,
    },
  });
  const infoItems = await prisma.infoItems.findMany({});
  res.render("main", {
    regions: regions,
    infoItems: infoItems,
  });
});

router.post(
  "/submission",
  body("name").notEmpty().isAlpha(),
  body("email").isEmail().notEmpty(),
  body("message").notEmpty(),
  async (req, res) => {
    const regions = await prisma.regions.findMany({
      include: {
        attractions: true,
      },
    });
    const infoItems = await prisma.infoItems.findMany({});
    const result = validationResult(req);
    if (!result.isEmpty()) {
      return res.render("main", {
        success: false,
        message: "Validation Error",
        regions: regions,
        infoItems: infoItems,
      });
    }
    return res.render("main", {
      regions: regions,
      infoItems: infoItems,
    });
  },
);

export { router as mainRouter };

import { Router } from "express";
import { prisma } from "./db.js";
import { fields } from "./schema.js";
import multer from "multer";

const router = Router();
const upload = multer({ dest: "uploads/" });

async function auth(req, res, next) {
  const pwd = req.body?.pwd ?? req.query?.pwd;
  if (pwd === "admin") return next();
  else return res.sendStatus(401);
}

router.get("/login", (req, res) => {
  res.render("login");
});

router.get("/company", auth, async (req, res) => {
  const data = await prisma.Company.findMany({
    include: {
      Owner: true,
      Contact: true,
    },
  });
  res.render("company", {
    data: data,
  });
});

router.get("/company/new", auth, async (req, res) => {
  res.render("companyNew", {
    fields: fields["Company"],
  });
});

router.get("/company/update/:id", auth, async (req, res) => {
  const data = await prisma.Company.findFirst({
    where: {
      id: req.params.id,
    },
    include: {
      Owner: true,
      Contact: true,
    },
  });
  data.ownerName = data.Owner.name;
  data.ownerEmail = data.Owner.email;
  data.ownerMobile = data.Owner.mobile;
  data.contactName = data.Contact.name;
  data.contactEmail = data.Contact.email;
  data.contactMobile = data.Contact.mobile;
  res.render("companyNew", {
    fields: fields["Company"],
    data: data,
  });
});

router.post("/company", auth, async (req, res) => {
  const {
    pwd,
    contactName,
    contactEmail,
    contactMobile,
    ownerName,
    ownerEmail,
    ownerMobile,
    isDeactivated,
    ...body
  } = req.body;
  const newBody = {
    ...body,
    isDeactivated:
      isDeactivated === "on" || isDeactivated === "" ? true : false,
    Contact: {
      create: {
        name: contactName,
        email: contactEmail,
        mobile: contactMobile,
      },
    },
    Owner: {
      create: {
        name: ownerName,
        email: ownerEmail,
        mobile: ownerMobile,
      },
    },
  };
  await prisma.Company.create({
    data: newBody,
  });
  const data = await prisma.Company.findMany({
    include: {
      Owner: true,
      Contact: true,
    },
  });
  res.render("company", {
    data: data,
  });
});

router.post("/company/update/:id", auth, async (req, res) => {
  const {
    pwd,
    contactName,
    contactEmail,
    contactMobile,
    ownerName,
    ownerEmail,
    ownerMobile,
    isDeactivated,
    ...body
  } = req.body;
  const newBody = {
    ...body,
    isDeactivated:
      isDeactivated === "on" || isDeactivated === "" ? true : false,
    Contact: {
      update: {
        name: contactName,
        email: contactEmail,
        mobile: contactMobile,
      },
    },
    Owner: {
      update: {
        name: ownerName,
        email: ownerEmail,
        mobile: ownerMobile,
      },
    },
  };
  await prisma.Company.update({
    data: newBody,
    where: {
      id: req.params.id,
    },
  });
  if (isDeactivated === "on" || isDeactivated === "") {
    await prisma.Products.updateMany({
        data: {
            isHidden: true
        },
        where: {
            companyId: req.params.id
        }
    })
  }
  const data = await prisma.Company.findMany({
    include: {
      Owner: true,
      Contact: true,
    },
  });
  res.render("company", {
    data: data,
  });
});

// Products APIS (ADMIN)

router.get("/products", auth, async (req, res) => {
  const data = await prisma.Products.findMany({});
  res.render("products", {
    data: data,
  });
});

router.get("/products/new", auth, async (req, res) => {
  const data = await prisma.Company.findMany({
    select: {
      id: true,
      name: true,
    },
  });
  res.render("productsNew", {
    fields: fields["Products"],
    options: data,
  });
});

router.get("/products/update/:id", auth, async (req, res) => {
  const data = await prisma.Products.findFirst({
    where: {
      GTIN: req.params.id,
    },
    include: {
      Company: true,
    },
  });
  const companies = await prisma.Company.findMany({
    select: {
      id: true,
      name: true,
    },
  });
  res.render("productsNew", {
    fields: fields["Products"],
    data: data,
    options: companies,
  });
});

router.post("/products", upload.single("image"), auth, async (req, res) => {
  const { pwd, isHidden, ...body } = req.body;
  if (body.GTIN.length < 13 || body.GTIN.length > 14) {
    const data = await prisma.Products.findFirst({
      where: {
        GTIN: req.params.id,
      },
      include: {
        Company: true,
      },
    });
    const companies = await prisma.Company.findMany({
      select: {
        id: true,
        name: true,
      },
    });
    return res.render("productsNew", {
      fields: fields["Products"],
      data: data,
      options: companies,
      error: "GTIN Field Must be between 13 and 14 length",
    });
  }
  body.GTIN = Number(body.GTIN)
  body.grossWeight = Number(body.grossWeight)
  body.netWeight = Number(body.netWeight)
  body.image = req.file?.path ?? "uploads/default.jpg"
  const newBody = {
    ...body,
    isHidden: isHidden === "on" || isHidden === "" ? true : false,
  };
  await prisma.Products.create({
    data: newBody,
  });
  const data = await prisma.Products.findMany({
    include: {
      Company: true,
    },
  });
  res.render("products", {
    data: data,
  });
});

router.post("/products/update/:id", upload.single("image"), auth, async (req, res) => {
  const { pwd, isHidden, ...body } = req.body;
  if (body.GTIN.length < 13 || body.GTIN.length > 14) {
    const data = await prisma.Products.findFirst({
      where: {
        GTIN: req.params.id,
      },
      include: {
        Company: true,
      },
    });
    const companies = await prisma.Company.findMany({
      select: {
        id: true,
        name: true,
      },
    });
    return res.render("productsNew", {
      fields: fields["Products"],
      data: data,
      options: companies,
      error: "GTIN Field Must be between 13 and 14 length",
    });
  }
  body.GTIN = Number(body.GTIN)
  body.grossWeight = Number(body.grossWeight)
  body.netWeight = Number(body.netWeight)
  body.image = req.file?.path ?? 'uploads/default.jpg';
  const newBody = {
    ...body,
    isHidden: isHidden === "on" || isHidden === "" ? true : false,
  };
  await prisma.Products.update({
    data: newBody,
    where: {
      GTIN: req.params.id,
    },
  });
  const data = await prisma.Products.findMany({
    include: {
      Company: true,
    },
  });
  res.render("products", {
    data: data,
  });
});

router.post("/products/delete/:id", auth, async (req, res) => {
  await prisma.Products.delete({
    where: {
      GTIN: req.params.id,
      isHidden: true
    },
  });
  const data = await prisma.Products.findMany({
    include: {
      Company: true,
    },
  });
  res.render("products", {
    data: data,
  });
});

// Public PRODUCT APIs

router.get("/products.json", (req, res) => {});

router.get("/products/:id.json", (req, res) => {});

export { router as mainRouter };

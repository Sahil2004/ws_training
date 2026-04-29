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

function productTransformer(data) {
  function transformer(d) {
    return {
      name: {
        en: d.name,
        fr: d.nameFr
      },
      description: {
        en: d.description,
        fr: d.descriptionFr
      },
      gtin: d.GTIN.toString(),
      brand: d.brand,
      countryOfOrigin: d.country,
      weight: {
        gross: d.grossWeight,
        net: d.netWeight,
        unit: d.unit
      },
      company: {
        companyName: d.Company.name,
        companyAddress: d.Company.address,
        companyTelephone: d.Company.mobile,
        companyEmail: d.Company.email,
        owner: {
          name: d.Company.Owner.name,
          mobileNumber: d.Company.Owner.mobile,
          email: d.Company.Owner.email
        },
        contact: {
          name: d.Company.Contact.name,
          mobileNumber: d.Company.Contact.mobile,
          email: d.Company.Contact.email
        }
      }
    }
  }
  return Array.isArray(data) ? data.map(transformer) : transformer(data);
}

router.get("/products.json", async (req, res) => {
  const { page = 1, query = ""} = req.query;
  const count = await prisma.Products.count({})
  const data = await prisma.Products.findMany({
    include: {
      Company: {
        include: {
          Owner: true,
          Contact: true
        }
      }
    },
    where: {
      OR: [
        { name: { contains: query, mode: 'insensitive'}},
        { nameFr: { contains: query, mode: 'insensitive'}},
        { description: { contains: query, mode: 'insensitive'}},
        { descriptionFr: { contains: query, mode: 'insensitive'}},
      ]
    },
    skip: (page - 1) * 10,
    take: 10
  });
  res.status(200).json({
    data: productTransformer(data),
    pagination: {
      current_page: page,
      total_pages: Math.ceil(count / 10.0),
      per_page: 10,
      next_page_url: page + 1 <= Math.ceil(count / 10.0) ? "http://localhost:4003/04_module_b/products.json?page=" + (page + 1) : null,
      prev_page_url: page - 1 >= 1 ? "http://localhost:4003/04_module_b/products.json?page=" + (page + 1) : null,
    }
  })
});

router.get("/products/:id.json", async (req, res) => {
  const data = await prisma.Products.findFirst({
    where: {
      GTIN: req.params.id
    },
    include: {
      Company: {
        include: {
          Owner: true,
          Contact: true
        }
      }
    },
  });
  if (!data) {
    return res.sendStatus(404)
  } else {
    res.status(200).json(productTransformer(data))
  }
});


// Public Pages

router.get("/verify", (req, res) => {
  res.render("verify");
});

router.post("/verify", async (req, res) => {
  const { gtin } = req.body;
  const result = await Promise.all(gtin.split("\r\n").map(async (g) => {
    const p = await prisma.Products.findFirst({
      select: {
        GTIN: true
      },
      where: {
        GTIN: g
      }
    })
    if (p) {
      return {
        gtin: g,
        verify: true
      }
    } else {
      return {
        gtin: g,
        verify: false
      }
    }
  }))
  let all = true;
  result.forEach(r => {
    if (!r.verify) all = false
  })
  res.render("verify", {
    data: result,
    all: all
  })
})

router.get("/01/:id", async (req, res) => {
  const { lang = "en" } = req.query;
  const data = await prisma.Products.findFirst({
    where: {
      GTIN: req.params.id,
    },
    include: {
      Company: true
    }
  })
  res.render("product", {
    lang: lang,
    data: data
  })
})

export { router as mainRouter };

import { prisma } from "../db/db.js";
import { schemas } from "../db/schemas.js";

export const handler = (modelName = null, options = {}) => ({
  fetchAll: async (req, res) => {
    const data = await prisma[modelName].findMany({
      where: {
        ...options.where,
      },
      include: {
        ...options.include,
      },
    });
    if (options.render) {
      return res.render(options.render, {
        title: modelName,
        data: options.transformer ? options.transformer(data) : data,
        fields: schemas[modelName],
        other: modelName === "Company" ? "Products" : "Company"
      });
    }
    return res.status(200).json(data);
  },
  getFields: async (req, res) => {
    return res.render(options.render, {
        title: modelName,
        fields: schemas[modelName]
    })
  },
  create: async (req, res) => {
    if (req.body.image) {
        req.body.image = req.file.path
    }
    try {

    await prisma[modelName].create({
      data: req.body,
    });
    const data = await prisma[modelName].findMany({
      where: {
        ...options.where,
      },
      include: {
        ...options.include,
      },
    });
    if (options.render) {
      return res.render(options.render, {
        title: modelName,
        fields: schemas[modelName],
        data: options.transformer ? options.transformer(data) : data,
        other: modelName === "Company" ? "Products" : "Company",
      });
    }
    } catch (err) {
      return res.render("new", {
        title: modelName,
        fields: schemas[modelName],
        error: err.message
      })
    }
    return res.status(200).json(data);
  },
});

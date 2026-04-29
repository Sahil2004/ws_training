import { prisma } from "../db/db.js"
import { fields } from "../db/fields.js"

export const handler = (modelName = null, options = {}) => ({
    fields: async (req, res) => {
        let selectOptions = null
        if (options.select) {
            selectOptions = await prisma[options.select.name].findMany({
                select: {
                    ...options.select.fields
                }
            })
        }
        const id = req.params?.id ?? null;
        let data = null
        if (id) {
            if (modelName === "Products") {
                data = await prisma[modelName].findFirst({
                    where: {
                        GTIN: id
                    },
                    include: {
                        ...options.include
                    }
                })
            } else {
                data = await prisma[modelName].findFirst({
                    where: {
                        id: id
                    },
                    include: {
                        ...options.include
                    }
                })
            }
        }
        return res.render(options.render, {
            title: modelName,
            fields: fields[modelName],
            selectOptions: selectOptions,
            data: options.transformer ? options.transformer(data) : data,
            id: id
        })
    },
    findMany: async (req, res) => {
        let data = await prisma[modelName].findMany({
            where: {
                ...options.where
            },
            include: {
                ...options.include
            }
        })

        if (options.render) {
            return res.render(options.render, {
                title: modelName,
                data: options.transformer ? options.transformer(data) : data,
                fields: fields[modelName],
                other: options.other
            })
        } else {
            return res.status(200).json(options.transformer ? options.transformer(data) : data)
        }
    },
    create: async (req, res) => {
        try {
            await prisma[modelName].create({
                data: req.body
            })
        } catch (err) {
            if (options.errRender) {
                return res.render(options.errRender, {
                    title: modelName,
                    fields: fields[modelName],
                    other: options.other,
                    error: err.message
                })
            } else {
                return res.status(400).json({
                    success: false,
                    error: err.message
                })
            }
        }
        let data = await prisma[modelName].findMany({
            where: {
                ...options.where
            },
            include: {
                ...options.include
            }
        })

        if (options.render) {
            return res.render(options.render, {
                title: modelName,
                data: options.transformer ? options.transformer(data) : data,
                fields: fields[modelName],
                other: options.other
            })
        } else {
            return res.status(200).json(options.transformer ? options.transformer(data) : data)
        }
    },
    update: async (req, res) => {
        try {
            if (modelName === "Products") {
                await prisma[modelName].update({
                    data: req.body,
                    where: {
                        GTIN: req.params.id
                    }
                })
            } else {
                await prisma[modelName].update({
                    data: req.body,
                    where: {
                        id: req.params.id
                    }
                })
            }
        } catch (err) {
            if (options.errRender) {
                let selectOptions = null
                if (options.select) {
                    selectOptions = await prisma[options.select.name].findMany({
                        select: {
                            ...options.select.fields
                        }
                    })
                }
                return res.render(options.errRender, {
                    title: modelName,
                    fields: fields[modelName],
                    other: options.other,
                    selectOptions: selectOptions,
                    error: err.message
                })
            } else {
                return res.status(400).json({
                    success: false,
                    error: err.message
                })
            }
        }
        let data = await prisma[modelName].findMany({
            where: {
                ...options.where
            },
            include: {
                ...options.include
            }
        })

        if (options.render) {
            return res.render(options.render, {
                title: modelName,
                data: options.transformer ? options.transformer(data) : data,
                fields: fields[modelName],
                other: options.other
            })
        } else {
            return res.status(200).json(options.transformer ? options.transformer(data) : data)
        }
    }
})
import { prisma } from "../db/db.js"
import { fields } from "../db/fields.js"

export const handler = (modelName = null, options = {}) => ({
    fields: (req, res) => {
        return res.render(options.render, {
            title: modelName,
            fields: fields[modelName]
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
                data: data,
                fields: fields[modelName],
                other: options.other
            })
        } else {
            return res.status(200).json(data)
        }
    }
})
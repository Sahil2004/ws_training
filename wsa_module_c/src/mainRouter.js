import { Router } from "express";
import { prisma } from "./db.js";
import crypto from "crypto"

const router = Router()

// Public APIs

router.post("/login", async (req, res) => {
    const{ username , password} = req.body;
    const user = await prisma.user.findUnique({
        select: {
            id: true,
            username: true,
            email: true,
            role: true,
            created_at: true,
            updated_at: true
        },
        where: {
            username: username,
            password: password
        }
    })
    const token = crypto.createHash("md5").update(JSON.stringify({ id: user.id})).digest("hex").toString().toLowerCase()
    const session = await prisma.session.create({
        data: {
            token: token,
            user_id: user.id
        }
    })
    if (user) {
        return res.status(200).json({
            success: true,
            data: {
                token: token,
                user: user
            }
        })
    }
})


router.post("/register", async (req, res)=> {
    const{ username, password, email} = req.body
    const user = await prisma.user.create({
        select: {
            id: true,
            username: true,
            email: true,
            role: true,
            created_at: true,
            updated_at: true
        },
        data: {
            username,
            email,
            password
        }
    })
    if (user) {
        return res.status(200).json({
            success: true,
            data: {
                user: user
            }
        })
    }
})

router.get("/albums", async (req, res) => {
    const { capital = null, year = null, limit = null, cursor = null} = req.query
    const albums = await prisma.album.findMany({
        select: {
            id: true,
            title: true,
            artist: true,
            release_year: true,
        },
        include: {
            publisher: {
                select: {
                    id: true,
                    username: true,
                    email: true
                }
            }
        },
    })
})


// User API

async function auth(req, res, next) {
    const token = req.get("x-authorization").split("Bearer ")[1]
    if (!token) return res.status(401).json({
        success: false,
        message: "Access Token is required."
    })
    const session = await prisma.session.findUnique({
        where: {
            token: token
        },
        include: {
            user: true
        }
    })
    if (session) {
        req.token = token
        req.user = session.user
        return next()
    } else {
        return res.status(401).json({
            success: false,
            message: "Invalid Access Token"
        })
    }
}

router.post("/logout", auth, async (req, res) => {
    await prisma.session.delete({
        where: {
            token: req.token
        }
    })
    res.status(200).json({
        success: true
    })
})

// Admin APIs

router.get("/users", async (req, res) => {
    const { cursor = null, limit = 10 } = req.query;
    let id = cursor ? JSON.parse(atob(cursor)).id :  1;
    const users = await prisma.user.findMany({
        cursor: {
            id: id
        },
        skip: cursor ? 1 : 0,
        take: parseInt(limit),
        select: {
            id: true,
            username: true,
            email: true,
            role: true,
            is_banned: true,
            created_at: true,
        },
    })
    const next_cursor = users.length === parseInt(limit) ? btoa(JSON.stringify({ "id": users[users.length - 1].id })) : null;
    return res.status(200).json({
        success: true,
        data: users,
        meta: {
            prev_cursor: cursor,
            next_cursor: next_cursor
        }
    })
})

export { router as mainRouter }
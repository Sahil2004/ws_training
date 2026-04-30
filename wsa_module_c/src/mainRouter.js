import { Router } from "express";
import { prisma } from "./db.js";
import crypto from "crypto"
import multer from "multer";

const router = Router()

const upload = multer({ dest: "uploads/"})

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
    if (!user) return res.status(400).json({
        success: false,
        message: "Login failed"
    })
    const token = crypto.createHash("md5").update(JSON.stringify({ id: user.id})).digest("hex").toString().toLowerCase()
    const session = await prisma.session.create({
        data: {
            token: token,
            user_id: user.id
        }
    })
    return res.status(200).json({
        success: true,
        data: {
            token: token,
            user: user
        }
    })
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
    const { capital = null, year = null, limit = 10, cursor = null} = req.query
    if (year &&isNaN(parseInt(year))) return res.status(400).json({
        success:false,
        message: "Invalid year format"
    })
    let id = 1;
    try {
        id = cursor ? JSON.parse(atob(cursor)).id :  1;
    } catch (err) {
        return res.status(400).json({
            success: false,
            message: "Invalid cursor"
        })
    }
    const albums = await prisma.album.findMany({
        cursor: {
            id: id
        },
        skip: cursor ? 1 : 0,
        take: parseInt(limit),
        select: {
            id: true,
            title: true,
            artist: true,
            release_year: true,
            publisher: {
                select: {
                    id: true,
                    username: true,
                    email: true
                }
            }
        },
    })
    const next_cursor = albums.length === parseInt(limit) ? btoa(JSON.stringify({ "id": albums[albums.length - 1].id })) : null;
    return res.status(200).json({
        success: true,
        data: albums,
        meta: {
            prev_cursor: cursor,
            next_cursor: next_cursor
        }
    })
})

router.get("/albums/:id", async (req, res) => {
    const{ id } = req.params;
    const albums = await prisma.album.findFirst({
        select: {
            id: true,
            title: true,
            artist: true,
            release_year: true,
            genre: true,
            description: true,
            created_at: true,
            updated_at: true,
            publisher: {
                select: {
                    id: true,
                    username: true,
                    email: true
                }
            }
        },
        where: {
            id: parseInt(id)
        }
    })
    return res.status(200).json({
        success: true,
        data: albums,
    })
})

router.get("/albums/:id/songs", async (req, res) => {
    const sid = parseInt(req.params.id)
    const songs = await prisma.song.findMany({
        where: {
            album_id: sid
        },
        orderBy: {
            order: "asc"
        },
        select: {
            id: true,
            album_id: true,
            title: true,
            label: {
                select: {
                    name: true
                }
            },
            duration_seconds: true,
            order: true,
            is_cover: true,
            cover_image_url: true
        },
    })
    songs.forEach(song => {
        song.label = song.label.map(l => l.name)
    })
    return res.status(200).json({
        success: true,
        data: songs,
    })
})

router.get("/songs", async (req, res) => {
    const { keyword = "", limit = 10, cursor = null} = req.query
    let id = 1;
    try {
        id = cursor ? JSON.parse(atob(cursor)).id :  1;
    } catch (err) {
        return res.status(400).json({
            success: false,
            message: "Invalid cursor"
        })
    }
    const songs = await prisma.song.findMany({
        cursor: {
            id: id
        },
        skip: cursor ? 1 : 0,
        take: parseInt(limit),
        orderBy: {
            order: "asc"
        },
        select: {
            id: true,
            album_id: true,
            title: true,
            label: {
                select: {
                    name: true
                }
            },
            album: {
                select: {
                    title: true
                }
            },
            duration_seconds: true,
            cover_image_url: true
        },
    })
    songs.forEach(song => {
        song.label = song.label.map(l => l.name)
        song.album_title = song.album.title
        delete song.album.title
        delete song.album
    })
    const next_cursor = songs.length === parseInt(limit) ? btoa(JSON.stringify({ "id": songs[songs.length - 1].id })) : null;
    return res.status(200).json({
        success: true,
        data: songs,
        meta: {
            prev_cursor: cursor,
            next_cursor: next_cursor
        }
    })
})

router.get("/songs/:id/cover", async (req, res) => {
    const { id } = req.params;
    const file = await prisma.song.findFirst({
        where: {
            id: parseInt(id)
        },
        select: {
            cover_image_url: true
        }
    })
    if (!file) return res.status(404).json({
        success: true,
        message: "Cover not found"
    })
    res.attachment("cover.jpg")
    res.status(200).sendFile(process.cwd() + "/" + file.cover_image_url)
})


// User API

async function auth(req, res, next) {
    if (!req.get("x-authorization")) return res.status(401).json({
        success: false,
        message: "Access Token is required."
    })
    const token = req.get("x-authorization").split("Bearer ")[1]
    const session = await prisma.session.findUnique({
        where: {
            token: token
        },
        include: {
            user: true
        }
    })
    if (session.user.is_banned) {
        return res.status(403).json({
            success: false,
            message: "User is banned"
        })
    }
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

async function admin(req, res, next) {
    if (req.user.role === "admin") {
        return next()
    } else {
        return res.status(403).json({
            success: false,
            message: "Admin access required"
        })
    }
}


router.get("/users", auth, admin, async (req, res) => {
    const { cursor = null, limit = 10 } = req.query;
    let id = 1;
    try {
        id = cursor ? JSON.parse(atob(cursor)).id :  1;
    } catch (err) {
        return res.status(400).json({
            success: false,
            message: "Invalid cursor"
        })
    }
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

router.put("/users/:id", auth, admin, async (req, res) => {
    const { role } = req.body;
    let {id} = req.params;
    id = parseInt(id)
    if (role === "user") {
        const adminCnt = await prisma.user.count({
            where: {
                role: "admin",
                id: id
            }
        })
        if (adminCnt === 1) {
            return res.status(403).json({
                success: false,
                message: "Last admin demotion forbidden"
            })
        }
    }
    const user = await prisma.user.findFirst({
        where: {
            id: id
        },
        select: {
            is_banned: true
        }
    })
    if (!user) {
        return res.status(404).json({
            success: false,
            message: "User not found"
        })
    }
    if (user.is_banned) {
        return res.status(409).json({
            success: false,
            message: "Banned user update failed"
        })
    }
    const result = await prisma.user.update({
        data: {
            role: role,
        },
        where: {
            id: id
        },
        select: {
            id: true,
            username: true,
            email: true,
            role: true,
            is_banned: true,
            created_at: true,
            updated_at: true
        }
    })
    return res.status(200).json({
        success: true,
        data: result
    })
})

router.put("/users/:id/ban", auth, admin, async (req, res) => {
    let{ id} = req.params
    id = parseInt(id)
    if (id === parseInt(req.user.id)) {
        return res.status(400).json({
            success: false,
            message: "Cannot ban self"
        })
    }
    const user = await prisma.user.findFirst({
        where: {
            id: id
        },
        select: {
            role: true
        }
    })
    if (user === null) {
        return res.status(404).json({
            success: false,
            message: "User not found"
        })
    }
    if (user.role === "admin") {
        return res.status(403).json({
            success: false,
            message: "Cannot ban another admin"
        })
    }
    const result = await prisma.user.update({
        data: {
            is_banned: true
        },
        where: {
            id: id
        },
        select: {
            id: true,
            username: true,
            email: true,
            role: true,
            is_banned: true,
            updated_at: true
        }
    })
    return res.status(200).json({
        success: true,
        data: result
    })
})

router.put("/users/:id/unban", auth, admin, async (req, res) => {
    let{ id} = req.params
    id = parseInt(id)
    const user = await prisma.user.findFirst({
        where: {
            id: id
        },
        select: {
            role: true
        }
    })
    if (user === null) {
        return res.status(404).json({
            success: false,
            message: "User not found"
        })
    }
    const result = await prisma.user.update({
        data: {
            is_banned: false
        },
        where: {
            id: id
        },
        select: {
            id: true,
            username: true,
            email: true,
            role: true,
            is_banned: true,
            updated_at: true
        }
    })
    return res.status(200).json({
        success: true,
        data: result
    })
})

router.post("/albums", upload.none(), auth, admin, async (req, res) => {
    const { release_year, ...body} = req.body
    if (release_year && isNaN(parseInt(release_year))) return res.status(400).json({
        success:false,
        message: "Invalid year format"
    })
    const album = await prisma.album.create({
        data: {
            ...body,
            release_year: parseInt(release_year),
            publisher_id: parseInt(req.user.id)
        },
        select: {
            id: true,
            title: true,
            artist: true,
            release_year: true,
            genre: true,
            description: true,
            created_at: true,
            updated_at: true,
            publisher: {
                select: {
                    id: true,
                    username: true,
                    email: true,
                }
            }
        },
    })
    res.status(201).json({
        success: true,
        data: album
    })
})

router.put("/albums/:id", upload.none(), auth, admin, async (req, res) => {
    const id = parseInt(req.params.id)
    const album = await prisma.album.update({
        data: {
            ...req.body,
            publisher_id: parseInt(req.user.id)
        },
        where: {
            id: id
        },
        select: {
            id: true,
            title: true,
            artist: true,
            release_year: true,
            genre: true,
            description: true,
            created_at: true,
            updated_at: true,
            publisher: {
                select: {
                    id: true,
                    username: true,
                    email: true,
                }
            }
        },
    })
    res.status(201).json({
        success: true,
        data: album
    })
})


router.delete("/albums/:id", auth, admin, async (req, res) => {
    const id = parseInt(req.params.id)
    const album = await prisma.album.update({
        data: {
            is_deleted: true
        },
        where: {
            id: id
        },
    })
    res.status(200).json({
        success: true,
    })
})

router.post("/albums/:id/songs", upload.single("cover_image"), auth, admin, async (req, res) => {
    const id = parseInt(req.params.id)
    let { duration_seconds, label, cover_image, is_cover, ...body} = req.body
    if (req.file) {
        if (!req.file.mimetype.includes("image")) {
            return res.status(400).json({
                success: false,
                message: "Invalid file type"
            })
        }
        cover_image = req.file.path;
    }
    const labelData = await prisma.label.findFirst({
        where: {
            name: label
        },
        select: {
            id: true,
        }
    })
    const covers = await prisma.song.count({
        where: {
            album_id: id,
            is_cover: true
        }
    })
    if (covers === 3 && is_cover) {
        return res.status(400).json({
            success: false,
            message: "Too many covers provided"
        })
    }
    const song = await prisma.song.create({
        data: {
            ...body,
            duration_seconds: parseInt(duration_seconds),
            label: {
                connect: {
                    id: labelData.id
                }
            },
            is_cover: Boolean(is_cover),
            album_id: id,
            cover_image_url: cover_image,
        },
        select: {
            id: true,
            title: true,
            album_id: true,
            duration_seconds: true,
            lyrics: true,
            order: true,
            view_count: true,
            label: {
                select: {
                    name: true,
                }
            },
            is_cover: true,
            cover_image_url: true,
            created_at: true,
            updated_at: true,
        },
    })
    song.label = song.label.map(l => l.name)
    res.status(201).json({
        success: true,
        data: song
    })
})

router.post("/albums/:id/songs/order", auth, admin, async (req, res) => {
    let{ id} = req.params
    id = parseInt(id)
    const { song_ids } = req.body;
    await Promise.all(song_ids.map(async (s, i) => {
        await prisma.song.update({
            data: {
                order: i + 1
            },
            where: {
                id: s
            }
        })
    }))
    return res.status(200).json({
        success: true,
    })
})

router.post("/albums/:id/songs/:sid", upload.single("cover_image"), auth, admin, async (req, res) => {
    const id = parseInt(req.params.id)
    let { duration_seconds, label, cover_image, is_cover, ...body} = req.body
    if (req.file) {
        if (!req.file.mimetype.includes("image")) {
            return res.status(400).json({
                success: false,
                message: "Invalid file type"
            })
        }
        cover_image = req.file.path;
    }
    const labelData = await prisma.label.findFirst({
        where: {
            name: label
        },
        select: {
            id: true,
        }
    })
    const covers = await prisma.song.count({
        where: {
            album_id: id,
            is_cover: true
        }
    })
    if (covers === 3 && is_cover) {
        return res.status(400).json({
            success: false,
            message: "Too many covers provided"
        })
    }
    const song = await prisma.song.update({
        data: {
            ...body,
            duration_seconds: parseInt(duration_seconds),
            label: {
                connect: {
                    id: labelData.id
                }
            },
            is_cover: Boolean(is_cover),
            album_id: id,
            cover_image_url: cover_image,
        },
        where: {
            album_id: id,
            id: parseInt(req.params.sid)
        },
        select: {
            id: true,
            title: true,
            album_id: true,
            duration_seconds: true,
            lyrics: true,
            order: true,
            view_count: true,
            label: {
                select: {
                    name: true,
                }
            },
            is_cover: true,
            cover_image_url: true,
            created_at: true,
            updated_at: true,
        },
    })
    song.label = song.label.map(l => l.name)
    res.status(201).json({
        success: true,
        data: song
    })
})

router.delete("/albums/:id/songs/:sid", auth, admin, async (req, res) => {
    const id = parseInt(req.params.id)
    const sid = parseInt(req.params.sid)
    try {

    const album = await prisma.song.update({
        data: {
            is_deleted: true
        },
        where: {
            id: sid,
            album_id: id
        },
    })
    } catch (err) {
        res.status(404).json({
            success: false,
            message: "Not Found"
        })
    }
    res.status(200).json({
        success: true,
    })
})

router.all("/:any", (req, res) => {
    res.status(404).json({
        success: false,
        message: "Not Found"
    })
})


export { router as mainRouter }
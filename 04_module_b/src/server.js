import express from "express"
import cors from "cors"
import { mainRouter } from "./routers/mainRouter.js"

const app = express()

app.use(cors({
    origin: "*",
    methods: ["GET", "POST", "PUT", "DELETE"],
    credentials: true
}))
app.use(express.json())
app.use(express.urlencoded({ extended: false }))

app.set("view engine", "ejs")
app.set("views", "views/")

app.use("/04_module_b", mainRouter)

app.listen(4002, (req, res) => {
    console.log("http://localhost:4002/04_module_b")
})
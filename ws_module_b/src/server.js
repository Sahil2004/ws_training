import express from "express"
import cors from "cors"
import { mainRouter } from "./routers/mainRouter.js"

const app = express()

app.use(cors())
app.use(express.json())

app.use(express.urlencoded({ extended: false }))
app.set("view engine", "ejs")
app.set("views", "views/")

app.use("/ws_module_b", mainRouter)

app.listen(4001, (req, res) => {
    console.log("Live at: http://localhost:4001/ws_module_b")
})
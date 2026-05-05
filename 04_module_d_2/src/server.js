import express from "express"
import cors from "cors"
import { mainRouter } from "./mainRouter.js"

const app = express()
app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.set("view engine", "ejs")
app.set("views", "views/")
app.use("/css", express.static(process.cwd() + "/node_modules/bootstrap/dist/css/"))
app.use("/js", express.static(process.cwd() + "/node_modules/bootstrap/dist/js/"))
app.use("/public", express.static(process.cwd() + "/public"))

app.use("/04_module_d", mainRouter)

app.listen(4005, () => {
    console.log("http://localhost:4005/04_module_d")
})
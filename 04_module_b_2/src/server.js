import express from "express"
import cors from "cors"
import { mainRouter } from "./mainRouter.js"

const app = express()

app.use(express.urlencoded( { extended :false }))
app.use(express.json())

app.set("view engine", "ejs")
app.set("views", "views/")

app.use("/04_module_b/uploads", express.static("uploads/"))
app.use("/04_module_b", mainRouter)

app.listen(4003, () => {
    console.log("http://localhost:4003/04_module_b")
})
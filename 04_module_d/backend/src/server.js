import express from "express"
import cors from "cors"
import { mainRouter } from "./mainRouter.js"

const app = express()

app.use(cors({
    origin: "*",
    methods: ["GET", "POST"]
}))
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use("/04_module_d/api", mainRouter)
app.listen(4005, () => {
    console.log("http://localhost:4005/04_module_d/api")
})
import express from "express"
import cors from "cors"
import { mainRouter } from "./mainRouter.js"

const app = express()

app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: false }))

app.use("/wsa_module_c/api", mainRouter)

app.listen(4002, () => {
    console.log("http://localhost:4002/wsa_module_c")
})
const button = document.querySelector("button")
const inpt = document.querySelector("#pwd")

function toggle() {
    if (inpt.type === "password") {
        inpt.type = "text"
        button.innerText = "Hide"
    } else {
        inpt.type = "password"
        button.innerText = "Show"
    }
}
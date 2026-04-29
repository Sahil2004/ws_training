export const fields = {
    Company: [
        { name: "name", label: "Name", type: "text", required: true},
        { name: "address", label: "Address", type: "text", required: false },
        { name: "mobile", label: "Mobile", type: "tel", required: false },
        { name: "email", label: "Email", type: "email", required: true },
        { name: "ownerName", label: "Owner's Name", type: "text", required: true },
        { name: "ownerEmail", label: "Owner's Email", type: "email", required: true },
        { name: "ownerMobile", label: "Owner's Mobile", type: "tel", required: false },
        { name: "contactName", label: "Contact's Name", type: "text", required: true },
        { name: "contactEmail", label: "Contact's Email", type: "email", required: true },
        { name: "contactMobile", label: "Contact's Mobile", type: "tel", required: false },
    ]
}
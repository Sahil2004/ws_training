export const fields = {
    Company: [
        { name: "name", type: "text", required: true},
        { name: "email", type: "email", required: true},
        { name: "mobile", type: "tel", required: false},
        { name: "address", type: "text", required: false},
        { name: "ownerName", type: "text", required: true},
        { name: "ownerEmail", type: "email", required: true},
        { name: "ownerMobile", type: "tel", required: false},
        { name: "contactName", type: "text", required: true},
        { name: "contactEmail", type: "email", required: true},
        { name: "contactMobile", type: "tel", required: false},
        { name: "isDeactivated", type: "checkbox", required: false }
    ],
    Products: [
        { name: "image", type: "file", required: false },
        { name: "GTIN", type: "number", required: true},
        { name: "name", type: "text", required: true},
        { name: "nameFr", type: "text", required: true},
        { name: "description", type: "text", required: false},
        { name: "descriptionFr", type: "text", required: false},
        { name: "brand", type: "text", required: false},
        { name: "country", type: "text", required: false},
        { name: "grossWeight", type: "number", required: false},
        { name: "netWeight", type: "number", required: false},
        { name: "unit", type: "text", required: false},
        { name: "isHidden", type: "checkbox", required: false},
        { name: "companyId", type: "select", required: true},
    ]
}
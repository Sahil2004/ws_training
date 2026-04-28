export const schemas = {
    Company: [
        { name: "name", label: "Name", type: "text", required: true},
        { name: "address", label: "Address", type: "text", required: true},
        { name: "mobile", label: "Mobile", type: "tel", required: true},
        { name: "email", label: "Email", type: "email", required: true},
        { name: "ownerName", label: "Owner's Name", type: "text", required: true},
        { name: "ownerEmail", label: "Owner's Email", type: "email", required: true},
        { name: "ownerMobile", label: "Owner's Mobile", type: "tel", required: true},
        { name: "contactName", label: "Contact' Name", type: "text", required: true},
        { name: "contactEmail", label: "Contact's Email", type: "email", required: true},
        { name: "contactMobile", label: "Contact's Mobile", type: "tel", required: true},
    ],
    Product: [
        { name: "GTIN", label: "GTIN", type: "number", required: true, min: 13, max: 14},
        { name: "name", label: "Name", type: "text", required: true},
        { name: "nameFr", label: "Name (in French)", type: "text", required: false},
        { name: "description", label: "Description", type: "text", required: false},
        { name: "brand", label: "Brand", type: "text", required: false},
        { name: "country", label: "Country", type: "text", required: false},
        { name: "grossWeight", label: "Weight", type: "number", required: false },
        { name: "netWeight", label: "Net Weight", type: "number", required: false },
        { name: "unit", label: "Weight Unit", type: "text", required: false },
        { name: "image", label: "Image", type: "file", required: false },
    ]
}
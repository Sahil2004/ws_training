export const fields = {
    Company: [
        { name: "name", label: "Name", type: "text", required: true},
        { name: "address", label: "Address", type: "textarea", required: false },
        { name: "mobile", label: "Mobile", type: "tel", required: false },
        { name: "email", label: "Email", type: "email", required: true },
        { name: "ownerName", label: "Owner's Name", type: "text", required: true },
        { name: "ownerEmail", label: "Owner's Email", type: "email", required: true },
        { name: "ownerMobile", label: "Owner's Mobile", type: "tel", required: false },
        { name: "contactName", label: "Contact's Name", type: "text", required: true },
        { name: "contactEmail", label: "Contact's Email", type: "email", required: true },
        { name: "contactMobile", label: "Contact's Mobile", type: "tel", required: false },
    ],
    Products: [
        { name: "GTIN", label: "GTIN", type: "number", required: true},
        { name: "name", label: "Name", type: "text", required: true},
        { name: "nameFr", label: "Name (in French)", type: "text", required: true},
        { name: "description", label: "Description", type: "textarea", required: false},
        { name: "descriptionFr", label: "Description (in French)", type: "textarea", required: false},
        { name: "image", label: "Image", type: "file", required: false},
        { name: "brand", label: "Brand", type: "text", required: false},
        { name: "country", label: "Country", type: "text", required: false},
        { name: "grossWeight", label: "Gross Weight", type: "number", required: false},
        { name: "netWeight", label: "Net Weight", type: "number", required: false},
        { name: "unit", label: "Weight Unit", type: "text", required: false},
        { name: "company_id", label: "Company", type: "select", required: true }
    ]
}
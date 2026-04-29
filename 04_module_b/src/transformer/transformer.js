export const companyTransformer = (data) => {
    const transformer = (d) => ({
        id: d.id,
        name: d.name,
        address: d.address,
        email: d.email,
        mobile: d.mobile,
        ownerName: d.Owner.name,
        ownerMobile: d.Owner.mobile,
        ownerEmail: d.Owner.email,
        contactName: d.Contact.name,
        contactMobile: d.Contact.mobile,
        contactEmail: d.Contact.email
    })
    return Array.isArray(data) ? data.map(transformer) : transformer(data);
}

export const productsTransformer = (data) => {
    const transformer = (d) => ({
        id: d.GTIN,
        name: d.name,
        nameFr: d.nameFr,
        description: d.description,
        descriptionFr: d.descriptionFr,
        image: d.image,
        brand: d.brand,
        country: d.country,
        grossWeight: d.grossWeight,
        netWeight: d.netWeight,
        unit: d.unit,
    })
    return Array.isArray(data) ? data.map(transformer) : transformer(data);
}
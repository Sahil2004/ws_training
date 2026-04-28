export function companyTransformer(d) {
  if (Array.isArray(d)) {
    return d.map((data) => {
      return ({
      name: data.name,
      address: data.address,
      mobile: data.mobile,
      email: data.email,
      ownerName: data.Owner.name,
      ownerEmail: data.Owner.email,
      ownerMobile: data.Owner.mobile,
      contactName: data.Contact.name,
      contactEmail: data.Contact.email,
      contactMobile: data.Contact.mobile,
    })});
  } else {
    return {
      name: d.name,
      address: d.address,
      mobile: d.mobile,
      email: d.email,
      ownerName: d.Owner.name,
      ownerEmail: d.Owner.email,
      ownerMobile: d.Owner.mobile,
      contactName: d.Contact.name,
      contactEmail: d.Contact.email,
      contactMobile: d.Contact.mobile,
    };
  }
}

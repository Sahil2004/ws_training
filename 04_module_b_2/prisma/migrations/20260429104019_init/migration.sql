-- CreateTable
CREATE TABLE "Company" (
    "id" VARCHAR(36) NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "address" TEXT,
    "mobile" VARCHAR(12),
    "email" VARCHAR(100) NOT NULL,
    "ownerId" VARCHAR(36) NOT NULL,
    "contactId" VARCHAR(36) NOT NULL,
    "isDeactivated" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" VARCHAR(36) NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "mobile" VARCHAR(12),
    "email" VARCHAR(100) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Products" (
    "GTIN" BIGINT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "nameFr" VARCHAR(50) NOT NULL,
    "description" TEXT,
    "descriptionFr" TEXT,
    "brand" VARCHAR(20),
    "country" VARCHAR(20),
    "grossWeight" SMALLINT,
    "netWeight" SMALLINT,
    "unit" VARCHAR(10),
    "companyId" VARCHAR(36) NOT NULL,
    "isHidden" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Products_pkey" PRIMARY KEY ("GTIN")
);

-- CreateIndex
CREATE UNIQUE INDEX "Company_email_key" ON "Company"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "Products_GTIN_idx" ON "Products"("GTIN");

-- AddForeignKey
ALTER TABLE "Company" ADD CONSTRAINT "Company_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Company" ADD CONSTRAINT "Company_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products" ADD CONSTRAINT "Products_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- CreateTable
CREATE TABLE "Company" (
    "id" VARCHAR(36) NOT NULL,
    "name" VARCHAR(100),
    "address" TEXT,
    "mobile" VARCHAR(12),
    "email" VARCHAR(150) NOT NULL,
    "isDeactivated" BOOLEAN NOT NULL DEFAULT false,
    "ownerId" VARCHAR(36) NOT NULL,
    "contactId" VARCHAR(35) NOT NULL,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" VARCHAR(36) NOT NULL,
    "name" VARCHAR(100),
    "mobile" VARCHAR(12),
    "email" VARCHAR(150) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Products" (
    "GTIN" VARCHAR(14) NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "nameFr" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "descriptionFr" TEXT,
    "images" VARCHAR(100),
    "brand" VARCHAR(50),
    "country" VARCHAR(50),
    "grossWeight" SMALLINT,
    "netWeight" SMALLINT,
    "unit" VARCHAR(10),

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

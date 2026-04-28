-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "mobile" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Company" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT,
    "mobile" TEXT,
    "email" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "contactId" TEXT NOT NULL,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "GTIN" BIGINT NOT NULL,
    "name" TEXT NOT NULL,
    "nameFr" TEXT NOT NULL,
    "description" TEXT,
    "descriptionFr" TEXT,
    "brand" TEXT,
    "country" TEXT,
    "grossWeight" INTEGER,
    "netWeight" INTEGER,
    "unit" TEXT,
    "image" TEXT,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("GTIN")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Company_email_key" ON "Company"("email");

-- CreateIndex
CREATE INDEX "Product_GTIN_idx" ON "Product"("GTIN");

-- AddForeignKey
ALTER TABLE "Company" ADD CONSTRAINT "Company_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Company" ADD CONSTRAINT "Company_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

/*
  Warnings:

  - The primary key for the `Products` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Changed the type of `GTIN` on the `Products` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "Products" DROP CONSTRAINT "Products_pkey",
DROP COLUMN "GTIN",
ADD COLUMN     "GTIN" BIGINT NOT NULL,
ADD CONSTRAINT "Products_pkey" PRIMARY KEY ("GTIN");

-- CreateIndex
CREATE INDEX "Products_GTIN_idx" ON "Products"("GTIN");

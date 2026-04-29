/*
  Warnings:

  - Added the required column `company_id` to the `Products` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Products" ADD COLUMN     "company_id" VARCHAR(36) NOT NULL,
ADD COLUMN     "isHidden" BOOLEAN NOT NULL DEFAULT false;

-- AddForeignKey
ALTER TABLE "Products" ADD CONSTRAINT "Products_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "Company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

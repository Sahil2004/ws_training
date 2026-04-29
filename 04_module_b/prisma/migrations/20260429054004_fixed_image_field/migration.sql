/*
  Warnings:

  - You are about to drop the column `images` on the `Products` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Products" DROP COLUMN "images",
ADD COLUMN     "image" VARCHAR(100);

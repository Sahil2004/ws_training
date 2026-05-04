/*
  Warnings:

  - You are about to drop the column `category_id` on the `Info_items` table. All the data in the column will be lost.
  - You are about to drop the `Category` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Info_items" DROP CONSTRAINT "Info_items_category_id_fkey";

-- AlterTable
ALTER TABLE "Info_items" DROP COLUMN "category_id",
ADD COLUMN     "category" VARCHAR(14);

-- DropTable
DROP TABLE "Category";

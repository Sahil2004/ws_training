/*
  Warnings:

  - The primary key for the `Info_items` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Info_items` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "Info_items" DROP CONSTRAINT "Info_items_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SMALLSERIAL NOT NULL,
ADD CONSTRAINT "Info_items_pkey" PRIMARY KEY ("id");

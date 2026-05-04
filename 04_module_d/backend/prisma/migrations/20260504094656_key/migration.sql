/*
  Warnings:

  - The primary key for the `Attraction` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Attraction` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Region` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Region` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Changed the type of `region_id` on the `Attraction` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "Attraction" DROP CONSTRAINT "Attraction_region_id_fkey";

-- AlterTable
ALTER TABLE "Attraction" DROP CONSTRAINT "Attraction_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SMALLSERIAL NOT NULL,
DROP COLUMN "region_id",
ADD COLUMN     "region_id" SMALLINT NOT NULL,
ADD CONSTRAINT "Attraction_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Region" DROP CONSTRAINT "Region_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SMALLSERIAL NOT NULL,
ADD CONSTRAINT "Region_pkey" PRIMARY KEY ("id");

-- AddForeignKey
ALTER TABLE "Attraction" ADD CONSTRAINT "Attraction_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "Region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- DropForeignKey
ALTER TABLE "Company" DROP CONSTRAINT "Company_contactId_fkey";

-- AlterTable
ALTER TABLE "Company" ALTER COLUMN "contactId" SET DATA TYPE VARCHAR(36);

-- AddForeignKey
ALTER TABLE "Company" ADD CONSTRAINT "Company_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

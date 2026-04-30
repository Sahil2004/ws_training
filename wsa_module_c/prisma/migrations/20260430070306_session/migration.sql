-- CreateTable
CREATE TABLE "Session" (
    "token" TEXT NOT NULL,
    "user_id" SMALLINT NOT NULL,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("token")
);

-- CreateIndex
CREATE UNIQUE INDEX "Session_user_id_key" ON "Session"("user_id");

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

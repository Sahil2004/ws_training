-- CreateTable
CREATE TABLE "User" (
    "id" SMALLSERIAL NOT NULL,
    "username" VARCHAR(50) NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "password" VARCHAR(20) NOT NULL,
    "role" VARCHAR(5) NOT NULL DEFAULT 'user',
    "is_banned" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Label" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(10) NOT NULL,

    CONSTRAINT "Label_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Album" (
    "id" SMALLSERIAL NOT NULL,
    "title" VARCHAR(50) NOT NULL,
    "artist" VARCHAR(50) NOT NULL,
    "release_year" SMALLINT NOT NULL,
    "genre" VARCHAR(30) NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "publisher_id" SMALLINT NOT NULL,

    CONSTRAINT "Album_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Song" (
    "id" SMALLSERIAL NOT NULL,
    "title" VARCHAR(50) NOT NULL,
    "album_id" SMALLINT NOT NULL,
    "duration_seconds" SMALLINT NOT NULL,
    "order" SMALLSERIAL NOT NULL,
    "is_cover" BOOLEAN NOT NULL DEFAULT false,
    "cover_image_url" VARCHAR(20) NOT NULL,
    "view_count" SMALLINT NOT NULL DEFAULT 1,
    "lyrics" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Song_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_LabelToSong" (
    "A" SMALLINT NOT NULL,
    "B" SMALLINT NOT NULL,

    CONSTRAINT "_LabelToSong_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "_LabelToSong_B_index" ON "_LabelToSong"("B");

-- AddForeignKey
ALTER TABLE "Album" ADD CONSTRAINT "Album_publisher_id_fkey" FOREIGN KEY ("publisher_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Song" ADD CONSTRAINT "Song_album_id_fkey" FOREIGN KEY ("album_id") REFERENCES "Album"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_LabelToSong" ADD CONSTRAINT "_LabelToSong_A_fkey" FOREIGN KEY ("A") REFERENCES "Label"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_LabelToSong" ADD CONSTRAINT "_LabelToSong_B_fkey" FOREIGN KEY ("B") REFERENCES "Song"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- CreateTable
CREATE TABLE "Regions" (
    "id" SMALLSERIAL NOT NULL,
    "key" VARCHAR(7) NOT NULL,
    "name" VARCHAR(7) NOT NULL,
    "color" VARCHAR(9) NOT NULL,
    "summary" TEXT,

    CONSTRAINT "Regions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Attractions" (
    "id" SMALLSERIAL NOT NULL,
    "region_id" SMALLINT NOT NULL,
    "name" VARCHAR(20),
    "description" VARCHAR(100),

    CONSTRAINT "Attractions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Submissions" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "country" VARCHAR(20),
    "interests" VARCHAR(20),
    "message" TEXT NOT NULL,
    "submitted_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Submissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Info_items" (
    "id" SMALLSERIAL NOT NULL,
    "category" VARCHAR(14) NOT NULL,
    "icon" VARCHAR(20) NOT NULL,
    "title" VARCHAR(50) NOT NULL,
    "body" TEXT NOT NULL,

    CONSTRAINT "Info_items_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Attractions" ADD CONSTRAINT "Attractions_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "Regions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

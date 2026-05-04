-- CreateTable
CREATE TABLE "Region" (
    "id" VARCHAR(36) NOT NULL,
    "key" VARCHAR(7) NOT NULL,
    "name" VARCHAR(10) NOT NULL,
    "color" TEXT NOT NULL,
    "summary" TEXT,

    CONSTRAINT "Region_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Attraction" (
    "id" VARCHAR(36) NOT NULL,
    "region_id" VARCHAR(36) NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,

    CONSTRAINT "Attraction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" VARCHAR(36) NOT NULL,
    "label" VARCHAR(14) NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Info_items" (
    "id" VARCHAR(36) NOT NULL,
    "category_id" VARCHAR(36) NOT NULL,
    "icon" TEXT,
    "title" VARCHAR(50),
    "body" TEXT,

    CONSTRAINT "Info_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Submission" (
    "id" VARCHAR(36) NOT NULL,
    "name" VARCHAR(80),
    "email" VARCHAR(100),
    "country" VARCHAR(20),
    "interests" TEXT,
    "message" TEXT,
    "submitted_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Submission_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Attraction" ADD CONSTRAINT "Attraction_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "Region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Info_items" ADD CONSTRAINT "Info_items_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

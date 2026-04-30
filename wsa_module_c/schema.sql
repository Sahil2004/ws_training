-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

-- DROP SEQUENCE public."Album_id_seq";

CREATE SEQUENCE public."Album_id_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 32767
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."Label_id_seq";

CREATE SEQUENCE public."Label_id_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 32767
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."Song_id_seq";

CREATE SEQUENCE public."Song_id_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 32767
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."Song_order_seq";

CREATE SEQUENCE public."Song_order_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 32767
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."User_id_seq";

CREATE SEQUENCE public."User_id_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 32767
	START 1
	CACHE 1
	NO CYCLE;-- public."Label" definition

-- Drop table

-- DROP TABLE public."Label";

CREATE TABLE public."Label" (
	id smallserial NOT NULL,
	"name" varchar(10) NOT NULL,
	CONSTRAINT "Label_pkey" PRIMARY KEY (id)
);


-- public."User" definition

-- Drop table

-- DROP TABLE public."User";

CREATE TABLE public."User" (
	id smallserial NOT NULL,
	username varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	"password" varchar(20) NOT NULL,
	"role" varchar(5) DEFAULT 'user'::character varying NOT NULL,
	is_banned bool DEFAULT false NOT NULL,
	created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT "User_pkey" PRIMARY KEY (id)
);
CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);
CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


-- public._prisma_migrations definition

-- Drop table

-- DROP TABLE public._prisma_migrations;

CREATE TABLE public._prisma_migrations (
	id varchar(36) NOT NULL,
	checksum varchar(64) NOT NULL,
	finished_at timestamptz NULL,
	migration_name varchar(255) NOT NULL,
	logs text NULL,
	rolled_back_at timestamptz NULL,
	started_at timestamptz DEFAULT now() NOT NULL,
	applied_steps_count int4 DEFAULT 0 NOT NULL,
	CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id)
);


-- public."Album" definition

-- Drop table

-- DROP TABLE public."Album";

CREATE TABLE public."Album" (
	id smallserial NOT NULL,
	title varchar(50) NOT NULL,
	artist varchar(50) NOT NULL,
	release_year int2 NOT NULL,
	genre varchar(30) NOT NULL,
	description text NULL,
	created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	publisher_id int2 NOT NULL,
	is_deleted bool DEFAULT false NOT NULL,
	CONSTRAINT "Album_pkey" PRIMARY KEY (id),
	CONSTRAINT "Album_publisher_id_fkey" FOREIGN KEY (publisher_id) REFERENCES public."User"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- public."Session" definition

-- Drop table

-- DROP TABLE public."Session";

CREATE TABLE public."Session" (
	"token" text NOT NULL,
	user_id int2 NOT NULL,
	CONSTRAINT "Session_pkey" PRIMARY KEY (token),
	CONSTRAINT "Session_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE UNIQUE INDEX "Session_user_id_key" ON public."Session" USING btree (user_id);


-- public."Song" definition

-- Drop table

-- DROP TABLE public."Song";

CREATE TABLE public."Song" (
	id smallserial NOT NULL,
	title varchar(50) NOT NULL,
	album_id int2 NOT NULL,
	duration_seconds int2 NOT NULL,
	"order" smallserial NOT NULL,
	is_cover bool DEFAULT false NOT NULL,
	cover_image_url varchar(100) NOT NULL,
	view_count int2 DEFAULT 1 NOT NULL,
	lyrics text NULL,
	created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	is_deleted bool DEFAULT false NOT NULL,
	CONSTRAINT "Song_pkey" PRIMARY KEY (id),
	CONSTRAINT "Song_album_id_fkey" FOREIGN KEY (album_id) REFERENCES public."Album"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- public."_LabelToSong" definition

-- Drop table

-- DROP TABLE public."_LabelToSong";

CREATE TABLE public."_LabelToSong" (
	"A" int2 NOT NULL,
	"B" int2 NOT NULL,
	CONSTRAINT "_LabelToSong_AB_pkey" PRIMARY KEY ("A", "B"),
	CONSTRAINT "_LabelToSong_A_fkey" FOREIGN KEY ("A") REFERENCES public."Label"(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT "_LabelToSong_B_fkey" FOREIGN KEY ("B") REFERENCES public."Song"(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX "_LabelToSong_B_index" ON public."_LabelToSong" USING btree ("B");
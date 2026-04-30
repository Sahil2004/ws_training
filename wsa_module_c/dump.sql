--
-- PostgreSQL database dump
--

\restrict kK9rDDB6GQXVO91VhEhhLGteBAPbGuBgdUhFEaIzmyapFRKZ6dmEmRotPyDWoSk

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-04-30 19:06:12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE wsa_module_c;
--
-- TOC entry 4989 (class 1262 OID 24576)
-- Name: wsa_module_c; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE wsa_module_c WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE wsa_module_c OWNER TO postgres;

\unrestrict kK9rDDB6GQXVO91VhEhhLGteBAPbGuBgdUhFEaIzmyapFRKZ6dmEmRotPyDWoSk
\connect wsa_module_c
\restrict kK9rDDB6GQXVO91VhEhhLGteBAPbGuBgdUhFEaIzmyapFRKZ6dmEmRotPyDWoSk

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 225 (class 1259 OID 24621)
-- Name: Album; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Album" (
    id smallint NOT NULL,
    title character varying(50) NOT NULL,
    artist character varying(50) NOT NULL,
    release_year smallint NOT NULL,
    genre character varying(30) NOT NULL,
    description text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    publisher_id smallint NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Album" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24620)
-- Name: Album_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Album_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Album_id_seq" OWNER TO postgres;

--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 224
-- Name: Album_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Album_id_seq" OWNED BY public."Album".id;


--
-- TOC entry 223 (class 1259 OID 24612)
-- Name: Label; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Label" (
    id smallint NOT NULL,
    name character varying(10) NOT NULL
);


ALTER TABLE public."Label" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24611)
-- Name: Label_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Label_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Label_id_seq" OWNER TO postgres;

--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 222
-- Name: Label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Label_id_seq" OWNED BY public."Label".id;


--
-- TOC entry 230 (class 1259 OID 25101)
-- Name: Session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Session" (
    token text NOT NULL,
    user_id smallint NOT NULL
);


ALTER TABLE public."Session" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24640)
-- Name: Song; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Song" (
    id smallint NOT NULL,
    title character varying(50) NOT NULL,
    album_id smallint NOT NULL,
    duration_seconds smallint NOT NULL,
    "order" smallint NOT NULL,
    is_cover boolean DEFAULT false NOT NULL,
    cover_image_url character varying(100) NOT NULL,
    view_count smallint DEFAULT 1 NOT NULL,
    lyrics text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Song" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24638)
-- Name: Song_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Song_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Song_id_seq" OWNER TO postgres;

--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 226
-- Name: Song_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Song_id_seq" OWNED BY public."Song".id;


--
-- TOC entry 227 (class 1259 OID 24639)
-- Name: Song_order_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Song_order_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Song_order_seq" OWNER TO postgres;

--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 227
-- Name: Song_order_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Song_order_seq" OWNED BY public."Song"."order";


--
-- TOC entry 221 (class 1259 OID 24594)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id smallint NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(20) NOT NULL,
    role character varying(5) DEFAULT 'user'::character varying NOT NULL,
    is_banned boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24593)
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 220
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- TOC entry 229 (class 1259 OID 24662)
-- Name: _LabelToSong; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_LabelToSong" (
    "A" smallint NOT NULL,
    "B" smallint NOT NULL
);


ALTER TABLE public."_LabelToSong" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24579)
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- TOC entry 4791 (class 2604 OID 24624)
-- Name: Album id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Album" ALTER COLUMN id SET DEFAULT nextval('public."Album_id_seq"'::regclass);


--
-- TOC entry 4790 (class 2604 OID 24615)
-- Name: Label id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Label" ALTER COLUMN id SET DEFAULT nextval('public."Label_id_seq"'::regclass);


--
-- TOC entry 4795 (class 2604 OID 24643)
-- Name: Song id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Song" ALTER COLUMN id SET DEFAULT nextval('public."Song_id_seq"'::regclass);


--
-- TOC entry 4796 (class 2604 OID 24644)
-- Name: Song order; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Song" ALTER COLUMN "order" SET DEFAULT nextval('public."Song_order_seq"'::regclass);


--
-- TOC entry 4785 (class 2604 OID 24597)
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- TOC entry 4978 (class 0 OID 24621)
-- Dependencies: 225
-- Data for Name: Album; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Album" VALUES (1, 'one', 'a', 2021, 'Rock', 'lol', '2026-04-30 10:02:01.669', '2026-04-30 10:02:01.669', 1, false);
INSERT INTO public."Album" VALUES (2, 'lol', 'a', 2022, 'Pop', 'Somerthing', '2026-04-30 10:04:24.785', '2026-04-30 10:16:45.349', 1, true);


--
-- TOC entry 4976 (class 0 OID 24612)
-- Dependencies: 223
-- Data for Name: Label; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Label" VALUES (1, 'Pop');
INSERT INTO public."Label" VALUES (2, 'Rock');
INSERT INTO public."Label" VALUES (3, 'Hip-Hop');
INSERT INTO public."Label" VALUES (4, 'Electronic');
INSERT INTO public."Label" VALUES (5, 'Jazz');
INSERT INTO public."Label" VALUES (6, 'Classical');
INSERT INTO public."Label" VALUES (7, 'Chill');
INSERT INTO public."Label" VALUES (8, 'Country');


--
-- TOC entry 4983 (class 0 OID 25101)
-- Dependencies: 230
-- Data for Name: Session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Session" VALUES ('d2ce28b9a7fd7e4407e2b0fd499b7fe4', 1);


--
-- TOC entry 4981 (class 0 OID 24640)
-- Dependencies: 228
-- Data for Name: Song; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Song" VALUES (1, 't', 1, 22, 2, true, 'uploads\71144e702f3c3621d188f167905fb652', 1, 'Lol', '2026-04-30 12:25:05.557', '2026-04-30 12:40:14.201', false);
INSERT INTO public."Song" VALUES (2, 't', 1, 22, 1, true, 'uploads\250a4b212ae80ba84d58ef7eb562189e', 1, 'Lol', '2026-04-30 12:32:19.766', '2026-04-30 12:43:34.998', true);


--
-- TOC entry 4974 (class 0 OID 24594)
-- Dependencies: 221
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User" VALUES (1, 'admin', 'admin@web.wsa', 'adminpass', 'admin', false, '2026-04-30 12:23:32.349', '2026-04-30 12:23:32.349');
INSERT INTO public."User" VALUES (5, 'sahil', 's@s.com', 'sahilpass', 'user', false, '2026-04-30 07:20:03.522', '2026-04-30 07:20:03.522');
INSERT INTO public."User" VALUES (3, 'user2', 'user2@web.wsa', 'user2pass', 'admin', false, '2026-04-30 12:27:23.45', '2026-04-30 09:49:13.839');
INSERT INTO public."User" VALUES (2, 'user1', 'user1@web.wsa', 'user1pass', 'user', false, '2026-04-30 12:25:30.599', '2026-04-30 09:53:02.775');


--
-- TOC entry 4982 (class 0 OID 24662)
-- Dependencies: 229
-- Data for Name: _LabelToSong; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."_LabelToSong" VALUES (2, 1);
INSERT INTO public."_LabelToSong" VALUES (2, 2);


--
-- TOC entry 4972 (class 0 OID 24579)
-- Dependencies: 219
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public._prisma_migrations VALUES ('9970ca16-ca67-46ab-8f4e-936a1dc3263b', '08e483a9ad13c6202a920a2ee27d9024efdbf3b288ba9fd36bdf12112b34ca61', '2026-04-30 12:16:50.874409+05:30', '20260430064650_init', NULL, NULL, '2026-04-30 12:16:50.81434+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('0eecc922-9947-4e39-a107-f3417fd68146', '4f89184f671c45cdf439db43845878639c3a6e47b4a7dc14249d9c725ee8aa1b', '2026-04-30 12:21:11.226294+05:30', '20260430065111_fix_update', NULL, NULL, '2026-04-30 12:21:11.212014+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('2e417811-5700-41cd-831e-be13ce348028', '09ea08e7143fd0ddf7c591729850fbc25355937616ffd14e22f3ea4485de5b4e', '2026-04-30 12:33:06.933855+05:30', '20260430070306_session', NULL, NULL, '2026-04-30 12:33:06.878764+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('3b62d8d5-1b04-44e8-bdda-02f7153cdc72', '64a7926821044d55c359006d4fc1f8c7aac58ee7f2a00a71ea8d79facafe559b', '2026-04-30 15:37:23.961692+05:30', '20260430100723_soft_delete_album', NULL, NULL, '2026-04-30 15:37:23.950578+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('67f2f8f0-c6a4-4e96-af63-fc8d27faebf1', '5cf5aa17eaf57a17ab5f3cd0f4fc77eb478a765ad154e970cf1324ad03927823', '2026-04-30 15:45:06.641486+05:30', '20260430101506_soft_delete_songs', NULL, NULL, '2026-04-30 15:45:06.627021+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('7bd65988-a850-46bc-8782-0f499a2d33f6', '00ee30ad598c565b5a6690d2058d1ba4f31d0b643704fab83ced771ec246bacf', '2026-04-30 17:54:44.441976+05:30', '20260430122444_cover_image_size', NULL, NULL, '2026-04-30 17:54:44.404068+05:30', 1);


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 224
-- Name: Album_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Album_id_seq"', 2, true);


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 222
-- Name: Label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Label_id_seq"', 8, true);


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 226
-- Name: Song_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Song_id_seq"', 2, true);


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 227
-- Name: Song_order_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Song_order_seq"', 2, true);


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 220
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 5, true);


--
-- TOC entry 4811 (class 2606 OID 24637)
-- Name: Album Album_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Album"
    ADD CONSTRAINT "Album_pkey" PRIMARY KEY (id);


--
-- TOC entry 4809 (class 2606 OID 24619)
-- Name: Label Label_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Label"
    ADD CONSTRAINT "Label_pkey" PRIMARY KEY (id);


--
-- TOC entry 4818 (class 2606 OID 25109)
-- Name: Session Session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_pkey" PRIMARY KEY (token);


--
-- TOC entry 4813 (class 2606 OID 24661)
-- Name: Song Song_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Song"
    ADD CONSTRAINT "Song_pkey" PRIMARY KEY (id);


--
-- TOC entry 4806 (class 2606 OID 24610)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 4815 (class 2606 OID 24668)
-- Name: _LabelToSong _LabelToSong_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_LabelToSong"
    ADD CONSTRAINT "_LabelToSong_AB_pkey" PRIMARY KEY ("A", "B");


--
-- TOC entry 4803 (class 2606 OID 24592)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4819 (class 1259 OID 25110)
-- Name: Session_user_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Session_user_id_key" ON public."Session" USING btree (user_id);


--
-- TOC entry 4804 (class 1259 OID 24670)
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- TOC entry 4807 (class 1259 OID 24669)
-- Name: User_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


--
-- TOC entry 4816 (class 1259 OID 24671)
-- Name: _LabelToSong_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_LabelToSong_B_index" ON public."_LabelToSong" USING btree ("B");


--
-- TOC entry 4820 (class 2606 OID 24672)
-- Name: Album Album_publisher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Album"
    ADD CONSTRAINT "Album_publisher_id_fkey" FOREIGN KEY (publisher_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4824 (class 2606 OID 25111)
-- Name: Session Session_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4821 (class 2606 OID 24677)
-- Name: Song Song_album_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Song"
    ADD CONSTRAINT "Song_album_id_fkey" FOREIGN KEY (album_id) REFERENCES public."Album"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4822 (class 2606 OID 24682)
-- Name: _LabelToSong _LabelToSong_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_LabelToSong"
    ADD CONSTRAINT "_LabelToSong_A_fkey" FOREIGN KEY ("A") REFERENCES public."Label"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4823 (class 2606 OID 24687)
-- Name: _LabelToSong _LabelToSong_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_LabelToSong"
    ADD CONSTRAINT "_LabelToSong_B_fkey" FOREIGN KEY ("B") REFERENCES public."Song"(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2026-04-30 19:06:12

--
-- PostgreSQL database dump complete
--

\unrestrict kK9rDDB6GQXVO91VhEhhLGteBAPbGuBgdUhFEaIzmyapFRKZ6dmEmRotPyDWoSk


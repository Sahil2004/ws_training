--
-- PostgreSQL database dump
--

\restrict Xu4peTOAq5m3MdebHI86vPNHAbveQTNvY87icgOgjMoveMzrDHCFHdB4Q2FgM0D

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-05-04 15:22:01

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

DROP DATABASE "04_module_d";
--
-- TOC entry 4955 (class 1262 OID 32768)
-- Name: 04_module_d; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "04_module_d" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE "04_module_d" OWNER TO postgres;

\unrestrict Xu4peTOAq5m3MdebHI86vPNHAbveQTNvY87icgOgjMoveMzrDHCFHdB4Q2FgM0D
\connect "04_module_d"
\restrict Xu4peTOAq5m3MdebHI86vPNHAbveQTNvY87icgOgjMoveMzrDHCFHdB4Q2FgM0D

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

--
-- TOC entry 5 (class 2615 OID 33158)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 33184)
-- Name: Attraction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Attraction" (
    name character varying(100) NOT NULL,
    description text,
    id smallint NOT NULL,
    region_id smallint NOT NULL
);


ALTER TABLE public."Attraction" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 33230)
-- Name: Attraction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Attraction_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Attraction_id_seq" OWNER TO postgres;

--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 224
-- Name: Attraction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Attraction_id_seq" OWNED BY public."Attraction".id;


--
-- TOC entry 222 (class 1259 OID 33201)
-- Name: Info_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Info_items" (
    icon text,
    title character varying(50),
    body text,
    id smallint NOT NULL,
    category character varying(14)
);


ALTER TABLE public."Info_items" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 33430)
-- Name: Info_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Info_items_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Info_items_id_seq" OWNER TO postgres;

--
-- TOC entry 4959 (class 0 OID 0)
-- Dependencies: 226
-- Name: Info_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Info_items_id_seq" OWNED BY public."Info_items".id;


--
-- TOC entry 220 (class 1259 OID 33173)
-- Name: Region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Region" (
    key character varying(7) NOT NULL,
    name character varying(10) NOT NULL,
    color text NOT NULL,
    summary text,
    id smallint NOT NULL
);


ALTER TABLE public."Region" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 33242)
-- Name: Region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Region_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Region_id_seq" OWNER TO postgres;

--
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 225
-- Name: Region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Region_id_seq" OWNED BY public."Region".id;


--
-- TOC entry 223 (class 1259 OID 33210)
-- Name: Submission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Submission" (
    id character varying(36) NOT NULL,
    name character varying(80),
    email character varying(100),
    country character varying(20),
    interests text,
    message text,
    submitted_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Submission" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 33159)
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
-- TOC entry 227 (class 1259 OID 33636)
-- Name: info_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.info_items (
    id integer,
    category character varying(50),
    icon character varying(50),
    title character varying(50),
    body character varying(128)
);


ALTER TABLE public.info_items OWNER TO postgres;

--
-- TOC entry 4780 (class 2604 OID 33231)
-- Name: Attraction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Attraction" ALTER COLUMN id SET DEFAULT nextval('public."Attraction_id_seq"'::regclass);


--
-- TOC entry 4781 (class 2604 OID 33431)
-- Name: Info_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Info_items" ALTER COLUMN id SET DEFAULT nextval('public."Info_items_id_seq"'::regclass);


--
-- TOC entry 4779 (class 2604 OID 33243)
-- Name: Region id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Region" ALTER COLUMN id SET DEFAULT nextval('public."Region_id_seq"'::regclass);


--
-- TOC entry 4943 (class 0 OID 33184)
-- Dependencies: 221
-- Data for Name: Attraction; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Attraction" VALUES ('Taipei 101', 'Skyscraper views & luxury mall', 1, 1);
INSERT INTO public."Attraction" VALUES ('Jiufen', 'Hillside lantern alleys & tea houses', 2, 1);
INSERT INTO public."Attraction" VALUES ('Yehliu Geopark', 'Otherworldly sea-eroded rock formations', 3, 1);
INSERT INTO public."Attraction" VALUES ('Sun Moon Lake', 'Scenic cycling & boat tours', 4, 2);
INSERT INTO public."Attraction" VALUES ('Taichung', 'Museums, parks & creative parks', 5, 2);
INSERT INTO public."Attraction" VALUES ('Alishan', 'Tea terraces & sunrise sea of clouds', 6, 2);
INSERT INTO public."Attraction" VALUES ('Tainan', 'Taiwan''s oldest city & street eats', 7, 3);
INSERT INTO public."Attraction" VALUES ('Kaohsiung', 'Pier-2 Art Center & harbor views', 8, 3);
INSERT INTO public."Attraction" VALUES ('Kenting', 'White-sand beaches & water sports', 9, 3);
INSERT INTO public."Attraction" VALUES ('Taroko Gorge', 'Marble canyons & sky-high trails', 10, 4);
INSERT INTO public."Attraction" VALUES ('Hualien', 'Pacific coastlines & rice paddies', 11, 4);
INSERT INTO public."Attraction" VALUES ('Taitung', 'Hot springs & laid-back festivals', 12, 4);


--
-- TOC entry 4944 (class 0 OID 33201)
-- Dependencies: 222
-- Data for Name: Info_items; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4942 (class 0 OID 33173)
-- Dependencies: 220
-- Data for Name: Region; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Region" VALUES ('north', 'North', '#22c55e', 'Urban energy & nature: Taipei 101, night markets, Jiufen''s old streets, Yehliu''s unique geology.', 1);
INSERT INTO public."Region" VALUES ('central', 'Central', '#06b6d4', 'Misty mountains & lakes: Sun Moon Lake cycling, Taichung art, Alishan sunrise forests.', 2);
INSERT INTO public."Region" VALUES ('south', 'South', '#f97316', 'Historic flavors & beaches: Tainan temples, Kaohsiung harbor art, Kenting''s tropical coast.', 3);
INSERT INTO public."Region" VALUES ('east', 'East', '#8b5cf6', 'Wild coasts & gorges: Taroko marble cliffs, Hualien ocean vistas, Taitung hot air vibes.', 4);


--
-- TOC entry 4945 (class 0 OID 33210)
-- Dependencies: 223
-- Data for Name: Submission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Submission" VALUES ('dbb10e0c-4ec6-4e10-b069-7d8025de8899', 'Sahil', 's@s.com', 'India', 'Cycling', 'Some message.', '2026-05-04 09:51:23.267');


--
-- TOC entry 4941 (class 0 OID 33159)
-- Dependencies: 219
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public._prisma_migrations VALUES ('3fabee30-105b-40df-8fe2-26c3ca1578c2', 'cf0b6afb0758dc1c8915a29c1ecef6ebb493dca97d0c343e775d38d83039c512', '2026-05-04 15:18:38.385474+05:30', '20260504063556_init', NULL, NULL, '2026-05-04 15:18:38.359794+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('f0872b8e-71e8-4adb-b84a-255c44c6e0f6', '9b822385e9a83ff40b1f3e1403998920c3f5c1f0f182070862fdc44a654ccbe6', '2026-05-04 15:18:38.409102+05:30', '20260504094656_key', NULL, NULL, '2026-05-04 15:18:38.38626+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('2cc4c4d5-7413-478c-a528-19e52f6451b2', '2f4a7c1d53f7424bb65a9656075ac6dfb6e6a554f80ab4f5542e4510c8e2f696', '2026-05-04 15:18:46.366185+05:30', '20260504094846_keys', NULL, NULL, '2026-05-04 15:18:46.293429+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('3ae6e193-469a-4514-9287-d7ecff5150e8', '7c04a439847ed74cfe82867bb3aecd8101c5b610bea1d25dbcadfa1d2216459c', '2026-05-04 15:20:10.081374+05:30', '20260504095010_fix', NULL, NULL, '2026-05-04 15:20:10.07214+05:30', 1);


--
-- TOC entry 4949 (class 0 OID 33636)
-- Dependencies: 227
-- Data for Name: info_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.info_items VALUES (1, 'transportation', '#i-train', 'High-Speed Rail (HSR)', 'Zip between major cities from Taipei to Kaohsiung in ~1.5–2 hours. Reserve seats online or at kiosks.');
INSERT INTO public.info_items VALUES (2, 'transportation', '#i-landmark', 'TRA & Local Lines', 'Coastal and mountain routes cover smaller towns. EasyCard works on most services.');
INSERT INTO public.info_items VALUES (3, 'transportation', '#i-pin', 'Metro & Buses', 'Taipei/Kaohsiung MRT are bilingual and spotless. Bus networks are extensive and affordable.');
INSERT INTO public.info_items VALUES (4, 'accommodation', '#i-hotel', 'Hotels & Hostels', 'From luxury towers to design hostels—book early for weekends & festivals.');
INSERT INTO public.info_items VALUES (5, 'accommodation', '#i-landmark', 'Minshuku (B&B)', 'Warm, family-run stays—especially common on the East Coast.');
INSERT INTO public.info_items VALUES (6, 'accommodation', '#i-pin', 'Hot Spring Resorts', 'Soak in Beitou, Jiaoxi or mountainside retreats across the island.');
INSERT INTO public.info_items VALUES (7, 'shopping', '#i-bag', 'Night Markets', 'Try snacks as you browse souvenirs—remember to bring small bills.');
INSERT INTO public.info_items VALUES (8, 'shopping', '#i-utensils', 'Gourmet Gifts', 'Pineapple cakes, nougat, oolong teas—pack for customs.');
INSERT INTO public.info_items VALUES (9, 'shopping', '#i-globe', 'Tax Refund', 'Foreign visitors can claim VAT refunds—check store windows for the logo.');


--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 224
-- Name: Attraction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Attraction_id_seq"', 1, false);


--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 226
-- Name: Info_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Info_items_id_seq"', 1, false);


--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 225
-- Name: Region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Region_id_seq"', 1, false);


--
-- TOC entry 4788 (class 2606 OID 33235)
-- Name: Attraction Attraction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Attraction"
    ADD CONSTRAINT "Attraction_pkey" PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 33434)
-- Name: Info_items Info_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Info_items"
    ADD CONSTRAINT "Info_items_pkey" PRIMARY KEY (id);


--
-- TOC entry 4786 (class 2606 OID 33246)
-- Name: Region Region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Region"
    ADD CONSTRAINT "Region_pkey" PRIMARY KEY (id);


--
-- TOC entry 4792 (class 2606 OID 33219)
-- Name: Submission Submission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submission"
    ADD CONSTRAINT "Submission_pkey" PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 33172)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4793 (class 2606 OID 33253)
-- Name: Attraction Attraction_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Attraction"
    ADD CONSTRAINT "Attraction_region_id_fkey" FOREIGN KEY (region_id) REFERENCES public."Region"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2026-05-04 15:22:01

--
-- PostgreSQL database dump complete
--

\unrestrict Xu4peTOAq5m3MdebHI86vPNHAbveQTNvY87icgOgjMoveMzrDHCFHdB4Q2FgM0D


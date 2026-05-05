--
-- PostgreSQL database dump
--

\restrict SogZgnL1QcMNmSiNbYmI175opjl8bQHlq7HlvNWDldyIpFGdAINMcNeVaFj0TB3

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-05-05 18:07:45

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

DROP DATABASE "04_module_d_3";
--
-- TOC entry 4953 (class 1262 OID 33714)
-- Name: 04_module_d_3; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "04_module_d_3" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE "04_module_d_3" OWNER TO postgres;

\unrestrict SogZgnL1QcMNmSiNbYmI175opjl8bQHlq7HlvNWDldyIpFGdAINMcNeVaFj0TB3
\connect "04_module_d_3"
\restrict SogZgnL1QcMNmSiNbYmI175opjl8bQHlq7HlvNWDldyIpFGdAINMcNeVaFj0TB3

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
-- TOC entry 223 (class 1259 OID 33745)
-- Name: Attractions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Attractions" (
    id smallint NOT NULL,
    region_id smallint NOT NULL,
    name character varying(20) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public."Attractions" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 33744)
-- Name: Attractions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Attractions_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Attractions_id_seq" OWNER TO postgres;

--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 222
-- Name: Attractions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Attractions_id_seq" OWNED BY public."Attractions".id;


--
-- TOC entry 227 (class 1259 OID 33773)
-- Name: Info_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Info_items" (
    id smallint NOT NULL,
    category character varying(14) NOT NULL,
    icon character varying(20) NOT NULL,
    title character varying(50) NOT NULL,
    body text NOT NULL
);


ALTER TABLE public."Info_items" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 33772)
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
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 226
-- Name: Info_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Info_items_id_seq" OWNED BY public."Info_items".id;


--
-- TOC entry 221 (class 1259 OID 33732)
-- Name: Regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Regions" (
    id smallint NOT NULL,
    key character varying(7) NOT NULL,
    name character varying(7) NOT NULL,
    color character varying(9) NOT NULL,
    summary text,
    region_id integer,
    description character varying(50)
);


ALTER TABLE public."Regions" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 33731)
-- Name: Regions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Regions_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Regions_id_seq" OWNER TO postgres;

--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 220
-- Name: Regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Regions_id_seq" OWNED BY public."Regions".id;


--
-- TOC entry 225 (class 1259 OID 33758)
-- Name: Submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Submissions" (
    id smallint NOT NULL,
    name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    country character varying(20),
    interests text,
    message text NOT NULL,
    submitted_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Submissions" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 33757)
-- Name: Submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Submissions_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Submissions_id_seq" OWNER TO postgres;

--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 224
-- Name: Submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Submissions_id_seq" OWNED BY public."Submissions".id;


--
-- TOC entry 219 (class 1259 OID 33717)
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
-- TOC entry 4777 (class 2604 OID 33748)
-- Name: Attractions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Attractions" ALTER COLUMN id SET DEFAULT nextval('public."Attractions_id_seq"'::regclass);


--
-- TOC entry 4780 (class 2604 OID 33776)
-- Name: Info_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Info_items" ALTER COLUMN id SET DEFAULT nextval('public."Info_items_id_seq"'::regclass);


--
-- TOC entry 4776 (class 2604 OID 33735)
-- Name: Regions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Regions" ALTER COLUMN id SET DEFAULT nextval('public."Regions_id_seq"'::regclass);


--
-- TOC entry 4778 (class 2604 OID 33761)
-- Name: Submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submissions" ALTER COLUMN id SET DEFAULT nextval('public."Submissions_id_seq"'::regclass);


--
-- TOC entry 4943 (class 0 OID 33745)
-- Dependencies: 223
-- Data for Name: Attractions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Attractions" VALUES (1, 1, 'Taipei 101', 'Skyscraper views & luxury mall');
INSERT INTO public."Attractions" VALUES (2, 1, 'Jiufen', 'Hillside lantern alleys & tea houses');
INSERT INTO public."Attractions" VALUES (3, 1, 'Yehliu Geopark', 'Otherworldly sea-eroded rock formations');
INSERT INTO public."Attractions" VALUES (4, 2, 'Sun Moon Lake', 'Scenic cycling & boat tours');
INSERT INTO public."Attractions" VALUES (5, 2, 'Taichung', 'Museums, parks & creative parks');
INSERT INTO public."Attractions" VALUES (6, 2, 'Alishan', 'Tea terraces & sunrise sea of clouds');
INSERT INTO public."Attractions" VALUES (7, 3, 'Tainan', 'Taiwan''s oldest city & street eats');
INSERT INTO public."Attractions" VALUES (8, 3, 'Kaohsiung', 'Pier-2 Art Center & harbor views');
INSERT INTO public."Attractions" VALUES (9, 3, 'Kenting', 'White-sand beaches & water sports');
INSERT INTO public."Attractions" VALUES (10, 4, 'Taroko Gorge', 'Marble canyons & sky-high trails');
INSERT INTO public."Attractions" VALUES (11, 4, 'Hualien', 'Pacific coastlines & rice paddies');
INSERT INTO public."Attractions" VALUES (12, 4, 'Taitung', 'Hot springs & laid-back festivals');


--
-- TOC entry 4947 (class 0 OID 33773)
-- Dependencies: 227
-- Data for Name: Info_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Info_items" VALUES (1, 'transportation', '#i-train', 'High-Speed Rail (HSR)', 'Zip between major cities from Taipei to Kaohsiung in ~1.5–2 hours. Reserve seats online or at kiosks.');
INSERT INTO public."Info_items" VALUES (2, 'transportation', '#i-landmark', 'TRA & Local Lines', 'Coastal and mountain routes cover smaller towns. EasyCard works on most services.');
INSERT INTO public."Info_items" VALUES (3, 'transportation', '#i-pin', 'Metro & Buses', 'Taipei/Kaohsiung MRT are bilingual and spotless. Bus networks are extensive and affordable.');
INSERT INTO public."Info_items" VALUES (4, 'accommodation', '#i-hotel', 'Hotels & Hostels', 'From luxury towers to design hostels—book early for weekends & festivals.');
INSERT INTO public."Info_items" VALUES (5, 'accommodation', '#i-landmark', 'Minshuku (B&B)', 'Warm, family-run stays—especially common on the East Coast.');
INSERT INTO public."Info_items" VALUES (6, 'accommodation', '#i-pin', 'Hot Spring Resorts', 'Soak in Beitou, Jiaoxi or mountainside retreats across the island.');
INSERT INTO public."Info_items" VALUES (7, 'shopping', '#i-bag', 'Night Markets', 'Try snacks as you browse souvenirs—remember to bring small bills.');
INSERT INTO public."Info_items" VALUES (8, 'shopping', '#i-utensils', 'Gourmet Gifts', 'Pineapple cakes, nougat, oolong teas—pack for customs.');
INSERT INTO public."Info_items" VALUES (9, 'shopping', '#i-globe', 'Tax Refund', 'Foreign visitors can claim VAT refunds—check store windows for the logo.');


--
-- TOC entry 4941 (class 0 OID 33732)
-- Dependencies: 221
-- Data for Name: Regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Regions" VALUES (1, 'north', 'North', '#22c55e', 'Urban energy & nature: Taipei 101, night markets, Jiufen''s old streets, Yehliu''s unique geology.', NULL, NULL);
INSERT INTO public."Regions" VALUES (2, 'central', 'Central', '#06b6d4', 'Misty mountains & lakes: Sun Moon Lake cycling, Taichung art, Alishan sunrise forests.', NULL, NULL);
INSERT INTO public."Regions" VALUES (3, 'south', 'South', '#f97316', 'Historic flavors & beaches: Tainan temples, Kaohsiung harbor art, Kenting''s tropical coast.', NULL, NULL);
INSERT INTO public."Regions" VALUES (4, 'east', 'East', '#8b5cf6', 'Wild coasts & gorges: Taroko marble cliffs, Hualien ocean vistas, Taitung hot air vibes.', NULL, NULL);


--
-- TOC entry 4945 (class 0 OID 33758)
-- Dependencies: 225
-- Data for Name: Submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4939 (class 0 OID 33717)
-- Dependencies: 219
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public._prisma_migrations VALUES ('08e5a9a1-73e3-42f8-a406-98c0e6a6ca10', 'b9919992159fa11fafbbcc1d6edd70b1ab2527638af1b90243dd236a35706ea5', '2026-05-05 12:11:04.136067+05:30', '20260505064104_init', NULL, NULL, '2026-05-05 12:11:04.092001+05:30', 1);


--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 222
-- Name: Attractions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Attractions_id_seq"', 1, false);


--
-- TOC entry 4959 (class 0 OID 0)
-- Dependencies: 226
-- Name: Info_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Info_items_id_seq"', 1, false);


--
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 220
-- Name: Regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Regions_id_seq"', 1, false);


--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 224
-- Name: Submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Submissions_id_seq"', 1, false);


--
-- TOC entry 4786 (class 2606 OID 33756)
-- Name: Attractions Attractions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Attractions"
    ADD CONSTRAINT "Attractions_pkey" PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 33785)
-- Name: Info_items Info_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Info_items"
    ADD CONSTRAINT "Info_items_pkey" PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 33743)
-- Name: Regions Regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Regions"
    ADD CONSTRAINT "Regions_pkey" PRIMARY KEY (id);


--
-- TOC entry 4788 (class 2606 OID 33771)
-- Name: Submissions Submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submissions"
    ADD CONSTRAINT "Submissions_pkey" PRIMARY KEY (id);


--
-- TOC entry 4782 (class 2606 OID 33730)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4791 (class 2606 OID 33786)
-- Name: Attractions Attractions_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Attractions"
    ADD CONSTRAINT "Attractions_region_id_fkey" FOREIGN KEY (region_id) REFERENCES public."Regions"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2026-05-05 18:07:46

--
-- PostgreSQL database dump complete
--

\unrestrict SogZgnL1QcMNmSiNbYmI175opjl8bQHlq7HlvNWDldyIpFGdAINMcNeVaFj0TB3


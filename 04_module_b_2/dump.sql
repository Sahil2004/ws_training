--
-- PostgreSQL database dump
--

\restrict 3vaOZMu9axHHJAZSSjIfhssUcWAGTmqcSqxTBtlBhxYuabL1PjwTSV8ewwic2If

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-04-29 21:33:59

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

DROP DATABASE "04_module_b_2";
--
-- TOC entry 4940 (class 1262 OID 16945)
-- Name: 04_module_b_2; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "04_module_b_2" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE "04_module_b_2" OWNER TO postgres;

\unrestrict 3vaOZMu9axHHJAZSSjIfhssUcWAGTmqcSqxTBtlBhxYuabL1PjwTSV8ewwic2If
\connect "04_module_b_2"
\restrict 3vaOZMu9axHHJAZSSjIfhssUcWAGTmqcSqxTBtlBhxYuabL1PjwTSV8ewwic2If

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
-- TOC entry 220 (class 1259 OID 16962)
-- Name: Company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Company" (
    id character varying(36) NOT NULL,
    name character varying(50) NOT NULL,
    address text,
    mobile character varying(12),
    email character varying(100) NOT NULL,
    "ownerId" character varying(36) NOT NULL,
    "contactId" character varying(36) NOT NULL,
    "isDeactivated" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Company" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16984)
-- Name: Products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Products" (
    "GTIN" bigint NOT NULL,
    name character varying(50) NOT NULL,
    "nameFr" character varying(50) NOT NULL,
    description text,
    "descriptionFr" text,
    brand character varying(20),
    country character varying(20),
    "grossWeight" smallint,
    "netWeight" smallint,
    unit character varying(10),
    "companyId" character varying(36) NOT NULL,
    "isHidden" boolean DEFAULT false NOT NULL,
    image text
);


ALTER TABLE public."Products" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16976)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id character varying(36) NOT NULL,
    name character varying(50) NOT NULL,
    mobile character varying(12),
    email character varying(100) NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16948)
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
-- TOC entry 4932 (class 0 OID 16962)
-- Dependencies: 220
-- Data for Name: Company; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Company" VALUES ('e362baf0-4c76-4e1f-afcd-d3a8da5b1c57', 'Sahil Garg', '5', '1234', 'me.sahil.gg@gmail.com', '09571685-484f-4f34-a27a-7174e6b6bbc2', '4444ac3e-0d81-4018-a804-97fd59729402', true);


--
-- TOC entry 4934 (class 0 OID 16984)
-- Dependencies: 222
-- Data for Name: Products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Products" VALUES (1234567890123, 'Sahil Garg', 'PFr', 'd', 'dfr', 'Brand', 'Country', 123, 123, 'Kg', 'e362baf0-4c76-4e1f-afcd-d3a8da5b1c57', false, 'uploads\8a16d7db5e48d9e8435af95895bb4369');


--
-- TOC entry 4933 (class 0 OID 16976)
-- Dependencies: 221
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User" VALUES ('4444ac3e-0d81-4018-a804-97fd59729402', 'Sahil Garg', '1234', 'me.sahil2.gg@gmail.com');
INSERT INTO public."User" VALUES ('09571685-484f-4f34-a27a-7174e6b6bbc2', 'Someone', '1234', 'me.sahil.gg@gmail.com');


--
-- TOC entry 4931 (class 0 OID 16948)
-- Dependencies: 219
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public._prisma_migrations VALUES ('3dd29b98-3f00-4d03-bdbf-98127f103875', 'e752746a0a892d7ea21a559bfd99ebef949f4679991822830b20be161402d127', '2026-04-29 16:10:19.593955+05:30', '20260429104019_init', NULL, NULL, '2026-04-29 16:10:19.560585+05:30', 1);
INSERT INTO public._prisma_migrations VALUES ('8d46eab7-5aeb-4f6f-a8f5-79c001af4614', '933d4ea213676802c227b815b85dd3e77fe1c944386e6bf0d2a85bd07cb6c23e', '2026-04-29 20:24:51.412941+05:30', '20260429145451_image_added', NULL, NULL, '2026-04-29 20:24:51.391522+05:30', 1);


--
-- TOC entry 4774 (class 2606 OID 16975)
-- Name: Company Company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_pkey" PRIMARY KEY (id);


--
-- TOC entry 4780 (class 2606 OID 16996)
-- Name: Products Products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_pkey" PRIMARY KEY ("GTIN");


--
-- TOC entry 4777 (class 2606 OID 16983)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 4771 (class 2606 OID 16961)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4772 (class 1259 OID 16997)
-- Name: Company_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Company_email_key" ON public."Company" USING btree (email);


--
-- TOC entry 4778 (class 1259 OID 16999)
-- Name: Products_GTIN_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Products_GTIN_idx" ON public."Products" USING btree ("GTIN");


--
-- TOC entry 4775 (class 1259 OID 16998)
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- TOC entry 4781 (class 2606 OID 17005)
-- Name: Company Company_contactId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4782 (class 2606 OID 17000)
-- Name: Company Company_ownerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4783 (class 2606 OID 17010)
-- Name: Products Products_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2026-04-29 21:34:00

--
-- PostgreSQL database dump complete
--

\unrestrict 3vaOZMu9axHHJAZSSjIfhssUcWAGTmqcSqxTBtlBhxYuabL1PjwTSV8ewwic2If


--
-- PostgreSQL database cluster dump
--

\restrict QCC4kp6sws03L8YeWguLdYeeWR4HEByf4g0toIkubWBqGTkWBs6ppfj29HizIyj

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:4dLBIRTnTPbXNl6xUbCQVA==$JBBI38/Ye/bHAp/g4uF7CnaQUT6iP/5tEqCn7vW/iQc=:Bolvfe8XiDmFiU0KEWfLrWoOBDjJwXwfYJPrwroNUtY=';

--
-- User Configurations
--








\unrestrict QCC4kp6sws03L8YeWguLdYeeWR4HEByf4g0toIkubWBqGTkWBs6ppfj29HizIyj

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict 3FyXH2Du2pE1e7QiwddCo0dpcOwChUcsKCL1Qvi9tbaJMaJChuY9Io8KSf4LRDy

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\unrestrict 3FyXH2Du2pE1e7QiwddCo0dpcOwChUcsKCL1Qvi9tbaJMaJChuY9Io8KSf4LRDy

--
-- Database "coach_auth" dump
--

--
-- PostgreSQL database dump
--

\restrict bzE1UFAETYppmycsCBW1G4m6qN6BQfH92RJk74Sl0P5r3h9xXp4ldSbvWhWPS3E

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: coach_auth; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE coach_auth WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE coach_auth OWNER TO postgres;

\unrestrict bzE1UFAETYppmycsCBW1G4m6qN6BQfH92RJk74Sl0P5r3h9xXp4ldSbvWhWPS3E
\connect coach_auth
\restrict bzE1UFAETYppmycsCBW1G4m6qN6BQfH92RJk74Sl0P5r3h9xXp4ldSbvWhWPS3E

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    full_name character varying(100) NOT NULL,
    email character varying(120) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    last_login_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	create users table	SQL	V1__create_users_table.sql	1261029036	postgres	2026-03-11 06:57:41.193254	165	t
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, full_name, email, password_hash, role, created_at, updated_at, last_login_at) FROM stdin;
ffb476db-0bce-4e49-9bdb-c55ad3a28e24	Varun Deoghare	varun.deoghare@gmail.com	$2a$10$c158uhRy8ZWvpNiGlW710OxJq5WIGCRR7Gcz1RwtSaowWz3EXnRtq	COACH	2026-03-11 06:58:54.663743	\N	2026-05-18 14:05:24.486012
\.


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- PostgreSQL database dump complete
--

\unrestrict bzE1UFAETYppmycsCBW1G4m6qN6BQfH92RJk74Sl0P5r3h9xXp4ldSbvWhWPS3E

--
-- Database "coach_billing" dump
--

--
-- PostgreSQL database dump
--

\restrict drgNyYdUWj06N4aXrl35abcLsf9sUDzLsihVgdBZq2IuZCvORL2QngHot5LHCrK

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: coach_billing; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE coach_billing WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE coach_billing OWNER TO postgres;

\unrestrict drgNyYdUWj06N4aXrl35abcLsf9sUDzLsihVgdBZq2IuZCvORL2QngHot5LHCrK
\connect coach_billing
\restrict drgNyYdUWj06N4aXrl35abcLsf9sUDzLsihVgdBZq2IuZCvORL2QngHot5LHCrK

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id uuid NOT NULL,
    member_id uuid NOT NULL,
    coach_email character varying(120) NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_date date,
    mode character varying(50) NOT NULL,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    gateway character varying(50),
    gateway_order_id character varying(100),
    gateway_payment_id character varying(100),
    gateway_signature character varying(200),
    status character varying(20) DEFAULT 'PENDING'::character varying NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscriptions (
    id uuid NOT NULL,
    member_id uuid NOT NULL,
    coach_email character varying(120) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.subscriptions OWNER TO postgres;

--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	create billing tables	SQL	V1__create_billing_tables.sql	1239972611	postgres	2026-03-11 06:57:52.913085	311	t
2	2	add gateway fields	SQL	V2__add_gateway_fields.sql	194094964	postgres	2026-03-11 06:57:53.774862	51	t
3	3	add payment status	SQL	V3__add_payment_status.sql	-1610799134	postgres	2026-03-11 06:57:53.987401	59	t
4	4	make payment date nullable	SQL	V4__make_payment_date_nullable.sql	-440865652	postgres	2026-03-11 06:57:54.170236	72	t
5	5	add soft delete to payments	SQL	V5__add_soft_delete_to_payments.sql	353380651	postgres	2026-03-13 14:30:36.603917	1212	t
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, member_id, coach_email, amount, payment_date, mode, notes, created_at, gateway, gateway_order_id, gateway_payment_id, gateway_signature, status, deleted_at) FROM stdin;
dd55d56d-ceec-40d6-ae73-bbb5d203943d	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	1000.00	2026-04-06	MANUAL	\N	2026-05-02 14:51:20.839675	MANUAL	\N	\N	\N	SUCCESS	\N
3ebd6a2b-157b-4ae6-9766-8ef035946959	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	1000.00	2026-03-13	MANUAL	\N	2026-03-13 14:02:17.257142	MANUAL	\N	\N	\N	SUCCESS	\N
144164a3-5258-431a-aba0-6d807e523d85	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	-1.00	2026-03-13	MANUAL	\N	2026-03-13 14:01:58.302696	MANUAL	\N	\N	\N	SUCCESS	2026-03-13 14:32:48.344724
c8de6853-a01a-48b2-8ff8-6898c787f5c7	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	1000.00	2026-03-15	MANUAL	\N	2026-03-15 07:16:41.494346	MANUAL	\N	\N	\N	SUCCESS	\N
7771cd14-9067-4e17-aafe-4f27314997f4	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	1000.00	2026-03-15	MANUAL	\N	2026-03-15 07:14:35.849737	MANUAL	\N	\N	\N	SUCCESS	2026-03-15 07:17:36.756003
16ac39a4-e0f5-4308-af09-d365e06049c3	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	1000.00	2026-03-15	MANUAL	\N	2026-03-15 07:19:13.608576	MANUAL	\N	\N	\N	SUCCESS	\N
239df2ec-7bb6-4690-a095-8649f1d418bd	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	1000.00	2026-03-16	MANUAL	\N	2026-03-16 03:26:53.083858	MANUAL	\N	\N	\N	SUCCESS	\N
e9028c6b-5128-4868-bc6b-b33e2f6f8bfd	615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	1000.00	2026-03-17	MANUAL	\N	2026-03-17 12:02:06.37049	MANUAL	\N	\N	\N	SUCCESS	\N
ce78d4e4-b0e4-41f2-93ea-eb7316650d02	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	1000.00	2026-03-19	MANUAL	\N	2026-03-19 13:09:54.898369	MANUAL	\N	\N	\N	SUCCESS	\N
027ade8c-d8bd-4ce1-bb6c-44e0467434fc	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	1000.00	2026-03-28	MANUAL	\N	2026-03-28 12:19:38.050464	MANUAL	\N	\N	\N	SUCCESS	\N
149a76c2-881b-4a1f-838e-b33ad12f02ec	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	1000.00	2026-03-28	MANUAL	\N	2026-03-28 12:19:25.635881	MANUAL	\N	\N	\N	SUCCESS	\N
0f1ff68f-a385-4cd9-ad78-7a5ae172773a	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	1000.00	2026-05-01	MANUAL	\N	2026-05-02 14:56:35.780206	MANUAL	\N	\N	\N	SUCCESS	\N
d661ae74-467e-4086-a240-6913c3c8cd62	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	1000.00	2026-04-01	MANUAL	\N	2026-04-05 04:06:54.468315	MANUAL	\N	\N	\N	SUCCESS	2026-04-05 04:20:24.739086
c6d19871-efd9-4603-a628-78b01e26da29	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	1000.00	2026-04-01	MANUAL	\N	2026-04-05 04:21:06.17738	MANUAL	\N	\N	\N	SUCCESS	2026-04-05 04:26:29.396176
ee2f576a-c7f8-4ae4-b656-32edbc3a5719	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	1000.00	2026-04-01	MANUAL	\N	2026-04-05 04:26:47.729552	MANUAL	\N	\N	\N	SUCCESS	2026-04-05 04:46:01.124094
da014192-b578-4cda-9aba-f9d2c54a5a3f	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	1500.00	1970-01-06	MANUAL	\N	2026-05-07 13:32:23.296827	MANUAL	\N	\N	\N	SUCCESS	2026-05-07 13:33:05.933938
9014a843-3510-4104-a81e-4ede0de8adb5	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	1000.00	2026-04-01	MANUAL	\N	2026-04-05 04:46:15.094008	MANUAL	\N	\N	\N	SUCCESS	2026-04-05 05:42:11.618635
3f927cec-bb7c-45f1-ab96-ea720e9f4cdd	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	1000.00	2026-04-01	MANUAL	\N	2026-04-05 05:42:18.614077	MANUAL	\N	\N	\N	SUCCESS	2026-04-05 05:43:36.53379
9ad8f033-3288-4344-ad7a-dc0ad47b6264	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	1000.00	\N	MANUAL	\N	2026-04-05 05:43:41.142676	MANUAL	\N	\N	\N	PENDING	2026-04-05 05:48:00.937851
b1e50a84-f199-4438-88a9-c9abd0d96c92	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	1000.00	2026-04-01	MANUAL	\N	2026-04-05 05:52:10.672948	MANUAL	\N	\N	\N	SUCCESS	\N
83d86988-6768-445b-b313-832537972705	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	1000.00	2026-04-15	MANUAL	\N	2026-04-25 08:38:04.837232	MANUAL	\N	\N	\N	SUCCESS	\N
d3a0eba4-0f82-43f8-bde2-752a1d310dc0	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	1000.00	2026-04-23	MANUAL	\N	2026-04-25 08:39:16.923919	MANUAL	\N	\N	\N	SUCCESS	\N
9497ea0f-816c-4be2-aebb-50a9b5b5c0bd	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	1000.00	2026-04-25	MANUAL	\N	2026-04-26 06:43:02.938771	MANUAL	\N	\N	\N	SUCCESS	\N
c8326fba-f780-49d1-9afe-93026194e2e9	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	1000.00	2026-05-01	MANUAL	\N	2026-05-02 14:46:59.596708	MANUAL	\N	\N	\N	SUCCESS	\N
3e969a53-83f0-4f46-b76f-02e6c57d21be	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	1000.00	2026-05-01	MANUAL	\N	2026-05-02 14:47:26.812346	MANUAL	\N	\N	\N	SUCCESS	\N
8ff47f33-37bb-4ae6-bda5-106ed12ee3b0	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	1000.00	2026-05-01	MANUAL	\N	2026-05-02 14:47:43.962945	MANUAL	\N	\N	\N	SUCCESS	\N
1e36e692-cd93-41d4-950c-abf960aa91dc	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	1500.00	2026-05-07	MANUAL	\N	2026-05-07 13:33:17.081394	MANUAL	\N	\N	\N	SUCCESS	\N
434b1509-8b6f-4e56-8401-10570d990833	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	1500.00	2026-05-09	MANUAL	\N	2026-05-09 08:56:54.866114	MANUAL	\N	\N	\N	SUCCESS	\N
e0141d5c-d92a-4fe5-a8ec-079b38fd2654	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	1500.00	2026-05-15	MANUAL	\N	2026-05-15 14:16:06.06007	MANUAL	\N	\N	\N	SUCCESS	2026-05-15 14:20:58.150515
6f3525b7-b637-459f-b304-a90c08948e91	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	1500.00	2026-05-15	MANUAL	\N	2026-05-15 14:21:46.976253	MANUAL	\N	\N	\N	SUCCESS	\N
605c822e-f756-4d8d-876d-28588ce39b7b	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	1500.00	2026-05-15	MANUAL	\N	2026-05-15 14:22:20.123763	MANUAL	\N	\N	\N	SUCCESS	\N
6277fefd-ef31-4355-94e5-d7e4392dd5be	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	1000.00	2026-05-17	MANUAL	\N	2026-05-17 09:54:59.695924	MANUAL	\N	\N	\N	SUCCESS	2026-05-17 10:00:14.216381
646be957-44e0-43a7-b848-ae33a2a9c14f	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	1000.00	2026-05-16	MANUAL	\N	2026-05-17 10:09:11.386934	MANUAL	\N	\N	\N	SUCCESS	\N
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscriptions (id, member_id, coach_email, start_date, end_date, status, created_at) FROM stdin;
d80e385f-ff28-48e5-888f-2a48abd00752	615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	2026-03-17	2026-04-17	ACTIVE	2026-03-17 12:02:09.102047
48487970-f5df-4508-ac70-07ecd4d349e3	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-03-16	2026-05-23	ACTIVE	2026-03-16 03:26:57.199948
95dbd35b-cd7a-4e41-af0d-5b33134d6ace	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-03-19	2026-05-25	ACTIVE	2026-03-19 13:10:00.667824
4f14457d-58bd-4091-a8b4-781f4185cd5a	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-03-28	2026-06-01	ACTIVE	2026-03-28 12:19:47.250801
ba1a57d7-7e7e-4bc0-a8f3-abeff6f631d6	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-03-28	2026-06-01	ACTIVE	2026-03-28 12:19:42.899755
e5855b3d-4773-433b-87d7-b8fdd2fed418	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	2026-03-15	2026-06-01	ACTIVE	2026-03-15 07:16:43.551385
5d06e5e0-a0d0-4db3-8fcd-1b6cff3086bd	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-03-15	2026-06-01	ACTIVE	2026-03-15 07:19:15.688507
77df0c1c-0950-4568-b640-c109904d0ab0	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-04-06	2026-06-07	ACTIVE	2026-05-02 14:51:37.619421
9fd9e9f8-9f2b-4627-9473-7bf249325809	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-05-09	2026-06-09	ACTIVE	2026-05-09 08:56:59.412086
f6d08d3e-60d8-45a7-a0c8-809489deb097	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-05-15	2026-06-15	ACTIVE	2026-05-15 14:16:09.057742
da4c62ce-5b71-47c1-9d03-240da255e8b7	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-05-15	2026-06-15	ACTIVE	2026-05-15 14:22:20.173549
1a672766-345b-4d32-ab63-ef07ef86306f	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-03-13	2026-06-16	ACTIVE	2026-03-13 14:02:00.812984
\.


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- PostgreSQL database dump complete
--

\unrestrict drgNyYdUWj06N4aXrl35abcLsf9sUDzLsihVgdBZq2IuZCvORL2QngHot5LHCrK

--
-- Database "coach_checkin" dump
--

--
-- PostgreSQL database dump
--

\restrict b2pwEtaJmlPrPh4AWQtjnGNJgBIeQZaoFZbnorGaN3e7O9VOsvMu2K0FJDjtkRJ

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: coach_checkin; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE coach_checkin WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE coach_checkin OWNER TO postgres;

\unrestrict b2pwEtaJmlPrPh4AWQtjnGNJgBIeQZaoFZbnorGaN3e7O9VOsvMu2K0FJDjtkRJ
\connect coach_checkin
\restrict b2pwEtaJmlPrPh4AWQtjnGNJgBIeQZaoFZbnorGaN3e7O9VOsvMu2K0FJDjtkRJ

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: checkin_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checkin_photos (
    id uuid NOT NULL,
    check_in_id uuid NOT NULL,
    file_name character varying(255) NOT NULL,
    mime_type character varying(100) NOT NULL,
    size bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.checkin_photos OWNER TO postgres;

--
-- Name: checkins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checkins (
    id uuid NOT NULL,
    member_id uuid NOT NULL,
    coach_email character varying(120) NOT NULL,
    check_in_date date NOT NULL,
    weight numeric(5,2),
    compliance integer,
    energy integer,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.checkins OWNER TO postgres;

--
-- Name: daily_member_checkins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.daily_member_checkins (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    member_id uuid NOT NULL,
    coach_email character varying(255) NOT NULL,
    check_in_date date NOT NULL,
    exercise_done boolean DEFAULT false NOT NULL,
    steps_count integer,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.daily_member_checkins OWNER TO postgres;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: measurements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measurements (
    id uuid NOT NULL,
    check_in_id uuid NOT NULL,
    measurement_name character varying(50) NOT NULL,
    value numeric(6,2) NOT NULL
);


ALTER TABLE public.measurements OWNER TO postgres;

--
-- Name: progress_checkin_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.progress_checkin_photos (
    id uuid NOT NULL,
    check_in_id uuid NOT NULL,
    type character varying(20) NOT NULL,
    file_name character varying(255) NOT NULL,
    mime_type character varying(100) NOT NULL,
    size bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.progress_checkin_photos OWNER TO postgres;

--
-- Name: progress_checkins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.progress_checkins (
    id uuid NOT NULL,
    member_id uuid NOT NULL,
    coach_email character varying(120) NOT NULL,
    weight numeric(6,2),
    diet_adherence integer,
    energy integer,
    steps_avg integer,
    notes text,
    submitted_at timestamp without time zone NOT NULL,
    exercise_rating integer
);


ALTER TABLE public.progress_checkins OWNER TO postgres;

--
-- Data for Name: checkin_photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.checkin_photos (id, check_in_id, file_name, mime_type, size, created_at) FROM stdin;
\.


--
-- Data for Name: checkins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.checkins (id, member_id, coach_email, check_in_date, weight, compliance, energy, notes, created_at) FROM stdin;
\.


--
-- Data for Name: daily_member_checkins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.daily_member_checkins (id, member_id, coach_email, check_in_date, exercise_done, steps_count, notes, created_at, updated_at) FROM stdin;
8c457150-e489-40b5-8808-e79a67915909	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-04-01	t	8000	\N	2026-04-25 08:30:50.718021+00	2026-04-25 08:30:50.718021+00
dd47391f-41f1-4cbc-ae90-16e003229c2f	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-04-03	t	8000	\N	2026-04-25 08:35:38.601634+00	2026-04-25 08:35:38.601634+00
8dd2d532-4330-442e-8cdc-7717dd4b5250	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-04-02	t	8000	\N	2026-04-25 08:31:10.884534+00	2026-04-26 13:10:20.648657+00
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	create checkin tables	SQL	V1__create_checkin_tables.sql	215829978	postgres	2026-03-11 06:57:59.182269	394	t
2	2	create checkin photos	SQL	V2__create_checkin_photos.sql	-362048871	postgres	2026-03-11 06:57:59.951155	90	t
3	3	create progess checkin table	SQL	V3__create_progess_checkin_table.sql	-1187272593	postgres	2026-03-11 06:58:00.114308	183	t
4	4	create progess checkin photo table	SQL	V4__create_progess_checkin_photo_table.sql	-1411197935	postgres	2026-03-11 06:58:00.546709	142	t
5	5	add exercise rating to progress checkins	SQL	V5__add_exercise_rating_to_progress_checkins.sql	-604023149	postgres	2026-03-22 04:21:02.824759	95	t
6	6	create daily member checkins table	SQL	V6__create_daily_member_checkins_table.sql	-2039790891	postgres	2026-04-25 05:38:23.262382	111	t
\.


--
-- Data for Name: measurements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.measurements (id, check_in_id, measurement_name, value) FROM stdin;
\.


--
-- Data for Name: progress_checkin_photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.progress_checkin_photos (id, check_in_id, type, file_name, mime_type, size, created_at) FROM stdin;
ded89e40-5480-4049-9808-a90f4a4b1705	08ca139d-1756-4b37-8794-cb299ae0ff17	SIDE	3e23cbf1-bff7-484d-b2a9-ebc6562920c0_IMG_20260302_131533 - Prateek Srivastava.jpg	image/jpeg	1081318	2026-03-13 14:03:50.336054
3355a204-9558-47e3-98f6-d88e9f3f09e2	08ca139d-1756-4b37-8794-cb299ae0ff17	BACK	385663f6-f7c2-4018-a95a-723c1617c20b_IMG_20260302_131628 - Prateek Srivastava.jpg	image/jpeg	940586	2026-03-13 14:03:50.336054
adaa449c-8339-46e6-a447-ef7f0ac03080	08ca139d-1756-4b37-8794-cb299ae0ff17	FRONT	5fc00e7e-ce6c-4405-bf8d-8ea8501895ae_IMG_20260302_131616 - Prateek Srivastava.jpg	image/jpeg	823074	2026-03-13 14:03:50.390506
1a969cc7-ada3-4f0a-abba-7582bc8f42ff	f6daf442-ad33-4a26-a101-ad23790cfdeb	FRONT	4d61ac6b-ce05-4f7d-acbb-776cf76d5c5b_IMG_20260124_102009 - Prateek Srivastava.jpg	image/jpeg	3749409	2026-03-13 14:05:07.610266
590be31c-7d56-4247-84ed-dfb7e9bce667	f6daf442-ad33-4a26-a101-ad23790cfdeb	SIDE	212b264a-4897-4267-8f48-9bb9eb8da59a_IMG_20260124_102059 - Prateek Srivastava.jpg	image/jpeg	4865077	2026-03-13 14:05:07.64777
802beca2-4974-4ea5-af48-711573740fc7	f6daf442-ad33-4a26-a101-ad23790cfdeb	BACK	d2cf07be-ff84-40dd-970d-03e57c11534c_IMG_20260124_102032 - Prateek Srivastava.jpg	image/jpeg	4400511	2026-03-13 14:05:07.658666
1f1e6c51-907e-4113-b3a0-f3080134ecf6	eecfcd12-ba4e-4730-93fb-80913af8124d	BACK	450738b2-5c24-402e-9f1c-0bae0b8a8363_IMG_20260112_192047 - Prateek Srivastava.jpg	image/jpeg	4497665	2026-03-13 14:06:29.300377
f7edd6b0-0c27-467b-808e-fcea62f177fa	eecfcd12-ba4e-4730-93fb-80913af8124d	FRONT	1ee8a96c-e192-423d-89df-411f6d8ea093_IMG_20260112_192040 - Prateek Srivastava.jpg	image/jpeg	4182814	2026-03-13 14:06:29.352748
81f9f90f-1435-45a9-8b9b-35a0bb233e4d	eecfcd12-ba4e-4730-93fb-80913af8124d	SIDE	5949ae8f-1022-4d11-8985-58ca628bc397_IMG_20260112_192054 - Prateek Srivastava.jpg	image/jpeg	4482115	2026-03-13 14:06:29.357763
519300b4-9f96-4aa9-b3a2-42b2faf30934	27616213-19f9-46d6-95ab-7ff93ce2b64a	FRONT	fb0761fd-15cc-4bbf-84fe-909f547dfd8b_IMG_20260112_192040 - Prateek Srivastava.jpg	image/jpeg	4182814	2026-03-13 14:39:58.77369
6dfd6902-c0bc-421a-8de6-f06278127b0d	27616213-19f9-46d6-95ab-7ff93ce2b64a	BACK	053452a3-1592-4698-aea0-37c48f6ad63a_IMG_20260112_192047 - Prateek Srivastava.jpg	image/jpeg	4497665	2026-03-13 14:39:58.806125
f3819b93-f434-426b-8bd7-387c4e0d9460	27616213-19f9-46d6-95ab-7ff93ce2b64a	SIDE	a2315aaa-b1e8-459a-a9ce-1a42346eacc6_IMG_20260112_192054 - Prateek Srivastava.jpg	image/jpeg	4482115	2026-03-13 14:39:58.843947
269cf4d4-d010-4404-8e60-e0a675b39c5d	1338897b-d47c-4229-a2ce-42b98c20a11e	SIDE	18a26ad3-8021-4ea8-b6e0-a31fe043614e_IMG_20260112_192054 - Prateek Srivastava.jpg	image/jpeg	4482115	2026-03-13 14:52:37.633017
74b31032-f525-428a-99bf-31feea444a67	1338897b-d47c-4229-a2ce-42b98c20a11e	FRONT	71c6f75a-160e-4dd7-9c4c-6fed117dc230_IMG_20260112_192040 - Prateek Srivastava.jpg	image/jpeg	4182814	2026-03-13 14:52:37.71924
59e74c1b-b465-41af-a998-28f9041dcfbb	1338897b-d47c-4229-a2ce-42b98c20a11e	BACK	b6233568-c9b7-4a32-9783-f6bfa0eec50f_IMG_20260112_192047 - Prateek Srivastava.jpg	image/jpeg	4497665	2026-03-13 14:52:37.709971
215151ae-4a9b-4a03-bb06-d829e8449adb	b09614d5-17e8-4b8f-9a25-e0f2ef7547d2	FRONT	d17ec525-ef13-4d6d-83b4-4a77eec3de0f_IMG_20260112_192040 - Prateek Srivastava.jpg	image/jpeg	4182814	2026-03-13 14:55:30.310677
ea26d7e9-8e4b-4e98-bfe1-ee59f929827b	b09614d5-17e8-4b8f-9a25-e0f2ef7547d2	BACK	1b4f29b5-1228-46fe-8fd1-83cd592f694b_IMG_20260112_192047 - Prateek Srivastava.jpg	image/jpeg	4497665	2026-03-13 14:55:30.570871
a8e5062e-1b4f-48ae-adeb-92c9d31e825f	b09614d5-17e8-4b8f-9a25-e0f2ef7547d2	SIDE	aca55818-a135-4198-92c7-2b38b4cd80e3_IMG_20260112_192054 - Prateek Srivastava.jpg	image/jpeg	4482115	2026-03-13 14:55:30.600092
e351c007-62a0-4b45-81aa-c6fdc665971c	e0a72386-93ea-46b5-a6a2-7fb60f892cbe	BACK	03f192be-0b8f-4717-a0f8-bfdc1bd7ba39_IMG_20260112_192047 - Prateek Srivastava.jpg	image/jpeg	4497665	2026-03-13 15:00:38.56909
870b59ba-4c8e-4d3a-b7e9-0f836a8c7da3	e0a72386-93ea-46b5-a6a2-7fb60f892cbe	FRONT	faa9be6c-03cc-4cc2-a093-0f1a633ceeee_IMG_20260112_192040 - Prateek Srivastava.jpg	image/jpeg	4182814	2026-03-13 15:00:38.573323
222f422c-de0e-4449-91a6-349abd043aa0	e0a72386-93ea-46b5-a6a2-7fb60f892cbe	SIDE	4339ae27-7e68-4e5b-a55b-a216fec6093e_IMG_20260112_192054 - Prateek Srivastava.jpg	image/jpeg	4482115	2026-03-13 15:00:38.652737
42bb9ab2-ea5d-4a86-bcb1-ff340111d9b2	9492652e-2496-422a-a3ac-aa993f9b2ed8	SIDE	185764bc-9719-43cf-a2e8-21a2d62d1945_IMG_20260112_192054 - Prateek Srivastava.jpg	image/jpeg	4482115	2026-03-14 06:40:21.512311
2de8cc59-50fd-4ca0-89d1-a3d18692c0c5	9492652e-2496-422a-a3ac-aa993f9b2ed8	BACK	06b8c4f9-cc87-474b-9289-15554c50ffee_IMG_20260112_192047 - Prateek Srivastava.jpg	image/jpeg	4497665	2026-03-14 06:40:21.510755
9f3fdf5e-b128-45d8-bf08-e23e21d19591	9492652e-2496-422a-a3ac-aa993f9b2ed8	FRONT	ab518622-5e68-4dce-815f-acc63ca17c05_IMG_20260112_192040 - Prateek Srivastava.jpg	image/jpeg	4182814	2026-03-14 06:40:21.546398
e2b3142e-f12d-4a49-8c0a-912b47d270a2	38bd944a-e792-4891-b8be-33747cfc4870	FRONT	bb033c20-98c2-44bb-a40f-0b1819578202_IMG_20260112_192047 - Prateek Srivastava.jpg	image/jpeg	4497665	2026-03-14 06:41:11.594162
b7389940-ec35-444c-9f8d-ee28664814ad	38bd944a-e792-4891-b8be-33747cfc4870	BACK	7a41a203-8bcb-4479-8297-2d8791352d3a_IMG_20260112_192040 - Prateek Srivastava.jpg	image/jpeg	4182814	2026-03-14 06:41:11.687603
a3ec1041-1bd3-4ae0-9c5c-5fc0588a3dd9	38bd944a-e792-4891-b8be-33747cfc4870	SIDE	ab99f7c0-4d71-47df-9f85-c01d2d95f298_IMG_20260112_192054 - Prateek Srivastava.jpg	image/jpeg	4482115	2026-03-14 06:41:11.773165
25c125d1-ad30-464a-9a46-8b5ee27042d6	9bf33714-5528-4350-bee9-93f753831a3e	SIDE	7d5aa459-71a1-44cf-8e55-f301484a27be_IMG_20260112_192040 - Prateek Srivastava.jpg	image/jpeg	4182814	2026-03-14 06:44:01.480339
78b1ed18-97e4-4682-9b2b-60419372de26	9bf33714-5528-4350-bee9-93f753831a3e	FRONT	64e43311-4731-4831-99c0-cbb0ef6a3058_IMG_20260124_102032 - Prateek Srivastava.jpg	image/jpeg	4400511	2026-03-14 06:44:01.492486
a7747290-1a60-49f3-ba95-fd43592434d1	9bf33714-5528-4350-bee9-93f753831a3e	BACK	7835702e-001e-4a2e-8694-23245d48bfdc_IMG_20260112_192054 - Prateek Srivastava.jpg	image/jpeg	4482115	2026-03-14 06:44:01.508441
179e45f7-6bb8-473e-8927-d2f4a7193070	68f1637b-d216-4039-93d6-d02f811c0ca8	FRONT	ed56fac4-c6da-4b16-9f5f-f8ad22ac00ae_IMG_20260124_102009 - Prateek Srivastava (1).jpg	image/jpeg	3749409	2026-03-14 07:02:26.507989
f0942bbb-5f2b-4015-809a-4347da93bbea	68f1637b-d216-4039-93d6-d02f811c0ca8	BACK	9f66deb4-75cd-40ae-9ae0-9c295ff51d4b_IMG_20260124_102032 - Prateek Srivastava (1).jpg	image/jpeg	4400511	2026-03-14 07:02:26.557938
a8139026-3a05-4ebc-8965-dfb056eef633	68f1637b-d216-4039-93d6-d02f811c0ca8	SIDE	e0bc8677-0f07-4a02-a3e8-16a76d1b305b_IMG_20260124_102059 - Prateek Srivastava (1).jpg	image/jpeg	4865077	2026-03-14 07:02:26.60952
bd031c58-cc4f-4067-a1d9-15941640d4cf	2970d979-a39f-44d4-8ac3-d3bb5f4b23fd	FRONT	2a468546-ad2a-4a3d-a77b-c41fa02cae56_IMG_20260302_131616 - Prateek Srivastava (1).jpg	image/jpeg	823074	2026-03-14 07:03:27.142141
c0301289-bc1a-4a9d-99ae-2336d0873866	2970d979-a39f-44d4-8ac3-d3bb5f4b23fd	SIDE	4470e235-7409-426b-a1de-340d313e8aac_IMG_20260302_131533 - Prateek Srivastava (1).jpg	image/jpeg	1081318	2026-03-14 07:03:27.194835
77da7beb-be05-4de3-ad7c-1c52c66a52eb	2970d979-a39f-44d4-8ac3-d3bb5f4b23fd	BACK	31c513a7-bde5-4554-a379-0687e84247d9_IMG_20260302_131628 - Prateek Srivastava (1).jpg	image/jpeg	940586	2026-03-14 07:03:27.230169
f3ab6575-13c0-4696-a248-3c7b8c3d88d1	0f92c35d-c1bc-4f64-8d1f-99c0de6549fc	FRONT	55d39e43-3a22-48e8-b6b7-408ed929cd6f_IMG_20260112_192040 - Prateek Srivastava (1).jpg	image/jpeg	4182814	2026-03-14 07:15:21.741461
8981c2e2-90f6-4091-909b-249c56bcfc0b	0f92c35d-c1bc-4f64-8d1f-99c0de6549fc	BACK	918a0063-8306-4a38-a895-418a3306ae09_IMG_20260112_192047 - Prateek Srivastava (1).jpg	image/jpeg	4497665	2026-03-14 07:15:21.732659
9c8fb313-1a00-44a9-b1e2-971c2ffdd7bb	0f92c35d-c1bc-4f64-8d1f-99c0de6549fc	SIDE	03eb9c5f-d64b-4e3e-8563-20119670375b_IMG_20260112_192054 - Prateek Srivastava (1).jpg	image/jpeg	4482115	2026-03-14 07:15:21.798454
2acd278d-ec12-41d5-8c22-9a08eb98dd83	3edee4cb-512f-4631-a71a-94bc7638dcc7	FRONT	cb711932-ea2b-4382-bec6-0bc6f2ed83e0_IMG_20260112_192040 - Prateek Srivastava (1).jpg	image/jpeg	4182814	2026-03-14 07:44:23.075146
34a724c4-56d5-4da9-bfe5-fba7ddef1406	3edee4cb-512f-4631-a71a-94bc7638dcc7	SIDE	c7693d2c-9023-40b8-a588-85e17992b8ce_IMG_20260112_192054 - Prateek Srivastava (1).jpg	image/jpeg	4482115	2026-03-14 07:44:23.080294
70c8465e-e000-45cb-82bc-93ef42b00830	3edee4cb-512f-4631-a71a-94bc7638dcc7	BACK	0a58526a-8fc0-41cd-ab56-63c13740e0b3_IMG_20260112_192047 - Prateek Srivastava (1).jpg	image/jpeg	4497665	2026-03-14 07:44:23.129236
ca03c4b6-bcfb-4067-a47d-fce7718eb5e8	ebbc9611-7db0-4773-b707-4ba2f809cec1	FRONT	4175999f-d71b-4dd1-8f88-db6f4b674106_IMG_20260112_192040 - Prateek Srivastava (1).jpg	image/jpeg	4182814	2026-03-14 07:51:53.989652
c9f757ca-749d-4e39-b9ca-720a797e0d48	ebbc9611-7db0-4773-b707-4ba2f809cec1	SIDE	0371f4db-fd3a-4570-bb22-3d255e30a019_IMG_20260112_192054 - Prateek Srivastava (1).jpg	image/jpeg	4482115	2026-03-14 07:51:54.092401
154dee86-9cd9-4a53-a2cb-0af4bc5e2526	ebbc9611-7db0-4773-b707-4ba2f809cec1	BACK	12ee1af5-b893-4076-9514-e5795d43fa98_IMG_20260112_192047 - Prateek Srivastava (1).jpg	image/jpeg	4497665	2026-03-14 07:51:54.74919
9bc2bdee-6fdb-4fa7-a54f-6f463d3609e6	13231c44-e95a-4f41-851d-ec4b2390b6fb	BACK	47f7d73b-b8de-430b-bb7f-d65965e4fc8f_IMG_20260302_131628 - Prateek Srivastava.jpg	image/jpeg	940586	2026-03-14 07:55:05.467611
303af903-9503-404b-ad4e-bf38794a3b56	13231c44-e95a-4f41-851d-ec4b2390b6fb	SIDE	ae68b09e-e265-4cf1-9c25-e8737d3d7277_IMG_20260302_131533 - Prateek Srivastava.jpg	image/jpeg	1081318	2026-03-14 07:55:05.571605
3eb4c0a3-02ee-453d-a2c8-82784607ebcc	13231c44-e95a-4f41-851d-ec4b2390b6fb	FRONT	dc37d46d-14ca-4154-8973-847a67731a93_IMG_20260302_131616 - Prateek Srivastava.jpg	image/jpeg	823074	2026-03-14 07:55:05.712714
fda9c78f-a40c-4711-9821-f03b36984a35	13dc76b0-6178-40a3-8c38-56bed69dc114	SIDE	1c1448f1-83d3-4dbb-80f5-4e3d06ac2c6f_IMG_20260112_192054 - Prateek Srivastava.jpg	image/jpeg	4482115	2026-03-14 12:46:08.694725
4410a6f7-a470-4b64-9782-7f0601020415	13dc76b0-6178-40a3-8c38-56bed69dc114	FRONT	6abbc8cc-e99e-4d62-a24d-4d1671522b0f_IMG_20260112_192040 - Prateek Srivastava.jpg	image/jpeg	4182814	2026-03-14 12:46:08.690238
10f773e1-5384-4be9-8ce8-6037a08c43eb	13dc76b0-6178-40a3-8c38-56bed69dc114	BACK	0ab01b9a-dbd8-4124-b7f4-9ee2ba62b652_IMG_20260112_192047 - Prateek Srivastava.jpg	image/jpeg	4497665	2026-03-14 12:46:08.806273
cee78da5-1db6-42f5-b543-a41553514741	e8c10f55-dbf2-4b10-b477-11dc4b1ec6e2	FRONT	050cece0-12b9-4624-af3d-32204ed918eb_IMG_20260124_102009 - Prateek Srivastava.jpg	image/jpeg	3749409	2026-03-14 12:47:33.639996
b9addf6e-34b4-4ee5-8151-46e3a0c3b0ed	e8c10f55-dbf2-4b10-b477-11dc4b1ec6e2	BACK	ffe9e750-5402-402f-85d7-28d87af34deb_IMG_20260124_102032 - Prateek Srivastava.jpg	image/jpeg	4400511	2026-03-14 12:47:33.90634
d3c421b1-608e-44b5-ad31-6981b9ab7b40	e8c10f55-dbf2-4b10-b477-11dc4b1ec6e2	SIDE	5b89cf19-daff-4b83-aefa-587e983c6593_IMG_20260124_102059 - Prateek Srivastava.jpg	image/jpeg	4865077	2026-03-14 12:47:34.190374
c58491ab-d10b-4191-8e08-eb09ff43010f	c581c21f-6f63-4799-94c7-d3a97425389a	FRONT	1994342e-808d-4a9a-a0fe-b37e0cb2a3ea_IMG_20260302_131616 - Prateek Srivastava.jpg	image/jpeg	823074	2026-03-14 12:48:54.235653
b86bca89-0ab7-4822-b5ff-2fb3deb98dd8	c581c21f-6f63-4799-94c7-d3a97425389a	BACK	1fdabfa4-317e-4b95-a0b1-ab9dfa459b71_IMG_20260302_131628 - Prateek Srivastava.jpg	image/jpeg	940586	2026-03-14 12:48:56.412602
d0491fec-9844-4c97-9f2d-d8117da5be09	c581c21f-6f63-4799-94c7-d3a97425389a	SIDE	f19d4815-69d5-4436-aca4-01cb11e5bdf3_IMG_20260302_131533 - Prateek Srivastava.jpg	image/jpeg	1081318	2026-03-14 12:48:59.152837
eb3a6200-2b34-488a-a314-6d9394ea20e2	b464d553-88db-410a-a45c-1fbf1afaa4e8	BACK	acb14ef6-cf4b-499f-bbfc-0822daf53053_IMG_20260321_131528 - Prateek Srivastava.jpg	image/jpeg	990195	2026-03-22 03:39:27.803996
648d99df-b36a-4142-8029-c1bd7a872fe3	b464d553-88db-410a-a45c-1fbf1afaa4e8	FRONT	68486589-9a1d-4db0-b0b6-7d604bde5c1d_IMG_20260321_131442 - Prateek Srivastava.jpg	image/jpeg	1015276	2026-03-22 03:39:27.803978
d9dc0891-04da-452e-b766-97c20f12df75	b464d553-88db-410a-a45c-1fbf1afaa4e8	SIDE	a9565404-1b5b-44f7-a4c8-f05a75967088_IMG_20260321_131547 - Prateek Srivastava.jpg	image/jpeg	1019187	2026-03-22 03:39:27.803955
d3932111-0a2c-4287-ae2e-f93076c602bd	764d37e9-939a-41ce-93c4-776d39dca48e	FRONT	1f86bc41-00fa-4e6b-9a75-40c713037d8b_IMG_20260329_124728 - Prateek Srivastava.jpg	image/jpeg	828470	2026-03-30 09:13:41.809542
13be77f3-8e46-4e77-9b78-6d38f88938ad	764d37e9-939a-41ce-93c4-776d39dca48e	BACK	b7d721ca-669e-4f08-be46-4d3cc6dbc37d_IMG_20260329_124812 - Prateek Srivastava.jpg	image/jpeg	928513	2026-03-30 09:13:41.868475
03df4231-a23c-4da2-bbb2-60e464dd10dc	764d37e9-939a-41ce-93c4-776d39dca48e	SIDE	da2ac0c0-435d-4c2c-a051-6d9cf2cc4c67_IMG_20260329_124750 - Prateek Srivastava.jpg	image/jpeg	975611	2026-03-30 09:13:44.122368
289786fa-8ee4-42c1-82bc-e56167a1bd5c	c9d7035e-6ad1-4091-88ac-76d582518292	FRONT	9e2eced9-05fb-4cd2-8310-8019ba33bbc0_IMG_1779 - Vaishnavi R B.jpeg	image/jpeg	3856874	2026-04-07 03:16:38.442123
c5b040cd-1dee-4632-b134-dabe5e78ec15	c9d7035e-6ad1-4091-88ac-76d582518292	BACK	3fff3e60-91ea-4082-9efe-1d5de454bf9f_IMG_1778 - Vaishnavi R B.jpeg	image/jpeg	3682591	2026-04-07 03:16:38.442124
55996107-157e-4097-b5ac-e30783db9013	c9d7035e-6ad1-4091-88ac-76d582518292	SIDE	cf4eaf5d-b308-4b2f-848b-975f936a3bc2_IMG_1780 - Vaishnavi R B.jpeg	image/jpeg	4015296	2026-04-07 03:16:38.445439
0cceae59-de64-4c54-aecd-97877a45084e	426cbff9-7846-4444-aed1-3e1eaae5adf0	BACK	93517a2d-6175-4f35-b952-f1fe3f277f5a_IMG_0656 - Vaishnavi R B.jpeg	image/jpeg	1274875	2026-04-07 03:18:08.598925
459bde19-384d-47a6-8ded-54c55a926d2e	426cbff9-7846-4444-aed1-3e1eaae5adf0	SIDE	a97f368c-49b5-4347-ba3e-2886324f6805_IMG_0665 - Vaishnavi R B.jpeg	image/jpeg	1405283	2026-04-07 03:18:08.779648
efd55b76-d35e-4de3-9305-9bb406746a7f	426cbff9-7846-4444-aed1-3e1eaae5adf0	FRONT	4e1a49a8-889c-4d09-83bd-31fddf3b7c0e_IMG_0615 - Vaishnavi R B.jpeg	image/jpeg	1535260	2026-04-07 03:18:08.919487
046a8751-a41c-4542-bacb-996899692c02	031e1cb9-8d88-4b4d-a72c-6bc66d3ec579	FRONT	f55204b4-2dd4-43c2-a69d-7f2f11b2a0b8_20260419_083030 - Anwar Khan.heic	application/octet-stream	1122836	2026-04-22 14:25:57.819206
3f392cae-abb1-400f-9187-94783de57d66	031e1cb9-8d88-4b4d-a72c-6bc66d3ec579	BACK	02b17010-22d9-4ba0-b9e3-9ab95c9c8ac1_20260419_083050 - Anwar Khan.heic	application/octet-stream	886327	2026-04-22 14:25:57.878058
4d270730-393c-4a07-8caa-6caed31dc6e5	031e1cb9-8d88-4b4d-a72c-6bc66d3ec579	SIDE	02d2b882-e95e-4f64-a9c2-795e86fc596c_20260419_083057 - Anwar Khan.heic	application/octet-stream	968700	2026-04-22 14:25:57.899102
ece6be79-3a93-4f40-ae4a-14a2f0e8ba55	ac4bbbaa-65d7-43c7-9a62-419baa7d6238	SIDE	18aa2aca-f4da-493c-8e23-cea580b11fda_20260419_083057 - Anwar Khan.jpg	image/jpeg	1649961	2026-04-22 14:40:51.317747
46072eda-b8c2-40e5-913b-f18cd6656721	ac4bbbaa-65d7-43c7-9a62-419baa7d6238	FRONT	77a12b9e-6c73-464a-8669-64584f460395_20260419_083050 - Anwar Khan.jpg	image/jpeg	1509265	2026-04-22 14:40:51.317751
3699a4b0-d0dc-4c55-9fbe-da834c27bf25	ac4bbbaa-65d7-43c7-9a62-419baa7d6238	BACK	5d3a1609-3a09-4b87-9de6-c40b9e03816f_20260419_083030 - Anwar Khan.jpg	image/jpeg	1826791	2026-04-22 14:40:51.358383
bc875640-d38f-4455-a708-ccb34f2afb3f	3a2cba19-cbca-4536-91b1-5f168620e6c3	FRONT	6c8d26b3-7f3c-42d8-8781-3a25c17bc547_20260404_093754 - Anwar Khan.jpg	image/jpeg	1161268	2026-04-22 14:44:51.973141
5c5bc979-735d-444d-80a7-4f8cda7b223c	3a2cba19-cbca-4536-91b1-5f168620e6c3	BACK	dc271405-8798-4d09-b34e-9e7451b85b17_20260404_093811 - Anwar Khan.jpg	image/jpeg	1311506	2026-04-22 14:44:51.999029
d11604e0-0192-4130-a8c9-eb322fc6f795	3a2cba19-cbca-4536-91b1-5f168620e6c3	SIDE	bd391560-970b-4183-8678-6604ed5ff5dd_20260404_093803 - Anwar Khan.jpg	image/jpeg	1216047	2026-04-22 14:44:52.223731
e9ffa944-31d4-4c34-87ce-1541be1fd88a	fe63b854-44ab-4552-b22f-1ec9c97d5deb	SIDE	880738a1-9d89-49d3-951a-1c28fd1e8b30_20260419_083057 - Anwar Khan - Side.jpg	image/jpeg	1649961	2026-04-22 14:53:00.296525
912cce16-4ac6-47ed-9542-a4fb974ee5cf	fe63b854-44ab-4552-b22f-1ec9c97d5deb	BACK	302b55e0-57fe-4b22-9bbd-ad4f7c799763_20260419_083050 - Anwar Khan - Back.jpg	image/jpeg	1509265	2026-04-22 14:53:00.355294
be141d85-0576-4c6c-b57b-5f0bfa65ba90	fe63b854-44ab-4552-b22f-1ec9c97d5deb	FRONT	d37dce38-3821-48d3-a2f6-bd5115df0cca_20260419_083030 - Anwar Khan - Front.jpg	image/jpeg	1826791	2026-04-22 14:53:00.385596
ce85a417-fa4a-49c3-8de6-0f7d85d9692d	88a4f483-cc9c-4ee0-ad37-0c34f1eecbfc	FRONT	54b7bbd1-35ed-4a83-b170-8c869171ddf8_20260330_132154 - Prashant Kumar.jpg	image/jpeg	1104690	2026-04-25 08:46:01.558192
c8da4470-269b-42ab-a4bd-bfcd2fb6d16b	88a4f483-cc9c-4ee0-ad37-0c34f1eecbfc	SIDE	0fc4a45f-cd2d-4780-988e-308a61ea115a_20260330_132219(0) - Prashant Kumar.jpg	image/jpeg	986644	2026-04-25 08:46:01.558188
fd557fb8-c394-479f-a8c2-7f31f1e29e7b	88a4f483-cc9c-4ee0-ad37-0c34f1eecbfc	BACK	aca4b924-e6d1-4836-b511-f9729ed85732_20260330_132253 - Prashant Kumar.jpg	image/jpeg	1245286	2026-04-25 08:46:01.558189
11beb9f3-fece-478b-86cd-c814771b128e	84fa6785-d1ea-4771-a956-6d1c48298052	SIDE	3eed30a0-f774-4cad-bca2-0e63158b82eb_IMG_20251220_192917 - Sudhanshu Shekhar Singh.jpg	image/jpeg	2628215	2026-04-25 08:47:23.443391
d905a3f3-9cc2-440d-a0a7-91a3e1622659	84fa6785-d1ea-4771-a956-6d1c48298052	FRONT	2d16a466-8bd2-4b8a-975d-daafa26a4bc0_IMG_20251220_192900 - Sudhanshu Shekhar Singh.jpg	image/jpeg	2547185	2026-04-25 08:47:23.546773
37940a6b-1162-4e8b-8e8b-43104cab9da0	84fa6785-d1ea-4771-a956-6d1c48298052	BACK	f5d4f91e-a31d-49bb-893f-ade737e3e0f6_IMG_20251220_192927 - Sudhanshu Shekhar Singh.jpg	image/jpeg	1631865	2026-04-25 08:47:23.635114
e4b4cc92-adb9-4000-aa82-3430ad852a20	d2a12fef-93d7-4a3d-9964-c0a1e6675992	BACK	4393530c-8f1f-437c-8a0e-86875f132248_IMG_20260425_213135 - Sudhanshu Shekhar Singh.jpg	image/jpeg	1254951	2026-04-26 06:47:24.917585
27415a71-52c0-4990-830d-c589f0318e5f	d2a12fef-93d7-4a3d-9964-c0a1e6675992	SIDE	db7cebbb-2a9d-4eaf-9fa0-1b978d65ac79_IMG_20260425_213152 - Sudhanshu Shekhar Singh.jpg	image/jpeg	2415173	2026-04-26 06:47:24.917584
9fdeb0dd-077b-4527-9e11-778be940393b	d2a12fef-93d7-4a3d-9964-c0a1e6675992	FRONT	b7bdc98e-9eba-4242-83ce-27a1b837fadf_IMG_20260425_213207 - Sudhanshu Shekhar Singh.jpg	image/jpeg	1323202	2026-04-26 06:47:24.917586
531af7cc-1a7c-4414-89af-8b08d2d04ea3	b78ce66f-930a-4220-b344-440dce5c8e67	SIDE	1cee5ff4-cf70-4b9b-9da1-530b114c289b_IMG_20260412_122658 - Prateek Srivastava.jpg	image/jpeg	929482	2026-04-26 13:09:35.157308
0875f46d-9da1-4465-b471-ed3571f85d2b	b78ce66f-930a-4220-b344-440dce5c8e67	FRONT	1aa5d38b-979b-4ba0-9377-0892ccbf3acd_IMG_20260412_122625 - Prateek Srivastava.jpg	image/jpeg	708190	2026-04-26 13:09:35.181334
f8561b86-6627-4412-b6ec-b3ba5e88e51b	b78ce66f-930a-4220-b344-440dce5c8e67	BACK	f2f056bd-b93f-46b4-b111-48f2802d9c40_IMG_20260412_122641 - Prateek Srivastava.jpg	image/jpeg	853566	2026-04-26 13:09:35.19858
40080bc8-3bed-41c4-a01e-5a95794f798a	e8e988b5-567b-47b1-a2fa-fa1494153775	SIDE	7627b357-eda7-4580-8576-9bd2d15657ea_20260426_212154 - Prashant Kumar.jpg	image/jpeg	931566	2026-04-27 08:07:44.138046
5e7337c6-e5a7-4755-97da-588b8e25874a	e8e988b5-567b-47b1-a2fa-fa1494153775	FRONT	1cdb9ea7-876d-4180-b93d-fdd0deb0bacd_20260330_132154 - Prashant Kumar (1).jpg	image/jpeg	1104690	2026-04-27 08:07:44.164953
14cb9f3a-74e4-4fca-9907-208907fc98a7	e8e988b5-567b-47b1-a2fa-fa1494153775	BACK	f99f7eae-7959-4c16-a2b4-133961629683_20260426_212143 - Prashant Kumar.jpg	image/jpeg	1485199	2026-04-27 08:07:44.208076
3ac5397c-790d-4580-83bc-8214cb150f66	bf2e3d64-e2ff-4ad5-a833-61b4cd311356	FRONT	9e37337c-a6fb-4840-a2fa-8bb205bd1c1e_IMG_8759 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4933748	2026-04-27 11:52:46.379862
30c0f8e0-db6f-404d-85b6-e5ed9d7ddb27	bf2e3d64-e2ff-4ad5-a833-61b4cd311356	SIDE	8c3343e6-aac0-4b76-b961-1f80b83785c9_IMG_8760 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4911350	2026-04-27 11:52:46.443899
1482c562-4e2e-454e-8818-c17de9829a32	bf2e3d64-e2ff-4ad5-a833-61b4cd311356	BACK	8d728fba-16a7-467c-9bcb-f6e9fedbc1a6_IMG_8761 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4419155	2026-04-27 11:52:46.758534
3210f728-ce6e-4f82-9c5b-f4ff9fc37e7d	e361147f-bbb9-4ebe-b940-ec8c2d291c4d	BACK	46019291-50f2-4ce0-bb23-d3afce2198dd_IMG_8300 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4656389	2026-04-27 11:57:54.063993
74d810d8-4178-4295-99f2-3a23d48a07a3	e361147f-bbb9-4ebe-b940-ec8c2d291c4d	FRONT	1e1f806b-4bd9-41a1-b1be-56cd07702a9b_IMG_8298 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4727058	2026-04-27 11:57:54.264867
85e55545-a089-48a5-8a89-f2ec7092995a	e361147f-bbb9-4ebe-b940-ec8c2d291c4d	SIDE	fb418101-ec93-4a52-b57e-b120c904e28a_IMG_8299 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4478493	2026-04-27 11:57:54.635775
752772df-63dc-4bcb-b26f-0c7d0a31c510	17204b69-1175-4762-9cd2-cd1739584138	FRONT	8e0e6d48-0399-4ce2-8321-f3d92479cea3_IMG-20260322-WA0007 - Dr Khushbu Ganjir.jpg	image/jpeg	913349	2026-04-27 12:02:00.420908
e60cdd76-fe8e-4ff9-b559-e8e81ee2f1ac	17204b69-1175-4762-9cd2-cd1739584138	BACK	1203c2bc-27ae-49ee-809c-634597e72e68_IMG-20260322-WA0010 - Dr Khushbu Ganjir.jpg	image/jpeg	1023228	2026-04-27 12:02:00.431091
d7707691-efbb-4d69-bcbb-3cbcf5e95d97	17204b69-1175-4762-9cd2-cd1739584138	SIDE	f917318f-b05d-4701-b733-e4c116af56a0_IMG-20260322-WA0008 - Dr Khushbu Ganjir.jpg	image/jpeg	932909	2026-04-27 12:02:00.465362
007c6b5e-b7bf-4aff-a0f3-50a579298a4e	f38dc64b-4ad9-4275-af5d-f840eea12511	FRONT	5e7462e2-55ba-40d9-bc01-28e2114c40fe_IMG-20260426-WA0005 - Dr Khushbu Ganjir.jpg	image/jpeg	232580	2026-04-27 12:03:15.106162
bcf8ae6b-7081-482d-89e8-3c4a29949c31	f38dc64b-4ad9-4275-af5d-f840eea12511	BACK	eabca3fe-e8a4-4a79-a4df-e1971013c071_IMG-20260426-WA0004 - Dr Khushbu Ganjir.jpg	image/jpeg	205729	2026-04-27 12:03:15.129709
9bb9cacc-ec36-44d5-9187-4925de9b8ea2	f38dc64b-4ad9-4275-af5d-f840eea12511	SIDE	545de878-3f18-4951-9de5-00d510006fc9_IMG-20260426-WA0003 - Dr Khushbu Ganjir.jpg	image/jpeg	219314	2026-04-27 12:03:15.174872
09fd3176-e492-4963-858a-c049243145b1	e237c780-aa39-4331-8860-684d9b869b8f	SIDE	44a48bab-cd18-4f2f-9b75-7f5a5bd6a959_20260503_083058 - Anwar Khan.jpg	image/jpeg	2235138	2026-05-03 06:00:37.97265
8915e081-7c14-470b-b64b-ddcad6ee8eb3	e237c780-aa39-4331-8860-684d9b869b8f	FRONT	a665a786-8317-4276-9a1b-1081f6808d3e_20260503_083315 - Anwar Khan.jpg	image/jpeg	2516581	2026-05-03 06:00:38.141016
943e5ec9-98f7-4ee5-90bc-fd5931d71b9a	e237c780-aa39-4331-8860-684d9b869b8f	BACK	45daab6f-e814-4ef4-bc2d-7a263c9775a8_20260503_083321 - Anwar Khan.jpg	image/jpeg	2523359	2026-05-03 06:00:38.292862
7ed638cd-e473-4a94-885f-eb82e62f14b2	54354eb0-8a94-427b-bcca-ce321e663e68	FRONT	52eda69e-c50f-46e8-a909-03eb6e88b766_IMG_9051 - Rishikant Soni.jpeg	image/jpeg	1499349	2026-05-04 04:14:55.368805
bc5d60fc-bdfe-4c32-900c-2abdb22b2304	54354eb0-8a94-427b-bcca-ce321e663e68	SIDE	92accb86-9bd2-4e39-bef0-5805cfd66e57_IMG_9068 - Rishikant Soni.jpeg	image/jpeg	1400914	2026-05-04 04:14:55.36881
a63cbd87-e457-4c04-92bb-1e0768f6c24c	54354eb0-8a94-427b-bcca-ce321e663e68	BACK	079b1478-3ff0-4fa5-9d6c-276abfb95e81_IMG_9079 - Rishikant Soni.jpeg	image/jpeg	1512074	2026-05-04 04:14:55.651327
5380629b-61c2-411a-8cb9-8b43ae91c113	5ea95ec0-e8cb-46a3-a7f8-f24c4d09e288	BACK	34dfddbe-4127-4f9c-8cf6-030669819dc4_20260510_094839 - Anwar Khan.jpg	image/jpeg	2417365	2026-05-11 03:41:02.929128
94d07e40-9924-406e-8d3f-18fc27804ac5	5ea95ec0-e8cb-46a3-a7f8-f24c4d09e288	SIDE	c11c5ccb-60fa-4ac1-84d2-e0e9c82a18bf_20260510_094832 - Anwar Khan.jpg	image/jpeg	2433353	2026-05-11 03:41:02.929128
b9bab44b-0dba-4bd4-8fd2-a6e4f5453e63	5ea95ec0-e8cb-46a3-a7f8-f24c4d09e288	FRONT	68677459-f211-4f6b-91a9-8bbfc8b9558d_20260510_094826 - Anwar Khan.jpg	image/jpeg	2471283	2026-05-11 03:41:03.183649
3fd54f89-3792-459f-80f1-6360024adb66	f65dfeb7-efcf-45cf-9004-1bdc6690a13c	BACK	8d1cd8c9-1e24-4319-954f-23ecf7ea69b6_IMG_8912 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	1274848	2026-05-12 03:22:47.019507
f618a434-2971-445b-bc0a-3ebd807e0c51	f65dfeb7-efcf-45cf-9004-1bdc6690a13c	FRONT	39a5d171-7f2a-4794-8f33-4aaba26a6bb4_IMG_8910 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	1721617	2026-05-12 03:22:47.019509
85aa2466-196d-4f85-9a21-c06bbb9d1908	f65dfeb7-efcf-45cf-9004-1bdc6690a13c	SIDE	d9b24011-0513-47bd-8632-b0770cc2a548_IMG_8911 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	1495007	2026-05-12 03:22:47.029951
6a02da3b-2deb-4b3e-832b-119209427b1a	208e8994-6759-477c-b50b-cf601ea3f371	FRONT	22b6685c-11af-45e6-a1aa-72d3a8c496cd_IMG_20260509_123852 - Prateek Srivastava.jpg	image/jpeg	680843	2026-05-12 03:23:50.391326
3bf44f37-b1cd-4feb-8aa1-8881d7ee36dc	208e8994-6759-477c-b50b-cf601ea3f371	BACK	3f3221fd-e449-4546-bdcd-204cb1e279ed_IMG_20260509_123907 - Prateek Srivastava.jpg	image/jpeg	781197	2026-05-12 03:23:50.401529
58dfbd99-0509-44a4-b572-64ea86f04b04	208e8994-6759-477c-b50b-cf601ea3f371	SIDE	61be4b82-fc87-429d-b7c2-de8c24f5fa50_IMG_20260509_123923 - Prateek Srivastava.jpg	image/jpeg	908980	2026-05-12 03:23:50.586524
86bdc551-6283-4474-9e82-1b09f0c71626	fcd30426-df26-470d-b419-a5725c8ed9c8	BACK	fd9f36aa-71e4-44cb-bfc8-c21b76c28697_20260511_132631 - Mayank Thakur.jpg	image/jpeg	1960912	2026-05-12 03:25:04.927713
a772850a-0301-4056-80b8-a95be5da1a1f	fcd30426-df26-470d-b419-a5725c8ed9c8	FRONT	f484f995-a6d0-4be9-b124-1f0b1abdb9b2_20260511_132636 - Mayank Thakur.jpg	image/jpeg	2247609	2026-05-12 03:25:06.812718
25ba2f0b-9834-4e49-8ed6-9a8d5a6c8a82	fcd30426-df26-470d-b419-a5725c8ed9c8	SIDE	e24f1f8a-c506-41cb-b4a7-ac29197c0985_20260511_132627 - Mayank Thakur.jpg	image/jpeg	2127789	2026-05-12 03:25:07.01636
5d51a2ca-7912-4f55-aed4-204246947f6a	84816486-778e-4189-a260-c3e9ac7ba662	SIDE	f0365a31-55b9-4781-98bd-d80c9b804cf4_20260211_122600 - Mayank Thakur.jpg	image/jpeg	1906460	2026-05-12 03:39:24.616591
ff7b9bfe-62de-4030-b226-7d635c06942f	84816486-778e-4189-a260-c3e9ac7ba662	BACK	21616f84-9b61-4847-9e40-c8e9e8942590_20260211_122532 - Mayank Thakur.jpg	image/jpeg	2090750	2026-05-12 03:39:25.517435
7de54566-a7bd-4cbf-9489-925e849d4728	84816486-778e-4189-a260-c3e9ac7ba662	FRONT	1c70f1da-a178-4f7c-9e16-f70901722b73_20260211_122500 - Mayank Thakur.jpg	image/jpeg	2135049	2026-05-12 03:39:27.42946
c0adbe3f-9623-4602-aa05-7eeee67a3b0e	e72e8b3b-4990-463d-8a35-d7ed9894e5ec	SIDE	34adfdf1-b1c9-4e27-a28c-db70612bb2e1_20260513_202427(1) - Prashant Kumar.jpg	image/jpeg	987124	2026-05-16 04:46:59.963379
167a3bad-75fe-4d2e-9461-d7620e0bc449	e72e8b3b-4990-463d-8a35-d7ed9894e5ec	FRONT	4f68244c-bb81-4f2e-9be9-ed4470d7be57_20260513_202604(1) - Prashant Kumar.jpg	image/jpeg	1164158	2026-05-16 04:47:00.11443
0bf1054a-89cf-48cb-b9c8-7eb8cc7d6325	e72e8b3b-4990-463d-8a35-d7ed9894e5ec	BACK	e33da9dc-253c-4e3c-8257-77874c85f067_20260513_202619(1) - Prashant Kumar.jpg	image/jpeg	1267964	2026-05-16 04:47:00.256819
\.


--
-- Data for Name: progress_checkins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.progress_checkins (id, member_id, coach_email, weight, diet_adherence, energy, steps_avg, notes, submitted_at, exercise_rating) FROM stdin;
13dc76b0-6178-40a3-8c38-56bed69dc114	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	63.00	10	\N	0	First checkin. No change, follow same diet and consistent workouts	2026-01-12 19:23:39.761	\N
e8c10f55-dbf2-4b10-b477-11dc4b1ec6e2	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	64.10	10	\N	8000	No change, follow same diet and consistent workouts	2026-01-24 10:34:36.917	\N
b464d553-88db-410a-a45c-1fbf1afaa4e8	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	63.90	7	\N	8000	10K Steps Daily	2026-03-21 13:19:40.703	6
f65dfeb7-efcf-45cf-9004-1bdc6690a13c	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	117.00	8	\N	9700		2026-05-09 16:44:49.44	6
c581c21f-6f63-4799-94c7-d3a97425389a	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	63.30	4	\N	9000	No change\nFollow the routine more strictly	2026-03-02 13:21:30.164	6
764d37e9-939a-41ce-93c4-776d39dca48e	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	64.30	6	\N	8000	Keep same diet and increase steps to 10000	2026-03-29 12:51:57.45	7
426cbff9-7846-4444-aed1-3e1eaae5adf0	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	59.20	7	\N	10000	Steps increased to 12k	2026-02-24 00:19:15.961	6
c9d7035e-6ad1-4091-88ac-76d582518292	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	59.00	6	\N	7000	Visible changes on lower body\nLower and Upper body getting in symmetry\nFollow more strict diet(9-10) and achive steps target	2026-04-06 11:50:35.911	6
3a2cba19-cbca-4536-91b1-5f168620e6c3	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	96.00	\N	\N	\N		2026-04-05 08:34:06	\N
fe63b854-44ab-4552-b22f-1ec9c97d5deb	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	95.00	8	\N	8000	Increase the steps to 10K	2026-04-19 08:34:06.405	7
88a4f483-cc9c-4ee0-ad37-0c34f1eecbfc	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	70.00	7	\N	5000		2026-03-30 13:28:11.222	3
84fa6785-d1ea-4771-a956-6d1c48298052	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	75.00	7	\N	\N		2026-01-17 11:57:51.523	6
d2a12fef-93d7-4a3d-9964-c0a1e6675992	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	76.00	3	\N	9000	Maintain Strict Diet \nIncrease steps to 12k Daily	2026-04-25 21:34:18.04	6
b78ce66f-930a-4220-b344-440dce5c8e67	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	64.30	5	\N	10490	Increase the calories by 100g	2026-04-12 12:37:59.367	7
e8e988b5-567b-47b1-a2fa-fa1494153775	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	68.00	8	\N	8000	Increase the step count to 10K daily	2026-04-27 00:16:10.873	5
e361147f-bbb9-4ebe-b940-ec8c2d291c4d	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	115.00	\N	\N	\N		2026-03-23 22:25:05.999	\N
bf2e3d64-e2ff-4ad5-a833-61b4cd311356	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	118.20	10	\N	6000	Increase the steps to 10k daily	2026-04-26 22:25:06.407	5
17204b69-1175-4762-9cd2-cd1739584138	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	59.00	\N	\N	\N		2026-03-23 22:25:05.999	\N
f38dc64b-4ad9-4275-af5d-f840eea12511	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	58.20	9	\N	\N	Increase the steps to 10k 	2026-04-27 07:00:20.608	4
e237c780-aa39-4331-8860-684d9b869b8f	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	95.20	8	\N	10000	Increase the steps to 12k and increase slight protein	2026-05-03 08:40:14.141	7
54354eb0-8a94-427b-bcca-ce321e663e68	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	73.00	\N	\N	\N		2026-05-04 04:14:51.565421	\N
5ea95ec0-e8cb-46a3-a7f8-f24c4d09e288	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	94.90	9	\N	10000	Good progress.\nMaintain same diet and steps for this week	2026-05-10 12:20:29.882	7
84816486-778e-4189-a260-c3e9ac7ba662	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	111.00	\N	\N	\N	first checkin	2026-03-18 18:30:00	\N
fcd30426-df26-470d-b419-a5725c8ed9c8	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	112.00	5	\N	2000	Start getting consistent and compete 8K steps daily	2026-05-11 13:30:29.705	5
208e8994-6759-477c-b50b-cf601ea3f371	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	63.80	1	\N	8000	Start getting back to routine and be consistent	2026-05-10 14:32:29.157	7
e72e8b3b-4990-463d-8a35-d7ed9894e5ec	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	67.40	8	\N	8000	Changes clearly visible now.\nSlight changes in diet plan	2026-05-14 02:13:27.541	6
\.


--
-- Name: checkin_photos checkin_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkin_photos
    ADD CONSTRAINT checkin_photos_pkey PRIMARY KEY (id);


--
-- Name: checkins checkins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkins
    ADD CONSTRAINT checkins_pkey PRIMARY KEY (id);


--
-- Name: daily_member_checkins daily_member_checkins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_member_checkins
    ADD CONSTRAINT daily_member_checkins_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: measurements measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT measurements_pkey PRIMARY KEY (id);


--
-- Name: progress_checkin_photos progress_checkin_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progress_checkin_photos
    ADD CONSTRAINT progress_checkin_photos_pkey PRIMARY KEY (id);


--
-- Name: progress_checkins progress_checkins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progress_checkins
    ADD CONSTRAINT progress_checkins_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_daily_member_checkins_member_coach_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_daily_member_checkins_member_coach_date ON public.daily_member_checkins USING btree (member_id, coach_email, check_in_date);


--
-- Name: idx_progress_checkin_photos_checkin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progress_checkin_photos_checkin_id ON public.progress_checkin_photos USING btree (check_in_id);


--
-- Name: ux_daily_member_checkins_member_date_coach; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ux_daily_member_checkins_member_date_coach ON public.daily_member_checkins USING btree (member_id, check_in_date, coach_email);


--
-- Name: checkin_photos checkin_photos_check_in_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkin_photos
    ADD CONSTRAINT checkin_photos_check_in_id_fkey FOREIGN KEY (check_in_id) REFERENCES public.checkins(id) ON DELETE CASCADE;


--
-- Name: measurements measurements_check_in_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT measurements_check_in_id_fkey FOREIGN KEY (check_in_id) REFERENCES public.checkins(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict b2pwEtaJmlPrPh4AWQtjnGNJgBIeQZaoFZbnorGaN3e7O9VOsvMu2K0FJDjtkRJ

--
-- Database "coach_diet" dump
--

--
-- PostgreSQL database dump
--

\restrict sB6iwq5bjwy6I6vxaP8gz3xTGWpoCuTyWhMyPYSsHEGMBVZPDTXaCqHY4ACIRSs

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: coach_diet; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE coach_diet WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE coach_diet OWNER TO postgres;

\unrestrict sB6iwq5bjwy6I6vxaP8gz3xTGWpoCuTyWhMyPYSsHEGMBVZPDTXaCqHY4ACIRSs
\connect coach_diet
\restrict sB6iwq5bjwy6I6vxaP8gz3xTGWpoCuTyWhMyPYSsHEGMBVZPDTXaCqHY4ACIRSs

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: diet_plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diet_plans (
    id uuid NOT NULL,
    member_id uuid NOT NULL,
    coach_email character varying(120) NOT NULL,
    title character varying(100) NOT NULL,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.diet_plans OWNER TO postgres;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: food_library_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.food_library_items (
    id uuid NOT NULL,
    food_item character varying(200) NOT NULL,
    calories numeric(10,2) NOT NULL,
    carbs numeric(10,2) NOT NULL,
    protein numeric(10,2) NOT NULL,
    fats numeric(10,2) NOT NULL,
    category character varying(30) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    CONSTRAINT food_library_items_calories_check CHECK ((calories >= (0)::numeric)),
    CONSTRAINT food_library_items_carbs_check CHECK ((carbs >= (0)::numeric)),
    CONSTRAINT food_library_items_fats_check CHECK ((fats >= (0)::numeric)),
    CONSTRAINT food_library_items_protein_check CHECK ((protein >= (0)::numeric))
);


ALTER TABLE public.food_library_items OWNER TO postgres;

--
-- Name: meal_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meal_items (
    id uuid NOT NULL,
    meal_id uuid NOT NULL,
    food_name character varying(200) NOT NULL,
    unit character varying(50),
    quantity integer,
    protein integer,
    carbs integer,
    fat integer,
    calories integer
);


ALTER TABLE public.meal_items OWNER TO postgres;

--
-- Name: meals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meals (
    id uuid NOT NULL,
    plan_id uuid NOT NULL,
    meal_name character varying(100) NOT NULL,
    order_index integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.meals OWNER TO postgres;

--
-- Data for Name: diet_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diet_plans (id, member_id, coach_email, title, notes, created_at, updated_at) FROM stdin;
9edc2473-b6e3-4fd4-bddf-cc65413e450d	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	Recomping Phase 1		2026-05-06 03:49:10.259386	2026-05-07 03:25:06.363973
df9fb82a-a780-4769-8951-8060fc7eb19d	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	Fat Loss Shailesh Phase 1(Drop 10 Kgs)		2026-03-28 10:40:27.576876	2026-05-12 04:09:37.515402
ee183b68-4fda-42c3-b63b-dcabc5d23c67	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	Fat Loss Anwar Phase 1		2026-04-07 03:42:35.704328	2026-05-12 04:14:06.543657
5016bd40-5cad-41b4-99dd-d8fc560908ff	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	Recomping Phase 1		2026-03-22 06:27:40.471627	2026-03-22 06:27:40.764438
b6a1fa02-c586-4272-af78-f72c88449da0	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	Fat Loss Vaishnavi Phase 1		2026-03-22 11:34:44.416099	2026-03-24 13:53:04.651586
f6473eb1-e9e8-480c-8015-3a21f7b98e3a	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	Fat Loss Mayank Phase 1(Drop 10 Kgs)		2026-03-21 08:49:02.376483	2026-03-24 13:59:33.706005
99a28bc0-ca4e-499f-bc22-cf6503583fcf	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	Fat Loss Phase 1 Shreya		2026-05-14 13:10:59.868721	2026-05-14 13:29:59.109748
572877d5-29fe-45ea-a926-f93cce8b9a17	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	Fat Loss Phase 1 Nitin		2026-05-14 03:05:52.031886	2026-05-14 13:30:12.945688
95e86798-dfa5-411b-b2c9-bffdc9745f6b	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	Fat Loss Khushbu Phase 1		2026-03-28 11:25:26.892291	2026-03-28 12:16:30.697254
85e2b7b2-318b-437c-873d-f2fac41559f9	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	Fat Loss Phase 1 Prashant		2026-05-17 07:41:03.50547	2026-05-17 08:24:31.536621
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	create diet tables	SQL	V1__create_diet_tables.sql	-770398939	postgres	2026-03-11 06:57:57.446796	391	t
2	2	update meal items macros.	SQL	V2__update_meal_items_macros..sql	-412408164	postgres	2026-03-11 06:57:58.440202	165	t
3	3	add calories meal item	SQL	V3__add_calories_meal_item.sql	376322885	postgres	2026-03-11 06:57:58.971232	38	t
4	4	create food library items	SQL	V4__create_food_library_items.sql	-393114217	postgres	2026-03-11 06:57:59.114414	217	t
5	5	food library macros to decimal	SQL	V5__food_library_macros_to_decimal.sql	-1412085447	postgres	2026-03-11 06:57:59.423267	1462	t
6	6	add meal order index	SQL	V6__add_meal_order_index.sql	-63755231	postgres	2026-03-11 06:58:00.973828	48	t
\.


--
-- Data for Name: food_library_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.food_library_items (id, food_item, calories, carbs, protein, fats, category, created_at, updated_at) FROM stdin;
ef66e984-2f9f-4365-92d1-5bfd0f49bf4b	Wheat Roti	100.00	20.00	3.00	0.50	CARBOHYDRATES	2026-03-21 09:00:59.744401	\N
7b74d8c3-aa62-4b1a-b827-cdbfc70ab0b5	Small Wheat Bran Roti	60.00	12.00	3.00	1.00	CARBOHYDRATES	2026-03-21 09:01:00.524553	\N
2c646cad-87a0-43f6-b223-97602968fad7	100g Rice	360.00	77.00	9.00	0.00	CARBOHYDRATES	2026-03-21 09:01:00.800756	\N
9a839904-3584-4f65-9fb4-6eefc954db55	100g Oats	389.00	75.00	17.00	7.00	CARBOHYDRATES	2026-03-21 09:01:01.175222	\N
1a227c95-8565-4371-9da5-7bc8fae2c876	100g Porridge/Daliya	362.00	60.00	11.00	9.00	CARBOHYDRATES	2026-03-21 09:01:01.496934	\N
76af1e08-a71e-4ff1-ad37-53a886f48245	Corn Flakes	373.00	85.00	8.00	1.00	CARBOHYDRATES	2026-03-21 09:01:01.559055	\N
c8c86f78-24c5-4349-a67e-49d2b8976929	Missi Roti	120.00	22.00	4.00	1.00	CARBOHYDRATES	2026-03-21 09:01:01.610644	\N
403e18b9-e736-40f4-91ca-b10236356351	Muesli	365.00	73.00	8.00	7.00	CARBOHYDRATES	2026-03-21 09:01:01.655096	\N
9891d2ee-f588-467f-b761-ddcd665a8a58	100g Poha	365.00	86.00	7.00	1.00	CARBOHYDRATES	2026-03-21 09:01:01.695912	\N
9c76c2d9-5acd-4ad9-bdf6-9529889e90d5	100g Potato	100.00	20.00	1.00	0.00	CARBOHYDRATES	2026-03-21 09:01:01.727506	\N
8e21d701-25ec-4b4a-a296-3536c69fd530	100g Sweet Potato	76.00	18.00	1.00	0.00	CARBOHYDRATES	2026-03-21 09:01:01.761178	\N
bb92774a-13cc-485f-b138-baaed6477d6c	Apple	100.00	25.00	0.00	0.00	CARBOHYDRATES	2026-03-21 09:01:01.822109	\N
0da4e9b7-5a6f-401c-88b2-77320f02e90b	Banana	90.00	23.00	1.00	0.00	CARBOHYDRATES	2026-03-21 09:01:01.857189	\N
620c3738-2bc2-483c-be82-4b40d9da5423	100g Mango	65.00	17.00	0.50	0.00	CARBOHYDRATES	2026-03-21 09:01:01.893456	\N
2d9c9579-4c65-4cae-8608-6e73b669ffe4	100g Papaya	40.00	10.00	0.00	0.00	CARBOHYDRATES	2026-03-21 09:01:01.967592	\N
f177a8d2-8ca1-4671-96c6-083b3b7a32d9	100g Pear	58.00	14.50	0.00	0.00	CARBOHYDRATES	2026-03-21 09:01:02.007615	\N
6843717c-4481-4a2f-a7b0-9c5e4b272682	100 Pineapple	48.00	12.50	0.00	0.00	CARBOHYDRATES	2026-03-21 09:01:02.060073	\N
27af0fd9-bb20-4304-a3c1-ac0715337b43	100g Grapes	70.00	18.00	1.00	0.10	CARBOHYDRATES	2026-03-21 09:01:02.122566	\N
41de57cf-1b63-4893-b90c-b2d37017e457	100g Watermelon	30.00	7.50	0.50	0.00	CARBOHYDRATES	2026-03-21 09:01:02.190624	\N
85a48c3b-01dd-4f7e-bd5b-7c542ad8911a	100g Pomegranate	68.00	17.50	1.00	0.00	CARBOHYDRATES	2026-03-21 09:01:02.236864	\N
8b68dec5-3df5-4099-b97e-062a8af329b8	100g Orange	47.00	12.00	1.00	0.00	CARBOHYDRATES	2026-03-21 09:01:02.272459	\N
53d6e5fd-0802-4a79-9b3b-ddb686d7d380	1 Kiwi	46.00	11.00	1.00	0.00	CARBOHYDRATES	2026-03-21 09:01:02.30206	\N
a64f930f-9f6d-482b-b8f0-4d5c2d9a50fc	100g Chiku	85.00	19.00	0.00	1.00	CARBOHYDRATES	2026-03-21 09:01:02.334557	\N
458ac309-73e6-450d-a5df-86f124fe70d5	100g Arbi	112.00	26.50	1.50	0.20	CARBOHYDRATES	2026-03-21 09:01:02.353008	\N
281239a4-a546-49da-ae9d-14305254434b	100g Bhindi	31.00	7.00	2.00	0.10	CARBOHYDRATES	2026-03-21 09:01:02.390897	\N
7e3dc3bb-a82a-4047-97b4-332a90871e79	100g Ghia / Bottlegourd	24.00	5.00	1.00	0.00	CARBOHYDRATES	2026-03-21 09:01:02.416772	\N
3d304087-bd8c-4429-a7f5-24d7c3963428	100g Brinjal	24.00	5.70	1.00	0.20	CARBOHYDRATES	2026-03-21 09:01:02.439619	\N
63450814-e6f2-4f1e-b269-8c51eb388ad0	100g Shalgam	28.00	6.43	0.90	0.10	CARBOHYDRATES	2026-03-21 09:01:02.464931	\N
85fb18aa-eeaa-4d3c-a29f-8531eaf24fd5	Coconut Water (250ml)	46.00	9.00	0.00	0.00	CARBOHYDRATES	2026-03-21 09:01:02.487011	\N
013d81f4-1e40-43a4-9204-1a16f3f97c4b	100g Raw Spinach	24.00	5.00	2.00	0.50	CARBOHYDRATES	2026-03-21 09:01:02.521702	\N
be52f5bd-272d-43f1-8212-3c26d96b0eed	1 Fig	21.00	5.37	0.20	0.08	CARBOHYDRATES	2026-03-21 09:01:02.544092	\N
98bd213d-ab1b-44b0-82b9-cc99de0a7d87	100g Curd	60.00	4.00	3.50	3.00	PROTEINS	2026-03-21 09:01:02.572025	\N
2fc28e2e-3618-4736-b08a-cef3c0a72a16	250ml Skimmed Milk	100.00	10.00	7.00	2.00	PROTEINS	2026-03-21 09:01:02.696374	\N
4b66fdf7-56a6-4e10-8f9a-90c06278b3ae	250 ml Full Cream Milk	160.00	12.00	8.00	8.00	PROTEINS	2026-03-21 09:01:02.729096	\N
3c6e7a65-7181-4dab-ba72-464113d4f670	100g Greek Yogurt	80.00	6.00	8.00	2.50	PROTEINS	2026-03-21 09:01:02.756864	\N
68ce2203-a9cb-4334-b718-344eef03a2fe	1 Bowl Boiled Rajma (100g)	125.00	23.00	8.50	0.50	PROTEINS	2026-03-21 09:01:02.781402	\N
fdb218ce-7c10-4153-bb07-748a6a9b32a3	1 whole egg	75.00	0.00	6.00	5.00	PROTEINS	2026-03-21 09:01:02.804136	\N
4e8a5267-dfa7-48af-95d6-b20906179bbc	1 egg white	17.00	0.00	3.40	0.00	PROTEINS	2026-03-21 09:01:02.826655	\N
b2b5d748-bfd1-4110-a471-3310181412de	100g Chicken Breast	110.00	0.00	24.00	2.00	PROTEINS	2026-03-21 09:01:02.852524	\N
78bfe2a1-f13e-4b1a-8473-aea387e9ff5c	100g Chicken Thigh	245.00	0.00	24.00	13.00	PROTEINS	2026-03-21 09:01:02.876289	\N
6bd9f383-df8e-4f16-83c5-5cda8bcb4006	Fish per 100g	170.00	0.00	20.00	10.00	PROTEINS	2026-03-21 09:01:02.89955	\N
2c9a2c5b-cc01-4123-b640-b19f4a6f6c9e	Whey Protein	120.00	2.00	24.00	1.00	PROTEINS	2026-03-21 09:01:02.933348	\N
4b685939-3d6b-479d-866c-7a8096846874	100g Mutton	200.00	0.00	20.00	13.00	PROTEINS	2026-03-21 09:01:02.975538	\N
0dee8d39-892e-4b20-a78e-f0885e79d530	100g Paneer	265.00	1.00	18.00	20.00	PROTEINS	2026-03-21 09:01:03.009822	\N
d6344db7-b506-4603-92f4-bbc503c639c3	1 Max Protein Bar	222.00	13.00	20.00	10.00	PROTEINS	2026-03-21 09:01:03.047284	\N
fd8fe541-4453-4e64-80bc-f3b6872d1836	Hallumi Cheese 100g (Kuwait)	316.00	1.60	20.80	24.70	PROTEINS	2026-03-21 09:01:03.080417	\N
f015d536-2997-4628-be26-a168e51e451b	10 almonds	70.00	2.50	2.50	6.00	FATS	2026-03-21 09:01:03.116849	\N
0ecda226-4398-4741-9724-a5871895bdf7	1 Walnuts	26.00	0.50	0.60	2.50	FATS	2026-03-21 09:01:03.145468	\N
302363ab-917d-4eb2-9b4a-66c82a482edf	10g cashew	60.00	3.00	1.50	5.00	FATS	2026-03-21 09:01:03.184362	\N
2c41593c-4a53-49f3-af8d-30584796d928	Tender Coconut (100 g)	354.00	15.00	3.33	33.50	FATS	2026-03-21 09:01:03.211444	\N
f6d3eae2-3759-44d1-ae27-4c485f2616bb	1 Teaspoon Flax seed / Alsi	18.00	1.98	0.62	1.43	FATS	2026-03-21 09:01:03.237096	\N
dfa75fdd-f9d8-42ed-b2c7-33ee433af902	1 Tea Spoon Chia Seeds	34.00	3.00	1.00	2.00	FATS	2026-03-21 09:01:03.261478	\N
dcc813c9-a760-4251-a8fd-a0444de115a3	15g Peanut Butter	94.00	3.00	4.00	8.00	FATS	2026-03-21 09:01:03.281612	\N
ded58e38-1719-4105-804a-28885f097940	1 cheese slice	61.00	0.00	4.00	5.00	FATS	2026-03-21 09:01:03.305654	\N
606964c5-800d-455d-a3e5-02299776a91d	1 Teaspoon desi ghee (5g)	45.00	0.00	0.00	5.00	FATS	2026-03-21 09:01:03.326963	\N
b11bbdca-0920-4aeb-85ab-3cc3b4c08355	Butter (10g)	90.00	0.00	0.00	10.00	FATS	2026-03-21 09:01:03.355288	\N
24fcf8c5-b900-4034-9902-0a6d83c279ee	Amul Fresh Cream (per 50g gram)	130.00	1.00	1.00	13.50	FATS	2026-03-21 09:01:03.379793	\N
0fd07304-88bb-4936-991d-2d3ad44ebde4	Mustard Oil (1 Tablespoon)	126.00	0.00	0.00	14.00	FATS	2026-03-21 09:01:03.401022	\N
6ecc11a9-4fb7-46fa-8f13-e324c780d5cc	10g Sugar	40.00	40.00	0.00	0.00	CARBOHYDRATES	2026-03-21 09:04:37.532806	\N
ce3176bc-8394-4b60-af34-0b3d1fe2b32e	100 g Urad Daal	350.00	58.00	25.00	1.50	CARBOHYDRATES	2026-03-21 09:11:14.205404	\N
381bee45-bca8-4b2a-b975-437ace6bb0d0	1 Hide and Seek Bisuits	39.00	7.00	2.00	0.70	CARBOHYDRATES	2026-03-21 09:16:58.529441	\N
03f2f97c-9a7d-44f8-88f2-424bc27b9e80	100g Whole Wheat Flour	340.00	72.00	13.00	2.00	CARBOHYDRATES	2026-03-21 09:19:55.946364	\N
42c2d1b1-0473-45a7-83f1-811fd90243de	100g Cooking Oil	884.00	0.00	0.00	100.00	FATS	2026-03-21 10:43:24.210074	\N
993e82be-6d04-4c6c-a892-da9729a49390	100g Besan	390.00	60.00	22.00	7.00	CARBOHYDRATES	2026-03-22 12:02:10.175761	\N
7800f811-c591-42c2-8979-56d964539067	100g Rava/Sooji	370.00	75.00	13.00	2.00	CARBOHYDRATES	2026-03-22 12:00:29.459587	2026-03-22 12:08:56.91319
bf6e6ca0-b2e5-4656-9c34-3f111e7c5633	100g Soya Chunks	350.00	33.00	52.00	1.00	PROTEINS	2026-03-22 12:14:18.91839	\N
818cce85-5d21-4d80-a388-7352b592a5b2	100g Tofu	80.00	3.00	10.00	5.00	PROTEINS	2026-03-22 12:15:04.857135	\N
fef8c66f-9cff-4826-9802-5fc082c7714d	1 Brown Bread	80.00	15.00	3.00	1.00	CARBOHYDRATES	2026-03-28 10:46:08.644887	\N
bbd7cc3f-3acb-4da9-9e43-7038f84d309f	100g Peanuts	580.00	16.00	26.00	50.00	FATS	2026-03-28 11:58:43.970983	\N
9ad6cf7a-0e1d-4f67-a743-1b63a8f8f1d8	100g Chana	370.00	60.00	19.00	6.00	CARBOHYDRATES	2026-03-28 12:00:40.257377	\N
041a31be-132e-43c6-ae00-8cc0ec9afad5	1g Black Coffee	2.50	0.00	0.00	0.00	CARBOHYDRATES	2026-03-28 10:52:17.822807	2026-04-07 03:51:58.624133
8568a8a8-21f5-406d-a4f2-9c0e3a545692	100g Roasted Chana	380.00	60.00	22.00	6.00	CARBOHYDRATES	2026-05-12 04:07:02.729115	2026-05-12 04:08:07.032923
\.


--
-- Data for Name: meal_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meal_items (id, meal_id, food_name, unit, quantity, protein, carbs, fat, calories) FROM stdin;
1e7e4236-8ca8-44d8-8351-456badc7349b	1cd1a0d7-69d1-441f-9bc5-95685f6eb62c	Apple	serving	1	0	25	0	100
32ca0f31-c0d4-4e62-95df-a13929c4a65b	b09a6a04-f978-43d1-896d-28bddc24e26d	60g Poha/Upma/Daliya/2 Bread/Rice/Whole Wheat Flour Roti	g	60	4	51	0	219
55db62aa-b7b6-4dcc-ab29-705be82c76ee	b09a6a04-f978-43d1-896d-28bddc24e26d	2 whole egg	whole	2	12	0	10	150
c08eb8e4-9fd3-459e-9d89-b5133a04550b	28e75678-4f82-4099-9d45-e38f85215b21	70g Poha/Upma/Daliya/Chila/2 Brown Bread	g	70	4	60	0	255
a5bcb427-c515-4002-bd14-d9678fbbd798	28e75678-4f82-4099-9d45-e38f85215b21	2 whole egg	whole	2	12	0	10	150
01b831a0-1f66-4dad-8c3f-426c3815affb	28e75678-4f82-4099-9d45-e38f85215b21	10g Cooking Oil	g	10	0	0	10	88
42896503-206d-4d89-b038-41476d03703a	3b5d9dc7-5ecd-4eb1-ab00-f718ff2a425f	70g Rice/Whole Wheat Flour	g	70	6	53	0	252
3c311811-c612-4762-86d7-902b4fae629a	3b5d9dc7-5ecd-4eb1-ab00-f718ff2a425f	50g Chicken Breast/25g Soya Chunks/3 egg whites	g	50	12	0	1	55
87d8e84a-c41f-4d32-bab2-80da703e68de	3b5d9dc7-5ecd-4eb1-ab00-f718ff2a425f	200g Raw or Cooked Vegetables	g	200	4	10	1	48
16ee4e63-2d04-4d99-b03e-61fa3fc819a6	3b5d9dc7-5ecd-4eb1-ab00-f718ff2a425f	200g Curd	g	200	7	8	6	120
31ab0c3b-be8c-4023-8e7f-85909333e550	3b5d9dc7-5ecd-4eb1-ab00-f718ff2a425f	10g Cooking Oil	g	10	0	0	10	88
0f309531-039d-44a7-936b-529b693ca338	3b5d9dc7-5ecd-4eb1-ab00-f718ff2a425f	60g Daal	g	60	15	34	0	210
fb214b59-b7d4-43af-9287-b0cc54f59e25	ad3a8032-b8ff-49a9-8307-ac56317f39d0	Whey Protein	serving	1	24	2	1	120
d481ccfa-5bcc-43e5-836e-f01b61f16a86	ad3a8032-b8ff-49a9-8307-ac56317f39d0	100g Greek Yogurt/Curd	g	100	8	6	2	80
c0ba5287-66bb-482c-88f7-54d3d33c9388	ad3a8032-b8ff-49a9-8307-ac56317f39d0	1 Apple	serving	1	0	25	0	100
ac77d936-e8bf-48f0-8f4b-b4e20e44308e	83ff651c-df53-40e6-b976-d25d7322d05f	70g Rice/Whole Wheat Flour	g	70	6	53	0	252
c8a47946-5e2f-4c93-8540-58a6817eaed3	83ff651c-df53-40e6-b976-d25d7322d05f	100g Paneer/3 Whole Eggs	g	100	18	1	20	265
cacde816-6dda-4535-b357-94c387226aad	83ff651c-df53-40e6-b976-d25d7322d05f	200g Raw or Cooked Vegetables	g	200	4	10	1	48
ae6a6dea-b987-4b3f-84a8-a9ecc3bd2e9c	83ff651c-df53-40e6-b976-d25d7322d05f	10g Cooking Oil	g	10	0	0	10	88
befe9e80-ea13-4ee2-b9c9-9d860defe147	b09a6a04-f978-43d1-896d-28bddc24e26d	2 egg white	egg	2	6	0	0	34
642d3be3-d560-4991-b8fa-00daf5a92b38	b09a6a04-f978-43d1-896d-28bddc24e26d	150g Curd	g	150	5	6	4	90
c6ec9c30-c0af-424d-aac0-a3589cbf6467	98a8048a-eb67-4c2f-8c67-7dcc3e1d84e5	Cooking Oil	g	5	0	0	5	44
9c8d27cb-784c-471e-9a7a-a2f7d93d1f05	b09a6a04-f978-43d1-896d-28bddc24e26d	1 cheese slice	cheese	1	4	0	5	61
fff54346-6a2f-4480-9bf6-bca2176e771a	b09a6a04-f978-43d1-896d-28bddc24e26d	200g Raw or Cooked Vegetables	g	200	4	10	1	48
ad5cadc7-6beb-42c3-996a-362cb0063602	b09a6a04-f978-43d1-896d-28bddc24e26d	5g Cooking Oil/Butter/Ghee	g	5	0	0	5	44
a5dfbfc9-1473-4c29-b9b8-135425deaffc	6dff970c-bed7-4479-a345-33031ad31256	Whey Protein	serving	1	24	2	1	120
a1668825-d64d-4a45-949f-f69fa0b86e21	6dff970c-bed7-4479-a345-33031ad31256	40g oats/ 40g poha/ 40g rava/ 2 slices whole wheat bread	g	40	2	34	0	146
5f990162-ae9c-41cd-a442-ebdcb6e06977	479895f2-4ba6-4ba5-b956-1f4840aa53c2	100g Paneer/3 Whole Eggs	g	100	18	1	20	265
0860c1b6-5c72-4be2-8a2e-cffbd552cda4	479895f2-4ba6-4ba5-b956-1f4840aa53c2	5g Cooking Oil/Butter/Ghee	g	5	0	0	5	44
2363c963-1069-4285-8170-8a2656545b96	479895f2-4ba6-4ba5-b956-1f4840aa53c2	200g Raw or Cooked Vegetables	g	200	4	10	1	48
530e10c9-c79b-403a-b068-6b3f1d4cab78	479895f2-4ba6-4ba5-b956-1f4840aa53c2	60g Rice/Whole Wheat Flour Roti	g	60	5	46	0	216
ff95d211-3fc8-4d3c-9258-9dbbd7aa36cf	479895f2-4ba6-4ba5-b956-1f4840aa53c2	40g Any Dal / Rajma / Chole	g	40	10	23	0	140
182d576f-371f-46a4-86ba-58c53a33fa29	a9716b19-60f3-418c-8fd8-c513a720cf02	50g Poha/Upma/Vermicilli/Oats/Wheat Flour(for paratha)/2 Brown Bread(for sandwitch)	g	50	3	43	0	182
d69d927a-1373-4dc8-afe9-ed3b751aa4df	a9716b19-60f3-418c-8fd8-c513a720cf02	5g Cooking Oil	g	5	0	0	5	44
cdaf63e3-4d81-44cf-a2de-394df4534bb8	a9716b19-60f3-418c-8fd8-c513a720cf02	15g Chana	g	15	2	9	0	55
9bb3aa92-b356-457b-97ac-33fc4b9021c0	94dc65fe-5c8a-4a5d-a76c-e21e00b18116	100g Curd	g	100	3	4	3	60
f3bf5566-3e0a-4475-a582-7f663a5caf17	94dc65fe-5c8a-4a5d-a76c-e21e00b18116	50g Whole Wheat Flour	g	50	6	36	1	170
6b49c84e-f377-41dc-b1ac-6a14cbf2398f	94dc65fe-5c8a-4a5d-a76c-e21e00b18116	50g Paneer	g	50	9	0	10	132
eed36898-1669-4c6e-b509-4da49951e262	94dc65fe-5c8a-4a5d-a76c-e21e00b18116	200g Raw or Cooked Vegetables	g	200	4	10	1	48
ea592104-5aa2-47a9-bb0b-6706c6bfc789	94dc65fe-5c8a-4a5d-a76c-e21e00b18116	5g Cooking Oil	g	5	0	0	5	44
bafbf0ca-9e88-4cbd-8e5d-1afe5f1cfe0b	a7bfe4e0-7f96-4938-9c34-7e1627671ba1	10g Peanuts	g	10	2	1	5	58
e48bee3a-cd78-4098-a856-6285d093ec7f	a7bfe4e0-7f96-4938-9c34-7e1627671ba1	10g Chana	g	10	1	6	0	37
ac091c3c-b341-4964-b275-97d70e9ffa13	a7bfe4e0-7f96-4938-9c34-7e1627671ba1	150 ml Milk (for Tea)	ml	150	4	7	4	96
4a337d7a-76f5-4c07-acd8-ee1e8488c968	a7bfe4e0-7f96-4938-9c34-7e1627671ba1	5g Sugar	g	5	0	20	0	20
df851843-84d9-44cb-9520-154f4c2cc219	558e045a-296e-4fd7-a171-437a560a4862	50g Rice	g	50	4	38	0	180
6c371a11-7b51-4497-88d3-be3ba9bad9c8	558e045a-296e-4fd7-a171-437a560a4862	200g Raw or Cooked Vegetables	g	200	4	10	1	48
c24a2f7d-ace7-4038-aa60-2db08c3a787c	558e045a-296e-4fd7-a171-437a560a4862	5g Cooking Oil	g	5	0	0	5	44
d58d6145-d46c-4113-907e-bf30dfc098b1	558e045a-296e-4fd7-a171-437a560a4862	40g Daal/Rajma/Chole	g	40	10	23	0	140
244b39f8-fd91-400f-a11a-c891413d57e3	40b23d87-95a6-4916-98c7-9aee66edd557	Poha/Rava/Sooji(for Upma)/Upma/Besan Chila/Dosa / Idli [[OPT:upma | besan | dosa | idli]]	g	50	3	43	0	182
bb4bd95d-7f01-4599-8914-858559face23	40b23d87-95a6-4916-98c7-9aee66edd557	Cooking Oil	g	10	0	0	10	44
73c93795-bae7-4fe6-bd13-e358f1104214	40b23d87-95a6-4916-98c7-9aee66edd557	Apple	serving	1	0	25	0	100
3ed6adb9-e8fb-41a5-bb9d-18ba97592940	40b23d87-95a6-4916-98c7-9aee66edd557	Almonds	almonds	5	1	1	3	35
9b43e2d4-c2ac-48e2-a678-292ad75103b2	a91fa504-270c-4689-833c-dd084bf1725a	Rice(Raw)	g	20	4	38	0	180
223f31ec-b585-4410-a6d4-d3f83a79ddba	a91fa504-270c-4689-833c-dd084bf1725a	Whole Wheat Flour(Raw)	g	50	6	36	1	170
c398c836-22b5-4b75-b4a8-9da520406be9	a91fa504-270c-4689-833c-dd084bf1725a	Soya Chunks	g	60	31	19	0	210
4802b4f7-4fdb-459b-8876-bc859bc3de0b	a91fa504-270c-4689-833c-dd084bf1725a	Cooking Oil	g	5	0	0	5	44
94234255-ccc2-403b-a4df-2c359531c2d8	558e045a-296e-4fd7-a171-437a560a4862	20g Soya Chunks	g	20	10	6	0	70
ea323c04-0f54-4983-98ed-0c5c453469e1	12342268-2603-4725-8c5b-aa77f70dbed0	50g Poha/Upma/Vermicilli/Oats/Wheat Flour(for paratha)/2 Brown Bread(for sandwitch)	g	50	3	43	0	182
080cad00-a205-4f9a-a5d7-7c05bf7c8b74	12342268-2603-4725-8c5b-aa77f70dbed0	5g(1table spoon) Black Coffee	g	5	0	0	0	20
b61264af-e655-4a7a-a4fa-e45a38ff48f4	12342268-2603-4725-8c5b-aa77f70dbed0	1 whole egg	egg	1	6	0	5	75
8f272af2-b7b8-4190-aa31-7356e4b22977	12342268-2603-4725-8c5b-aa77f70dbed0	5g Cooking Oil	g	5	0	0	5	88
6bd7024a-e121-4aa1-b10f-17333b841fb6	12342268-2603-4725-8c5b-aa77f70dbed0	1 Apple	serving	1	0	25	0	100
d36b3ec2-d543-482a-bdb5-32c04757d939	12342268-2603-4725-8c5b-aa77f70dbed0	2 egg white	egg	2	6	0	0	34
4b255c56-b32c-45c7-b46a-e05658a1768b	64f46d85-3dc0-461d-b5f1-240083afb0f1	60g Whole Wheat Flour	g	60	7	43	1	204
6261df02-98d0-4c40-8744-105c2838bebe	64f46d85-3dc0-461d-b5f1-240083afb0f1	200g Raw/Cooked Vegitable	g	200	4	10	1	48
d8ee2580-1a58-4169-a43a-214fc7af681a	64f46d85-3dc0-461d-b5f1-240083afb0f1	100g Paneer	g	100	18	1	20	265
e81188db-37dc-4b94-a4b8-1ed4b9ec2c65	64f46d85-3dc0-461d-b5f1-240083afb0f1	5g Cooking Oil	g	5	0	0	5	44
ae8db8e1-1776-4263-9798-87ccdfa0e03a	64f46d85-3dc0-461d-b5f1-240083afb0f1	100g Curd	g	100	3	4	3	60
943d1083-1cc8-448f-ad2d-321ea85f8c4f	7eb24793-b593-413a-8a80-84633091abfa	150 ml Milk(for Tea)	ml	150	4	7	4	96
7a98f1c1-beec-4889-bb45-3e873ede70fd	7eb24793-b593-413a-8a80-84633091abfa	5g Sugar(for Tea)	g	5	0	20	0	20
81a57254-fb4b-452b-ad74-35f26511fa3a	7eb24793-b593-413a-8a80-84633091abfa	Apple	serving	1	0	25	0	100
a9037865-e573-45bb-a992-91f4fd7cf468	7eb24793-b593-413a-8a80-84633091abfa	15g Roasted Chana	g	15	3	9	0	57
cefbc986-8203-4f76-b74d-c8ae19c5056f	9c0f1b41-261c-44fd-ba4c-b3756e140744	60g Rice	g	60	5	46	0	216
9f73bffc-3c68-41c9-9368-485ff70bde8c	a91fa504-270c-4689-833c-dd084bf1725a	Raw or Cooked Veggies	g	200	4	10	1	48
a8e198b9-b94f-4f6b-bcc9-3281aa5484e4	a48a8793-ccfa-48d6-9690-f80b61c7381e	Whole Wheat Flour	g	50	6	36	1	170
48412dd9-3fc0-46ca-876d-fa86090798da	a48a8793-ccfa-48d6-9690-f80b61c7381e	Tofu	g	150	15	4	7	120
142b598c-4801-4ea2-9442-c63efe95520d	a48a8793-ccfa-48d6-9690-f80b61c7381e	Cooking Oil	g	10	0	0	10	88
8db65a74-9ab1-4f56-8b94-40b877f40994	a48a8793-ccfa-48d6-9690-f80b61c7381e	Raw or Cooked Veggies	g	200	4	10	1	48
763b279e-6612-4542-b40e-fcf01af01ddb	b726ff84-3fb7-4e7d-aced-c1588daee22d	Full Cream Milk	ml	150	4	7	4	96
b924306f-4aa6-4bd9-a49c-15269041c232	b726ff84-3fb7-4e7d-aced-c1588daee22d	Sugar	g	5	0	20	0	20
cc4136ac-0b50-4fbd-a506-fd395b4944c5	b726ff84-3fb7-4e7d-aced-c1588daee22d	Rice(For Dosa/Idli)	g	30	2	23	0	108
f0ca2b70-10e9-442e-8177-16ccefaddf94	b726ff84-3fb7-4e7d-aced-c1588daee22d	Urad Daal(For Dosa/Idli)	g	15	3	8	0	52
c28af338-a7ef-4c18-b08b-74461bd77f24	b726ff84-3fb7-4e7d-aced-c1588daee22d	Brown Bread	serving	2	6	28	2	150
50bdbeaf-3441-4d70-8986-d9558b0987a4	b726ff84-3fb7-4e7d-aced-c1588daee22d	Whole egg	whole	1	6	0	5	75
d435e4ca-2b05-4e26-bc11-d950835ef639	b726ff84-3fb7-4e7d-aced-c1588daee22d	Hide and Seek Bisuits	serving	2	4	14	1	78
14c97203-ccad-4306-a468-4a18f089e172	b726ff84-3fb7-4e7d-aced-c1588daee22d	Cheese slice	cheese	1	4	0	5	61
1f4ce9e1-3cbc-4467-bc95-66e8286fcdf3	b726ff84-3fb7-4e7d-aced-c1588daee22d	Cooking Oil	g	5	0	0	5	44
f556c7e6-5ff3-4253-9aa1-78e782c492f0	b726ff84-3fb7-4e7d-aced-c1588daee22d	60g Oats/Museli/ Dosa/ Idli (30gRice + 15g Urad Daal)/2 Brown Bread	g	60	10	45	4	233
a12ecdd0-b028-4b9a-b3d3-629a6662ec32	cc84f1e9-8862-4520-b88c-db30c8a244c0	Whole Wheat Flour	g	60	7	43	1	204
08eb8897-38a8-464f-864a-8ad3ed38bde3	cc84f1e9-8862-4520-b88c-db30c8a244c0	Green Veggies	g	200	3	3	0	24
c9e6e0af-4ef9-4c90-af63-9918e738962b	cc84f1e9-8862-4520-b88c-db30c8a244c0	Curd	g	100	3	4	3	60
3724e78f-7187-4f94-8e4f-f07c1aa11421	cc84f1e9-8862-4520-b88c-db30c8a244c0	Paneer / 3 Whole Eggs	g	100	18	1	20	265
7edb97b5-b0a0-4b5a-997c-dc7a961aac2b	cc84f1e9-8862-4520-b88c-db30c8a244c0	Cooking Oil	g	5	0	0	5	44
8e288c26-ed3e-488c-baee-388f6c502b3a	26d7d68f-824b-427a-a499-3d5188a2d32c	Apple	piece	1	0	25	0	100
a31d3933-a7f9-4ca5-a48b-9cd04666ec1e	26d7d68f-824b-427a-a499-3d5188a2d32c	Almonds	piece	5	1	1	3	35
a2cb1c4f-4376-47ed-9394-5d9d1fe64bd3	26d7d68f-824b-427a-a499-3d5188a2d32c	Cashew	g	10	1	3	5	60
113b0d60-d71c-4566-92d1-9c407b83c4f3	98a8048a-eb67-4c2f-8c67-7dcc3e1d84e5	Rice	g	60	5	46	0	216
a84dbb06-cb09-4ea8-b804-737adf94fcc1	98a8048a-eb67-4c2f-8c67-7dcc3e1d84e5	Green Veggies	g	200	3	3	0	24
cea4fac8-35f4-495c-bfb6-d7ca88a31da6	98a8048a-eb67-4c2f-8c67-7dcc3e1d84e5	Urad Daal	g	50	12	29	0	175
653a7e4d-f44b-46f7-b5c0-37eac71a07e3	98a8048a-eb67-4c2f-8c67-7dcc3e1d84e5	Chicken Breast / 6 Egg Whites	g	100	24	0	2	110
137ed375-2b9f-4734-8a57-72596d556bf3	9c0f1b41-261c-44fd-ba4c-b3756e140744	50g Daal/Rajma/Chole	g	50	12	29	0	175
c1ea6f3a-f4c8-46c2-ae54-8cc501bc7ae8	9c0f1b41-261c-44fd-ba4c-b3756e140744	5g Cooking Oil	g	5	0	0	5	44
a36fc469-bfda-48e5-b49e-5cb3fc939b81	9c0f1b41-261c-44fd-ba4c-b3756e140744	200g Raw Spinach	g	200	4	10	1	48
ada8f69b-88da-43f7-aa30-cc83fb5826bf	9c0f1b41-261c-44fd-ba4c-b3756e140744	5 egg white/25g Soya Chunks	egg	5	17	0	0	85
aa60510e-c196-4d7e-a0ea-853fa2b224a8	4388b07e-3b58-4125-9e6c-b77869da0930	60g Poha/Upma/Daliya/2 Bread	g	60	4	51	0	219
aebce9af-08d2-431a-bb59-2e5d2588b1c9	4388b07e-3b58-4125-9e6c-b77869da0930	1 whole egg	whole	1	6	0	5	75
5e829758-68c8-4cac-8b69-36ddc3e9f80c	4388b07e-3b58-4125-9e6c-b77869da0930	5 almonds	almonds	5	1	1	3	35
fe81fa0f-5b36-45f9-9c10-697ac63c27d8	4388b07e-3b58-4125-9e6c-b77869da0930	5g Black Coffee	g	5	0	0	0	12
e146eee9-6af1-40e6-b699-75107792bc66	4388b07e-3b58-4125-9e6c-b77869da0930	5g Cooking Oil	g	5	0	0	5	44
a6f1b320-dcf1-49eb-b1cb-40ea31957e6a	4388b07e-3b58-4125-9e6c-b77869da0930	4 egg white	egg	4	13	0	0	68
4f85887a-6ff5-46d9-9d80-cfcf0f75c566	51cb4fa8-6b4a-4e9a-a496-4c20da50049d	60g Rice/Whole Wheat Flour Roti	g	60	5	46	0	216
86db4edb-88bf-40b7-87d6-f2380fffc388	51cb4fa8-6b4a-4e9a-a496-4c20da50049d	100g Chicken Breast/50g Soya/6 Egg Whites	g	100	24	0	2	110
f69462dd-c033-4741-8001-b4ad10510fe8	51cb4fa8-6b4a-4e9a-a496-4c20da50049d	200g Raw or Cooked Vegetable	g	200	4	10	1	48
9cd9e203-8c25-4cee-ba6c-d76eddd981d7	51cb4fa8-6b4a-4e9a-a496-4c20da50049d	5g Cooking Oil	g	5	0	0	5	44
b9e6d2f1-0191-4722-882f-b854350558f2	51cb4fa8-6b4a-4e9a-a496-4c20da50049d	300g Curd	g	300	10	12	9	180
dcf1277c-4510-4a92-9daa-a8a897bb3fbc	51cb4fa8-6b4a-4e9a-a496-4c20da50049d	50g Daal/Rajma/Chole	g	50	12	29	0	175
4c34d166-b63e-461b-82e9-6d939e4cd0dc	c526cbdb-4b0d-4c5c-bdb3-6d2e9afb94b7	5g Black Coffee	g	5	0	0	0	12
2aab6ba8-cf54-4ddc-a617-adfe21eee188	c526cbdb-4b0d-4c5c-bdb3-6d2e9afb94b7	150 ml Full Cream Milk	ml	150	4	7	4	96
faba47de-3453-43ed-8dbf-d72b1b57d35b	c526cbdb-4b0d-4c5c-bdb3-6d2e9afb94b7	5g Sugar	g	5	0	20	0	20
e0a6df4a-35b5-4b30-a54c-598c43e1b546	c526cbdb-4b0d-4c5c-bdb3-6d2e9afb94b7	2 Brown Bread	Brown	2	6	30	2	160
94ea939e-16c0-4793-afe0-c279d70869e5	82d7241f-e5e5-4317-afff-5cce2b2cafd5	60gRice/Whole Wheat Flour Roti	g	60	7	43	1	204
69735907-01d6-4ba9-b920-1a41cbe30143	82d7241f-e5e5-4317-afff-5cce2b2cafd5	100g Paneer/3 Whole Eggs	g	100	18	1	20	265
175b6d95-2e96-4cb4-ac75-4b4aa0e14a83	82d7241f-e5e5-4317-afff-5cce2b2cafd5	200g Raw or Cooked Vegetable	g	200	4	10	1	48
d0e05a7c-3331-4480-908f-c1e4bd090379	82d7241f-e5e5-4317-afff-5cce2b2cafd5	5g Cooking Oil	g	5	0	0	5	44
528f6cfe-3aab-417a-a213-4bf752b8b24c	088a050b-3a8b-42ad-afd8-f8ca7ff44d3a	5g Black Coffee	g	5	0	0	0	12
4e4b8485-d335-4aa2-a075-9f2ab8331610	e44e0992-0cf3-4037-9870-ccd9b563d783	60g Poha/Upma/Vermicilli/Oats/Wheat Flour(for paratha)/2 Brown Bread(for sandwitch)	g	60	4	51	0	219
e80159a9-60ed-4c88-8868-fb60206a6633	e44e0992-0cf3-4037-9870-ccd9b563d783	1 whole egg	whole	1	6	0	5	75
e4248d82-75f8-43dd-93a0-d3a563c3e60e	e44e0992-0cf3-4037-9870-ccd9b563d783	2 egg white	egg	2	6	0	0	34
0cb83ec7-3d60-4708-90b6-8d23b36ccea3	e44e0992-0cf3-4037-9870-ccd9b563d783	5g Cooking Oil	g	5	0	0	5	44
0232d7da-6f87-4693-a5e5-45a232f93487	e44e0992-0cf3-4037-9870-ccd9b563d783	Whey Protein	serving	1	24	2	0	120
b6d11e29-c8a3-4410-a79d-679a75f529a6	b39f95a7-bc4c-41eb-a5d8-a05ac83c76d0	60g Rice/60g Whole Wheat Flour	g	60	5	46	0	216
3b378d90-380d-4179-812d-1cf8455ba18c	b39f95a7-bc4c-41eb-a5d8-a05ac83c76d0	200g Raw/Cooked Vegetable	g	200	4	10	1	48
5c77605e-cc6a-4ec9-8c9e-407502cc6770	b39f95a7-bc4c-41eb-a5d8-a05ac83c76d0	100g Paneer/3Whole Eggs	g	100	18	1	20	265
16263916-808f-4846-8043-73efbc7869f1	b39f95a7-bc4c-41eb-a5d8-a05ac83c76d0	5g Cooking Oil	g	5	0	0	5	44
09d50db8-f54b-446f-a7e3-64884426dfa9	b39f95a7-bc4c-41eb-a5d8-a05ac83c76d0	100g Curd	g	100	3	4	3	60
cce4cff5-1f08-4471-879c-4c0686539aad	b39f95a7-bc4c-41eb-a5d8-a05ac83c76d0	50g Daal/Rajma/Chole	g	50	12	29	0	175
fb060d53-12c6-4126-b8c9-b7f35f2adc1f	a1f531c4-457c-4856-9026-90d7ccb09711	5g Tea	g	5	0	0	0	0
1bd57a27-cfc3-4e33-8903-28cbb48f221b	a1f531c4-457c-4856-9026-90d7ccb09711	5g Sugar	g	5	0	20	0	20
502960a0-c67a-46c4-84c6-f49b50e89955	a1f531c4-457c-4856-9026-90d7ccb09711	200 ml Full Cream Milk	ml	200	6	9	6	128
25dbb7d1-0209-4434-8895-5afce84869d4	a1f531c4-457c-4856-9026-90d7ccb09711	2 Brown Bread(for sandwitch toast) / 75g sprouts(for bhel)	Brown	2	6	30	2	160
e6fa5f3a-3602-4815-8ef5-96e819cb0177	a1f531c4-457c-4856-9026-90d7ccb09711	Apple	serving	1	0	25	0	100
564f92a1-5e70-4976-8c17-bb8023f923b9	d9cbf1ff-f0ba-48fa-9f6c-53c1f66e679a	60g Rice/60g Whole Wheat Flour	g	60	5	46	0	216
056fbd44-2274-45b5-8dad-350804cf0884	d9cbf1ff-f0ba-48fa-9f6c-53c1f66e679a	1 egg white/25g soya chunks/ 150g tofu	egg	3	10	0	0	51
a082aeaa-0376-4170-bd3b-d12b588a148b	d9cbf1ff-f0ba-48fa-9f6c-53c1f66e679a	200g Raw/Cooked Vegetable	g	200	4	10	1	48
2c0d53ce-1b90-4df4-8664-a91c13df87cc	d9cbf1ff-f0ba-48fa-9f6c-53c1f66e679a	5g Cooking Oil	g	5	0	0	5	44
8987ca60-a639-4094-8e28-a6e36977cdc4	e16acddf-e1a5-4a92-a7f7-eacd31a3de8e	5g Black Coffee	g	1	0	0	0	2
4ee264f4-cbee-451f-81c5-167e7296083b	ed4fb7c8-6c7e-4404-b7fc-7dfeae4aebe7	40g Poha/Upma/Vermicilli/Oats/Wheat Flour(for paratha)/2 Brown Bread(for sandwitch)	g	40	2	34	0	146
c3892cd4-e278-479a-aca7-6d350800ccb7	ed4fb7c8-6c7e-4404-b7fc-7dfeae4aebe7	2 egg white	egg	2	6	0	0	17
0f8daed0-8d65-4c9f-b2f6-d02ef966a8d7	ed4fb7c8-6c7e-4404-b7fc-7dfeae4aebe7	Whey Protein	serving	1	24	2	0	120
31bb2d75-4609-4818-8273-8869b6ce1bfc	ed4fb7c8-6c7e-4404-b7fc-7dfeae4aebe7	5g Cooking Oil	g	5	0	0	5	44
0c9469ab-42ff-40d8-b0a1-d9206341ffa2	3ac03b42-2090-4fcb-965f-ec502c5f686f	50g Rice/ 50g Whole Wheat Flour	g	50	4	38	0	180
65fb58a3-44c2-4652-b3e4-381b09c00ae7	3ac03b42-2090-4fcb-965f-ec502c5f686f	200g Raw/Cooked Vegetable	g	200	4	10	1	48
a64dea2b-8364-4ecf-a3b7-38ce8399d23d	3ac03b42-2090-4fcb-965f-ec502c5f686f	50g Paneer/1 Whole Eggs	g	50	9	0	10	132
e13cd569-dfd1-4431-86c6-d3282e21ec9d	3ac03b42-2090-4fcb-965f-ec502c5f686f	5g Cooking Oil	g	5	0	0	5	44
97634d77-6918-4512-b6cc-ea9eea4c2d8b	3ac03b42-2090-4fcb-965f-ec502c5f686f	100g Curd	g	100	3	4	3	60
d9a31f12-e4b3-4d5d-9fe6-eac6c78471d7	3ac03b42-2090-4fcb-965f-ec502c5f686f	40g Daal/Rajma/Chole	g	40	10	23	0	140
3c5edd94-402c-4401-93d8-adbb5f939fcb	1bee5096-f487-4ea4-b8f6-eed38ac40750	5g Tea	g	5	0	0	0	0
4cc2ca7a-d552-4a0b-92c8-55fa13563607	1bee5096-f487-4ea4-b8f6-eed38ac40750	5g Sugar	g	5	0	20	0	20
aea44499-42fc-4a07-bf20-fd0d966e335f	1bee5096-f487-4ea4-b8f6-eed38ac40750	200 ml Full Cream Milk	ml	200	6	9	6	128
fe628517-15fa-4e99-b9fa-4c8cc467a1b0	1bee5096-f487-4ea4-b8f6-eed38ac40750	2 Brown Bread(for sandwitch toast) / 75g sprouts(for bhel)	Brown	2	6	30	2	160
d48a0d31-c540-441f-b54c-136cda876a40	1bee5096-f487-4ea4-b8f6-eed38ac40750	Apple	serving	1	0	25	0	100
ba7bbde8-9cc0-425e-81cf-8b8a7192b08c	1ee2cd29-3a93-4e4f-a292-93b54dd53666	50g Rice/ 50g Whole Wheat Flour	g	50	4	38	0	180
68c1801b-cd36-4a48-b4d2-52ec6d215f8b	1ee2cd29-3a93-4e4f-a292-93b54dd53666	200g Raw/Cooked Vegetable	g	200	4	10	1	48
fe376d9c-2e96-48e1-8daa-19bca2aa053e	1ee2cd29-3a93-4e4f-a292-93b54dd53666	5g Cooking Oil	g	6	0	0	6	53
576006ab-3436-45cf-baa2-9034b69a3ba5	1ee2cd29-3a93-4e4f-a292-93b54dd53666	2 egg white/50g Soya Chunks/200g Tofu	egg	2	6	0	0	34
\.


--
-- Data for Name: meals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meals (id, plan_id, meal_name, order_index, created_at) FROM stdin;
e16acddf-e1a5-4a92-a7f7-eacd31a3de8e	99a28bc0-ca4e-499f-bc22-cf6503583fcf	Pre-Workout	0	2026-05-14 13:29:59.176976
ed4fb7c8-6c7e-4404-b7fc-7dfeae4aebe7	99a28bc0-ca4e-499f-bc22-cf6503583fcf	Breakfast	1	2026-05-14 13:29:59.178145
3ac03b42-2090-4fcb-965f-ec502c5f686f	99a28bc0-ca4e-499f-bc22-cf6503583fcf	Lunch	2	2026-05-14 13:29:59.179653
28e75678-4f82-4099-9d45-e38f85215b21	9edc2473-b6e3-4fd4-bddf-cc65413e450d	Breakfast	0	2026-05-07 03:25:06.49868
3b5d9dc7-5ecd-4eb1-ab00-f718ff2a425f	9edc2473-b6e3-4fd4-bddf-cc65413e450d	Lunch	1	2026-05-07 03:25:06.57487
ad3a8032-b8ff-49a9-8307-ac56317f39d0	9edc2473-b6e3-4fd4-bddf-cc65413e450d	Pre Workout	2	2026-05-07 03:25:06.57893
83ff651c-df53-40e6-b976-d25d7322d05f	9edc2473-b6e3-4fd4-bddf-cc65413e450d	Dinner	3	2026-05-07 03:25:06.580981
1bee5096-f487-4ea4-b8f6-eed38ac40750	99a28bc0-ca4e-499f-bc22-cf6503583fcf	Snacks	3	2026-05-14 13:29:59.18253
1ee2cd29-3a93-4e4f-a292-93b54dd53666	99a28bc0-ca4e-499f-bc22-cf6503583fcf	Dinner	4	2026-05-14 13:29:59.185859
088a050b-3a8b-42ad-afd8-f8ca7ff44d3a	572877d5-29fe-45ea-a926-f93cce8b9a17	Pre-Workout	0	2026-05-14 13:30:13.027504
e44e0992-0cf3-4037-9870-ccd9b563d783	572877d5-29fe-45ea-a926-f93cce8b9a17	Breakfast	1	2026-05-14 13:30:13.028358
12342268-2603-4725-8c5b-aa77f70dbed0	df9fb82a-a780-4769-8951-8060fc7eb19d	Breakfast	0	2026-05-12 04:09:37.547617
64f46d85-3dc0-461d-b5f1-240083afb0f1	df9fb82a-a780-4769-8951-8060fc7eb19d	Lunch	1	2026-05-12 04:09:37.54985
7eb24793-b593-413a-8a80-84633091abfa	df9fb82a-a780-4769-8951-8060fc7eb19d	Snacks	2	2026-05-12 04:09:37.554858
9c0f1b41-261c-44fd-ba4c-b3756e140744	df9fb82a-a780-4769-8951-8060fc7eb19d	Dinner	3	2026-05-12 04:09:37.561084
4388b07e-3b58-4125-9e6c-b77869da0930	ee183b68-4fda-42c3-b63b-dcabc5d23c67	Breakfast	0	2026-05-12 04:14:06.570256
51cb4fa8-6b4a-4e9a-a496-4c20da50049d	ee183b68-4fda-42c3-b63b-dcabc5d23c67	Lunch	1	2026-05-12 04:14:06.573241
c526cbdb-4b0d-4c5c-bdb3-6d2e9afb94b7	ee183b68-4fda-42c3-b63b-dcabc5d23c67	Snacks	2	2026-05-12 04:14:06.575852
82d7241f-e5e5-4317-afff-5cce2b2cafd5	ee183b68-4fda-42c3-b63b-dcabc5d23c67	Dinner	3	2026-05-12 04:14:06.578424
b39f95a7-bc4c-41eb-a5d8-a05ac83c76d0	572877d5-29fe-45ea-a926-f93cce8b9a17	Lunch	2	2026-05-14 13:30:13.031058
a1f531c4-457c-4856-9026-90d7ccb09711	572877d5-29fe-45ea-a926-f93cce8b9a17	Snacks	3	2026-05-14 13:30:13.034194
d9cbf1ff-f0ba-48fa-9f6c-53c1f66e679a	572877d5-29fe-45ea-a926-f93cce8b9a17	Dinner	4	2026-05-14 13:30:13.038162
a9716b19-60f3-418c-8fd8-c513a720cf02	95e86798-dfa5-411b-b2c9-bffdc9745f6b	Breakfast	0	2026-03-28 12:16:30.738523
94dc65fe-5c8a-4a5d-a76c-e21e00b18116	95e86798-dfa5-411b-b2c9-bffdc9745f6b	Lunch	1	2026-03-28 12:16:30.740509
a7bfe4e0-7f96-4938-9c34-7e1627671ba1	95e86798-dfa5-411b-b2c9-bffdc9745f6b	Snacks	2	2026-03-28 12:16:30.743336
558e045a-296e-4fd7-a171-437a560a4862	95e86798-dfa5-411b-b2c9-bffdc9745f6b	Dinner	3	2026-03-28 12:16:30.744507
40b23d87-95a6-4916-98c7-9aee66edd557	b6a1fa02-c586-4272-af78-f72c88449da0	Breakfast	0	2026-03-24 13:53:04.850474
a91fa504-270c-4689-833c-dd084bf1725a	b6a1fa02-c586-4272-af78-f72c88449da0	Lunch	1	2026-03-24 13:53:04.864897
a48a8793-ccfa-48d6-9690-f80b61c7381e	b6a1fa02-c586-4272-af78-f72c88449da0	Dinner	2	2026-03-24 13:53:04.86717
b726ff84-3fb7-4e7d-aced-c1588daee22d	f6473eb1-e9e8-480c-8015-3a21f7b98e3a	Breakfast	0	2026-03-24 13:59:33.779242
cc84f1e9-8862-4520-b88c-db30c8a244c0	f6473eb1-e9e8-480c-8015-3a21f7b98e3a	Lunch	1	2026-03-24 13:59:33.783313
26d7d68f-824b-427a-a499-3d5188a2d32c	f6473eb1-e9e8-480c-8015-3a21f7b98e3a	Snacks	2	2026-03-24 13:59:33.784823
98a8048a-eb67-4c2f-8c67-7dcc3e1d84e5	f6473eb1-e9e8-480c-8015-3a21f7b98e3a	Dinner	3	2026-03-24 13:59:33.786936
1cd1a0d7-69d1-441f-9bc5-95685f6eb62c	85e2b7b2-318b-437c-873d-f2fac41559f9	PreWorkout	0	2026-05-17 08:24:31.552518
b09a6a04-f978-43d1-896d-28bddc24e26d	85e2b7b2-318b-437c-873d-f2fac41559f9	Brunch	1	2026-05-17 08:24:31.552876
6dff970c-bed7-4479-a345-33031ad31256	85e2b7b2-318b-437c-873d-f2fac41559f9	Snacks	2	2026-05-17 08:24:31.553488
479895f2-4ba6-4ba5-b956-1f4840aa53c2	85e2b7b2-318b-437c-873d-f2fac41559f9	Dinner	3	2026-05-17 08:24:31.553674
\.


--
-- Name: diet_plans diet_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diet_plans
    ADD CONSTRAINT diet_plans_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: food_library_items food_library_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_library_items
    ADD CONSTRAINT food_library_items_pkey PRIMARY KEY (id);


--
-- Name: meal_items meal_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meal_items
    ADD CONSTRAINT meal_items_pkey PRIMARY KEY (id);


--
-- Name: meals meals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meals
    ADD CONSTRAINT meals_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_food_library_items_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_food_library_items_category ON public.food_library_items USING btree (category);


--
-- Name: idx_food_library_items_food_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_food_library_items_food_item ON public.food_library_items USING btree (food_item);


--
-- Name: meal_items meal_items_meal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meal_items
    ADD CONSTRAINT meal_items_meal_id_fkey FOREIGN KEY (meal_id) REFERENCES public.meals(id);


--
-- Name: meals meals_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meals
    ADD CONSTRAINT meals_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.diet_plans(id);


--
-- PostgreSQL database dump complete
--

\unrestrict sB6iwq5bjwy6I6vxaP8gz3xTGWpoCuTyWhMyPYSsHEGMBVZPDTXaCqHY4ACIRSs

--
-- Database "coach_member" dump
--

--
-- PostgreSQL database dump
--

\restrict Q2LHQ7e7vsBHZcAQlp7uEd1X8gz1rqHQzdpsI2onyE8vOgKdJk0o5iMYjrsAkzG

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: coach_member; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE coach_member WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE coach_member OWNER TO postgres;

\unrestrict Q2LHQ7e7vsBHZcAQlp7uEd1X8gz1rqHQzdpsI2onyE8vOgKdJk0o5iMYjrsAkzG
\connect coach_member
\restrict Q2LHQ7e7vsBHZcAQlp7uEd1X8gz1rqHQzdpsI2onyE8vOgKdJk0o5iMYjrsAkzG

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: body_metrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.body_metrics (
    id uuid NOT NULL,
    member_id uuid NOT NULL,
    height_cm double precision NOT NULL,
    current_weight_kg double precision NOT NULL,
    gender character varying(20) NOT NULL,
    age integer NOT NULL,
    is_lean boolean NOT NULL,
    activity_factor double precision NOT NULL,
    protein_rda double precision NOT NULL,
    carb_factor double precision NOT NULL,
    target_goal character varying(20) NOT NULL,
    target_calorie_factor double precision NOT NULL,
    ibw_kg double precision NOT NULL,
    bmi double precision NOT NULL,
    bmr double precision NOT NULL,
    tdee double precision NOT NULL,
    target_calories double precision NOT NULL,
    protein_grams double precision NOT NULL,
    carbs_grams double precision NOT NULL,
    fats_grams double precision NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    CONSTRAINT chk_body_metrics_goal CHECK (((target_goal)::text = ANY ((ARRAY['FAT_LOSS'::character varying, 'MAINTENANCE'::character varying, 'GAINING'::character varying])::text[])))
);


ALTER TABLE public.body_metrics OWNER TO postgres;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.members (
    id uuid NOT NULL,
    coach_email character varying(120) NOT NULL,
    full_name character varying(100) NOT NULL,
    email character varying(100),
    phone character varying(20),
    gender character varying(20),
    date_of_birth date,
    goal text,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    age integer,
    country character varying(100),
    state_city_province character varying(120),
    height_cm integer,
    current_weight_kg integer,
    main_training_goal text,
    previous_weight_loss text,
    weight_regain character varying(50),
    prior_training_experience text,
    daily_training_commitment_hours character varying(50),
    preferred_workout_timing character varying(50),
    days_per_week_train integer,
    personal_training_before character varying(50),
    goal_reward text,
    additional_info text,
    alcohol_consumption text,
    smoking_habits text,
    supplements_past character varying(50),
    steroid_usage character varying(50),
    stress_level integer,
    sleep_hours character varying(30),
    past_sports_activity text,
    food_preference character varying(80),
    activity_level character varying(80),
    typical_day text,
    current_diet_plan text,
    favorite_foods text,
    food_allergies text,
    medical_condition text,
    injuries text,
    medical_conditions_detailed text,
    push_up text,
    squat text,
    row_band_dumbbell text,
    overhead_press_dumbbell text,
    hip_hinge_rdl text,
    front_view text,
    side_view text,
    back_view text,
    status character varying(20) DEFAULT 'ACTIVE'::character varying NOT NULL,
    CONSTRAINT chk_members_status CHECK (((status)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);


ALTER TABLE public.members OWNER TO postgres;

--
-- Data for Name: body_metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.body_metrics (id, member_id, height_cm, current_weight_kg, gender, age, is_lean, activity_factor, protein_rda, carb_factor, target_goal, target_calorie_factor, ibw_kg, bmi, bmr, tdee, target_calories, protein_grams, carbs_grams, fats_grams, created_at, updated_at) FROM stdin;
5a16b7b6-f678-44f4-8368-f69940152a36	ac007cd0-71ae-45ae-875a-342fbafca921	181	111	Male	31	f	1.2	1.3	4	FAT_LOSS	12	76	33.9	1824	2189	2011	100	300	45	2026-03-21 08:46:47.255926	2026-03-21 08:46:47.271649
fbe37297-19ca-4c83-b648-3860f5ab410c	b4f7aef7-e790-4017-b54b-de6d215940ce	180	63	Male	31	f	1.55	1.88	3.27	GAINING	14	75	19.4	1800	2790	2240	141	245	74	2026-03-22 06:06:48.823983	2026-03-22 06:26:53.658319
79cc1339-83a5-487d-96e1-15573bbb5ede	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	151	60	Female	30	f	1.725	1.4	4	GAINING	14.43	44	26.3	990	1708	1399.7573303999998	62	176	50	2026-03-22 11:43:05.209926	2026-03-22 11:43:05.210813
11b7238e-0e10-4e3a-992f-c82df68e804b	ac5f869c-9115-4f0a-9f68-d02c0275570c	173	115	Male	31	f	1.2	1.2	4	FAT_LOSS	12	68	38.4	1632	1958	1798.9699199999998	82	272	43	2026-03-28 10:39:59.895509	2026-03-28 10:39:59.89652
42752ab2-27cb-47a1-acdc-98678171c083	0e06681a-b803-432e-99f0-8fdf61e1bdcb	157	59	Female	31	f	1.2	1.2	4	FAT_LOSS	12	50	23.9	1125	1350	1322.772	60	200	31	2026-03-28 11:25:16.28286	2026-03-28 11:25:16.283551
2f1b1197-3ecb-47e0-a98b-aa45465622dc	19fea79e-0cd4-4196-a8c5-09ba95f28629	165	96	Male	32	f	1.55	1.5	4	GAINING	14	60	35.3	1440	2232	1851.8808	90	240	59	2026-04-07 03:42:16.954738	2026-04-07 03:42:16.99044
d84f12bc-a7ac-450a-a690-b07e49a37f39	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	180	73	Male	31	t	1.375	1.3	4.66	GAINING	15	73	22.5	1752	2409	2414.0588999999995	95	340	75	2026-05-06 03:48:57.137884	2026-05-06 03:48:57.142554
a20f2e21-af44-45b5-89bf-35e989769978	f47345ea-a6df-40b0-928b-9d88c3e05350	180	80	Male	30	f	1.375	1.4	4	FAT_LOSS	12	75	24.7	1800	2475	1984.158	105	300	40	2026-05-12 13:50:42.998979	2026-05-12 13:50:43.009399
637d416f-558e-4f50-a6d1-a95267ba878d	80026e92-8f66-4cfb-852a-e92f48f7ea38	165	67	Female	28	f	1.375	1.3	3.6	FAT_LOSS	12	58	24.6	1305	1794	1534.4155199999998	75	209	44	2026-05-14 13:08:32.697283	2026-05-14 13:10:42.967571
adf76a01-dfba-4fc0-9571-652faab2f6c3	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	165	71	Male	31	f	1.375	1.6	3.5	MAINTENANCE	12.1	60	26.1	1440	1980	1600.5541199999998	96	210	42	2026-05-17 08:03:01.575318	2026-05-17 08:24:55.221171
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	create members table	SQL	V1__create_members_table.sql	1270564397	postgres	2026-03-11 06:57:52.722646	261	t
2	2	add member profile fields	SQL	V2__add_member_profile_fields.sql	-650467566	postgres	2026-03-11 06:57:53.856036	93	t
3	3	change sleep hours to text	SQL	V3__change_sleep_hours_to_text.sql	903014124	postgres	2026-03-11 06:57:54.12334	103	t
4	4	add member status	SQL	V4__add_member_status.sql	1570520107	postgres	2026-03-11 06:57:54.313731	13	t
5	5	create body metrics table	SQL	V5__create_body_metrics_table.sql	1254383291	postgres	2026-03-11 06:57:54.409927	201	t
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.members (id, coach_email, full_name, email, phone, gender, date_of_birth, goal, notes, created_at, updated_at, age, country, state_city_province, height_cm, current_weight_kg, main_training_goal, previous_weight_loss, weight_regain, prior_training_experience, daily_training_commitment_hours, preferred_workout_timing, days_per_week_train, personal_training_before, goal_reward, additional_info, alcohol_consumption, smoking_habits, supplements_past, steroid_usage, stress_level, sleep_hours, past_sports_activity, food_preference, activity_level, typical_day, current_diet_plan, favorite_foods, food_allergies, medical_condition, injuries, medical_conditions_detailed, push_up, squat, row_band_dumbbell, overhead_press_dumbbell, hip_hinge_rdl, front_view, side_view, back_view, status) FROM stdin;
5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	Prashant Kumar	prashantkumar.0142@gmail.com	9631597047	Male	1994-04-22	Fat Loss	\N	2026-03-15 07:09:56.85391	2026-03-15 07:09:56.854617	31	India	Karnataka	165	71	Lean athletic body, Fat below 20%, Muscle above 40%	Yes 2 kg	Yes	1 year irregular 	1 to 1.5 hours	Morning	5	No	Will enroll for kick boxing.		Occasionally, once or twice in a month	Daily,  maximum 2 cigarette 	No	No	4	8	None	Non-Vegetarian	Low (Desk job)	Waking 10 am,\nMeals: brunch at afternoon, evening snacks, dinner\nSleep: late around 1or 2	None	Biryani, dosa	None	None	Past injury: Shoulder	All Good						https://drive.google.com/open?id=13muNkafJ1UwQvWn69AE-4XtsMh-1nAtJ	https://drive.google.com/open?id=1wq9x5bFt1iKbx39SKO00EjD-9FD8lgsk	https://drive.google.com/open?id=1iIvi2kkSLDvOwVsUg0YXZ1Bw5WjClyDe	ACTIVE
8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	Vaisshnavi	Vaishnavigwd@gmail.com	8050646481	Female	2020-02-20	Fat Loss	\N	2026-03-15 07:13:21.387748	2026-03-15 07:13:21.388987	30	India	Karnataka 	151	60	To get fit and loose 5 kg 	Yes 	Yes	10 years 	1 hour 	Morning	7	Yes	Enjoy the moment 		No 	No 	No 	No 	6	6 hours 	No 	Vegetarian	High (Sports, Dance, Physical job)	8 am everyday 6 hours 4 liters 	No 	Pani puri 	No 	No 	Head	All Good						https://drive.google.com/open?id=1B6jwezbOnaiIao3YmtYQ03dpJCBziv32	https://drive.google.com/open?id=1V1nIfb1t_21UO-PnecqfxXH3NPwIoH_D	https://drive.google.com/open?id=1cSS5Igh3VBP2ecMzPrlzSv2qb3s73bZJ	ACTIVE
525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	Sudhanshu Shekhar Singh	rules.sid4@gmail.com	9030223950	Male	1997-05-06	Fat Loss	\N	2026-03-16 03:26:15.966337	2026-03-16 03:26:15.966969	28	India	Banglore 	182	76	Get some muscle mass and lose belly fat	No	No	No training experience 	1-1.5 hrs	Flexible	6	No	Get a tattoo	Nil	Consume around 1 time in a week that too 2-3 pegs	Around 8	No	No	8	6	Played sports professionally	Non-Vegetarian	Low (Desk job)	Do shift duty so working time is flexible	Nil	Chicken	Nil	Shoulder sockets injury and migraine 	Shoulder	All Good						https://drive.google.com/open?id=180DMtnDlAtbNZcEiUnMex9JIt711loGj	https://drive.google.com/open?id=101SoQvN6wiOajgStF9aI6FxznoSMaJKD	https://drive.google.com/open?id=19aPSebS2Fyl6r1p5nBOST1T4C_IfzfwR	ACTIVE
ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	Mayank Thakur	mayank4656@gmail.com	70677 39630	Male	1994-12-25	Fat Loss	\N	2026-03-19 13:09:33.160387	2026-03-19 13:09:33.161342	31	India	Bangalore	181	111	Lose weight and Reverse Diabetes and take care of liver and cholesterol markers. 	10 kgs	Yes	6 months gym training	1 hour	Morning	6	No	Maintain the physique and lifestyle so that I never have to eat any tablets.	No	3-4 days	3-5 per day	Protein powder, Creatine and BCAA	No	5			Non-Vegetarian	Low (Desk job)	Walking : Occasionally after food, 7 hours of sleep, 3 meals a day and some snacks in evening.	No	Eggs chicken mutton dosa idly roti sabzi	None	Diabetes, Fatty Liver and high cholesterol	Lower Back	Diabetes, Cholesterol						https://drive.google.com/open?id=1N3fj_DHyNUeH0LOW9e0teJvDoezxaQxZ	https://drive.google.com/open?id=191Ss8FO0MQ3RR-P4kAvJxHOtqnf3TurL	https://drive.google.com/open?id=1tFPloPetqXmY4ah58jicGxuRjcWAdMnA	ACTIVE
ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	Shailesh Kumar Sahu	shailesh.sksahu@gmail.com	7828673538	Male	1994-04-24	Fat Loss	\N	2026-03-23 03:57:38.401819	2026-03-23 03:57:38.404189	31	India	Chennai	173	115	To feel more active and gain strength	No	No	No	1-2	Flexible	5	No	I will do sky diving	No	Once in a month and upto 4 drinks of 60ml	No	No	No	2		School	Vegetarian	Low (Desk job)	Wakeup- 8-9 A.M., breakfast- 9:30 A.M. ( Poha, idli, Suji, Vermicelli, boiled eggs, sandwich), work- 10 AM to 8 PM, Lunch- 1-2 PM ( rice, , roti sabzi), evening snacks- tea and biscuit, mixture, Dinner- 9-10 PM ( Rice or roti), sleep- 12-8	No	Poha\nUpma\nSabudan khichdi\nParatha\nRice\nRoti\nEgg items\nSome times  chicken birayani- once in a quarter\nSoyabean khichdi\nMushroom\nEtc.	No	Slip disc- L5-S1 (moderate)	Shoulder	All Good						https://drive.google.com/open?id=1ZTKaxFBv_14jV6DTNot4_HQumJK_FPxt	https://drive.google.com/open?id=19HmRozCAZ7RmhnXUT4DYg0vsTo_me_fr	https://drive.google.com/open?id=1LjsqYnlyTVawcf_OCOmGZiYFsmxuQYQq	ACTIVE
0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	Khushbu Sahu	khushbuganjir06@gmail.com	7974985243	Female	1994-07-24	Fat Loss	\N	2026-03-23 03:58:52.543445	2026-03-23 03:58:52.543457	31	India	Tamilnadu 	157	59	Stay active and fit 	No	Yes	No	1hr	Flexible	5	No	Buy a new outfit and go on a trip.	No	Once in a while	No	Iron	No	7	8	Classical dance 	Vegetarian	Moderate (Teacher/Student/Homemaker)	Currently, I do not have a fixed daily routine for walking, meals, water intake, or sleep, but I am working on building healthier habits.	No	Nothing specific 	No	Allergic 	No Injuries	All Good						https://drive.google.com/open?id=1t11WqL1E97m4Ud4bNMH15kDIr--u1Hxq	https://drive.google.com/open?id=1fBFm455JnsAQ5V23hbTG0kMIiodGB0NM	https://drive.google.com/open?id=1MMkuIMFBS-MOkBLQHKgbILt0x04Go--k	ACTIVE
19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	ANWAR KHAN	akanwar7@gmail.com	8087535411	Male	1993-10-10	Fat Loss	\N	2026-04-05 03:53:22.16863	2026-04-05 03:53:22.169797	32	India	PUNE	165	96	Fat loss	Yes 10 kg	Yes	1	1hr	Morning	6	Yes	Good	No	No	No	Yes	No	2	6	No	Non-Vegetarian	Moderate (Teacher/Student/Homemaker)	Waking time 7 meals 3 work 10 to 10 sleep time 11 steps 3-5k water 3+	No	Chicken Egg paneer	No	No	No Injuries	Cholesterol, Asthma						https://drive.google.com/open?id=1xhz0pprvTyVdSuyNAReM-AIXIruPLC7P	https://drive.google.com/open?id=1yYL8Fbfwj1SqErxbpH_haBNSAyY_LeQm	https://drive.google.com/open?id=1x8VPCToMUU4JXsNdfC_WeL-K40a-CjrX	ACTIVE
b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	Prateek Srivastava	srivastavaprateek1994@gmail.com	8269499713	Male	1994-08-10	Muscle Gain	\N	2026-03-13 14:01:19.12028	2026-05-17 10:09:20.467719	31	India	Pune Maharashtra 	180	63	Transformation 	NA	No	6 months	2	Morning	6	No	Will try to continue the lifestyle 	Smoking: negligible, occasionally, trying to quit Drinking: Occasionally 	1-2 per month limited quantity 	Right now zero. Trying to quit. Very occasional	No	No	8	8	NA	Non-Vegetarian	Low (Desk job)	I am trying to wake up by 7 Am and go to bed around 11 pm.\nWater intake: 3-4 litres\nMeals as per the plan \nSteps: 9000 average in February \nWork: 5 days a month.	Yes	Already shared	No	No	No Injuries	All Good						https://drive.google.com/open?id=1VjUFCQk_yYkxFrzIzmgJw0MjNZ7M8DAI	https://drive.google.com/open?id=1eP3Vi5mlthn353rPoSNnYPVeGTY3EoT0	https://drive.google.com/open?id=1091re_Kp8Vo2nKB4lceS2ROTh8bWglFJ	ACTIVE
8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	Rishikant Soni	Rishikantjbp@gmail.com	8989891537	Male	1995-01-19	Muscle Gain	\N	2026-05-04 04:10:55.19084	2026-05-04 04:10:55.19114	31	India	Pune	180	73	Build a fit and a lean muscular body	Yes, 4kg	No	No	1	Flexible	4	No	Buy myself a lot of clothes	Bhaiya meri nangi photos kisi ko mat dikhana ≡ƒÑ╣≡ƒÑ╣	Very occasionally 	No	No	No	6	7	Cricket club	Non-Vegetarian	Low (Desk job)	10-11 wake up breakfast  start office\n2-3 lunch\n8-9 wrap office \n9-10 gym \n10-11 dinner followed by work	Home food, less oil, focus on protein intake	Pani puri	Lactose intolerant 	Knee issues - damaged ligaments while skiing Γ¢╖∩╕Å 	Knee	All Good						https://drive.google.com/open?id=1nOoEXXpCscNg7nqMKMWcbxtquIQNJoeM	https://drive.google.com/open?id=1VTa-PK4jKrrV3_gQrAOSDMbOjcYE-mVQ	https://drive.google.com/open?id=1kP7CNtuxgp3AHPX8n4bG95-m1769uKDQ	ACTIVE
f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	Nitin Gupta	Nnitingupta24@gmail.com	8109464940	Male	1996-06-24	Fat Loss	\N	2026-05-07 13:38:11.232665	2026-05-07 13:38:11.233855	30	India	Jabalpur	180	80	Fat loss and better muscles definition	Yes, 7kg	Yes	5 years of self training 	1 hour	Morning	5	No	Boys trip with my coach		Yes once in a month	No	Whey protiens	No	4	6	School- regular athete	Vegetarian	Low (Desk job)	Waking ΓÅ░∩╕Å > 8am\nMeals> breakfast lunch tea snacks dinner\nWork > 5 to 6 hrs desk job\nSleep> at 1 am approx\nWater > 4-5 ltr	Not available 	Eggs\nPaneer\nIdly/dosa\nCheela\nPastry	Nothing 	Nope	1 year old right feet ATFL Injury- recovered completely  2 year old neck muscles Injury- recovered completely but take precautions while doing exercise 	All Good						https://drive.google.com/open?id=1BGPAjBps0_1DaTNj7D4sdjj47Wg9nbPq	https://drive.google.com/open?id=1QyY746-8124sYJ_n4U5n0_x-qqL4g1_0	https://drive.google.com/open?id=14lxbP5Y2fgdBMveh31ybZnYyvLoRSFPM	ACTIVE
80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	Shreya Verma	jshreyav09@gmail.com	8989115353	Female	1998-07-09	Fat Loss	\N	2026-05-07 13:39:01.576612	2026-05-07 13:39:01.57663	28	India	Jabalpur	165	67	Fat loss and muscle gain	9kg	Partially	4	1	Morning	5	No	Will plan some travel and eat good food		Not more than once a month	No	Take whey protein regularly 	No	4			Vegetarian	Low (Desk job)	Wake up at 8:30 am, breakfast at 10-10:30 lunch at 1:30pm evening snacks at 5-6pm tea in morning and evening, dinner by 9pm. Water intake in 3lit per day, 2-3k steps per day sleep by 1am	No	Eggs, paneer, idly/dosa, cheela, chicken(eat outside only), ice cream,	No	PCOS	No Injuries	PCOS/PCOD						https://drive.google.com/open?id=1V979xVH9BlXyMBfmKsTrdmcjfMKXxpYO	https://drive.google.com/open?id=1wTMYwbYcPTX9vP476ex-ZLw8omtrTRgt	https://drive.google.com/open?id=1ElEW7U1EenvC1HJK9oXYmg_c4NwNHkOn	ACTIVE
615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	Rashmi Tamane Deoghare	Rtamane96@gmail.com	6265874807	Female	1996-07-11	Fat Loss	\N	2026-03-17 12:01:23.604698	2026-05-15 14:51:54.154159	29	India	Pune	157	66	Fat loss	63	Partially	Trained under Varun Deoghare for few months	2	Morning	4	No	Achieving goal is itself a reward for me ≡ƒÿè	What if i crave icecream weekly? 	No	No	No	No	4	6.5	Yes	Vegetarian	Low (Desk job)	Waking up at 5:45 . Gym workout for 1.5 hrs. Breakfast. Office .Lunch. Office. Dinner. Walk. Sleep		NA	NA	No	No Injuries	All Good						https://drive.google.com/open?id=1NLnIbDoYByYM6weVmfmJExzpBXJRcAsJ	https://drive.google.com/open?id=1q1R2PNb4rJ3zoOVDMJBDtHvlRn9QFe2u	https://drive.google.com/open?id=1NP04fMuz6ybg8Kf7ugSYL2Fibs9fVsW6	INACTIVE
fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	Mohit Soni	mohitsoni444.ms@gmail.com	9770516659	Male	1994-09-07	Fat Loss	\N	2026-05-18 04:13:28.061778	2026-05-18 04:13:28.062218	31	India	Maharashtra	178	78	Fat loss, Muscle gain	No	No	10	45 mins to 1 hour	Evening	5	Yes	by Maintaining it.		once a month	occasionally. twice or thrice a week	Yes, muscle tech nitrotech whey, creatine	Never	7		School	Vegetarian	Low (Desk job)	Wake up at 8, one glass water, breakfast at 9, office, lunch at 1/2, gym at 8, sleep by 11/12		Nothing much, Mostly I can eat everything except soya chunks	none	NO	No Injuries	All Good, Migraine						https://drive.google.com/open?id=1XR-eTtaOc4j-iRvPZOIZrtTp6pwCzIBE	https://drive.google.com/open?id=1a5unEcuIfMFksRF-qQ_zXEjqnEUzU0Vq	https://drive.google.com/open?id=1ZZfBbaR_vvq5HblZvDbkfD8UU17hC3G5	ACTIVE
\.


--
-- Name: body_metrics body_metrics_member_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.body_metrics
    ADD CONSTRAINT body_metrics_member_id_key UNIQUE (member_id);


--
-- Name: body_metrics body_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.body_metrics
    ADD CONSTRAINT body_metrics_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: ix_members_coach_email_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_members_coach_email_email ON public.members USING btree (coach_email, lower((email)::text)) WHERE (email IS NOT NULL);


--
-- Name: body_metrics fk_body_metrics_member; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.body_metrics
    ADD CONSTRAINT fk_body_metrics_member FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict Q2LHQ7e7vsBHZcAQlp7uEd1X8gz1rqHQzdpsI2onyE8vOgKdJk0o5iMYjrsAkzG

--
-- Database "coach_notification" dump
--

--
-- PostgreSQL database dump
--

\restrict vjBpj0S0mZImXFaFdHThHUHYXelUfalVihkUYWHNbEu7CMUJizWkanKvaht7QtK

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: coach_notification; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE coach_notification WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE coach_notification OWNER TO postgres;

\unrestrict vjBpj0S0mZImXFaFdHThHUHYXelUfalVihkUYWHNbEu7CMUJizWkanKvaht7QtK
\connect coach_notification
\restrict vjBpj0S0mZImXFaFdHThHUHYXelUfalVihkUYWHNbEu7CMUJizWkanKvaht7QtK

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    member_id uuid NOT NULL,
    coach_email character varying(255) NOT NULL,
    channel character varying(20) NOT NULL,
    notification_type character varying(40) NOT NULL,
    recipient character varying(255) NOT NULL,
    subject character varying(255),
    message text NOT NULL,
    status character varying(20) NOT NULL,
    error_message text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	create notifications table	SQL	V1__create_notifications_table.sql	-852896165	postgres	2026-03-11 06:57:49.458619	832	t
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, member_id, coach_email, channel, notification_type, recipient, subject, message, status, error_message, created_at, updated_at) FROM stdin;
\.


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_notifications_channel; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notifications_channel ON public.notifications USING btree (channel);


--
-- Name: idx_notifications_coach_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notifications_coach_email ON public.notifications USING btree (coach_email);


--
-- Name: idx_notifications_member_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notifications_member_id ON public.notifications USING btree (member_id);


--
-- Name: idx_notifications_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notifications_status ON public.notifications USING btree (status);


--
-- PostgreSQL database dump complete
--

\unrestrict vjBpj0S0mZImXFaFdHThHUHYXelUfalVihkUYWHNbEu7CMUJizWkanKvaht7QtK

--
-- Database "coach_workout" dump
--

--
-- PostgreSQL database dump
--

\restrict pQwvENbznCQf11yRkAuL5liZdWv6cEr1uAzTlvSlRDPcQxU3QcJseePUSwfLNHw

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: coach_workout; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE coach_workout WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE coach_workout OWNER TO postgres;

\unrestrict pQwvENbznCQf11yRkAuL5liZdWv6cEr1uAzTlvSlRDPcQxU3QcJseePUSwfLNHw
\connect coach_workout
\restrict pQwvENbznCQf11yRkAuL5liZdWv6cEr1uAzTlvSlRDPcQxU3QcJseePUSwfLNHw

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: exercise_library; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercise_library (
    id uuid NOT NULL,
    coach_email character varying(120) NOT NULL,
    exercise_name character varying(100) NOT NULL,
    video_url text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    sr_no integer NOT NULL,
    muscle_group character varying(100) NOT NULL,
    muscles_trained character varying(255)
);


ALTER TABLE public.exercise_library OWNER TO postgres;

--
-- Name: exercise_sets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercise_sets (
    id uuid NOT NULL,
    exercise_id uuid NOT NULL,
    set_number integer NOT NULL,
    reps character varying(20),
    weight numeric(10,2),
    rpe numeric(3,1),
    tempo character varying(20),
    rest character varying(20)
);


ALTER TABLE public.exercise_sets OWNER TO postgres;

--
-- Name: exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercises (
    id uuid NOT NULL,
    day_id uuid NOT NULL,
    name character varying(100) NOT NULL,
    notes text,
    video_url text,
    muscles_trained character varying(255),
    muscle_group character varying(255)
);


ALTER TABLE public.exercises OWNER TO postgres;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: member_exercise_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.member_exercise_assignments (
    id uuid NOT NULL,
    library_exercise_id uuid NOT NULL,
    member_id uuid NOT NULL,
    coach_email character varying(120) NOT NULL,
    assigned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.member_exercise_assignments OWNER TO postgres;

--
-- Name: workout_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workout_assignments (
    id uuid NOT NULL,
    plan_id uuid NOT NULL,
    member_id uuid NOT NULL,
    coach_email character varying(120) NOT NULL,
    active boolean NOT NULL,
    assigned_at timestamp without time zone NOT NULL
);


ALTER TABLE public.workout_assignments OWNER TO postgres;

--
-- Name: workout_days; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workout_days (
    id uuid NOT NULL,
    plan_id uuid NOT NULL,
    day_name character varying(100) NOT NULL
);


ALTER TABLE public.workout_days OWNER TO postgres;

--
-- Name: workout_plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workout_plans (
    id uuid NOT NULL,
    member_id uuid NOT NULL,
    coach_email character varying(120) NOT NULL,
    title character varying(100) NOT NULL,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.workout_plans OWNER TO postgres;

--
-- Data for Name: exercise_library; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercise_library (id, coach_email, exercise_name, video_url, created_at, updated_at, sr_no, muscle_group, muscles_trained) FROM stdin;
0a4a5cf7-c11e-410b-b4c3-effaa449c707	varun.deoghare@gmail.com	15┬░ Incline Dumbbell Press		2026-03-15 03:23:00.932082	\N	1	CHEST	Pecs(upper, middle) - Lengthened,\nAnterior Delts
5ebdb2a2-6b25-41c6-b05c-dea1481ed17d	varun.deoghare@gmail.com	Neutral Grip Lat Pulldown		2026-03-15 04:19:34.425427	\N	2	BACK	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps
99674fde-90be-4780-b55f-ce087de3fd40	varun.deoghare@gmail.com	Smith Machine Squats		2026-03-15 04:19:34.565446	\N	3	LEGS	Quads(Lengthened),\nGlutes(Lengthened),\nSpinal Erectors
a7e03bac-d98a-4134-83ba-fe348205da9a	varun.deoghare@gmail.com	Seated Leg Curl		2026-03-15 04:19:34.663528	\N	4	LEGS	Hamstrings(Lengthened)
1cf0248a-435e-4d1b-a0c7-62650740eecb	varun.deoghare@gmail.com	Incline Dumbell Curl		2026-03-15 04:19:34.697139	\N	5	BICEPS	Biceps(Lengthened)
47038022-5911-4d83-ac7f-215bf4dfba2a	varun.deoghare@gmail.com	Cable Press(lo-hi)		2026-03-15 08:41:24.703018	\N	46	CHEST	Pecs(Upper, middle - Full ROM),\nAnterior Delt
ef0de82b-646f-46c4-be93-ffc4b87de70d	varun.deoghare@gmail.com	Calf Press		2026-03-15 04:23:08.517105	\N	7	LEGS	Gastroc, Soleus
c86cf733-c0bb-4a48-b4ef-8ca4309439f6	varun.deoghare@gmail.com	Pec Deck Fly		2026-03-15 07:26:30.955328	\N	8	CHEST	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts
4ffc017c-8723-43ad-a987-de9e83c663d5	varun.deoghare@gmail.com	Cable Lateral Raises		2026-03-15 07:27:41.808935	\N	10	SHOULDER	Lateral Delt
74ddf0f5-c702-420c-abe1-5d02c84d3272	varun.deoghare@gmail.com	Leg Extensions		2026-03-15 07:27:41.842445	\N	11	LEGS	Quads(Shortened)
94277776-6ec2-4643-b498-fc4bdbb7b131	varun.deoghare@gmail.com	45 Degree Hip Extension		2026-03-15 07:28:59.351661	\N	12	LEGS	Glutes (Shortened)
85dc3cc1-ac7d-45fc-b49e-22b406522fec	varun.deoghare@gmail.com	Lying Leg Curl		2026-03-15 07:28:59.573421	\N	13	LEGS	Hamstrings(Less Lengthened)
76913169-17f2-4084-9d7a-4bd795bf2940	varun.deoghare@gmail.com	Preacher Curl Machine		2026-03-15 07:30:04.395864	\N	14	BICEPS	Biceps(Shortened)
08e4dd0f-4abd-46ae-a3c6-f49bc01e7d4d	varun.deoghare@gmail.com	Cross Body Triceps Pushdown		2026-03-15 07:30:04.431198	\N	15	TRICEPS	Tricpes(Shortened - Long Head)
f88bb0fa-6838-47d6-9413-febde46c6fe4	varun.deoghare@gmail.com	Seated Calf Raises		2026-03-15 07:30:22.601875	\N	16	LEGS	Soleus
2b081981-005b-4da1-b52e-38b99fdc3f4b	varun.deoghare@gmail.com	Neutral Grip Pullups		2026-03-15 07:32:30.046878	\N	17	BACK	Lats(Vertical),\nTeres Major,\nRear Delts,\nLower Traps
640409e4-e88a-42f0-b0c0-c9ed386f2762	varun.deoghare@gmail.com	Overhead Dumbbell Press		2026-03-15 07:32:30.083548	\N	18	SHOULDER	Anterior Delts,\nUpper Pecs
6a8e612a-fb76-4a1e-aae1-9d159d31d516	varun.deoghare@gmail.com	Flat Bench Dumbbell Press		2026-03-15 07:33:36.020524	\N	19	CHEST	Pecs(middle, lower - lengthened),\nAnterior Delts
1293c2d5-c06a-4963-9842-bb66797137e9	varun.deoghare@gmail.com	Hack Squat		2026-03-15 07:33:36.055767	2026-03-15 07:33:47.344259	20	LEGS	Quads(Lengthened)
7a6059a5-b94d-4f3c-8960-a76537b91ef1	varun.deoghare@gmail.com	Stiff Leg Deadlift(Barbell)		2026-03-15 07:36:06.978392	\N	21	LEGS	Hamstrings(Lengthened),\nGlutes(Lengthened)
2bd3ca1f-a298-44fa-bb06-282b712b4f0d	varun.deoghare@gmail.com	Standing Calf Raises(Smith Machine)		2026-03-15 07:36:07.01459	\N	22	LEGS	Gastroc, Soleus
79d3b772-aaf8-4be2-b026-f3c1713ca09f	varun.deoghare@gmail.com	Wide Grip Barbell Shrugs		2026-03-15 07:37:26.196524	\N	23	BACK	Upper Traps
7a883a60-4dec-4f8f-94b7-0143509fbd79	varun.deoghare@gmail.com	Hammer Curl		2026-03-15 07:37:26.229425	\N	24	BICEPS	Brachioradialis
ddf6e1de-ebb2-492d-a5d2-5aa695b1ca83	varun.deoghare@gmail.com	Wood Choppers		2026-03-15 07:39:25.699503	\N	26	ABS	Obliques
b46790ca-1632-4a78-9d41-160c6d7ab04b	varun.deoghare@gmail.com	Russian Twists		2026-03-15 07:39:49.176004	\N	27	ABS	Obliques
abfefb6b-bec5-43f5-a8d0-60b9e2453952	varun.deoghare@gmail.com	Abdominal Crunch		2026-03-15 07:41:39.709146	\N	28	ABS	Rectus Abdominis,\nTransverse Abdominis
b89e5e72-d6e8-4038-ac5c-7fb89dbb90fe	varun.deoghare@gmail.com	Single Arm Illiac Pulldown		2026-03-15 07:44:22.328573	\N	29	BACK	Lats(Vertical),\nTeres Major,\nRear Delt,\nLower Traps
e7deb387-096c-49e0-87cf-97633312b6d9	varun.deoghare@gmail.com	Incline Dumbbell Press		2026-03-15 07:44:22.350599	\N	30	CHEST	Pecs(Upper, Middle - Lengthened),\nAnterior Delt
e76c6ae9-7653-45a4-8020-6f798a9fdaae	varun.deoghare@gmail.com	Upper Back Seated Row		2026-03-15 08:15:09.546094	\N	31	BACK	Traps(Middle, upper to some extent),\nTeres Major,\nRear Delt,\nRhomboids,\nLats(Horizontal)
760b868c-a324-4cf5-9bd4-230d602beefd	varun.deoghare@gmail.com	Bench Supported Dumbbell Curl		2026-03-15 08:15:09.792536	\N	32	BICEPS	Biceps
2edc40db-3af5-4655-8122-e98f4054257a	varun.deoghare@gmail.com	Overhead Triceps Extensions(Cable)		2026-03-15 04:20:39.115911	2026-03-15 08:15:30.635676	6	TRICEPS	Triceps(Lengthened - Long head)
c0cefc02-ea0c-45ac-ad3b-5dba23c2e04d	varun.deoghare@gmail.com	Cable Cross Over(hi-low)		2026-03-15 08:16:31.675475	\N	33	CHEST	Pecs(Lower)
dde2bef2-372f-451e-a67f-fcaa8b66b120	varun.deoghare@gmail.com	Romanian Dumbbell Deadlift		2026-03-15 08:20:24.649495	\N	34	LEGS	Glutes(Lengthened)
0c4f28b5-0d47-4635-aa19-88c4648e5670	varun.deoghare@gmail.com	Hip Adduction		2026-03-15 08:20:24.711658	\N	35	LEGS	Hip Adductors
bc6fdb96-c64c-434d-8a46-01695c5793d1	varun.deoghare@gmail.com	Hip Abduction		2026-03-15 08:20:24.751757	\N	36	LEGS	Hip Abductors
d672d230-c693-470f-bb83-3c756af97a2b	varun.deoghare@gmail.com	Toe Raises		2026-03-15 08:20:24.812041	\N	37	LEGS	Tibialis Anterior
5c1be5e3-15dd-4445-8c6d-0228c9150a69	varun.deoghare@gmail.com	Shoulder Machine Press		2026-03-15 08:22:38.619388	\N	38	SHOULDER	Anterior Delts,\nUpper pecs
4e3327ca-c036-4aca-9121-7825fd100fad	varun.deoghare@gmail.com	Leg Press		2026-03-15 08:32:25.430019	\N	39	LEGS	Glutes(Lengthened)
4ce193c2-4b63-4a73-ae9b-b9ca108aeee8	varun.deoghare@gmail.com	Cable Press		2026-03-15 08:32:25.473063	\N	40	CHEST	Pecs(Upper, middle - shortened),\nAnterior Delts
252e01c4-81d7-45a3-a76e-61b0f5169284	varun.deoghare@gmail.com	Single Arm Landmine Row		2026-03-15 08:32:25.496754	\N	41	BACK	Lats(Horizontal),\nTraps(Middle),\nRear Delt,\nTeres Major,\nRhomboids
c058d42f-c206-4d06-b7bd-9fc48d2582dc	varun.deoghare@gmail.com	Preacher Curl(Cable)		2026-03-15 08:38:41.328679	\N	42	BICEPS	Biceps(Shortened)
7b637554-81b3-42a6-91e7-4be285f759b9	varun.deoghare@gmail.com	Y Raises(Cable)		2026-03-15 08:38:41.373145	\N	43	MISC	Lateral Delt,\nLower Traps
6daeda5a-1e20-4cb9-b57a-d19d4b1a1f09	varun.deoghare@gmail.com	Cable Press(Slight hi-low)		2026-03-15 08:38:41.422837	\N	44	CHEST	Pecs(Lower, Middle)
705a645c-036d-41e2-a255-8e97f3b15780	varun.deoghare@gmail.com	Chest Supported Shrugs(Bench, Dumbbell)		2026-03-15 08:38:41.456167	\N	45	BACK	Upper Traps,\nSome Middle Traps
6cbf2c28-d3ab-4fe1-9a22-f4cc433741af	varun.deoghare@gmail.com	Cable Press(hi-lo)		2026-03-15 08:41:24.784122	\N	47	CHEST	PECS(Lower, Middle - Full ROM),\nAnterior Delt
0032c8b4-e05f-46b2-8b73-79d5e40254dc	varun.deoghare@gmail.com	Overhead Triceps Extension(Cable, Dumbbell)		2026-03-15 08:43:30.601607	\N	48	TRICEPS	Triceps(Long Head - Lengthened)
12b4cbbb-a4bf-479c-8743-90ede708ec07	varun.deoghare@gmail.com	Double Rope Push Down		2026-03-15 08:43:30.627519	\N	49	TRICEPS	Triceps(Long Head - Shortened)
a5d36b17-be3e-4833-8a38-89a5522cb9ce	varun.deoghare@gmail.com	Rope Crunch		2026-03-15 08:43:30.661361	\N	50	ABS	Rectus Abdominis, Transverse Abdominis
ae385966-8ff0-45fc-91f2-4adafb7b2926	varun.deoghare@gmail.com	Face Away Cable Curl		2026-03-15 08:45:49.889886	\N	51	BICEPS	Biceps(makes sure resistance in the lengthened position)
801a2d1e-f22e-463d-9287-9fea20b84f11	varun.deoghare@gmail.com	45 Degree Back Extension		2026-03-15 08:45:49.931872	\N	52	BACK	Spinal Extensors
5b5c9a07-106e-40d2-8d43-84c6ea537762	varun.deoghare@gmail.com	Chest Supported T-Bar Row		2026-03-15 07:26:31.176853	2026-03-15 12:32:54.059599	9	BACK	Lats(Horizontal), \nTeres Major,\nRear Delt,\nMiddle Traps,\nRhomboids
34973f2c-876e-4285-b494-c127eb20b94f	varun.deoghare@gmail.com	Oblique Crunch		2026-03-15 08:45:49.958982	\N	53	ABS	Obliques
7631da01-d5a3-4432-9339-6f9c4b9430ad	varun.deoghare@gmail.com	Cross Body Triceps Extension(Cable, Dumbell)		2026-03-15 07:39:25.650483	2026-03-15 08:46:45.890986	25	TRICEPS	Triceps(slightly Lengthened - Long Head)
7581f350-527c-48e7-b2fb-36fde682028c	varun.deoghare@gmail.com	Flat Bench Barbell Press		2026-03-15 12:31:00.674158	\N	55	CHEST	Pecs(middle, lower - lengthened), Anterior Delts
9412c8d7-7ee8-40b2-9762-00ec5cce8f8f	varun.deoghare@gmail.com	Cable Flys(Slight hi-lo)		2026-03-15 12:31:00.801254	\N	57	CHEST	Pecs(Lower, Middle)
90a6d22d-42c0-461b-a2e7-5eba9fed9b26	varun.deoghare@gmail.com	Chest Supported Seated Machine Row		2026-03-15 12:37:58.424661	\N	58	BACK	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids
66ef7c22-3dbe-45d0-83de-0c6e2479f6fc	varun.deoghare@gmail.com	Dumbbell Spider Curls		2026-03-15 12:37:58.486092	\N	59	BICEPS	Biceps(Shortened)
76847003-5e81-4e13-8312-04c9b9a47775	varun.deoghare@gmail.com	Dumbbell Wrist Curls		2026-03-15 12:37:58.559663	\N	60	BICEPS	Anterior Forearm
25d7033d-343b-4f47-b685-d8e92172ac74	varun.deoghare@gmail.com	Dumbbell Wrist Extensions		2026-03-15 12:37:58.613993	\N	61	BICEPS	Posterior Forearm
4d2b580d-d8d0-4cd3-94bd-8787bc3b352d	varun.deoghare@gmail.com	Body Weight Squats		2026-03-15 12:37:58.686397	\N	62	LEGS	Quads(Lengthened), Glutes(Lengthened), Spinal Erectors
f7e132f8-468b-45cf-a4d4-822816f61f94	varun.deoghare@gmail.com	Barbell Squats		2026-03-15 12:37:58.724764	\N	63	LEGS	Quads(Lengthened), Glutes(Lengthened), Spinal Erectors
b2f52ed0-98ad-4fc3-aeea-de96d6dc8293	varun.deoghare@gmail.com	V Squat(Quad Dominant)		2026-03-15 12:37:59.076801	\N	64	LEGS	Quads(Lengthened)
cef7bbaf-5f78-4b64-b06c-43d7a5f28e59	varun.deoghare@gmail.com	V Squat(Glute Dominant)		2026-03-15 12:37:59.12679	\N	65	LEGS	Glutes(Lengthened)
88f75574-40b2-46b0-be7c-63f3c4055ff1	varun.deoghare@gmail.com	Bulgarian Split Squats(Quad Dominant)		2026-03-15 12:37:59.153055	\N	66	LEGS	Quads(Lengthened)
9a5c29e9-ba1f-41c2-8b19-d0ecb0dc3cfe	varun.deoghare@gmail.com	Dumbbell Skull Cruchers		2026-03-15 12:31:00.707351	2026-03-15 12:39:37.596188	56	TRICEPS	Triceps(Long head - Shortened)
aeaebcee-991c-49a0-8609-9476a3097d64	varun.deoghare@gmail.com	One Arm Overhead Triceps Extension(Cable)		2026-03-15 12:42:35.77084	\N	67	TRICEPS	Triceps(Long Head - Lengthened)
e3dcea17-874f-4a34-8f36-72c88ec959e1	varun.deoghare@gmail.com	One Arm Faceaway Curls		2026-03-15 12:42:35.798008	\N	68	BICEPS	Biceps(Lengthened)
b9a10dfa-aa85-44c7-aee7-0fad0d03d2db	varun.deoghare@gmail.com	Shoulder Smith Machine Press		2026-03-15 12:42:35.825365	\N	69	SHOULDER	Anterior Delts, Upper pecs
c0a2a7b5-03a9-4723-b0f5-24bd64115e03	varun.deoghare@gmail.com	Planks		2026-03-15 12:43:29.474722	\N	70	ABS	Rectus Abdominis, \nTransverse Abdominis
273f4a7f-ccf7-455f-bc47-20fd082cba99	varun.deoghare@gmail.com	Ez Bar Skull Crushers		2026-03-15 12:48:58.408333	2026-03-15 12:53:20.579637	71	TRICEPS	Triceps(Long head - Lengthened)
469de596-279a-4a22-a3a3-9b65595dd0a6	varun.deoghare@gmail.com	Dumbbell Chest Supported Row		2026-03-15 13:40:53.224406	\N	72	BACK	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids
20771470-7846-4ba5-a67f-2d766fc83140	varun.deoghare@gmail.com	30 Degree Incline Dumbbell Press	https://www.youtube.com/watch?v=mR6_jMWNlQI	2026-03-15 12:31:00.471743	2026-04-06 03:16:10.365709	54	CHEST	Pecs(upper, middle) - Lengthened, Anterior Delts
8502f636-32a8-41db-a4db-2b4ed334847f	varun.deoghare@gmail.com	Flat Machine Chest Press	https://www.youtube.com/watch?v=_69Kbze7idE	2026-04-06 03:46:13.037137	\N	73	CHEST	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps
cc967e84-e4df-4a8e-9133-85674304ad57	varun.deoghare@gmail.com	Triceps Pulley Pushdown	https://www.youtube.com/watch?v=CHz2KNxqGqY	2026-04-06 03:46:13.282082	\N	74	TRICEPS	Triceps (Shortened + Mid)
90bedca7-dfd2-4ebb-b4b1-89e2d70f838d	varun.deoghare@gmail.com	Dumbbell overhead tricep extension	https://www.youtube.com/shorts/T3e390Dl3XU	2026-04-06 03:46:13.369639	\N	75	TRICEPS	Triceps (Shortened + Mid)
bb3ae4ee-3819-4bf9-b04b-a5010e71713d	varun.deoghare@gmail.com	Dumbbell Lateral Raises	https://www.youtube.com/watch?v=UDPaZ2CEYh0	2026-04-06 03:49:26.286286	\N	76	SHOULDER	Lateral Deltoid ΓÇô Mid + Shortened
\.


--
-- Data for Name: exercise_sets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercise_sets (id, exercise_id, set_number, reps, weight, rpe, tempo, rest) FROM stdin;
87e26f0d-61f4-433b-9c48-49ae1d3e6927	cb46b512-ecff-457d-b3b5-75eab62c55f4	3	8-12	\N	\N	\N	\N
7ccd4642-d6d5-41b4-851f-48d261362552	be42f11b-4613-4542-a517-ae494a1ac0f9	3	8-12	\N	\N	\N	\N
77ee6834-2608-4467-bbd6-48e1063ebcf6	7430f4f4-bdb0-4d58-95cd-c4b44a9c753d	3	12-15	\N	\N	\N	\N
c4e3c0d2-53c8-406c-869f-054f6d4bb9b8	a278119d-7d73-456d-ae07-e3935c4239b0	3	12-15	\N	\N	\N	\N
c962863d-8178-4463-9717-a65c98ae7392	01a9d35e-b551-43d1-98df-548b8b098de3	3	8-12	\N	\N	\N	\N
c2cd329b-e7c1-4bfe-b7a5-e5742f53d593	d235e5b8-524e-437b-8553-1a2f380236e1	3	12-15	\N	\N	\N	\N
82aee5f2-b3ce-4a78-8664-57858c34bc0d	618a4fb9-c673-43e7-a7d1-6c1a6c29fe8f	3	8-12	\N	\N	\N	\N
14c2977d-30be-47c7-92fd-715dc36a42cd	137d191b-d85e-4b9a-8574-901113530da6	3	8-12	\N	\N	\N	\N
c9e502ef-310c-406f-9216-ad18ff6c8f41	9e95f8b4-6553-4e3d-9fa9-bcf4da72b2fe	3	12-15	\N	\N	\N	\N
a0f284f0-2196-4f4b-a0c3-b9ee6b014ffc	03e5738f-e9fb-44fa-b25d-1a6d7b50fce5	3	12-15	\N	\N	\N	\N
891360f6-b639-4ad8-8f39-2362ddc0bb3a	311748b4-4167-4945-a93a-0fbf4f976050	3	8-12	\N	\N	\N	\N
a336ca8a-4f22-4347-9881-b85145691ba4	0ab27474-84c2-41b5-8d03-5d8516e102e4	2	12-15	\N	\N	\N	\N
f8c3cada-dace-43e5-9d9f-ad7d6ac15858	f6e044c5-60c1-4b26-801c-6c6f6b325bca	3	12-15	\N	\N	\N	\N
21444080-75fd-4718-9544-b0fb66b9ed7a	6dd1a2b2-93ef-49bf-9a24-9b5a497f2d1b	3	12-15	\N	\N	\N	\N
9aed5c15-9bbd-48b8-960b-f6f7cf69b98e	da16d4e9-3b24-4f24-a6e0-aa110dccfd3d	3	12-15	\N	\N	\N	\N
462b304f-e82d-49d5-b314-373310d1e5e3	31aaf5a7-1fd9-48f5-903e-d9a522ddf011	2	15-20	\N	\N	\N	\N
84ce97f7-9064-451a-9f4d-7a7513fd8ecf	4645f03c-5d12-4b1f-854d-7eb352366cdc	3	15	\N	\N	\N	\N
ff5b1eaf-206b-496a-8ff5-b32d734808c8	d832c372-33af-4a31-86eb-8794f3af5638	3	15	\N	\N	\N	\N
4729dacf-24fe-4247-afbc-6b164dd58186	e48c4503-6f11-4d0f-b10a-d6673858a762	3	8-12	\N	\N	\N	\N
b3d2b74e-4374-40f3-b631-24d01252d83c	2ae42b5e-1404-4bd8-8ebf-373fe9a7fff6	3	8-12	\N	\N	\N	\N
3eb8c8f3-32f9-4009-9e7a-684902b0b82f	4cf7f116-da64-447b-8b9e-c6f492a9893b	3	12-15	\N	\N	\N	\N
d22fd0ac-33ef-4192-a966-46198d8dc638	3a27c0a2-2214-4072-ba11-2ae085fdf073	3	12-15	\N	\N	\N	\N
393d5ca3-9b1d-4602-9a83-8f4e7f62d8ff	aa35b7fb-7882-45a7-b012-8f88b32c19c4	3	8-12	\N	\N	\N	\N
0bf0f501-388c-4306-bcb6-2968205fcdb8	8e654417-e68d-45f2-97aa-3abb2359322e	3	12-15	\N	\N	\N	\N
d7f2e5b2-39b2-4af3-b5fb-1601977d159c	d189681b-dbde-4783-a09f-04113ef0a18d	3	8-12	\N	\N	\N	\N
6704b8e6-619c-4117-a47f-187efa9f6609	2a5a939e-9a5f-48c9-8ec8-76383f71ac8b	3	8-12	\N	\N	\N	\N
761c3832-cadb-482e-be08-aece714613df	d69e9a71-a6f1-4ccc-b746-86660f0f9cf8	3	12-15	\N	\N	\N	\N
72d1afd2-58e2-4e9c-956e-dc462d64c2c6	8000f016-af23-47f1-a9f5-929b1f3fa7eb	3	12-15	\N	\N	\N	\N
07dd7561-77c9-46f4-8940-07d17d4626a4	34291a16-4266-4ba3-a74b-daf951995c67	3	8-12	\N	\N	\N	\N
ad195e59-1d23-4d4b-bd37-619280e0269a	c0ff2a07-b24e-4be6-aa51-3d831e5c0d58	2	12-15	\N	\N	\N	\N
39fa173c-2ca7-42a0-81ae-a555f0ff4373	16473a4b-c8cb-4f92-a93f-4dcaa87e864d	3	12-15	\N	\N	\N	\N
2c2f7e25-5131-487a-bd31-25a83246e513	30dad80c-e3d9-4a44-afcd-da47ca9dd76c	3	12-15	\N	\N	\N	\N
63f188ef-7bb7-4462-a463-c21788ac0950	75d6f39b-7b22-4236-8e7f-de560eb8975b	3	12-15	\N	\N	\N	\N
d23ca9f9-c7aa-448a-81f3-9f42f3c9d3b1	9ea3b2eb-2af5-469c-bf64-68948a929b8c	2	15-20	\N	\N	\N	\N
f5e41c85-bca0-4f24-829a-d6ee93db3425	e4d23fe3-8ccb-4227-a1d0-0c902f4edb32	3	15	\N	\N	\N	\N
e9b398de-ee41-4794-be8a-209eb6267bfa	f3b2701a-7ee8-4776-9333-f2cdcb0d2dcd	3	15	\N	\N	\N	\N
2535dda7-2ad1-4b24-93cf-ac95cbf9cbf0	3fe194d6-9afb-4328-b9bb-62db66c1d704	3	8-12	\N	\N	\N	\N
51dad008-3ae7-45bd-99cc-fea0ad3a20fe	6ef48986-4bb2-4b34-bd40-7b461e6b8de1	3	8-12	\N	\N	\N	\N
83860596-5716-4768-8bb7-e9770fefa62f	c95f8b3a-5925-490f-86b6-1ba0c4d4b009	3	8-12	\N	\N	\N	\N
eba73b1c-7dac-46d6-8c90-97d0a40ecb2a	e16a4c6c-3855-4be5-8384-69ac62130955	3	8-12	\N	\N	\N	\N
96d91767-ce6c-4f15-8eac-863571a379c8	7e91bc52-2c4e-4032-8640-f8994c2ed393	3	8-12	\N	\N	\N	\N
e5b7fad4-65da-4b39-aecb-7ed077d6b55f	1101c52e-42da-4582-84d7-fbefea89011e	3	30-45 sec	\N	\N	\N	\N
927ba57c-786f-417f-9238-355ded74c090	1ed34dc2-7fb1-45bb-9192-1ffd3a21f3c2	3	8-12	\N	\N	\N	\N
2e566819-f36a-41b5-a828-1ca70499e9f9	b8179696-06c6-4c5d-8479-59ce6618f066	3	8-12	\N	\N	\N	\N
24081773-ccfa-45cd-b70e-205ad9d006a8	090aa915-2a77-4415-8a51-8ef86ae30db2	3	8-12	\N	\N	\N	\N
7fe727b3-16bc-48fa-aaf2-0a2f1d1ee4cc	8b0329fa-61dc-4acf-bf8b-f1123bb0ef07	3	15-20	\N	\N	\N	\N
8dd199f3-9f2e-4b32-8202-2c0c5eebc137	b820928a-c623-4a1d-9721-0f5cf8d7342d	3	15 Reps(Each Side)	\N	\N	\N	\N
1f4b88fb-7bc8-45db-aa26-2739f5788135	b97cc8ec-594d-465f-bdf0-662da3ac3cdb	3	8-12	\N	\N	\N	\N
d4f34a75-d817-4517-9a99-53534bbf79e0	60c0a900-1909-4689-8443-23ba0318b033	3	8-12	\N	\N	\N	\N
9af37d32-d65e-4c21-9e54-dbb2538dd763	38c8d3f5-a12b-4663-9db5-02a697b53191	3	8-12	\N	\N	\N	\N
2b7925a7-8625-4be6-b8d6-b7eb6e0bace1	8555cfb0-1d75-4587-914e-516651d5fa51	3	8-12	\N	\N	\N	\N
1fdf5d79-64a6-4a01-bff7-d0bcbd6d7481	b3b0665e-6a57-411b-9bc2-96ceb142d551	3	8-12	\N	\N	\N	\N
89642bc3-2b1d-4b98-be23-6d3c44eb2aeb	edbc06d5-2c00-4d42-a867-ea2fea818dbc	3	30-4 sec	\N	\N	\N	\N
36aa9f9c-c1bc-41ae-aeae-163f5c3509a3	01a96348-56e6-4471-86f9-89d1b83c046d	3	8-12	\N	\N	\N	\N
27fd8d66-e269-4bc7-90d8-03a7e5832d3b	87ddebd6-043b-4e68-87e4-96aa68c4c34f	3	8-12	\N	\N	\N	\N
6c223331-1b50-4706-8d7a-388a796a8565	031b61f3-981c-46f1-a999-0bfaa105184e	3	12-15	\N	\N	\N	\N
76ab83a2-a9af-4b95-9644-9ad953032b5a	5476af43-0de2-4a7f-a455-0cfe4bff4277	3	15(each side)	\N	\N	\N	\N
b681a57b-660f-4b43-a433-3aa7d0bbf9e8	68f0ef5b-a02a-4c09-a459-a50a6230c7e3	3	30-45 sec	\N	\N	\N	\N
8c83ad2f-4239-408d-bcfa-95f4cc27ed3e	230434f2-bdff-43d8-a696-b7965e95a3d3	3	8-12	\N	\N	\N	\N
abe5c05b-a75e-496e-81cb-c279ea3e93c5	9678ba63-b524-4531-a1b7-a89671f4d902	3	8-12	\N	\N	\N	\N
f1877128-ffd1-4fe4-8de9-d346e3454dd7	9418ee45-0216-4013-bc4a-53656d0a0a7c	3	8-12	\N	\N	\N	\N
27ded3ab-9c18-49d9-8489-a4b974125df9	0b542d3c-07c6-4a5b-ad24-642438382f15	3	8-12	\N	\N	\N	\N
97f4070c-2c46-42e5-91da-b903fd813548	210add6d-c13c-459c-a653-664fba87645a	3	8-12	\N	\N	\N	\N
022945c9-be20-4d3b-b579-53b1bececd29	a49bf19b-25ef-4f3e-b017-9bdc95878473	3	8-12	\N	\N	\N	\N
aff9a492-2a0a-4d65-b0d1-6287ca709830	dff688f3-4f33-41e0-b669-45dcbdf445f2	3	8-12	\N	\N	\N	\N
b1198bce-6393-45e7-bb8a-0bdf86da78f0	0f81c855-0ef5-4041-bec3-cb2ee30ad7a5	3	8-12	\N	\N	\N	\N
0aa53674-409d-4fb4-adbb-64a8e8e5541e	5bed39aa-2f55-460a-a102-e2500288c37f	3	8-12	\N	\N	\N	\N
540ba53a-14f6-467e-ace1-4ac666453a27	95a9da1f-6219-428e-9617-12a4970e6c91	3	8-12	\N	\N	\N	\N
6d808cc0-c233-4c8f-a79c-81c7a3abb6d3	fbca66e3-f323-4fb2-88e7-1be3bfe9bc3a	3	8-12	\N	\N	\N	\N
77a92cee-f624-46b8-beb5-19f8cc0d5240	ef4f107d-6bcc-43b4-9850-3b5e3f1cb29b	3	30-4 sec	\N	\N	\N	\N
cd5a722a-b888-43aa-b943-76dade7244e1	9369e1f4-fbed-4f5e-b2e1-0ea5640e3ffe	3	8-12	\N	\N	\N	\N
66e79e44-881c-4e79-b37d-6ae3dc2cb820	286c3e2a-1a62-46d2-9cb2-27133a63b7ac	3	8-12	\N	\N	\N	\N
c44a48b0-3758-4c3a-b398-93d9407c4e25	3179a2f6-5e6f-48ca-bc6e-6ea5833da79c	3	8-12	\N	\N	\N	\N
c4a54c9f-70c1-4394-9bdd-4f0b3c6acbc5	95662f72-1496-4fb8-96d8-70852543a202	3	8-12	\N	\N	\N	\N
1b45f536-8a29-4510-9bdb-0942ece2aef3	05f230dd-ecab-4605-b5b0-efee7b12b61b	3	8-12	\N	\N	\N	\N
3201786e-d52f-4444-b77d-8650c678b751	e98b4d20-cb83-4030-b6de-2062319880c0	3	8-12	\N	\N	\N	\N
e53fec5d-361e-479f-a7c0-30574c806fef	d6268629-84ac-4065-90b5-706b92ec962e	3	8-12	\N	\N	\N	\N
c7acc1fd-1d3c-474b-af0e-71560ac54a66	ab930b85-cd1a-47f8-95fe-fa31a4742c06	3	8-12	\N	\N	\N	\N
642839cc-344e-4af0-a32e-5e07298383a7	9d85e08b-e65b-4527-9f20-8ec9f91ec477	3	8-12	\N	\N	\N	\N
0a6b0fe5-5fea-4afc-8eff-f20b8846f88e	c80b9469-7e49-467f-919d-6caebe6a4c1f	3	10-15	\N	\N	\N	\N
2e47e86f-9dd9-4e4d-a956-d822b390ee38	cf9d07ef-0412-4098-81d9-4b42d7dd3394	3	10-15	\N	\N	\N	\N
8fe09e6f-bc00-4de9-8ce5-e4bd942e0223	22f0b80a-0f7d-4de3-a436-05ea13a2d4d8	3	10-15	\N	\N	\N	\N
4472b139-368f-4c09-a433-958b1bdd0fb5	75e29dc5-c41d-455f-a592-53eb72d39a2f	3	12-15	\N	\N	\N	\N
86b8691e-f973-4ab3-b27e-b427830e2d86	23bbb7e4-5989-47ff-8ad7-060eeaba46e5	3	8-12	\N	\N	\N	\N
a98a37e8-f2d8-4e62-aa66-d14a03d47548	38c2684f-4338-4974-898f-84ffc49884cd	3	8-12	\N	\N	\N	\N
9a2b1176-6562-4ff3-88c4-f84095022688	978ab03c-0196-4cff-8414-8fd51b5a85a5	3	12-15	\N	\N	\N	\N
b7aa6e60-23bb-4e8a-9af9-6cd0e38344aa	10a524e0-a132-4998-92f2-a9d5439b9c83	3	10-15	\N	\N	\N	\N
ca871a59-74c5-4ac9-bd05-2b10c1fca66d	24df4b8f-7abf-4657-9405-5796b95c3bf4	3	10-15	\N	\N	\N	\N
417c39b5-90fa-458f-bfa5-d8c10dcfab2b	0eee8cd0-d579-458e-a07c-128cb7371122	3	10-15	\N	\N	\N	\N
df13df44-94f0-4c0d-9b5a-369d493bb02c	760e9336-9abb-4dd6-bbb5-61e958624b82	3	8-12	\N	\N	\N	\N
8a2e0f10-8f3b-43a4-825c-966053bf5a1e	525c753a-8bb1-4694-a3cb-1aee31119806	3	10-15	\N	\N	\N	\N
65d092ac-52ff-446e-9b90-68e2361dae69	c3bc5460-34ca-4367-b575-eedb12cca7af	3	15(each side)	\N	\N	\N	\N
e5f0415a-f4af-48fc-8610-3b121e0f1222	9413ceb5-b5e4-469f-a090-50f09c38eddc	3	30-45 sec	\N	\N	\N	\N
b3620fb6-fe41-4944-bd57-7396c792e5f3	faa3d905-bcd0-48b5-b9eb-c159c95eaa85	3	8-12	\N	\N	\N	\N
952769cb-272e-4d89-8c56-46cb692c5134	b179045f-84ae-4e1f-84a4-108fe26b5e0f	3	8-12	\N	\N	\N	\N
e1f55afd-21d6-403e-b17a-a1c0174336fb	d972da97-641a-458b-a830-4cfea174dc97	3	8-12	\N	\N	\N	\N
05e5dc7a-acc0-418e-ad73-338875db47d2	784b0dff-7605-4524-b976-71a6c14eed43	3	8-12	\N	\N	\N	\N
614f63f6-eb8d-4dec-b0d9-fdcd493dc1b3	c91dc0a2-d0cc-4929-a630-0126d4bf89fa	3	8-12	\N	\N	\N	\N
9a77853c-7240-45e5-a03e-04463e4281e3	77c8bd1f-1f75-4d90-818e-5f602ce46ab9	3	8-12	\N	\N	\N	\N
c074a392-39b6-4535-a406-792658d86412	86ce245c-57ce-42ee-a104-28a8f84dd31e	3	8-12	\N	\N	\N	\N
2223f893-c422-490f-a804-581c887e4d20	423df60a-0aca-4990-bfa4-e566a7c44d99	3	8-12	\N	\N	\N	\N
83cf874c-a480-4964-b040-d269c8d7728e	e557a261-9a53-4a2b-b8ac-77209bb887a1	3	8-12	\N	\N	\N	\N
794e2bc2-ddb5-4fd9-8187-6958845b7129	7b029637-2992-4b09-aeab-6e1fb8f088b4	3	8-12	\N	\N	\N	\N
c871624b-8d30-4421-89fa-73eaf9927a40	63109499-45ae-4465-a51b-26a760c2936b	3	8-12	\N	\N	\N	\N
1bfba64f-86db-4193-8e02-eeabab1f190f	d5b13ae4-d538-4e44-85bf-b9df2b11ee87	3	12-15	\N	\N	\N	\N
f48d90e8-3f39-4548-949e-a95cf75f362f	0c2aee86-b7bd-461a-b574-5749f8f98722	3	8-12	\N	\N	\N	\N
1711aade-09e8-46c3-939a-3ca438a87cf6	13e8ffbd-a251-49b8-b7b8-ba10d8b28796	3	8-12	\N	\N	\N	\N
96e74b0c-ac33-4dcd-a9a4-fde1b55e83e0	339b4372-d9cf-4c8f-8a19-1b0b354370f0	3	8-12	\N	\N	\N	\N
297bb83c-80bc-487f-be15-ecee07c58616	78f78f68-a270-4604-8edc-79de070cee7f	3	8-12	\N	\N	\N	\N
5ed2d94e-c933-4c57-9f44-b24983384697	68795a52-7c4b-4ff0-9f7f-b7645c175a0b	3	12-15	\N	\N	\N	\N
b62de709-ff9c-4cfe-a680-d70a63652a75	8628ac2b-5209-40a2-9e25-79eebce9a7e6	3	8-12	\N	\N	\N	\N
af4b45a8-667e-412a-9f53-cfaa815e87d6	3ba428c7-88b5-42ea-a816-1d0be39503c6	3	8-12	\N	\N	\N	\N
3c033e2a-4db1-4c8b-a7a4-e5ad627295cd	8d5ace9c-cf9a-4d05-9daa-7075652d093a	3	12-15	\N	\N	\N	\N
442f7a2f-2d6a-4343-b460-8861ea171c42	8248ac88-a792-4740-9b02-3b2ba8a6b521	3	8-12	\N	\N	\N	\N
66e145c8-d6bc-4cf7-a351-547dcff86875	cd2ef2ea-6794-4062-8d66-71599453d9f3	3	8-12	\N	\N	\N	\N
c896c3dc-109b-464e-8f99-4faab67df0b4	9a873de4-7b39-4023-933f-48bf210144e5	3	12-15	\N	\N	\N	\N
f6ae886a-eb38-47a9-93d5-d75951457a05	edda8155-1304-48a5-b418-7d2bd73ae760	3	8-12	\N	\N	\N	\N
65ca62c0-314a-49b2-8862-d6e968d03bfa	054c6fb9-47f4-48f7-990c-6f0321dcfaf4	3	8-12	\N	\N	\N	\N
f123ec68-f410-4d2a-ad93-434185171e76	b441978e-b634-4633-acad-8293f0ca5232	2	12-15	\N	\N	\N	\N
de6b43fa-0c27-4e7f-9f26-23608b7f3efd	b53e5f59-b4f5-4ab1-9ec7-7cdde9334ef5	3	12-15	\N	\N	\N	\N
7ab8aaff-edb8-4815-a77d-ee893fb1357e	2f4b2643-851c-412a-bf63-502c59dd4140	3	8-12	\N	\N	\N	\N
c0f3608a-9330-4970-b791-18c100b1c866	879e2d92-dd7a-4086-ae09-0705d1284ac2	3	12-15	\N	\N	\N	\N
f359a939-b0f6-4a47-b0bf-fe52b9081563	cafa77d5-dba3-4fef-8f34-bc02fe5b6e17	2	15-20	\N	\N	\N	\N
fd08e5f5-aa99-489b-adb7-34d2fddbbda6	252f8a28-2374-458e-9239-ba70cce9d536	3	12-15	\N	\N	\N	\N
9f872979-fd40-44f0-8d2c-ce9a3c4139e3	3173a62a-0ac4-4421-a181-a06c63e6459e	3	12-15	\N	\N	\N	\N
ff964285-b99c-4835-a836-9a59477c6b13	ffa1bff5-b58e-43c6-a6b7-69c7595ea944	3	8-12	\N	\N	\N	\N
dd97f005-20ec-4449-a116-34b55f590a8e	a93951c1-11d5-4228-9183-3878158cb535	3	8-12	\N	\N	\N	\N
99a07778-4490-43c6-be49-0c0c6957b837	f79d684c-c73d-46b2-a3ca-5bd507cb727a	3	12-15	\N	\N	\N	\N
cb023569-796b-4a52-97c8-bc7cff5250f2	baadbd29-d023-451e-852f-bb0a3cf50223	3	8-12	\N	\N	\N	\N
d92ac5e5-27b1-4ac2-9c1b-ad47f007e687	16c81899-dcef-44d3-ad90-c82ef90e96fa	3	8-12	\N	\N	\N	\N
08cce9ac-75eb-48e1-a382-2d3eb3c90552	e696d844-3905-4267-a4a9-5c42964a732b	3	12-15	\N	\N	\N	\N
f69d961f-e966-4114-adc4-79d99cd8bd57	cc4f1538-aaf1-4b61-ada9-9d6c202fef47	3	8-12	\N	\N	\N	\N
cf2b3afc-f456-4043-9724-ddcd0573e6bd	a3ad6192-97d1-4be7-95c6-0dfbce00f7b2	3	8-12	\N	\N	\N	\N
3586216a-3ba7-4f8a-82a2-b45038a5b3db	dedfe8a2-4700-4848-a1e7-a9f4bd68897e	3	12-15	\N	\N	\N	\N
48d1c2cc-1931-401c-b86f-03bf44ae467d	cd526831-8194-492f-94b6-63b19ea9f858	3	8-12	\N	\N	\N	\N
e9dd5bd1-71a0-4b9c-86fc-69f850671608	916300f2-486e-4e6e-b694-e9efff569c86	3	8-12	\N	\N	\N	\N
74c58f2d-c8d0-41de-bd8f-b1f3ec64da6d	59568adc-2355-49a4-8ba7-8f29cd4cc983	3	8-12	\N	\N	\N	\N
dfdcfef2-8d0f-41a3-a801-ba9a3914f4db	1724f5ad-d5d1-47be-9194-8c8bb4587d81	3	12-15	\N	\N	\N	\N
c6d84865-d9da-4695-82ba-5c860f9fe8b9	39241834-2ea3-4c32-8399-8c7e6a457a3d	3	12-15	\N	\N	\N	\N
547e5d80-8899-42b1-9c4b-958d525f31cf	476c3c12-ba10-4005-a4fc-bb3455f628e8	3	12-15	\N	\N	\N	\N
bf56b06b-746b-4896-83e5-2c4483f3953d	6bab4d37-aba3-4676-b4af-7cf0baef9117	3	12-15	\N	\N	\N	\N
1a92a2ae-8fd3-46fb-ae0e-de62a59a69cb	612bdecc-cc99-4575-8427-c4f69405aed1	3	8-12	\N	\N	\N	\N
1954f8d1-0f8b-4c49-a58e-36c9bf007b02	29153ab1-5ac3-4726-8ace-6e5d448c22cf	3	8-12	\N	\N	\N	\N
8e901748-3f15-45ea-a734-e662fed12b0b	6d0a2fde-39d2-473d-bd33-f523466c8069	3	12-15	\N	\N	\N	\N
97e5269e-b0cc-47a8-b052-fd04d1850308	3a34b030-b981-47f0-a083-708b2050eb16	3	8-12	\N	\N	\N	\N
bca5d698-6766-490f-be37-7b066cfd12b2	4cfaa592-98d1-4223-b131-dcdb0e8750f2	3	12-15	\N	\N	\N	\N
dbd0cd78-b467-4cb0-a287-77bc4fdaee55	0ae0cd4f-25c4-4117-b30a-a8ce505baab8	2	12-15	\N	\N	\N	\N
f742e34f-85d3-4d22-8c13-bc95fb592da8	eaf5ae5b-80e4-47cd-bf3d-6a6a23b9918a	3	12-15	\N	\N	\N	\N
1357110d-63c8-4e64-9bdb-c7c5520aab38	24752967-92ee-46ea-92d1-081672d867d2	3	8-12	\N	\N	\N	\N
9aa6d532-8c4d-4f5b-9362-e94e4a50a2d8	ef3e24db-3c89-436e-9f77-4aa4a056dae6	3	12-15	\N	\N	\N	\N
392d7699-a94a-4ce6-858f-0be813c7d9fd	3e05930a-8c51-4a30-b5b9-8c713f31982a	3	15	\N	\N	\N	\N
cccf147c-b988-4021-85ff-dc38ec2cbdcf	5b41aeb3-c7a3-4e3f-8c1d-54b40908eec5	3	15	\N	\N	\N	\N
1a17caaa-f48a-4d69-b994-0dedb2c4a29f	6c7702ea-5fc5-4152-81c5-7761eb5dece3	2	15	\N	\N	\N	\N
7d991b00-3d93-4e79-9ec9-85154416f582	d0554860-5cd6-42ff-8ef6-8fbf4634a39a	3	8-12	\N	\N	\N	\N
cf401c49-a693-4c1d-a9be-9a5875f47bd4	9243cdb8-6de1-4d64-869f-fdb8ec706af7	3	8-12	\N	\N	\N	\N
113796ac-9771-49b0-974d-edfead0a995a	b0c71005-6a6c-4597-b4eb-12f805183460	3	12-15	\N	\N	\N	\N
1fa024f3-e054-455a-bfb5-9102291c5a47	f0ad6b34-5430-4f10-a64b-9e5479695b0d	3	12-15	\N	\N	\N	\N
dfd55583-bb2d-4cd5-bf5b-f8ff0d3b380a	4b661642-99c0-492e-9717-b89a85bb9e76	3	12-15	\N	\N	\N	\N
5c4e4662-8147-4710-bf6d-ea0aecd8212d	171d4c8d-b77d-4617-b1c6-858b8a61b09f	3	12-15	\N	\N	\N	\N
f6fcc896-524d-481a-a5d6-41dbb62e9312	1884e93c-bb9d-48e1-9db6-9324f639cdac	3	8-12	\N	\N	\N	\N
a0c99df2-c652-4bc5-8c0d-2f14608370c3	93f619a1-fbb8-4dca-a9a7-1d80bbae02fe	3	8-12	\N	\N	\N	\N
18a72057-29c8-4013-a2c8-430f04be0fdf	8d0ecaee-3a22-487a-ba62-0533264b8a21	3	12-15	\N	\N	\N	\N
5db2ada9-08ac-4d71-8859-dfbada580fd7	726d5c24-82c5-405c-891e-713317e4a779	3	8-12	\N	\N	\N	\N
32550a1d-b593-4c87-b656-076cb320fbae	a5944627-3829-4528-a31e-901c674ba330	3	12-15	\N	\N	\N	\N
63305043-a6ad-4e66-9630-dfca7ba390fe	074aa954-fc5e-4faa-94df-c8dccff161ca	2	12-15	\N	\N	\N	\N
7c7380cf-e082-469b-9b9e-fbbab7161e4c	8163e280-2945-49c1-bab9-4845dc613304	3	12-15	\N	\N	\N	\N
913c4c4f-c8f6-4b89-8732-56aa20f7abef	8bb4902d-c1c5-4030-8724-967790a27b36	3	8-12	\N	\N	\N	\N
9ed3f455-e27b-48b4-887d-62d6f350af04	e55e9afc-9dba-4ed5-9426-0ada894664c6	3	12-15	\N	\N	\N	\N
9947643c-c835-4803-b586-45896863751d	83aa4348-d3ba-45cb-abff-4324c9867d55	3	15	\N	\N	\N	\N
74398200-41b1-46df-881c-bb52e0635018	a174e6ff-c5a9-4cd2-9464-d07317c59a95	3	15	\N	\N	\N	\N
c1653488-baea-4214-ae19-09e741edfefd	fd9431fb-f070-4c89-9b92-aaf37b10f9a6	2	15	\N	\N	\N	\N
64767a92-27b8-455a-9e35-eff23a695842	420ffa5d-a9e6-42ac-8ad2-72f44ab5c548	3	8-12	\N	\N	\N	\N
63fc75a6-aa66-443c-8da6-4f48b11f7c13	b4c144dd-178a-4596-9d71-f4c88ee88896	3	8-12	\N	\N	\N	\N
1f2c1af3-cc4d-4c5c-aacf-cce202a032f4	cd2dcf16-eb4d-4046-8c18-6074791d439c	2	12	\N	\N	\N	\N
cf3db223-58b9-4cf4-9e41-a85a5df1e812	10594a1f-457d-46cd-bc93-2b64029e0ba0	3	8-12	\N	\N	\N	\N
fd060d7b-0ccf-4e42-8fc5-0ba8c824bee6	cc18f924-6286-4bbf-a2ec-d14c73208a39	3	8-12	\N	\N	\N	\N
18265c6d-9251-479b-98ce-3171250fdb15	0d937ccc-adbc-4b36-8059-406e99a08793	3	8-12	\N	\N	\N	\N
7b05efe5-70d8-414b-a313-3c421f447a85	411ad8e8-4099-4a11-8d08-da48331157df	3	8-12	\N	\N	\N	\N
3a514a65-ac34-4ee2-95f2-de024869755b	54729b8e-267f-4673-9152-e87c5a0cead4	2	15	\N	\N	\N	\N
0fbe0a77-e636-48bd-a96e-924b54fb2192	c93a09d1-2658-413b-9cd2-f091c8dd67a9	2	15	\N	\N	\N	\N
50f43788-1aed-4481-abf2-4db09520139f	76781196-d566-4bff-a3be-ea121b5701f2	3	8-12	\N	\N	\N	\N
4ae1f136-85d1-4fc8-8f0d-25b34cec9311	ced8a8c4-8cc1-4cf0-902e-6e8875efccf3	3	8-12	\N	\N	\N	\N
169a63ce-4da3-459b-9202-3e33007619fc	01eeb95f-2954-4fc9-8991-40a09a44bf9c	2	12-15	\N	\N	\N	\N
ca9a880b-29ed-4738-9456-dabd632aa1a6	88aed8b1-0820-475f-b0b0-6be251cd8fc3	2	12-15	\N	\N	\N	\N
b2e01bcd-a00c-440d-be02-ccb219120351	03c22cc1-58ec-41ab-b963-e770ac0ffe30	2	12-15	\N	\N	\N	\N
2144b83c-07ef-4e9f-8273-319f1646068c	96660ad6-22de-48be-a689-a13afce85e66	3	8-12	\N	\N	\N	\N
f31454cf-67fe-4ab1-97d1-bca1bd2446c6	cb23250a-3ffe-4d2a-92e5-8f1808fd27e3	3	8-12	\N	\N	\N	\N
3c4d978c-37e8-409f-89b9-13e92e36b392	b4db037e-05fe-4f0e-83f8-0cdf0975762c	3	12-15	\N	\N	\N	\N
85794477-8246-418a-abc2-2e86832b3b43	f6d45537-9f42-4f58-9cd6-71864396e144	3	8-12	\N	\N	\N	\N
af0586a6-d26e-4b14-9950-9fb176fc7044	1a738284-1c16-4d35-b498-d9b6a66e3050	3	8-12	\N	\N	\N	\N
59958b6e-8491-40c1-a9ac-3ce008cda00a	035d0cf2-3e56-4ae2-a3ca-7cfbc12c625b	3	8-12	\N	\N	\N	\N
62286f9a-e33e-46de-929b-7df1e17314f9	dfb46451-d6c4-4201-b851-e12722c1c02f	2	12	\N	\N	\N	\N
221ecbab-c886-4a91-8b1d-2a5ee3594233	ac99d8f4-2867-4e00-9d65-8d162f2c2c6f	3	8-12	\N	\N	\N	\N
6863bd24-0766-4c14-bdd9-bcf718e780b8	5bb1a87c-990a-41ad-8ba8-913077c71d31	3	8-12	\N	\N	\N	\N
ad90b70e-3fe2-4eb6-8002-18b7e85026ce	d9bec449-ee89-4f66-99d7-50c9668f92c5	3	8-12	\N	\N	\N	\N
36a29adf-50ce-4615-ba7e-f00c62e5d4f4	84a97e4a-4b8b-4ac9-9c74-a5c48a04e02a	3	8-12	\N	\N	\N	\N
d0efdfa2-e47b-45f8-9f5c-f50ab074cb17	d371a2ee-c064-4c8b-89e5-7936f8a8d6df	2	15	\N	\N	\N	\N
32741d06-50ff-4ca5-8524-f94bd134f794	4a475f00-e7d4-4b98-9896-91e1dcbee246	2	15	\N	\N	\N	\N
a964dada-1f55-4c12-be87-c001e369cd3a	0c772017-0415-4355-8e59-5b52102741d2	3	8-12	\N	\N	\N	\N
1e4cfc39-a31c-4776-b6dd-be29760e6126	fae9df54-5974-4e15-8937-f431f6d613fb	3	8-12	\N	\N	\N	\N
05da13c5-6a83-4b0e-851b-765b27e39600	278b28bb-d748-43d6-a49f-b85a87f1518d	2	12-15	\N	\N	\N	\N
d4cbbdb2-6560-48f8-8ba5-54f0162981b2	0c0f72bd-9cfc-417c-8d18-0d51c17a74fd	2	12-15	\N	\N	\N	\N
57a8d793-6afb-4a18-8e12-3862d65cf673	b78b8f96-5a4a-4367-aeb5-f640e7339b8c	2	12-15	\N	\N	\N	\N
a0748985-dc0a-44a1-bc94-2c94c35e9daa	22ffd7e1-015a-4c3a-b782-336385517ce2	3	8-12	\N	\N	\N	\N
d9010666-3f07-4d92-8a10-b8f03a39abf7	b6858523-8ec3-465e-ab5b-a9416c3f4d89	3	8-12	\N	\N	\N	\N
62d5f94e-a6c1-426e-a68b-b1c95cd2f194	aac6fba0-0617-4902-97d9-643774b8fe70	3	12-15	\N	\N	\N	\N
71efc073-4d4d-4afc-9e5b-ebd9136c44db	77ea57f4-fff2-48f0-af28-1c143b47a587	3	8-12	\N	\N	\N	\N
a98ec333-cdf3-4020-92ed-e472cfc23dc8	7841cbb4-f1e4-49e9-915f-aa3c198261bd	3	8-12	\N	\N	\N	\N
bac38d63-61d0-4424-ae9d-4bc1086e2cd6	fc6e6359-0ac1-433f-be19-b34012ec4be5	2	12-15	\N	\N	\N	\N
9dd30c9d-938b-4e84-a71c-4f0d3b2c1a7c	3198b8df-5891-4092-b2ab-ebfbc718387a	3	12-15	\N	\N	\N	\N
fe3107d6-d5c7-491b-9a9f-30c7ee94cfb3	6ce54960-71e5-41a2-9de8-3f4efb54e9c9	3	8-12	\N	\N	\N	\N
01330383-55f6-40aa-b27f-9104cf9328b8	14ea4ce6-cd86-40ae-871b-a45757ff6499	3	12-15	\N	\N	\N	\N
47da450e-df79-4c31-b8ad-203cb464add2	c93b5ebf-d3cc-4e81-ba0f-8066f42e3ee2	2	15-20	\N	\N	\N	\N
7500c6e0-61ec-4c63-8af3-59e01adbabb2	99251838-4573-445a-813c-e2a81d38c39a	3	12-15	\N	\N	\N	\N
ca94ab19-f404-4cce-a1ee-410972f4c8db	aa835542-9453-471b-af1b-806bb182f60d	3	12-15	\N	\N	\N	\N
2c98436f-e0c3-4c24-b951-6aeb9ea4ba08	ba0753f7-f6ea-4378-a76a-d79bef4a15c0	3	8-12	\N	\N	\N	\N
93dbf4a4-0949-4455-bdeb-40abd5ef5de9	8bb54e71-4756-460b-861d-22ac7afe952a	3	8-12	\N	\N	\N	\N
96c4d973-2590-4fa2-a54e-620bbd04a2a7	7ff82f9b-0724-44fa-af5d-6ff05e684fd0	3	12-15	\N	\N	\N	\N
7acdfa3b-70cc-4ba1-a1d8-e0710895c8d3	129d2198-d64f-405f-9d5e-36fccc162d3d	3	12-15	\N	\N	\N	\N
2bd14062-2472-4a99-b792-1698befe5383	3fdead37-d254-403e-8791-a1da5a4ca6d9	3	8-12	\N	\N	\N	\N
bfe74e01-bcaa-4d53-92fb-e8a3cae41ea1	da04ebc1-94ef-41d5-a829-43e940ce9d89	3	8-12	\N	\N	\N	\N
90f4742c-b716-4222-81bc-3acadf6c210e	b2fc5bfc-c24f-473a-8015-6c3a0bee728f	3	8-12	\N	\N	\N	\N
dd152d62-7fdc-469e-b4c9-35b5b9211e2e	32d12d19-cdb1-4097-b998-dce48841dfc6	3	8-12	\N	\N	\N	\N
01360dc1-ec37-4d00-a76b-963aad027a0e	b804b560-a75f-4821-8452-2e3f3dceca23	3	8-12	\N	\N	\N	\N
15c7c04d-ed5c-489e-863f-0184a33fbfbe	a53719b2-8780-4291-b2e9-4a8ac181aae7	3	12-15	\N	\N	\N	\N
268feb6a-cd19-4561-8b91-6c4d78e80f0a	536dcfb8-a539-4ced-91dc-00cf1e57a83d	3	8-12	\N	\N	\N	\N
57f51554-9364-4ba7-8f98-6564260644b3	47c24bca-0976-4550-a335-9d15d712208e	3	8-12	\N	\N	\N	\N
b665666d-16a4-40e1-b564-99b608bb256e	280ee4e1-0e79-42b4-982d-74bcc1766778	3	8-12	\N	\N	\N	\N
15b010a7-51eb-42c6-8647-2292855b3040	20336867-fcfd-4dc5-9cfe-12bcec0a9535	3	8-12	\N	\N	\N	\N
f06fccf5-ca27-4b39-a058-de2fdc12fb83	bcc549aa-44d3-450c-b9b1-6b3cceb5f3cf	3	12-15	\N	\N	\N	\N
e80f9bb2-c6f0-4365-b753-176eb96727eb	3c941aee-b01c-47e4-842c-b7f639a91293	3	15(each side)	\N	\N	\N	\N
1a66fe48-a210-4ac3-8334-3c577279988d	75591ddb-bdde-4d13-8e77-70626c5a5fd2	3	8-12	\N	\N	\N	\N
8da83bdf-944d-4ece-a7b8-5d46f2b02792	3d887b5a-eb45-4d49-bc61-f870862a21b7	3	8-12	\N	\N	\N	\N
13cbad6d-8344-4a8f-95e5-6cfd6aafed51	aa8f5919-7a76-4d80-b961-5f842ffcfbf3	3	12-15	\N	\N	\N	\N
9d68caf9-3d86-4aac-9483-3544fe54df68	d63d4f35-3140-4d83-a053-61a245144dc5	3	8-12	\N	\N	\N	\N
c2830b00-a33d-4e12-9d65-bcbf92cd06fa	6150f8f7-a4c2-4881-9a12-8ba1b4e45682	3	8-12	\N	\N	\N	\N
1497cb29-7927-40dc-adac-44a357364624	f6fa9e00-396b-4969-9470-588b1a3172eb	3	8-12	\N	\N	\N	\N
e0138067-5547-46a4-be2b-d1cfe90dd831	19fb71f4-1e37-461b-8bbc-4172b8fa82ee	3	8-12	\N	\N	\N	\N
cd6fb0d1-efcc-408a-82ec-78919f661044	8aa95d5e-defa-4ae3-b2bb-e3af05ec307d	3	10-15	\N	\N	\N	\N
4e644631-edb3-4edb-b671-66af2d2f68ef	d100c420-1846-434d-b680-c7028a507157	3	10-15	\N	\N	\N	\N
7af7a0ac-abbb-4d18-acd1-a5b406c60b8a	55f625dc-0d28-4c1c-b03e-3d7d89ab4305	3	12-15	\N	\N	\N	\N
9629e0d8-2fed-44b5-81b6-b052116c87f2	24ce2d3f-464f-425c-b53a-afc0413ae5d2	3	12-15	\N	\N	\N	\N
28f3c5b2-b576-4398-9282-2242a14d4210	ab0b49dc-18a4-4a3f-9060-84f14d7ea6cf	3	8-12	\N	\N	\N	\N
ca853234-c3b2-41ad-b3d4-909a06e6dabe	a186808f-6540-4362-b259-322e5c198e33	3	8-12	\N	\N	\N	\N
38d8cfd3-dedb-4d3d-b1b9-b13b74f8d574	0051de21-8faa-4ac5-9219-65b7e5c8341a	3	10-15	\N	\N	\N	\N
8273c716-2d3e-4eda-b3fc-4ff6ebcfc9d5	966f6942-efd6-4ff7-91eb-fd4c39b98cce	3	10-15	\N	\N	\N	\N
4ef03d2d-eced-4fcc-be57-8519992a746c	db2ac0f9-a479-4368-9cbe-8b0f60d7f3c6	3	10-15	\N	\N	\N	\N
e7e0783a-f34a-4111-86f2-56b27d2f3e4c	efe4f627-4da7-42a9-a6c8-6b8888dd7924	3	12-15	\N	\N	\N	\N
df12887b-8ef9-48a5-8fbe-6ae95c96c778	e3ca414c-84fe-458d-a6b0-22d3ebe582c9	3	8-12	\N	\N	\N	\N
0d3ad55f-1e5c-44fd-a978-c3bab84a6b89	af5e845c-147f-4fb8-a809-4285d5576323	3	8-12	\N	\N	\N	\N
a2ec2fd8-cfda-4b78-ba5b-d0bece3c458b	55200e96-5d94-4475-b008-28e845edf3e4	3	12-15	\N	\N	\N	\N
10a5d53f-486d-4694-985b-2bb7112b460c	b365497c-a5d1-461d-9cce-23467f3a2885	3	10-15	\N	\N	\N	\N
3f585ad8-04ca-47d7-9a3c-c4b630f7a2e2	aca4cf81-21ae-4243-81c3-da2ef44cf4ef	3	10-15	\N	\N	\N	\N
1fb0eb99-a762-423d-932a-dd4622dc0bd5	f29a3095-d428-47d7-8bda-ead24ed8aa61	3	10-15	\N	\N	\N	\N
ac419a82-969c-4870-9606-d8f8779b5238	db130231-02e0-4072-9e2d-cff09bc3e08b	3	8-12	\N	\N	\N	\N
1d91ecf7-c4f5-4558-8b57-d84e5795f000	a6b9d38a-e9f3-445d-b96c-92dc407148d0	3	30-45 sec	\N	\N	\N	\N
60ce1099-f271-4c51-b9a0-f6ae923038e8	a88718c5-2831-4f86-8d6c-c90a382af67d	3	8-12	\N	\N	\N	\N
3fc72c20-21b7-4d08-a22c-1fdcd63dc364	2a996d27-c647-4cc8-ba77-072ebd781a5d	3	8-12	\N	\N	\N	\N
e59260ec-7c7f-455d-8691-ec2dd5b0bbe4	1509c862-49f2-40e2-ad83-1aafb5819851	3	8-12	\N	\N	\N	\N
d3d690e5-de8d-4c00-8f9f-5b8ef9871478	9bd480f8-7cd5-4ac6-b62e-663a8cee2d34	3	15-20	\N	\N	\N	\N
7bf0158a-5b83-4ecc-8dd0-e2a4188749c0	b7a0ad93-1833-408e-b7f4-4ea39f05ab59	3	15 Reps(Each Side)	\N	\N	\N	\N
1daaffc6-9270-4d18-896a-4e90c4455e8b	6329d816-e611-4bef-823d-ea0a844e7aea	3	8-12	\N	\N	\N	\N
077a29f0-6b0f-49e4-bd49-4685fe36066e	96959760-c59d-4dbb-abae-7a67de03d655	3	8-12	\N	\N	\N	\N
8e6f8dc2-6c96-4604-b637-087809b842a8	2993faf4-4f1e-4c00-a014-b0abeeee6283	3	8-12	\N	\N	\N	\N
46504bd2-984c-4716-be0d-68b029a198e1	cfc7c44e-d49c-47e0-a085-c937ee232ac6	3	8-12	\N	\N	\N	\N
8685a9de-7e8a-4771-8156-baa3ed62e3f2	5de4c1ea-8148-4e0c-822b-3ed2a0586bcb	3	8-12	\N	\N	\N	\N
ade6581b-2067-4d43-8909-566de1b4265b	9243fa06-2ce9-404c-bf3a-301b9f157e63	3	8-12	\N	\N	\N	\N
f2ec9b3b-165d-43ae-b0a8-9bdfdf4bbf37	bac53175-7198-4b02-98dc-46367b25ce27	3	8-12	\N	\N	\N	\N
b4c713a1-19a3-4893-bdbc-4e28ebbc21d5	eceeffad-1e49-46b2-963d-00e1a7b50556	3	8-12	\N	\N	\N	\N
55bf20cf-1d9b-46f1-9303-f481fd53886d	e5e16770-43c8-4077-b653-f5d5e569580d	3	8-12	\N	\N	\N	\N
95f8487e-8b7d-415b-9a10-0f1f36599263	b9c4ba24-a063-4164-95a2-3e7dd109b032	3	8-12	\N	\N	\N	\N
09906105-4555-4a9a-ae31-7dab7cca6e10	3069ac39-d57c-4e67-8ee9-fc6bcf84c3c9	3	8-12	\N	\N	\N	\N
a848eaa2-2dcf-4c18-95e0-3c15e5f36ea1	b5e06a2e-df01-487a-acf8-f499abe8e4d4	3	8-12	\N	\N	\N	\N
911bc9cb-4f2b-4578-a78d-77af9a29486b	5a81a06f-42ad-4522-b32d-170e38efded6	3	10-15	\N	\N	\N	\N
e5784e1c-e947-48a7-9c2e-10b554c13432	c224a86b-5806-45c6-a474-769eca910d2f	3	10-15	\N	\N	\N	\N
02de2c9c-23c6-4f25-a54c-589ba8373263	107653ab-a872-4a1b-9e76-27088407673a	3	10-15	\N	\N	\N	\N
a19d035f-b03c-4ae7-a31c-c21f2edd9dd9	449e4016-931d-40d0-9a94-7cc02d828238	3	12-15	\N	\N	\N	\N
ae08b88f-031c-455b-9a00-59e097d79b6b	89e40157-b9e4-4fb8-b7f2-410dd5cfee9f	3	12-15	\N	\N	\N	\N
513e237f-9911-4882-9451-fac77cecae16	3461b3c5-cd80-4264-957b-ae2bb5471a5f	3	8-12	\N	\N	\N	\N
3a67cca0-5f33-4fd6-9873-2cf5a761b7aa	8d8b675b-3693-41da-bbcb-6d208373c34d	3	8-12	\N	\N	\N	\N
090d312a-1390-4f37-86a7-8bead28ab864	0484f885-e2a8-41c6-b8c5-d7ae17af03b6	3	8-12	\N	\N	\N	\N
686dec9f-d171-4dd3-b525-4c45cc73f1c3	efc8ba58-d958-4ce9-a405-3e18ecc842bd	3	8-12	\N	\N	\N	\N
00dff94c-7c56-4d15-92aa-c48570f9d3d4	e9b6b839-4e27-415c-8cbe-44040a7511c0	3	8-12	\N	\N	\N	\N
87d50c62-7eb5-48ff-92bc-9db7674ea89e	09e531ba-1c45-45fe-8555-66d445467bf5	3	8-12	\N	\N	\N	\N
fb51171f-9a2d-47ec-8e8d-49d2b75a9fc9	83a70b26-546d-4024-9b07-5ca907d3137e	3	8-12	\N	\N	\N	\N
08b5a070-d912-4d36-bf6d-ff2a4a097fd5	5bceb85e-5ae9-43bc-8cc9-11c2e036b204	3	12-15	\N	\N	\N	\N
6491e298-c5eb-418f-adc6-e090256a10cf	87b1cf49-6e60-4388-ab1c-5380d71b84ca	3	8-12	\N	\N	\N	\N
e7d6bc10-c1a3-4723-a644-fa1bfceaa607	88dff587-4bff-4d39-8644-f3a270c976fe	3	8-12	\N	\N	\N	\N
f1a899a1-2a75-4d3d-b7a1-27216437f636	a3e86c1d-5614-4dd8-946a-218f9d64a851	3	8-12	\N	\N	\N	\N
3ffe78fb-6995-49be-b5ae-8ee798976fc1	ae72b5e5-b0d5-4a95-ac92-582f4d197ec5	3	8-12	\N	\N	\N	\N
dcba5ef6-2818-4374-8560-00c80b76d4f1	799c38b8-2312-402e-be46-9e2da1862c37	3	8-12	\N	\N	\N	\N
6a439ab9-3562-418b-8473-e26694bc838f	6fb71e44-e509-4f5d-8a7a-95b81a6cf6c0	3	8-12	\N	\N	\N	\N
bbc18a5b-b47e-40ab-beee-96410a37d9a2	6b66a055-0b77-49f3-890d-918ade3e9a47	3	8-12	\N	\N	\N	\N
5c1193f8-a0d4-4a65-8d0f-3d91e2961c28	7a87c4f9-ca33-40e9-b67e-a415e0ac333f	3	8-12	\N	\N	\N	\N
60eec518-032c-4a47-a42a-e91ce34728b8	8fe43d39-2934-444c-baa8-0b48e5036040	3	8-12	\N	\N	\N	\N
83dd6f7f-19fb-4a29-828d-011fe1ff57ab	4ec0b141-7b55-46bf-8222-b4de1b1b62b6	3	8-12	\N	\N	\N	\N
d2c7bbee-336d-4031-bd1c-22bc2054b581	66a92f36-11e2-4789-b15f-79f2c78730f0	3	8-12	\N	\N	\N	\N
7cd38bd3-0112-4be4-88d2-4a66f52be4bf	70ef20ae-6053-42d5-9975-a55c559a88b1	3	8-12	\N	\N	\N	\N
cff004ae-2f5f-4113-b505-d10890ec7320	096db8bf-d6a8-42fe-8e4e-b47bd91a31bb	3	8-12	\N	\N	\N	\N
e7220559-3f30-481d-a9f5-aa6fe055d17f	20e7626c-973f-4c54-87fd-9f4c62b0bab5	3	8-12	\N	\N	\N	\N
29a8e1c4-140e-4506-b490-c64048126fe2	fdaa2bfc-937b-4ff6-8864-7982e788f4a7	3	12-15	\N	\N	\N	\N
9dec9d06-2de3-4bc9-9d85-1e883ec98874	6bcae7eb-9cb2-4487-86ae-28933ce8701e	3	8-12	\N	\N	\N	\N
30bf6adf-d55a-4b7e-9146-10b255a678d1	941725cc-7d38-4e5b-ab99-9736db95abf0	3	8-12	\N	\N	\N	\N
ae047063-579f-48a6-8e00-1606ccfe97d6	f1370706-3edf-4c9b-86ea-886610a54e31	3	8-12	\N	\N	\N	\N
e8e8bcce-0ab6-4703-843c-7943554dd393	6d995edc-24e8-4154-bf52-b0a3e1cafefb	3	8-12	\N	\N	\N	\N
b03f7698-86f4-48ba-9ffd-cf96cca9ff5a	419669d2-35e8-482c-a6ef-7757edb3676e	3	8-12	\N	\N	\N	\N
78203c35-6544-4e1b-a30a-fd51f1b93e74	e5b08604-f8c0-4891-8924-446e57430a2e	3	8-12	\N	\N	\N	\N
eb549bde-a426-445f-bbbd-db05b14ca442	95157627-6fdc-46c3-adbf-8558f563b944	3	8-12	\N	\N	\N	\N
9c312552-23bf-438f-a512-58f5fd97b6d5	8ded575e-8a79-408f-b6ea-6ebb8b94d36b	3	8-12	\N	\N	\N	\N
fc797ce0-b9f5-4099-b18b-39ea4c6d8ba4	de4a05ce-90e8-46d1-b561-bf74f6c508aa	3	8-12	\N	\N	\N	\N
ce2936a6-aaea-48f6-9995-800dd897b196	def59453-890f-441c-880a-f94debcf2382	3	12-15	\N	\N	\N	\N
b0da7c3e-bae8-4b60-8191-1e4042e7b7ae	e7ad2051-18db-474d-b82b-56259ef51cae	3	12-15	\N	\N	\N	\N
9f952f12-d0f8-4cd9-a982-54b69bc7505b	c4a9215b-9ca3-4a36-b358-776a716a6980	3	8-12	\N	\N	\N	\N
4c98eef5-8cd9-41ca-89a3-b61a03122e97	d5e5bdd3-2ab2-4fb4-a565-5d659237ddef	3	8-12	\N	\N	\N	\N
f006106e-1c89-4543-847c-6c4970fe4297	f400a792-d4f3-4e79-b836-267522a0d405	3	8-12	\N	\N	\N	\N
a3243272-829e-4a29-92a6-6045eb99a1fa	a909ff73-d608-419c-8c5f-8e84609f7d17	3	8-12	\N	\N	\N	\N
c04dab5b-8a7b-4f02-b418-7b0d567ddf82	9ed4d296-667e-4be4-b866-4420dafbdf43	3	8-12	\N	\N	\N	\N
3a6bdbe6-0814-4b2d-ad6f-7c7f6cd1242f	0a2ee5e7-0cdf-40c2-b635-cab9674030cc	3	8-12	\N	\N	\N	\N
f4d26b1a-fce8-4867-b9a4-0a03f0a74fcd	41324ffa-a55e-43bb-9d5e-be5227a87873	3	8-12	\N	\N	\N	\N
75ded406-3aa2-4e70-873c-c35870ddb848	ebf58554-c9c4-49c4-b6ac-6f2f7a81c65a	3	8-12	\N	\N	\N	\N
2997463e-587d-4bf5-8225-408e30230621	2bc21e86-1a76-4d21-bd61-7874602f2acc	3	8-12	\N	\N	\N	\N
ab67ee33-29a1-4318-aea3-259c784155c5	972cb919-cc91-4199-a01d-17fb4f1e0b06	3	8-12	\N	\N	\N	\N
50b4e625-0f9d-4f49-8982-e8d770a9a502	940d4d5d-933d-4581-a7e2-582729069354	3	8-12	\N	\N	\N	\N
28fe3214-d6c8-407b-8adf-43ea9bac109a	6b9a426f-8f01-4627-8808-7f23950a66f5	3	8-12	\N	\N	\N	\N
1dbf7c43-6c29-46e0-83d3-08f29331d1a3	2effe1fc-4886-480b-a62c-3a58eb58ad02	3	8-12	\N	\N	\N	\N
715824ed-8966-4155-8e43-a80884b40baf	4d74cfd9-0521-4485-9cb3-6f794049b51c	3	8-12	\N	\N	\N	\N
d19bad02-d629-4d54-9aee-2c78501404a9	7b2e6b0a-817c-45b0-803a-dd69f7f12e38	3	8-12	\N	\N	\N	\N
\.


--
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercises (id, day_id, name, notes, video_url, muscles_trained, muscle_group) FROM stdin;
cb46b512-ecff-457d-b3b5-75eab62c55f4	e4332898-fef2-47d5-9fdc-e92674501b79	Incline Barbell Chest Press	\N	https://www.youtube.com/watch?v=6YaZyZyeito	Pecs(Upper, Middle - Lengthened), Anterior Delt	CHEST
be42f11b-4613-4542-a517-ae494a1ac0f9	e4332898-fef2-47d5-9fdc-e92674501b79	Seated Cable Chest Press	\N	https://www.youtube.com/watch?v=aQ5VspphLjE	Pecs(Upper, middle - shortened), Anterior Delts	CHEST
7430f4f4-bdb0-4d58-95cd-c4b44a9c753d	e4332898-fef2-47d5-9fdc-e92674501b79	Dumbbell Chest Fly	\N	https://www.youtube.com/watch?v=Nhvz9EzdJ4U	Pecs(Upper, middle - Lengthened),\nAnterior Delts	CHEST
a278119d-7d73-456d-ae07-e3935c4239b0	e4332898-fef2-47d5-9fdc-e92674501b79	Chest Supported Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=pDzjKXU3Lto	Lateral Delt	SHOULDER
01a9d35e-b551-43d1-98df-548b8b098de3	e4332898-fef2-47d5-9fdc-e92674501b79	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U	Triceps(Long head - Lengthened)	TRICEPS
d235e5b8-524e-437b-8553-1a2f380236e1	e4332898-fef2-47d5-9fdc-e92674501b79	Single Arm Triceps Crossover	\N	https://www.youtube.com/watch?v=lC9NRhFN7X4	Tricpes(Shortened - Long Head)	TRICEPS
618a4fb9-c673-43e7-a7d1-6c1a6c29fe8f	6172e9bd-e906-4862-a750-4b212b7c7cb0	Single Arm Lat Pulldown	\N	https://www.youtube.com/shorts/paOm0L4zrCE	Lats(Vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
137d191b-d85e-4b9a-8574-901113530da6	6172e9bd-e906-4862-a750-4b212b7c7cb0	Seated Cable Row	\N	https://www.youtube.com/watch?v=mnUUQWcqHPQ	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
9e95f8b4-6553-4e3d-9fa9-bcf4da72b2fe	6172e9bd-e906-4862-a750-4b212b7c7cb0	Incline Dumbell Curl	\N	https://www.youtube.com/watch?v=EiPYwFGeMwc	Biceps(Lengthened)	BICEPS
03e5738f-e9fb-44fa-b25d-1a6d7b50fce5	6172e9bd-e906-4862-a750-4b212b7c7cb0	Preacher Curl Machine	\N	https://www.youtube.com/watch?v=e1Lh7RVV2NQ	Biceps(Shortened)	BICEPS
311748b4-4167-4945-a93a-0fbf4f976050	6172e9bd-e906-4862-a750-4b212b7c7cb0	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM	Upper Traps	BACK
0ab27474-84c2-41b5-8d03-5d8516e102e4	6172e9bd-e906-4862-a750-4b212b7c7cb0	Rear Delt Cable Pull	\N	https://www.youtube.com/watch?v=JUKuGImz51U	Rear Delts,\nRhomboids	SHOULDER
f6e044c5-60c1-4b26-801c-6c6f6b325bca	31314383-c5ec-46b5-98cf-5e375a786e40	Barbell Squats	\N	https://www.youtube.com/watch?v=EBItm_AOzK8	Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
6dd1a2b2-93ef-49bf-9a24-9b5a497f2d1b	31314383-c5ec-46b5-98cf-5e375a786e40	Seated Leg Extension	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
da16d4e9-3b24-4f24-a6e0-aa110dccfd3d	31314383-c5ec-46b5-98cf-5e375a786e40	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
31aaf5a7-1fd9-48f5-903e-d9a522ddf011	31314383-c5ec-46b5-98cf-5e375a786e40	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
4645f03c-5d12-4b1f-854d-7eb352366cdc	31314383-c5ec-46b5-98cf-5e375a786e40	Reverse Crunches	\N	https://www.youtube.com/watch?v=U-eR6Pt1gZA&pp=0gcJCcUKAYcqIYzv	Rectus Abdominis, Transverse Abdominis	ABS
d832c372-33af-4a31-86eb-8794f3af5638	31314383-c5ec-46b5-98cf-5e375a786e40	Side Bending with cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
e48c4503-6f11-4d0f-b10a-d6673858a762	dca5b842-4fc4-4192-a7fc-07feea7857c9	Incline Barbell Chest Press	\N	https://www.youtube.com/watch?v=6YaZyZyeito	Pecs(Upper, Middle - Lengthened), Anterior Delt	CHEST
2ae42b5e-1404-4bd8-8ebf-373fe9a7fff6	dca5b842-4fc4-4192-a7fc-07feea7857c9	Seated Cable Chest Press	\N	https://www.youtube.com/watch?v=aQ5VspphLjE	Pecs(Upper, middle - shortened), Anterior Delts	CHEST
4cf7f116-da64-447b-8b9e-c6f492a9893b	dca5b842-4fc4-4192-a7fc-07feea7857c9	Dumbbell Chest Fly	\N	https://www.youtube.com/watch?v=Nhvz9EzdJ4U	Pecs(Upper, middle - Lengthened),\nAnterior Delts	CHEST
3a27c0a2-2214-4072-ba11-2ae085fdf073	dca5b842-4fc4-4192-a7fc-07feea7857c9	Chest Supported Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=pDzjKXU3Lto	Lateral Delt	SHOULDER
aa35b7fb-7882-45a7-b012-8f88b32c19c4	dca5b842-4fc4-4192-a7fc-07feea7857c9	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U	Triceps(Long head - Lengthened)	TRICEPS
8e654417-e68d-45f2-97aa-3abb2359322e	dca5b842-4fc4-4192-a7fc-07feea7857c9	Single Arm Triceps Crossover	\N	https://www.youtube.com/watch?v=lC9NRhFN7X4	Tricpes(Shortened - Long Head)	TRICEPS
d189681b-dbde-4783-a09f-04113ef0a18d	ef202a35-e917-4c9b-8521-0c80bc762343	Single Arm Lat Pulldown	\N	https://www.youtube.com/shorts/paOm0L4zrCE	Lats(Vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
2a5a939e-9a5f-48c9-8ec8-76383f71ac8b	ef202a35-e917-4c9b-8521-0c80bc762343	Seated Cable Row	\N	https://www.youtube.com/watch?v=mnUUQWcqHPQ	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
d69e9a71-a6f1-4ccc-b746-86660f0f9cf8	ef202a35-e917-4c9b-8521-0c80bc762343	Incline Dumbell Curl	\N	https://www.youtube.com/watch?v=EiPYwFGeMwc	Biceps(Lengthened)	BICEPS
8000f016-af23-47f1-a9f5-929b1f3fa7eb	ef202a35-e917-4c9b-8521-0c80bc762343	Preacher Curl Machine	\N	https://www.youtube.com/watch?v=e1Lh7RVV2NQ	Biceps(Shortened)	BICEPS
34291a16-4266-4ba3-a74b-daf951995c67	ef202a35-e917-4c9b-8521-0c80bc762343	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM	Upper Traps	BACK
c0ff2a07-b24e-4be6-aa51-3d831e5c0d58	ef202a35-e917-4c9b-8521-0c80bc762343	Rear Delt Cable Pull	\N	https://www.youtube.com/watch?v=JUKuGImz51U	Rear Delts,\nRhomboids	SHOULDER
16473a4b-c8cb-4f92-a93f-4dcaa87e864d	ce79beea-5299-4b91-9491-fb2717c2708f	Barbell Squats	\N	https://www.youtube.com/watch?v=EBItm_AOzK8	Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
30dad80c-e3d9-4a44-afcd-da47ca9dd76c	ce79beea-5299-4b91-9491-fb2717c2708f	Seated Leg Extension	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
75d6f39b-7b22-4236-8e7f-de560eb8975b	ce79beea-5299-4b91-9491-fb2717c2708f	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
9ea3b2eb-2af5-469c-bf64-68948a929b8c	ce79beea-5299-4b91-9491-fb2717c2708f	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
e4d23fe3-8ccb-4227-a1d0-0c902f4edb32	ce79beea-5299-4b91-9491-fb2717c2708f	Reverse Crunches	\N	https://www.youtube.com/watch?v=U-eR6Pt1gZA&pp=0gcJCcUKAYcqIYzv	Rectus Abdominis, Transverse Abdominis	ABS
f3b2701a-7ee8-4776-9333-f2cdcb0d2dcd	ce79beea-5299-4b91-9491-fb2717c2708f	Side Bending with cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
3fe194d6-9afb-4328-b9bb-62db66c1d704	76217a8e-59a8-48d5-9e19-034717cf96bd	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
6ef48986-4bb2-4b34-bd40-7b461e6b8de1	76217a8e-59a8-48d5-9e19-034717cf96bd	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
c95f8b3a-5925-490f-86b6-1ba0c4d4b009	76217a8e-59a8-48d5-9e19-034717cf96bd	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
e16a4c6c-3855-4be5-8384-69ac62130955	76217a8e-59a8-48d5-9e19-034717cf96bd	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
7e91bc52-2c4e-4032-8640-f8994c2ed393	76217a8e-59a8-48d5-9e19-034717cf96bd	Resverse Pec Deck Fly	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
1101c52e-42da-4582-84d7-fbefea89011e	01da0d04-6311-4870-8b84-57ac7f40b782	Wall Sit	\N	https://www.youtube.com/watch?v=c38NDc644rs	Quads	LEGS
1ed34dc2-7fb1-45bb-9192-1ffd3a21f3c2	01da0d04-6311-4870-8b84-57ac7f40b782	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
b8179696-06c6-4c5d-8479-59ce6618f066	01da0d04-6311-4870-8b84-57ac7f40b782	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
090aa915-2a77-4415-8a51-8ef86ae30db2	01da0d04-6311-4870-8b84-57ac7f40b782	Hip Abduction	\N	https://www.youtube.com/watch?v=H98IP8rARy4	Hip Abductors	LEGS
8b0329fa-61dc-4acf-bf8b-f1123bb0ef07	01da0d04-6311-4870-8b84-57ac7f40b782	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
b820928a-c623-4a1d-9721-0f5cf8d7342d	01da0d04-6311-4870-8b84-57ac7f40b782	Dead Bugs	\N	https://www.youtube.com/watch?v=mUMVASv0x7U	Rectus Abdominis	ABS
3179a2f6-5e6f-48ca-bc6e-6ea5833da79c	230ec348-0915-4078-80f2-0c5097d02241	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
b97cc8ec-594d-465f-bdf0-662da3ac3cdb	0b391810-638e-4b5c-b24c-fa4d4b6aff6d	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
60c0a900-1909-4689-8443-23ba0318b033	0b391810-638e-4b5c-b24c-fa4d4b6aff6d	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
38c8d3f5-a12b-4663-9db5-02a697b53191	0b391810-638e-4b5c-b24c-fa4d4b6aff6d	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Delt	SHOULDER
8555cfb0-1d75-4587-914e-516651d5fa51	0b391810-638e-4b5c-b24c-fa4d4b6aff6d	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Tricpes(Long Head - Shortened)	TRICEPS
75591ddb-bdde-4d13-8e77-70626c5a5fd2	0b391810-638e-4b5c-b24c-fa4d4b6aff6d	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U	Triceps(Long head - Lengthened)	TRICEPS
b3b0665e-6a57-411b-9bc2-96ceb142d551	0b391810-638e-4b5c-b24c-fa4d4b6aff6d	Reverse Pec Deck	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delt	SHOULDER
edbc06d5-2c00-4d42-a867-ea2fea818dbc	251bb4a7-4a91-44d0-ae1b-1e24410e7a54	Wall Sits	\N	https://www.youtube.com/watch?v=c38NDc644rs	Quads ΓÇô Isometric (Mid)\nGlutes ΓÇô Isometric (Mid)\nErector Spinae	LEGS
01a96348-56e6-4471-86f9-89d1b83c046d	251bb4a7-4a91-44d0-ae1b-1e24410e7a54	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
87ddebd6-043b-4e68-87e4-96aa68c4c34f	251bb4a7-4a91-44d0-ae1b-1e24410e7a54	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
5476af43-0de2-4a7f-a455-0cfe4bff4277	251bb4a7-4a91-44d0-ae1b-1e24410e7a54	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
68f0ef5b-a02a-4c09-a459-a50a6230c7e3	251bb4a7-4a91-44d0-ae1b-1e24410e7a54	Planks	\N	https://www.youtube.com/watch?v=Qv00BKMQf6M	Rectus Abdominis, \nTransverse Abdominis	ABS
230434f2-bdff-43d8-a696-b7965e95a3d3	fcc301ce-dbb3-4f77-a6d1-583bbe4b7556	Machine Lat Pull Down	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical), Teres Major, Rear Delt, Lower Traps	BACK
3d887b5a-eb45-4d49-bc61-f870862a21b7	fcc301ce-dbb3-4f77-a6d1-583bbe4b7556	Single Arm Dumbbell Row	\N	https://www.youtube.com/shorts/rO4Q7nW0ygo	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
9678ba63-b524-4531-a1b7-a89671f4d902	fcc301ce-dbb3-4f77-a6d1-583bbe4b7556	Dumbbell Pullover	\N	https://www.youtube.com/shorts/pRLIZFFoQ-M	Lats (lower) ΓÇô Lengthened\nChest (pectoralis major)\nTriceps (long head)\nSerratus Anterior	BACK
9418ee45-0216-4013-bc4a-53656d0a0a7c	fcc301ce-dbb3-4f77-a6d1-583bbe4b7556	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
916300f2-486e-4e6e-b694-e9efff569c86	929cebe1-2821-414b-825a-7a2b885d9fb1	Incline Bench Press	\N	https://www.youtube.com/shorts/L9UKMQw1Nss	Pecs(Upper, Middle - Lengthened), Anterior Delt	CHEST
59568adc-2355-49a4-8ba7-8f29cd4cc983	929cebe1-2821-414b-825a-7a2b885d9fb1	Seated Cable Chest Press	\N	https://www.youtube.com/shorts/sNFUt4vjN20	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
1724f5ad-d5d1-47be-9194-8c8bb4587d81	929cebe1-2821-414b-825a-7a2b885d9fb1	Cable Lateral Raises	\N	https://www.youtube.com/shorts/lK-Jupl2ciQ	Lateral Delt	SHOULDER
39241834-2ea3-4c32-8399-8c7e6a457a3d	929cebe1-2821-414b-825a-7a2b885d9fb1	Single Arm Overhead Cable Triceps Extension	\N		Triceps(Lengthened - Long head)	TRICEPS
476c3c12-ba10-4005-a4fc-bb3455f628e8	929cebe1-2821-414b-825a-7a2b885d9fb1	Cable Triceps Extension	\N		Triceps(Shortened - Long Head)	TRICEPS
6bab4d37-aba3-4676-b4af-7cf0baef9117	929cebe1-2821-414b-825a-7a2b885d9fb1	Cable Fly	\N	https://www.youtube.com/shorts/MD1IfN687a8	Pecs(Upper, middle - shortened, active throughout ROM ), Anterior Delts	CHEST
612bdecc-cc99-4575-8427-c4f69405aed1	242d4551-5fa3-4bb0-afe4-5876551f4975	Single Arm Lat Pulldown	\N	https://www.youtube.com/shorts/paOm0L4zrCE	Lats(Vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
29153ab1-5ac3-4726-8ace-6e5d448c22cf	242d4551-5fa3-4bb0-afe4-5876551f4975	Seated Cable Row	\N	https://www.youtube.com/shorts/3cR8rElT5sY	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
6d0a2fde-39d2-473d-bd33-f523466c8069	242d4551-5fa3-4bb0-afe4-5876551f4975	Barbell Shrugs	\N	https://www.youtube.com/watch?v=larn3Asl6oM	Upper Traps	BACK
3a34b030-b981-47f0-a083-708b2050eb16	242d4551-5fa3-4bb0-afe4-5876551f4975	Single Arm DB Preacher Curls	\N	https://www.youtube.com/shorts/Mg0NnlF5NZQ	Biceps(Shortened)	BICEPS
4cfaa592-98d1-4223-b131-dcdb0e8750f2	242d4551-5fa3-4bb0-afe4-5876551f4975	Incline Dumbell Curl	\N	https://www.youtube.com/shorts/Bi88U34pdE4	Biceps(Lengthened)	BICEPS
0ae0cd4f-25c4-4117-b30a-a8ce505baab8	242d4551-5fa3-4bb0-afe4-5876551f4975	Cable Rear Delt Fly	\N	https://www.youtube.com/shorts/iidcl0mf_4c	Rear Delts,\nRhomboids	BACK
eaf5ae5b-80e4-47cd-bf3d-6a6a23b9918a	15dc2363-58e5-4033-8a8d-a641320a89cb	Barbell Squats	\N		Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
24752967-92ee-46ea-92d1-081672d867d2	15dc2363-58e5-4033-8a8d-a641320a89cb	Stiff Leg Deadlift(Barbell)	\N		Hamstrings(Lengthened),\nGlutes(Lengthened)	LEGS
ef3e24db-3c89-436e-9f77-4aa4a056dae6	15dc2363-58e5-4033-8a8d-a641320a89cb	Leg Extensions	\N		Quads(Shortened)	LEGS
3e05930a-8c51-4a30-b5b9-8c713f31982a	15dc2363-58e5-4033-8a8d-a641320a89cb	Abdominal Crunch	\N		Rectus Abdominis,\nTransverse Abdominis	ABS
5b41aeb3-c7a3-4e3f-8c1d-54b40908eec5	15dc2363-58e5-4033-8a8d-a641320a89cb	Side Bending with Cable	\N	https://www.youtube.com/shorts/RvCR6YWkQiA	Obliques	ABS
6c7702ea-5fc5-4152-81c5-7761eb5dece3	15dc2363-58e5-4033-8a8d-a641320a89cb	Dumbbell Single Leg Standing Calf Raise	\N	https://www.youtube.com/watch?v=KcTEGifMTDY	Gastroc, Soleus	LEGS
d0554860-5cd6-42ff-8ef6-8fbf4634a39a	a54cd1e3-7853-4907-a6a7-78baffbc64b0	Incline Bench Press	\N	https://www.youtube.com/shorts/L9UKMQw1Nss	Pecs(Upper, Middle - Lengthened), Anterior Delt	CHEST
9243cdb8-6de1-4d64-869f-fdb8ec706af7	a54cd1e3-7853-4907-a6a7-78baffbc64b0	Seated Cable Chest Press	\N	https://www.youtube.com/shorts/sNFUt4vjN20	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
b0c71005-6a6c-4597-b4eb-12f805183460	a54cd1e3-7853-4907-a6a7-78baffbc64b0	Cable Lateral Raises	\N	https://www.youtube.com/shorts/lK-Jupl2ciQ	Lateral Delt	SHOULDER
f0ad6b34-5430-4f10-a64b-9e5479695b0d	a54cd1e3-7853-4907-a6a7-78baffbc64b0	Single Arm Overhead Cable Triceps Extension	\N		Triceps(Lengthened - Long head)	TRICEPS
4b661642-99c0-492e-9717-b89a85bb9e76	a54cd1e3-7853-4907-a6a7-78baffbc64b0	Cable Triceps Extension	\N		Triceps(Shortened - Long Head)	TRICEPS
171d4c8d-b77d-4617-b1c6-858b8a61b09f	a54cd1e3-7853-4907-a6a7-78baffbc64b0	Cable Fly	\N	https://www.youtube.com/shorts/MD1IfN687a8	Pecs(Upper, middle - shortened, active throughout ROM ), Anterior Delts	CHEST
1884e93c-bb9d-48e1-9db6-9324f639cdac	7cf1dcab-3f45-4a58-bc98-62bb960ec4dc	Single Arm Lat Pulldown	\N	https://www.youtube.com/shorts/paOm0L4zrCE	Lats(Vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
93f619a1-fbb8-4dca-a9a7-1d80bbae02fe	7cf1dcab-3f45-4a58-bc98-62bb960ec4dc	Seated Cable Row	\N	https://www.youtube.com/shorts/3cR8rElT5sY	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
8d0ecaee-3a22-487a-ba62-0533264b8a21	7cf1dcab-3f45-4a58-bc98-62bb960ec4dc	Barbell Shrugs	\N	https://www.youtube.com/watch?v=larn3Asl6oM	Upper Traps	BACK
726d5c24-82c5-405c-891e-713317e4a779	7cf1dcab-3f45-4a58-bc98-62bb960ec4dc	Single Arm DB Preacher Curls	\N	https://www.youtube.com/shorts/Mg0NnlF5NZQ	Biceps(Shortened)	BICEPS
a5944627-3829-4528-a31e-901c674ba330	7cf1dcab-3f45-4a58-bc98-62bb960ec4dc	Incline Dumbell Curl	\N	https://www.youtube.com/shorts/Bi88U34pdE4	Biceps(Lengthened)	BICEPS
074aa954-fc5e-4faa-94df-c8dccff161ca	7cf1dcab-3f45-4a58-bc98-62bb960ec4dc	Cable Rear Delt Fly	\N	https://www.youtube.com/shorts/iidcl0mf_4c	Rear Delts,\nRhomboids	BACK
8163e280-2945-49c1-bab9-4845dc613304	c6c626f0-9191-4790-a7a9-e936c515f14c	Barbell Squats	\N		Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
8bb4902d-c1c5-4030-8724-967790a27b36	c6c626f0-9191-4790-a7a9-e936c515f14c	Stiff Leg Deadlift(Barbell)	\N		Hamstrings(Lengthened),\nGlutes(Lengthened)	LEGS
e55e9afc-9dba-4ed5-9426-0ada894664c6	c6c626f0-9191-4790-a7a9-e936c515f14c	Leg Extensions	\N		Quads(Shortened)	LEGS
83aa4348-d3ba-45cb-abff-4324c9867d55	c6c626f0-9191-4790-a7a9-e936c515f14c	Abdominal Crunch	\N		Rectus Abdominis,\nTransverse Abdominis	ABS
a174e6ff-c5a9-4cd2-9464-d07317c59a95	c6c626f0-9191-4790-a7a9-e936c515f14c	Side Bending with Cable	\N	https://www.youtube.com/shorts/RvCR6YWkQiA	Obliques	ABS
fd9431fb-f070-4c89-9b92-aaf37b10f9a6	c6c626f0-9191-4790-a7a9-e936c515f14c	Dumbbell Single Leg Standing Calf Raise	\N	https://www.youtube.com/watch?v=KcTEGifMTDY	Gastroc, Soleus	LEGS
031b61f3-981c-46f1-a999-0bfaa105184e	251bb4a7-4a91-44d0-ae1b-1e24410e7a54	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
a49bf19b-25ef-4f3e-b017-9bdc95878473	6a96aaca-8e09-49dc-af05-43542d56963e	Overhead Dumbbell Press	\N	https://www.youtube.com/watch?v=Qscmgbf5AUI	Anterior Delts,\nUpper Pecs	SHOULDER
fbca66e3-f323-4fb2-88e7-1be3bfe9bc3a	6a96aaca-8e09-49dc-af05-43542d56963e	Machine Lat Pull Down	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical), Teres Major, Rear Delt, Lower Traps	BACK
95662f72-1496-4fb8-96d8-70852543a202	230ec348-0915-4078-80f2-0c5097d02241	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
05f230dd-ecab-4605-b5b0-efee7b12b61b	230ec348-0915-4078-80f2-0c5097d02241	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
e98b4d20-cb83-4030-b6de-2062319880c0	230ec348-0915-4078-80f2-0c5097d02241	Bench Supported Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
d6268629-84ac-4065-90b5-706b92ec962e	230ec348-0915-4078-80f2-0c5097d02241	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
d63d4f35-3140-4d83-a053-61a245144dc5	586d5670-ab85-45f6-8dab-e7195ebc09bf	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
6150f8f7-a4c2-4881-9a12-8ba1b4e45682	586d5670-ab85-45f6-8dab-e7195ebc09bf	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
cc4f1538-aaf1-4b61-ada9-9d6c202fef47	618c40a6-be57-4d79-a7da-73a09588d6db	Smith Machine Flat Chest Press	\N	https://www.youtube.com/shorts/8MULputkx4Q	Pecs(middle, lower - lengthened),\nAnterior Delts	CHEST
a3ad6192-97d1-4be7-95c6-0dfbce00f7b2	618c40a6-be57-4d79-a7da-73a09588d6db	Overhead Dumbbell Press	\N	https://www.youtube.com/watch?v=Qscmgbf5AUI	Anterior Delts,\nUpper Pecs	SHOULDER
dedfe8a2-4700-4848-a1e7-a9f4bd68897e	618c40a6-be57-4d79-a7da-73a09588d6db	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Delt	SHOULDER
cd526831-8194-492f-94b6-63b19ea9f858	618c40a6-be57-4d79-a7da-73a09588d6db	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps(Long Head - Shortened)	TRICEPS
420ffa5d-a9e6-42ac-8ad2-72f44ab5c548	618c40a6-be57-4d79-a7da-73a09588d6db	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U	Triceps(Long head - Shortened)	TRICPES
b4c144dd-178a-4596-9d71-f4c88ee88896	618c40a6-be57-4d79-a7da-73a09588d6db	Pec Deck Fly	\N	https://www.youtube.com/watch?v=Qplb3CTTawM	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts	CHEST
cd2dcf16-eb4d-4046-8c18-6074791d439c	873c3aa5-87c7-41be-bd3b-80a771762af2	Superman Back Extension	\N	https://www.youtube.com/shorts/qQ67h06Oct4	Erector Spinae	ERECTOR SPINAE
10594a1f-457d-46cd-bc93-2b64029e0ba0	873c3aa5-87c7-41be-bd3b-80a771762af2	Machine Lat Pull Down	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical), Teres Major, Rear Delt, Lower Traps	BACK
cc18f924-6286-4bbf-a2ec-d14c73208a39	873c3aa5-87c7-41be-bd3b-80a771762af2	Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
0d937ccc-adbc-4b36-8059-406e99a08793	873c3aa5-87c7-41be-bd3b-80a771762af2	Seated Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps(Normal Position)	BICEPS
411ad8e8-4099-4a11-8d08-da48331157df	873c3aa5-87c7-41be-bd3b-80a771762af2	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
54729b8e-267f-4673-9152-e87c5a0cead4	873c3aa5-87c7-41be-bd3b-80a771762af2	Seated Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
c93a09d1-2658-413b-9cd2-f091c8dd67a9	3e84e704-fd23-4895-b171-b75c8665b377	Body Weight Squats	\N		Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
76781196-d566-4bff-a3be-ea121b5701f2	3e84e704-fd23-4895-b171-b75c8665b377	Seated Leg Extension	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
ced8a8c4-8cc1-4cf0-902e-6e8875efccf3	3e84e704-fd23-4895-b171-b75c8665b377	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
01eeb95f-2954-4fc9-8991-40a09a44bf9c	3e84e704-fd23-4895-b171-b75c8665b377	Abdominal Crunch	\N	https://www.youtube.com/watch?v=ZPdx67dVJHg	Rectus Abdominis,\nTransverse Abdominis	ABS
88aed8b1-0820-475f-b0b0-6be251cd8fc3	3e84e704-fd23-4895-b171-b75c8665b377	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
03c22cc1-58ec-41ab-b963-e770ac0ffe30	3e84e704-fd23-4895-b171-b75c8665b377	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
96660ad6-22de-48be-a689-a13afce85e66	e7a690f4-892e-4f2d-85fb-b0425fb07084	Smith Machine Flat Chest Press	\N	https://www.youtube.com/shorts/8MULputkx4Q	Pecs(middle, lower - lengthened),\nAnterior Delts	CHEST
cb23250a-3ffe-4d2a-92e5-8f1808fd27e3	e7a690f4-892e-4f2d-85fb-b0425fb07084	Overhead Dumbbell Press	\N	https://www.youtube.com/watch?v=Qscmgbf5AUI	Anterior Delts,\nUpper Pecs	SHOULDER
b4db037e-05fe-4f0e-83f8-0cdf0975762c	e7a690f4-892e-4f2d-85fb-b0425fb07084	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Delt	SHOULDER
f6d45537-9f42-4f58-9cd6-71864396e144	e7a690f4-892e-4f2d-85fb-b0425fb07084	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps(Long Head - Shortened)	TRICEPS
1a738284-1c16-4d35-b498-d9b6a66e3050	e7a690f4-892e-4f2d-85fb-b0425fb07084	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U	Triceps(Long head - Shortened)	TRICEPS
035d0cf2-3e56-4ae2-a3ca-7cfbc12c625b	e7a690f4-892e-4f2d-85fb-b0425fb07084	Pec Deck Fly	\N	https://www.youtube.com/watch?v=Qplb3CTTawM	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts	CHEST
dfb46451-d6c4-4201-b851-e12722c1c02f	e6616aca-8b74-4f41-91d7-d5c08593578e	Superman Back Extension	\N	https://www.youtube.com/shorts/qQ67h06Oct4	Erector Spinae	ERECTOR SPINAE
ac99d8f4-2867-4e00-9d65-8d162f2c2c6f	e6616aca-8b74-4f41-91d7-d5c08593578e	Machine Lat Pull Down	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical), Teres Major, Rear Delt, Lower Traps	BACK
5bb1a87c-990a-41ad-8ba8-913077c71d31	e6616aca-8b74-4f41-91d7-d5c08593578e	Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
d9bec449-ee89-4f66-99d7-50c9668f92c5	e6616aca-8b74-4f41-91d7-d5c08593578e	Seated Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps(Normal Position)	BICEPS
84a97e4a-4b8b-4ac9-9c74-a5c48a04e02a	e6616aca-8b74-4f41-91d7-d5c08593578e	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
d371a2ee-c064-4c8b-89e5-7936f8a8d6df	e6616aca-8b74-4f41-91d7-d5c08593578e	Seated Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
4a475f00-e7d4-4b98-9896-91e1dcbee246	99744c9a-0ede-4480-ba98-fa22cb1f47eb	Body Weight Squats	\N		Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
0c772017-0415-4355-8e59-5b52102741d2	99744c9a-0ede-4480-ba98-fa22cb1f47eb	Seated Leg Extension	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
fae9df54-5974-4e15-8937-f431f6d613fb	99744c9a-0ede-4480-ba98-fa22cb1f47eb	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
278b28bb-d748-43d6-a49f-b85a87f1518d	99744c9a-0ede-4480-ba98-fa22cb1f47eb	Abdominal Crunch	\N	https://www.youtube.com/watch?v=ZPdx67dVJHg	Rectus Abdominis,\nTransverse Abdominis	ABS
0c0f72bd-9cfc-417c-8d18-0d51c17a74fd	99744c9a-0ede-4480-ba98-fa22cb1f47eb	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
b78b8f96-5a4a-4367-aeb5-f640e7339b8c	99744c9a-0ede-4480-ba98-fa22cb1f47eb	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
339b4372-d9cf-4c8f-8a19-1b0b354370f0	8c8058c2-e950-44d6-8669-418e7ae7c349	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
78f78f68-a270-4604-8edc-79de070cee7f	8c8058c2-e950-44d6-8669-418e7ae7c349	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
68795a52-7c4b-4ff0-9f7f-b7645c175a0b	8c8058c2-e950-44d6-8669-418e7ae7c349	Cable Lateral Raises	\N	https://www.youtube.com/watch?v=JFzKbUggz7E	Lateral Delt	SHOULDER
8628ac2b-5209-40a2-9e25-79eebce9a7e6	8c8058c2-e950-44d6-8669-418e7ae7c349	Ez Bar Lying Triceps Extension	\N	https://www.youtube.com/watch?v=iyIe7qdGtdE	Triceps(Long head - Lengthened)	TRICEPS
3ba428c7-88b5-42ea-a816-1d0be39503c6	8c8058c2-e950-44d6-8669-418e7ae7c349	Single Arm Triceps Crossover	\N	https://www.youtube.com/watch?v=lC9NRhFN7X4	Triceps(Long Head - Shortened)	TRICEPS
8d5ace9c-cf9a-4d05-9daa-7075652d093a	8c8058c2-e950-44d6-8669-418e7ae7c349	Pec Deck Fly	\N	https://www.youtube.com/watch?v=Qplb3CTTawM	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts	CHEST
8248ac88-a792-4740-9b02-3b2ba8a6b521	89d79788-288c-406e-b5bf-5e4c40fd43ad	Cable Machine Neutral Grip Lat Pull Down	\N	https://www.youtube.com/watch?v=xEDDlzTKpG4	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
cd2ef2ea-6794-4062-8d66-71599453d9f3	89d79788-288c-406e-b5bf-5e4c40fd43ad	Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
9a873de4-7b39-4023-933f-48bf210144e5	89d79788-288c-406e-b5bf-5e4c40fd43ad	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM&pp=0gcJCcUKAYcqIYzv	Upper Traps	BACK
edda8155-1304-48a5-b418-7d2bd73ae760	89d79788-288c-406e-b5bf-5e4c40fd43ad	Incline Dumbell Curl	\N	https://www.youtube.com/watch?v=EiPYwFGeMwc	Biceps(Lengthened)	BICEPS
054c6fb9-47f4-48f7-990c-6f0321dcfaf4	89d79788-288c-406e-b5bf-5e4c40fd43ad	Strict Hammer Curl	\N	https://www.youtube.com/watch?v=vgy3Ay0QUTc	Brachioradialis	BICEPS
b441978e-b634-4633-acad-8293f0ca5232	89d79788-288c-406e-b5bf-5e4c40fd43ad	Cable Rear Delt Fly	\N	https://www.youtube.com/watch?v=me0PJqCEqDU	Teres Major,\nRear Delt, \nMiddle Traps, \nRhomboids	SHOULDER
b53e5f59-b4f5-4ab1-9ec7-7cdde9334ef5	17abd4e8-efa6-41b1-a053-ea14f8f26129	V Squat(Quad Dominant)	\N	https://www.youtube.com/shorts/_t4HyUwmAE8	Quads(Lengthened)	LEGS
2f4b2643-851c-412a-bf63-502c59dd4140	17abd4e8-efa6-41b1-a053-ea14f8f26129	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
879e2d92-dd7a-4086-ae09-0705d1284ac2	17abd4e8-efa6-41b1-a053-ea14f8f26129	Lying Leg Curl	\N		Hamstrings(Less Lengthened)	LEGS
cafa77d5-dba3-4fef-8f34-bc02fe5b6e17	17abd4e8-efa6-41b1-a053-ea14f8f26129	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
252f8a28-2374-458e-9239-ba70cce9d536	17abd4e8-efa6-41b1-a053-ea14f8f26129	Reverse Crunches	\N	https://www.youtube.com/watch?v=U-eR6Pt1gZA	Rectus Abdominis, Transverse Abdominis	ABS
3173a62a-0ac4-4421-a181-a06c63e6459e	17abd4e8-efa6-41b1-a053-ea14f8f26129	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
ffa1bff5-b58e-43c6-a6b7-69c7595ea944	1b70309e-a44b-4f8c-a3ce-a8b4d05fac4a	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
a93951c1-11d5-4228-9183-3878158cb535	1b70309e-a44b-4f8c-a3ce-a8b4d05fac4a	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
f79d684c-c73d-46b2-a3ca-5bd507cb727a	1b70309e-a44b-4f8c-a3ce-a8b4d05fac4a	Cable Lateral Raises	\N	https://www.youtube.com/watch?v=JFzKbUggz7E	Lateral Delt	SHOULDER
baadbd29-d023-451e-852f-bb0a3cf50223	1b70309e-a44b-4f8c-a3ce-a8b4d05fac4a	Ez Bar Lying Triceps Extension	\N	https://www.youtube.com/watch?v=iyIe7qdGtdE	Triceps(Long head - Lengthened)	TRICEPS
16c81899-dcef-44d3-ad90-c82ef90e96fa	1b70309e-a44b-4f8c-a3ce-a8b4d05fac4a	Single Arm Triceps Crossover	\N	https://www.youtube.com/watch?v=lC9NRhFN7X4	Triceps(Long Head - Shortened)	TRICEPS
e696d844-3905-4267-a4a9-5c42964a732b	1b70309e-a44b-4f8c-a3ce-a8b4d05fac4a	Pec Deck Fly	\N	https://www.youtube.com/watch?v=Qplb3CTTawM	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts	CHEST
22ffd7e1-015a-4c3a-b782-336385517ce2	f558a799-a932-4694-917a-71864e1769b4	Cable Machine Neutral Grip Lat Pull Down	\N	https://www.youtube.com/watch?v=xEDDlzTKpG4	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
b6858523-8ec3-465e-ab5b-a9416c3f4d89	f558a799-a932-4694-917a-71864e1769b4	Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
aac6fba0-0617-4902-97d9-643774b8fe70	f558a799-a932-4694-917a-71864e1769b4	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM&pp=0gcJCcUKAYcqIYzv	Upper Traps	BACK
0b542d3c-07c6-4a5b-ad24-642438382f15	fcc301ce-dbb3-4f77-a6d1-583bbe4b7556	Seated Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
210add6d-c13c-459c-a653-664fba87645a	fcc301ce-dbb3-4f77-a6d1-583bbe4b7556	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
dff688f3-4f33-41e0-b669-45dcbdf445f2	6a96aaca-8e09-49dc-af05-43542d56963e	Chest Supported Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
0f81c855-0ef5-4041-bec3-cb2ee30ad7a5	6a96aaca-8e09-49dc-af05-43542d56963e	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Tricpes(Long Head - Shortened)	TRICEPS
5bed39aa-2f55-460a-a102-e2500288c37f	6a96aaca-8e09-49dc-af05-43542d56963e	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
95a9da1f-6219-428e-9617-12a4970e6c91	6a96aaca-8e09-49dc-af05-43542d56963e	Flat Bench Dumbbell Press	\N	https://www.youtube.com/watch?v=3JEKRdfwdxg	Pecs(middle, lower - lengthened),\nAnterior Delts	CHEST
ef4f107d-6bcc-43b4-9850-3b5e3f1cb29b	c59cc3a2-549e-4fd1-bbfe-e795f1c49233	Wall Sits	\N	https://www.youtube.com/watch?v=c38NDc644rs	Quads ΓÇô Isometric (Mid)\nGlutes ΓÇô Isometric (Mid)\nErector Spinae	LEGS
9369e1f4-fbed-4f5e-b2e1-0ea5640e3ffe	c59cc3a2-549e-4fd1-bbfe-e795f1c49233	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
286c3e2a-1a62-46d2-9cb2-27133a63b7ac	c59cc3a2-549e-4fd1-bbfe-e795f1c49233	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
aa8f5919-7a76-4d80-b961-5f842ffcfbf3	c59cc3a2-549e-4fd1-bbfe-e795f1c49233	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
c3bc5460-34ca-4367-b575-eedb12cca7af	c59cc3a2-549e-4fd1-bbfe-e795f1c49233	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
9413ceb5-b5e4-469f-a090-50f09c38eddc	c59cc3a2-549e-4fd1-bbfe-e795f1c49233	Planks	\N	https://www.youtube.com/watch?v=Qv00BKMQf6M	Rectus Abdominis, \nTransverse Abdominis	ABS
77ea57f4-fff2-48f0-af28-1c143b47a587	f558a799-a932-4694-917a-71864e1769b4	Incline Dumbell Curl	\N	https://www.youtube.com/watch?v=EiPYwFGeMwc	Biceps(Lengthened)	BICEPS
7841cbb4-f1e4-49e9-915f-aa3c198261bd	f558a799-a932-4694-917a-71864e1769b4	Strict Hammer Curl	\N	https://www.youtube.com/watch?v=vgy3Ay0QUTc	Brachioradialis	BICEPS
fc6e6359-0ac1-433f-be19-b34012ec4be5	f558a799-a932-4694-917a-71864e1769b4	Cable Rear Delt Fly	\N	https://www.youtube.com/watch?v=me0PJqCEqDU	Teres Major,\nRear Delt, \nMiddle Traps, \nRhomboids	SHOULDER
3198b8df-5891-4092-b2ab-ebfbc718387a	75b5164f-a37c-42e6-9920-9e8812064348	V Squat(Quad Dominant)	\N	https://www.youtube.com/shorts/_t4HyUwmAE8	Quads(Lengthened)	LEGS
6ce54960-71e5-41a2-9de8-3f4efb54e9c9	75b5164f-a37c-42e6-9920-9e8812064348	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
14ea4ce6-cd86-40ae-871b-a45757ff6499	75b5164f-a37c-42e6-9920-9e8812064348	Lying Leg Curl	\N		Hamstrings(Less Lengthened)	LEGS
c93b5ebf-d3cc-4e81-ba0f-8066f42e3ee2	75b5164f-a37c-42e6-9920-9e8812064348	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
99251838-4573-445a-813c-e2a81d38c39a	75b5164f-a37c-42e6-9920-9e8812064348	Reverse Crunches	\N	https://www.youtube.com/watch?v=U-eR6Pt1gZA	Rectus Abdominis, Transverse Abdominis	ABS
aa835542-9453-471b-af1b-806bb182f60d	75b5164f-a37c-42e6-9920-9e8812064348	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
ab930b85-cd1a-47f8-95fe-fa31a4742c06	13ee20a1-e094-4df6-a66c-2ba528735d1a	Incline Smith Machine Chest Press	\N	https://www.youtube.com/watch?v=xH2z4eyy3gA	Pecs (upper) ΓÇô Mid, Anterior Delts, Triceps	CHEST
9d85e08b-e65b-4527-9f20-8ec9f91ec477	13ee20a1-e094-4df6-a66c-2ba528735d1a	High to Low Cable Chest Press	\N	https://www.youtube.com/watch?v=64vMQ-bgMWI	Pecs (middle, lower) ΓÇô Shortened + Mid, Anterior Delts	CHEST
c80b9469-7e49-467f-919d-6caebe6a4c1f	13ee20a1-e094-4df6-a66c-2ba528735d1a	Cable Lateral Raises	\N	https://www.youtube.com/watch?v=JFzKbUggz7E	Lateral Delt	SHOULDER
cf9d07ef-0412-4098-81d9-4b42d7dd3394	13ee20a1-e094-4df6-a66c-2ba528735d1a	Single Arm Overhead Triceps Extension (Cable)	\N	https://www.youtube.com/watch?v=PRnt2HfL39c	Triceps (Long Head) ΓÇô Lengthened	TRICEPS
22f0b80a-0f7d-4de3-a436-05ea13a2d4d8	13ee20a1-e094-4df6-a66c-2ba528735d1a	Machine Triceps Extension	\N	https://www.youtube.com/watch?v=MFRVOkyJyDk	Triceps (Lateral, Medial) ΓÇô Mid + Lengthened	TRICEPS
75e29dc5-c41d-455f-a592-53eb72d39a2f	13ee20a1-e094-4df6-a66c-2ba528735d1a	Machine Crunches	\N		Abs ΓÇô Shortened	ABS
23bbb7e4-5989-47ff-8ad7-060eeaba46e5	ad3cbb58-8524-46aa-845d-158ae7c9ff66	Neutral Grip Seated Cable Row	\N	https://www.youtube.com/watch?v=mnUUQWcqHPQ	Lats (lower, middle) ΓÇô Shortened, Teres Major, Biceps	BACK
38c2684f-4338-4974-898f-84ffc49884cd	ad3cbb58-8524-46aa-845d-158ae7c9ff66	Cable Machine Neutral Grip Lat Pull Down	\N	https://www.youtube.com/watch?v=xEDDlzTKpG4	Lats (vertical fibres) ΓÇô Mid + Shortened, Teres Major, Biceps	BACK
978ab03c-0196-4cff-8414-8fd51b5a85a5	ad3cbb58-8524-46aa-845d-158ae7c9ff66	Rear Delt Cable Pull	\N	https://www.youtube.com/watch?v=JUKuGImz51U	Rear Delts ΓÇô Shortened, External Rotators, Mid/Lower Traps	SHOULDER
10a524e0-a132-4998-92f2-a9d5439b9c83	ad3cbb58-8524-46aa-845d-158ae7c9ff66	Preacher Curl Machine	\N	https://www.youtube.com/watch?v=e1Lh7RVV2NQ	Biceps(Shortened)	BICEPS
faa3d905-bcd0-48b5-b9eb-c159c95eaa85	9c651c4d-dd51-464b-bcf1-6b0ebc9da093	Flat Bench Dumbbell Press	\N	https://www.youtube.com/watch?v=3JEKRdfwdxg	Pecs(middle, lower - lengthened),\nAnterior Delts	CHEST
b179045f-84ae-4e1f-84a4-108fe26b5e0f	9c651c4d-dd51-464b-bcf1-6b0ebc9da093	Incline Dumbell Chest Fly	\N	https://www.youtube.com/watch?v=JSDpq14vCZ8	Pecs (upper) ΓÇô Lengthened\nAnterior Delts\nBiceps (long head)\nSerratus Anterior	CHEST
d972da97-641a-458b-a830-4cfea174dc97	9c651c4d-dd51-464b-bcf1-6b0ebc9da093	Chest Supported Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=pDzjKXU3Lto	Side Delts	SHOULDER
784b0dff-7605-4524-b976-71a6c14eed43	9c651c4d-dd51-464b-bcf1-6b0ebc9da093	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U	Triceps(Long Head - Lengthened)	TRICEPS
c91dc0a2-d0cc-4929-a630-0126d4bf89fa	9c651c4d-dd51-464b-bcf1-6b0ebc9da093	Smith Machine Triceps Press/Incline Close Grip Barbell Bench Press	\N	https://www.youtube.com/watch?v=K1xbj4SRhGg	Triceps(Long Head - Shortened/Normal)	TRICEPS
77c8bd1f-1f75-4d90-818e-5f602ce46ab9	9c651c4d-dd51-464b-bcf1-6b0ebc9da093	Reverse Pec Deck	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
86ce245c-57ce-42ee-a104-28a8f84dd31e	4c426598-8ed9-4c05-9066-73bdbbb1820a	Neutral Grip Lat Pull Down	\N	https://www.youtube.com/watch?v=xEDDlzTKpG4	Lats (upper, lower) ΓÇô Lengthened\nBiceps\nTeres Major\nRear Delts\nRhomboids\nMiddle Traps	BACK
423df60a-0aca-4990-bfa4-e566a7c44d99	4c426598-8ed9-4c05-9066-73bdbbb1820a	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
e557a261-9a53-4a2b-b8ac-77209bb887a1	4c426598-8ed9-4c05-9066-73bdbbb1820a	Dumbbell Pullover	\N	https://www.youtube.com/shorts/k_cFbm-KXtI	Lats (lower) ΓÇô Lengthened\nChest\nTriceps (long head)	BACK
7b029637-2992-4b09-aeab-6e1fb8f088b4	4c426598-8ed9-4c05-9066-73bdbbb1820a	Incline Dumbell Curl	\N	https://www.youtube.com/watch?v=EiPYwFGeMwc	Biceps(Lengthened)	BICEPS
63109499-45ae-4465-a51b-26a760c2936b	4c426598-8ed9-4c05-9066-73bdbbb1820a	Preacher Dumbbell curl on 45 degrees incline bench	\N	https://www.youtube.com/watch?v=i6o-m0BxV8c	Biceps(Shortened)	BICEPS
d5b13ae4-d538-4e44-85bf-b9df2b11ee87	4c426598-8ed9-4c05-9066-73bdbbb1820a	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
0c2aee86-b7bd-461a-b574-5749f8f98722	8d92c260-48f0-4164-b41c-0a4f89bebbb7	Dumbbell Lunges	\N	https://www.youtube.com/watch?v=lotPMgYPbyQ	Quads ΓÇô Lengthened\nGlutes\nHamstrings\nAdductors\nCalves	LEGS
13e8ffbd-a251-49b8-b7b8-ba10d8b28796	8d92c260-48f0-4164-b41c-0a4f89bebbb7	Stiff Leg Deadlift(Dumbbell)	\N	https://www.youtube.com/watch?v=5ExizhPmqbo	Hamstrings(Lengthened),\nGlutes(Lengthened)	LEGS
ba0753f7-f6ea-4378-a76a-d79bef4a15c0	8d92c260-48f0-4164-b41c-0a4f89bebbb7	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
8bb54e71-4756-460b-861d-22ac7afe952a	8d92c260-48f0-4164-b41c-0a4f89bebbb7	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Shortened)	LEGS
7ff82f9b-0724-44fa-af5d-6ff05e684fd0	8d92c260-48f0-4164-b41c-0a4f89bebbb7	Calf Press	\N	https://www.youtube.com/shorts/-pktcXXJo7A	Gastroc, Soleus	LEGS
129d2198-d64f-405f-9d5e-36fccc162d3d	8d92c260-48f0-4164-b41c-0a4f89bebbb7	Crunches	\N	https://www.youtube.com/watch?v=ZPdx67dVJHg	ABS	ABS
3fdead37-d254-403e-8791-a1da5a4ca6d9	b4eda087-737c-411d-94ef-5e904e8ebae6	Seated Dumbbell Shoulder Press	\N	https://www.youtube.com/watch?v=Qscmgbf5AUI	Anterior Delts,\nUpper Pecs	SHOULDER
da04ebc1-94ef-41d5-a829-43e940ce9d89	b4eda087-737c-411d-94ef-5e904e8ebae6	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
b2fc5bfc-c24f-473a-8015-6c3a0bee728f	b4eda087-737c-411d-94ef-5e904e8ebae6	Chest Supported Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Side Delts	SHOULDER
32d12d19-cdb1-4097-b998-dce48841dfc6	b4eda087-737c-411d-94ef-5e904e8ebae6	Dumbbell Pullover	\N	https://www.youtube.com/shorts/k_cFbm-KXtI	Lats (lower) ΓÇô Lengthened\nChest\nTriceps (long head)	BACK
b804b560-a75f-4821-8452-2e3f3dceca23	b4eda087-737c-411d-94ef-5e904e8ebae6	Reverse Pec Deck	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
a53719b2-8780-4291-b2e9-4a8ac181aae7	b4eda087-737c-411d-94ef-5e904e8ebae6	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
536dcfb8-a539-4ced-91dc-00cf1e57a83d	a6e61fa2-253e-4fd7-8f85-1579930a85ac	Pendulum Squat	\N	https://www.youtube.com/shorts/RsSGq7aN_ww	Quads(Lengthened)	LEGS
47c24bca-0976-4550-a335-9d15d712208e	a6e61fa2-253e-4fd7-8f85-1579930a85ac	Reverse V Squat	\N	https://www.youtube.com/shorts/3p9vc0nL5eE	Hamstrings(Lengthened),\nGlutes(Lengthened)	LEGS
280ee4e1-0e79-42b4-982d-74bcc1766778	a6e61fa2-253e-4fd7-8f85-1579930a85ac	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
20336867-fcfd-4dc5-9cfe-12bcec0a9535	a6e61fa2-253e-4fd7-8f85-1579930a85ac	Hip Abduction	\N	https://www.youtube.com/watch?v=G_8LItOiZ0Q	Hip Abductors	LEGS
bcc549aa-44d3-450c-b9b1-6b3cceb5f3cf	a6e61fa2-253e-4fd7-8f85-1579930a85ac	Calf Press	\N	https://www.youtube.com/shorts/-pktcXXJo7A	Gastroc, Soleus	LEGS
3c941aee-b01c-47e4-842c-b7f639a91293	a6e61fa2-253e-4fd7-8f85-1579930a85ac	Russian Twists	\N	https://www.youtube.com/shorts/rTTBzWIsUIM	Obliques	ABS
24df4b8f-7abf-4657-9405-5796b95c3bf4	ad3cbb58-8524-46aa-845d-158ae7c9ff66	Seated Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachialis ΓÇô Mid, Biceps, Forearms	BICEPS
0eee8cd0-d579-458e-a07c-128cb7371122	ad3cbb58-8524-46aa-845d-158ae7c9ff66	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM	Upper Traps	BACK
760e9336-9abb-4dd6-bbb5-61e958624b82	de2264cb-ce65-4d39-af4a-6f44e5547ab8	Smith Machine Squats	\N		Quads(Lengthened),\nGlutes(Lengthened),\nSpinal Erectors	LEGS
525c753a-8bb1-4694-a3cb-1aee31119806	de2264cb-ce65-4d39-af4a-6f44e5547ab8	Hip Extension on 45 degree bench	\N	https://www.youtube.com/watch?v=lUd9L5hSwaA	Hamstrings, Glutes ΓÇô Lengthened + Mid, Spinal Erectors	LEGS
8aa95d5e-defa-4ae3-b2bb-e3af05ec307d	de2264cb-ce65-4d39-af4a-6f44e5547ab8	Seated Single Leg Extensions	\N		Quads(Shortened)	LEGS
d100c420-1846-434d-b680-c7028a507157	de2264cb-ce65-4d39-af4a-6f44e5547ab8	Seated Single Leg Curl	\N		Hamstrings(Lengthened)	LEGS
55f625dc-0d28-4c1c-b03e-3d7d89ab4305	de2264cb-ce65-4d39-af4a-6f44e5547ab8	Calf Press	\N	https://www.youtube.com/shorts/-pktcXXJo7A	Gastroc, Soleus	LEGS
24ce2d3f-464f-425c-b53a-afc0413ae5d2	de2264cb-ce65-4d39-af4a-6f44e5547ab8	Wood Choppers	\N	https://www.youtube.com/watch?v=iWxTGXIViro	Obliques	ABS
f6fa9e00-396b-4969-9470-588b1a3172eb	586d5670-ab85-45f6-8dab-e7195ebc09bf	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
19fb71f4-1e37-461b-8bbc-4172b8fa82ee	586d5670-ab85-45f6-8dab-e7195ebc09bf	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
db130231-02e0-4072-9e2d-cff09bc3e08b	586d5670-ab85-45f6-8dab-e7195ebc09bf	Resverse Pec Deck Fly	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
a6b9d38a-e9f3-445d-b96c-92dc407148d0	4d43bf0d-c142-4435-a6bc-b53080dc94d3	Wall Sit	\N	https://www.youtube.com/watch?v=c38NDc644rs	Quads	LEGS
a88718c5-2831-4f86-8d6c-c90a382af67d	4d43bf0d-c142-4435-a6bc-b53080dc94d3	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
2a996d27-c647-4cc8-ba77-072ebd781a5d	4d43bf0d-c142-4435-a6bc-b53080dc94d3	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
1509c862-49f2-40e2-ad83-1aafb5819851	4d43bf0d-c142-4435-a6bc-b53080dc94d3	Hip Abduction	\N	https://www.youtube.com/watch?v=H98IP8rARy4	Hip Abductors	LEGS
9bd480f8-7cd5-4ac6-b62e-663a8cee2d34	4d43bf0d-c142-4435-a6bc-b53080dc94d3	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
b7a0ad93-1833-408e-b7f4-4ea39f05ab59	4d43bf0d-c142-4435-a6bc-b53080dc94d3	Dead Bugs	\N	https://www.youtube.com/watch?v=mUMVASv0x7U	Rectus Abdominis	ABS
6329d816-e611-4bef-823d-ea0a844e7aea	8a50237f-1358-428e-8b3d-4ac100764164	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
96959760-c59d-4dbb-abae-7a67de03d655	8a50237f-1358-428e-8b3d-4ac100764164	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
2993faf4-4f1e-4c00-a014-b0abeeee6283	8a50237f-1358-428e-8b3d-4ac100764164	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
cfc7c44e-d49c-47e0-a085-c937ee232ac6	8a50237f-1358-428e-8b3d-4ac100764164	Bench Supported Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
5de4c1ea-8148-4e0c-822b-3ed2a0586bcb	8a50237f-1358-428e-8b3d-4ac100764164	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
3461b3c5-cd80-4264-957b-ae2bb5471a5f	d0d37bf5-dc62-4565-99b8-ddb444cb5709	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
8d8b675b-3693-41da-bbcb-6d208373c34d	d0d37bf5-dc62-4565-99b8-ddb444cb5709	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
0484f885-e2a8-41c6-b8c5-d7ae17af03b6	d0d37bf5-dc62-4565-99b8-ddb444cb5709	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
9243fa06-2ce9-404c-bf3a-301b9f157e63	d0d37bf5-dc62-4565-99b8-ddb444cb5709	Dumbbell overhead tricep extension	\N	https://www.youtube.com/shorts/T3e390Dl3XU	Triceps (Long Head) ΓÇô Lengthened + Mid	TRCIEPS
efc8ba58-d958-4ce9-a405-3e18ecc842bd	d0d37bf5-dc62-4565-99b8-ddb444cb5709	Reverse Pec Deck	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Deltoid ΓÇô Mid + Shortened	SHOULDER
e9b6b839-4e27-415c-8cbe-44040a7511c0	7153214c-b458-4994-965c-4ec106fc2e89	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
bac53175-7198-4b02-98dc-46367b25ce27	7153214c-b458-4994-965c-4ec106fc2e89	Incline Leg Press	\N	https://www.youtube.com/watch?v=Ac7D1W0BUF0	Glutes(Lengthened)\nQuads(Lengthened)	LEGS
09e531ba-1c45-45fe-8555-66d445467bf5	7153214c-b458-4994-965c-4ec106fc2e89	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
83a70b26-546d-4024-9b07-5ca907d3137e	7153214c-b458-4994-965c-4ec106fc2e89	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
5bceb85e-5ae9-43bc-8cc9-11c2e036b204	7153214c-b458-4994-965c-4ec106fc2e89	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
87b1cf49-6e60-4388-ab1c-5380d71b84ca	d1295d2c-403d-4f17-aae7-c7e29425922d	Machine Lat Pull Down	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
88dff587-4bff-4d39-8644-f3a270c976fe	d1295d2c-403d-4f17-aae7-c7e29425922d	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
eceeffad-1e49-46b2-963d-00e1a7b50556	d1295d2c-403d-4f17-aae7-c7e29425922d	Dumbbell Pullover	\N	https://www.youtube.com/shorts/k_cFbm-KXtI	Lats (lower) ΓÇô Lengthened\nChest\nTriceps (long head)	BACK
a3e86c1d-5614-4dd8-946a-218f9d64a851	d1295d2c-403d-4f17-aae7-c7e29425922d	Seated Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps ΓÇô Lengthened + Mid	BICEPS
ab0b49dc-18a4-4a3f-9060-84f14d7ea6cf	22a14cd2-1ac3-403d-8265-76a2d4cd8899	Incline Smith Machine Chest Press	\N	https://www.youtube.com/watch?v=xH2z4eyy3gA	Pecs (upper) ΓÇô Mid, Anterior Delts, Triceps	CHEST
a186808f-6540-4362-b259-322e5c198e33	22a14cd2-1ac3-403d-8265-76a2d4cd8899	High to Low Cable Chest Press	\N	https://www.youtube.com/watch?v=64vMQ-bgMWI	Pecs (middle, lower) ΓÇô Shortened + Mid, Anterior Delts	CHEST
0051de21-8faa-4ac5-9219-65b7e5c8341a	22a14cd2-1ac3-403d-8265-76a2d4cd8899	Cable Lateral Raises	\N	https://www.youtube.com/watch?v=JFzKbUggz7E	Lateral Delt	SHOULDER
66a92f36-11e2-4789-b15f-79f2c78730f0	d1295d2c-403d-4f17-aae7-c7e29425922d	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Trapezius ΓÇô Shortened + Mid	BACK
e5e16770-43c8-4077-b653-f5d5e569580d	f80a503e-dc08-4f1c-8ac2-ab9c7d5677df	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
70ef20ae-6053-42d5-9975-a55c559a88b1	f80a503e-dc08-4f1c-8ac2-ab9c7d5677df	Incline Leg Press	\N	https://www.youtube.com/watch?v=Ac7D1W0BUF0	Glutes(Lengthened)\nQuads(Lengthened)	LEGS
096db8bf-d6a8-42fe-8e4e-b47bd91a31bb	f80a503e-dc08-4f1c-8ac2-ab9c7d5677df	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
20e7626c-973f-4c54-87fd-9f4c62b0bab5	f80a503e-dc08-4f1c-8ac2-ab9c7d5677df	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
fdaa2bfc-937b-4ff6-8864-7982e788f4a7	f80a503e-dc08-4f1c-8ac2-ab9c7d5677df	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
6bcae7eb-9cb2-4487-86ae-28933ce8701e	f0bd8432-ca33-4b42-844f-96aab00096c3	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
b9c4ba24-a063-4164-95a2-3e7dd109b032	f0bd8432-ca33-4b42-844f-96aab00096c3	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
941725cc-7d38-4e5b-ab99-9736db95abf0	f0bd8432-ca33-4b42-844f-96aab00096c3	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
f1370706-3edf-4c9b-86ea-886610a54e31	f0bd8432-ca33-4b42-844f-96aab00096c3	Triceps Pulley Pushdown(Bar)	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps	TRICEPS
6d995edc-24e8-4154-bf52-b0a3e1cafefb	f0bd8432-ca33-4b42-844f-96aab00096c3	Pec Deck Fly	\N	https://www.youtube.com/watch?v=Qplb3CTTawM	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts	CHEST
419669d2-35e8-482c-a6ef-7757edb3676e	5b3e4b93-8826-4602-ad3a-534fb2c6ee75	Machine Lat Pull Down	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
e5b08604-f8c0-4891-8924-446e57430a2e	5b3e4b93-8826-4602-ad3a-534fb2c6ee75	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
95157627-6fdc-46c3-adbf-8558f563b944	5b3e4b93-8826-4602-ad3a-534fb2c6ee75	Dumbbell Pullover	\N	https://www.youtube.com/shorts/k_cFbm-KXtI	Lats (lower) ΓÇô Lengthened\nChest\nTriceps (long head)	BACK
8ded575e-8a79-408f-b6ea-6ebb8b94d36b	5b3e4b93-8826-4602-ad3a-534fb2c6ee75	Incline Dumbell Curl	\N	https://www.youtube.com/watch?v=EiPYwFGeMwc	Biceps(Lengthened)	BICEPS
3069ac39-d57c-4e67-8ee9-fc6bcf84c3c9	5b3e4b93-8826-4602-ad3a-534fb2c6ee75	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Trapezius ΓÇô Shortened + Mid	BACK
ae72b5e5-b0d5-4a95-ac92-582f4d197ec5	abebc397-17a0-437b-9e41-7663e8f218d7	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
799c38b8-2312-402e-be46-9e2da1862c37	abebc397-17a0-437b-9e41-7663e8f218d7	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
6fb71e44-e509-4f5d-8a7a-95b81a6cf6c0	abebc397-17a0-437b-9e41-7663e8f218d7	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
6b66a055-0b77-49f3-890d-918ade3e9a47	abebc397-17a0-437b-9e41-7663e8f218d7	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
7a87c4f9-ca33-40e9-b67e-a415e0ac333f	abebc397-17a0-437b-9e41-7663e8f218d7	Reverse Pec Deck Fly	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
8fe43d39-2934-444c-baa8-0b48e5036040	b4f1e983-61aa-4d96-a03f-ed36b5218efa	Leg Press	\N	https://www.youtube.com/watch?v=Ac7D1W0BUF0	Glutes(Lengthened)	LEGS
4ec0b141-7b55-46bf-8222-b4de1b1b62b6	b4f1e983-61aa-4d96-a03f-ed36b5218efa	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
de4a05ce-90e8-46d1-b561-bf74f6c508aa	b4f1e983-61aa-4d96-a03f-ed36b5218efa	Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
def59453-890f-441c-880a-f94debcf2382	b4f1e983-61aa-4d96-a03f-ed36b5218efa	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
e7ad2051-18db-474d-b82b-56259ef51cae	b4f1e983-61aa-4d96-a03f-ed36b5218efa	Abdominal Crunch	\N	https://www.youtube.com/watch?v=ZPdx67dVJHg	Rectus Abdominis,\nTransverse Abdominis	ABS
c4a9215b-9ca3-4a36-b358-776a716a6980	1bcb6bca-a9cb-4a4c-9b3b-c2764fee163b	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
d5e5bdd3-2ab2-4fb4-a565-5d659237ddef	1bcb6bca-a9cb-4a4c-9b3b-c2764fee163b	Single Arm Dumbbell Row	\N	https://www.youtube.com/shorts/rO4Q7nW0ygo	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
f400a792-d4f3-4e79-b836-267522a0d405	1bcb6bca-a9cb-4a4c-9b3b-c2764fee163b	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
a909ff73-d608-419c-8c5f-8e84609f7d17	1bcb6bca-a9cb-4a4c-9b3b-c2764fee163b	Chest Supported Dumbbell Abducted Row	\N	https://www.youtube.com/watch?v=fPtSGpS0tgE	Rhomboids\nMid Traps\nRear Delts\nTeres Minor / Infraspinatus\nUpper Lats (minor contribution)	BACK
9ed4d296-667e-4be4-b866-4420dafbdf43	1bcb6bca-a9cb-4a4c-9b3b-c2764fee163b	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
0a2ee5e7-0cdf-40c2-b635-cab9674030cc	143a5bca-6a36-411b-a0ec-554887fa22d9	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
41324ffa-a55e-43bb-9d5e-be5227a87873	143a5bca-6a36-411b-a0ec-554887fa22d9	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
ebf58554-c9c4-49c4-b6ac-6f2f7a81c65a	143a5bca-6a36-411b-a0ec-554887fa22d9	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
2bc21e86-1a76-4d21-bd61-7874602f2acc	143a5bca-6a36-411b-a0ec-554887fa22d9	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
972cb919-cc91-4199-a01d-17fb4f1e0b06	143a5bca-6a36-411b-a0ec-554887fa22d9	Reverse Pec Deck Fly	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
940d4d5d-933d-4581-a7e2-582729069354	f8342bf4-d8c5-4310-870a-5a226e708391	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
6b9a426f-8f01-4627-8808-7f23950a66f5	f8342bf4-d8c5-4310-870a-5a226e708391	Single Arm Dumbbell Row	\N	https://www.youtube.com/shorts/rO4Q7nW0ygo	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
2effe1fc-4886-480b-a62c-3a58eb58ad02	f8342bf4-d8c5-4310-870a-5a226e708391	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
4d74cfd9-0521-4485-9cb3-6f794049b51c	f8342bf4-d8c5-4310-870a-5a226e708391	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
7b2e6b0a-817c-45b0-803a-dd69f7f12e38	f8342bf4-d8c5-4310-870a-5a226e708391	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
966f6942-efd6-4ff7-91eb-fd4c39b98cce	22a14cd2-1ac3-403d-8265-76a2d4cd8899	Single Arm Overhead Triceps Extension (Cable)	\N	https://www.youtube.com/watch?v=PRnt2HfL39c	Triceps (Long Head) ΓÇô Lengthened	TRICEPS
db2ac0f9-a479-4368-9cbe-8b0f60d7f3c6	22a14cd2-1ac3-403d-8265-76a2d4cd8899	Machine Triceps Extension	\N	https://www.youtube.com/watch?v=MFRVOkyJyDk	Triceps (Lateral, Medial) ΓÇô Mid + Lengthened	TRICEPS
efe4f627-4da7-42a9-a6c8-6b8888dd7924	22a14cd2-1ac3-403d-8265-76a2d4cd8899	Machine Crunches	\N		Abs ΓÇô Shortened	ABS
e3ca414c-84fe-458d-a6b0-22d3ebe582c9	5b25a2c7-9e2c-4ec8-81d7-d2e7cac94e4c	Neutral Grip Seated Cable Row	\N	https://www.youtube.com/watch?v=mnUUQWcqHPQ	Lats (lower, middle) ΓÇô Shortened, Teres Major, Biceps	BACK
af5e845c-147f-4fb8-a809-4285d5576323	5b25a2c7-9e2c-4ec8-81d7-d2e7cac94e4c	Cable Machine Neutral Grip Lat Pull Down	\N	https://www.youtube.com/watch?v=xEDDlzTKpG4	Lats (vertical fibres) ΓÇô Mid + Shortened, Teres Major, Biceps	BACK
55200e96-5d94-4475-b008-28e845edf3e4	5b25a2c7-9e2c-4ec8-81d7-d2e7cac94e4c	Rear Delt Cable Pull	\N	https://www.youtube.com/watch?v=JUKuGImz51U	Rear Delts ΓÇô Shortened, External Rotators, Mid/Lower Traps	SHOULDER
b365497c-a5d1-461d-9cce-23467f3a2885	5b25a2c7-9e2c-4ec8-81d7-d2e7cac94e4c	Preacher Curl Machine	\N	https://www.youtube.com/watch?v=e1Lh7RVV2NQ	Biceps(Shortened)	BICEPS
aca4cf81-21ae-4243-81c3-da2ef44cf4ef	5b25a2c7-9e2c-4ec8-81d7-d2e7cac94e4c	Seated Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachialis ΓÇô Mid, Biceps, Forearms	BICEPS
f29a3095-d428-47d7-8bda-ead24ed8aa61	5b25a2c7-9e2c-4ec8-81d7-d2e7cac94e4c	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM	Upper Traps	BACK
b5e06a2e-df01-487a-acf8-f499abe8e4d4	c7bdd5c3-9475-41ca-ae13-fdcb3f48cd0e	Smith Machine Squats	\N		Quads(Lengthened),\nGlutes(Lengthened),\nSpinal Erectors	LEGS
5a81a06f-42ad-4522-b32d-170e38efded6	c7bdd5c3-9475-41ca-ae13-fdcb3f48cd0e	Hip Extension on 45 degree bench	\N	https://www.youtube.com/watch?v=lUd9L5hSwaA	Hamstrings, Glutes ΓÇô Lengthened + Mid, Spinal Erectors	LEGS
c224a86b-5806-45c6-a474-769eca910d2f	c7bdd5c3-9475-41ca-ae13-fdcb3f48cd0e	Seated Single Leg Extensions	\N		Quads(Shortened)	LEGS
107653ab-a872-4a1b-9e76-27088407673a	c7bdd5c3-9475-41ca-ae13-fdcb3f48cd0e	Seated Single Leg Curl	\N		Hamstrings(Lengthened)	LEGS
449e4016-931d-40d0-9a94-7cc02d828238	c7bdd5c3-9475-41ca-ae13-fdcb3f48cd0e	Calf Press	\N	https://www.youtube.com/shorts/-pktcXXJo7A	Gastroc, Soleus	LEGS
89e40157-b9e4-4fb8-b7f2-410dd5cfee9f	c7bdd5c3-9475-41ca-ae13-fdcb3f48cd0e	Wood Choppers	\N	https://www.youtube.com/watch?v=iWxTGXIViro	Obliques	ABS
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	workout tables	SQL	V1__workout_tables.sql	1478511855	postgres	2026-03-11 06:57:52.439739	576	t
2	2	create workout assignments	SQL	V2__create_workout_assignments.sql	854679782	postgres	2026-03-11 06:57:53.785932	82	t
3	3	reps datatype change	SQL	V3__reps_datatype_change.sql	-1186540855	postgres	2026-03-11 06:57:54.054772	142	t
4	4	add video url to exercises	SQL	V4__add_video_url_to_exercises.sql	-971857309	postgres	2026-03-11 06:57:54.449048	89	t
5	5	create exercise library tables	SQL	V5__create_exercise_library_tables.sql	-944177170	postgres	2026-03-11 06:57:54.685669	318	t
6	6	align exercise library columns	SQL	V6__align_exercise_library_columns.sql	-596863615	postgres	2026-03-11 06:57:55.362542	171	t
7	7	add muscles trained columns	SQL	V7__add_muscles_trained_columns.sql	757049620	postgres	2026-03-11 06:57:55.772871	138	t
8	8	add muscle group to exercises	SQL	V8__add_muscle_group_to_exercises.sql	-1999577553	postgres	2026-03-15 13:05:11.185626	77	t
\.


--
-- Data for Name: member_exercise_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.member_exercise_assignments (id, library_exercise_id, member_id, coach_email, assigned_at) FROM stdin;
\.


--
-- Data for Name: workout_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workout_assignments (id, plan_id, member_id, coach_email, active, assigned_at) FROM stdin;
f14e72a4-0c0e-475f-9a8a-ac379640e025	a2577221-541d-428d-84d5-c411246dcc8c	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	t	2026-03-15 12:49:14.124733
7c3078b6-f6cb-4bba-8e65-adf6298f3ef3	da8e814d-f49b-4e96-9afd-e484c9e440f6	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	t	2026-03-15 14:54:54.049982
0db9287b-2acf-453d-972f-d0c7fd9e5d8f	ca59d371-e6cc-440c-941c-94271aa61761	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	t	2026-03-16 11:46:51.923583
adf027af-16dc-47e3-a957-b2091c0ab3a9	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	t	2026-03-19 13:36:30.077944
8a7c3f0f-9331-4640-9d00-18a486708904	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	t	2026-03-27 04:16:38.02247
0edded78-9619-4dde-ac8c-2658efa1bcaa	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	t	2026-03-28 14:03:43.674218
a75726dc-b020-4f2a-9162-c21677a9094b	c5def8cb-87f5-4deb-866e-17b0c1e76d15	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	t	2026-05-08 03:15:23.938523
b57f6569-e004-4398-b0f6-e2bf7f94478c	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	t	2026-05-12 13:52:16.08647
722889a7-ab2e-48c3-8eb4-e5ad1cd2c9b4	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	f	2026-04-06 03:20:21.604886
1e8600e6-1439-49fb-b7fa-d3655f80d55d	dbca39d7-faa6-4cf6-929a-1436658823a3	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	t	2026-05-17 16:41:18.009327
\.


--
-- Data for Name: workout_days; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workout_days (id, plan_id, day_name) FROM stdin;
8c8058c2-e950-44d6-8669-418e7ae7c349	a2577221-541d-428d-84d5-c411246dcc8c	Day 1
89d79788-288c-406e-b5bf-5e4c40fd43ad	a2577221-541d-428d-84d5-c411246dcc8c	Day 2
17abd4e8-efa6-41b1-a053-ea14f8f26129	a2577221-541d-428d-84d5-c411246dcc8c	Day 3
1b70309e-a44b-4f8c-a3ce-a8b4d05fac4a	a2577221-541d-428d-84d5-c411246dcc8c	Day 4
f558a799-a932-4694-917a-71864e1769b4	a2577221-541d-428d-84d5-c411246dcc8c	Day 5
75b5164f-a37c-42e6-9920-9e8812064348	a2577221-541d-428d-84d5-c411246dcc8c	Day 6
76217a8e-59a8-48d5-9e19-034717cf96bd	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 1
01da0d04-6311-4870-8b84-57ac7f40b782	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 2
230ec348-0915-4078-80f2-0c5097d02241	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 3
586d5670-ab85-45f6-8dab-e7195ebc09bf	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 4
4d43bf0d-c142-4435-a6bc-b53080dc94d3	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 5
8a50237f-1358-428e-8b3d-4ac100764164	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 6
d0d37bf5-dc62-4565-99b8-ddb444cb5709	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 1
9c651c4d-dd51-464b-bcf1-6b0ebc9da093	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	Day 1
4c426598-8ed9-4c05-9066-73bdbbb1820a	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	Day 2
8d92c260-48f0-4164-b41c-0a4f89bebbb7	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	Day 3
b4eda087-737c-411d-94ef-5e904e8ebae6	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	Day 4
a6e61fa2-253e-4fd7-8f85-1579930a85ac	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	Day 5
7153214c-b458-4994-965c-4ec106fc2e89	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 2
d1295d2c-403d-4f17-aae7-c7e29425922d	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 3
f80a503e-dc08-4f1c-8ac2-ab9c7d5677df	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 4
f0bd8432-ca33-4b42-844f-96aab00096c3	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 5
929cebe1-2821-414b-825a-7a2b885d9fb1	ca59d371-e6cc-440c-941c-94271aa61761	Day 1
242d4551-5fa3-4bb0-afe4-5876551f4975	ca59d371-e6cc-440c-941c-94271aa61761	Day 2
15dc2363-58e5-4033-8a8d-a641320a89cb	ca59d371-e6cc-440c-941c-94271aa61761	Day 3
a54cd1e3-7853-4907-a6a7-78baffbc64b0	ca59d371-e6cc-440c-941c-94271aa61761	Day 4
7cf1dcab-3f45-4a58-bc98-62bb960ec4dc	ca59d371-e6cc-440c-941c-94271aa61761	Day 5
c6c626f0-9191-4790-a7a9-e936c515f14c	ca59d371-e6cc-440c-941c-94271aa61761	Day 6
5b3e4b93-8826-4602-ad3a-534fb2c6ee75	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 6
e4332898-fef2-47d5-9fdc-e92674501b79	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 1
6172e9bd-e906-4862-a750-4b212b7c7cb0	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 2
31314383-c5ec-46b5-98cf-5e375a786e40	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 3
dca5b842-4fc4-4192-a7fc-07feea7857c9	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 4
ef202a35-e917-4c9b-8521-0c80bc762343	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 5
ce79beea-5299-4b91-9491-fb2717c2708f	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 6
618c40a6-be57-4d79-a7da-73a09588d6db	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 1
873c3aa5-87c7-41be-bd3b-80a771762af2	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 2
3e84e704-fd23-4895-b171-b75c8665b377	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 3
e7a690f4-892e-4f2d-85fb-b0425fb07084	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 4
e6616aca-8b74-4f41-91d7-d5c08593578e	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 5
99744c9a-0ede-4480-ba98-fa22cb1f47eb	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 6
0b391810-638e-4b5c-b24c-fa4d4b6aff6d	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	Day 1
251bb4a7-4a91-44d0-ae1b-1e24410e7a54	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	Day 2
fcc301ce-dbb3-4f77-a6d1-583bbe4b7556	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	Day 3
6a96aaca-8e09-49dc-af05-43542d56963e	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	Day 4
c59cc3a2-549e-4fd1-bbfe-e795f1c49233	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	Day 5
abebc397-17a0-437b-9e41-7663e8f218d7	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	Day 1
b4f1e983-61aa-4d96-a03f-ed36b5218efa	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	Day 2
1bcb6bca-a9cb-4a4c-9b3b-c2764fee163b	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	Day 3
143a5bca-6a36-411b-a0ec-554887fa22d9	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	Day 4
f8342bf4-d8c5-4310-870a-5a226e708391	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	Day 5
13ee20a1-e094-4df6-a66c-2ba528735d1a	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 1
ad3cbb58-8524-46aa-845d-158ae7c9ff66	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 2
de2264cb-ce65-4d39-af4a-6f44e5547ab8	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 3
22a14cd2-1ac3-403d-8265-76a2d4cd8899	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 4
5b25a2c7-9e2c-4ec8-81d7-d2e7cac94e4c	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 5
c7bdd5c3-9475-41ca-ae13-fdcb3f48cd0e	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 6
\.


--
-- Data for Name: workout_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workout_plans (id, member_id, coach_email, title, notes, created_at, updated_at) FROM stdin;
ca59d371-e6cc-440c-941c-94271aa61761	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	Push Pull Legs (8-10 weeks)		2026-03-16 11:46:50.730681	\N
9fd58431-91f6-4e1e-9f58-f6e7f6128d06	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	Push Pull Legs (8-10 weeks)	Steps Target : 8k Daily	2026-03-19 13:36:28.402106	\N
a2577221-541d-428d-84d5-c411246dcc8c	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	Push Pull Legs (8-10 weeks)	Steps Target : 8k Daily	2026-03-15 12:49:13.51916	\N
da8e814d-f49b-4e96-9afd-e484c9e440f6	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	Push Pull Legs (8-10 weeks)	Steps Target : 12K	2026-03-15 14:54:52.519471	\N
043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	Push-Pull-Legs-Upper-Lower	Steps Target : 8000 Daily	2026-03-28 14:03:43.228464	\N
f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	Gym based workout	Target Steps : 8000 daily	2026-03-27 04:16:36.507894	\N
c5def8cb-87f5-4deb-866e-17b0c1e76d15	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	Push-Legs-Pull		2026-05-08 03:15:22.061623	\N
d9ee8604-ec0a-4beb-9df7-68eb619d17d2	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	Push-Lower-Pull-Lower-Push-Pull	Steps Target : 12000 Daily	2026-04-06 03:20:18.822365	\N
61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	Push ΓÇô Lower ΓÇô Pull ΓÇô Push ΓÇô Pull	Steps Target : 8K	2026-05-12 13:52:15.894094	\N
dbca39d7-faa6-4cf6-929a-1436658823a3	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	Push Pull Legs Phase 2		2026-05-17 16:41:16.626651	\N
\.


--
-- Name: exercise_library exercise_library_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_library
    ADD CONSTRAINT exercise_library_pkey PRIMARY KEY (id);


--
-- Name: exercise_sets exercise_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_sets
    ADD CONSTRAINT exercise_sets_pkey PRIMARY KEY (id);


--
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: member_exercise_assignments member_exercise_assignments_library_exercise_id_member_id_c_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_exercise_assignments
    ADD CONSTRAINT member_exercise_assignments_library_exercise_id_member_id_c_key UNIQUE (library_exercise_id, member_id, coach_email);


--
-- Name: member_exercise_assignments member_exercise_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_exercise_assignments
    ADD CONSTRAINT member_exercise_assignments_pkey PRIMARY KEY (id);


--
-- Name: workout_assignments workout_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workout_assignments
    ADD CONSTRAINT workout_assignments_pkey PRIMARY KEY (id);


--
-- Name: workout_days workout_days_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workout_days
    ADD CONSTRAINT workout_days_pkey PRIMARY KEY (id);


--
-- Name: workout_plans workout_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workout_plans
    ADD CONSTRAINT workout_plans_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: exercise_sets exercise_sets_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_sets
    ADD CONSTRAINT exercise_sets_exercise_id_fkey FOREIGN KEY (exercise_id) REFERENCES public.exercises(id);


--
-- Name: exercises exercises_day_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_day_id_fkey FOREIGN KEY (day_id) REFERENCES public.workout_days(id);


--
-- Name: member_exercise_assignments member_exercise_assignments_library_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_exercise_assignments
    ADD CONSTRAINT member_exercise_assignments_library_exercise_id_fkey FOREIGN KEY (library_exercise_id) REFERENCES public.exercise_library(id);


--
-- Name: workout_days workout_days_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workout_days
    ADD CONSTRAINT workout_days_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.workout_plans(id);


--
-- PostgreSQL database dump complete
--

\unrestrict pQwvENbznCQf11yRkAuL5liZdWv6cEr1uAzTlvSlRDPcQxU3QcJseePUSwfLNHw

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict TsC3yDJIaK3VEtruJSbIL4HrvrPEdWf2TzyyTLAzD3jjaIlXdvSwjpf4m3HKFTA

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\unrestrict TsC3yDJIaK3VEtruJSbIL4HrvrPEdWf2TzyyTLAzD3jjaIlXdvSwjpf4m3HKFTA

--
-- PostgreSQL database cluster dump complete
--


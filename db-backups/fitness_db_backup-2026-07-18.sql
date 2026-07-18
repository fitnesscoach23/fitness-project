--
-- PostgreSQL database cluster dump
--

\restrict voGGhE4e2zdTvkM7Awap8NRbsCJgjcLI1bxyVNM1t9L5aXvKumih2beWF6qTPCg

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








\unrestrict voGGhE4e2zdTvkM7Awap8NRbsCJgjcLI1bxyVNM1t9L5aXvKumih2beWF6qTPCg

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

\restrict mja0wnn2oNJbJtjnTNoKwQfoLke9bmFOg0ZwOFgSTzyXDapFfg3G3djTezlynGE

-- Dumped from database version 15.18 (Debian 15.18-1.pgdg13+1)
-- Dumped by pg_dump version 15.18 (Debian 15.18-1.pgdg13+1)

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

\unrestrict mja0wnn2oNJbJtjnTNoKwQfoLke9bmFOg0ZwOFgSTzyXDapFfg3G3djTezlynGE

--
-- Database "coach_auth" dump
--

--
-- PostgreSQL database dump
--

\restrict QufPLQ1E7MluRwfX7kWlX1fEJQuuMrECFvdZpB1PgiMNVzmgR2w2kReWX6gJ8Nw

-- Dumped from database version 15.18 (Debian 15.18-1.pgdg13+1)
-- Dumped by pg_dump version 15.18 (Debian 15.18-1.pgdg13+1)

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

\unrestrict QufPLQ1E7MluRwfX7kWlX1fEJQuuMrECFvdZpB1PgiMNVzmgR2w2kReWX6gJ8Nw
\connect coach_auth
\restrict QufPLQ1E7MluRwfX7kWlX1fEJQuuMrECFvdZpB1PgiMNVzmgR2w2kReWX6gJ8Nw

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
ffb476db-0bce-4e49-9bdb-c55ad3a28e24	Varun Deoghare	varun.deoghare@gmail.com	$2a$10$c158uhRy8ZWvpNiGlW710OxJq5WIGCRR7Gcz1RwtSaowWz3EXnRtq	COACH	2026-03-11 06:58:54.663743	\N	2026-07-18 12:36:17.465249
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

\unrestrict QufPLQ1E7MluRwfX7kWlX1fEJQuuMrECFvdZpB1PgiMNVzmgR2w2kReWX6gJ8Nw

--
-- Database "coach_billing" dump
--

--
-- PostgreSQL database dump
--

\restrict VKWtVuo0wWiXcuRRkXPlicNGW8u5gz34ymcVEPeHxmfpR8uyJpzqYEPIYgNbEJb

-- Dumped from database version 15.18 (Debian 15.18-1.pgdg13+1)
-- Dumped by pg_dump version 15.18 (Debian 15.18-1.pgdg13+1)

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

\unrestrict VKWtVuo0wWiXcuRRkXPlicNGW8u5gz34ymcVEPeHxmfpR8uyJpzqYEPIYgNbEJb
\connect coach_billing
\restrict VKWtVuo0wWiXcuRRkXPlicNGW8u5gz34ymcVEPeHxmfpR8uyJpzqYEPIYgNbEJb

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
5004a901-2fab-4f12-9662-ca414a357e41	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	1500.00	2026-05-21	MANUAL	\N	2026-05-22 13:39:38.808278	MANUAL	\N	\N	\N	SUCCESS	\N
6bfc7c3b-bd90-43d4-8ba0-5ca6b960ad0e	57ee19de-9c3f-49bf-83d2-20a56100a64e	varun.deoghare@gmail.com	1000.00	2026-05-26	MANUAL	\N	2026-05-26 11:50:01.993944	MANUAL	\N	\N	\N	SUCCESS	\N
ed252bc2-c0e7-4fd1-904a-4f08164c751d	6ae0f3fa-0233-4160-ba88-11f4b8ae7e38	varun.deoghare@gmail.com	1000.00	2026-05-26	MANUAL	\N	2026-05-26 11:50:26.11388	MANUAL	\N	\N	\N	SUCCESS	\N
1fb3cb79-cc78-4b24-84bd-79debcde3fc9	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	1000.00	2026-05-25	MANUAL	\N	2026-05-26 11:50:43.758569	MANUAL	\N	\N	\N	SUCCESS	\N
8189b39d-1b13-434b-92f6-fca424d485d7	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	1000.00	2026-05-26	MANUAL	\N	2026-05-26 11:50:52.485082	MANUAL	\N	\N	\N	SUCCESS	\N
a038bc68-91ab-40ee-bde9-587e0e47b6c3	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	1000.00	2026-05-29	MANUAL	\N	2026-05-29 14:26:01.496898	MANUAL	\N	\N	\N	SUCCESS	\N
4d3d8846-0570-46da-bfb3-229440da2f9f	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	1000.00	2026-05-29	MANUAL	\N	2026-05-29 14:26:08.805166	MANUAL	\N	\N	\N	SUCCESS	\N
f09380ed-b700-4b2d-a6b5-329a38e31341	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	1500.00	2026-05-30	MANUAL	\N	2026-05-30 13:55:20.185182	MANUAL	\N	\N	\N	SUCCESS	\N
aab43fa8-9bc1-4980-9e9c-2c2e05301772	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	1000.00	2026-05-31	MANUAL	\N	2026-06-02 14:55:07.396163	MANUAL	\N	\N	\N	SUCCESS	\N
6fc135ee-eab5-44d4-a132-fbb0a1f422c8	615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	1000.00	\N	ONLINE	\N	2026-06-14 05:22:34.468909	RAZORPAY	\N	\N	\N	PENDING	\N
3f2dbe89-fe5a-4dc0-9969-f767889f24d6	615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	1000.00	2026-06-14	MANUAL	\N	2026-06-14 05:22:43.726529	MANUAL	\N	\N	\N	SUCCESS	2026-06-15 03:49:47.092359
183a32d3-d21d-4e04-a757-1f9482d7d45b	615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	1000.00	2026-06-16	MANUAL	\N	2026-06-16 03:32:22.433762	MANUAL	\N	\N	\N	SUCCESS	\N
0353c6e4-3b67-4937-91cd-f95f8916e047	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	1000.00	2026-06-16	MANUAL	\N	2026-06-17 04:27:46.198548	MANUAL	\N	\N	\N	SUCCESS	\N
470b7173-6146-4da2-9053-6a9a49cadccf	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	1500.00	2026-06-15	MANUAL	\N	2026-06-17 07:54:19.631881	MANUAL	\N	\N	\N	SUCCESS	\N
3257f96b-d785-4eae-840e-5ff8bcdd37c1	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	1500.00	2026-06-15	MANUAL	\N	2026-06-17 07:54:50.13839	MANUAL	\N	\N	\N	SUCCESS	\N
85259038-0627-49b5-a5fc-30abe2d0e1f1	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	1500.00	2026-06-20	MANUAL	\N	2026-06-22 04:10:22.887641	MANUAL	\N	\N	\N	SUCCESS	\N
ee04d9c7-06dd-4aae-b8c1-9bdb75ffd730	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	1000.00	2026-06-24	MANUAL	\N	2026-06-27 04:19:42.257877	MANUAL	\N	\N	\N	SUCCESS	\N
2f931d50-9228-4722-8807-1ef6a2a20949	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	1000.00	2026-06-25	MANUAL	\N	2026-06-28 07:03:08.399145	MANUAL	\N	\N	\N	SUCCESS	\N
f2a32a71-c2a9-42b8-abc6-4a4f31bfcfac	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	1500.00	2026-06-07	MANUAL	\N	2026-06-28 07:45:29.045763	MANUAL	\N	\N	\N	SUCCESS	\N
1f80a4e6-017f-4608-8b79-3f320fb5dbf8	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	1500.00	2026-06-29	MANUAL	\N	2026-06-30 03:53:39.580224	MANUAL	\N	\N	\N	SUCCESS	\N
38de9dde-b789-4d06-a6c7-80e4b46c0148	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	1000.00	2026-06-30	MANUAL	\N	2026-07-01 03:06:46.457275	MANUAL	\N	\N	\N	SUCCESS	\N
2d6c46b1-c4d9-4e75-8bc2-5cf57858b902	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	1000.00	2026-06-28	MANUAL	\N	2026-07-01 03:35:45.285012	MANUAL	\N	\N	\N	SUCCESS	\N
35dcf337-d4f0-4cca-8aa2-27c2f8e9dc1f	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	1000.00	2026-06-28	MANUAL	\N	2026-07-01 03:35:57.403017	MANUAL	\N	\N	\N	SUCCESS	\N
81f98455-f753-4d9d-a1bf-99ad45fcbb92	57ee19de-9c3f-49bf-83d2-20a56100a64e	varun.deoghare@gmail.com	1000.00	2026-06-25	MANUAL	\N	2026-07-01 03:36:07.919913	MANUAL	\N	\N	\N	SUCCESS	\N
75215fc2-feb2-407e-ae6c-3421058b99a7	6ae0f3fa-0233-4160-ba88-11f4b8ae7e38	varun.deoghare@gmail.com	1000.00	2026-06-25	MANUAL	\N	2026-07-01 03:36:23.323691	MANUAL	\N	\N	\N	SUCCESS	\N
82008e02-093f-4702-9110-0cd8d4027dc4	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	1500.00	2026-07-28	MANUAL	\N	2026-07-01 03:36:43.489556	MANUAL	\N	\N	\N	SUCCESS	2026-07-01 03:37:05.181771
5b260ea0-557b-4a46-8b33-8503e704e16b	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	500.00	2026-07-05	MANUAL	\N	2026-07-05 15:13:16.195354	MANUAL	\N	\N	\N	SUCCESS	\N
cce4323a-ecb2-4c14-8d8c-102236d5b62c	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	1500.00	2026-07-09	MANUAL	\N	2026-07-09 03:44:01.541571	MANUAL	\N	\N	\N	SUCCESS	\N
a0ce8474-bc91-4680-b188-2426dd268bdb	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	1500.00	2026-07-06	MANUAL	\N	2026-07-16 12:52:07.098081	MANUAL	\N	\N	\N	SUCCESS	\N
127809fa-8089-4c6b-b4c6-2e72cf5342f7	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	1500.00	2026-07-14	MANUAL	\N	2026-07-16 13:27:34.454199	MANUAL	\N	\N	\N	SUCCESS	\N
c7004590-e299-41e3-98bc-ebaf67cf0c39	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	1500.00	2026-07-14	MANUAL	\N	2026-07-16 13:27:54.19435	MANUAL	\N	\N	\N	SUCCESS	\N
bbce4dd1-b85f-4dab-9d71-6617f52f3b15	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	500.00	2026-07-15	MANUAL	\N	2026-07-12 14:05:19.479811	MANUAL	\N	\N	\N	SUCCESS	2026-07-16 13:47:26.275741
3db10604-3e4d-4471-8d0c-58c80dc83848	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	500.00	2026-07-15	MANUAL	\N	2026-07-16 13:47:55.162754	MANUAL	\N	\N	\N	SUCCESS	2026-07-16 13:49:15.011785
b6b29aa7-4c04-4512-8149-bc297ede85f9	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	500.00	2026-08-01	MANUAL	\N	2026-07-16 13:49:28.467184	MANUAL	\N	\N	\N	SUCCESS	\N
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscriptions (id, member_id, coach_email, start_date, end_date, status, created_at) FROM stdin;
e5855b3d-4773-433b-87d7-b8fdd2fed418	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	2026-03-15	2026-06-01	ACTIVE	2026-03-15 07:16:43.551385
9fd9e9f8-9f2b-4627-9473-7bf249325809	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-05-09	2026-06-09	ACTIVE	2026-05-09 08:56:59.412086
d80e385f-ff28-48e5-888f-2a48abd00752	615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	2026-03-17	2026-07-16	ACTIVE	2026-03-17 12:02:09.102047
ad8c1589-15bf-4a03-845b-2a6167d41863	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-05-21	2026-07-20	ACTIVE	2026-05-22 13:39:40.266859
48487970-f5df-4508-ac70-07ecd4d349e3	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-03-16	2026-07-24	ACTIVE	2026-03-16 03:26:57.199948
95dbd35b-cd7a-4e41-af0d-5b33134d6ace	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-03-19	2026-07-25	ACTIVE	2026-03-19 13:10:00.667824
5d06e5e0-a0d0-4db3-8fcd-1b6cff3086bd	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-03-15	2026-07-30	ACTIVE	2026-03-15 07:19:15.688507
4f14457d-58bd-4091-a8b4-781f4185cd5a	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-03-28	2026-07-28	ACTIVE	2026-03-28 12:19:47.250801
ba1a57d7-7e7e-4bc0-a8f3-abeff6f631d6	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-03-28	2026-07-28	ACTIVE	2026-03-28 12:19:42.899755
f058a6c1-5fb7-4afc-bb63-d451bd4b496e	57ee19de-9c3f-49bf-83d2-20a56100a64e	varun.deoghare@gmail.com	2026-05-26	2026-07-25	ACTIVE	2026-05-26 11:50:02.518703
20edd787-b2e5-4488-97b6-9d18a098ee6b	6ae0f3fa-0233-4160-ba88-11f4b8ae7e38	varun.deoghare@gmail.com	2026-05-26	2026-07-25	ACTIVE	2026-05-26 11:50:26.134995
4ea31dad-9d8c-4f63-b502-afbd816c7eef	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-05-30	2026-07-29	ACTIVE	2026-05-30 13:55:20.293045
6dff41e5-0dc9-4d96-880c-a0fc42c80416	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	2026-07-05	2026-08-05	ACTIVE	2026-07-05 15:13:16.846549
52d762e2-0b8d-4b74-ae10-cd0c8455363e	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	2026-07-09	2026-08-09	ACTIVE	2026-07-09 03:44:02.684932
77df0c1c-0950-4568-b640-c109904d0ab0	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-04-06	2026-08-06	ACTIVE	2026-05-02 14:51:37.619421
f6d08d3e-60d8-45a7-a0c8-809489deb097	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-05-15	2026-08-14	ACTIVE	2026-05-15 14:16:09.057742
da4c62ce-5b71-47c1-9d03-240da255e8b7	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-05-15	2026-08-14	ACTIVE	2026-05-15 14:22:20.173549
1a672766-345b-4d32-ab63-ef07ef86306f	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-03-13	2026-09-01	ACTIVE	2026-03-13 14:02:00.812984
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

\unrestrict VKWtVuo0wWiXcuRRkXPlicNGW8u5gz34ymcVEPeHxmfpR8uyJpzqYEPIYgNbEJb

--
-- Database "coach_checkin" dump
--

--
-- PostgreSQL database dump
--

\restrict SkaxMzRCsvAhuTx0R1pOrXH4stmNrIzd1sIJMHG6SqwM72WRcOIl6YFHguA4732

-- Dumped from database version 15.18 (Debian 15.18-1.pgdg13+1)
-- Dumped by pg_dump version 15.18 (Debian 15.18-1.pgdg13+1)

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

\unrestrict SkaxMzRCsvAhuTx0R1pOrXH4stmNrIzd1sIJMHG6SqwM72WRcOIl6YFHguA4732
\connect coach_checkin
\restrict SkaxMzRCsvAhuTx0R1pOrXH4stmNrIzd1sIJMHG6SqwM72WRcOIl6YFHguA4732

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
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    activity_status character varying(40) DEFAULT 'NO_ACTIVITY'::character varying NOT NULL,
    step_target_achieved boolean DEFAULT false NOT NULL,
    travel_workout boolean DEFAULT false NOT NULL,
    recovery_day boolean DEFAULT false NOT NULL,
    active_other boolean DEFAULT false NOT NULL,
    not_active boolean DEFAULT false NOT NULL,
    workout_video_not_shared boolean DEFAULT false NOT NULL,
    steps_record_not_shared boolean DEFAULT false NOT NULL,
    workout_not_completed boolean DEFAULT false NOT NULL
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

COPY public.daily_member_checkins (id, member_id, coach_email, check_in_date, exercise_done, steps_count, notes, created_at, updated_at, activity_status, step_target_achieved, travel_workout, recovery_day, active_other, not_active, workout_video_not_shared, steps_record_not_shared, workout_not_completed) FROM stdin;
4497ac97-3a4e-4d63-b9da-bc125747523e	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-05	t	3000	\N	2026-06-21 12:29:01.240625+00	2026-06-21 12:29:01.240625+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
3286365f-af5f-4d0c-a14f-1e72f1f1f2f1	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-01	t	3000	\N	2026-06-21 12:29:01.240625+00	2026-06-21 12:29:01.240625+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
700a6f01-c48b-4915-9fa4-56f9daf00e4d	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-05	f	0	\N	2026-06-21 02:54:41.413324+00	2026-06-21 02:54:41.413324+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
8c457150-e489-40b5-8808-e79a67915909	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-04-01	t	8000	\N	2026-04-25 08:30:50.718021+00	2026-04-25 08:30:50.718021+00	WORKOUT_COMPLETED	t	f	f	f	f	f	f	f
dd47391f-41f1-4cbc-ae90-16e003229c2f	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-04-03	t	8000	\N	2026-04-25 08:35:38.601634+00	2026-04-25 08:35:38.601634+00	WORKOUT_COMPLETED	t	f	f	f	f	f	f	f
8dd2d532-4330-442e-8cdc-7717dd4b5250	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-04-02	t	8000	\N	2026-04-25 08:31:10.884534+00	2026-04-26 13:10:20.648657+00	WORKOUT_COMPLETED	t	f	f	f	f	f	f	f
fc4fba28-cb52-466f-a7f3-91eecbc8c096	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-03	f	0	\N	2026-06-21 02:54:41.41197+00	2026-06-21 02:54:41.41197+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
1e224d0c-b5f3-4b86-9697-2e5817169a2b	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-07	f	0	\N	2026-06-21 02:54:41.423152+00	2026-06-21 02:54:41.423152+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
2464d7cb-1982-4573-92b1-ccace3833b84	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-06	f	0	\N	2026-06-21 02:54:41.424917+00	2026-06-21 02:54:41.424917+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
f445d9b6-d8c5-4f9c-a81b-8f4c8d42e686	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-19	t	4000	\N	2026-06-21 02:55:33.872435+00	2026-06-21 13:24:59.325653+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
39f9f6f2-b361-4192-9077-ef88e9fe4619	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-01	f	0	\N	2026-06-11 10:46:48.040026+00	2026-06-21 13:18:06.002542+00	WORKOUT_COMPLETED	f	f	f	f	t	f	f	f
cae81e4c-c626-4850-ab32-0f235122dda0	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-07	f	0	\N	2026-06-19 03:27:08.472998+00	2026-06-19 03:27:08.472998+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
57672750-81fd-4359-a925-4edd7009139d	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-01	f	0	\N	2026-06-21 02:54:41.439124+00	2026-06-21 02:54:41.439124+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
2a414f3c-d5b7-4462-9fc4-40dcb5721ccc	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-02	f	0	\N	2026-06-21 02:54:41.441097+00	2026-06-21 02:54:41.441097+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
697373c7-81c8-4f9c-bd66-278451efb55c	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-09	f	0	\N	2026-06-21 02:54:41.446927+00	2026-06-21 02:54:41.446927+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
6d16de7c-b5d5-4738-ab77-69db2eeec274	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-10	f	0	\N	2026-06-21 02:54:41.44936+00	2026-06-21 02:54:41.44936+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
232b91bf-ff22-4fdd-b3f8-620cf4bb3ead	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-12	f	0	\N	2026-06-21 02:54:41.462439+00	2026-06-21 02:54:41.462439+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
2894ccff-c5a7-4d02-a153-c6e8677c2c80	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-14	f	0	\N	2026-06-21 02:54:41.465081+00	2026-06-21 02:54:41.465081+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
919c78f0-3fd3-4b3d-9791-63e4623dfe5a	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-09	f	0	\N	2026-06-19 03:27:08.474399+00	2026-06-19 03:27:08.474399+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
e13b4bef-9d89-4fc6-8d5c-312a76db37d3	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-08	f	0	\N	2026-06-19 03:27:08.4746+00	2026-06-19 03:27:08.4746+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
17e33b60-d6ec-4522-b520-2625fbfdf9d4	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-15	f	0	\N	2026-06-21 02:54:41.475214+00	2026-06-21 02:54:41.475214+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
02abdb2b-9cbb-4013-a800-d2073ee738f3	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-18	f	0	\N	2026-06-21 02:55:30.153128+00	2026-06-21 02:55:30.153128+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
2acabfc2-864b-4d51-ba3d-3b71c79bdc71	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-07	f	0	\N	2026-06-21 03:15:51.094272+00	2026-06-21 03:15:51.094272+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
ba999540-8481-4b20-8e7d-bb93103e1ca5	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-08	f	0	\N	2026-06-21 03:15:51.11282+00	2026-06-21 03:15:51.11282+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
47491003-b213-4afe-a817-ec9bca5f2845	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-12	f	0	\N	2026-06-21 03:15:51.122618+00	2026-06-21 03:15:51.122618+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
3f4e05b6-0324-488b-a0b7-41624cddafe1	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-13	f	0	\N	2026-06-21 03:15:51.138199+00	2026-06-21 03:15:51.138199+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
ad28057e-6b76-480b-a771-3483b89d895c	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-14	f	0	\N	2026-06-21 03:15:51.169208+00	2026-06-21 03:15:51.169208+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
2212e3ae-9968-46ab-988f-56b1f5a46121	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-10	f	0	\N	2026-06-19 03:27:08.482267+00	2026-06-19 03:27:08.482267+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
a6134fe6-2c41-48ae-91ff-c5404026e698	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-11	f	0	\N	2026-06-19 03:27:08.482346+00	2026-06-19 03:27:08.482346+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
13462cd1-08a8-47d0-a1bd-763e77e79e96	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-20	f	0	\N	2026-06-21 03:15:51.186517+00	2026-06-21 03:15:51.186517+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
51c9c829-e330-437c-9e89-427994ab6429	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-10	t	6000	\N	2026-06-21 04:07:18.702255+00	2026-06-21 04:07:18.702255+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
dbd8f7f9-b7d0-47c6-a83b-e6920ecf7663	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-13	t	6000	\N	2026-06-21 04:07:50.689412+00	2026-06-21 04:07:50.689412+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
3a232a3a-7dfe-4f06-b0e4-ca48c1fe0b02	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-14	f	6000	\N	2026-06-21 04:07:58.762371+00	2026-06-21 04:08:57.458008+00	NO_ACTIVITY	t	f	t	f	f	f	f	f
1f5eb155-531f-4649-a417-a60fd02aa1ec	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-04	f	0	\N	2026-06-21 04:09:32.24464+00	2026-06-21 04:09:32.24464+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
3917660c-a064-42ab-8285-54e75d04feec	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-06	f	0	\N	2026-06-21 04:09:32.250701+00	2026-06-21 04:09:32.250701+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
daafe6c3-b74b-4ab7-a0ce-fbcbc0a7a381	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-06	f	3000	\N	2026-06-21 12:30:48.44182+00	2026-06-21 12:30:57.706244+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
01558bb7-ee4f-4938-af75-6429d7f14c60	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-07	f	3000	\N	2026-06-21 12:31:06.399621+00	2026-06-21 12:31:06.399621+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
71db5130-33ba-4d97-80ef-397eb1922e14	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-17	t	6000	\N	2026-06-21 02:40:48.952449+00	2026-06-21 04:43:37.478851+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
9309793a-3b7a-49b7-8e2b-7216450f33db	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-18	t	9000	\N	2026-06-21 02:40:59.603943+00	2026-06-21 04:43:43.946495+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
318ab0b9-feeb-4a1a-99c0-9da7fcd6f638	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-19	t	5000	\N	2026-06-21 02:43:57.298259+00	2026-06-21 04:43:54.420996+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
88199959-e19f-44c0-92eb-c58537fadac0	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-04	t	3000	\N	2026-06-21 12:29:01.199898+00	2026-06-21 12:29:01.199898+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
48584f59-4472-49a4-9920-670ec682ebf7	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-03	t	3000	\N	2026-06-21 12:29:01.199898+00	2026-06-21 12:29:01.199898+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
7c335bdf-6f45-45c5-b05c-0dacb50e1a90	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-02	t	3000	\N	2026-06-21 12:29:01.224607+00	2026-06-21 12:29:01.224607+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
80ab3616-7dbb-4d4f-bd57-c11ac74be646	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-08	t	3000	\N	2026-06-21 12:31:27.091919+00	2026-06-21 12:31:27.091919+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
2f677dd4-401d-4ffa-9fee-e9bbebfdc09c	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-11	t	3000	\N	2026-06-21 12:31:27.136668+00	2026-06-21 12:31:27.136668+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
3e796ce8-4c93-4c7c-ad8c-8cd6eab9257f	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-19	t	3000	\N	2026-06-21 12:31:38.519332+00	2026-06-21 12:31:38.519332+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
1037ceb1-f5d8-4907-b657-99343affb51e	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-15	t	3000	\N	2026-06-21 12:31:38.525487+00	2026-06-21 12:31:38.525487+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
d5b9dacd-2f68-4389-82f4-e57b34f1f6ed	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-03	f	0	\N	2026-06-11 10:47:49.96929+00	2026-06-21 13:18:05.994229+00	WORKOUT_COMPLETED	f	f	f	f	t	f	f	f
6ecc27c6-e012-4e65-a919-0f3065e7ff1a	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-16	t	9000	\N	2026-06-21 02:54:58.86301+00	2026-06-21 13:25:32.530156+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
2d1f027b-1d58-4c0e-8806-bb80d10a7336	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-17	t	8200	\N	2026-06-21 02:55:05.018772+00	2026-06-21 13:25:49.294478+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
3be34164-1d67-4f28-8e7e-68f357ff4d62	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-20	t	3500	\N	2026-06-21 02:55:37.318438+00	2026-06-21 13:26:03.664854+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
a155453d-e34c-471e-8b80-d04cd0a9f5c8	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-12	f	0	\N	2026-06-19 03:27:08.482635+00	2026-06-19 03:27:08.482635+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
529fb7a2-7012-471d-be22-c0c7e42b7e46	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-13	f	0	\N	2026-06-21 02:51:57.302511+00	2026-06-21 02:51:57.302511+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
4c044f72-6bf6-4659-b68b-8e193b6c4cf0	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-17	f	0	\N	2026-06-21 02:51:57.319962+00	2026-06-21 02:51:57.319962+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
94974638-6c88-459b-a52d-4f5f038188d5	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-18	f	0	\N	2026-06-21 02:51:57.329812+00	2026-06-21 02:51:57.329812+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
62a1e7ce-b753-430b-b178-626378d0b79c	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-21	f	0	\N	2026-06-21 02:51:57.341864+00	2026-06-21 02:51:57.341864+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
b74ee4bb-d27a-4d25-9fa8-8f67fa2401a9	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-08	f	0	\N	2026-06-21 02:54:41.415145+00	2026-06-21 02:54:41.415145+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
de8f1232-57c8-4ee1-852e-77dfffa75616	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-04	f	0	\N	2026-06-21 02:54:41.42673+00	2026-06-21 02:54:41.42673+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
bf22ac0b-b815-445b-9bd8-8e78e829ad7b	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-11	f	0	\N	2026-06-21 02:54:41.444887+00	2026-06-21 02:54:41.444887+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
cf1a77b9-f813-4336-8671-e7454e512b09	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-13	f	0	\N	2026-06-21 02:54:41.455343+00	2026-06-21 02:54:41.455343+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
1d610154-beda-40f6-b6b3-c5aafbb3c221	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-11	f	0	\N	2026-06-21 03:15:51.123757+00	2026-06-21 03:15:51.123757+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
9a9add4b-fe6b-49d4-8175-c86b8cc4ce72	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-18	f	0	\N	2026-06-21 03:15:51.161622+00	2026-06-21 03:15:51.161622+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
5741aeb7-373b-4fa6-ad1e-5d6099ff5a09	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-21	f	0	\N	2026-06-21 03:15:51.170733+00	2026-06-21 03:15:51.170733+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
33c62db3-d77c-42b3-8225-cb17865f222d	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-18	t	6000	\N	2026-06-21 04:08:27.686828+00	2026-06-21 04:08:34.942919+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
1853ecfd-6093-435b-aacf-91d0fc0a4059	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-19	t	6000	\N	2026-06-21 04:08:27.700277+00	2026-06-21 04:08:37.733444+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
fa71940c-ff37-42dc-98ba-6eac00e8765b	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-03	f	0	\N	2026-06-21 04:09:32.244741+00	2026-06-21 04:09:32.244741+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
b8d69e40-3a06-4a54-ad51-cd073d58442d	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-07	f	0	\N	2026-06-21 04:09:32.250965+00	2026-06-21 04:09:32.250965+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
cddf8325-095d-4230-a77b-ba35e09b325b	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-20	f	6000	\N	2026-06-21 04:17:30.12947+00	2026-06-21 04:44:02.022468+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
ffe8fec3-6487-47a7-b059-61fd180a6016	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-08	f	0	\N	2026-06-11 10:49:00.04188+00	2026-06-21 13:18:05.982644+00	WORKOUT_COMPLETED	f	f	f	f	t	f	f	f
b1dcb3b9-8b4d-40b0-b7cc-a2b04f09780f	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-04	f	0	\N	2026-06-11 10:48:10.095961+00	2026-06-21 13:18:06.025512+00	STEP_TARGET_ACHIEVED	f	f	f	f	t	f	f	f
afa09b17-01b9-4129-99cc-924d21fdaecb	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-11	f	0	\N	2026-06-11 10:49:39.418917+00	2026-06-21 13:18:06.020992+00	WORKOUT_COMPLETED	f	f	f	f	t	f	f	f
9cea470b-eacf-4ad4-90c6-4988afc28edd	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-10	f	0	\N	2026-06-11 10:49:18.276944+00	2026-06-21 13:18:06.012923+00	WORKOUT_COMPLETED	f	f	f	f	t	f	f	f
a628bf06-614d-4bd5-ac82-f80789275ed0	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-05	f	0	\N	2026-06-11 11:09:47.609774+00	2026-06-21 13:18:06.032254+00	STEP_TARGET_ACHIEVED	f	f	f	f	t	f	f	f
14258398-252b-470b-910c-a2b9f14936fa	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-06	f	0	\N	2026-06-11 11:11:43.908152+00	2026-06-21 13:18:06.035943+00	STEP_TARGET_ACHIEVED	f	f	f	f	t	f	f	f
eec350c3-b507-4b0c-a45d-cf1fc9d07e12	615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	2026-06-02	t	2000	\N	2026-06-14 07:00:46.785136+00	2026-06-14 07:00:46.785136+00	WORKOUT_COMPLETED	t	f	f	f	f	f	f	f
e25c6bf4-fbce-42ac-9339-7b242ae21151	615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	2026-06-03	t	2000	\N	2026-06-14 07:00:46.79266+00	2026-06-14 07:00:46.79266+00	WORKOUT_COMPLETED	t	f	f	f	f	f	f	f
320b1d4e-60f6-4904-93bb-f7b98ce3ebf3	615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	2026-06-01	t	2000	\N	2026-06-14 07:00:46.785171+00	2026-06-14 07:00:46.785171+00	WORKOUT_COMPLETED	t	f	f	f	f	f	f	f
3c5e7228-425c-4bf9-9200-a9783392cada	615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	2026-06-04	t	2000	\N	2026-06-14 07:00:46.84271+00	2026-06-14 07:00:46.84271+00	WORKOUT_COMPLETED	t	f	f	f	f	f	f	f
4e803c9a-8a0b-4f79-bd9c-7e01c289a058	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-01	t	8000	\N	2026-06-20 13:57:38.476916+00	2026-06-20 13:57:38.476916+00	WORKOUT_COMPLETED	t	f	f	f	f	f	f	f
fd75fc48-c30d-484d-8cbc-62b4a4175b24	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-02	t	8000	\N	2026-06-20 13:58:46.990515+00	2026-06-20 13:58:46.990515+00	WORKOUT_COMPLETED	t	f	f	f	f	f	f	f
7b4c12bb-e6a0-4717-9778-8c289fc32fd4	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-02	t	12000	\N	2026-06-21 08:52:15.560761+00	2026-06-21 08:53:08.092217+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
8157c3b4-e98f-4c8a-a7f5-73bcecc2ba17	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-03	t	12000	\N	2026-06-21 08:52:15.528116+00	2026-06-21 08:53:10.819058+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
ed25fe97-cc33-40c6-a56d-212099800240	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-04	t	12000	\N	2026-06-21 08:52:15.558396+00	2026-06-21 08:53:13.611289+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
7ac6b321-8822-4dbc-bc7a-4babf336b2e0	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-05	t	12000	\N	2026-06-21 08:52:15.52519+00	2026-06-21 08:53:16.043812+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
48126e1e-553e-456f-ad38-190f1a67bd0c	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-06	t	12000	\N	2026-06-21 08:52:15.56699+00	2026-06-21 08:53:18.520548+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
a49ec64e-55d7-4f81-8078-abcb10aa1fb6	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-12	f	0	\N	2026-06-21 08:53:36.15289+00	2026-06-21 08:53:36.15289+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
42dcc833-cc67-4acd-b0cd-19e879c3b228	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-07	f	0	\N	2026-06-21 08:53:36.152904+00	2026-06-21 08:53:36.152904+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
18fcd60c-ef36-4cfb-9a31-940f711e8d60	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-08	f	0	\N	2026-06-21 08:53:36.159666+00	2026-06-21 08:53:36.159666+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
05ca0f8f-8306-4d5d-ad5e-1faa71026b55	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-09	f	0	\N	2026-06-21 08:53:36.163777+00	2026-06-21 08:53:36.163777+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
e8a66b26-fd35-4a8a-afaf-bd3014527e77	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-13	f	0	\N	2026-06-21 08:53:36.173737+00	2026-06-21 08:53:36.173737+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
7951fcb9-6e11-40b3-9942-8773b37123d2	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-14	f	0	\N	2026-06-21 08:53:36.17492+00	2026-06-21 08:53:36.17492+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
161d8432-7811-4542-b941-ac24b2516673	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-17	t	12000	\N	2026-06-21 08:53:59.522448+00	2026-06-21 08:55:06.71578+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
7768e11c-96a8-4899-b4a0-1b8462823b54	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-19	t	12000	\N	2026-06-21 08:53:59.527297+00	2026-06-21 08:55:15.876658+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
3195c1a0-032a-4841-967a-56f5e2ce017e	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-20	t	12000	\N	2026-06-21 08:53:59.522581+00	2026-06-21 08:55:19.929182+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
7b2c97ba-7d21-4f44-8f63-1f9fe712bd46	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-12	t	3000	\N	2026-06-21 12:31:27.123746+00	2026-06-21 12:31:27.123746+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
de6cc6b3-ee92-41af-a8ff-4436236afbf6	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-16	t	12000	\N	2026-06-21 08:53:59.528043+00	2026-06-21 08:55:02.196458+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
77be46c4-1813-48f5-8068-51cd82adab34	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-18	t	3000	\N	2026-06-21 12:31:38.519466+00	2026-06-21 12:31:38.519466+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
49ddded3-734f-49ed-824f-08ae16f8bb5a	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-17	t	3000	\N	2026-06-21 12:31:38.525487+00	2026-06-21 12:31:38.525487+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
0fe85a82-126d-42bb-b3cd-618d667ccc52	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-13	f	3000	\N	2026-06-21 12:31:47.15032+00	2026-06-21 12:31:47.15032+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
435e3cd2-2229-4097-8832-2b79501f9ff6	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-14	f	3000	\N	2026-06-21 12:31:53.731385+00	2026-06-21 12:31:53.731385+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
f3560d06-a24d-42a0-ac41-d10f57674e60	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-20	f	3000	\N	2026-06-21 12:32:03.435629+00	2026-06-21 12:32:03.435629+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
260b2a22-4055-49d6-adf5-175cbb97e90a	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-15	f	0	\N	2026-06-19 03:27:08.490242+00	2026-06-19 03:27:08.490242+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
c72c76c9-0234-4c0b-b784-7b76da5e6b50	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-13	f	0	\N	2026-06-19 03:27:08.489633+00	2026-06-19 03:27:08.489633+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
464c8381-e39b-4dfe-b4b0-85a7c3ee5dbb	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-14	f	0	\N	2026-06-19 03:27:08.493098+00	2026-06-19 03:27:08.493098+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
977ce9a3-ab3e-4439-8043-b5eafaafe38d	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-15	f	0	\N	2026-06-21 02:51:57.314297+00	2026-06-21 02:51:57.314297+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
40277709-a10b-4f17-9f71-4c5b406ba529	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-16	f	0	\N	2026-06-21 02:51:57.327568+00	2026-06-21 02:51:57.327568+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
60c23a7f-c995-4741-b65f-788d18a51c62	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-19	f	0	\N	2026-06-21 02:51:57.335542+00	2026-06-21 02:51:57.335542+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
542ebb70-f91a-4df7-81ae-197080108021	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-07	f	10000	\N	2026-06-21 13:08:23.734535+00	2026-06-21 13:08:32.700547+00	NO_ACTIVITY	t	f	t	f	f	f	f	f
239efb60-6ac8-4fac-a3fd-79df00161181	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-11	t	7064	\N	2026-06-21 03:17:57.205747+00	2026-06-21 04:07:23.947281+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
3211fae5-25ac-4258-9e56-00541de15d97	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-12	t	6000	\N	2026-06-21 03:18:11.319307+00	2026-06-21 04:07:29.722781+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
b54114e6-d71c-4ae6-a808-a813169e6f9a	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-16	t	6000	\N	2026-06-21 03:18:28.097138+00	2026-06-21 04:08:27.697798+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
49d567f7-f34e-4275-b5c4-1d527f460a6b	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-17	t	6000	\N	2026-06-21 04:08:27.688314+00	2026-06-21 04:08:32.23081+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
3a14e1c9-3222-4295-a0d9-05bd54aa27e6	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-20	t	6000	\N	2026-06-21 04:08:27.840801+00	2026-06-21 04:08:40.399293+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
5a488c1f-78ac-47ef-b69c-1ac6f0d762ff	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-08	f	0	\N	2026-06-21 04:08:52.65848+00	2026-06-21 04:08:52.65848+00	NO_ACTIVITY	f	f	t	f	f	f	f	f
c8a4fb0a-79a3-425d-9fdb-fcdf4ecd5480	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-15	f	6000	\N	2026-06-21 04:09:07.049083+00	2026-06-21 04:09:07.049083+00	NO_ACTIVITY	f	f	t	f	f	f	f	f
cff227de-474d-438d-b41b-7a0a5dca4375	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-05	f	0	\N	2026-06-21 04:09:32.245178+00	2026-06-21 04:09:32.245178+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
ed6a5d8c-d9bf-4e30-a772-213650067b13	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-08	t	10000	\N	2026-06-21 13:08:46.828431+00	2026-06-21 13:08:46.828431+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
f7c2fcc2-6e2e-4231-a847-b7b91182aad2	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-01	t	12000	\N	2026-06-21 08:52:15.569888+00	2026-06-21 08:53:04.791006+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
e7d45b59-aca9-4edd-b3fd-9daf8ccb7c3c	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-10	f	0	\N	2026-06-21 08:53:36.155553+00	2026-06-21 08:53:36.155553+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
391b63a3-94c1-46e0-bc79-068ee085ffd8	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-11	f	0	\N	2026-06-21 08:53:36.163764+00	2026-06-21 08:53:36.163764+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
66e3bf7c-c572-481c-82a4-b383376e3412	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-09	t	10000	\N	2026-06-21 13:08:53.907427+00	2026-06-21 13:08:53.907427+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
7051f516-e991-45dc-9b6b-2455cb53e15a	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-10	t	10000	\N	2026-06-21 13:09:03.884617+00	2026-06-21 13:09:03.884617+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
4c17d0b1-70bc-4358-b294-082911183bce	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-15	t	12000	\N	2026-06-21 08:53:59.529024+00	2026-06-21 08:54:57.049656+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
994fe316-bff2-4299-9e45-87088d0784c1	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-18	t	12000	\N	2026-06-21 08:53:59.522318+00	2026-06-21 08:55:11.194373+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
e41424a0-bc34-4110-94f0-39734c66459b	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-09	t	3000	\N	2026-06-21 03:09:38.902445+00	2026-06-21 12:31:27.108084+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
7fbfbaaa-8c7c-4f96-9021-e6f68686c119	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-10	t	3000	\N	2026-06-21 03:09:24.493878+00	2026-06-21 12:31:27.1149+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
c17a6fc3-1844-4c2e-91a7-0ace08064c36	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-16	t	3000	\N	2026-06-21 12:31:38.519466+00	2026-06-21 12:31:38.519466+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
b3a12b43-1ed3-43d1-89ff-657991709c5f	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-03	f	3000	\N	2026-06-20 14:09:20.992895+00	2026-06-21 12:33:00.733489+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
84bbbc09-d599-4537-9d16-2a808908553e	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-11	f	0	\N	2026-06-21 13:09:09.735304+00	2026-06-21 13:09:09.735304+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
cd1ddb5c-6312-4ed2-937b-e03da478e8ca	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-12	f	0	\N	2026-06-21 13:09:12.337954+00	2026-06-21 13:09:12.337954+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
d693c22f-4d31-4477-9bd0-49516ad207d4	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-07	f	3000	\N	2026-06-20 14:09:21.024376+00	2026-06-21 12:33:41.496641+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
eb77ecee-1dbb-45fa-b862-180ee5b161b4	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-13	f	3000	\N	2026-06-20 14:09:21.051736+00	2026-06-21 12:33:57.974985+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
3f26efd3-cf2d-4081-9554-b3cd8f02f35e	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-14	f	3000	\N	2026-06-20 14:09:21.028771+00	2026-06-21 12:34:00.732694+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
cb6f6daa-423b-4963-8776-ea2ff193f73f	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-01	f	10000	\N	2026-06-21 13:01:05.750028+00	2026-06-21 13:07:16.689336+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
c1fa605a-b5dc-45b8-a21b-59bd8a2558f3	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-02	t	10000	\N	2026-06-21 13:07:37.204976+00	2026-06-21 13:07:37.204976+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
bce57953-3b5c-42e3-9694-c2550e1f6e10	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-03	t	10000	\N	2026-06-21 13:07:56.298156+00	2026-06-21 13:07:56.298156+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
b55b7032-551a-407f-ab56-24689e7625f5	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-04	t	10000	\N	2026-06-21 13:08:03.182746+00	2026-06-21 13:08:03.182746+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
c71726f6-e273-4c82-b579-f95376dea476	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-05	t	10000	\N	2026-06-21 13:08:09.505266+00	2026-06-21 13:08:09.505266+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
8f05a972-532d-4ae6-bad3-d147513b7d7b	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-06	t	10000	\N	2026-06-21 13:08:15.727934+00	2026-06-21 13:08:15.727934+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
a64f3f62-d867-445e-a80c-0b0833719466	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-13	f	0	\N	2026-06-21 13:09:18.108777+00	2026-06-21 13:09:18.108777+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
da8e6989-892c-48a9-8c13-dc41bef29dfb	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-14	f	0	\N	2026-06-21 13:09:22.586185+00	2026-06-21 13:09:22.586185+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
02944127-2034-436a-9d75-a2f20b7056fc	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-15	f	10000	\N	2026-06-21 13:09:43.740077+00	2026-06-21 13:09:43.740077+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
09768a4a-acbb-4ec8-8f5f-c6868fad7c89	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-16	f	10000	\N	2026-06-21 13:09:50.218737+00	2026-06-21 13:09:50.218737+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
238196cd-a3fc-4740-ab93-e9f566b540ef	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-17	t	10000	\N	2026-06-21 13:09:57.227753+00	2026-06-21 13:09:57.227753+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
8cff27ec-f2f2-424e-9a8a-f1d52b3d27b0	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-18	f	10000	\N	2026-06-21 13:10:04.205625+00	2026-06-21 13:10:04.205625+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
d37b1665-0978-4cf6-989c-41bbd30fdeee	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-19	f	10000	\N	2026-06-21 13:10:11.643849+00	2026-06-21 13:10:11.643849+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
eb91d8e0-aaa3-47b5-9152-b18e21d4c963	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-20	f	10000	\N	2026-06-21 13:10:17.478306+00	2026-06-21 13:10:17.478306+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
86f99a51-4724-4133-b124-478824074211	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-07	f	0	\N	2026-06-11 11:11:50.586191+00	2026-06-21 13:18:05.970113+00	STEP_TARGET_ACHIEVED	f	f	f	f	t	f	f	f
09cdee07-b2fd-471f-a315-e3c7fae276c6	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-02	f	0	\N	2026-06-11 10:47:39.644364+00	2026-06-21 13:18:06.003966+00	WORKOUT_COMPLETED	f	f	f	f	t	f	f	f
4c352739-6432-4d9a-88cf-909cd2b7c3e2	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-09	f	0	\N	2026-06-11 10:49:13.32775+00	2026-06-21 13:18:06.013189+00	WORKOUT_COMPLETED	f	f	f	f	t	f	f	f
10243185-de88-46c4-9390-109c27088c2c	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-15	f	0	\N	2026-06-21 13:18:36.089069+00	2026-06-21 13:18:36.089069+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
98f03d35-745f-4bcc-847f-7b3cd8f5cb3a	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-16	t	9000	\N	2026-06-21 13:19:00.732669+00	2026-06-21 13:19:00.732669+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
1f377cb0-68e6-4924-87ee-6918839db49d	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-17	t	8200	\N	2026-06-21 13:19:08.882043+00	2026-06-21 13:19:08.882043+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
e324312b-8d39-4413-904e-92b757a1384e	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-18	f	0	\N	2026-06-21 13:19:18.958043+00	2026-06-21 13:19:18.958043+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
d2d63828-4338-4136-b54d-7aff9073a4da	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-19	t	4000	\N	2026-06-21 13:19:32.003128+00	2026-06-21 13:19:32.003128+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
e6c147c7-6ae8-4fbe-bde4-e4449e2e4e61	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-20	t	3500	\N	2026-06-21 13:19:39.995154+00	2026-06-21 13:19:39.995154+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
52a7f159-e6dc-4b28-8991-34b5bc996d4e	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-21	f	0	\N	2026-06-21 13:19:53.349299+00	2026-06-21 13:19:53.349299+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
bd849d4c-7c13-44c0-a52f-10b8878f5d26	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-21	f	0	\N	2026-06-21 13:26:21.741108+00	2026-06-21 13:26:21.741108+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
24e61ac9-5e48-4e2f-83cd-434f4ddc3204	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-16	f	0	\N	2026-06-19 03:27:08.499625+00	2026-06-19 03:27:08.499625+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
36a3acd1-ab6f-4530-b12e-abd03ba382ef	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-12	f	0	\N	2026-06-11 11:14:23.473847+00	2026-06-11 11:14:23.473847+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
5a42cd53-756b-4f82-8b18-e391bdad83eb	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-14	f	0	\N	2026-06-11 11:12:25.324764+00	2026-06-11 11:14:23.486988+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
983d2b1f-add0-46be-9b81-88fec9a36eb0	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-13	f	0	\N	2026-06-11 11:12:25.336115+00	2026-06-11 11:14:23.496992+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
50114177-94c6-4268-a828-86257a33fbd8	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-01	f	0	\N	2026-06-11 12:24:40.746666+00	2026-06-11 12:24:40.746666+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
6241154c-2ea9-49ed-b40a-40cb0b317161	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-04	f	0	\N	2026-06-11 12:24:40.746711+00	2026-06-11 12:24:40.746711+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
21366b30-716e-4f9a-b5d5-166cd85e52c1	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-05	f	0	\N	2026-06-11 12:24:40.778186+00	2026-06-11 12:24:40.778186+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
d4241e98-73e9-489b-99e9-058bf5c976ac	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-06	f	0	\N	2026-06-11 12:24:40.787655+00	2026-06-11 12:24:40.787655+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
bfb5fd17-0ec4-41db-9c00-280de64aaff7	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-03	f	0	\N	2026-06-11 12:24:40.787758+00	2026-06-11 12:24:40.787758+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
7a9222b6-445c-4cc8-ba38-e631a4c49a14	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-02	f	0	\N	2026-06-11 12:24:40.790429+00	2026-06-11 12:24:40.790429+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
d02c9ddc-623f-4e3d-9e4b-7098e109bdd5	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-08	f	0	\N	2026-06-11 12:24:40.814859+00	2026-06-11 12:24:40.814859+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
63ff9c9a-f607-4017-9391-ba25beb39319	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-09	f	0	\N	2026-06-11 12:24:40.81639+00	2026-06-11 12:24:40.81639+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
fc8de12d-86a2-411c-8e3d-55f0edad747b	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-07	f	0	\N	2026-06-11 12:24:40.82733+00	2026-06-11 12:24:40.82733+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
fc7ba12e-b28b-4af9-bfd6-d1d633935867	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-10	f	0	\N	2026-06-11 12:24:40.826513+00	2026-06-11 12:24:40.826513+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
bb3fc026-01c3-4303-85e7-4e55ca727931	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-11	f	0	\N	2026-06-11 12:24:40.850856+00	2026-06-11 12:24:40.850856+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
dcdf743f-2808-4bdc-a690-8f2f8c3e1825	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-04	f	0	\N	2026-06-19 03:27:08.417227+00	2026-06-19 03:27:08.417227+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
5239490e-8ddf-4a0e-ba02-ecde91270da2	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-06	f	0	\N	2026-06-19 03:27:08.417228+00	2026-06-19 03:27:08.417228+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
4dc4e9b0-16df-4ba3-ac90-7107e6870250	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-03	f	0	\N	2026-06-19 03:27:08.417227+00	2026-06-19 03:27:08.417227+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
4b37540a-8ffb-4e9d-8d80-b0bd1aef2cc5	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-01	f	0	\N	2026-06-19 03:27:08.462883+00	2026-06-19 03:27:08.462883+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
94af474f-7604-45a6-9aca-95afa62c30cf	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-02	f	0	\N	2026-06-19 03:27:08.463126+00	2026-06-19 03:27:08.463126+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
b03a489b-a33d-454a-bdd4-a590af34acb7	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-05	f	0	\N	2026-06-19 03:27:08.463366+00	2026-06-19 03:27:08.463366+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
2bf7b153-d5e9-45a9-86c8-a8c565c5a49e	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-19	f	0	\N	2026-06-19 03:27:08.502745+00	2026-06-19 03:27:08.502745+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
bd5ba810-22d3-4004-80ab-8c743717c18a	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-17	f	0	\N	2026-06-19 03:27:08.504842+00	2026-06-19 03:27:08.504842+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
d7c00e0f-9792-47fe-9b1e-923fa9273727	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	2026-06-18	f	0	\N	2026-06-19 03:27:08.508089+00	2026-06-19 03:27:08.508089+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
484191ed-2b6d-4e95-8f8b-d5451127dba1	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-12	f	3000	\N	2026-06-20 14:09:21.013318+00	2026-06-21 12:33:55.566404+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
75cd0e35-a260-46a1-8825-7c3dc06b90f6	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-14	f	0	\N	2026-06-21 02:51:57.320255+00	2026-06-21 02:51:57.320255+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
60f267f9-093a-4beb-9425-dd007604212a	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-12	f	0	\N	2026-06-21 02:51:57.341965+00	2026-06-21 02:51:57.341965+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
26df5956-70e1-483b-b16a-6a21fb108850	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-20	f	0	\N	2026-06-21 02:51:57.35145+00	2026-06-21 02:51:57.35145+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
a3de9156-e723-4990-a3e9-a5adf22b5e8a	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-01	t	0	\N	2026-06-21 03:14:27.516398+00	2026-06-21 03:14:27.516398+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
9f62823d-bdbf-4a51-9088-54561841f354	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-02	t	0	\N	2026-06-21 03:14:30.783718+00	2026-06-21 03:14:30.783718+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
8b6f784f-8524-4a10-8900-cf00c1b54ff7	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-04	t	0	\N	2026-06-21 03:14:34.277154+00	2026-06-21 03:14:34.277154+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
25922238-ed4a-45e8-8c1c-7e5a54b06c10	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-05	t	0	\N	2026-06-21 03:14:47.53054+00	2026-06-21 03:14:47.53054+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
6a238e56-f709-4298-a0e4-1067e84a9f73	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-03	f	0	\N	2026-06-21 03:15:25.369116+00	2026-06-21 03:15:25.369116+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
b5ce4f92-6c37-4023-9e6c-3e604ea79490	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-06	f	0	\N	2026-06-21 03:15:51.094036+00	2026-06-21 03:15:51.094036+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
0a82ce8f-0f0a-4168-9ab0-885db3bcb865	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-10	f	0	\N	2026-06-21 03:15:51.105861+00	2026-06-21 03:15:51.105861+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
9feee3f8-8f8a-4164-a8ab-57ad5e527d7d	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-09	f	0	\N	2026-06-21 03:15:51.117192+00	2026-06-21 03:15:51.117192+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
af6d96a2-9a51-4601-a823-ff1d221ed80d	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-16	f	0	\N	2026-06-21 03:15:51.128492+00	2026-06-21 03:15:51.128492+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
26ff92a7-758e-4740-96ad-86ae29132b2c	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-15	f	0	\N	2026-06-21 03:15:51.146205+00	2026-06-21 03:15:51.146205+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
96a0a565-ca5e-47ca-be2f-99d30aac8ff8	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-17	f	0	\N	2026-06-21 03:15:51.16977+00	2026-06-21 03:15:51.16977+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
1a85b8a4-1ea3-4741-b524-0d25912f09d0	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-19	f	0	\N	2026-06-21 03:15:51.189032+00	2026-06-21 03:15:51.189032+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
32e461e1-c286-43cb-b0bf-bf055b702dab	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-01	t	0	\N	2026-06-21 04:01:41.966552+00	2026-06-21 04:01:41.966552+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
071e6cd6-085f-4dee-960b-cf73fff52edc	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-02	t	0	\N	2026-06-21 04:01:45.962767+00	2026-06-21 04:01:45.962767+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
15a18db1-7484-4b2a-9836-c4b320969361	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-09	t	6000	\N	2026-06-21 04:07:11.285833+00	2026-06-21 04:07:11.285833+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
b8f077bd-19a6-4a20-9c96-da2d899ca446	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-06	f	3000	\N	2026-06-20 14:09:20.900976+00	2026-06-21 12:33:38.228639+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
5bb2d617-3449-4e88-b693-c1e186ec4a0c	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-05	f	3000	\N	2026-06-20 14:09:20.992812+00	2026-06-21 12:33:35.64429+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
16e9bf33-241e-4e95-b80e-f3c92a6f4e40	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-15	f	3000	\N	2026-06-20 14:09:21.03175+00	2026-06-21 12:34:07.368178+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
d408bbad-5bdc-4163-bd72-9628dbe61e2d	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-16	f	3000	\N	2026-06-20 14:09:21.052011+00	2026-06-21 12:34:09.997294+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
05a1ffab-38b9-4faa-aaad-357c9e7c2b79	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-10	f	3000	\N	2026-06-20 14:09:20.992974+00	2026-06-21 12:33:50.406793+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
094e0308-3dc4-4052-bd5e-bfb22025a1d9	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-11	f	3000	\N	2026-06-20 14:09:21.016594+00	2026-06-21 12:33:52.914447+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
375a9b9b-624e-4690-9087-54fbab593e40	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-04	f	3000	\N	2026-06-20 14:09:21.008593+00	2026-06-21 12:33:31.831534+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
18d54ff8-f4b6-41ff-b0f3-d51349bb8c97	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-08	f	3000	\N	2026-06-20 14:09:20.900985+00	2026-06-21 12:33:44.125087+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
3d96336c-ae86-41d4-9026-b14b64c7f1b8	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-09	f	3000	\N	2026-06-20 14:09:20.901125+00	2026-06-21 12:33:46.895083+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
a197ddd0-a178-4ba2-9487-73121c8277f1	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-11	t	10000	\N	2026-06-21 13:30:24.889527+00	2026-06-21 13:30:24.889527+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
e1d9e010-c2be-4f70-861b-53bac323ff5e	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-01	f	10000	\N	2026-06-21 13:30:08.951328+00	2026-06-21 13:31:20.455179+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
d718fd05-cdfc-4dbe-93db-93b73febe64d	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-03	f	10000	\N	2026-06-21 13:30:08.957915+00	2026-06-21 13:31:20.460572+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
756e1f40-dcaf-4383-b0ce-b0128abc5bf7	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-04	f	10000	\N	2026-06-21 13:30:08.962177+00	2026-06-21 13:31:20.468767+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
6041d6af-f344-4e44-a20c-6c20f61a7fc6	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-06	f	10000	\N	2026-06-21 13:30:08.946241+00	2026-06-21 13:31:20.472993+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
123f1ddb-fb40-428a-a7b7-83b276350b3b	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-02	f	10000	\N	2026-06-21 13:30:08.965666+00	2026-06-21 13:31:20.477461+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
6063d488-f92a-4476-9f2e-4116e46da510	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-05	f	10000	\N	2026-06-21 13:30:08.961143+00	2026-06-21 13:31:20.479025+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
784316fe-c91b-46c7-b466-e64466d32d45	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-07	f	10000	\N	2026-06-21 13:30:08.967556+00	2026-06-21 13:31:20.485704+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
3f5c01bf-0d9a-4d61-be0c-0f8438bf1270	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-09	f	10000	\N	2026-06-21 13:30:08.970484+00	2026-06-21 13:31:20.485901+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
ff6c8134-5773-487a-b9f6-28746360b36f	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-10	f	10000	\N	2026-06-21 13:30:08.97707+00	2026-06-21 13:31:20.493148+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
f3e17cb2-e5d9-427b-9c6c-23eb48f559bc	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-08	f	10000	\N	2026-06-21 13:30:08.976028+00	2026-06-21 13:31:20.492715+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
92e9645b-22dc-4bc6-9b8f-95bf1197af57	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-14	f	10000	\N	2026-06-21 13:31:48.729815+00	2026-06-21 13:31:48.729815+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
66432cdb-9dea-4731-940e-c9e376a2d69d	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-12	f	10000	\N	2026-06-21 13:31:48.72984+00	2026-06-21 13:31:48.72984+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
eab09b59-8073-4a49-9492-4eff5ca92a12	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-16	f	10000	\N	2026-06-21 13:31:48.734823+00	2026-06-21 13:31:48.734823+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
dbe96704-b67c-461c-80a6-b697c5838d13	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-15	f	10000	\N	2026-06-21 13:31:48.738097+00	2026-06-21 13:31:48.738097+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
cca71efb-ec85-41f7-98bc-a7a91ea2651c	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-20	f	10000	\N	2026-06-21 13:31:48.740409+00	2026-06-21 13:31:48.740409+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
61da41d9-b36f-44c9-ab84-d71b4c8ca2a2	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-13	f	10000	\N	2026-06-21 13:31:48.742318+00	2026-06-21 13:31:48.742318+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
0e9a6a48-98fc-402a-be61-6ccd168a4592	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-18	f	10000	\N	2026-06-21 13:31:48.750302+00	2026-06-21 13:31:48.750302+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
61c13a7c-eb38-462b-a32d-dccc2111e1a9	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-19	f	10000	\N	2026-06-21 13:31:48.750134+00	2026-06-21 13:31:48.750134+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
a55f1d56-4338-4ce6-b455-d1d121c465a0	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-17	f	10000	\N	2026-06-21 13:31:48.753347+00	2026-06-21 13:31:48.753347+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
f837c870-9106-4a86-8e2d-f922bd61d9c0	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-01	t	0	\N	2026-06-21 13:41:22.101755+00	2026-06-21 13:41:22.101755+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
d2c802c0-61ec-489e-a3ed-fc88cf960867	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-02	t	0	\N	2026-06-21 13:41:24.854114+00	2026-06-21 13:41:24.854114+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
82f21035-f308-4ab2-b4e5-55fcfd6f6651	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-18	t	0	\N	2026-06-21 13:42:02.677523+00	2026-06-21 13:42:02.677523+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
5286cb7c-53ef-4f5a-aba5-1909a90b538e	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-05	f	0	\N	2026-06-21 13:42:19.386644+00	2026-06-21 13:42:19.386644+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
33a6fa9c-1d78-4c30-9f19-4a736f77e016	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-04	f	0	\N	2026-06-21 13:42:19.386511+00	2026-06-21 13:42:19.386511+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
54eb7e06-79a4-4303-b17a-bbf4b6a751d9	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-06	f	0	\N	2026-06-21 13:42:19.387902+00	2026-06-21 13:42:19.387902+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
248e9077-a5a1-40b1-afe8-dba7f4981551	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-03	f	0	\N	2026-06-21 13:42:19.392906+00	2026-06-21 13:42:19.392906+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
40e15c4d-20ed-4048-8483-861339dfaceb	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-07	f	0	\N	2026-06-21 13:42:19.395098+00	2026-06-21 13:42:19.395098+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
675fe4dd-b333-4703-9345-22bb68bda8cf	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-08	f	0	\N	2026-06-21 13:42:19.395379+00	2026-06-21 13:42:19.395379+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
31dd61d9-4c50-4dde-ab75-846848ae6ac9	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-09	f	0	\N	2026-06-21 13:42:19.408562+00	2026-06-21 13:42:19.408562+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
618d9cca-ab4f-4b3f-927d-44430d0af3f8	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-11	f	0	\N	2026-06-21 13:42:19.410727+00	2026-06-21 13:42:19.410727+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
d7bcc526-e1de-4c4d-a4d7-9fa68734a920	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-13	f	0	\N	2026-06-21 13:42:19.412665+00	2026-06-21 13:42:19.412665+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
0c61987b-696d-42ac-9279-a134ab74c279	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-12	f	0	\N	2026-06-21 13:42:19.41689+00	2026-06-21 13:42:19.41689+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
7c25592b-c90c-4d95-b5de-a1ed315153a6	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-10	f	0	\N	2026-06-21 13:42:19.420735+00	2026-06-21 13:42:19.420735+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
19fdd98b-df38-4aaf-aede-d58bb9870357	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-15	f	0	\N	2026-06-21 13:42:19.424898+00	2026-06-21 13:42:19.424898+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
1eef564b-05c4-4404-b0a3-04cee3cae1d8	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-14	f	0	\N	2026-06-21 13:42:19.424898+00	2026-06-21 13:42:19.424898+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
3fe11364-ebc3-4ccf-8742-e8f99a99ce83	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-16	f	0	\N	2026-06-21 13:42:19.429981+00	2026-06-21 13:42:19.429981+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
769eddc7-ff59-4fbf-a727-a3fe0f1440a2	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-17	f	0	\N	2026-06-21 13:42:19.436221+00	2026-06-21 13:42:19.436221+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
228c007e-f5a8-4828-88b7-a7307bb35050	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-19	f	6874	\N	2026-06-21 13:42:36.868664+00	2026-06-21 13:42:36.868664+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
ec3b6683-adc5-4d87-88d9-d0d9f3ffef7e	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-20	f	0	\N	2026-06-21 13:42:55.516039+00	2026-06-21 13:42:55.516039+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
6bb1eb85-c512-48cf-a566-a176e6a7a006	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-21	f	0	\N	2026-06-21 13:42:55.515036+00	2026-06-21 13:42:55.515036+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
5f31b329-25a9-4a6f-8a4c-8bca20f4dda4	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-21	t	0	\N	2026-06-22 04:12:17.827749+00	2026-06-22 04:12:17.827749+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
d649db44-76d8-4d9a-9d33-40f672be74f5	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-22	t	0	\N	2026-06-23 03:44:46.34878+00	2026-06-23 03:44:46.34878+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
9c3461ad-1f7d-4188-906a-683a9be7abc4	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-23	t	7500	\N	2026-06-24 03:44:27.994314+00	2026-06-24 03:44:27.994314+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
4aa6e046-52ca-4d5f-a3c9-9978cba44154	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-23	t	5503	\N	2026-06-24 03:49:20.840975+00	2026-06-24 03:49:20.840975+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
f22eb356-ad7c-400b-9621-2fc230c89351	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-23	t	10884	\N	2026-06-24 04:13:04.826863+00	2026-06-24 04:13:04.826863+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
649b4bb7-6900-47dd-9fe3-a840c3b8ed76	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-23	t	0	\N	2026-06-24 12:49:41.999203+00	2026-06-24 12:49:41.999203+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
ce21de4a-7b4f-4a4c-9fe8-e7c647befe60	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-22	f	0	\N	2026-06-24 12:50:13.319363+00	2026-06-24 12:50:13.319363+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
7fea7e9b-440c-4d63-9b33-f558183618e3	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-22	t	10833	\N	2026-06-23 03:44:10.688438+00	2026-06-24 12:53:30.681737+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
bc8a2ca1-fa0c-4574-9ad0-1b57cbaf857a	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-21	f	12406	\N	2026-06-24 12:52:33.553581+00	2026-06-24 12:53:15.419961+00	NO_ACTIVITY	t	f	t	f	f	f	f	f
37a2c645-a4ce-4125-807c-b2df955780c5	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-23	t	8000	\N	2026-06-24 12:54:13.278688+00	2026-06-24 12:54:13.278688+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
db3c2003-cd57-4466-ab6e-71a6858b795e	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-21	f	8000	\N	2026-06-23 03:43:20.062991+00	2026-06-24 12:54:32.164536+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
a6a1b545-f866-441b-8628-588d72dff3db	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-22	t	8000	\N	2026-06-23 03:43:28.43681+00	2026-06-24 12:54:57.790803+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
09692117-dfe9-4d0b-8381-7e1e373f0286	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-22	f	2000	\N	2026-06-24 13:02:53.563517+00	2026-06-24 13:03:08.093065+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
865329f1-f507-43d6-b063-4d0142ba8d07	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-24	t	0	\N	2026-06-25 03:26:26.341719+00	2026-06-25 03:26:26.341719+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
fe944f35-04b6-4dd6-a826-646636bbb765	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-24	t	12351	\N	2026-06-25 03:12:45.364748+00	2026-06-25 03:49:35.011056+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
a28e58cc-8cba-44a8-8265-90331cc2d29a	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-24	t	8000	\N	2026-06-25 06:45:32.174772+00	2026-06-25 06:45:32.174772+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
896335b4-4731-4486-84d7-741daca79513	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-24	f	0	\N	2026-06-25 07:42:05.239327+00	2026-06-25 07:42:05.239327+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
55f60eb2-a092-44f5-ba4f-0cf29e881dd2	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-24	f	0	\N	2026-06-26 03:29:16.561147+00	2026-06-26 03:29:16.561147+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
b15ac0ba-56a2-4865-8a41-52929fa4652b	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-25	t	8183	\N	2026-06-26 03:32:12.579716+00	2026-06-26 03:32:12.579716+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
03358c50-5bcf-49ab-b223-efb0cfb21299	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-25	t	8000	\N	2026-06-26 03:39:14.06555+00	2026-06-26 03:39:14.06555+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
d0f184d1-77d5-4d07-b9a6-2e26cc99aa32	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-23	f	0	\N	2026-06-26 03:39:34.141743+00	2026-06-26 03:39:34.141743+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
99be1411-782c-42f9-900f-03f13db05531	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-22	f	0	\N	2026-06-26 03:39:34.143854+00	2026-06-26 03:39:34.143854+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
d19d44aa-c5b2-485c-b9e8-f1199a63a3ae	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-24	f	0	\N	2026-06-26 03:39:34.148307+00	2026-06-26 03:39:34.148307+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
53ad558f-22cf-4bd5-a52d-10c63cc82dc5	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-21	f	0	\N	2026-06-26 03:39:34.15366+00	2026-06-26 03:39:34.15366+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
b57fa8af-981b-4d78-a017-76d758e2aff8	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-25	t	8000	\N	2026-06-26 03:45:58.894786+00	2026-06-26 03:45:58.894786+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
d3ef30d2-c327-4db7-b525-4bfbbfca8360	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-24	f	0	\N	2026-06-26 04:24:59.963379+00	2026-06-26 04:24:59.963379+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
960f1529-c36f-46cb-a1cc-49195f012e1d	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-25	t	5731	\N	2026-06-26 04:25:12.012584+00	2026-06-26 04:25:12.012584+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
7e03155b-62cf-4bdb-81f5-ac93d6b0926e	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-25	t	4628	\N	2026-06-26 04:26:09.026327+00	2026-06-26 04:26:09.026327+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
cc068c19-4542-4b0b-af36-8a31ecd6ae89	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-24	f	0	\N	2026-06-26 04:26:28.239583+00	2026-06-26 04:26:28.239583+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
b6df8c04-4b44-41ba-91e4-b8f2eb5d8d80	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-23	f	0	\N	2026-06-26 04:26:28.242268+00	2026-06-26 04:26:28.242268+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
fd56b619-4b8a-4287-87ec-f6d11ecca6e1	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-22	f	0	\N	2026-06-26 04:26:28.254836+00	2026-06-26 04:26:28.254836+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
ce712073-3bd5-4411-9379-313aa76b97fa	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-22	f	0	\N	2026-06-28 08:13:06.493518+00	2026-06-28 08:13:06.493518+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
05a5f10d-adb0-4a7e-951f-e67706d016ab	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-26	f	0	\N	2026-06-28 08:13:06.493861+00	2026-06-28 08:13:06.493861+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
70bb816e-db48-46a2-9fd2-03529cd900df	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-25	f	0	\N	2026-06-28 08:13:06.494888+00	2026-06-28 08:13:06.494888+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
b99d4be6-0270-4058-81b1-37b7659c5a23	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-25	f	12160	\N	2026-06-26 03:49:35.275688+00	2026-06-27 04:14:53.38321+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
e7461225-ccf8-40c4-a36c-8e75e151956c	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-26	t	8000	\N	2026-06-27 04:16:10.10108+00	2026-06-27 04:16:10.10108+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
50d40b58-9d33-43c8-a0b0-8c7cdd82447f	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-26	t	10304	\N	2026-06-27 04:24:55.902574+00	2026-06-27 04:24:55.902574+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
0bb74303-8d48-4256-bf38-ff7da59b5295	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-25	f	0	\N	2026-06-27 04:25:32.244321+00	2026-06-27 04:25:32.244321+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
3b3ebae3-d911-4c8d-9b86-221c878f861d	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-24	f	0	\N	2026-06-27 04:25:32.250551+00	2026-06-27 04:25:32.250551+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
43b6209e-44d6-41bd-b4c0-93ba465ff32a	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-23	f	0	\N	2026-06-27 04:25:32.258499+00	2026-06-27 04:25:32.258499+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
91c3ee60-45b5-4cc2-b86d-922d95fe2bab	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-26	t	0	\N	2026-06-27 04:32:42.447478+00	2026-06-27 04:32:42.447478+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
6c3fe07d-e749-438d-8180-485321440e83	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-22	f	0	\N	2026-06-27 04:32:51.245904+00	2026-06-27 04:32:51.245904+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
09fbd9bf-17f5-4afc-8c5f-6f487bf55722	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-23	f	0	\N	2026-06-27 04:32:53.907203+00	2026-06-27 04:32:53.907203+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
7c1a079e-3f14-4b86-a91f-0537aea8910a	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-25	f	0	\N	2026-06-27 04:32:57.17812+00	2026-06-27 04:32:57.17812+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
565e16c5-c318-418b-b1a8-af2f5c06719e	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-26	t	11823	\N	2026-06-27 04:15:16.147458+00	2026-06-27 07:14:37.4028+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
d99dc6bd-77ec-4696-b6dc-065401cc47d3	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-25	t	6385	\N	2026-06-25 07:42:25.696713+00	2026-06-27 07:33:41.754651+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
71145e4f-841f-4953-b315-63fe6f1437cc	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-26	t	6272	\N	2026-06-27 03:49:50.036292+00	2026-06-27 07:33:56.528896+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
86c52b46-7d5a-4658-bd80-6e0e323b1d6b	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-27	t	8000	\N	2026-06-28 07:23:43.532655+00	2026-06-28 07:23:43.532655+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
07ed818b-a443-4339-9d52-597081949984	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-21	f	0	\N	2026-06-28 07:33:40.503179+00	2026-06-28 07:33:40.503179+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
07e6737d-ed08-4f42-897c-5a3153a05e34	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-22	f	0	\N	2026-06-28 07:33:48.338378+00	2026-06-28 07:33:48.338378+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
8ae6872b-11ca-42d0-9f47-e004116c5d08	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-27	t	10827	\N	2026-06-28 07:37:55.714566+00	2026-06-28 07:37:55.714566+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
bf27fac6-4358-4767-9a90-720468c9d2ed	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-22	f	0	\N	2026-06-28 08:12:40.932673+00	2026-06-28 08:12:40.932673+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
21a9fb5a-48f1-4b6f-a7c8-1d4ff0b4e8f2	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-25	f	0	\N	2026-06-28 08:12:40.921068+00	2026-06-28 08:12:40.921068+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
6fdf6b8b-ba88-416e-8241-59386293e316	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-23	f	0	\N	2026-06-28 08:12:40.921066+00	2026-06-28 08:12:40.921066+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
1e6174ca-fc17-474b-a90a-17511e213ced	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-21	f	0	\N	2026-06-28 08:12:41.022647+00	2026-06-28 08:12:41.022647+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
40d96385-ef29-470d-9b60-0840beb68c03	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-26	f	0	\N	2026-06-28 08:12:41.023174+00	2026-06-28 08:12:41.023174+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
4246fb92-e76a-43ee-9317-c564d1e8367e	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-24	f	0	\N	2026-06-28 08:12:41.02286+00	2026-06-28 08:12:41.02286+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
b1de9308-d7c5-4520-9dc1-d1c31335c36e	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-27	f	0	\N	2026-06-28 08:12:41.035049+00	2026-06-28 08:12:41.035049+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
bd56f6fa-d754-4c56-be60-4ff78e51f75b	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-27	f	0	\N	2026-06-28 08:13:06.503292+00	2026-06-28 08:13:06.503292+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
311ff2b9-d966-4947-91b2-dc04721e5e76	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-24	f	0	\N	2026-06-28 08:13:06.505708+00	2026-06-28 08:13:06.505708+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
e81f306c-c365-4714-96ed-90969820175c	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-23	f	0	\N	2026-06-28 08:13:06.509886+00	2026-06-28 08:13:06.509886+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
22e3a20e-56ca-47da-9355-f4f3e456553e	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-26	f	0	\N	2026-06-28 08:13:21.350908+00	2026-06-28 08:13:21.350908+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
02b3151a-0044-46e2-b430-ca6f81e75e1a	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-27	f	0	\N	2026-06-28 08:13:23.550836+00	2026-06-28 08:13:23.550836+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
d22c6c96-6322-46fe-890a-9272be2d7b7b	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-26	f	0	\N	2026-06-28 08:13:38.240042+00	2026-06-28 08:13:38.240042+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
ccef7324-84b9-473b-b4c0-b398d29f8131	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-27	f	0	\N	2026-06-28 08:13:40.421135+00	2026-06-28 08:13:40.421135+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
12c6c369-791a-479f-a790-e4ef9d3cadda	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-27	f	0	\N	2026-06-28 08:14:03.795444+00	2026-06-28 08:14:03.795444+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
a1eb2a18-8a0e-42cd-936b-8a41b0593abe	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-27	f	0	\N	2026-06-28 08:14:25.650844+00	2026-06-28 08:14:25.650844+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
4d93c9bb-358d-4940-b5ae-67399208404d	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-26	f	0	\N	2026-06-28 08:14:54.162451+00	2026-06-28 08:14:54.162451+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
bd4c6f96-efa6-434c-8e30-adacf0753e5a	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-27	f	0	\N	2026-06-28 08:14:56.624664+00	2026-06-28 08:14:56.624664+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
9bb3281c-5be6-4287-b7fb-61eb7d587e72	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-26	f	0	\N	2026-06-28 08:15:05.901046+00	2026-06-28 08:15:05.901046+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
ef49c6b1-defa-4c6f-8a60-2520dd6d4e7d	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-27	f	0	\N	2026-06-28 08:15:08.433435+00	2026-06-28 08:15:08.433435+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
ae584094-201f-4fe6-a9c2-00cc48e533ac	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-27	t	5900	\N	2026-06-27 07:34:24.327337+00	2026-06-28 13:14:22.833644+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
c5070cad-4bae-48e6-b8e0-f4974bf62152	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-28	f	0	\N	2026-06-30 03:27:27.93234+00	2026-06-30 03:27:27.93234+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
cc269303-5d09-4b64-92a3-c64ef4ce10cd	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-29	t	8723	\N	2026-06-30 03:28:05.421255+00	2026-06-30 03:28:05.421255+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
81a4ef4c-a139-4f1b-8655-2c13dd571306	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-28	f	8000	\N	2026-06-30 03:35:15.646435+00	2026-06-30 03:35:15.646435+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
f8a13b81-c8e3-4ed0-b61c-a8ae02495ef8	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-29	t	8000	\N	2026-06-30 03:35:35.541473+00	2026-06-30 03:35:35.541473+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
9f54ece1-35b7-446a-bc85-fdd56bc915ae	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-28	f	12941	\N	2026-06-30 03:42:36.916754+00	2026-06-30 03:42:36.916754+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
0863a517-6903-4c8e-9006-5609df537619	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-29	t	12808	\N	2026-06-30 03:42:50.053167+00	2026-06-30 03:42:50.053167+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
f62924ef-b1d2-47a6-a8ed-84d7a09506fc	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-28	f	0	\N	2026-06-30 03:44:26.973771+00	2026-06-30 03:44:26.973771+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
b43bc9c1-8a5f-4bb9-9e47-a0faf039fedc	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-28	f	6667	\N	2026-06-30 03:47:03.577299+00	2026-06-30 03:47:03.577299+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
4581597d-bfe5-44cb-b5a2-b6bb69656271	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-29	f	17004	\N	2026-06-30 03:47:26.163907+00	2026-06-30 03:47:26.163907+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
0f1d81f5-9cf5-44e8-a77d-a9fa93261efd	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-28	f	0	\N	2026-06-30 03:56:00.61592+00	2026-06-30 03:56:00.61592+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
4dcaadde-d41c-4cbe-8ae5-f6ce973da337	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-29	t	0	\N	2026-06-30 03:56:03.770334+00	2026-06-30 03:56:03.770334+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
0c18b012-9027-40dc-958a-5f4223184a07	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-28	f	0	\N	2026-06-30 04:31:40.978748+00	2026-06-30 04:31:40.978748+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
7345e7ba-ee5c-4ace-a1ef-8837dff67bef	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-29	t	7062	\N	2026-06-30 04:31:53.372054+00	2026-06-30 04:31:53.372054+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
e1dbeba5-463e-49c4-80f1-9609998201d4	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-06-30	t	8477	\N	2026-07-01 03:38:15.439857+00	2026-07-01 03:38:15.439857+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
b843f6d3-3c7c-4ffc-8563-165e205f468d	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-28	f	0	\N	2026-07-01 03:39:19.194589+00	2026-07-01 03:39:19.194589+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
173fd859-789d-4d76-b617-a2b3e63ea8ca	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-29	t	10541	\N	2026-07-01 03:39:38.727846+00	2026-07-01 03:39:38.727846+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
52d610a6-b11f-4ec8-8111-3d7ea10dd176	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-06-30	t	12603	\N	2026-07-01 03:39:52.458067+00	2026-07-01 03:39:52.458067+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
7adaf462-ce7d-4074-be63-c6a344ee79a1	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-28	f	0	\N	2026-07-01 03:50:04.637622+00	2026-07-01 03:50:04.637622+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
c635fd93-33b9-4000-ba9a-0b5763a6ea88	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-29	f	0	\N	2026-07-01 03:50:07.012819+00	2026-07-01 03:50:07.012819+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
47b4ab02-f9bc-4cf9-9c96-9b4c69814f55	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-06-30	t	0	\N	2026-07-01 03:50:09.876059+00	2026-07-01 03:50:09.876059+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
66e161ee-faf5-4d02-b395-c861bf0180a8	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-30	f	8925	\N	2026-07-01 03:51:17.548785+00	2026-07-01 03:51:17.548785+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
2b6bc4b8-515e-408e-8def-c6688cc541c2	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-06-29	f	5714	\N	2026-06-30 03:44:36.085483+00	2026-07-01 03:51:52.803596+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
5f5c5f91-8a09-4c6d-bd84-61c1f5f27fde	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-30	f	4593	\N	2026-07-01 14:15:37.448912+00	2026-07-01 14:15:37.448912+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
37d02338-578f-45fc-ab22-9f1f76ee9b45	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-28	f	0	\N	2026-07-01 14:15:42.889788+00	2026-07-01 14:15:42.889788+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
bbe272bc-6ca0-4f63-be57-7de63179c504	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-06-29	f	0	\N	2026-07-01 14:15:46.539974+00	2026-07-01 14:15:46.539974+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
28cbe074-59e0-4412-b837-de487795c50c	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-06-30	t	0	\N	2026-07-01 14:16:18.684026+00	2026-07-01 14:16:18.684026+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
61e91cb0-6e3c-4a66-9024-f61f087666b4	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-06-30	t	8000	\N	2026-07-01 14:16:45.425687+00	2026-07-01 14:16:45.425687+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
87a3c2c7-4a56-43bc-a305-422554435b27	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-06-30	f	5840	\N	2026-07-01 14:17:23.279867+00	2026-07-01 14:17:23.279867+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
aa2eeb4f-cb1e-4e75-aec3-9bae367e24a8	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-01	t	8271	\N	2026-07-04 04:36:52.161011+00	2026-07-04 04:42:22.931519+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
27445515-abe0-4084-bfee-2013c0cf3485	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-01	t	10136	\N	2026-07-02 03:35:13.099123+00	2026-07-02 03:35:13.099123+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
c52c4fa8-f900-4728-91c2-c4c816b9f8d9	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-01	t	8000	\N	2026-07-02 03:36:07.434082+00	2026-07-02 03:36:07.434082+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
b0f20fe9-7e0f-4c84-9000-a9b2da975faf	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-06-30	t	12471	\N	2026-07-02 03:37:21.171815+00	2026-07-05 16:23:54.660779+00	NO_ACTIVITY	t	f	f	f	f	t	f	f
0921921c-7653-4f51-ac85-7da5cdc430c1	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-01	f	10503	\N	2026-07-02 03:39:00.673752+00	2026-07-02 03:39:00.673752+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
47bc2c15-f80f-48cf-ad77-96e1cf123cb7	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-07-01	f	7886	\N	2026-07-02 03:39:51.034063+00	2026-07-02 03:39:51.034063+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
c5c6cc9b-f1bd-410a-a1f5-0262dd2caa3c	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-29	t	6000	\N	2026-07-02 03:40:06.637731+00	2026-07-02 03:40:06.637731+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
25b35a6b-b3d9-4300-b73b-f253521646ef	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-06-30	t	6000	\N	2026-07-02 03:40:12.585229+00	2026-07-02 03:40:12.585229+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
96c5d77b-2301-44f5-9e22-2f78f2d0da75	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-02	t	8000	\N	2026-07-03 03:11:10.295161+00	2026-07-03 03:11:10.295161+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
c3a2dcbb-24c1-4e3c-9ab8-4cab7a9e245a	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-07-02	t	9970	\N	2026-07-03 03:11:40.783807+00	2026-07-03 03:11:40.783807+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
c5e3f0d3-3572-4ce5-a72b-92bcfc8e78de	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-02	f	8197	\N	2026-07-03 03:13:03.545451+00	2026-07-03 03:13:03.545451+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
aa890363-009b-43f8-ad29-f6ad2d1dd413	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-01	t	9018	\N	2026-07-02 03:33:32.627804+00	2026-07-03 03:14:51.781365+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
bf592c9f-eccc-4b7d-a64a-2435ea0d9a79	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-01	f	4668	\N	2026-07-03 03:17:02.813143+00	2026-07-03 03:17:02.813143+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
5a4becb4-af81-42ff-a4ef-19383e1c4541	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-02	t	11299	\N	2026-07-04 04:04:41.277864+00	2026-07-04 04:04:41.277864+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
25a0645c-0296-44cb-a3ea-c60c228538cc	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-03	f	8193	\N	2026-07-04 04:37:48.518374+00	2026-07-04 04:37:48.518374+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
a780e412-14b6-4134-aa1d-32a8e30cfd6f	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-02	t	12106	\N	2026-07-04 04:36:55.612448+00	2026-07-04 04:42:34.946636+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
c0f50f65-fb9d-4e00-977b-200d50265fd0	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-03	t	10566	\N	2026-07-04 04:38:39.167236+00	2026-07-05 16:23:30.189658+00	NO_ACTIVITY	t	f	f	f	f	t	f	f
ea6fc63e-670e-4256-93bc-c26c710a53df	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-02	t	15839	\N	2026-07-03 03:13:49.206741+00	2026-07-05 16:23:44.57455+00	NO_ACTIVITY	t	f	f	f	f	t	f	f
af4694af-4725-4482-a55f-192e59c8f830	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-01	t	16973	\N	2026-07-02 03:37:37.342284+00	2026-07-05 16:23:47.156017+00	NO_ACTIVITY	t	f	f	f	f	t	f	f
af431231-843c-4468-8a65-c0f9d23dc2c1	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-03	t	10954	\N	2026-07-04 04:36:58.367805+00	2026-07-04 04:42:48.341686+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
dce866c0-f200-4d05-a15d-8d11cf814ccd	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-06-30	t	10802	\N	2026-07-01 03:38:36.955533+00	2026-07-04 04:42:54.708646+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
1f64306e-99df-4681-8a33-8635a2fa7f08	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-03	t	8000	\N	2026-07-04 04:49:03.466799+00	2026-07-04 04:49:03.466799+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
d96caf34-00ba-4bd1-9cc4-d7963492fa7f	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-04	t	0	\N	2026-07-05 06:34:19.951175+00	2026-07-05 06:34:19.951175+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
1964297a-e88e-4693-9e45-bdb7ed405527	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-02	f	0	\N	2026-07-05 06:50:10.720484+00	2026-07-05 06:50:10.720484+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
7203b586-0aa4-4747-af19-2fc90b55e8b4	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-03	f	0	\N	2026-07-05 06:50:13.305548+00	2026-07-05 06:50:13.305548+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
abb4ab91-51ef-436d-b358-1fa50771bc06	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-04	f	6799	\N	2026-07-05 07:19:29.218499+00	2026-07-05 07:19:29.218499+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
6771b540-28b4-4c6a-b5ca-3c7f29ddbbaa	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-02	f	0	\N	2026-07-05 07:19:32.216641+00	2026-07-05 07:19:32.216641+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
5890985e-0d4f-4950-b5b9-d1eedf5a5a6c	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-03	f	0	\N	2026-07-05 07:19:34.899844+00	2026-07-05 07:19:34.899844+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
416770c2-6b10-424d-9c9d-d14db5175129	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-04	t	8000	\N	2026-07-05 07:20:36.964449+00	2026-07-05 07:20:36.964449+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
b4591027-a6cf-4ba4-bbcb-c64e9a1e47aa	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-04	f	9205	\N	2026-07-05 07:58:29.20174+00	2026-07-05 07:58:29.20174+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
d1cf5511-a53d-416e-9957-418be3896c19	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-07	t	8000	\N	2026-07-09 04:41:33.577665+00	2026-07-09 04:41:33.577665+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
643d26cb-127c-4fd5-b424-09c180bdba01	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-07-03	f	4500	\N	2026-07-05 15:25:31.47299+00	2026-07-05 15:27:33.621529+00	NO_ACTIVITY	f	f	f	f	f	t	f	f
a810a3b7-8c66-4ed7-baed-cbf0ed254ea2	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-07-04	f	8704	\N	2026-07-05 15:15:14.083884+00	2026-07-05 15:27:42.774871+00	NO_ACTIVITY	t	f	f	f	f	t	f	f
631cc5aa-6669-4065-94d5-2ece1d3a3abd	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-03	f	0	\N	2026-07-05 15:28:51.918637+00	2026-07-05 15:28:51.918637+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
d2f199fe-1e23-40e1-9f75-b6f8cbf77be6	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-04	f	0	\N	2026-07-05 15:28:51.918525+00	2026-07-05 15:28:51.918525+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
19046d19-9d1c-4312-9852-ddbf59cf21ae	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-02	f	0	\N	2026-07-05 15:28:51.931782+00	2026-07-05 15:28:51.931782+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
f879ff21-6751-40fe-8216-c5d164a873b8	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-01	f	0	\N	2026-07-05 15:28:51.933881+00	2026-07-05 15:28:51.933881+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
8deae00a-6672-408f-961a-ed881e75ddbf	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-03	f	0	\N	2026-07-05 15:38:10.309532+00	2026-07-05 15:38:10.309532+00	NO_ACTIVITY	f	f	f	f	f	t	t	f
8bcad4ea-f781-4105-985b-9cbb08672eac	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-04	f	0	\N	2026-07-05 15:38:13.430602+00	2026-07-05 15:38:13.430602+00	NO_ACTIVITY	f	f	f	f	f	t	t	f
0962642c-7591-4c27-a9a0-7ca23db1995c	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-04	t	6032	\N	2026-07-05 06:59:51.028573+00	2026-07-05 16:23:41.597215+00	NO_ACTIVITY	t	f	f	f	f	t	f	f
63c6ca4e-624b-47cb-8d7d-5ab56465a0dc	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-04	f	0	\N	2026-07-05 15:31:00.556913+00	2026-07-07 03:22:26.305158+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
01905bdf-6a8f-480e-8e4b-508326eac556	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-06	f	8553	\N	2026-07-07 03:23:48.18389+00	2026-07-07 03:24:06.659075+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
9207ef9a-5a47-4a58-ad80-2c581920e9ca	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-05	f	0	\N	2026-07-07 03:25:09.824455+00	2026-07-07 03:25:09.824455+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
4f6829d1-6b39-4546-9c6b-b0cbdfaa0e58	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-06	f	8520	\N	2026-07-07 03:25:17.655318+00	2026-07-07 03:25:17.655318+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
b0a0d2e3-dcef-4e23-a2d0-d3954c974ff4	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-05	f	8000	\N	2026-07-07 03:26:34.915303+00	2026-07-07 03:26:34.915303+00	NO_ACTIVITY	f	f	f	t	f	f	f	f
4d8e6a3a-a27d-4764-8cad-217914b73d56	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-07-05	f	6925	\N	2026-07-07 03:29:35.978252+00	2026-07-07 03:29:35.978252+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
8314e62f-03d1-46f8-a033-8d71e05e5724	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	2026-07-06	f	7698	\N	2026-07-07 03:29:57.675461+00	2026-07-07 03:29:57.675461+00	NO_ACTIVITY	t	f	f	f	f	t	f	f
a59c5e62-dea5-41dd-86f4-c2d9538ab8b1	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-05	f	0	\N	2026-07-07 13:21:17.928211+00	2026-07-07 13:21:17.928211+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
638bb51c-3ca7-4abc-82be-1bbcf4771a6f	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-06	f	2322	\N	2026-07-07 13:41:23.891645+00	2026-07-07 13:43:25.26685+00	NO_ACTIVITY	f	f	f	f	f	f	f	t
45820aa2-1f47-4359-97be-2c0f6951ac66	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-06	t	10000	\N	2026-07-09 03:45:21.699416+00	2026-07-09 03:45:21.699416+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
3374157f-167d-4ae4-bf07-a9d15f4b6902	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-07	f	10000	\N	2026-07-09 03:45:29.789713+00	2026-07-09 03:45:29.789713+00	NO_ACTIVITY	t	f	f	f	f	f	f	t
71c5f728-23f9-44ab-8c82-9fb0af47579a	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-08	t	10000	\N	2026-07-09 03:45:37.179481+00	2026-07-09 03:45:37.179481+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
9e197809-1e9d-4b67-86c4-3818f46e6e95	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-07	t	13470	\N	2026-07-09 04:13:48.350731+00	2026-07-09 04:13:48.350731+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
be383876-d6ac-474a-979a-560b7015e5a0	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-08	t	0	\N	2026-07-09 04:13:51.595079+00	2026-07-09 04:13:56.644573+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
ffed2821-f010-414d-8b44-fea12a69383c	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-06	f	0	\N	2026-07-09 04:14:04.136787+00	2026-07-09 04:14:10.591973+00	NO_ACTIVITY	f	f	f	f	f	f	t	t
8b1ec9f9-654c-4a1a-b468-847016e6735e	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-05	f	0	\N	2026-07-09 04:14:13.136606+00	2026-07-09 04:14:13.136606+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
8b9cc116-1f98-4da4-8907-8dd22bbb087c	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-07	t	11538	\N	2026-07-09 04:33:59.05195+00	2026-07-09 04:33:59.05195+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
2d10c3b1-2485-4b2f-a6cc-7722a0d01d51	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-08	t	12463	\N	2026-07-09 04:34:14.125337+00	2026-07-09 04:34:14.125337+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
09d6054e-96af-4f44-b9b9-56b3501e0551	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-05	f	0	\N	2026-07-09 04:41:04.242485+00	2026-07-09 04:41:04.242485+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
0ca4b19e-37b9-4bea-ad6d-2abb49f0f498	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-06	f	0	\N	2026-07-09 04:41:26.642359+00	2026-07-09 04:41:26.642359+00	NO_ACTIVITY	f	f	f	f	f	f	t	t
5c3de94f-6e5d-4c05-bd77-86537ee056a4	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-08	f	0	\N	2026-07-09 04:41:40.64132+00	2026-07-09 04:41:40.64132+00	NO_ACTIVITY	f	f	f	f	f	t	t	f
aa4905c3-9bba-4ddc-9372-99732e38bcca	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-08	t	6259	\N	2026-07-09 04:57:08.044762+00	2026-07-09 04:57:08.044762+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
bbea54ef-03a6-4b72-8f13-056dc14c010b	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-07	f	0	\N	2026-07-09 05:12:56.736674+00	2026-07-09 05:12:56.736674+00	NO_ACTIVITY	f	f	f	f	f	f	t	t
d8ebc6cb-ab66-430c-a3bb-74d5ecc74cc5	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-08	t	2525	\N	2026-07-09 05:08:45.660866+00	2026-07-09 05:09:28.614915+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
399af6ff-bc53-42cd-bf8a-cc1f3a6796bf	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-05	f	7551	\N	2026-07-09 04:56:12.912286+00	2026-07-09 05:10:45.910751+00	NO_ACTIVITY	t	f	f	f	f	f	t	f
803e9d32-4cd8-48c0-8e77-190481d60cb2	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-06	f	2738	\N	2026-07-09 04:56:49.906873+00	2026-07-09 05:11:00.517688+00	NO_ACTIVITY	f	f	f	f	f	f	f	t
2ab60e57-374d-44bd-8e5f-91c180fa5f7e	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-07	t	4051	\N	2026-07-09 04:56:53.018075+00	2026-07-09 05:11:17.943172+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
f07d95a2-47fa-4568-acee-cabc9c9f9323	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-08	f	12224	\N	2026-07-09 05:12:34.587904+00	2026-07-09 05:12:34.587904+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
6771eeff-9a94-46f3-ba88-dddfe30785d4	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-07	f	4009	\N	2026-07-09 05:08:37.387171+00	2026-07-09 05:17:00.922096+00	NO_ACTIVITY	f	f	f	f	f	f	f	t
5a32d597-e2d1-473e-98d6-2316ab396b3f	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-07-04	f	0	\N	2026-07-10 03:13:44.248435+00	2026-07-10 03:13:44.248435+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
3cf674da-d71a-4373-80af-fcc68fcf39a2	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-07-02	f	0	\N	2026-07-10 03:13:44.248469+00	2026-07-10 03:13:44.248469+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
1009d6db-16eb-4e4a-aa14-fbe8e67c650d	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-07-06	f	0	\N	2026-07-10 03:13:44.248433+00	2026-07-10 03:13:44.248433+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
1ef13caa-a05f-4a12-8134-4944f4618d45	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-07-05	f	0	\N	2026-07-10 03:13:44.266483+00	2026-07-10 03:13:44.266483+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
b602fd72-73ed-404a-a5be-e7fa4b122506	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-07-03	f	0	\N	2026-07-10 03:13:44.266872+00	2026-07-10 03:13:44.266872+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
b9ae9760-18ee-4d75-91b0-80424f89bf4b	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-07-07	f	0	\N	2026-07-10 03:13:44.27806+00	2026-07-10 03:13:44.27806+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
915e734a-f005-4f25-8db9-c9a2c3d8c113	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-07-09	t	0	\N	2026-07-10 03:13:58.703718+00	2026-07-10 03:13:58.703718+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
f5b80867-b84a-465c-9046-ee2a6d545dc3	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-07-08	f	0	\N	2026-07-10 03:13:44.27806+00	2026-07-10 03:13:44.27806+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
388b1200-a2f4-46e9-92a6-2ec8ae98ad11	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-01	f	0	\N	2026-07-12 16:29:26.408858+00	2026-07-12 16:29:26.408858+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
a8ddf182-f5e2-453f-83c3-10d8e553c365	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-04	f	0	\N	2026-07-12 16:29:26.429328+00	2026-07-12 16:29:26.429328+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
bf4baf16-d060-4be7-9a20-cbe87c28e01a	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-07	f	0	\N	2026-07-12 16:29:26.443033+00	2026-07-12 16:29:26.443033+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
a3632b3d-94ef-4b53-b47c-8593591e8d70	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-09	f	0	\N	2026-07-12 16:29:26.448368+00	2026-07-12 16:29:26.448368+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
b54d6b43-8209-4ecb-8672-9429dbf6e2db	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-12	f	0	\N	2026-07-12 16:29:26.455166+00	2026-07-12 16:29:26.455166+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
8a3ea2fa-8cc6-4168-a7c3-9fda87372284	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-08	f	0	\N	2026-07-12 16:29:26.460324+00	2026-07-12 16:29:26.460324+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
f2bc0d8a-60f3-40fb-aaa2-991ee1e461ad	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-11	f	0	\N	2026-07-12 16:29:26.466418+00	2026-07-12 16:29:26.466418+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
7ec0953e-45f9-4c36-b419-e5e3058f14b5	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-07-10	f	0	\N	2026-07-12 16:36:00.588941+00	2026-07-12 16:36:00.588941+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
18c9dbf4-e7e5-4704-996b-7e39243d8af1	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-07-11	f	0	\N	2026-07-12 16:36:02.70117+00	2026-07-12 16:36:02.70117+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
864b1e96-e72d-442d-bf55-503638d8b42f	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	2026-07-16	t	12076	\N	2026-07-18 04:42:19.569834+00	2026-07-18 04:42:24.69636+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
48e12d47-a48a-4762-9e09-cd915792d127	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	2026-07-17	t	8455	\N	2026-07-18 04:42:38.125928+00	2026-07-18 04:42:38.125928+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
a89a1331-a1ee-4348-b520-342a62e8a49a	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	2026-07-05	f	0	not started	2026-07-10 03:58:05.59625+00	2026-07-10 03:58:05.59625+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
3bb5ffbd-c38b-4673-9b1f-461c14ffc408	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	2026-07-06	f	0	\N	2026-07-10 03:58:25.125984+00	2026-07-10 03:58:25.125984+00	NO_ACTIVITY	f	f	f	f	f	f	t	t
bbcfa612-7430-469e-a65f-e13af8da470a	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	2026-07-07	t	0	\N	2026-07-10 03:58:30.447633+00	2026-07-10 03:58:30.447633+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
e2e86cea-7bcc-44b0-932b-602eb761b8c3	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	2026-07-08	f	0	\N	2026-07-10 03:58:38.839351+00	2026-07-10 03:58:38.839351+00	NO_ACTIVITY	f	f	f	f	f	t	t	f
cba564f5-4ca1-4035-8e0d-649dc116ba9e	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-10	f	0	\N	2026-07-12 16:39:03.602914+00	2026-07-12 16:39:03.602914+00	NO_ACTIVITY	f	f	f	f	f	t	t	f
c40d0c15-4997-4181-a3c6-124971d35637	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-11	f	0	\N	2026-07-12 16:39:06.604261+00	2026-07-12 16:39:06.604261+00	NO_ACTIVITY	f	f	f	f	f	t	t	f
aab2baf8-d835-4e6b-912b-5091a2de8925	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-16	f	6000	\N	2026-07-18 04:59:28.467481+00	2026-07-18 04:59:28.467481+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
40d7993a-a6f4-4f98-8aab-ee07278be6d1	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-08	f	12104	\N	2026-07-10 04:00:29.497231+00	2026-07-10 04:00:29.497231+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
addb9d39-20fc-4ad3-93b7-516d422a0344	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-06	f	0	\N	2026-07-10 04:00:37.167852+00	2026-07-10 04:00:37.167852+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
cc3b2627-c137-4610-b392-c428f226ffad	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-13	t	14519	\N	2026-07-15 15:59:56.659288+00	2026-07-15 15:59:56.659288+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
2d59379f-bfe2-4f07-beb3-31f1e4eecf41	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-12	f	10000	\N	2026-07-15 15:59:43.138316+00	2026-07-16 03:52:42.688376+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
f439829a-6acc-46d8-b048-0dc3706df586	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-17	t	10000	\N	2026-07-18 05:01:42.607721+00	2026-07-18 05:02:00.612097+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
5905fbd6-cac8-4e32-b7b6-1a67dd55681a	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-05	f	0	\N	2026-07-10 04:00:34.472021+00	2026-07-10 04:00:34.472021+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
b9ebe812-cdb7-49b4-8fdf-328df3268d40	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-07	f	0	\N	2026-07-10 04:00:40.275195+00	2026-07-10 04:00:40.275195+00	NO_ACTIVITY	f	f	f	f	t	f	f	f
e9d43ef2-4999-4634-847b-c53bec671a8a	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-14	t	10000	\N	2026-07-15 16:01:17.090899+00	2026-07-16 03:52:24.648883+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
38d2e8eb-3c42-4df7-b8d4-6fd35a49de23	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-16	t	10000	\N	2026-07-18 05:01:42.612833+00	2026-07-18 05:01:51.336359+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
b4d70ce8-5bdd-4c6f-8f75-ae3e80f26870	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	2026-07-09	t	10105	\N	2026-07-10 13:58:54.405589+00	2026-07-10 13:58:57.941481+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
378354c7-985a-4a5f-a28d-5ad2279e19dd	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	2026-07-10	t	10385	\N	2026-07-10 13:59:01.82376+00	2026-07-12 12:52:54.541018+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
08f6e049-63b4-4882-b9ad-8c23070b23d1	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-14	t	6000	\N	2026-07-16 03:45:08.441205+00	2026-07-16 03:45:08.441205+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
ca6fc1d7-40e6-487d-a205-7c1e9ac3b01c	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	2026-07-12	f	0	\N	2026-07-16 03:46:32.868104+00	2026-07-16 03:46:32.868104+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
8fc264fb-0251-417d-b84d-7bc7dd2e0bd5	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	2026-07-13	f	0	\N	2026-07-16 03:46:44.277471+00	2026-07-16 03:46:44.277471+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
8f24c76a-79e7-4254-87fd-c4c16ae81986	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	2026-07-14	t	11136	\N	2026-07-16 03:47:07.668209+00	2026-07-16 03:47:07.668209+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
7b453c80-b8b1-490c-892a-7b4e51b11e0f	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	2026-07-15	t	8689	\N	2026-07-16 03:47:39.564833+00	2026-07-16 03:47:39.564833+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
026b9b05-8cc6-4990-80a4-263b5f03757f	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-12	f	6780	\N	2026-07-16 03:44:41.149721+00	2026-07-16 13:07:12.547947+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
a60d2ea3-3f17-4189-a222-2dc5fbd430a3	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-13	f	2995	\N	2026-07-16 03:44:44.703427+00	2026-07-16 13:07:29.644853+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
2da773da-705c-46b5-ae9c-c74f42f58b4a	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-16	f	6152	\N	2026-07-18 05:03:06.499782+00	2026-07-18 05:03:11.71297+00	NO_ACTIVITY	t	f	f	f	f	f	f	t
3bd8f154-3eb2-44ff-b8a4-7e6873725694	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-17	t	7608	\N	2026-07-18 05:03:24.474254+00	2026-07-18 05:03:24.474254+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
46f80da1-e8e4-45dc-830a-faa08de8d7e6	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-09	t	7358	\N	2026-07-10 14:07:06.091625+00	2026-07-10 14:07:06.091625+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
8467b1c4-5b77-4ef7-b277-a99e91f7f569	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-12	f	0	\N	2026-07-16 03:58:32.654539+00	2026-07-16 03:58:32.654539+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
caca2daf-0e78-41ac-98c0-6a8ccd61f71b	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-09	t	10000	\N	2026-07-10 14:16:37.756798+00	2026-07-10 14:16:37.756798+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
89682065-aafa-494b-b99f-c0099c06eff8	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-09	t	12872	\N	2026-07-10 14:21:34.544139+00	2026-07-10 14:21:34.544139+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
0f2bad69-5cee-458a-871f-37c6487447ed	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-13	f	0	\N	2026-07-16 03:59:16.340706+00	2026-07-16 03:59:16.340706+00	NO_ACTIVITY	f	f	f	f	f	t	t	f
41681264-496b-4c87-9a6e-47bcbe3f0bab	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-14	f	0	\N	2026-07-16 03:59:19.981776+00	2026-07-16 03:59:19.981776+00	NO_ACTIVITY	f	f	f	f	f	t	t	f
c5953d81-895b-4560-91bf-83c595324ed5	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-15	t	6025	\N	2026-07-16 03:59:31.436692+00	2026-07-16 03:59:31.436692+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
ef5293b7-692c-4bbd-9ee1-d231d9b1ce04	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-12	f	0	\N	2026-07-16 04:00:30.050896+00	2026-07-16 04:00:30.050896+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
7b5b8641-7fe8-436b-9306-57fe013c3964	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-15	f	3228	\N	2026-07-16 04:01:02.666427+00	2026-07-16 04:01:02.666427+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
185809bc-c34f-4dc2-98d7-4bcdec066571	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-09	t	11945	\N	2026-07-10 14:28:13.564537+00	2026-07-10 14:28:13.564537+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
6d836186-2bbe-4fbe-856b-edd8d662acb6	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-13	f	4100	\N	2026-07-16 04:00:36.368574+00	2026-07-16 04:00:36.368574+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
d3ed1b64-3694-45ef-b547-c8ad66e30a27	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-14	f	0	\N	2026-07-16 04:01:08.131752+00	2026-07-16 04:01:08.131752+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
ca079e88-a980-41df-b988-a874aeeec580	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-09	t	5328	\N	2026-07-10 14:44:55.933094+00	2026-07-10 14:44:55.933094+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
d2f105a8-abf3-4044-adba-1fb042601aaa	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-05	f	0	\N	2026-07-16 04:06:17.562047+00	2026-07-16 04:06:17.562047+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
cc599ecf-39dc-4c6c-a30d-ad274145096c	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-10	t	12019	\N	2026-07-12 12:47:08.602492+00	2026-07-12 12:47:08.602492+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
5d448611-61d3-4b20-90a4-172d172b501a	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-12	f	0	\N	2026-07-16 04:09:41.006837+00	2026-07-16 04:09:41.006837+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
b4966925-df42-4208-90c9-856a4488bca6	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-11	t	12351	\N	2026-07-12 12:47:25.762651+00	2026-07-12 12:47:25.762651+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
8e01c442-02b0-4c25-8a0d-bab1ee64dd01	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-15	t	6156	\N	2026-07-16 13:06:50.377271+00	2026-07-16 13:06:50.377271+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
87ab3060-d38a-490c-876e-ccdcb66ebf4c	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-09	f	4813	\N	2026-07-12 12:49:56.515526+00	2026-07-12 12:49:56.515526+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
8c8ad541-f905-4771-a932-62a51f25143b	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-10	t	6564	\N	2026-07-12 12:50:44.501859+00	2026-07-12 12:50:44.501859+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
e12468a4-496e-4637-be3d-fdfc8b7aa6dc	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-11	f	8282	\N	2026-07-12 12:51:03.619154+00	2026-07-12 12:51:03.619154+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
a6f02ae5-d9dc-4d4d-85d9-845e3f43cf53	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-13	t	10648	\N	2026-07-16 13:10:19.665181+00	2026-07-16 13:10:57.903758+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
55e4541d-54a6-4a63-9ada-8d91bd30ce5c	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-14	t	12044	\N	2026-07-16 13:10:19.681723+00	2026-07-16 13:11:14.933032+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
c38a0439-af46-45f3-bc58-b4a12ab89b4e	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-10	t	6229	\N	2026-07-12 13:01:09.614189+00	2026-07-12 13:02:14.26294+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
e51862c3-b976-488a-af1d-81e94db2f133	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-15	t	0	\N	2026-07-16 13:10:19.714786+00	2026-07-16 13:10:19.714786+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
e091c83e-7d7f-40e7-87eb-37cf56b21970	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-11	f	7598	\N	2026-07-12 13:10:31.448118+00	2026-07-12 13:10:31.448118+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
33755660-cc4b-4310-913b-2d2f94584893	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-12	f	0	\N	2026-07-16 13:17:03.359966+00	2026-07-16 13:17:03.359966+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
73a1442e-a6de-4f54-99ec-d1f2a2ddf468	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-13	t	4000	\N	2026-07-16 13:17:26.811545+00	2026-07-16 13:17:26.811545+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
95a08216-cf38-4da5-bbe3-0d6d94adfccc	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-14	t	4574	\N	2026-07-16 13:17:41.594277+00	2026-07-16 13:17:41.594277+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
c286b147-9d27-4ee2-85fd-b1cce1970be1	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-15	t	4548	\N	2026-07-16 13:18:38.009556+00	2026-07-16 13:18:38.009556+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
2100cc1e-7ba8-4d12-8584-d5421e5b2dbb	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-14	t	5098	\N	2026-07-16 13:22:44.091211+00	2026-07-16 13:25:49.438063+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
2f6d0c8a-3eec-4a67-8f4a-9e407584cc51	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-12	f	0	\N	2026-07-16 13:19:38.114646+00	2026-07-16 13:26:08.585448+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
6f127c7f-a187-4bd0-9b34-0cba255df036	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-13	t	8754	\N	2026-07-16 13:20:13.703837+00	2026-07-16 13:26:18.432448+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
962a29e2-c300-42e4-83a2-c475df92e538	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-11	t	12839	\N	2026-07-12 15:28:06.745202+00	2026-07-12 15:28:06.745202+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
abba3082-238a-4f06-8b63-44c26a0b7fef	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	2026-07-10	t	10787	\N	2026-07-12 15:27:54.683453+00	2026-07-12 16:15:08.433706+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
f7198d7e-e4c0-4c6e-9e24-bb00e9dcaaa1	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-15	t	4565	\N	2026-07-16 13:24:51.028261+00	2026-07-16 13:25:29.101064+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
bdd80267-2827-47d9-958c-8d4a827725e4	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	2026-07-11	t	7637	\N	2026-07-12 15:37:51.232793+00	2026-07-12 15:37:51.232793+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
f7c174a4-f2e3-4588-976b-58fa64cda973	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-11	t	10000	\N	2026-07-12 15:39:03.697191+00	2026-07-12 15:39:03.697191+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
992cfb1a-bd4a-4c5b-83ec-b548000faee7	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-13	t	10000	\N	2026-07-16 13:51:11.527132+00	2026-07-16 13:51:11.527132+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
2dc60f66-6f08-4b6e-88d5-a9cf4ac3ca73	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-15	t	10000	\N	2026-07-16 13:51:25.119711+00	2026-07-16 13:51:25.119711+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
85738938-c656-4226-93d9-e90263607a64	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-10	t	10000	\N	2026-07-12 15:38:57.358966+00	2026-07-12 15:38:57.358966+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
4c7468f1-8afe-47a2-8d34-e10442251b50	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-12	t	10000	\N	2026-07-12 15:39:14.543352+00	2026-07-16 13:50:58.840976+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
47ccfed4-4923-448e-89e4-3b013ddad603	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	2026-07-14	t	10000	\N	2026-07-16 13:51:18.712327+00	2026-07-16 13:51:18.712327+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
ad2ae8a1-ffa3-4687-9e4f-55895b10f9c3	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-09	f	4644	\N	2026-07-12 16:09:38.655154+00	2026-07-12 16:09:38.655154+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
6d76a66a-94d7-4029-8362-f7697ba1f235	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-10	f	4000	\N	2026-07-12 16:09:51.141312+00	2026-07-12 16:09:51.141312+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
29ee3828-42dc-4afc-bc93-3a02d00fed70	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	2026-07-11	t	5541	\N	2026-07-12 16:10:07.608829+00	2026-07-12 16:11:29.598165+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
a0895ffe-e302-4df8-af69-08a88439f211	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-09	f	0	\N	2026-07-12 16:13:04.429677+00	2026-07-12 16:13:04.429677+00	NO_ACTIVITY	f	f	f	f	f	f	t	t
41211029-3315-4899-b8e9-0e6fa9146c79	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-10	t	0	\N	2026-07-12 16:13:54.883772+00	2026-07-12 16:13:54.883772+00	NO_ACTIVITY	f	f	f	f	f	f	t	f
c6fcc6b1-7ed1-4e51-9d1e-d42c5e682afa	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-15	t	10582	\N	2026-07-18 03:50:11.00575+00	2026-07-18 03:50:11.00575+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
72e0726a-2c2f-499a-91b4-25a27403eef2	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-16	t	16570	\N	2026-07-18 03:50:26.330254+00	2026-07-18 03:50:26.330254+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
38d9d025-6484-4110-9135-a397f4602f58	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	2026-07-17	t	15794	\N	2026-07-18 03:50:38.314526+00	2026-07-18 03:50:42.49015+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
53c0b4f9-7197-4ef8-b74d-f148bfb7eb3c	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	2026-07-11	f	9545	\N	2026-07-12 16:13:40.538664+00	2026-07-12 16:13:40.538664+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
e00eec61-b67a-4ab4-96f7-d5266cafb825	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-16	t	8463	\N	2026-07-18 04:02:10.703859+00	2026-07-18 04:02:10.703859+00	NO_ACTIVITY	f	f	f	f	f	f	f	f
0f9a274c-9f92-45cd-99a4-85c5c2774baf	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	2026-07-17	f	0	\N	2026-07-18 04:02:25.512735+00	2026-07-18 04:02:25.512735+00	NO_ACTIVITY	f	f	f	f	f	t	t	f
a48a0add-6ef9-4383-adf0-a43eb4b41e66	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-16	f	7035	\N	2026-07-18 04:05:55.846465+00	2026-07-18 04:05:55.846465+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
5a6bcff1-9c80-40e1-9b86-20825bf74993	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	2026-07-17	f	8465	\N	2026-07-18 04:06:10.589819+00	2026-07-18 04:06:10.589819+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
e1f1bae7-ed74-4ab5-8296-c2e000eaf37d	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-02	f	0	\N	2026-07-12 16:29:26.408815+00	2026-07-12 16:29:26.408815+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
2d690adf-ca0d-4f3f-a456-017ebeebf7cf	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-05	f	0	\N	2026-07-12 16:29:26.408815+00	2026-07-12 16:29:26.408815+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
32cc810b-648d-4e4b-9aa5-571400ac1d5a	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-03	f	0	\N	2026-07-12 16:29:26.428807+00	2026-07-12 16:29:26.428807+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
f60d9915-444d-4d02-b165-de3a641cbf52	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-06	f	0	\N	2026-07-12 16:29:26.542243+00	2026-07-12 16:29:26.542243+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
ba8a9c26-3d5a-4726-b306-5259508470d3	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	2026-07-10	f	0	\N	2026-07-12 16:29:26.542267+00	2026-07-12 16:29:26.542267+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
ab027a7f-fdb6-4568-9f09-331e1d057117	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-16	t	6200	\N	2026-07-18 04:12:58.117216+00	2026-07-18 04:13:33.990613+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
c78439e5-dd71-4f0d-972c-b9fb9f93df5b	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	2026-07-17	t	6265	\N	2026-07-18 04:13:48.722675+00	2026-07-18 04:58:09.493422+00	NO_ACTIVITY	t	f	f	f	f	f	f	f
93848f7b-abf1-4f3a-8d50-78c61a67f595	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	2026-07-01	f	0	\N	2026-07-10 03:13:44.266483+00	2026-07-10 03:13:44.266483+00	NO_ACTIVITY	f	f	f	f	t	f	f	t
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
7	7	add activity status to daily member checkins	SQL	V7__add_activity_status_to_daily_member_checkins.sql	-2088212069	postgres	2026-06-20 13:44:59.825807	54	t
8	8	add activity markers to daily member checkins	SQL	V8__add_activity_markers_to_daily_member_checkins.sql	1317537733	postgres	2026-06-20 14:06:06.1133	22	t
9	9	add not active marker to daily member checkins	SQL	V9__add_not_active_marker_to_daily_member_checkins.sql	-1359597226	postgres	2026-06-20 14:24:39.368015	22	t
10	10	add not shared markers to daily member checkins	SQL	V10__add_not_shared_markers_to_daily_member_checkins.sql	1921587498	postgres	2026-07-05 15:25:15.215568	90	t
11	11	add workout not completed to daily member checkins	SQL	V11__add_workout_not_completed_to_daily_member_checkins.sql	459893617	postgres	2026-07-07 13:14:48.713497	42	t
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
09fd3176-e492-4963-858a-c049243145b1	e237c780-aa39-4331-8860-684d9b869b8f	SIDE	44a48bab-cd18-4f2f-9b75-7f5a5bd6a959_20260503_083058 - Anwar Khan.jpg	image/jpeg	2235138	2026-05-03 06:00:37.97265
8915e081-7c14-470b-b64b-ddcad6ee8eb3	e237c780-aa39-4331-8860-684d9b869b8f	FRONT	a665a786-8317-4276-9a1b-1081f6808d3e_20260503_083315 - Anwar Khan.jpg	image/jpeg	2516581	2026-05-03 06:00:38.141016
943e5ec9-98f7-4ee5-90bc-fd5931d71b9a	e237c780-aa39-4331-8860-684d9b869b8f	BACK	45daab6f-e814-4ef4-bc2d-7a263c9775a8_20260503_083321 - Anwar Khan.jpg	image/jpeg	2523359	2026-05-03 06:00:38.292862
7ed638cd-e473-4a94-885f-eb82e62f14b2	54354eb0-8a94-427b-bcca-ce321e663e68	FRONT	52eda69e-c50f-46e8-a909-03eb6e88b766_IMG_9051 - Rishikant Soni.jpeg	image/jpeg	1499349	2026-05-04 04:14:55.368805
bc5d60fc-bdfe-4c32-900c-2abdb22b2304	54354eb0-8a94-427b-bcca-ce321e663e68	SIDE	92accb86-9bd2-4e39-bef0-5805cfd66e57_IMG_9068 - Rishikant Soni.jpeg	image/jpeg	1400914	2026-05-04 04:14:55.36881
a63cbd87-e457-4c04-92bb-1e0768f6c24c	54354eb0-8a94-427b-bcca-ce321e663e68	BACK	079b1478-3ff0-4fa5-9d6c-276abfb95e81_IMG_9079 - Rishikant Soni.jpeg	image/jpeg	1512074	2026-05-04 04:14:55.651327
86bdc551-6283-4474-9e82-1b09f0c71626	fcd30426-df26-470d-b419-a5725c8ed9c8	BACK	fd9f36aa-71e4-44cb-bfc8-c21b76c28697_20260511_132631 - Mayank Thakur.jpg	image/jpeg	1960912	2026-05-12 03:25:04.927713
a772850a-0301-4056-80b8-a95be5da1a1f	fcd30426-df26-470d-b419-a5725c8ed9c8	FRONT	f484f995-a6d0-4be9-b124-1f0b1abdb9b2_20260511_132636 - Mayank Thakur.jpg	image/jpeg	2247609	2026-05-12 03:25:06.812718
25ba2f0b-9834-4e49-8ed6-9a8d5a6c8a82	fcd30426-df26-470d-b419-a5725c8ed9c8	SIDE	e24f1f8a-c506-41cb-b4a7-ac29197c0985_20260511_132627 - Mayank Thakur.jpg	image/jpeg	2127789	2026-05-12 03:25:07.01636
5d51a2ca-7912-4f55-aed4-204246947f6a	84816486-778e-4189-a260-c3e9ac7ba662	SIDE	f0365a31-55b9-4781-98bd-d80c9b804cf4_20260211_122600 - Mayank Thakur.jpg	image/jpeg	1906460	2026-05-12 03:39:24.616591
ff7b9bfe-62de-4030-b226-7d635c06942f	84816486-778e-4189-a260-c3e9ac7ba662	BACK	21616f84-9b61-4847-9e40-c8e9e8942590_20260211_122532 - Mayank Thakur.jpg	image/jpeg	2090750	2026-05-12 03:39:25.517435
7de54566-a7bd-4cbf-9489-925e849d4728	84816486-778e-4189-a260-c3e9ac7ba662	FRONT	1c70f1da-a178-4f7c-9e16-f70901722b73_20260211_122500 - Mayank Thakur.jpg	image/jpeg	2135049	2026-05-12 03:39:27.42946
61b9416e-d3f3-4298-9c24-e32e4c74792f	4b923d84-f6e3-465c-8b78-af228a595f1e	FRONT	Nitin Gupta/c746c076-5217-4098-9729-ffc20e4d4845_20260507_121501 - Nitin Gupta.jpg	image/jpeg	3172382	2026-05-22 14:25:36.86426
263bd8eb-4a9e-487c-a274-0431cf92f891	4b923d84-f6e3-465c-8b78-af228a595f1e	SIDE	Nitin Gupta/1e404238-035f-4380-9ebf-544a78d68110_20260507_121507 - Nitin Gupta.jpg	image/jpeg	3531835	2026-05-22 14:25:36.873143
97991ab0-6a19-4221-991a-b47cf1944cf4	4b923d84-f6e3-465c-8b78-af228a595f1e	BACK	Nitin Gupta/1af628ba-d8a9-4cf1-add5-c46add101ec6_20260507_121516 - Nitin Gupta.jpg	image/jpeg	3527251	2026-05-22 14:25:36.893961
6c1abd91-11a9-4c5e-88ad-41d20f4b4dd4	d98f2294-dbf5-4b99-8644-0b38c3eeee22	SIDE	Shreya Verma/3d85a02f-501c-4ea4-9913-ae38ed2afc79_IMG_6031 - Shreya Verma.jpeg	image/jpeg	3226512	2026-05-22 14:27:10.6813
57832a8d-241b-4e47-9290-510242f6a4db	d98f2294-dbf5-4b99-8644-0b38c3eeee22	FRONT	Shreya Verma/422b4119-74e4-4bb1-80c5-8a82546c8fe2_IMG_6030 - Shreya Verma.jpeg	image/jpeg	3109078	2026-05-22 14:27:10.735767
c8962f6d-f636-42ac-a63b-4ff160e790ea	d98f2294-dbf5-4b99-8644-0b38c3eeee22	BACK	Shreya Verma/2be614fe-152a-43cb-acb6-e74cdb25827b_IMG_6032 - Shreya Verma.jpeg	image/jpeg	3189901	2026-05-22 14:27:10.769352
73de4425-3dea-474c-8334-7638e084261a	794f2e43-33a6-4c34-ac22-7cee818f8919	FRONT	Mohit Soni/f2af05e1-e174-4d63-a35f-72d959829c88_WhatsApp Image 2026-05-17 at 15.20.42 - Mohit Soni.jpeg	image/jpeg	206428	2026-05-22 14:28:37.483577
d15f1d24-2ad9-4daf-bfd4-6c64573234b6	794f2e43-33a6-4c34-ac22-7cee818f8919	BACK	Mohit Soni/c3c0f464-ac90-4b6d-8b53-68c657a9c90e_WhatsApp Image 2026-05-17 at 15.20.41 - Mohit Soni.jpeg	image/jpeg	187029	2026-05-22 14:28:37.49253
865c31b5-8e2c-486a-8f43-ebe81deef09a	794f2e43-33a6-4c34-ac22-7cee818f8919	SIDE	Mohit Soni/02a1753b-638e-4884-8642-ee262d031205_WhatsApp Image 2026-05-17 at 15.20.42 - Mohit Soni.jpeg	image/jpeg	206428	2026-05-22 14:28:37.505735
d2e62fa2-44d8-4dee-8261-6d5a063dc397	4faa6816-4bb4-40d0-a7dd-c5b2639b5825	BACK	Prateek Srivastava/42a7c217-da02-4406-828c-c951122fad73_IMG_20260524_092039 - Prateek Srivastava.jpg	image/jpeg	4439171	2026-05-25 11:58:58.621023
98c9286c-95e8-4648-adf0-dfaa84e91622	4faa6816-4bb4-40d0-a7dd-c5b2639b5825	FRONT	Prateek Srivastava/12f3265d-f0bd-4cc6-83ce-ed5ea41c4be4_IMG_20260524_092020 - Prateek Srivastava.jpg	image/jpeg	4339370	2026-05-25 11:58:58.619062
91487292-321f-496a-97d0-fede46bf7be6	4faa6816-4bb4-40d0-a7dd-c5b2639b5825	SIDE	Prateek Srivastava/6f75caf1-c1c4-43af-92e3-9445ec6496ac_IMG_20260524_092216 - Prateek Srivastava.jpg	image/jpeg	4530216	2026-05-25 11:58:58.637716
03811b5b-d24b-4860-82a7-6f4bda9248d7	208e8994-6759-477c-b50b-cf601ea3f371	BACK	Prateek Srivastava/2bdc63d9-d688-4904-abcc-0dc73204ccdb_IMG_20260509_123907 - Prateek Srivastava.jpg	image/jpeg	781197	2026-05-25 12:05:11.129257
72026406-aab4-4734-8f75-b82cfe377f9b	208e8994-6759-477c-b50b-cf601ea3f371	SIDE	Prateek Srivastava/d3ccfbce-d981-4449-bc8e-6e10915c2810_IMG_20260509_123923 - Prateek Srivastava.jpg	image/jpeg	908980	2026-05-25 12:05:11.129257
ab1da653-417d-4b47-ae1a-1638b8d2871b	208e8994-6759-477c-b50b-cf601ea3f371	FRONT	Prateek Srivastava/ec66074d-2804-4cae-87b0-c89d5c957e79_IMG_20260509_123852 - Prateek Srivastava.jpg	image/jpeg	680843	2026-05-25 12:05:11.129271
ef202aaa-972f-4a89-bfe6-1d2f2ab66e05	5ea95ec0-e8cb-46a3-a7f8-f24c4d09e288	BACK	ANWAR KHAN/40d58bbd-ee26-4109-ab8e-364556129aca_20260524_082820 - Anwar Khan.heic	application/octet-stream	1540393	2026-05-25 13:31:43.791806
ca58f38f-1d04-4d23-91ed-f6cd5971913f	5ea95ec0-e8cb-46a3-a7f8-f24c4d09e288	SIDE	ANWAR KHAN/26ca9f87-9ed2-416d-9e84-2a43be1c3b28_20260524_082826 - Anwar Khan.heic	application/octet-stream	1536899	2026-05-25 13:31:43.791808
891c0a1c-d1a3-437e-abf1-379126bd02c8	5ea95ec0-e8cb-46a3-a7f8-f24c4d09e288	FRONT	ANWAR KHAN/2d6d1b57-94b7-457d-83ee-53be4ba86995_20260524_082835 - Anwar Khan.heic	application/octet-stream	1782746	2026-05-25 13:31:43.809661
eca2f15d-4204-4f0b-aeb6-d853171b7584	f64a89a7-b224-40ca-90e0-203fd1a4f049	SIDE	ANWAR KHAN/36d1f0d8-3f78-46a4-a285-46f70fba7fe4_20260524_082826 - Anwar Khan.jpg	image/jpeg	1861477	2026-05-25 13:40:25.170818
6a5cdb8e-9926-4e6b-84aa-29e50564d806	f64a89a7-b224-40ca-90e0-203fd1a4f049	BACK	ANWAR KHAN/67277d41-170b-418f-aa58-55085b288d5f_20260524_082820 - Anwar Khan.jpg	image/jpeg	1766354	2026-05-25 13:40:25.170682
5d467a7a-6778-4d8e-8800-a8fa65321953	f64a89a7-b224-40ca-90e0-203fd1a4f049	FRONT	ANWAR KHAN/6c9094e0-fc72-4bd6-9dc3-a17ac9148bc0_20260524_082835 - Anwar Khan.jpg	image/jpeg	2062521	2026-05-25 13:40:25.212109
da832ce6-8997-43c5-9c22-4f69a74fec42	fb09f5a4-094b-4518-9baa-4b7065ca173a	BACK	ANWAR KHAN/46da40b4-0b7d-40ca-9a27-810907d0cb45_20260517_124613 - Anwar Khan.jpg	image/jpeg	1849396	2026-05-25 13:42:40.434791
1f94be8a-de04-4317-b2b9-eb89e40334d1	fb09f5a4-094b-4518-9baa-4b7065ca173a	SIDE	ANWAR KHAN/cfe1642b-d7f7-4347-b12d-7da5614fb9d2_20260517_124526 - Anwar Khan.jpg	image/jpeg	1988796	2026-05-25 13:42:40.459694
391cd8e2-b3d2-4685-af00-029ae82ef639	fb09f5a4-094b-4518-9baa-4b7065ca173a	FRONT	ANWAR KHAN/6858e6ee-4894-4e52-b2ed-3d80a884b7c7_20260517_124519 - Anwar Khan.jpg	image/jpeg	2153355	2026-05-25 13:42:40.490687
7e42a8f9-f5c5-4a5f-b8f0-85583f3a5df8	85f3bd0e-f3cb-4d3d-9e32-2d0f849d472b	FRONT	Prashant Kumar/bea87b99-76b8-4b07-ae1f-fa9a8691f259_20260530_195707 - Prashant Kumar.jpg	image/jpeg	1151762	2026-05-31 05:44:57.977199
b2237414-833c-4b95-b502-2bb94a7a8603	85f3bd0e-f3cb-4d3d-9e32-2d0f849d472b	BACK	Prashant Kumar/017d6d30-e017-43bb-b25c-53e8ef8f88e4_20260530_195440 - Prashant Kumar.jpg	image/jpeg	1379393	2026-05-31 05:44:57.977199
660dbdee-2d7b-4a4f-b143-b3c3eafa2cc0	85f3bd0e-f3cb-4d3d-9e32-2d0f849d472b	SIDE	Prashant Kumar/48a675f1-dd3b-40a3-bef2-21c5afa7ffd6_20260530_195043 - Prashant Kumar.jpg	image/jpeg	1184751	2026-05-31 05:44:57.977478
36d34141-c660-4f5e-823b-010e531f37a8	e72e8b3b-4990-463d-8a35-d7ed9894e5ec	SIDE	Prashant Kumar/5b99fa2d-2765-4f97-a254-663d0372c321_20260218_192646 - Prashant Kumar.jpg	image/jpeg	1183427	2026-05-31 05:47:07.032035
1a80f332-5299-46d9-9a36-d1510244d3e3	e72e8b3b-4990-463d-8a35-d7ed9894e5ec	FRONT	Prashant Kumar/4bc9584c-0141-4cac-9525-535dbb311f5b_20260218_192601(1) - Prashant Kumar.jpg	image/jpeg	1318455	2026-05-31 05:47:07.040297
60c7697b-1735-4f44-b158-8c6e8889b6a3	e72e8b3b-4990-463d-8a35-d7ed9894e5ec	BACK	Prashant Kumar/53d2a763-0c07-4892-ba62-81f241d90b37_20260218_192656(1) - Prashant Kumar.jpg	image/jpeg	1420422	2026-05-31 05:47:07.125135
43cdf258-5e1e-4cba-8a93-c9f9303639a3	d1b72734-d2ce-4d37-aa40-337f50ae3833	FRONT	Nitin Gupta/9a01427c-db51-4218-8f8a-031f396ebf2d_20260530_213333 - Nitin Gupta.jpg	image/jpeg	3265339	2026-06-01 03:29:02.661689
69a1b4f1-316d-4b02-a65e-c7f81d03e45b	d1b72734-d2ce-4d37-aa40-337f50ae3833	BACK	Nitin Gupta/c52df50a-f20e-4d4b-a5b8-577400a9b865_20260530_213345 - Nitin Gupta.jpg	image/jpeg	3278211	2026-06-01 03:29:02.68467
18f03c57-a6d8-4c6d-89d2-f1cc738c9ff1	d1b72734-d2ce-4d37-aa40-337f50ae3833	SIDE	Nitin Gupta/89ad78db-411a-4126-afaa-708e74454a9b_20260530_213337 - Nitin Gupta.jpg	image/jpeg	3218617	2026-06-01 03:29:02.703634
e7972a5a-6833-4acf-be43-bc6dd31a8591	132c9d97-f86f-4ce8-a893-68343741ccdc	SIDE	Shreya Verma/0d3ad09c-1922-4131-980f-c68af6474d85_IMG_6184 - Shreya Verma.jpeg	image/jpeg	3169184	2026-06-01 03:29:45.193121
b3fa6da3-6d83-4ef3-a8b6-920438a4686e	132c9d97-f86f-4ce8-a893-68343741ccdc	BACK	Shreya Verma/632a20d7-4f43-4649-9c91-cb1df311998e_IMG_6185 - Shreya Verma.jpeg	image/jpeg	3167428	2026-06-01 03:29:45.207725
034db09a-bbbd-421a-9aeb-91cfce86852f	132c9d97-f86f-4ce8-a893-68343741ccdc	FRONT	Shreya Verma/d09cf35b-b686-4a61-8754-f6f68f081e6c_IMG_6186 - Shreya Verma.jpeg	image/jpeg	3155420	2026-06-01 03:29:45.212079
be0a0d29-e6f8-4b4d-a1bc-996871ee86c0	c8dab46c-d866-4e80-a6d6-6cc5d60c3920	BACK	Khushbu Sahu/a24134b1-99dc-4fff-8583-6d975c108271_IMG_20260531_233034258_HDR - Dr Khushbu Ganjir.jpg	image/jpeg	1457212	2026-06-01 03:34:47.02424
32a79255-7017-424c-983f-44ef7e2fe254	c8dab46c-d866-4e80-a6d6-6cc5d60c3920	SIDE	Khushbu Sahu/0898b40d-e386-41d0-a29d-51ab0760a9c9_IMG_20260531_233030016_HDR - Dr Khushbu Ganjir.jpg	image/jpeg	1500199	2026-06-01 03:34:47.039526
28e3d8ba-fecd-4257-8569-0c49e0ec928f	c8dab46c-d866-4e80-a6d6-6cc5d60c3920	FRONT	Khushbu Sahu/2cb6432c-7dc7-4591-b7dc-fbf5dc43627b_IMG_20260531_233026280_HDR - Dr Khushbu Ganjir.jpg	image/jpeg	1508139	2026-06-01 03:34:47.051604
9204ce80-4de9-4d9d-ad17-8912a9a9b6ba	a847fc03-2fbd-407a-a833-c9afa77d9f58	SIDE	Shailesh Kumar Sahu/16060241-abe5-4086-a616-81e738895b87_IMG_9234 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4448912	2026-06-01 03:35:17.151929
d9aa3e33-3a1f-46b1-826b-a8086938b198	a847fc03-2fbd-407a-a833-c9afa77d9f58	BACK	Shailesh Kumar Sahu/61c782e8-a8d3-4d5a-b088-513a3315bf28_IMG_9235 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4517777	2026-06-01 03:35:17.187788
bcb50824-6e7f-430c-ba6e-78c9e2146083	a847fc03-2fbd-407a-a833-c9afa77d9f58	FRONT	Shailesh Kumar Sahu/9d0d395b-5e0d-46a7-8d85-84b9e17109b9_IMG_9233 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4738126	2026-06-01 03:35:17.205871
86240873-3849-4e67-9b0b-635cf0ecb64d	f38dc64b-4ad9-4275-af5d-f840eea12511	FRONT	Khushbu Sahu/02984ad8-a0e7-4ccf-900b-11ef7932feb7_IMG-20260322-WA0007 - Dr Khushbu Ganjir.jpg	image/jpeg	913349	2026-06-01 03:44:32.633269
52b9c717-e74c-4645-b063-362a5c3570ce	f38dc64b-4ad9-4275-af5d-f840eea12511	BACK	Khushbu Sahu/7537cac0-38ef-44ed-8f8d-de298ed20625_IMG-20260322-WA0010 - Dr Khushbu Ganjir.jpg	image/jpeg	1023228	2026-06-01 03:44:32.652611
d90a6abd-f5a4-4b82-a675-9c4723ca09a5	f38dc64b-4ad9-4275-af5d-f840eea12511	SIDE	Khushbu Sahu/429586a1-2498-4c33-a5b0-cfdad2f77305_IMG-20260322-WA0008 - Dr Khushbu Ganjir.jpg	image/jpeg	932909	2026-06-01 03:44:32.667345
baa5a84a-6c52-454d-bd19-f90d6dedcd4f	f65dfeb7-efcf-45cf-9004-1bdc6690a13c	SIDE	Shailesh Kumar Sahu/55c9989d-1177-4dc4-ba05-2391e910008f_IMG_8299 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4478493	2026-06-01 03:54:27.215245
3d3ad079-fd0d-42c2-9ff5-c4c940414855	f65dfeb7-efcf-45cf-9004-1bdc6690a13c	BACK	Shailesh Kumar Sahu/a822827a-cd4c-4eba-bb93-9ef11a285e29_IMG_8300 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4656389	2026-06-01 03:54:27.235912
4e9e6bc6-1e6f-4394-b74b-9bf9c19d0818	f65dfeb7-efcf-45cf-9004-1bdc6690a13c	FRONT	Shailesh Kumar Sahu/6d18c24d-cdcf-4b4e-b3da-d71eef063370_IMG_8298 - SHAILESH KUMAR SAHU.jpeg	image/jpeg	4727058	2026-06-01 03:54:27.337261
beec39db-2994-4b3b-b290-bd6bc000b992	cc84ded5-d4e8-4c31-a873-0e46e8fc7635	FRONT	Sudhanshu Shekhar Singh/cb48ebcb-5fb0-493f-8c7e-d8f36fec29e3_17808922097358150028138910001038 - Sudhanshu Shekhar Singh.jpg	image/jpeg	2719200	2026-06-08 08:07:15.012843
845fd1e2-520b-4564-9fe2-2a00ddba7582	cc84ded5-d4e8-4c31-a873-0e46e8fc7635	SIDE	Sudhanshu Shekhar Singh/66ea454a-40a2-4499-af2b-1d11ac79663a_17808922928652175403487382822896 - Sudhanshu Shekhar Singh.jpg	image/jpeg	1694845	2026-06-08 08:07:14.970343
a87cbaeb-7550-400b-b6c3-4c076f7229bc	cc84ded5-d4e8-4c31-a873-0e46e8fc7635	BACK	Sudhanshu Shekhar Singh/6e096185-a8ea-47aa-8fc9-44467ee0906b_17808922576539152506482987722146 - Sudhanshu Shekhar Singh.jpg	image/jpeg	4150799	2026-06-08 08:07:15.381822
e98956ee-5b5a-4bfa-9861-4e66096a3f7b	0ba2aba0-f120-4209-ac7f-fa2da61e71e8	BACK	Sudhanshu Shekhar Singh/0445be37-05fc-4047-8207-4c6401c5a345_IMG_20260425_213135 - Sudhanshu Shekhar Singh.jpg	image/jpeg	1254951	2026-06-08 08:09:27.989355
80282140-3ef1-44b8-b8d1-a86a74b13850	0ba2aba0-f120-4209-ac7f-fa2da61e71e8	FRONT	Sudhanshu Shekhar Singh/d2512a80-eb1b-4320-b1ea-87f23f81e017_IMG_20260425_213207 - Sudhanshu Shekhar Singh.jpg	image/jpeg	1323202	2026-06-08 08:09:28.010765
4f352749-638c-477e-ab79-565e8ca4e8ad	0ba2aba0-f120-4209-ac7f-fa2da61e71e8	SIDE	Sudhanshu Shekhar Singh/d3fb0b4f-d167-4514-b1e0-d582cd23aeaa_IMG_20260425_213152 - Sudhanshu Shekhar Singh.jpg	image/jpeg	2415173	2026-06-08 08:09:28.089942
2129c36d-15a6-42b2-ac1f-522974f10ef8	d2a12fef-93d7-4a3d-9964-c0a1e6675992	FRONT	Sudhanshu Shekhar Singh/d859c2cf-adc1-4c4e-b2c5-d67652e42c86_IMG_20260425_213207 - Sudhanshu Shekhar Singh.jpg	image/jpeg	1323202	2026-06-08 08:10:32.959764
a7cef8e2-bae7-406f-bd34-0ca7caf786ae	d2a12fef-93d7-4a3d-9964-c0a1e6675992	BACK	Sudhanshu Shekhar Singh/fc650867-30fb-4d3d-8e67-b77fd43a5c20_IMG_20260425_213135 - Sudhanshu Shekhar Singh.jpg	image/jpeg	1254951	2026-06-08 08:10:32.959764
f08673ce-beb7-4b0a-a1b0-2c9f4b46bf80	d2a12fef-93d7-4a3d-9964-c0a1e6675992	SIDE	Sudhanshu Shekhar Singh/f039e04a-2840-45d3-b62e-a15693009935_IMG_20260425_213152 - Sudhanshu Shekhar Singh.jpg	image/jpeg	2415173	2026-06-08 08:10:33.116079
72360f32-36cc-4e52-9b43-80952ec6ade8	2d82f587-df92-4593-9c99-4059797320f7	SIDE	Prakhar Tamboli/0e073e8e-67ba-4b66-8548-5fdac5434f60_IMG-20260525-WA0001 - prakhar tamboli.jpg	image/jpeg	97559	2026-06-20 04:01:18.614467
b335e02e-fc4e-4e38-9f67-064b0813d4b1	2d82f587-df92-4593-9c99-4059797320f7	BACK	Prakhar Tamboli/0c1fd611-1e91-42d9-b52e-9f4d827ec295_IMG-20260525-WA0001 - prakhar tamboli (1).jpg	image/jpeg	97559	2026-06-20 04:01:18.614467
58b011a5-65b1-4575-bc4b-a45ba9e368c0	2d82f587-df92-4593-9c99-4059797320f7	FRONT	Prakhar Tamboli/e071a9a7-a3fc-487e-84cf-b2c5ed6ebc55_IMG-20260525-WA0003 - prakhar tamboli.jpg	image/jpeg	120821	2026-06-20 04:01:18.636483
b75d046f-f4c5-4de2-985e-d3199956fad1	ecdd4643-a451-454a-b296-6f3a1c578b2f	FRONT	Prateek Srivastava/574634c3-09fa-4ca8-a978-54c7919c125d_IMG_20260606_210407 - Prateek Srivastava.jpg	image/jpeg	4108734	2026-06-21 08:59:16.953944
82673e3d-4724-436b-a7ea-584b741a3567	ecdd4643-a451-454a-b296-6f3a1c578b2f	SIDE	Prateek Srivastava/8a91ffe6-0ff0-44ad-9743-c8599481ff68_IMG_20260606_210451 - Prateek Srivastava.jpg	image/jpeg	4370638	2026-06-21 08:59:16.953947
a0799e24-9ddb-473f-846a-da9dcd252ea8	ecdd4643-a451-454a-b296-6f3a1c578b2f	BACK	Prateek Srivastava/5a19f668-ee5e-45f9-aacb-671644e0e056_IMG_20260606_210502 - Prateek Srivastava.jpg	image/jpeg	4071030	2026-06-21 08:59:16.953947
fc005182-f663-443b-ae9f-1d1ae2ef7d40	5d19ad29-9142-455b-9b3a-8c2757f89b63	BACK	Nitin Gupta/e8ac9bec-7016-4ee3-8465-56ca4737d26c_20260620_101640 - Nitin Gupta.jpg	image/jpeg	3581057	2026-06-28 08:33:19.836515
1a22f8ec-be0f-443c-98c8-b0bc260a0ad8	5d19ad29-9142-455b-9b3a-8c2757f89b63	SIDE	Nitin Gupta/b6f691f2-40c8-4a0a-8980-d7f8a50fdcd5_20260620_101644 - Nitin Gupta.jpg	image/jpeg	3610955	2026-06-28 08:33:19.840033
57b2b05a-7fbe-44d0-946a-4b70f942db85	5d19ad29-9142-455b-9b3a-8c2757f89b63	FRONT	Nitin Gupta/5f23f18b-d004-4d08-9313-7c0883a67554_20260620_101631 - Nitin Gupta.jpg	image/jpeg	3530136	2026-06-28 08:33:19.836515
bccbead1-2899-4873-b795-92c94272bad7	31ad568d-14ad-4444-8800-4cacc4074a89	BACK	ANWAR KHAN/0eaee706-8afd-4e9f-b653-8c8c7751de0b_20260628_124834 - Anwar Khan.jpg	image/jpeg	1263320	2026-06-30 04:02:43.409351
271c20da-8459-4e73-8821-b53b129b9523	31ad568d-14ad-4444-8800-4cacc4074a89	FRONT	ANWAR KHAN/1fc88202-04bd-418a-8338-a44a450b3a87_20260628_124822 - Anwar Khan.jpg	image/jpeg	1651303	2026-06-30 04:02:43.426868
a786e721-a38a-467a-b305-b5ffe46554ac	31ad568d-14ad-4444-8800-4cacc4074a89	SIDE	ANWAR KHAN/6bcf929f-fd04-420d-8506-cfde39d05b76_20260628_124828 - Anwar Khan.jpg	image/jpeg	1794886	2026-06-30 04:02:43.433421
3421128c-c8dc-4cf6-b7c0-b1e717e4c9fe	f5364b82-f45e-4661-87d7-b626f1c90488	FRONT	Prateek Srivastava/f68744e8-d128-4e1c-b256-11fa67dd7abe_IMG_20260628_134938 - Prateek Srivastava.jpg	image/jpeg	3668348	2026-06-30 04:20:21.823303
7cfa2cc3-09f4-4f1f-b529-83ed3fafbbcb	f5364b82-f45e-4661-87d7-b626f1c90488	SIDE	Prateek Srivastava/a25fd2d5-9c43-4212-a7cd-39bca7b32293_IMG_20260628_134948 - Prateek Srivastava.jpg	image/jpeg	4578685	2026-06-30 04:20:21.849042
f14ca9da-9abb-4add-9fcb-4a77960b8b66	f5364b82-f45e-4661-87d7-b626f1c90488	BACK	Prateek Srivastava/4f56fb69-1713-4d6f-8d7c-c7a1fbaa267d_IMG_20260628_134944 - Prateek Srivastava.jpg	image/jpeg	4354453	2026-06-30 04:20:21.874788
924d2371-67cb-4660-8616-5eec809077a7	655f18ac-086d-4934-8573-4033c598badd	SIDE	Prakhar Tamboli/2601575e-c555-474e-8d83-168f18dd47b5_IMG_4409 - prakhar tamboli.jpeg	image/jpeg	1644433	2026-07-01 13:47:09.777321
3277171f-4759-4a7c-ba37-3aeaacd328c7	655f18ac-086d-4934-8573-4033c598badd	BACK	Prakhar Tamboli/976bc998-d6c7-4814-a08d-28d0e64cd292_IMG_4411 - prakhar tamboli.jpeg	image/jpeg	1363322	2026-07-01 13:47:09.761855
b863f39f-50d1-4199-9222-e94f9e70f799	655f18ac-086d-4934-8573-4033c598badd	FRONT	Prakhar Tamboli/c309eef9-5c0d-4d6c-9aea-8f548612b348_IMG_4408 - prakhar tamboli.jpeg	image/jpeg	4242311	2026-07-01 13:47:10.407803
357f072d-e9ae-46b2-9229-d6d0972d9eec	e870e531-ddb8-4c58-aef1-a47d2614628a	BACK	Shilpa Bhadang/2cb2d8d9-8366-41e0-b9a1-df74305e46be_WhatsApp Image 2026-06-29 at 12.10.43 PM - Varun Deoghare.jpeg	image/jpeg	137975	2026-07-05 09:45:49.994759
b55d9eee-0f67-492c-8106-c340c69e0db8	e870e531-ddb8-4c58-aef1-a47d2614628a	FRONT	Shilpa Bhadang/c8a21a41-bd74-4aed-89e4-ca01ad08e254_WhatsApp Image 2026-06-29 at 12.10.41 PM - Varun Deoghare.jpeg	image/jpeg	160400	2026-07-05 09:45:49.994759
878855e3-0cb4-4fd8-aee2-2977d1d9bd44	e870e531-ddb8-4c58-aef1-a47d2614628a	SIDE	Shilpa Bhadang/8fdc17af-7733-4adb-b991-cf71bcdbac1a_WhatsApp Image 2026-06-29 at 12.10.42 PM - Varun Deoghare.jpeg	image/jpeg	150896	2026-07-05 09:45:49.994759
6069c9b0-18b5-410c-834a-6c932c4e07ed	7e8186c4-6148-4ebe-9e53-663b9ba5f297	BACK	Prateek Srivastava/682eaba8-3820-4d76-8960-47fcdbf320ce_IMG_20260712_105217 - Prateek Srivastava (1).jpg	image/jpeg	4498591	2026-07-13 04:34:36.712749
6cf8967b-56b4-4f16-85e8-acdbbfbee2df	7e8186c4-6148-4ebe-9e53-663b9ba5f297	FRONT	Prateek Srivastava/441307c7-cc5a-45da-bf44-32b681656e52_IMG_20260712_105211 - Prateek Srivastava (2).jpg	image/jpeg	4253464	2026-07-13 04:34:36.703897
b3d56668-6b9b-4e23-b02c-36f7a197779a	7e8186c4-6148-4ebe-9e53-663b9ba5f297	SIDE	Prateek Srivastava/89613812-26ed-444b-bc36-2001ce020401_IMG_20260712_105221 - Prateek Srivastava (1).jpg	image/jpeg	4657462	2026-07-13 04:34:36.737143
b54df4d1-8f16-4ecb-811e-0cfc18d1c8c4	2499887c-33fa-4f8c-9705-b962c6c2d22a	FRONT	ANWAR KHAN/ae645d4b-5e13-4b81-8946-77f94f1dd4ba_20260712_103241 - Anwar Khan.jpg	image/jpeg	1496662	2026-07-13 04:50:54.346267
098b3216-e10e-45ce-b3c5-aed60c130a15	2499887c-33fa-4f8c-9705-b962c6c2d22a	BACK	ANWAR KHAN/ef874b10-5d11-478f-a7b9-98caaec60dba_20260712_103253 - Anwar Khan.jpg	image/jpeg	1433784	2026-07-13 04:50:54.349835
466400fd-808e-4d5e-8997-7fa8a372c0c0	2499887c-33fa-4f8c-9705-b962c6c2d22a	SIDE	ANWAR KHAN/4020e98a-a179-40af-acd1-015ac013cf04_20260712_103246 - Anwar Khan.jpg	image/jpeg	1769242	2026-07-13 04:50:54.364971
c5c68687-c171-4e3d-9aca-0da2c51a64a9	43a89989-938b-405f-8247-91c851aeb985	SIDE	Prashant Kumar/864d02e5-6c3e-471c-9029-befc8eaf2add_20260712_220411 - Prashant Kumar.jpg	image/jpeg	768451	2026-07-13 12:42:36.700108
d6d92a3e-c62b-49b0-9b1e-513b7a4954b8	43a89989-938b-405f-8247-91c851aeb985	FRONT	Prashant Kumar/53845216-ab34-4ad2-b968-006c34e55a7e_20260712_220350 - Prashant Kumar.jpg	image/jpeg	1039133	2026-07-13 12:42:36.708137
ffbf651b-5a18-45d8-befc-2674922c2a48	43a89989-938b-405f-8247-91c851aeb985	BACK	Prashant Kumar/1b32f0c9-46af-4638-aa07-3f9938b0e973_20260712_220356 - Prashant Kumar.jpg	image/jpeg	1314705	2026-07-13 12:42:36.721784
f4fa478e-652b-479f-8eb7-8bcd427a014d	f96d1c87-4e7b-484f-81bb-6192be0c687f	SIDE	Prakhar Tamboli/dcc78506-e1e2-4850-94e5-fd6c46de8b9f_IMG_4725 - prakhar tamboli.jpeg	image/jpeg	1453933	2026-07-18 07:57:07.462797
01276475-ed78-4f25-b415-9803f225ce26	f96d1c87-4e7b-484f-81bb-6192be0c687f	BACK	Prakhar Tamboli/5f952ba4-b190-4331-84ae-25c0672c9b8d_IMG_4731 - prakhar tamboli.jpeg	image/jpeg	1405906	2026-07-18 07:57:07.462795
aea5e631-8ebf-4b6c-8525-8b8e791acbb3	f96d1c87-4e7b-484f-81bb-6192be0c687f	FRONT	Prakhar Tamboli/c9996f8b-1cd5-45d7-ba6d-b469c0daa75d_IMG_4714 - prakhar tamboli.jpeg	image/jpeg	1391131	2026-07-18 07:57:07.462795
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
4b923d84-f6e3-465c-8b78-af228a595f1e	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	80.00	\N	\N	\N		2026-05-06 18:30:00	\N
794f2e43-33a6-4c34-ac22-7cee818f8919	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	76.00	\N	\N	\N		2026-05-21 18:30:00	\N
d98f2294-dbf5-4b99-8644-0b38c3eeee22	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	67.00	\N	\N	\N		2026-05-06 18:30:00	\N
4faa6816-4bb4-40d0-a7dd-c5b2639b5825	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	65.10	9	\N	10000	Maintain the same for next 2 weeks. Focus on Warmup exercises in the plan	2026-05-24 09:24:58.75	7
fb09f5a4-094b-4518-9baa-4b7065ca173a	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	94.50	9	\N	12000		2026-05-17 12:52:30.066	7
f64a89a7-b224-40ca-90e0-203fd1a4f049	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	94.60	9	\N	10000	Maintain 12k+ steps strictly	2026-05-24 12:18:12.219	7
85f3bd0e-f3cb-4d3d-9e32-2d0f849d472b	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	66.80	7	\N	7089	Good progress overall. reduced Waistline and abdominal fat.\nMaintain consistency and increase daily steps to 12k	2026-05-30 20:04:38.554	6
2d82f587-df92-4593-9c99-4059797320f7	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	88.00	0	\N	0	First checkin	2026-06-19 18:30:00	1
d1b72734-d2ce-4d37-aa40-337f50ae3833	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	80.00	7	\N	5000	Good start. \nFocus now on improving consistency with Workouts, hitting the 8k daily step target.	2026-05-31 11:16:07.574	6
132c9d97-f86f-4ce8-a893-68343741ccdc	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	67.00	7	\N	4000	Good start\nIncrease steps to 6K/day, and focus on workout consistency.	2026-05-31 23:01:25.296	5
a847fc03-2fbd-407a-a833-c9afa77d9f58	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	116.00	6	\N	6000	Focus on hitting daily step targets of 10K, improving workout consistency.	2026-05-31 23:36:59.891	6
c8dab46c-d866-4e80-a6d6-6cc5d60c3920	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	57.80	7	\N	6000	Focus on improving workout attendance, hitting 8k daily steps.	2026-05-31 23:33:28.094	5
ecdd4643-a451-454a-b296-6f3a1c578b2f	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	65.00	6	\N	10000	Get consistent with workouts	2026-06-06 21:16:17.968	7
cc84ded5-d4e8-4c31-a873-0e46e8fc7635	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	73.00	6	\N	13000	Get consistent with workout and steps	2026-06-08 09:48:59.899	6
5d19ad29-9142-455b-9b3a-8c2757f89b63	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	79.00	7	\N	7	Visible improvements around your waist, chest, and overall physique\nContinue following the current workout and nutrition plan consistently.	2026-06-20 10:18:18.434	6
31ad568d-14ad-4444-8800-4cacc4074a89	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	93.50	5	\N	12000	Good Progress. Visible improvement in overall physique\nKeep everything same for now. Will aim for progressive overload now	2026-06-28 13:07:56.72	7
f5364b82-f45e-4661-87d7-b626f1c90488	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	66.10	5	\N	8000	Good improvements. Try increase diet adherence to 8-9\nKeep everything same for now. Will focus on training quality	2026-06-28 13:53:56.848	7
655f18ac-086d-4934-8573-4033c598badd	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	88.00	8	\N	5400	Excellent start\nFocus on maintain your nutrition and step consistency\nNo change for now	2026-06-30 19:17:38.846	5
e870e531-ddb8-4c58-aef1-a47d2614628a	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	68.00	1	\N	0	First checkin	2026-07-04 18:30:00	1
7e8186c4-6148-4ebe-9e53-663b9ba5f297	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	67.00	6	\N	10000	Good progress. For next 2 weeks we will track the loads of all the workouts.	2026-07-12 12:18:33.949	7
2499887c-33fa-4f8c-9705-b962c6c2d22a	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	93.00	8	\N	10000	Good progress. Keep everything the same for now. Focus on maintaining 12k daily steps.	2026-07-12 18:27:16.183	7
43a89989-938b-405f-8247-91c851aeb985	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	67.10	6	\N	8000		2026-07-12 22:09:08.204	6
f96d1c87-4e7b-484f-81bb-6192be0c687f	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	87.00	8	\N	5700	Excellent Progress. Changes are clearly looking visible now.\nFocus on reaching an average of 6,000 steps per day	2026-07-13 21:01:29.684	6
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

\unrestrict SkaxMzRCsvAhuTx0R1pOrXH4stmNrIzd1sIJMHG6SqwM72WRcOIl6YFHguA4732

--
-- Database "coach_diet" dump
--

--
-- PostgreSQL database dump
--

\restrict eamFVll2cnpFTLGUSVuKJbrH0uGhEekTjsR1bWv5V79e2e8n8L04dzsV3cdsc7N

-- Dumped from database version 15.18 (Debian 15.18-1.pgdg13+1)
-- Dumped by pg_dump version 15.18 (Debian 15.18-1.pgdg13+1)

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

\unrestrict eamFVll2cnpFTLGUSVuKJbrH0uGhEekTjsR1bWv5V79e2e8n8L04dzsV3cdsc7N
\connect coach_diet
\restrict eamFVll2cnpFTLGUSVuKJbrH0uGhEekTjsR1bWv5V79e2e8n8L04dzsV3cdsc7N

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
b6a1fa02-c586-4272-af78-f72c88449da0	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	Fat Loss Vaishnavi Phase 1		2026-03-22 11:34:44.416099	2026-03-24 13:53:04.651586
f6473eb1-e9e8-480c-8015-3a21f7b98e3a	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	Fat Loss Mayank Phase 1(Drop 10 Kgs)		2026-03-21 08:49:02.376483	2026-03-24 13:59:33.706005
99a28bc0-ca4e-499f-bc22-cf6503583fcf	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	Fat Loss Phase 1 Shreya		2026-05-14 13:10:59.868721	2026-05-14 13:29:59.109748
572877d5-29fe-45ea-a926-f93cce8b9a17	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	Fat Loss Phase 1 Nitin		2026-05-14 03:05:52.031886	2026-05-14 13:30:12.945688
f50b542a-14af-4566-aca7-4132382ccd6d	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	Fat Loss Phase 1 Shilpa		2026-07-05 10:17:01.4123	2026-07-06 03:09:09.149163
c38b321b-4375-47ce-bc95-8c8f53e41d49	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	Fat Loss Phase 1 Aman		2026-07-09 15:14:54.455511	2026-07-10 03:42:30.305593
e6451798-b8c0-474b-8355-c08ba786dffc	57ee19de-9c3f-49bf-83d2-20a56100a64e	varun.deoghare@gmail.com	Fat Loss Phase 1 Bhagwati		2026-05-24 13:00:44.700296	2026-05-24 13:54:36.070495
a4cc86ac-98ee-4f6d-ad75-1e7a44923dac	6ae0f3fa-0233-4160-ba88-11f4b8ae7e38	varun.deoghare@gmail.com	Fat Loss Phase 1 Jitendra		2026-05-24 13:34:31.342239	2026-05-25 05:06:55.535776
5016bd40-5cad-41b4-99dd-d8fc560908ff	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	Recomping Phase 1		2026-03-22 06:27:40.471627	2026-05-25 12:18:15.013568
49b039ed-c1af-444d-918d-339bea30d983	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	Fat Loss Phase 1 Prakhar		2026-05-29 14:36:16.277467	2026-05-30 13:27:00.671941
95e86798-dfa5-411b-b2c9-bffdc9745f6b	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	Fat Loss Khushbu Phase 1		2026-03-28 11:25:26.892291	2026-06-01 06:06:28.963269
85e2b7b2-318b-437c-873d-f2fac41559f9	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	Fat Loss Phase 1 Prashant		2026-05-17 07:41:03.50547	2026-06-01 12:08:21.080092
aaffa140-c51f-458e-ad57-9dd67260fc39	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	Fat Loss Phase 1 Mohit		2026-05-21 14:06:52.107251	2026-06-10 04:20:48.127166
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
fbe534ea-1113-439a-8ab0-abf506bfbe37	1 Raisin	2.00	0.40	0.02	0.00	CARBOHYDRATES	2026-05-25 12:14:06.987399	\N
385e8d4f-b63c-4bb7-819c-389bdaf3241f	1 Anjeer	25.00	6.00	0.30	0.10	CARBOHYDRATES	2026-05-25 12:15:15.31925	\N
bc39f231-62d1-4fc7-9819-0d6e3cd8d0d5	1 Date	23.00	6.00	0.00	0.20	CARBOHYDRATES	2026-06-01 12:03:27.933476	\N
26000406-838d-4825-b70d-347704aef9c3	100g High Protein Oats	380.00	65.00	22.00	10.00	CARBOHYDRATES	2026-06-10 04:08:27.55668	\N
281bca46-960c-4de3-ad82-40032c0a0cbc	250ml High Protein Milk	163.00	8.90	13.90	8.00	FATS	2026-06-10 04:09:08.834532	\N
\.


--
-- Data for Name: meal_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meal_items (id, meal_id, food_name, unit, quantity, protein, carbs, fat, calories) FROM stdin;
b643fb52-f80e-4d4e-bef0-32490d11de71	939208d1-c9b0-46ea-9d35-139f58723677	60g Poha/Oats/Upma/Daliya/Vermicelli	g	60	4	51	0	219
33d2219d-7676-4233-9ba1-f5748b000721	939208d1-c9b0-46ea-9d35-139f58723677	1 whole egg	whole	1	6	0	5	75
28d5820e-fb45-435a-aaa2-6de857d351a5	939208d1-c9b0-46ea-9d35-139f58723677	2 egg white	egg	2	6	0	0	34
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
0b942363-f503-40b0-9133-7c80f5d4dab6	939208d1-c9b0-46ea-9d35-139f58723677	200 ml Full Cream Milk for Tea	ml	200	6	9	6	128
5db24fff-c039-453d-b9ae-27586f5b8d6e	939208d1-c9b0-46ea-9d35-139f58723677	5g Sugar	g	5	0	20	0	20
c6ec9c30-c0af-424d-aac0-a3589cbf6467	98a8048a-eb67-4c2f-8c67-7dcc3e1d84e5	Cooking Oil	g	5	0	0	5	44
40ca2b5d-c875-4a24-b53d-deeb11d96c00	939208d1-c9b0-46ea-9d35-139f58723677	5g Cooking Oil/Ghee	g	5	0	0	5	44
057879f2-97ad-45dd-8842-a3357436824d	bb166d76-1ec7-4a6c-bff6-d3258d447a4e	60g Rice/Wheat Flour (Roti)	g	60	5	46	0	216
b3337366-625c-4afa-8ba4-7d10c63acd33	bb166d76-1ec7-4a6c-bff6-d3258d447a4e	200g Raw/Cooked Vegetables	g	200	4	10	1	48
bd8e7926-5572-4b7c-8200-a41fc8cdfee4	bb166d76-1ec7-4a6c-bff6-d3258d447a4e	100g Paneer/50g Soya Chunks/3 Whole Eggs	g	100	18	1	20	265
8adb2299-4555-453a-a358-40487b2b411f	bb166d76-1ec7-4a6c-bff6-d3258d447a4e	200g Curd	g	200	7	8	6	120
eb2b1674-9064-42f3-b40f-f468705c7fae	bb166d76-1ec7-4a6c-bff6-d3258d447a4e	5g Cooking Oil/Ghee	g	5	0	0	5	44
1429d4c7-b9da-42ae-a3cb-39ff2e84ee0f	d03c0c3c-52e9-49bb-ae46-cb9fa79ba463	Whey Protein	serving	0	0	0	0	0
0a468a39-1266-4246-9073-940227917c92	d03c0c3c-52e9-49bb-ae46-cb9fa79ba463	30g Makhana/Peanuts/Chana	g	30	6	18	1	114
10ba4f68-a76e-4f23-bfd1-eb1e52d17bf3	d03c0c3c-52e9-49bb-ae46-cb9fa79ba463	Apple	serving	1	0	25	0	100
71ee61f7-2691-4746-8f5e-e7fe0b3356aa	3e044991-c0ce-4a7d-919d-9e857a231692	5g Cooking Oil/Ghee	g	5	0	0	5	44
760deaff-99cc-4212-958a-1309e26b0e4c	055c6e96-45c1-43c2-a625-a5c9d4d50ccd	50g Poha/Upma/Vermicilli/Oats/Wheat Flour(for paratha)/2 Brown Bread(for sandwitch)	g	50	3	43	0	182
5d80a1b3-1838-473b-9906-b4379099560f	055c6e96-45c1-43c2-a625-a5c9d4d50ccd	5g Cooking Oil	g	5	0	0	5	44
7ff07bde-8e2b-4cb8-8222-a280351ad529	055c6e96-45c1-43c2-a625-a5c9d4d50ccd	15g Chana	g	15	2	9	0	55
5b8e008d-e63e-4c88-949a-cac85d488cd4	399f8721-2e0b-4412-bf96-6087bfa4775c	200g Curd	g	200	7	8	6	120
a9ba2d41-0285-487a-bfba-53a90d0db1fd	399f8721-2e0b-4412-bf96-6087bfa4775c	50g Whole Wheat Flour	g	50	6	36	1	170
1672e8fa-2b18-4a8e-b802-ba8f4af61854	399f8721-2e0b-4412-bf96-6087bfa4775c	75g Paneer	g	75	9	0	10	132
7d01fe79-5982-4dca-a0a2-4850483606ec	399f8721-2e0b-4412-bf96-6087bfa4775c	200g Raw or Cooked Vegetables	g	200	4	10	1	48
f1e4ab80-232f-4566-afd3-4ac62310deab	399f8721-2e0b-4412-bf96-6087bfa4775c	5g Cooking Oil	g	5	0	0	5	44
55ba6adf-5d0a-4756-b347-96bf7d308936	721c6317-e5df-41f2-916f-3429b27a01f0	10g Peanuts	g	10	2	1	5	58
2da01c38-d20f-4fe8-88cc-a8933204acd8	721c6317-e5df-41f2-916f-3429b27a01f0	10g Chana	g	10	1	6	0	37
2f14ad73-b851-4f5f-afbd-c7eed5c2e8c1	721c6317-e5df-41f2-916f-3429b27a01f0	150 ml Milk (for Tea)	ml	150	4	7	4	96
a56afcab-dabf-4464-a52b-5d1afe472c1f	721c6317-e5df-41f2-916f-3429b27a01f0	5g Sugar	g	5	0	20	0	20
4647fcb2-ef76-45eb-bb13-944abfb2dde4	721c6317-e5df-41f2-916f-3429b27a01f0	Apple	serving	1	0	25	0	100
fa0209c7-b8f3-4fd9-a1fc-03137053bdaf	308078da-67b9-4c15-ba71-19a9ee387102	50g Rice	g	50	4	38	0	180
e003a021-45b1-43f7-ac06-7e2c0c33b91e	308078da-67b9-4c15-ba71-19a9ee387102	200g Raw or Cooked Vegetables	g	200	4	10	1	48
75485303-841b-4180-9315-662e3a591736	308078da-67b9-4c15-ba71-19a9ee387102	5g Cooking Oil	g	5	0	0	5	44
244b39f8-fd91-400f-a11a-c891413d57e3	40b23d87-95a6-4916-98c7-9aee66edd557	Poha/Rava/Sooji(for Upma)/Upma/Besan Chila/Dosa / Idli [[OPT:upma | besan | dosa | idli]]	g	50	3	43	0	182
bb4bd95d-7f01-4599-8914-858559face23	40b23d87-95a6-4916-98c7-9aee66edd557	Cooking Oil	g	10	0	0	10	44
73c93795-bae7-4fe6-bd13-e358f1104214	40b23d87-95a6-4916-98c7-9aee66edd557	Apple	serving	1	0	25	0	100
3ed6adb9-e8fb-41a5-bb9d-18ba97592940	40b23d87-95a6-4916-98c7-9aee66edd557	Almonds	almonds	5	1	1	3	35
9b43e2d4-c2ac-48e2-a678-292ad75103b2	a91fa504-270c-4689-833c-dd084bf1725a	Rice(Raw)	g	20	4	38	0	180
223f31ec-b585-4410-a6d4-d3f83a79ddba	a91fa504-270c-4689-833c-dd084bf1725a	Whole Wheat Flour(Raw)	g	50	6	36	1	170
c398c836-22b5-4b75-b4a8-9da520406be9	a91fa504-270c-4689-833c-dd084bf1725a	Soya Chunks	g	60	31	19	0	210
4802b4f7-4fdb-459b-8876-bc859bc3de0b	a91fa504-270c-4689-833c-dd084bf1725a	Cooking Oil	g	5	0	0	5	44
4140136e-9ba1-41db-a4bd-de64cd5436d3	308078da-67b9-4c15-ba71-19a9ee387102	40g Daal/Rajma/Chole	g	40	10	23	0	140
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
8868e0fa-a200-43c7-bdb0-50f9bbf8412b	3e044991-c0ce-4a7d-919d-9e857a231692	60g Rice/Wheat Flour (Roti)/Daliya	g	60	5	46	0	216
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
c496e1d6-79f5-425d-bf34-018a52e233d3	54d617f6-05b6-4e4e-a37b-cbd04c8f1418	60g Poha/Oats/Upma/Sprouts/Museli	g	60	4	51	0	219
f935e854-476d-4537-9ac1-650b12f4cf58	54d617f6-05b6-4e4e-a37b-cbd04c8f1418	3 whole egg	whole	3	18	0	15	225
a73b630c-b285-4566-b5a4-f8118c05452c	54d617f6-05b6-4e4e-a37b-cbd04c8f1418	1 egg white	egg	2	6	0	0	34
d70a92b8-7ba2-40ac-98f6-65f1065f32aa	54d617f6-05b6-4e4e-a37b-cbd04c8f1418	Apple	serving	1	0	25	0	100
bf2d227c-b1e4-4491-81bb-f3000322cab5	54d617f6-05b6-4e4e-a37b-cbd04c8f1418	10g Cooking Oil/Ghee	g	10	0	0	10	88
62b98fde-e680-4f3f-9ebb-9336c9e62705	8e350891-ced2-474b-9a46-e979d643b23c	70g Rice/Wheat Flour(Roti)	g	70	6	53	0	252
45f4fb80-b0b8-48d5-9204-0930759d1f3e	8e350891-ced2-474b-9a46-e979d643b23c	120g Chicken Breast/120g Fish/3 Whole Eggs/100g Paneer	g	120	28	0	2	132
36b25e3e-55e8-4181-a379-ea84372625bb	8e350891-ced2-474b-9a46-e979d643b23c	200g Raw or Cooked Vegetables	g	200	4	10	1	48
77677b7b-3cae-4d41-80bc-ba59629c4a4d	8e350891-ced2-474b-9a46-e979d643b23c	10g Cooking Oil/Ghee	g	10	0	0	10	88
0735380f-7790-49fd-abc8-158809796b5a	4ceba001-3d7f-4d4a-b78f-bd9cfaccfc4e	100g Curd	g	100	3	4	3	60
bebbd0fa-500f-4538-bf5c-bdf36d4b62c0	4ceba001-3d7f-4d4a-b78f-bd9cfaccfc4e	Banana	serving	1	1	23	0	90
f7d0ebc4-db3f-401c-973d-399d1c93d98e	cce9ab09-c0e5-4b18-b606-3b10a1c7b3fb	Whey Protein	serving	1	24	2	1	120
b73f4fb9-0aed-460f-818f-136c29387ad4	cce9ab09-c0e5-4b18-b606-3b10a1c7b3fb	200 ml Full Cream Milk	ml	200	6	9	6	128
4a84cd0c-d560-4479-83df-a162a2afc053	cce9ab09-c0e5-4b18-b606-3b10a1c7b3fb	5 almonds	almonds	5	1	1	3	35
972bd633-07e9-4b04-936d-6c9093ba1b9b	cce9ab09-c0e5-4b18-b606-3b10a1c7b3fb	11 Raisin	Raisin	11	0	4	0	22
a7680dcc-1cda-4a55-8dc7-0766ae61b148	cce9ab09-c0e5-4b18-b606-3b10a1c7b3fb	1 Anjeer	Anjeer	1	0	6	0	25
495e31d7-baaa-4a02-b7a6-46941bd94a17	2b3d8dba-8c2b-4942-8f02-febb158ea94a	70g Rice/Wheat Flour(Roti)	g	70	6	53	0	252
f2932c02-0466-4967-b032-c1b30b7f0ca4	2b3d8dba-8c2b-4942-8f02-febb158ea94a	120g Chicken Breast/120g Fish/3 Whole Eggs/100g Paneer	g	120	28	0	2	132
cbc96ec3-3af8-49c4-bf73-92cb8318e6b2	2b3d8dba-8c2b-4942-8f02-febb158ea94a	30g Raw Dal / Rajma / Chole	g	30	7	17	0	105
3e6d4b9f-9937-453e-a067-edad8a0bd9ed	2b3d8dba-8c2b-4942-8f02-febb158ea94a	200g Raw or Cooked Vegetables	g	200	4	10	1	48
360cec79-88a6-4e3a-9399-868c1450a498	2b3d8dba-8c2b-4942-8f02-febb158ea94a	10g Cooking Oil/Ghee	g	10	0	0	10	88
e4c7628b-4497-458c-ad96-a6663b8e7ad6	308078da-67b9-4c15-ba71-19a9ee387102	30g Soya Chunks	g	30	15	9	0	105
1e93e6e3-e5e4-4be7-9bb2-ae4cbcc9e527	3e044991-c0ce-4a7d-919d-9e857a231692	200g Raw/Cooked Vegetables	g	200	4	10	1	48
73b87d3f-9490-4d35-9671-be7c959a9195	3e044991-c0ce-4a7d-919d-9e857a231692	100g Paneer/50g Soya Chunks/3 Whole Eggs	g	100	18	1	20	265
c69eaa32-7737-4b83-ba99-5449fb4fdddf	3e044991-c0ce-4a7d-919d-9e857a231692	50g Any Daal/Rajma/Chole	g	50	12	29	0	175
9815f561-2f6b-496b-ad4f-a090e7c46906	7398c30e-3cf0-4da7-b094-6283ee05526c	50g Poha/Upma/Daliya	g	50	3	43	0	182
64c56b0b-8cff-4f44-a2ed-5be34fb808ae	7398c30e-3cf0-4da7-b094-6283ee05526c	200 ml Full Cream Milk	ml	200	6	9	6	128
477dcb6e-d24e-428e-aed9-763b47f91d88	7398c30e-3cf0-4da7-b094-6283ee05526c	Tea	g	5	0	0	0	0
e1eea5bc-39da-462c-a3db-4f12855a37c3	7398c30e-3cf0-4da7-b094-6283ee05526c	5g Cooking Oil	g	5	0	0	5	44
43412882-c406-439e-9e00-bd6c47ef1176	d359e778-fd8d-4ab3-ab1f-769d058ac631	40g Rice/Wheat Flour (Roti)/Daliya	g	40	3	30	0	144
a4260202-7c90-415c-b3f7-ec15d4d20766	d359e778-fd8d-4ab3-ab1f-769d058ac631	200g Raw/Cooked Vegetables	g	200	4	10	1	48
75d6861d-03b5-4d2b-a098-80652253d103	d359e778-fd8d-4ab3-ab1f-769d058ac631	50g Paneer/50g Tofu	g	50	9	0	10	132
761c5364-bf48-489c-952d-51ff7d55ff0b	d359e778-fd8d-4ab3-ab1f-769d058ac631	100g Curd	g	100	3	4	3	60
24025714-86df-43ad-b122-a7f4004c3d24	d359e778-fd8d-4ab3-ab1f-769d058ac631	5g Cooking Oil	g	5	0	0	5	44
06406b67-73fb-4c82-bf4b-ab7a6375faeb	f77c5014-e82c-4ba6-aa10-dc71c3d0856d	Apple	serving	1	0	25	0	100
991f85a1-af64-4c6d-bf65-e340a3badf03	f77c5014-e82c-4ba6-aa10-dc71c3d0856d	200 ml Full Cream Milk	ml	200	6	9	6	128
bce4a5ea-6f54-452a-8717-0fa35515e636	f77c5014-e82c-4ba6-aa10-dc71c3d0856d	30g Roasted Chana	g	30	6	18	1	114
8b86bc3c-c6eb-4173-a002-d7d72ced00ea	463bae18-dbf6-4a74-ba3c-a118ee4430ba	40g Rice/Wheat Flour (Roti)/Daliya	g	40	3	30	0	144
96516219-bff6-4a18-9732-483b85c7fe42	463bae18-dbf6-4a74-ba3c-a118ee4430ba	200g Raw/Cooked Vegetables	g	200	4	10	1	48
184f8860-e9dc-47ca-8a4d-99a311725ba2	573da9bf-5fce-470b-8c0e-acefbd1b6ab8	5g Black Coffee	g	5	0	0	0	12
3c3e9d7e-3949-443e-9f9a-62007e437d87	573da9bf-5fce-470b-8c0e-acefbd1b6ab8	Apple	serving	1	0	25	0	100
c9511912-6e89-4c76-b70e-67844ff92793	573da9bf-5fce-470b-8c0e-acefbd1b6ab8	60g Poha/Upma/Vermicilli/Oats/Wheat Flour(for paratha)/2 Brown Bread(for sandwitch)/Chila	g	60	4	51	0	219
5deb1372-7a0a-4ee3-9f32-b2d3d287af5e	573da9bf-5fce-470b-8c0e-acefbd1b6ab8	2 egg white	egg	2	6	0	0	34
8bd530ab-302f-45ed-a981-887d164356d2	573da9bf-5fce-470b-8c0e-acefbd1b6ab8	1 whole egg	whole	1	6	0	5	75
c47a7a0e-cf58-41cf-a556-274c94de804a	573da9bf-5fce-470b-8c0e-acefbd1b6ab8	5g Cooking Oil	g	5	0	0	5	44
a9df8ea1-ab70-475b-823d-49b3c03f4b13	d2ee0c27-2b46-4004-ae7d-55314fd8fd7a	60g Rice/Whole Wheat Flour	g	60	5	46	0	216
e58f62b6-8246-439a-a0fd-b2d5425cc387	d2ee0c27-2b46-4004-ae7d-55314fd8fd7a	50g Any Daal/Rajma/Chole	g	50	12	29	0	175
33d13338-9702-4a85-91cc-f1c338580de7	d2ee0c27-2b46-4004-ae7d-55314fd8fd7a	200g Raw/Cooked Vegitable	g	200	4	10	1	48
460c66ea-6c54-415b-a8eb-4c62b6821d0c	463bae18-dbf6-4a74-ba3c-a118ee4430ba	40g Dal / Rajma / Chole	g	40	10	23	0	140
18e0d21e-9182-475d-bd5c-d4a368e629be	463bae18-dbf6-4a74-ba3c-a118ee4430ba	5g Cooking Oil	g	5	0	0	5	44
cf1dc233-7329-4887-adca-e0f30069d6e8	463bae18-dbf6-4a74-ba3c-a118ee4430ba	25g Soya Chunks	g	25	13	8	0	87
1e4a31bd-56e4-4a8e-876e-bb623c654a52	628ac36c-158e-4f84-8c6a-e7cc9805c1cb	50g Poha/Upma/Besan Chilla	g	50	3	43	0	182
851f0dc3-a969-47ab-843b-7f4b94b02787	628ac36c-158e-4f84-8c6a-e7cc9805c1cb	Tea	g	5	0	0	0	0
11971a23-e114-4ed7-ba98-9f4e1e33e1f0	628ac36c-158e-4f84-8c6a-e7cc9805c1cb	5g Sugar	g	5	0	20	0	20
8476350d-401b-4573-a45e-bc9c5447f56a	628ac36c-158e-4f84-8c6a-e7cc9805c1cb	200 ml Full Cream Milk	ml	200	6	9	6	128
45f8150d-c6b5-496b-b956-6c181b1ad43e	628ac36c-158e-4f84-8c6a-e7cc9805c1cb	5g Cooking Oil	g	5	0	0	5	44
f43aa2ac-f273-4475-9079-72749d4f3a65	e9b1175f-e0ba-484b-973f-de14be0182e6	40g Rice/Whole Wheat Flour(for Roti)	g	40	3	30	0	144
292dcfda-c399-4113-8d3e-3ac57c589c8d	e9b1175f-e0ba-484b-973f-de14be0182e6	200g Raw/Cooked Vegitable	g	200	4	10	1	48
2041551e-f356-426b-b767-c177650122bb	e9b1175f-e0ba-484b-973f-de14be0182e6	100g Paneer	g	100	18	1	20	265
883338c8-09df-4242-b9f5-67230c65b749	e9b1175f-e0ba-484b-973f-de14be0182e6	5g Cooking Oil	g	5	0	0	5	44
fd5fe003-d1c4-4d04-8631-f52ad76365f6	fab6208c-81f3-4ed9-9eba-b1814d078dd2	Tea	g	5	0	0	0	0
bfdf7745-e0a7-41d0-bc3d-f49f1273f9bb	fab6208c-81f3-4ed9-9eba-b1814d078dd2	5g Sugar	g	5	0	20	0	20
c93d5f6f-733f-416c-9fc9-21b00fa2f011	fab6208c-81f3-4ed9-9eba-b1814d078dd2	200 ml Full Cream Milk	ml	200	6	9	6	128
f9a4c729-158b-474a-b39b-b0b05ff2e7c5	fab6208c-81f3-4ed9-9eba-b1814d078dd2	5 almonds	almonds	5	1	1	3	35
f8f1dd7f-dd40-4f13-b601-ea389ac3a874	fab6208c-81f3-4ed9-9eba-b1814d078dd2	Apple	serving	1	0	25	0	100
b8a4d1c2-4430-414b-a326-b396e3a5240a	5bc9804f-8771-4464-9acb-8124e6c91544	40g Rice/Whole Wheat Flour(for Roti)	g	40	3	30	0	144
3da7b6c3-9584-4e97-b450-a48708b77e1d	5bc9804f-8771-4464-9acb-8124e6c91544	200g Raw/Cooked Vegitable	g	200	4	10	1	48
cde3c430-ade0-4e88-bda8-cf6b7c08c52e	5bc9804f-8771-4464-9acb-8124e6c91544	5g Cooking Oil	g	5	0	0	5	44
1aa1fe90-93b2-41bd-a5c4-57e9081d57cb	5bc9804f-8771-4464-9acb-8124e6c91544	40g Daal/Rajma/Chole	g	40	10	23	0	140
56484bdd-c67e-46fe-a188-1670f7535880	ff8a5275-bf62-4fb3-b51b-648999faeb11	50g Poha/Upma/Besan Chilla	g	50	3	43	0	182
640714da-d08f-4a1a-af5e-90892ba1868c	ff8a5275-bf62-4fb3-b51b-648999faeb11	1 whole egg	whole	1	6	0	5	75
b77628d2-6796-4bdf-ad85-a316a25c8323	ff8a5275-bf62-4fb3-b51b-648999faeb11	Tea	g	5	0	0	0	0
9b63c654-c8cd-426c-98a0-36960249d810	ff8a5275-bf62-4fb3-b51b-648999faeb11	5g Sugar	g	5	0	20	0	20
37679c59-9026-4d74-9140-52ef4e67d3b6	ff8a5275-bf62-4fb3-b51b-648999faeb11	200 ml Full Cream Milk	ml	200	6	9	6	128
34360942-2441-4b2c-88bc-8d4138ad39f4	ff8a5275-bf62-4fb3-b51b-648999faeb11	5g Cooking Oil	g	5	0	0	5	44
a92638f8-dec1-41c4-9773-f062e8ff59e8	ff8a5275-bf62-4fb3-b51b-648999faeb11	1 egg white	egg	1	3	0	0	17
e657277b-1a7b-4239-a087-26b3fcafd3f3	67dd1e70-1954-436c-bc23-335cd711cbf6	50g Rice/Whole Wheat Flour(for Roti)	g	50	4	38	0	180
4cde5eb4-5da2-41ed-8165-c4ac2dcad82b	67dd1e70-1954-436c-bc23-335cd711cbf6	200g Raw/Cooked Vegitable	g	200	4	10	1	48
74a72fb3-574a-4cc6-82b0-041c7ea31afb	67dd1e70-1954-436c-bc23-335cd711cbf6	100g Paneer/3 Whole Eggs	g	100	18	1	20	265
e528488f-2b8f-409b-9de2-4f3d24adc8b8	67dd1e70-1954-436c-bc23-335cd711cbf6	200g Curd	g	200	7	8	6	120
5db1fe3e-e0a8-42eb-b876-701ba6808687	67dd1e70-1954-436c-bc23-335cd711cbf6	5g Cooking Oil	g	5	0	0	5	44
20447252-752f-4169-b9f8-dedad478c6fe	d30561bd-3da3-4caf-9674-51c1098eef7a	Tea	g	5	0	0	0	0
fc8ced94-6ef0-43ba-9dcb-29911883e9f7	d30561bd-3da3-4caf-9674-51c1098eef7a	5g Sugar	g	5	0	20	0	20
8036f7eb-e217-48db-a6b2-253f1f4f45be	d30561bd-3da3-4caf-9674-51c1098eef7a	200 ml Full Cream Milk	ml	200	6	9	6	128
0e5c7f47-2bdf-416f-830f-2ea54597fce6	d30561bd-3da3-4caf-9674-51c1098eef7a	5 almonds	almonds	5	1	1	3	35
15bd621c-5810-47ea-bfa9-e5a652ed0f42	d30561bd-3da3-4caf-9674-51c1098eef7a	Apple	serving	1	0	25	0	100
21578869-83bc-4402-8e4f-95cd093f54b0	396e5dab-66ef-4d33-93ec-8b762017e026	50g Rice/Whole Wheat Flour(for Roti)	g	50	4	38	0	180
9e594bf2-2a54-4f62-a661-6c59fa9dd326	396e5dab-66ef-4d33-93ec-8b762017e026	200g Raw/Cooked Vegitable	g	200	4	10	1	48
7244a348-7d17-4e1e-907a-242504bfa8aa	396e5dab-66ef-4d33-93ec-8b762017e026	5g Cooking Oil	g	5	0	0	5	44
a72ce94a-321d-412f-a7ec-9c262bf21594	396e5dab-66ef-4d33-93ec-8b762017e026	40g Daal/Rajma/Chole	g	40	10	23	0	140
049fd312-ea74-4f38-bca0-30b63f8f0b2c	396e5dab-66ef-4d33-93ec-8b762017e026	20g Soya Chunks/4 Egg Whites	g	20	10	6	0	70
4018f384-d93f-4cfc-a2ed-961a26d80d29	d2ee0c27-2b46-4004-ae7d-55314fd8fd7a	5g Cooking Oil	g	5	0	0	5	44
9f270f92-c73b-4caf-b2a2-59756c6bc06f	d2ee0c27-2b46-4004-ae7d-55314fd8fd7a	200g Curd	g	200	7	8	6	120
48e0ad1f-dbf3-40c6-883d-b7ebe1b50449	d2ee0c27-2b46-4004-ae7d-55314fd8fd7a	100g Chicken Breast/50g Soya/6 Egg Whites	g	100	24	0	2	110
8a72e9a1-3c98-4eef-9f91-1239c2d29b7b	2813640e-3a2e-45f5-aa9a-1d96ac20297d	Apple	serving	1	0	25	0	100
52e9783f-059e-45c9-abf0-d21aff90fc95	2813640e-3a2e-45f5-aa9a-1d96ac20297d	5 almonds	almonds	5	1	1	3	35
791083c7-9515-4de4-b34e-baaa243eace8	2813640e-3a2e-45f5-aa9a-1d96ac20297d	5 cashew	g	5	0	1	2	30
c9896ca2-16eb-4c7e-8841-8f734f68ccca	2cc7e032-ab90-470a-8e03-e07f6325d8f6	60g Rice/Whole Wheat Flour	g	60	5	46	0	216
48b1707b-2479-49ed-86da-b6d148182d93	2cc7e032-ab90-470a-8e03-e07f6325d8f6	100g Paneer/3 Whole Eggs	g	100	18	1	20	265
3c47de54-f936-42be-a038-30dfba71202f	2cc7e032-ab90-470a-8e03-e07f6325d8f6	100g Raw Spinach	g	100	2	5	0	24
875f2d39-d5c0-46b8-81fc-7d5a9c43c0fa	2cc7e032-ab90-470a-8e03-e07f6325d8f6	200g Raw or Cooked Vegetable	g	200	4	10	1	48
e5bc7007-6969-4cc4-bc6c-8d7f6d7e5ef6	2cc7e032-ab90-470a-8e03-e07f6325d8f6	5g Cooking Oil	g	5	0	0	5	44
dc007512-b0dc-44d5-b51a-1d52d5b366c2	7e27f485-d68b-4fbe-9a92-f043a36ef465	60g Poha/Upma/Daliya/2 Bread/Rice/Whole Wheat Flour Roti	g	60	4	51	0	219
428be14b-4565-4b23-b6eb-dc597ea51da6	7e27f485-d68b-4fbe-9a92-f043a36ef465	2 whole egg	whole	2	12	0	10	150
39cefe12-f44e-470d-9ff1-e6abcacb8857	7e27f485-d68b-4fbe-9a92-f043a36ef465	2 egg white	egg	2	6	0	0	34
cd1e1e03-3820-49ef-bdd3-e25744553d9c	7e27f485-d68b-4fbe-9a92-f043a36ef465	150g Curd	g	150	5	6	4	90
e0292e96-99e9-4d71-a447-2df259503e98	7e27f485-d68b-4fbe-9a92-f043a36ef465	1 cheese slice	cheese	1	4	0	5	61
4c78f30d-2c5c-47e5-a748-51b390ff20d8	7e27f485-d68b-4fbe-9a92-f043a36ef465	200g Raw or Cooked Vegetables	g	200	4	10	1	48
9af6beef-c4df-40df-af50-992f6e0f8fea	7e27f485-d68b-4fbe-9a92-f043a36ef465	5g Cooking Oil/Butter/Ghee	g	5	0	0	5	44
9cf28508-1f7f-408d-821f-f31bba725716	f22c49e5-1176-43b1-98ad-3ef5eabb1f41	Whey Protein	serving	1	24	2	1	120
dadfdb2c-0f67-45cb-8947-9e8e7d9df888	f22c49e5-1176-43b1-98ad-3ef5eabb1f41	Banana	serving	1	1	23	0	90
d4d358e2-b7d8-449e-a270-ae4c6990ff75	f22c49e5-1176-43b1-98ad-3ef5eabb1f41	1 Date	Date	4	0	24	0	92
c8c9b378-dc6b-4361-870d-3637ca78f6dc	27c6b745-6ceb-47bc-abe3-986488cee18e	100g Paneer/3 Whole Eggs	g	100	18	1	20	265
82df20a0-5a7f-492c-9eea-3c9136f76190	27c6b745-6ceb-47bc-abe3-986488cee18e	5g Cooking Oil/Butter/Ghee	g	5	0	0	5	44
6bdf1f04-e4f7-4c8b-b3f1-e00976a61e70	27c6b745-6ceb-47bc-abe3-986488cee18e	200g Raw or Cooked Vegetables	g	200	4	10	1	48
309c81f6-f30d-49c2-b220-cf0f7796178e	27c6b745-6ceb-47bc-abe3-986488cee18e	60g Rice/Whole Wheat Flour Roti	g	60	5	46	0	216
177ef980-dcf1-40c5-9122-95b02689191c	27c6b745-6ceb-47bc-abe3-986488cee18e	40g Any Dal / Rajma / Chole	g	40	10	23	0	140
f2112f97-fe1c-4218-9eec-7098c6a2b661	9451275e-62c6-4996-8581-ca6d721c27aa	Tea	g	5	0	0	0	0
c53a3888-66f0-4851-913f-4919b2ea1682	9451275e-62c6-4996-8581-ca6d721c27aa	Apple	serving	1	0	25	0	100
aa787d00-c42d-48c3-bcd9-68f8cb4b5410	9451275e-62c6-4996-8581-ca6d721c27aa	100g High Protein Oats	g	100	22	65	10	380
f8d31439-aa74-4364-9aab-fd2000727408	9451275e-62c6-4996-8581-ca6d721c27aa	900ml High Protein Milk	ml	900	50	32	28	586
3bc6430e-e39e-4a7d-ad2f-16202d5b6473	86c2c2cc-fff6-42de-89e1-c4fed2230caa	60g Rice/Whole Wheat Flour Roti/Daliya	g	60	5	46	0	216
0a562339-77d8-450f-99fd-49062dd19c3d	86c2c2cc-fff6-42de-89e1-c4fed2230caa	200g  Raw or Cooked Vegetable	g	200	4	10	1	48
29a4c101-2fe2-45bb-af86-f097d6c20ccf	86c2c2cc-fff6-42de-89e1-c4fed2230caa	10g Cooking Oil	g	10	0	0	10	88
711e6e5b-e4bb-4d34-aa65-2c552eb277d7	86c2c2cc-fff6-42de-89e1-c4fed2230caa	50g Daal/Rajma/Chole	g	50	12	29	0	175
4ea12e98-4621-46d6-9e33-78bfbe80868d	86c2c2cc-fff6-42de-89e1-c4fed2230caa	100g Curd	g	300	10	12	9	180
57d3b3cf-1c18-4625-ba19-fd1323d594c9	1d9ab511-586d-478c-9834-5f26f4655491	Whey Protein	serving	1	24	2	1	120
4a5e1076-ee99-42e1-b9a4-e9094b29c147	1d9ab511-586d-478c-9834-5f26f4655491	Apple	serving	1	0	25	0	100
0eb991a9-ebbb-4988-8f2a-6ba6764b28ff	1d9ab511-586d-478c-9834-5f26f4655491	Dry Fruits(Almonds, Cashews, Pumpkin Seeds, Cranberries)	g	20	4	7	9	125
61b38786-a7b9-4f58-b831-58740411d666	1d9ab511-586d-478c-9834-5f26f4655491	60g Daliya	g	60	5	46	0	216
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
40b23d87-95a6-4916-98c7-9aee66edd557	b6a1fa02-c586-4272-af78-f72c88449da0	Breakfast	0	2026-03-24 13:53:04.850474
a91fa504-270c-4689-833c-dd084bf1725a	b6a1fa02-c586-4272-af78-f72c88449da0	Lunch	1	2026-03-24 13:53:04.864897
a48a8793-ccfa-48d6-9690-f80b61c7381e	b6a1fa02-c586-4272-af78-f72c88449da0	Dinner	2	2026-03-24 13:53:04.86717
b726ff84-3fb7-4e7d-aced-c1588daee22d	f6473eb1-e9e8-480c-8015-3a21f7b98e3a	Breakfast	0	2026-03-24 13:59:33.779242
cc84f1e9-8862-4520-b88c-db30c8a244c0	f6473eb1-e9e8-480c-8015-3a21f7b98e3a	Lunch	1	2026-03-24 13:59:33.783313
26d7d68f-824b-427a-a499-3d5188a2d32c	f6473eb1-e9e8-480c-8015-3a21f7b98e3a	Snacks	2	2026-03-24 13:59:33.784823
98a8048a-eb67-4c2f-8c67-7dcc3e1d84e5	f6473eb1-e9e8-480c-8015-3a21f7b98e3a	Dinner	3	2026-03-24 13:59:33.786936
573da9bf-5fce-470b-8c0e-acefbd1b6ab8	49b039ed-c1af-444d-918d-339bea30d983	Breakfast	0	2026-05-30 13:27:00.684789
d2ee0c27-2b46-4004-ae7d-55314fd8fd7a	49b039ed-c1af-444d-918d-339bea30d983	Lunch	1	2026-05-30 13:27:00.687604
2813640e-3a2e-45f5-aa9a-1d96ac20297d	49b039ed-c1af-444d-918d-339bea30d983	Snacks	2	2026-05-30 13:27:00.688426
2cc7e032-ab90-470a-8e03-e07f6325d8f6	49b039ed-c1af-444d-918d-339bea30d983	Dinner	3	2026-05-30 13:27:00.688938
055c6e96-45c1-43c2-a625-a5c9d4d50ccd	95e86798-dfa5-411b-b2c9-bffdc9745f6b	Breakfast	0	2026-06-01 06:06:28.97619
399f8721-2e0b-4412-bf96-6087bfa4775c	95e86798-dfa5-411b-b2c9-bffdc9745f6b	Lunch	1	2026-06-01 06:06:28.976515
721c6317-e5df-41f2-916f-3429b27a01f0	95e86798-dfa5-411b-b2c9-bffdc9745f6b	Snacks	2	2026-06-01 06:06:28.976775
308078da-67b9-4c15-ba71-19a9ee387102	95e86798-dfa5-411b-b2c9-bffdc9745f6b	Dinner	3	2026-06-01 06:06:28.977044
7e27f485-d68b-4fbe-9a92-f043a36ef465	85e2b7b2-318b-437c-873d-f2fac41559f9	Brunch	0	2026-06-01 12:08:21.098146
f22c49e5-1176-43b1-98ad-3ef5eabb1f41	85e2b7b2-318b-437c-873d-f2fac41559f9	Snacks	1	2026-06-01 12:08:21.099022
27c6b745-6ceb-47bc-abe3-986488cee18e	85e2b7b2-318b-437c-873d-f2fac41559f9	Dinner	2	2026-06-01 12:08:21.09964
9451275e-62c6-4996-8581-ca6d721c27aa	aaffa140-c51f-458e-ad57-9dd67260fc39	Breakfast	0	2026-06-10 04:20:48.142189
86c2c2cc-fff6-42de-89e1-c4fed2230caa	aaffa140-c51f-458e-ad57-9dd67260fc39	Lunch	1	2026-06-10 04:20:48.142699
628ac36c-158e-4f84-8c6a-e7cc9805c1cb	e6451798-b8c0-474b-8355-c08ba786dffc	Breakfast	0	2026-05-24 13:54:36.095915
e9b1175f-e0ba-484b-973f-de14be0182e6	e6451798-b8c0-474b-8355-c08ba786dffc	Lunch	1	2026-05-24 13:54:36.097699
fab6208c-81f3-4ed9-9eba-b1814d078dd2	e6451798-b8c0-474b-8355-c08ba786dffc	Snacks	2	2026-05-24 13:54:36.099472
5bc9804f-8771-4464-9acb-8124e6c91544	e6451798-b8c0-474b-8355-c08ba786dffc	Dinner	3	2026-05-24 13:54:36.100751
1d9ab511-586d-478c-9834-5f26f4655491	aaffa140-c51f-458e-ad57-9dd67260fc39	Snacks	2	2026-06-10 04:20:48.142984
ff8a5275-bf62-4fb3-b51b-648999faeb11	a4cc86ac-98ee-4f6d-ad75-1e7a44923dac	Breakfast	0	2026-05-25 05:06:55.55947
67dd1e70-1954-436c-bc23-335cd711cbf6	a4cc86ac-98ee-4f6d-ad75-1e7a44923dac	Lunch	1	2026-05-25 05:06:55.560616
d30561bd-3da3-4caf-9674-51c1098eef7a	a4cc86ac-98ee-4f6d-ad75-1e7a44923dac	Snacks	2	2026-05-25 05:06:55.562031
396e5dab-66ef-4d33-93ec-8b762017e026	a4cc86ac-98ee-4f6d-ad75-1e7a44923dac	Dinner	3	2026-05-25 05:06:55.563018
7398c30e-3cf0-4da7-b094-6283ee05526c	f50b542a-14af-4566-aca7-4132382ccd6d	Breakfast	0	2026-07-06 03:09:09.309492
d359e778-fd8d-4ab3-ab1f-769d058ac631	f50b542a-14af-4566-aca7-4132382ccd6d	Lunch	1	2026-07-06 03:09:09.323491
f77c5014-e82c-4ba6-aa10-dc71c3d0856d	f50b542a-14af-4566-aca7-4132382ccd6d	Snacks	2	2026-07-06 03:09:09.325592
463bae18-dbf6-4a74-ba3c-a118ee4430ba	f50b542a-14af-4566-aca7-4132382ccd6d	Dinner	3	2026-07-06 03:09:09.325965
54d617f6-05b6-4e4e-a37b-cbd04c8f1418	5016bd40-5cad-41b4-99dd-d8fc560908ff	Breakfast	0	2026-05-25 12:18:15.024531
8e350891-ced2-474b-9a46-e979d643b23c	5016bd40-5cad-41b4-99dd-d8fc560908ff	Lunch	1	2026-05-25 12:18:15.025142
4ceba001-3d7f-4d4a-b78f-bd9cfaccfc4e	5016bd40-5cad-41b4-99dd-d8fc560908ff	Pre-Workout	2	2026-05-25 12:18:15.025637
cce9ab09-c0e5-4b18-b606-3b10a1c7b3fb	5016bd40-5cad-41b4-99dd-d8fc560908ff	Post-Workout	3	2026-05-25 12:18:15.025815
2b3d8dba-8c2b-4942-8f02-febb158ea94a	5016bd40-5cad-41b4-99dd-d8fc560908ff	Dinner	4	2026-05-25 12:18:15.026076
939208d1-c9b0-46ea-9d35-139f58723677	c38b321b-4375-47ce-bc95-8c8f53e41d49	Breakfast	0	2026-07-10 03:42:30.329213
bb166d76-1ec7-4a6c-bff6-d3258d447a4e	c38b321b-4375-47ce-bc95-8c8f53e41d49	Lunch	1	2026-07-10 03:42:30.330359
d03c0c3c-52e9-49bb-ae46-cb9fa79ba463	c38b321b-4375-47ce-bc95-8c8f53e41d49	Snacks	2	2026-07-10 03:42:30.479814
3e044991-c0ce-4a7d-919d-9e857a231692	c38b321b-4375-47ce-bc95-8c8f53e41d49	Dinner	3	2026-07-10 03:42:30.480846
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

\unrestrict eamFVll2cnpFTLGUSVuKJbrH0uGhEekTjsR1bWv5V79e2e8n8L04dzsV3cdsc7N

--
-- Database "coach_member" dump
--

--
-- PostgreSQL database dump
--

\restrict z6rsJFchzYL57iEVQ0IfUgSM0keWXESHxqX2S4ONwMhbU2sSRKuoBhgDpAgoByp

-- Dumped from database version 15.18 (Debian 15.18-1.pgdg13+1)
-- Dumped by pg_dump version 15.18 (Debian 15.18-1.pgdg13+1)

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

\unrestrict z6rsJFchzYL57iEVQ0IfUgSM0keWXESHxqX2S4ONwMhbU2sSRKuoBhgDpAgoByp
\connect coach_member
\restrict z6rsJFchzYL57iEVQ0IfUgSM0keWXESHxqX2S4ONwMhbU2sSRKuoBhgDpAgoByp

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
    CONSTRAINT chk_body_metrics_goal CHECK (((target_goal)::text = ANY (ARRAY[('FAT_LOSS'::character varying)::text, ('MAINTENANCE'::character varying)::text, ('GAINING'::character varying)::text])))
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
    inactive_at timestamp without time zone,
    CONSTRAINT chk_members_status CHECK (((status)::text = ANY (ARRAY[('ACTIVE'::character varying)::text, ('INACTIVE'::character varying)::text])))
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
2f1b1197-3ecb-47e0-a98b-aa45465622dc	19fea79e-0cd4-4196-a8c5-09ba95f28629	165	96	Male	32	f	1.55	1.5	4	GAINING	14	60	35.3	1440	2232	1851.8808	90	240	59	2026-04-07 03:42:16.954738	2026-04-07 03:42:16.99044
d84f12bc-a7ac-450a-a690-b07e49a37f39	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	180	73	Male	31	t	1.375	1.3	4.66	GAINING	15	73	22.5	1752	2409	2414.0588999999995	95	340	75	2026-05-06 03:48:57.137884	2026-05-06 03:48:57.142554
a20f2e21-af44-45b5-89bf-35e989769978	f47345ea-a6df-40b0-928b-9d88c3e05350	180	80	Male	30	f	1.375	1.4	4	FAT_LOSS	12	75	24.7	1800	2475	1984.158	105	300	40	2026-05-12 13:50:42.998979	2026-05-12 13:50:43.009399
637d416f-558e-4f50-a6d1-a95267ba878d	80026e92-8f66-4cfb-852a-e92f48f7ea38	165	67	Female	28	f	1.375	1.3	3.6	FAT_LOSS	12	58	24.6	1305	1794	1534.4155199999998	75	209	44	2026-05-14 13:08:32.697283	2026-05-14 13:10:42.967571
adf76a01-dfba-4fc0-9571-652faab2f6c3	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	165	71	Male	31	f	1.375	1.6	3.5	MAINTENANCE	12.1	60	26.1	1440	1980	1600.5541199999998	96	210	42	2026-05-17 08:03:01.575318	2026-05-17 08:24:55.221171
da371931-7d93-4f10-b6d9-215a60ee2c8e	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	178	78	Male	31	f	1.55	1.6	3.5	MAINTENANCE	13.05	73	24.6	1752	2716	2100.2312429999997	117	256	68	2026-05-20 11:44:21.098149	2026-05-20 11:47:20.024556
b1dc5eca-09d8-4a23-934f-275728482507	57ee19de-9c3f-49bf-83d2-20a56100a64e	152	72	Female	57	f	1.2	1.1	3.5	MAINTENANCE	12	52	31.2	1248	1498	1375.6828799999998	57	182	47	2026-05-24 07:20:46.562091	2026-05-24 07:20:46.565074
052fc404-c523-4770-bdac-7dc3c11a6a14	6ae0f3fa-0233-4160-ba88-11f4b8ae7e38	165	79	Male	58	f	1.375	1.3	3.4	MAINTENANCE	12.3	65	29	1560	2145	1762.59369	85	221	60	2026-05-24 13:39:17.363708	2026-05-24 13:42:17.877966
3b2dff17-60b1-4178-8a4e-ec66d3ac7803	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	167	88	Male	33	f	1.55	1.5	4.2	GAINING	14.63	62	31.6	1488	2306	1999.7226171999998	93	260	65	2026-05-29 14:43:16.077067	2026-05-29 14:43:50.972402
42752ab2-27cb-47a1-acdc-98678171c083	0e06681a-b803-432e-99f0-8fdf61e1bdcb	157	59	Female	31	f	1.2	1.56	4.2	MAINTENANCE	13.72	50	23.9	1125	1350	1512.36932	78	210	40	2026-03-28 11:25:16.28286	2026-06-01 06:02:51.706413
287bd478-2e2e-43b9-aab2-4216b7ad5c90	525dc6ab-79fa-49f9-af15-1e482244c495	182	76	Male	28	f	1.2	1.62	4.22	GAINING	14.84	77	22.9	1848	2218	2519.1751815999996	125	325	80	2026-06-09 03:05:37.010748	2026-06-09 03:05:37.011998
0d26a00c-842b-441e-bce4-944c7b74d88a	930eeb2e-e6d4-44f0-9636-d980c65db931	150	68	Female	44	f	1.2	1.2	3.5	MAINTENANCE	14	43	30.2	968	1161	1327.18124	52	151	58	2026-07-05 08:48:31.183556	2026-07-05 08:48:31.184221
3e2b74df-8bb9-4b4e-874c-aaf71dfb7f1b	e7720152-a475-463a-a2a5-120af6cdfce6	173	86	Male	30	f	1.375	1.41	3.8	MAINTENANCE	14	68	28.7	1632	2244	2098.7982399999996	96	258	76	2026-07-09 15:08:42.977476	2026-07-09 15:11:38.359981
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
6	6	add member inactive at	SQL	V6__add_member_inactive_at.sql	1907199662	postgres	2026-05-24 02:33:01.581106	145	t
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.members (id, coach_email, full_name, email, phone, gender, date_of_birth, goal, notes, created_at, updated_at, age, country, state_city_province, height_cm, current_weight_kg, main_training_goal, previous_weight_loss, weight_regain, prior_training_experience, daily_training_commitment_hours, preferred_workout_timing, days_per_week_train, personal_training_before, goal_reward, additional_info, alcohol_consumption, smoking_habits, supplements_past, steroid_usage, stress_level, sleep_hours, past_sports_activity, food_preference, activity_level, typical_day, current_diet_plan, favorite_foods, food_allergies, medical_condition, injuries, medical_conditions_detailed, push_up, squat, row_band_dumbbell, overhead_press_dumbbell, hip_hinge_rdl, front_view, side_view, back_view, status, inactive_at) FROM stdin;
ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	Mayank Thakur	mayank4656@gmail.com	70677 39630	Male	1994-12-25	Fat Loss	\N	2026-03-19 13:09:33.160387	2026-06-28 07:03:11.076533	31	India	Bangalore	181	111	Lose weight and Reverse Diabetes and take care of liver and cholesterol markers. 	10 kgs	Yes	6 months gym training	1 hour	Morning	6	No	Maintain the physique and lifestyle so that I never have to eat any tablets.	No	3-4 days	3-5 per day	Protein powder, Creatine and BCAA	No	5			Non-Vegetarian	Low (Desk job)	Walking : Occasionally after food, 7 hours of sleep, 3 meals a day and some snacks in evening.	No	Eggs chicken mutton dosa idly roti sabzi	None	Diabetes, Fatty Liver and high cholesterol	Lower Back	Diabetes, Cholesterol						https://drive.google.com/open?id=1N3fj_DHyNUeH0LOW9e0teJvDoezxaQxZ	https://drive.google.com/open?id=191Ss8FO0MQ3RR-P4kAvJxHOtqnf3TurL	https://drive.google.com/open?id=1tFPloPetqXmY4ah58jicGxuRjcWAdMnA	ACTIVE	\N
0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	Khushbu Sahu	khushbuganjir06@gmail.com	7974985243	Female	1994-07-24	Fat Loss	\N	2026-03-23 03:58:52.543445	2026-07-01 03:35:58.867274	31	India	Tamilnadu 	157	59	Stay active and fit 	No	Yes	No	1hr	Flexible	5	No	Buy a new outfit and go on a trip.	No	Once in a while	No	Iron	No	7	8	Classical dance 	Vegetarian	Moderate (Teacher/Student/Homemaker)	Currently, I do not have a fixed daily routine for walking, meals, water intake, or sleep, but I am working on building healthier habits.	No	Nothing specific 	No	Allergic 	No Injuries	All Good						https://drive.google.com/open?id=1t11WqL1E97m4Ud4bNMH15kDIr--u1Hxq	https://drive.google.com/open?id=1fBFm455JnsAQ5V23hbTG0kMIiodGB0NM	https://drive.google.com/open?id=1MMkuIMFBS-MOkBLQHKgbILt0x04Go--k	ACTIVE	\N
b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	Prateek Srivastava	srivastavaprateek1994@gmail.com	8269499713	Male	1994-08-10	Muscle Gain	\N	2026-03-13 14:01:19.12028	2026-07-16 13:49:33.403658	31	India	Pune Maharashtra 	180	63	Transformation 	NA	No	6 months	2	Morning	6	No	Will try to continue the lifestyle 	Smoking: negligible, occasionally, trying to quit Drinking: Occasionally 	1-2 per month limited quantity 	Right now zero. Trying to quit. Very occasional	No	No	8	8	NA	Non-Vegetarian	Low (Desk job)	I am trying to wake up by 7 Am and go to bed around 11 pm.\nWater intake: 3-4 litres\nMeals as per the plan \nSteps: 9000 average in February \nWork: 5 days a month.	Yes	Already shared	No	No	No Injuries	All Good						https://drive.google.com/open?id=1VjUFCQk_yYkxFrzIzmgJw0MjNZ7M8DAI	https://drive.google.com/open?id=1eP3Vi5mlthn353rPoSNnYPVeGTY3EoT0	https://drive.google.com/open?id=1091re_Kp8Vo2nKB4lceS2ROTh8bWglFJ	ACTIVE	\N
5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	Prashant Kumar	prashantkumar.0142@gmail.com	9631597047	Male	1994-04-22	Fat Loss	\N	2026-03-15 07:09:56.85391	2026-07-01 03:06:49.252956	31	India	Karnataka	165	71	Lean athletic body, Fat below 20%, Muscle above 40%	Yes 2 kg	Yes	1 year irregular 	1 to 1.5 hours	Morning	5	No	Will enroll for kick boxing.		Occasionally, once or twice in a month	Daily,  maximum 2 cigarette 	No	No	4	8	None	Non-Vegetarian	Low (Desk job)	Waking 10 am,\nMeals: brunch at afternoon, evening snacks, dinner\nSleep: late around 1or 2	None	Biryani, dosa	None	None	Past injury: Shoulder	All Good						https://drive.google.com/open?id=13muNkafJ1UwQvWn69AE-4XtsMh-1nAtJ	https://drive.google.com/open?id=1wq9x5bFt1iKbx39SKO00EjD-9FD8lgsk	https://drive.google.com/open?id=1iIvi2kkSLDvOwVsUg0YXZ1Bw5WjClyDe	ACTIVE	\N
ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	Shailesh Kumar Sahu	shailesh.sksahu@gmail.com	7828673538	Male	1994-04-24	Fat Loss	\N	2026-03-23 03:57:38.401819	2026-07-01 03:35:47.958265	31	India	Chennai	173	115	To feel more active and gain strength	No	No	No	1-2	Flexible	5	No	I will do sky diving	No	Once in a month and upto 4 drinks of 60ml	No	No	No	2		School	Vegetarian	Low (Desk job)	Wakeup- 8-9 A.M., breakfast- 9:30 A.M. ( Poha, idli, Suji, Vermicelli, boiled eggs, sandwich), work- 10 AM to 8 PM, Lunch- 1-2 PM ( rice, , roti sabzi), evening snacks- tea and biscuit, mixture, Dinner- 9-10 PM ( Rice or roti), sleep- 12-8	No	Poha\nUpma\nSabudan khichdi\nParatha\nRice\nRoti\nEgg items\nSome times  chicken birayani- once in a quarter\nSoyabean khichdi\nMushroom\nEtc.	No	Slip disc- L5-S1 (moderate)	Shoulder	All Good						https://drive.google.com/open?id=1ZTKaxFBv_14jV6DTNot4_HQumJK_FPxt	https://drive.google.com/open?id=19HmRozCAZ7RmhnXUT4DYg0vsTo_me_fr	https://drive.google.com/open?id=1LjsqYnlyTVawcf_OCOmGZiYFsmxuQYQq	ACTIVE	\N
19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	ANWAR KHAN	akanwar7@gmail.com	8087535411	Male	1993-10-10	Fat Loss	\N	2026-04-05 03:53:22.16863	2026-07-16 12:52:10.34316	32	India	PUNE	165	96	Fat loss	Yes 10 kg	Yes	1	1hr	Morning	6	Yes	Good	No	No	No	Yes	No	2	6	No	Non-Vegetarian	Moderate (Teacher/Student/Homemaker)	Waking time 7 meals 3 work 10 to 10 sleep time 11 steps 3-5k water 3+	No	Chicken Egg paneer	No	No	No Injuries	Cholesterol, Asthma						https://drive.google.com/open?id=1xhz0pprvTyVdSuyNAReM-AIXIruPLC7P	https://drive.google.com/open?id=1yYL8Fbfwj1SqErxbpH_haBNSAyY_LeQm	https://drive.google.com/open?id=1x8VPCToMUU4JXsNdfC_WeL-K40a-CjrX	ACTIVE	\N
fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	Mohit Soni	mohitsoni444.ms@gmail.com	9770516659	Male	1994-09-07	Fat Loss	\N	2026-05-18 04:13:28.061778	2026-06-22 04:10:26.101291	31	India	Maharashtra	178	78	Fat loss, Muscle gain	No	No	10	45 mins to 1 hour	Evening	5	Yes	by Maintaining it.		once a month	occasionally. twice or thrice a week	Yes, muscle tech nitrotech whey, creatine	Never	7		School	Vegetarian	Low (Desk job)	Wake up at 8, one glass water, breakfast at 9, office, lunch at 1/2, gym at 8, sleep by 11/12		Nothing much, Mostly I can eat everything except soya chunks	none	NO	No Injuries	All Good, Migraine						https://drive.google.com/open?id=1XR-eTtaOc4j-iRvPZOIZrtTp6pwCzIBE	https://drive.google.com/open?id=1a5unEcuIfMFksRF-qQ_zXEjqnEUzU0Vq	https://drive.google.com/open?id=1ZZfBbaR_vvq5HblZvDbkfD8UU17hC3G5	ACTIVE	\N
525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	Sudhanshu Shekhar Singh	rules.sid4@gmail.com	9030223950	Male	1997-05-06	Fat Loss	\N	2026-03-16 03:26:15.966337	2026-06-27 04:20:13.548862	28	India	Banglore 	182	76	Get some muscle mass and lose belly fat	No	No	No training experience 	1-1.5 hrs	Flexible	6	No	Get a tattoo	Nil	Consume around 1 time in a week that too 2-3 pegs	Around 8	No	No	8	6	Played sports professionally	Non-Vegetarian	Low (Desk job)	Do shift duty so working time is flexible	Nil	Chicken	Nil	Shoulder sockets injury and migraine 	Shoulder	All Good						https://drive.google.com/open?id=180DMtnDlAtbNZcEiUnMex9JIt711loGj	https://drive.google.com/open?id=101SoQvN6wiOajgStF9aI6FxznoSMaJKD	https://drive.google.com/open?id=19aPSebS2Fyl6r1p5nBOST1T4C_IfzfwR	ACTIVE	\N
8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	Vaisshnavi	Vaishnavigwd@gmail.com	8050646481	Female	2020-02-20	Fat Loss	\N	2026-03-15 07:13:21.387748	2026-06-02 14:54:06.290171	30	India	Karnataka 	151	60	To get fit and loose 5 kg 	Yes 	Yes	10 years 	1 hour 	Morning	7	Yes	Enjoy the moment 		No 	No 	No 	No 	6	6 hours 	No 	Vegetarian	High (Sports, Dance, Physical job)	8 am everyday 6 hours 4 liters 	No 	Pani puri 	No 	No 	Head	All Good						https://drive.google.com/open?id=1B6jwezbOnaiIao3YmtYQ03dpJCBziv32	https://drive.google.com/open?id=1V1nIfb1t_21UO-PnecqfxXH3NPwIoH_D	https://drive.google.com/open?id=1cSS5Igh3VBP2ecMzPrlzSv2qb3s73bZJ	INACTIVE	2026-06-02 14:54:06.29015
dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	Prakhar Tamboli	prakhar.tamboli@gmail.com	9039176375	Male	1993-08-03	Fat Loss	\N	2026-05-26 11:52:37.454911	2026-07-01 03:36:47.475425	33	India	Bilaspur	167	88	Lose fat and gain muscles	8 kgs	Yes	2	1	Morning	5	Yes	By being disciplined and maintaining my physique	No	No	No	No	No	9	7	Cricket and football at school and college 	Non-Vegetarian	Low (Desk job)	I wake up at 8 am in the morning after that I take breakfast and go to office at 10 am. My job is desk job so I usually sit at desk for around 8-10 hours. Since I deal with customers directly I deal with mental stress also I am an overthinker. I take 4 meals a day with no discipline and count of macros. I drink around 2-3 litres of water daily with 2000-3000 steps	No diet plan	Biryani, anything made from rice, poha daal, eggs chicken	Milk 	NO	No Injuries	All Good						https://drive.google.com/open?id=1aP_YYAPYwYvjPItTa5MrIgUS88toR3Cp	https://drive.google.com/open?id=1QDb9-roUg3cH7Gdt7gqjY5BLOorgKTg-	https://drive.google.com/open?id=1rgsn7DWz1EArHKt-7x3ByEpalEbhUFPH	ACTIVE	\N
80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	Shreya Verma	jshreyav09@gmail.com	8989115353	Female	1998-07-09	Fat Loss	\N	2026-05-07 13:39:01.576612	2026-07-16 13:27:55.46534	28	India	Jabalpur	165	67	Fat loss and muscle gain	9kg	Partially	4	1	Morning	5	No	Will plan some travel and eat good food		Not more than once a month	No	Take whey protein regularly 	No	4			Vegetarian	Low (Desk job)	Wake up at 8:30 am, breakfast at 10-10:30 lunch at 1:30pm evening snacks at 5-6pm tea in morning and evening, dinner by 9pm. Water intake in 3lit per day, 2-3k steps per day sleep by 1am	No	Eggs, paneer, idly/dosa, cheela, chicken(eat outside only), ice cream,	No	PCOS	No Injuries	PCOS/PCOD						https://drive.google.com/open?id=1V979xVH9BlXyMBfmKsTrdmcjfMKXxpYO	https://drive.google.com/open?id=1wTMYwbYcPTX9vP476ex-ZLw8omtrTRgt	https://drive.google.com/open?id=1ElEW7U1EenvC1HJK9oXYmg_c4NwNHkOn	ACTIVE	\N
57ee19de-9c3f-49bf-83d2-20a56100a64e	varun.deoghare@gmail.com	Bhagwati Sahu	Lalitksahu91@gmail.com	7879057634	Female	1969-09-12	General Fitness	\N	2026-05-23 15:22:19.375641	2026-07-01 03:36:08.771422	57	India	Chhattisgarh 	152	72	Get fit	No	No	No	40 min	Morning	4	No	Itself is a reward	No	No	No	No	No	1	7	Hockey national player in college	Vegetarian	Moderate (Teacher/Student/Homemaker)	Wake up at 6 30 am\n\nBreakfast and tea at 10 am\n\nNap for 2 hrs in afternoon\n\nEvening tea 5 30 pm\n\nDinner between 8 to 9 pm\n\nSleep at 11 pm	No	Everything in general	Not specific but die to prolonged cold and cough sour items are not allowed	High bp , thyroid	No Injuries	Cholesterol, Thyroid, High BP						https://drive.google.com/open?id=1BaPQDtXDR8WYmKy2yTlgFJcp7UGZIEhs	https://drive.google.com/open?id=17p9y96caXSQoDrSMGYL3Nh1jJEhFTAiO	https://drive.google.com/open?id=1dBlBpBjYVhRQLapbhdG_18rMWp_b0hQs	ACTIVE	\N
6ae0f3fa-0233-4160-ba88-11f4b8ae7e38	varun.deoghare@gmail.com	Jitendra Sahu	Lalitksahu92@gmail.com	9425556727	Male	1968-08-15	General Fitness	\N	2026-05-23 15:28:19.477609	2026-07-01 03:36:24.204586	58	India	Durg	165	79	Get fit , reduce cholesterol and other issues	No	No	No	45 mins	Morning	5	No	Itself is a reward	No	Once in a month	Once a week	No	No	2	6	No	Vegetarian	Low (Desk job)	Wake up - 7: 30 am depending on bsp shifts\n\nBreakfast with Tea 10 am\n\nLunch - 2 pm\n\nEvening tea - 5 30 pm\n\nDinner - 9 pm\n\nSleep at 11 pm\n	Not specifically 	Egg, milk, ghee , paneer, idli dosa etc in general all items but non veg we don’t cook on house	Not applicable 	High Bp, 	Ribs got fractured due to an accident two years ago	Cholesterol						https://drive.google.com/open?id=10AIDclv3UM_BF7faPamdkDpk0P5Vl4L3	https://drive.google.com/open?id=153ERwzSyQjT6PmYbukvJ3h9I-yEyKxKH	https://drive.google.com/open?id=1El0a-RxeM9-8hFHnIRV5BWACwJ5RzBUY	ACTIVE	\N
8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	Rishikant Soni	Rishikantjbp@gmail.com	8989891537	Male	1995-01-19	Muscle Gain	\N	2026-05-04 04:10:55.19084	2026-06-22 04:11:47.349129	31	India	Pune	180	73	Build a fit and a lean muscular body	Yes, 4kg	No	No	1	Flexible	4	No	Buy myself a lot of clothes	Bhaiya meri nangi photos kisi ko mat dikhana ≡ƒÑ╣≡ƒÑ╣	Very occasionally 	No	No	No	6	7	Cricket club	Non-Vegetarian	Low (Desk job)	10-11 wake up breakfast  start office\n2-3 lunch\n8-9 wrap office \n9-10 gym \n10-11 dinner followed by work	Home food, less oil, focus on protein intake	Pani puri	Lactose intolerant 	Knee issues - damaged ligaments while skiing Γ¢╖∩╕Å 	Knee	All Good						https://drive.google.com/open?id=1nOoEXXpCscNg7nqMKMWcbxtquIQNJoeM	https://drive.google.com/open?id=1VTa-PK4jKrrV3_gQrAOSDMbOjcYE-mVQ	https://drive.google.com/open?id=1kP7CNtuxgp3AHPX8n4bG95-m1769uKDQ	INACTIVE	2026-06-22 04:11:47.349128
930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	Shilpa Bhadang	shilpabhadng@gmail.com	8766927681	Female	1982-09-18	Fat Loss	\N	2026-07-05 08:01:07.370719	2026-07-05 08:01:07.373295	44	India	Maharashtra	150	68	Fat loss and muscle strength gain	Yes 7 kg, zumba daily and diet	Yes	1 year (home)	1 hr	Morning	6	No	Wear western clothes and go for vacation and click many photos		No	No	No	No	8	4	Yes	Vegetarian	Moderate (Teacher/Student/Homemaker)	5.30 Wakeup\n1 cup tea without sugar\n2 Marie Gold Biscuit\n8.45 School\nLunch 2 roti sabji\n3.45 School return\n4.30 Tea without sugar\n6PM Munching\n6-8 Tution\n9.30 Roti Sabji Rice Daal\n1 Am Sleep		Chai Paratha	No	High BP (190-110)	Shoulder, Right Shoulder	NA						https://drive.google.com/open?id=1B9juQnOQWSQcBC29PqYTTXaAMt8rB0lM	https://drive.google.com/open?id=1O2qpEsizpNf4hpZuUuH_IkYVwonkIHy_	https://drive.google.com/open?id=1QmU9221js_BhjjgpVkFZWKjByqVVcPkM	ACTIVE	\N
e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	Aman pandey	amann24pandeyy26@gmail.com	07489057144	Male	1995-08-24	Fat Loss	\N	2026-07-05 08:01:57.101169	2026-07-05 08:01:57.101292	30	India	Durg	173	86	Weight loss & be fit 	Yes by exercise & diet 	Yes	1	1.5	Morning	5	No	I will go for long vacation 	How to reduce my weight 	2 days 	No 	Whey protein 	No 	4	7	Cricket 	Vegetarian	Moderate (Teacher/Student/Homemaker)	Waking time - 6 am , meal - pure veg ghar ka khana , work - field work , sleep - 7 hr , steps - 3000, water intake- 3-4 l 	No 	Samosa , pizza , burger, all type of sweets	No	Normal 	No Injuries	All Good						https://drive.google.com/open?id=1gl77M1j0jwYz3P2c_o7pqGePZk9pYc1-	https://drive.google.com/open?id=1rt3BEAt_FZyYp06WJbHlsjUsICqTuPmk	https://drive.google.com/open?id=18G0OBk8odTnVKf7M5td5scXQbqW9V5OB	ACTIVE	\N
615a4248-15d6-44d0-a223-c80055813fbd	varun.deoghare@gmail.com	Rashmi Tamane Deoghare	Rtamane96@gmail.com	9584042542	Female	1996-07-11	Fat Loss	\N	2026-03-17 12:01:23.604698	2026-06-19 03:26:12.742091	29	India	Pune	157	66	Fat loss	63	Partially	Trained under Varun Deoghare for few months	2	Morning	4	No	Achieving goal is itself a reward for me ≡ƒÿè	What if i crave icecream weekly? 	No	No	No	No	4	6.5	Yes	Vegetarian	Low (Desk job)	Waking up at 5:45 . Gym workout for 1.5 hrs. Breakfast. Office .Lunch. Office. Dinner. Walk. Sleep		NA	NA	No	No Injuries	All Good						https://drive.google.com/open?id=1NLnIbDoYByYM6weVmfmJExzpBXJRcAsJ	https://drive.google.com/open?id=1q1R2PNb4rJ3zoOVDMJBDtHvlRn9QFe2u	https://drive.google.com/open?id=1NP04fMuz6ybg8Kf7ugSYL2Fibs9fVsW6	INACTIVE	2026-06-19 03:26:12.74209
f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	Nitin Gupta	Nnitingupta24@gmail.com	8109464940	Male	1996-06-24	Fat Loss	\N	2026-05-07 13:38:11.232665	2026-07-16 13:27:37.210944	30	India	Jabalpur	180	80	Fat loss and better muscles definition	Yes, 7kg	Yes	5 years of self training 	1 hour	Morning	5	No	Boys trip with my coach		Yes once in a month	No	Whey protiens	No	4	6	School- regular athete	Vegetarian	Low (Desk job)	Waking ΓÅ░∩╕Å > 8am\nMeals> breakfast lunch tea snacks dinner\nWork > 5 to 6 hrs desk job\nSleep> at 1 am approx\nWater > 4-5 ltr	Not available 	Eggs\nPaneer\nIdly/dosa\nCheela\nPastry	Nothing 	Nope	1 year old right feet ATFL Injury- recovered completely  2 year old neck muscles Injury- recovered completely but take precautions while doing exercise 	All Good						https://drive.google.com/open?id=1BGPAjBps0_1DaTNj7D4sdjj47Wg9nbPq	https://drive.google.com/open?id=1QyY746-8124sYJ_n4U5n0_x-qqL4g1_0	https://drive.google.com/open?id=14lxbP5Y2fgdBMveh31ybZnYyvLoRSFPM	ACTIVE	\N
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

\unrestrict z6rsJFchzYL57iEVQ0IfUgSM0keWXESHxqX2S4ONwMhbU2sSRKuoBhgDpAgoByp

--
-- Database "coach_notification" dump
--

--
-- PostgreSQL database dump
--

\restrict 8a2LJGKehKDHbyuZlJBgL6Ah556rRgWyfvSLLpPspSrj1YgfC5cyENLCbuqECzi

-- Dumped from database version 15.18 (Debian 15.18-1.pgdg13+1)
-- Dumped by pg_dump version 15.18 (Debian 15.18-1.pgdg13+1)

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

\unrestrict 8a2LJGKehKDHbyuZlJBgL6Ah556rRgWyfvSLLpPspSrj1YgfC5cyENLCbuqECzi
\connect coach_notification
\restrict 8a2LJGKehKDHbyuZlJBgL6Ah556rRgWyfvSLLpPspSrj1YgfC5cyENLCbuqECzi

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
    updated_at timestamp with time zone,
    provider character varying(40),
    provider_message_id character varying(120)
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	create notifications table	SQL	V1__create_notifications_table.sql	-852896165	postgres	2026-03-11 06:57:49.458619	832	t
2	2	add whatsapp notification metadata	SQL	V2__add_whatsapp_notification_metadata.sql	-1715987922	postgres	2026-06-12 03:18:02.094314	23	t
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, member_id, coach_email, channel, notification_type, recipient, subject, message, status, error_message, created_at, updated_at, provider, provider_message_id) FROM stdin;
6f702984-bb9d-4717-96e7-b47b217ba1d0	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	WHATSAPP	PAYMENT_REMINDER	9584042542	\N	Hello ANWAR,\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ₹1,500 to continue your coaching plan.\n\nRenewal date: 07 Jun 2026.\n\nYou can pay via UPI ID: 9584042542@ybl. Please review the attached billing snapshot and payment details.	SENT	\N	2026-06-19 07:58:24.916827+00	2026-06-19 07:58:29.58567+00	WHATSAPP	wamid.HBgMOTE5NTg0MDQyNTQyFQIAERgSQzE0NzM1RDc4ODhDMEFBNDcyAA==
e9574828-b243-45dc-ae45-8b8a92e3888e	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	WHATSAPP	DIET_PLAN	9584042542	\N	🥗 Diet Plan for ANWAR KHAN\n\n💧 Hydration First\n\nDrink plenty of water throughout the day 🚰\n\nAim for at least 4 litres daily\n\n🌅 Breakfast\n🥘 60g 60g Poha/Upma/Daliya/2 Bread\n🥚 1whole 1 whole egg\n🌰 5almonds 5 almonds\n☕ 5g 5g Black Coffee\n🫒 5g 5g Cooking Oil\n🥚 4egg 4 egg white\n\n🍛 Lunch\n🍚 60g 60g Rice/Whole Wheat Flour Roti\n🥚 100g 100g Chicken Breast/50g Soya/6 Egg Whites\n🥗 200g 200g Raw or Cooked Vegetable\n🫒 5g 5g Cooking Oil\n🥣 300g 300g Curd\n🥘 50g 50g Daal/Rajma/Chole\n\n☕ Snacks\n☕ 5g 5g Black Coffee\n• 150ml 150 ml Full Cream Milk\n• 5g 5g Sugar\n• 2Brown 2 Brown Bread\n\n🌙 Dinner\n🍚 60g 60gRice/Whole Wheat Flour Roti\n🥚 100g 100g Paneer/3 Whole Eggs\n🥗 200g 200g Raw or Cooked Vegetable\n🫒 5g 5g Cooking Oil\n\n📊 Daily Nutrition\n\n🔥 Calories: 2075 kcal\n🥩 Protein: 118 g\n🍚 Carbohydrates: 260 g\n🥜 Fats: 63 g\n\n💬 Final Notes\n\n✨ Include a protein source in every main meal\n✨ Maintain portion accuracy\n✨ Hit daily step target consistently\n✨ Recover well 💪\n\n👉 Consistency > Perfection 🚀\n\n⚡ Quick Rules\n\n✔️ 60g Rice = 60g Wheat Flour = 60g Daliya\n✔️ 2 Brown Bread ≈ 60g Rice\n✔️ 50g Dal ≈ 50g Rajma ≈ 50g Chole\n✔️ 100g Chicken Breast ≈ 6 Egg Whites ≈ 50g Soya Chunks\n✔️ 100g Paneer ≈ 3 Whole Eggs\n✔️ Total Oil Intake ≈ 15g/day\n✔️ 1 Apple ≈ 1 Banana ≈ 100-120g Mango ≈ 150g Papaya ≈ 250-300g Watermelon ≈ 150g Pineapple	FAILED	WhatsApp Cloud API error: {"error":{"message":"(#132018) There’s an issue with the parameters in your template","code":132018,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"Param text cannot have new-line/tab characters or more than 4 consecutive spaces"},"fbtrace_id":"A8SIM3ed8KnWt53x4uz3E23"}}	2026-06-20 03:43:01.438425+00	2026-06-20 03:43:02.440539+00	WHATSAPP	\N
5caecace-ec65-4d48-b4bb-77d9c9ed5a1c	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	9770516659	\N	Hello MOHIT,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 20 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 31 May 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-20 04:03:45.143979+00	2026-06-20 04:03:48.443827+00	WHATSAPP	wamid.HBgMOTE5NzcwNTE2NjU5FQIAERgSMDM3NTBFNjVEMzI4RUVEMjk0AA==
d0c6fae1-1d7f-4a53-86fb-5e223ec5aca6	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	70677 39630	\N	Hello MAYANK,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 27 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 24 May 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-20 04:03:50.500395+00	2026-06-20 04:03:52.989679+00	WHATSAPP	wamid.HBgMOTE3MDY3NzM5NjMwFQIAERgSOTg3OUJFRjRBQjEyMzlGQjNBAA==
f2c3d83f-8bf2-4f36-8da6-0bbdea990663	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	WHATSAPP	PAYMENT_REMINDER	9030223950	\N	Hello Sudhanshu,\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ₹1,000 to continue your coaching plan.\n\nRenewal date: 24 Jun 2026.\n\nYou can pay via UPI ID: 9584042542@ybl. Please review the attached billing snapshot and payment details.	SENT	\N	2026-06-26 04:07:43.683662+00	2026-06-26 04:07:50.662085+00	WHATSAPP	wamid.HBgMOTE5MDMwMjIzOTUwFQIAERgSNEM4MDgwNTQ0ODA4NzFDQTE1AA==
f7cfb139-2aa4-44e7-9a53-02e034ab6a4e	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	WHATSAPP	PAYMENT_REMINDER	9039176375	\N	Hello Prakhar,\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ₹1,500 to continue your coaching plan.\n\nRenewal date: 29 Jun 2026.\n\nYou can pay via UPI ID: 9584042542@ybl. Please review the attached billing snapshot and payment details.	SENT	\N	2026-06-30 03:45:54.316698+00	2026-06-30 03:45:57.190158+00	WHATSAPP	wamid.HBgMOTE5MDM5MTc2Mzc1FQIAERgSNzY2RDJERjkzQ0I2MjYwNzREAA==
06b607bb-7602-4117-9c81-6f97d3a24e85	6ae0f3fa-0233-4160-ba88-11f4b8ae7e38	varun.deoghare@gmail.com	WHATSAPP	PAYMENT_REMINDER	9425556727	\N	Hello Jitendra,\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ₹1,000 to continue your coaching plan.\n\nRenewal date: 25 Jun 2026.\n\nYou can pay via UPI ID: 9584042542@ybl. Please review the attached billing snapshot and payment details.	SENT	\N	2026-07-01 03:07:38.307504+00	2026-07-01 03:07:41.84551+00	WHATSAPP	wamid.HBgMOTE5NDI1NTU2NzI3FQIAERgSQzcxODYyNjYwM0EyRDZBMTgyAA==
82a04e14-a715-4227-9d75-47fdbad9ed54	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	WHATSAPP	PAYMENT_REMINDER	8087535411	\N	Hello ANWAR,\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ₹1,500 to continue your coaching plan.\n\nRenewal date: 6 Jul 2026.\n\nYou can pay via UPI ID: 9584042542@ybl. Please review the attached billing snapshot and payment details.	SENT	\N	2026-07-09 04:32:28.172932+00	2026-07-09 04:32:33.283274+00	WHATSAPP	wamid.HBgMOTE4MDg3NTM1NDExFQIAERgSRkUyMkVEMTk2OUNBNkRDQTIzAA==
d4895980-e003-4952-a50b-22c78a86a4b8	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	9030223950	\N	Hello SUDHANSHU,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 27 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 21 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-07-18 08:03:12.309724+00	2026-07-18 08:03:18.446063+00	WHATSAPP	wamid.HBgMOTE5MDMwMjIzOTUwFQIAERgSM0Q3MzUxMTlGMjA2MDgxNzNEAA==
27334928-555d-4622-afc3-51ccbb5d31a4	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	8109464940	\N	Hello NITIN,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 15 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 03 Jul 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-07-18 08:03:27.192098+00	2026-07-18 08:03:30.743318+00	WHATSAPP	wamid.HBgMOTE4MTA5NDY0OTQwFQIAERgSMTEyNDQwMkMxN0IxRDhENzY4AA==
130f0088-ca29-4b0d-8445-b335bbd316c3	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	WHATSAPP	PAYMENT_REMINDER	9584042542	\N	Hello MOHIT,\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ₹1,500 to continue your coaching plan.\n\nRenewal date: 20 Jun 2026.\n\nYou can pay via UPI ID: 9584042542@ybl. Please review the attached billing snapshot and payment details.	SENT	\N	2026-06-19 08:08:21.360845+00	2026-06-19 08:08:25.149116+00	WHATSAPP	wamid.HBgMOTE5NTg0MDQyNTQyFQIAERgSRTAxQTc4QkVEMEQxRDI1QTRGAA==
a21ecb16-f7f6-4782-a725-6671e6da72c5	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	WHATSAPP	DIET_PLAN	9584042542	\N	🥗 Diet Plan for ANWAR KHAN\n\n💧 Hydration First\n\nDrink plenty of water throughout the day 🚰\n\nAim for at least 4 litres daily\n\n🌅 Breakfast\n🥘 60g 60g Poha/Upma/Daliya/2 Bread\n🥚 1whole 1 whole egg\n🌰 5almonds 5 almonds\n☕ 5g 5g Black Coffee\n🫒 5g 5g Cooking Oil\n🥚 4egg 4 egg white\n\n🍛 Lunch\n🍚 60g 60g Rice/Whole Wheat Flour Roti\n🥚 100g 100g Chicken Breast/50g Soya/6 Egg Whites\n🥗 200g 200g Raw or Cooked Vegetable\n🫒 5g 5g Cooking Oil\n🥣 300g 300g Curd\n🥘 50g 50g Daal/Rajma/Chole\n\n☕ Snacks\n☕ 5g 5g Black Coffee\n• 150ml 150 ml Full Cream Milk\n• 5g 5g Sugar\n• 2Brown 2 Brown Bread\n\n🌙 Dinner\n🍚 60g 60gRice/Whole Wheat Flour Roti\n🥚 100g 100g Paneer/3 Whole Eggs\n🥗 200g 200g Raw or Cooked Vegetable\n🫒 5g 5g Cooking Oil\n\n📊 Daily Nutrition\n\n🔥 Calories: 2075 kcal\n🥩 Protein: 118 g\n🍚 Carbohydrates: 260 g\n🥜 Fats: 63 g\n\n💬 Final Notes\n\n✨ Include a protein source in every main meal\n✨ Maintain portion accuracy\n✨ Hit daily step target consistently\n✨ Recover well 💪\n\n👉 Consistency > Perfection 🚀\n\n⚡ Quick Rules\n\n✔️ 60g Rice = 60g Wheat Flour = 60g Daliya\n✔️ 2 Brown Bread ≈ 60g Rice\n✔️ 50g Dal ≈ 50g Rajma ≈ 50g Chole\n✔️ 100g Chicken Breast ≈ 6 Egg Whites ≈ 50g Soya Chunks\n✔️ 100g Paneer ≈ 3 Whole Eggs\n✔️ Total Oil Intake ≈ 15g/day\n✔️ 1 Apple ≈ 1 Banana ≈ 100-120g Mango ≈ 150g Papaya ≈ 250-300g Watermelon ≈ 150g Pineapple	SENT	\N	2026-06-20 03:45:29.468435+00	2026-06-20 03:45:31.067921+00	WHATSAPP	wamid.HBgMOTE5NTg0MDQyNTQyFQIAERgSQzY1RTVCQTQ3QUNFMTUyODk2AA==
c4637902-1cfb-48a2-9222-0ee0a17dbd66	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	WHATSAPP	DIET_PLAN	9584042542	\N	🥗 Diet Plan for Prakhar Tamboli\n\n💧 Hydration First\n\nDrink plenty of water throughout the day 🚰\n\nAim for at least 4 litres daily\n\n☕ Pre-Workout\n\n☕ Black Coffee – 5g\n🍎 Fruit — Choose one 👇\n\n🍎 1 Apple\n🍌 1 Banana\n🥭 120g Mango\n🍍 150g Pineapple\n🍉 300g Watermelon\n\n🌅 Breakfast\n\nChoose one option 👇\n\n🥣 60g Poha\n🍲 60g Upma\n🍝 60g Vermicelli\n🥣 60g Oats\n🫓 60g Wheat Flour (Paratha)\n🍞 2 Brown Bread (Sandwich)\n🥞 60g Chilla\n\n➕ Add:\n\n🥚 1 Whole Egg\n🥚 2 Egg Whites\n\n🫒 5g Cooking Oil\n\n🍛 Lunch\n\nChoose one option 👇\n\n🍚 60g Rice\n🫓 60g Whole Wheat Flour (Roti)\n\n➕ Add:\n\n🥘 50g Any Dal / Rajma / Chole\n🍗 100g Chicken Breast\nOR\n🥚 6 Egg Whites\nOR\n🌱 50g Soya Chunks\n\n🥗 200g Raw or Cooked Vegetables\n🥣 200g Curd\n🫒 5g Cooking Oil\n\n☕ Evening Snacks\n\n🍎 Fruit — Choose one 👇\n\n🍎 1 Apple\n🍌 1 Banana\n🥭 120g Mango\n🍍 150g Pineapple\n🍉 300g Watermelon\n\n🌰 5 Almonds\n🌰 5 Cashews\n\n🌙 Dinner\n\nChoose one option 👇\n\n🍚 60g Rice\n🫓 60g Whole Wheat Flour (Roti)\n\n➕ Add:\n\n🧀 100g Paneer\nOR\n🥚 3 Whole Eggs\n\n🥬 100g Raw Spinach\n🥗 200g Raw or Cooked Vegetables\n🫒 5g Cooking Oil\n\n\n📊 Daily Nutrition\n\n🔥 Calories: 1959 kcal\n🥩 Protein: 98g\n🍚 Carbohydrates: 258g\n🥜 Fats: 55g\n\n\n💬 Final Notes\n\n✨ Include a protein source in every main meal\n✨ Maintain portion accuracy\n✨ Hit daily step target consistently\n✨ Recover well 💪\n\n👉 Consistency > Perfection 🚀\n\n\n⚡ Quick Rules\n\n✔️ 60g Rice = 60g Wheat Flour = 60g Daliya\n✔️ 2 Brown Bread ≈ 60g Rice\n✔️ 50g Dal ≈ 50g Rajma ≈ 50g Chole\n✔️ 100g Chicken Breast ≈ 6 Egg Whites ≈ 50g Soya Chunks\n✔️ 100g Paneer ≈ 3 Whole Eggs\n✔️ Total Oil Intake ≈ 15g/day\n✔️ 1 Apple ≈ 1 Banana ≈ 100–120g Mango ≈ 150g Papaya ≈ 250–300g Watermelon ≈ 150g Pineapple	SENT	\N	2026-06-20 03:46:11.148331+00	2026-06-20 03:46:12.384175+00	WHATSAPP	wamid.HBgMOTE5NTg0MDQyNTQyFQIAERgSREQwQkQ4OTA2MkM2RTJEOTcxAA==
ae5e35c0-a894-43a9-a4f9-eceb94dfd971	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	WHATSAPP	PAYMENT_REMINDER	9770516659	\N	Hello MOHIT,\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ₹1,500 to continue your coaching plan.\n\nRenewal date: 20 Jun 2026.\n\nYou can pay via UPI ID: 9584042542@ybl. Please review the attached billing snapshot and payment details.	FAILED	Could not extract response: no suitable HttpMessageConverter found for response type [interface java.util.Map] and content type [text/javascript;charset=UTF-8]	2026-06-22 03:27:12.859317+00	2026-06-22 03:27:18.488621+00	WHATSAPP	\N
cc5e75ae-2ba4-4e56-a352-4cfaac29a1ad	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	9039176375	\N	Hello PRAKHAR,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 20 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 08 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-28 08:26:24.49391+00	2026-06-28 08:26:29.092022+00	WHATSAPP	wamid.HBgMOTE5MDM5MTc2Mzc1FQIAERgSMEQyRTkyRjhGMzYzOTE0MkE3AA==
ad1cecfa-0e64-4bfb-bb6e-a70ad9f6b628	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	WHATSAPP	PAYMENT_REMINDER	7974985243	\N	Hello Khushbu,\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ₹1,000 to continue your coaching plan.\n\nRenewal date: 28 Jun 2026.\n\nYou can pay via UPI ID: 9584042542@ybl. Please review the attached billing snapshot and payment details.	SENT	\N	2026-07-01 03:07:14.217+00	2026-07-01 03:07:19.118814+00	WHATSAPP	wamid.HBgMOTE3OTc0OTg1MjQzFQIAERgSRjM0OEE4MTI2MDM3Mzg2NDlEAA==
3c4b4716-58c2-48a9-8bc7-8a456d1e7e78	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	WHATSAPP	PAYMENT_REMINDER	7828673538	\N	Hello Shailesh,\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ₹1,000 to continue your coaching plan.\n\nRenewal date: 28 Jun 2026.\n\nYou can pay via UPI ID: 9584042542@ybl. Please review the attached billing snapshot and payment details.	SENT	\N	2026-07-01 03:07:26.154357+00	2026-07-01 03:07:29.61758+00	WHATSAPP	wamid.HBgMOTE3ODI4NjczNTM4FQIAERgSOUUxNTcyQTYyNzE0MkQ1MDQxAA==
ab94d1f8-bcef-4653-beca-778582b102fb	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	WHATSAPP	WORKOUT_PLAN	8766927681	\N	Hi Shilpa Bhadang, your workout plan is attached. Plan: Home Based Workout. Target steps: 6000. Please follow it as discussed.	SENT	\N	2026-07-05 14:49:41.727071+00	2026-07-05 14:49:47.049848+00	WHATSAPP	wamid.HBgMOTE4NzY2OTI3NjgxFQIAERgSQTMxNTg2NkE3QkY0N0Q5RTk1AA==
d0324fab-49c5-4c7c-aed8-9f3aefb53054	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	8269499713	\N	Hello PRATEEK,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is due today. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 11 Jul 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-07-11 04:24:52.891409+00	2026-07-11 04:24:57.078484+00	WHATSAPP	wamid.HBgMOTE4MjY5NDk5NzEzFQIAERgSMDc5MEVFNURFMzFCRTRFNERBAA==
f752f547-e73f-4d28-b5ca-93039ec43796	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	9039176375	\N	Hello PRAKHAR,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 3 days left. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 14 Jul 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-07-11 04:26:04.218728+00	2026-07-11 04:26:06.586374+00	WHATSAPP	wamid.HBgMOTE5MDM5MTc2Mzc1FQIAERgSNjY2OUI5RDg5Mjk2RkQwNzdDAA==
dd1eea74-1f0e-4b29-93c7-909b048cc640	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	WHATSAPP	DIET_PLAN	9584042542	\N	🥗 Diet Plan for ANWAR KHAN\n\n💧 Hydration First\nDrink plenty of water throughout the day 🚰\nAim for at least 2.5-3 litres daily	SENT	\N	2026-06-20 03:15:22.0764+00	2026-06-20 03:15:23.232207+00	WHATSAPP	wamid.HBgMOTE5NTg0MDQyNTQyFQIAERgSMkM5MkE0OTJENEZGQUIxQ0IzAA==
cba882ab-ae93-4a5d-831e-32aa76409feb	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	9039176375	\N	Hello PRAKHAR,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 12 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 08 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-20 04:01:59.974695+00	2026-06-20 04:02:02.889547+00	WHATSAPP	wamid.HBgMOTE5MDM5MTc2Mzc1FQIAERgSQzExMjJGNjE1NkMwRUU0QkNGAA==
0c0bb636-dc96-4d1e-ad9e-e29ae6e1b095	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	WHATSAPP	WORKOUT_PLAN	9030223950	\N	Hi Sudhanshu Shekhar Singh, your workout plan is attached. Plan: Push Pull Legs (8-10 weeks). Target steps: 10000. Please follow it as discussed.	FAILED	Could not extract response: no suitable HttpMessageConverter found for response type [interface java.util.Map] and content type [text/javascript;charset=UTF-8]	2026-06-22 03:32:48.289501+00	2026-06-22 03:32:51.342935+00	WHATSAPP	\N
f0a12a2a-8efd-47b3-a41a-dbb797421a03	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	WHATSAPP	PAYMENT_REMINDER	9631597047	\N	Hello Prashant,\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ₹1,000 to continue your coaching plan.\n\nRenewal date: 30 Jun 2026.\n\nYou can pay via UPI ID: 9584042542@ybl. Please review the attached billing snapshot and payment details.	SENT	\N	2026-06-30 03:26:02.509946+00	2026-06-30 03:26:08.571804+00	WHATSAPP	wamid.HBgMOTE5NjMxNTk3MDQ3FQIAERgSMDQ2RDYyNTI2ODRFRkI1RDk0AA==
9a00de7c-3e88-4403-9dc7-b9a9e0dc37c3	57ee19de-9c3f-49bf-83d2-20a56100a64e	varun.deoghare@gmail.com	WHATSAPP	PAYMENT_REMINDER	7879057634	\N	Hello Bhagwati,\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ₹1,000 to continue your coaching plan.\n\nRenewal date: 25 Jun 2026.\n\nYou can pay via UPI ID: 9584042542@ybl. Please review the attached billing snapshot and payment details.	SENT	\N	2026-07-01 03:07:32.628736+00	2026-07-01 03:07:36.295458+00	WHATSAPP	wamid.HBgMOTE3ODc5MDU3NjM0FQIAERgSQzgzMDlDMzk0QThGQzAwMjk2AA==
fadfc31a-7a93-493d-a4c7-5d65c97d4f5e	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	WHATSAPP	DIET_PLAN	8766927681	\N	🥗 Diet Plan for Shilpa Bhadang\n💧 Hydration First\n\nDrink plenty of water throughout the day 🚰\n\nAim for at least 4 litres daily\n\n🌅 Breakfast\n\nChoose one option 👇\n\n🥣 50g Poha\n\n🍲 50g Upma\n\n🥣 50g Daliya\n\n➕\n\n🥛 200ml Full Cream Milk\n\n☕ Tea (Without Sugar)\n\n🫒 5g Cooking Oil\n\n💊 Multivitamin\n\n🍛 Lunch\n\nChoose one option 👇\n\n🍚 40g Rice\n\n🫓 40g Wheat Flour (Roti)\n\n🥣 40g Daliya\n\n➕\n\n🥗 200g Raw/Cooked Vegetables\n\n🧀 50g Paneer\n\n🥣 100g Curd\n\n🫒 5g Cooking Oil\n\n☕ Evening Snacks\n\n🍎1 Apple ≈ 1 Banana ≈ 100–120g Mango ≈ 150g Papaya ≈ 250–300g Watermelon ≈ 150g Pineapple\n\n🥛 200ml Full Cream Milk\n\n🌰 30g Roasted Chana\n\n🌙 Dinner\n\nChoose one option 👇\n\n🍚 40g Rice\n\n🫓 40g Wheat Flour (Roti)\n\n🥣 40g Daliya\n\n➕\n\n🥗 200g Raw/Cooked Vegetables\n\n🥣 40g Dal / Rajma / Chole\n\n🫒 5g Cooking Oil\n\n\n📊 Daily Nutrition\n\n🔥 Calories: 1500 kcal\n🥩 Protein: 57 g\n🍚 Carbohydrates: 211 g\n🥜 Fats: 43 g\n\n💬 Final Notes\n\n✨ Include a protein source in every main meal\n✨ Maintain portion accuracy\n✨ Hit daily step target consistently\n✨ Recover well 💪\n\n👉 Consistency > Perfection 🚀\n\n⚡ Quick Rules\n\n✔️ 40g Rice = 40g Wheat Flour = 40g Daliya\n\n✔️ 2 Brown Bread ≈ 60g Rice\n\n✔️ 40g Dal ≈ 40g Rajma ≈ 40g Chole\n\n✔️ Total Oil Intake ≈ 15g/day\n\n✔️ 1 Apple ≈ 1 Banana ≈ 100–120g Mango ≈ 150g Papaya ≈ 250–300g Watermelon ≈ 150g Pineapple	SENT	\N	2026-07-05 14:49:50.908036+00	2026-07-05 14:49:51.621405+00	WHATSAPP	wamid.HBgMOTE4NzY2OTI3NjgxFQIAERgSNkUzQzE4MUVBRjJFQTlGNkUyAA==
f5f2ce0e-47b7-4a7f-99a5-d8ac442f26ed	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	8087535411	\N	Hello ANWAR,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is due today. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 11 Jul 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-07-11 04:27:25.072474+00	2026-07-11 04:27:27.582234+00	WHATSAPP	wamid.HBgMOTE4MDg3NTM1NDExFQIAERgSQ0EyMUVCQThENDhFRjM3MDA1AA==
54fdc59f-85c9-4686-abeb-6f3c0fbd15e9	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	9030223950	\N	Hello SUDHANSHU,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 20 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 21 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-07-11 04:27:58.085822+00	2026-07-11 04:28:00.086602+00	WHATSAPP	wamid.HBgMOTE5MDMwMjIzOTUwFQIAERgSNTNFMkQ3RTNDODkyRUVDNzNBAA==
17c5b866-a0b4-4194-8e38-29201592a919	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	9631597047	\N	Hello PRASHANT,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 28 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 13 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-07-11 04:28:30.089739+00	2026-07-11 04:28:32.401711+00	WHATSAPP	wamid.HBgMOTE5NjMxNTk3MDQ3FQIAERgSRTBEOEVEQkMwRUE1REJDOTMwAA==
91e287d7-3cb3-4655-97b6-2178c61ec844	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	9030223950	\N	Hello SUDHANSHU,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 27 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 21 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-07-18 08:03:33.990155+00	2026-07-18 08:03:37.400333+00	WHATSAPP	wamid.HBgMOTE5MDMwMjIzOTUwFQIAERgSN0QxQUJBRkVCQ0YyNTJGQ0NGAA==
985b7b36-0a25-493c-949e-204758f9bd54	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	07489057144	\N	Hello AMAN,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is due today. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 18 Jul 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-07-18 08:03:40.081901+00	2026-07-18 08:03:43.395988+00	WHATSAPP	wamid.HBgMOTE3NDg5MDU3MTQ0FQIAERgSRTJFOTc3MUJEMUI3MjA3RDNGAA==
ffa8698a-15cc-4a51-89c2-fd9bd2cedcea	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	WHATSAPP	DIET_PLAN	9584042542	\N	🥗 Diet Plan for ANWAR KHAN\n\n💧 Hydration First\n\nDrink plenty of water throughout the day 🚰\n\nAim for at least 4 litres daily\n\n🌅 Breakfast\n🥘 60g 60g Poha/Upma/Daliya/2 Bread\n🥚 1whole 1 whole egg\n🌰 5almonds 5 almonds\n☕ 5g 5g Black Coffee\n🫒 5g 5g Cooking Oil\n🥚 4egg 4 egg white\n\n🍛 Lunch\n🍚 60g 60g Rice/Whole Wheat Flour Roti\n🥚 100g 100g Chicken Breast/50g Soya/6 Egg Whites\n🥗 200g 200g Raw or Cooked Vegetable\n🫒 5g 5g Cooking Oil\n🥣 300g 300g Curd\n🥘 50g 50g Daal/Rajma/Chole\n\n☕ Snacks\n☕ 5g 5g Black Coffee\n• 150ml 150 ml Full Cream Milk\n• 5g 5g Sugar\n• 2Brown 2 Brown Bread\n\n🌙 Dinner\n🍚 60g 60gRice/Whole Wheat Flour Roti\n🥚 100g 100g Paneer/3 Whole Eggs\n🥗 200g 200g Raw or Cooked Vegetable\n🫒 5g 5g Cooking Oil\n\n📊 Daily Nutrition\n\n🔥 Calories: 2075 kcal\n🥩 Protein: 118 g\n🍚 Carbohydrates: 260 g\n🥜 Fats: 63 g\n\n💬 Final Notes\n\n✨ Include a protein source in every main meal\n✨ Maintain portion accuracy\n✨ Hit daily step target consistently\n✨ Recover well 💪\n\n👉 Consistency > Perfection 🚀\n\n⚡ Quick Rules\n\n✔️ 60g Rice = 60g Wheat Flour = 60g Daliya\n✔️ 2 Brown Bread ≈ 60g Rice\n✔️ 50g Dal ≈ 50g Rajma ≈ 50g Chole\n✔️ 100g Chicken Breast ≈ 6 Egg Whites ≈ 50g Soya Chunks\n✔️ 100g Paneer ≈ 3 Whole Eggs\n✔️ Total Oil Intake ≈ 15g/day\n✔️ 1 Apple ≈ 1 Banana ≈ 100-120g Mango ≈ 150g Papaya ≈ 250-300g Watermelon ≈ 150g Pineapple	SENT	\N	2026-06-20 03:39:43.799971+00	2026-06-20 03:39:45.17959+00	WHATSAPP	wamid.HBgMOTE5NTg0MDQyNTQyFQIAERgSNjcyNUFGQkU0MkU5QkM4QjVDAA==
6c1ea847-1519-4b44-ac67-d6d50d591bf4	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	8989115353	\N	Hello SHREYA,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 6 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 14 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-20 04:02:55.560077+00	2026-06-20 04:02:58.650341+00	WHATSAPP	wamid.HBgMOTE4OTg5MTE1MzUzFQIAERgSM0YzM0JCQUI0OTcxQzg3NTgwAA==
feeac0be-a819-4d71-8b96-ec54dda0d304	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	7974985243	\N	Hello KHUSHBU,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 6 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 14 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-20 04:03:03.455124+00	2026-06-20 04:03:06.661855+00	WHATSAPP	wamid.HBgMOTE3OTc0OTg1MjQzFQIAERgSQUEzMDNCRUY3MEUzNEE5NkFEAA==
fb837ae6-fe09-4e15-9346-1dba2cf53d18	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	WHATSAPP	WEEKLY_CONSISTENCY_REPORT	8989891537	\N	Hi Rishikant Soni, here is your weekly consistency report.\nWeek: 15 Jun - 19 Jun\nScore: 0/100 (Needs Improvement)\nWorkouts: 0/6\nAverage steps: 0 / 6000\nFocus: Complete workouts and hit step target more consistently.\nCoach feedback: Consistency was below target this week. \nPriority: Complete all scheduled workouts and Improve daily step count consistency.	SENT	\N	2026-06-19 03:28:42.048396+00	2026-06-19 03:28:44.863042+00	WHATSAPP	wamid.HBgMOTE4OTg5ODkxNTM3FQIAERgSNzA4Q0NGOTJBNTVFMDkwNzA4AA==
c32cdf40-856f-41cf-8fdb-7e80219eb8d8	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	7828673538	\N	Hello SHAILESH,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 6 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 14 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-20 04:03:08.757692+00	2026-06-20 04:03:11.423017+00	WHATSAPP	wamid.HBgMOTE3ODI4NjczNTM4FQIAERgSQUFGMkY2MzM0N0M5Mjg2NDU5AA==
015d5e99-4bea-4df0-90f9-6a0449847829	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	8109464940	\N	Hello NITIN,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 7 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 13 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-20 04:03:13.480995+00	2026-06-20 04:03:16.581229+00	WHATSAPP	wamid.HBgMOTE4MTA5NDY0OTQwFQIAERgSQzYzMDA0NjU3NDIzQUUxRkI3AA==
82d47703-ae9a-4089-835b-8ff7c8e49fd6	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	9631597047	\N	Hello PRASHANT,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 7 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 13 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-20 04:03:18.763769+00	2026-06-20 04:03:21.718545+00	WHATSAPP	wamid.HBgMOTE5NjMxNTk3MDQ3FQIAERgSMkE1Njk0MDBDNzM0NTgwQTM0AA==
19deff16-9e2a-4492-b7aa-b4317906a2a6	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	8269499713	\N	Hello PRATEEK,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 14 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 06 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-20 04:03:25.217933+00	2026-06-20 04:03:28.566162+00	WHATSAPP	wamid.HBgMOTE4MjY5NDk5NzEzFQIAERgSMzkzNkRDMUJDMDM4OUUwRjMyAA==
f1abfd12-75ea-43e1-921a-52d5f515cada	6ae0f3fa-0233-4160-ba88-11f4b8ae7e38	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	9425556727	\N	Hello JITENDRA,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 15 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 05 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-20 04:03:30.277064+00	2026-06-20 04:03:33.327875+00	WHATSAPP	wamid.HBgMOTE5NDI1NTU2NzI3FQIAERgSQ0M0OTA0QkYzNDM4MDJGRUMyAA==
fb8da7a3-7160-463f-abed-1f22a6f48166	57ee19de-9c3f-49bf-83d2-20a56100a64e	varun.deoghare@gmail.com	WHATSAPP	CHECKIN_REMINDER	7879057634	\N	Hello BHAGWATI,\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is 15 days overdue. Please fill the check-in form so we can keep your plan moving.\n\nDue date: 05 Jun 2026.\n\nCheck-in form: https://forms.gle/Mr1zs7tmoUguNMyG6\n\nPlease review the attached check-in summary and complete your update.	SENT	\N	2026-06-20 04:03:34.832386+00	2026-06-20 04:03:37.920692+00	WHATSAPP	wamid.HBgMOTE3ODc5MDU3NjM0FQIAERgSRTI2OEY4RkM0MzcwRjY4MERCAA==
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

\unrestrict 8a2LJGKehKDHbyuZlJBgL6Ah556rRgWyfvSLLpPspSrj1YgfC5cyENLCbuqECzi

--
-- Database "coach_workout" dump
--

--
-- PostgreSQL database dump
--

\restrict V5ifg2GglPdzOMAGJRoAcFoH2Be2kFi2DFaVIhRL12sEwNaabIbghPSHJjyRnaU

-- Dumped from database version 15.18 (Debian 15.18-1.pgdg13+1)
-- Dumped by pg_dump version 15.18 (Debian 15.18-1.pgdg13+1)

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

\unrestrict V5ifg2GglPdzOMAGJRoAcFoH2Be2kFi2DFaVIhRL12sEwNaabIbghPSHJjyRnaU
\connect coach_workout
\restrict V5ifg2GglPdzOMAGJRoAcFoH2Be2kFi2DFaVIhRL12sEwNaabIbghPSHJjyRnaU

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
    updated_at timestamp without time zone,
    target_steps_count integer
);


ALTER TABLE public.workout_plans OWNER TO postgres;

--
-- Data for Name: exercise_library; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercise_library (id, coach_email, exercise_name, video_url, created_at, updated_at, sr_no, muscle_group, muscles_trained) FROM stdin;
3b5dc4b0-a463-4578-89a5-c71203dcb65a	varun.deoghare@gmail.com	Standing Barbell Curl		2026-07-18 13:20:11.422858	\N	329	BICEPS	Biceps (Mid-Range), Brachialis, Brachioradialis
bd0c12fd-59ce-4c47-a60b-b000b0623b5d	varun.deoghare@gmail.com	Standing EZ-Bar Curl		2026-07-18 13:20:11.439671	\N	330	BICEPS	Biceps (Mid-Range), Brachialis, Brachioradialis
ef1c076f-f81d-4766-a9a1-0f9aab424331	varun.deoghare@gmail.com	Standing Dumbbell Curl		2026-07-18 13:20:11.4523	\N	331	BICEPS	Biceps (Mid-Range), Brachialis, Brachioradialis
e0db5172-db51-4621-9d2a-f78d1f6d8320	varun.deoghare@gmail.com	Alternating Dumbbell Curl		2026-07-18 13:20:11.463298	\N	332	BICEPS	Biceps (Mid-Range), Brachialis, Brachioradialis
5fafdf38-6d45-466e-99df-20b95ea1e646	varun.deoghare@gmail.com	Single-Arm Dumbbell Curl		2026-07-18 13:20:11.475006	\N	333	BICEPS	Biceps (Mid-Range), Brachialis, Brachioradialis
a0a28a32-f0d0-4909-9ea0-00e049af65bb	varun.deoghare@gmail.com	Seated Dumbbell Curl		2026-07-18 13:20:11.490282	\N	334	BICEPS	Biceps (Mid-Range), Brachialis, Brachioradialis
686dd7bf-37b6-4709-912d-f623749f5655	varun.deoghare@gmail.com	Strict Barbell Curl		2026-07-18 13:20:11.506056	\N	335	BICEPS	Biceps (Mid-Range), Brachialis, Brachioradialis
fa030b87-5dbb-4658-ad4c-18139c5e5ecb	varun.deoghare@gmail.com	Wall-Supported Dumbbell Curl		2026-07-18 13:20:11.519813	\N	336	BICEPS	Biceps (Mid-Range), Brachialis, Brachioradialis
aa73d115-5e15-41e7-a72b-7595ccb5eca6	varun.deoghare@gmail.com	Arm-Blaster Barbell Curl		2026-07-18 13:20:11.534392	\N	337	BICEPS	Biceps, Brachialis, Brachioradialis
779ced9a-9fb8-4cf9-8181-68d7420502f8	varun.deoghare@gmail.com	Standing Cable Curl		2026-07-18 13:20:11.546295	\N	338	BICEPS	Biceps (Mid-to-Shortened), Brachialis
42801313-67b3-45ab-aade-28ec099e61ce	varun.deoghare@gmail.com	Straight-Bar Cable Curl		2026-07-18 13:20:11.558621	\N	339	BICEPS	Biceps (Mid-to-Shortened), Brachialis
1186c1d0-bbf9-44ce-87b8-d6a1de47a407	varun.deoghare@gmail.com	EZ-Bar Cable Curl		2026-07-18 13:20:11.569893	\N	340	BICEPS	Biceps (Mid-to-Shortened), Brachialis
68af901c-cd3f-4797-aeae-190b4d808443	varun.deoghare@gmail.com	Rope Cable Curl		2026-07-18 13:20:11.580809	\N	341	BICEPS	Brachialis, Brachioradialis, Biceps
e6c1de85-b384-4390-9148-b9e85ee60de8	varun.deoghare@gmail.com	Single-Arm Cable Curl		2026-07-18 13:20:11.591947	\N	342	BICEPS	Biceps (Mid-to-Shortened), Brachialis
0b013e9e-4027-4292-92ff-506c3f7a1240	varun.deoghare@gmail.com	Seated Cable Curl		2026-07-18 13:20:11.603712	\N	343	BICEPS	Biceps, Brachialis
403a5c86-779a-4639-a068-6d4fb4bfcd17	varun.deoghare@gmail.com	Machine Biceps Curl		2026-07-18 13:20:11.614666	\N	344	BICEPS	Biceps, Brachialis
61d2ee19-4ec5-4c24-9bf5-e6824b99e971	varun.deoghare@gmail.com	Single-Arm Machine Biceps Curl		2026-07-18 13:20:11.623327	\N	345	BICEPS	Biceps, Brachialis
ffd60ff3-11ef-44f4-914b-07d7a1311be0	varun.deoghare@gmail.com	Resistance-Band Biceps Curl		2026-07-18 13:20:11.633322	\N	346	BICEPS	Biceps (Shortened Emphasis), Brachialis
4f249dca-06c3-43fd-a6b3-0de4c7ccf098	varun.deoghare@gmail.com	Single-Arm Resistance-Band Curl		2026-07-18 13:20:11.645239	\N	347	BICEPS	Biceps (Shortened Emphasis), Brachialis
d6786130-196d-4d95-a1a3-cc3a4c79ffb4	varun.deoghare@gmail.com	Incline Dumbbell Curl		2026-07-18 13:20:11.655503	\N	348	BICEPS	Biceps (Lengthened Emphasis), Brachialis
84e8acbf-1e1f-47d3-b649-530186b7da47	varun.deoghare@gmail.com	Alternating Incline Dumbbell Curl		2026-07-18 13:20:11.66667	\N	349	BICEPS	Biceps (Lengthened Emphasis), Brachialis
db13cb5d-2f70-408d-997e-2d276c8ff523	varun.deoghare@gmail.com	Single-Arm Incline Dumbbell Curl		2026-07-18 13:20:11.676557	\N	350	BICEPS	Biceps (Lengthened Emphasis), Brachialis
b5835de1-8c3c-48fc-8824-6087cc12b9ad	varun.deoghare@gmail.com	Incline Hammer Curl		2026-07-18 13:20:11.686177	\N	351	BICEPS	Brachialis, Brachioradialis, Biceps (Lengthened)
af6e0ba4-e788-4bdf-88f2-6429ae6fb90c	varun.deoghare@gmail.com	Bayesian Cable Curl		2026-07-18 13:20:11.696203	\N	352	BICEPS	Biceps (Lengthened Emphasis), Brachialis
2c990daf-000b-4927-86e4-2c86237379b9	varun.deoghare@gmail.com	Single-Arm Bayesian Cable Curl		2026-07-18 13:20:11.70579	\N	353	BICEPS	Biceps (Lengthened Emphasis), Brachialis
4fa85b1c-a213-4760-bcae-402b56734ff2	varun.deoghare@gmail.com	Behind-the-Body Cable Curl		2026-07-18 13:20:11.717007	\N	354	BICEPS	Biceps (Lengthened Emphasis), Brachialis
9d8de4fd-4095-47ee-9868-c5a924863ab6	varun.deoghare@gmail.com	Face-Away Cable Curl		2026-07-18 13:20:11.726145	\N	355	BICEPS	Biceps (Lengthened Emphasis), Brachialis
7e50c04e-7a01-4a37-80d5-e4e8652ce295	varun.deoghare@gmail.com	Incline Cable Curl		2026-07-18 13:20:11.736276	\N	356	BICEPS	Biceps (Lengthened Emphasis), Brachialis
98d0b27c-b916-4e1e-8e4d-0a5bbe77a8d9	varun.deoghare@gmail.com	Supine Cable Curl		2026-07-18 13:20:11.7461	\N	357	BICEPS	Biceps (Lengthened Emphasis), Brachialis
2da3c03e-64e2-4b18-8ef7-fcfdd4b5db1d	varun.deoghare@gmail.com	Drag Curl		2026-07-18 13:20:11.755071	\N	358	BICEPS	Biceps (Lengthened at Shoulder), Brachialis
b6af02d2-479c-4946-b475-920bad080f96	varun.deoghare@gmail.com	Barbell Preacher Curl		2026-07-18 13:20:11.765098	\N	359	BICEPS	Biceps (Shorter at Shoulder, Lengthened at Elbow), Brachialis
6f54a08c-6822-4647-8319-d4833d831c82	varun.deoghare@gmail.com	EZ-Bar Preacher Curl		2026-07-18 13:20:11.77381	\N	360	BICEPS	Biceps (Shorter at Shoulder, Lengthened at Elbow), Brachialis
a2732ee6-c45a-4d74-8ab8-e6bb0fdfbfe3	varun.deoghare@gmail.com	Dumbbell Preacher Curl		2026-07-18 13:20:11.783032	\N	361	BICEPS	Biceps (Shorter at Shoulder, Lengthened at Elbow), Brachialis
a2dfd3d4-1cc4-47e9-8910-755cf6c37503	varun.deoghare@gmail.com	Single-Arm Dumbbell Preacher Curl		2026-07-18 13:20:11.792409	\N	362	BICEPS	Biceps (Shorter at Shoulder, Lengthened at Elbow), Brachialis
f2a5678e-00a4-4d09-bd71-f849dc6b0de2	varun.deoghare@gmail.com	Machine Preacher Curl		2026-07-18 13:20:11.804921	\N	363	BICEPS	Biceps, Brachialis
7f08b87f-4e60-4001-80d4-9a754a213191	varun.deoghare@gmail.com	Single-Arm Machine Preacher Curl		2026-07-18 13:20:11.814616	\N	364	BICEPS	Biceps, Brachialis
453f8829-2898-4fb2-9ae3-001920d8e4bd	varun.deoghare@gmail.com	Cable Preacher Curl		2026-07-18 13:20:11.82385	\N	365	BICEPS	Biceps, Brachialis
dd1e9744-8c56-44b3-8235-e4db611d1881	varun.deoghare@gmail.com	Single-Arm Cable Preacher Curl		2026-07-18 13:20:11.835086	\N	366	BICEPS	Biceps, Brachialis
55297655-6ff7-4184-b8cf-aae04e6eb1a9	varun.deoghare@gmail.com	Reverse Preacher Curl		2026-07-18 13:20:11.846094	\N	367	BICEPS	Brachioradialis, Brachialis, Biceps
4db888f5-9921-41aa-ab83-9da7d4c67baa	varun.deoghare@gmail.com	Preacher Hammer Curl		2026-07-18 13:20:11.856828	\N	368	BICEPS	Brachialis, Brachioradialis, Biceps
55b1c8cd-c970-4f12-9785-e6f0e6095514	varun.deoghare@gmail.com	Spider Dumbbell Curl		2026-07-18 13:20:11.86631	\N	369	BICEPS	Biceps (Shortened Emphasis), Brachialis
aae92fea-a167-4fc9-9ca0-f485438f49d5	varun.deoghare@gmail.com	Spider Barbell Curl		2026-07-18 13:20:11.876174	\N	370	BICEPS	Biceps (Shortened Emphasis), Brachialis
c87f0716-a92a-4bda-996c-337118a05bcb	varun.deoghare@gmail.com	Spider EZ-Bar Curl		2026-07-18 13:20:11.885888	\N	371	BICEPS	Biceps (Shortened Emphasis), Brachialis
7fcb44b6-7994-4cca-ba14-cad4e484f489	varun.deoghare@gmail.com	Cable Spider Curl		2026-07-18 13:20:11.897763	\N	372	BICEPS	Biceps (Shortened Emphasis), Brachialis
835fb218-72fb-4ebe-9e90-c24e340ae146	varun.deoghare@gmail.com	High Cable Curl		2026-07-18 13:20:11.90771	\N	373	BICEPS	Biceps (Shortened Emphasis), Brachialis
cfa6ce76-ef66-40d3-97c4-ed6c27ebc4a4	varun.deoghare@gmail.com	Single-Arm High Cable Curl		2026-07-18 13:20:11.91885	\N	374	BICEPS	Biceps (Shortened Emphasis), Brachialis
cfbd8646-316d-49dd-9542-293f85d7815b	varun.deoghare@gmail.com	Double-Biceps Cable Curl		2026-07-18 13:20:11.929556	\N	375	BICEPS	Biceps (Shortened Emphasis), Brachialis
1fd39248-401b-4c2a-9e1a-47813ec1a96c	varun.deoghare@gmail.com	Overhead Cable Curl		2026-07-18 13:20:11.939479	\N	376	BICEPS	Biceps (Shortened at Shoulder), Brachialis
5b19279a-c177-4282-927e-3fd837f2e284	varun.deoghare@gmail.com	Concentration Curl		2026-07-18 13:20:11.949479	\N	377	BICEPS	Biceps (Mid-to-Shortened), Brachialis
eafd5b78-f054-4e5e-8463-f9d02a93841a	varun.deoghare@gmail.com	Cable Concentration Curl		2026-07-18 13:20:11.960471	\N	378	BICEPS	Biceps (Shortened Emphasis), Brachialis
e789fb00-5706-45c0-a226-26a6f24c6476	varun.deoghare@gmail.com	Dumbbell Hammer Curl		2026-07-18 13:20:11.970823	\N	379	BICEPS	Brachialis, Brachioradialis, Biceps
97214d62-2e0b-4d51-8a9f-b1dab6de69f0	varun.deoghare@gmail.com	Alternating Hammer Curl		2026-07-18 13:20:11.98137	\N	380	BICEPS	Brachialis, Brachioradialis, Biceps
8373bcd5-0497-4d9d-b9e4-eccb793cdda1	varun.deoghare@gmail.com	Seated Hammer Curl		2026-07-18 13:20:11.990318	\N	381	BICEPS	Brachialis, Brachioradialis, Biceps
f38eba82-0e0f-4d85-8594-b2b9581c0705	varun.deoghare@gmail.com	Rope Hammer Curl		2026-07-18 13:20:12.000566	\N	382	BICEPS	Brachialis, Brachioradialis, Biceps
6792cbc2-164f-49a7-b7a0-0248311f8f60	varun.deoghare@gmail.com	Single-Arm Cable Hammer Curl		2026-07-18 13:20:12.01108	\N	383	BICEPS	Brachialis, Brachioradialis, Biceps
22b3c5e0-9fe2-439b-b631-2b0d3df29927	varun.deoghare@gmail.com	Cross-Body Hammer Curl		2026-07-18 13:20:12.020881	\N	384	BICEPS	Brachialis, Brachioradialis, Biceps
b1fdfa8c-451c-4c9e-99cd-b55ec07c3bd9	varun.deoghare@gmail.com	Machine Neutral-Grip Curl		2026-07-18 13:20:12.031941	\N	385	BICEPS	Brachialis, Brachioradialis, Biceps
4d8ebff7-ccf1-4bb7-a42d-89672af56619	varun.deoghare@gmail.com	Barbell Reverse Curl		2026-07-18 13:20:12.041052	\N	386	BICEPS	Brachioradialis, Brachialis, Biceps
00b53bfb-c325-4427-a13d-2feea137552f	varun.deoghare@gmail.com	EZ-Bar Reverse Curl		2026-07-18 13:20:12.052912	\N	387	BICEPS	Brachioradialis, Brachialis, Biceps
c90a8ade-c0da-4192-b191-2a1162b98bed	varun.deoghare@gmail.com	Cable Reverse Curl		2026-07-18 13:20:12.062224	\N	388	BICEPS	Brachioradialis, Brachialis, Biceps
32a457a3-0d0a-4599-ad1c-87c91a1bb60b	varun.deoghare@gmail.com	Dumbbell Reverse Curl		2026-07-18 13:20:12.070886	\N	389	BICEPS	Brachioradialis, Brachialis, Biceps
12d1e77b-8e6b-40b5-9970-2b966bb51fe6	varun.deoghare@gmail.com	Zottman Curl		2026-07-18 13:20:12.082428	\N	390	BICEPS	Biceps, Brachialis, Brachioradialis, Forearm Extensors
48348655-3cd2-469e-bf9f-78ef11b8ce03	varun.deoghare@gmail.com	Cheat Barbell Curl		2026-07-18 13:20:12.091183	\N	391	BICEPS	Biceps, Brachialis, Brachioradialis
199d049b-c03c-407c-8c0c-571926b556d2	varun.deoghare@gmail.com	21s Barbell Curl		2026-07-18 13:20:12.101042	\N	392	BICEPS	Biceps, Brachialis, Brachioradialis
f7d432bc-8b92-437c-9429-06223a7b8e43	varun.deoghare@gmail.com	Isometric Biceps Curl Hold		2026-07-18 13:20:12.110869	\N	393	BICEPS	Biceps (Isometric), Brachialis, Brachioradialis
715f9a57-accd-449f-a839-ca9f702caee9	varun.deoghare@gmail.com	Towel Curl		2026-07-18 13:20:12.120062	\N	394	BICEPS	Biceps, Brachialis, Brachioradialis, Grip Muscles
74a05d13-b1a1-4732-858a-d3b99fd61173	varun.deoghare@gmail.com	Neutral-Grip Chin-Up		2026-07-18 13:20:12.13009	\N	395	BICEPS	Lats, Brachialis, Brachioradialis, Biceps
ee3d7c42-166a-4d0c-addc-e426cdf7a70b	varun.deoghare@gmail.com	Underhand Chin-Up		2026-07-18 13:20:12.138719	\N	396	BICEPS	Lats, Biceps, Brachialis, Teres Major
b37bf6a8-6ce8-43e6-91d9-30a8e48fad19	varun.deoghare@gmail.com	Underhand Lat Pulldown		2026-07-18 13:20:12.148627	\N	397	BICEPS	Lats, Biceps, Brachialis, Teres Major
b0daad59-c07f-49b2-9e59-88328abbeb17	varun.deoghare@gmail.com	Straight-Bar Cable Pushdown		2026-07-18 13:20:15.611912	\N	398	TRICEPS	Triceps (Mid-to-Shortened), especially Lateral and Medial Heads
497aadf3-136f-4acd-b3e9-146858dec73c	varun.deoghare@gmail.com	Rope Triceps Pushdown		2026-07-18 13:20:15.623922	\N	399	TRICEPS	Triceps (Mid-to-Shortened), especially Lateral and Medial Heads
6223e698-08c3-49a0-8b30-f018317215bf	varun.deoghare@gmail.com	V-Bar Triceps Pushdown		2026-07-18 13:20:15.635513	\N	400	TRICEPS	Triceps (Mid-to-Shortened), especially Lateral and Medial Heads
a53867d1-79be-4a75-8205-fc726d7f1e09	varun.deoghare@gmail.com	EZ-Bar Cable Pushdown		2026-07-18 13:20:15.645191	\N	401	TRICEPS	Triceps (Mid-to-Shortened), especially Lateral and Medial Heads
2c04bf72-9789-4873-8e8f-691da7d7415d	varun.deoghare@gmail.com	Reverse-Grip Cable Pushdown		2026-07-18 13:20:15.654686	\N	402	TRICEPS	Triceps (Mid-to-Shortened), especially Medial Head
b9a6548b-aa56-4a9e-a1e9-c451bfcaf3dc	varun.deoghare@gmail.com	Single-Arm Cable Pushdown		2026-07-18 13:20:15.665719	\N	403	TRICEPS	Triceps (Mid-to-Shortened), especially Lateral and Medial Heads
35b3bb3e-3d60-45b4-90a8-bd406c08c16b	varun.deoghare@gmail.com	Single-Arm Reverse-Grip Pushdown		2026-07-18 13:20:15.674862	\N	404	TRICEPS	Triceps (Mid-to-Shortened), especially Medial Head
8c12c4b3-4915-4c97-9be1-104d3319dcb4	varun.deoghare@gmail.com	Single-Arm Cross-Body Cable Extension		2026-07-18 13:20:15.688578	\N	405	TRICEPS	Triceps (Shortened Emphasis), especially Lateral and Medial Heads
00d2686b-4952-421b-be95-44379c06f0d1	varun.deoghare@gmail.com	Dual-Cable Cross-Body Extension		2026-07-18 13:20:15.699958	\N	406	TRICEPS	Triceps (Shortened Emphasis), especially Lateral and Medial Heads
7ef397ad-5f9f-4ada-97c3-87e7855a92f3	varun.deoghare@gmail.com	Resistance-Band Pushdown		2026-07-18 13:20:15.710141	\N	407	TRICEPS	Triceps (Shortened Emphasis)
516ad848-0a62-4eda-a46a-6d19dcf29053	varun.deoghare@gmail.com	Single-Arm Resistance-Band Pushdown		2026-07-18 13:20:15.720497	\N	408	TRICEPS	Triceps (Shortened Emphasis)
c2267dfb-3f04-4ffb-a480-d8c7b5ebd9fc	varun.deoghare@gmail.com	Triceps Pushdown Machine		2026-07-18 13:20:15.730507	\N	409	TRICEPS	Triceps (Mid-to-Shortened)
2b8b74a2-7148-444c-a2bd-e7d898ef4d7f	varun.deoghare@gmail.com	Dip Machine Triceps Press		2026-07-18 13:20:15.740323	\N	410	TRICEPS	Triceps, Pecs, Anterior Delts
c314cf30-bbee-4bf2-8426-e86a90704196	varun.deoghare@gmail.com	Standing Dumbbell Overhead Triceps Extension		2026-07-18 13:20:15.751496	\N	411	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
785f6741-2528-413a-824f-92595d087488	varun.deoghare@gmail.com	Seated Dumbbell Overhead Triceps Extension		2026-07-18 13:20:15.760673	\N	412	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
47913a83-a449-4c75-b235-6c6dceb1c523	varun.deoghare@gmail.com	Single-Arm Dumbbell Overhead Triceps Extension		2026-07-18 13:20:15.772624	\N	413	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
679a24d8-8800-48b8-b356-159b181a8181	varun.deoghare@gmail.com	Standing Cable Overhead Triceps Extension		2026-07-18 13:20:15.783813	\N	414	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
2e48e56c-fb05-435c-8b18-e57f050ace85	varun.deoghare@gmail.com	Seated Cable Overhead Triceps Extension		2026-07-18 13:20:15.794886	\N	415	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
3456f817-c2f0-4c82-a76c-e9eb353ffb6b	varun.deoghare@gmail.com	Kneeling Cable Overhead Triceps Extension		2026-07-18 13:20:15.806213	\N	416	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
54188bc7-9202-4993-8282-4e02971914f3	varun.deoghare@gmail.com	Rope Overhead Triceps Extension		2026-07-18 13:20:15.817659	\N	417	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
073805fa-6f22-404f-bfc7-82a9d800219b	varun.deoghare@gmail.com	Straight-Bar Overhead Cable Extension		2026-07-18 13:20:15.828959	\N	418	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
541c9d98-a816-4a6c-bbad-f59b5135871f	varun.deoghare@gmail.com	Single-Arm Cable Overhead Triceps Extension		2026-07-18 13:20:15.837408	\N	419	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
36fb5f30-9047-4a4e-bf1e-ad176c05597d	varun.deoghare@gmail.com	Cross-Body Overhead Cable Extension		2026-07-18 13:20:15.865615	\N	420	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
702c5e66-af35-4d41-a7ea-6575a70f8584	varun.deoghare@gmail.com	Incline-Bench Cable Overhead Extension		2026-07-18 13:20:15.875376	\N	421	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
4dc3462f-27c4-41d8-bfeb-f1443cf96048	varun.deoghare@gmail.com	Resistance-Band Overhead Triceps Extension		2026-07-18 13:20:15.887967	\N	422	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
764552ea-6047-4f01-9435-2fe5f3c132af	varun.deoghare@gmail.com	Standing EZ-Bar Overhead Triceps Extension		2026-07-18 13:20:15.903144	\N	423	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
e0864b32-9676-4c7a-9d23-821ff4d567c4	varun.deoghare@gmail.com	Seated EZ-Bar Overhead Triceps Extension		2026-07-18 13:20:15.91714	\N	424	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
5d65cb64-c14f-4e94-8534-5be88c4c92f2	varun.deoghare@gmail.com	Standing Barbell Overhead Triceps Extension		2026-07-18 13:20:15.927533	\N	425	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
0b1b82f9-5080-414d-b451-0114f7f54a1a	varun.deoghare@gmail.com	Seated Barbell Overhead Triceps Extension		2026-07-18 13:20:15.937607	\N	426	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
5aee9cd5-0731-45d3-be8e-5f985b4afde7	varun.deoghare@gmail.com	Flat-Bench EZ-Bar Skull Crusher		2026-07-18 13:20:15.947672	\N	427	TRICEPS	Triceps, especially Long Head
eaf9d76a-eeca-4e4b-8491-96ddee6f3f72	varun.deoghare@gmail.com	Flat-Bench Barbell Skull Crusher		2026-07-18 13:20:15.958379	\N	428	TRICEPS	Triceps, especially Long Head
f550af00-869c-4b03-a02d-184f62104a42	varun.deoghare@gmail.com	Flat-Bench Dumbbell Skull Crusher		2026-07-18 13:20:15.967903	\N	429	TRICEPS	Triceps, especially Long Head
a5a92d5b-62be-43ed-a266-237de320109d	varun.deoghare@gmail.com	Incline-Bench EZ-Bar Skull Crusher		2026-07-18 13:20:15.978784	\N	430	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
6c8f741c-cb2a-49da-b8d4-3f884622de6a	varun.deoghare@gmail.com	Incline-Bench Dumbbell Skull Crusher		2026-07-18 13:20:15.989092	\N	431	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
eff4f5c2-9104-4498-986e-dfe42615eb8e	varun.deoghare@gmail.com	Decline EZ-Bar Skull Crusher		2026-07-18 13:20:16.000035	\N	432	TRICEPS	Triceps, especially Lateral and Medial Heads
be0fa13c-2925-4929-bf09-9d49862a2527	varun.deoghare@gmail.com	Rolling Dumbbell Triceps Extension		2026-07-18 13:20:16.010975	\N	433	TRICEPS	Triceps Long Head, Lateral and Medial Heads
0f4cf1c7-b748-4039-9b88-ea4ea5ea8600	varun.deoghare@gmail.com	Dumbbell Tate Press		2026-07-18 13:20:16.019571	\N	434	TRICEPS	Triceps, especially Lateral and Medial Heads
80ee4947-9daa-43c3-b24a-67d3814e3592	varun.deoghare@gmail.com	Cable Skull Crusher		2026-07-18 13:20:16.028548	\N	435	TRICEPS	Triceps, especially Long Head
615412a8-5f2a-4072-8189-cc384324a14c	varun.deoghare@gmail.com	Rope Cable Skull Crusher		2026-07-18 13:20:16.038192	\N	436	TRICEPS	Triceps, especially Long Head
9b828e6e-ba0e-4846-8ce8-741b0f701c14	varun.deoghare@gmail.com	Smith Machine Skull Crusher		2026-07-18 13:20:16.047516	\N	437	TRICEPS	Triceps, especially Long Head
36296eef-42a5-4c13-a49f-c486d23e7c8b	varun.deoghare@gmail.com	Bodyweight Skull Crusher		2026-07-18 13:20:16.057205	\N	438	TRICEPS	Triceps, especially Long Head
72d43874-ddbb-4470-9cbc-ff9d34357606	varun.deoghare@gmail.com	Suspension-Trainer Triceps Extension		2026-07-18 13:20:16.066883	\N	439	TRICEPS	Triceps Long Head (Lengthened), Lateral and Medial Heads
32cc2c8a-b060-4e5b-8353-649d7687cb6c	varun.deoghare@gmail.com	Close-Grip Barbell Bench Press		2026-07-18 13:20:16.076247	\N	440	TRICEPS	Triceps, Pecs, Anterior Delts
ec442c09-2505-4dc8-b67c-2169e80e6394	varun.deoghare@gmail.com	Close-Grip Smith Machine Bench Press		2026-07-18 13:20:16.086868	\N	441	TRICEPS	Triceps, Pecs, Anterior Delts
42a720d7-5402-4360-81cc-845bbefc13a3	varun.deoghare@gmail.com	Close-Grip Dumbbell Press		2026-07-18 13:20:16.0963	\N	442	TRICEPS	Triceps, Pecs, Anterior Delts
2d93a14f-9eb6-4d74-9489-95baf1c5a871	varun.deoghare@gmail.com	Neutral-Grip Dumbbell Press		2026-07-18 13:20:16.105406	\N	443	TRICEPS	Triceps, Pecs, Anterior Delts
f56a6112-c5c7-4b43-88c6-b2b4981441f6	varun.deoghare@gmail.com	JM Press		2026-07-18 13:20:16.11436	\N	444	TRICEPS	Triceps, especially Lateral and Medial Heads; Pecs, Anterior Delts
f6bc5165-90c7-488b-b008-98aab7102751	varun.deoghare@gmail.com	Smith Machine JM Press		2026-07-18 13:20:16.122282	\N	445	TRICEPS	Triceps, especially Lateral and Medial Heads; Pecs, Anterior Delts
a90b1727-5072-461d-9a2f-e00cd912b648	varun.deoghare@gmail.com	Reverse-Grip Bench Press		2026-07-18 13:20:16.131439	\N	446	TRICEPS	Triceps, Upper Pecs, Anterior Delts
7d263153-54c3-4ed4-a721-2f51351132c8	varun.deoghare@gmail.com	Board Press		2026-07-18 13:20:16.140802	\N	447	TRICEPS	Triceps, Pecs, Anterior Delts
19316366-8a1c-4d4e-b876-910c44fa2bac	varun.deoghare@gmail.com	Floor Barbell Press		2026-07-18 13:20:16.1497	\N	448	TRICEPS	Triceps, Pecs, Anterior Delts
832e9fd3-6b1d-4667-b541-0dd85462ab46	varun.deoghare@gmail.com	Floor Dumbbell Press		2026-07-18 13:20:16.157899	\N	449	TRICEPS	Triceps, Pecs, Anterior Delts
ced4b718-fca2-4f94-8c12-4f704e010492	varun.deoghare@gmail.com	Diamond Push-Up		2026-07-18 13:20:16.166564	\N	450	TRICEPS	Triceps, Pecs, Anterior Delts
1d3145e3-62c6-4390-888d-38d4b0bd552e	varun.deoghare@gmail.com	Close-Grip Push-Up		2026-07-18 13:20:16.176347	\N	451	TRICEPS	Triceps, Pecs, Anterior Delts
7527ea87-3ae8-43f2-ba88-21eedcf1232d	varun.deoghare@gmail.com	Bench Triceps Dip		2026-07-18 13:20:16.184634	\N	452	TRICEPS	Triceps, Anterior Delts, Pecs
8afc9cc3-11c8-43c8-aa1b-ba2a9991f2bb	varun.deoghare@gmail.com	Parallel-Bar Triceps Dip		2026-07-18 13:20:16.193966	\N	453	TRICEPS	Triceps, Pecs, Anterior Delts
2fefac3a-2be9-406d-8e8f-c6daa10f8130	varun.deoghare@gmail.com	Assisted Triceps Dip		2026-07-18 13:20:16.202454	\N	454	TRICEPS	Triceps, Pecs, Anterior Delts
7edfdd77-16e2-48f3-b716-bbfe7ab582e3	varun.deoghare@gmail.com	Weighted Triceps Dip		2026-07-18 13:20:16.21071	\N	455	TRICEPS	Triceps, Pecs, Anterior Delts
05e19cdc-893d-431c-9eeb-60f21b8fb597	varun.deoghare@gmail.com	Machine Triceps Dip		2026-07-18 13:20:16.218745	\N	456	TRICEPS	Triceps, Pecs, Anterior Delts
693ea2e5-36bd-41e9-bc4b-e586fdf668d5	varun.deoghare@gmail.com	Dumbbell Triceps Kickback		2026-07-18 13:20:16.226895	\N	457	TRICEPS	Triceps (Shortened Emphasis), especially Long and Lateral Heads
bb549d83-a9f9-4b97-8a4d-32b87985ef8d	varun.deoghare@gmail.com	Single-Arm Cable Triceps Kickback		2026-07-18 13:20:16.235371	\N	458	TRICEPS	Triceps (Shortened Emphasis), especially Long and Lateral Heads
76994b9b-6f9f-4dc2-907a-c4f80d677c14	varun.deoghare@gmail.com	Dual-Cable Triceps Kickback		2026-07-18 13:20:16.245984	\N	459	TRICEPS	Triceps (Shortened Emphasis), especially Long and Lateral Heads
a75555b2-4cc7-40d3-9bc6-e6753ae1d764	varun.deoghare@gmail.com	Resistance-Band Triceps Kickback		2026-07-18 13:20:16.253927	\N	460	TRICEPS	Triceps (Shortened Emphasis)
dd8773eb-7b8c-48a8-b79c-fd2b75ce9f19	varun.deoghare@gmail.com	Bent-Over Rope Triceps Extension		2026-07-18 13:20:16.26214	\N	461	TRICEPS	Triceps (Shortened Emphasis), especially Long Head
9488fe8b-30f9-47f0-b5c4-daa09232653b	varun.deoghare@gmail.com	Machine Triceps Extension		2026-07-18 13:20:16.27001	\N	462	TRICEPS	Triceps
703e5952-21f5-4fbc-ac23-b70768257d1a	varun.deoghare@gmail.com	Single-Arm Machine Triceps Extension		2026-07-18 13:20:16.279757	\N	463	TRICEPS	Triceps
ae1017ae-84cc-4623-a45d-0d76fb9e3ea4	varun.deoghare@gmail.com	Isometric Triceps Extension Hold		2026-07-18 13:20:16.288518	\N	464	TRICEPS	Triceps (Isometric)
4afcbfb3-554b-4fad-80d5-74f4057bb8ef	varun.deoghare@gmail.com	Plyometric Close-Grip Push-Up		2026-07-18 13:20:16.297453	\N	465	TRICEPS	Triceps, Pecs, Anterior Delts
2e79b4e9-17f8-4beb-b25e-085f225334cf	varun.deoghare@gmail.com	Wide-Grip Lat Pulldown		2026-07-18 13:23:26.290124	\N	466	BACK	Lats (Lengthened to Mid-Range), Teres Major, Upper Back, Biceps
7a5e6a80-ac68-4d80-a067-748268f786da	varun.deoghare@gmail.com	Medium-Grip Lat Pulldown		2026-07-18 13:23:26.301022	\N	467	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps, Upper Back
26c42d24-b765-45fd-924e-0db20ca87727	varun.deoghare@gmail.com	Close-Grip Lat Pulldown		2026-07-18 13:23:26.310184	\N	468	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps
bf7e885c-c21d-4ed0-bdaf-5d9893f6e0b6	varun.deoghare@gmail.com	Neutral-Grip Lat Pulldown		2026-07-18 13:23:26.320031	\N	469	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps, Brachialis
a205585e-0e4d-4a42-ba62-4acc1d2a1a4a	varun.deoghare@gmail.com	Underhand Lat Pulldown		2026-07-18 13:23:26.329449	\N	470	BACK	Lats (Lengthened to Mid-Range), Biceps, Teres Major
e5db1dbd-b909-42d6-8f8d-3a579cbaac3f	varun.deoghare@gmail.com	Single-Arm Lat Pulldown		2026-07-18 13:23:26.339371	\N	471	BACK	Lats (Lengthened to Shortened), Teres Major, Biceps
3cffcf2d-3bbf-4463-8cf4-23e5fc91d7ac	varun.deoghare@gmail.com	Kneeling Single-Arm Lat Pulldown		2026-07-18 13:23:26.348413	\N	472	BACK	Lats (Lengthened to Shortened), Teres Major, Biceps
0de68305-b167-4bfe-ba0d-343c0e6ea171	varun.deoghare@gmail.com	Half-Kneeling Single-Arm Lat Pulldown		2026-07-18 13:23:26.35734	\N	473	BACK	Lats (Lengthened to Shortened), Teres Major, Biceps
0c447293-e208-4d1c-afd6-292ed289b6fb	varun.deoghare@gmail.com	Cross-Body Lat Pulldown		2026-07-18 13:23:26.366324	\N	474	BACK	Lats (Lengthened to Shortened), Teres Major, Biceps
92aa3d59-12f9-43cb-98b3-f7f35c9dd346	varun.deoghare@gmail.com	Single-Arm Supinated Lat Pulldown		2026-07-18 13:23:26.375385	\N	475	BACK	Lats (Lengthened to Shortened), Biceps, Teres Major
a318e540-87d9-47a9-8e36-675f9b5ccfb3	varun.deoghare@gmail.com	Single-Arm Neutral-Grip Lat Pulldown		2026-07-18 13:23:26.38458	\N	476	BACK	Lats (Lengthened to Shortened), Teres Major, Biceps, Brachialis
da2a8171-7835-44f8-94be-be47b2268c91	varun.deoghare@gmail.com	Machine Lat Pulldown		2026-07-18 13:23:26.393118	\N	477	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps
97fecb52-44fc-477c-b3f0-3740a878385f	varun.deoghare@gmail.com	Plate-Loaded Lat Pulldown		2026-07-18 13:23:26.404144	\N	478	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps
217d7d28-396d-4aed-939c-8a1942e90474	varun.deoghare@gmail.com	Iso-Lateral Lat Pulldown		2026-07-18 13:23:26.412107	\N	479	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps
7554a9d3-9df0-49a6-95df-47ab082fdcee	varun.deoghare@gmail.com	Behind-the-Neck Lat Pulldown		2026-07-18 13:23:26.421709	\N	480	BACK	Lats, Teres Major, Upper Back, Biceps
3b79d45a-789c-4226-84c4-708dbe5d928f	varun.deoghare@gmail.com	Resistance-Band Lat Pulldown		2026-07-18 13:23:26.430982	\N	481	BACK	Lats (Mid-to-Shortened), Teres Major, Biceps
6482e21d-3ce5-486a-bf66-34802f4305e1	varun.deoghare@gmail.com	Assisted Pull-Up		2026-07-18 13:23:26.441121	\N	482	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps, Upper Back
9f139a7a-88dd-4291-b57e-cf20f0902311	varun.deoghare@gmail.com	Pull-Up		2026-07-18 13:23:26.449628	\N	483	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps, Upper Back
ae0c2c61-e2bd-4c6b-9c51-49c6c28c17b4	varun.deoghare@gmail.com	Neutral-Grip Pull-Up		2026-07-18 13:23:26.458429	\N	484	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps, Brachialis
77e47165-e973-4245-aef9-f1bae58d6221	varun.deoghare@gmail.com	Chin-Up		2026-07-18 13:23:26.471148	\N	485	BACK	Lats (Lengthened to Mid-Range), Biceps, Teres Major
960f32b8-cb2c-4fac-a410-0cfa3b6e7320	varun.deoghare@gmail.com	Wide-Grip Pull-Up		2026-07-18 13:23:26.479133	\N	486	BACK	Lats, Teres Major, Upper Back, Biceps
006fd9f9-075c-4222-addf-316b75d75c47	varun.deoghare@gmail.com	Commando Pull-Up		2026-07-18 13:23:26.487692	\N	487	BACK	Lats, Teres Major, Biceps, Brachialis
2c2e48f5-4bef-41d7-b724-e9752477670a	varun.deoghare@gmail.com	Sternum Pull-Up		2026-07-18 13:23:26.496614	\N	488	BACK	Lats, Rhomboids, Middle Traps, Biceps
bedbfb63-a18a-4816-ba2c-6378cdb71ece	varun.deoghare@gmail.com	Rack Chin-Up		2026-07-18 13:23:26.506805	\N	489	BACK	Lats, Teres Major, Biceps
be92b3ee-e120-4828-a48e-cd9fa08416fb	varun.deoghare@gmail.com	Eccentric Pull-Up		2026-07-18 13:23:26.515845	\N	490	BACK	Lats, Teres Major, Biceps, Upper Back
08b6ee92-9e73-4815-aace-3d15a7010b76	varun.deoghare@gmail.com	Weighted Pull-Up		2026-07-18 13:23:26.524036	\N	491	BACK	Lats, Teres Major, Biceps, Upper Back
bac87e04-be74-4c34-8123-637766fe78b0	varun.deoghare@gmail.com	Weighted Chin-Up		2026-07-18 13:23:26.533601	\N	492	BACK	Lats, Biceps, Teres Major
c35e08dd-ffa9-4ff7-a007-616f9988b343	varun.deoghare@gmail.com	Scapular Pull-Up		2026-07-18 13:23:26.541768	\N	493	BACK	Lower Traps, Rhomboids, Serratus Anterior, Lats
ede1a889-b701-4603-bfc5-a55161b8572b	varun.deoghare@gmail.com	Cable Straight-Arm Pulldown		2026-07-18 13:23:26.550819	\N	494	BACK	Lats (Lengthened to Shortened), Teres Major
0f762b2f-1af8-4443-846a-9b47b768fd13	varun.deoghare@gmail.com	Rope Straight-Arm Pulldown		2026-07-18 13:23:26.559455	\N	495	BACK	Lats (Lengthened to Shortened), Teres Major
f84fe0d0-8d5f-4dcb-a4ef-8a7ba1034b9f	varun.deoghare@gmail.com	Bar Straight-Arm Pulldown		2026-07-18 13:23:26.569654	\N	496	BACK	Lats (Lengthened to Shortened), Teres Major
d41fdbf6-8126-40c3-b146-2dcbd292e6df	varun.deoghare@gmail.com	Single-Arm Straight-Arm Pulldown		2026-07-18 13:23:26.577805	\N	497	BACK	Lats (Lengthened to Shortened), Teres Major
ecb302b9-98d4-43fa-9f9e-afa47b6b236f	varun.deoghare@gmail.com	Kneeling Cable Pullover		2026-07-18 13:23:26.587601	\N	498	BACK	Lats (Lengthened to Shortened), Teres Major
f4f0374c-ced3-4a08-850f-93f944492b5d	varun.deoghare@gmail.com	Standing Cable Pullover		2026-07-18 13:23:26.60181	\N	499	BACK	Lats (Lengthened to Shortened), Teres Major
1439470b-f9f6-46f8-af8b-b8024ea23431	varun.deoghare@gmail.com	Seated Cable Pullover		2026-07-18 13:23:26.611366	\N	500	BACK	Lats (Lengthened to Shortened), Teres Major
cb749bfb-e249-4cd9-bb03-e52d845f2126	varun.deoghare@gmail.com	Machine Pullover		2026-07-18 13:23:26.622395	\N	501	BACK	Lats (Lengthened to Shortened), Teres Major, Pecs
7eb442c6-917a-412a-b41c-680cb2be0381	varun.deoghare@gmail.com	Dumbbell Pullover		2026-07-18 13:23:26.633219	\N	502	BACK	Lats (Lengthened Emphasis), Teres Major, Pecs
6cfae0c0-7829-4ae9-b9f8-e33a5be4f551	varun.deoghare@gmail.com	Decline Dumbbell Pullover		2026-07-18 13:23:26.642665	\N	503	BACK	Lats (Lengthened Emphasis), Teres Major, Pecs
4ddeb8c2-bf54-43a0-b777-1de7796b4dd5	varun.deoghare@gmail.com	Resistance-Band Pullover		2026-07-18 13:23:26.653668	\N	504	BACK	Lats (Shortened Emphasis), Teres Major
8d2fe678-b534-4278-8d37-c120b0b5c788	varun.deoghare@gmail.com	Bench-Supported Cable Pullover		2026-07-18 13:23:26.663586	\N	505	BACK	Lats (Lengthened to Shortened), Teres Major
ebdfce30-afdf-4ea6-9ff4-74861d43529a	varun.deoghare@gmail.com	Neutral-Grip Seated Cable Row		2026-07-18 13:23:26.674028	\N	506	BACK	Lats (Lengthened to Mid-Range), Teres Major, Rhomboids, Biceps
37123bca-9507-4e01-94f8-e513554d56f2	varun.deoghare@gmail.com	Close-Grip Seated Cable Row		2026-07-18 13:23:26.682556	\N	507	BACK	Lats (Lengthened to Mid-Range), Teres Major, Rhomboids, Biceps
b7cf762c-daa0-4a11-b958-1670b6c95cde	varun.deoghare@gmail.com	Underhand Seated Cable Row		2026-07-18 13:23:26.718458	\N	508	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps, Rhomboids
678779bb-1fa8-4086-96f5-f6fc7e10fa38	varun.deoghare@gmail.com	Wide-Grip Seated Cable Row		2026-07-18 13:23:26.729684	\N	509	BACK	Rhomboids, Middle Traps, Rear Delts, Lats, Biceps
083a7d2c-aeed-48c4-86d1-f6d89455b9bc	varun.deoghare@gmail.com	Rope Seated Cable Row		2026-07-18 13:23:26.742673	\N	510	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps
73e072cb-f07c-40d9-8967-d6ba59c716f3	varun.deoghare@gmail.com	Single-Arm Seated Cable Row		2026-07-18 13:23:26.774214	\N	511	BACK	Lats, Rhomboids, Middle Traps, Biceps
46abf249-4e32-4f24-92a3-b8b72f9a4621	varun.deoghare@gmail.com	Single-Arm Cable Lat Row		2026-07-18 13:23:26.786447	\N	512	BACK	Lats (Lengthened to Shortened), Teres Major, Biceps
f7a6b125-db82-47cd-a4e4-582a1ce01d82	varun.deoghare@gmail.com	Cross-Body Cable Lat Row		2026-07-18 13:23:26.795454	\N	513	BACK	Lats (Lengthened to Shortened), Teres Major, Biceps
e873d1c7-46e5-49e2-b2bc-4d2ad8c9436f	varun.deoghare@gmail.com	Standing Cable Row		2026-07-18 13:23:26.805055	\N	514	BACK	Lats, Rhomboids, Middle Traps, Biceps
0f36dacb-4f90-4714-b771-27407f4335b5	varun.deoghare@gmail.com	Half-Kneeling Cable Row		2026-07-18 13:23:26.815314	\N	515	BACK	Lats, Rhomboids, Middle Traps, Biceps
c3ba6407-e204-4f4e-b087-db3a69a5ba86	varun.deoghare@gmail.com	High Cable Row		2026-07-18 13:23:26.824115	\N	516	BACK	Rhomboids, Middle Traps, Rear Delts, Lower Traps, Biceps
340af9bc-8c93-4fae-95c8-392518483d03	varun.deoghare@gmail.com	Rope High Row		2026-07-18 13:23:26.832903	\N	517	BACK	Rear Delts, Rhomboids, Middle Traps, External Rotators, Biceps
5f543048-d545-4a38-8847-62bc7758e178	varun.deoghare@gmail.com	Dumbbell Row		2026-07-18 13:23:26.843456	\N	518	BACK	Lats, Rhomboids, Middle Traps, Rear Delts, Biceps
a4485df4-964d-4d2c-80b1-b43cf89ab6fc	varun.deoghare@gmail.com	One-Arm Dumbbell Row		2026-07-18 13:23:26.852551	\N	519	BACK	Lats, Rhomboids, Middle Traps, Rear Delts, Biceps
51680ab4-8058-4d5e-9d20-888ec6935a95	varun.deoghare@gmail.com	Dumbbell Row to Hip		2026-07-18 13:23:26.862147	\N	520	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps
e4bbacf3-85db-4bec-9081-53fe908e3a5b	varun.deoghare@gmail.com	Chest-Supported Dumbbell Lat Row		2026-07-18 13:23:26.872643	\N	521	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps
9fb2f1a1-ad30-4401-b9fa-b2b2c0a48213	varun.deoghare@gmail.com	Chest-Supported Dumbbell Upper-Back Row		2026-07-18 13:23:26.882323	\N	522	BACK	Rhomboids, Middle Traps, Rear Delts, Lats, Biceps
b3ccee30-1d7a-4a9d-9d9d-bed52be4f108	varun.deoghare@gmail.com	Incline-Bench Dumbbell Row		2026-07-18 13:23:26.89338	\N	523	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps
d1a218c1-e492-459a-84db-3097427ac9c3	varun.deoghare@gmail.com	Seal Dumbbell Row		2026-07-18 13:23:26.903935	\N	524	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps
45851bff-5c8c-4952-b2d9-c77d0aa7971d	varun.deoghare@gmail.com	Renegade Row		2026-07-18 13:23:26.916363	\N	525	BACK	Lats, Rhomboids, Biceps, Trunk Stabilizers
9050a31c-e168-41c7-9af9-86e5835a75bd	varun.deoghare@gmail.com	Gorilla Row		2026-07-18 13:23:26.926165	\N	526	BACK	Lats, Rhomboids, Middle Traps, Biceps, Spinal Erectors
eedb9cf4-ec63-4e2a-b859-c292b84236a4	varun.deoghare@gmail.com	Kroc Row		2026-07-18 13:23:26.936351	\N	527	BACK	Lats, Rhomboids, Middle Traps, Upper Traps, Biceps
a4308e81-92ca-4a8f-8295-c4d07862f9c4	varun.deoghare@gmail.com	Barbell Bent-Over Row		2026-07-18 13:23:26.94515	\N	528	BACK	Lats, Rhomboids, Middle Traps, Rear Delts, Biceps, Spinal Erectors
05f8a601-55f9-4e33-aebd-ed57fb102fc3	varun.deoghare@gmail.com	Underhand Barbell Row		2026-07-18 13:23:26.955055	\N	529	BACK	Lats, Teres Major, Biceps, Rhomboids, Spinal Erectors
5aaedc0c-0099-4fe3-a0d6-2f5c74425abd	varun.deoghare@gmail.com	Wide-Grip Barbell Row		2026-07-18 13:23:26.965079	\N	530	BACK	Rhomboids, Middle Traps, Rear Delts, Lats, Biceps, Spinal Erectors
6120d48d-93ec-4b54-a58c-377c47730668	varun.deoghare@gmail.com	Pendlay Row		2026-07-18 13:23:26.973547	\N	531	BACK	Lats, Rhomboids, Middle Traps, Rear Delts, Biceps, Spinal Erectors
fc23ebdb-f981-4671-a612-1456fac815d4	varun.deoghare@gmail.com	Smith Machine Bent-Over Row		2026-07-18 13:23:26.982704	\N	532	BACK	Lats, Rhomboids, Middle Traps, Rear Delts, Biceps
06902aa2-e53b-4f99-a4e9-29db979c8172	varun.deoghare@gmail.com	Underhand Smith Machine Row		2026-07-18 13:23:26.991675	\N	533	BACK	Lats, Teres Major, Biceps, Rhomboids
4106435a-5719-4718-ad99-14561f9e44e6	varun.deoghare@gmail.com	Wide-Grip Smith Machine Row		2026-07-18 13:23:27.001207	\N	534	BACK	Rhomboids, Middle Traps, Rear Delts, Lats, Biceps
36ee65f2-3b15-44fa-a684-31e1ab268851	varun.deoghare@gmail.com	Chest-Supported Barbell Row		2026-07-18 13:23:27.010931	\N	535	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps
a12d3870-d012-42b5-ad79-8045bcaa5d18	varun.deoghare@gmail.com	Seal Barbell Row		2026-07-18 13:23:27.020245	\N	536	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps
e4000979-b534-4caf-8767-3e3ebc4c2544	varun.deoghare@gmail.com	T-Bar Row		2026-07-18 13:23:27.028739	\N	537	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps, Spinal Erectors
305070a5-689e-43f0-b4a5-0c1665318bce	varun.deoghare@gmail.com	Chest-Supported T-Bar Row		2026-07-18 13:23:27.037936	\N	538	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps
191c6046-f01c-4416-9418-6b17971b8125	varun.deoghare@gmail.com	Wide-Grip T-Bar Row		2026-07-18 13:23:27.046984	\N	539	BACK	Rhomboids, Middle Traps, Rear Delts, Lats, Biceps
a6d660af-8146-40b0-9cf4-9268b2dd3234	varun.deoghare@gmail.com	Landmine Row		2026-07-18 13:23:27.055324	\N	540	BACK	Lats, Rhomboids, Middle Traps, Rear Delts, Biceps
239df34e-4228-4f6e-aa7a-91fc1eeba950	varun.deoghare@gmail.com	Landmine T-Bar Row		2026-07-18 13:23:27.063416	\N	541	BACK	Lats, Rhomboids, Middle Traps, Rear Delts, Biceps
8926b144-2d09-4a6a-886b-a109fa404ea4	varun.deoghare@gmail.com	Meadows Row		2026-07-18 13:23:27.072302	\N	542	BACK	Lats (Lengthened), Teres Major, Upper Back, Biceps
0fb668a7-4ed1-4281-a5cd-4a97c842a61d	varun.deoghare@gmail.com	Half-Kneeling Landmine Row		2026-07-18 13:23:27.079827	\N	543	BACK	Lats, Teres Major, Rhomboids, Biceps
5b320c56-b1eb-4a52-8d75-7e3924a69dca	varun.deoghare@gmail.com	Machine Seated Row		2026-07-18 13:23:27.089134	\N	544	BACK	Lats, Rhomboids, Middle Traps, Rear Delts, Biceps
cc819dba-10b8-4e77-9c38-3a3d935c16d0	varun.deoghare@gmail.com	Neutral-Grip Machine Row		2026-07-18 13:23:27.096688	\N	545	BACK	Lats, Rhomboids, Middle Traps, Biceps
5eaa01bf-74ae-41dd-861f-4df8fafda137	varun.deoghare@gmail.com	Wide-Grip Machine Row		2026-07-18 13:23:27.105437	\N	546	BACK	Rhomboids, Middle Traps, Rear Delts, Lats, Biceps
a689dd02-12f0-4ce0-a0aa-715167c8e3ed	varun.deoghare@gmail.com	Chest-Supported Machine Row		2026-07-18 13:23:27.114149	\N	547	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps
23dd8278-128d-45bf-aae3-a3dff8ae010d	varun.deoghare@gmail.com	Chest-Supported Machine Lat Row		2026-07-18 13:23:27.123442	\N	548	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps
e034a5e3-4cb4-4348-b269-f8cc4d94cb78	varun.deoghare@gmail.com	Machine High Row		2026-07-18 13:23:27.132072	\N	549	BACK	Lats, Teres Major, Rhomboids, Rear Delts, Biceps
8f4a846d-564a-4501-be52-dece8943bb5d	varun.deoghare@gmail.com	Plate-Loaded Low Row		2026-07-18 13:23:27.140221	\N	550	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps
00501894-5ec8-49fa-a5c6-eadfc14b869b	varun.deoghare@gmail.com	Hammer-Strength Low Row		2026-07-18 13:23:27.148256	\N	551	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps
5a17be5d-0c18-463a-9900-12b2a2adbd0a	varun.deoghare@gmail.com	Hammer-Strength High Row		2026-07-18 13:23:27.156183	\N	552	BACK	Lats, Teres Major, Rhomboids, Rear Delts, Biceps
7ef6de09-b3d3-4145-bdbc-2c9b3161f577	varun.deoghare@gmail.com	Iso-Lateral Low Row		2026-07-18 13:23:27.163583	\N	553	BACK	Lats (Lengthened to Mid-Range), Teres Major, Biceps
440357d9-14b9-4758-9f1b-0cc6fc17a6a8	varun.deoghare@gmail.com	Iso-Lateral High Row		2026-07-18 13:23:27.172378	\N	554	BACK	Lats, Teres Major, Rhomboids, Rear Delts, Biceps
14dd0c16-96e7-4550-936c-9802e0d81783	varun.deoghare@gmail.com	Single-Arm Machine Row		2026-07-18 13:23:27.180075	\N	555	BACK	Lats, Rhomboids, Middle Traps, Biceps
e2e5d630-d002-40a7-817a-dc6d4896077b	varun.deoghare@gmail.com	Single-Arm Machine Lat Row		2026-07-18 13:23:27.188955	\N	556	BACK	Lats (Lengthened to Shortened), Teres Major, Biceps
727fc238-78fd-4340-b138-79ccd6ab5103	varun.deoghare@gmail.com	Inverted Row		2026-07-18 13:23:27.198212	\N	557	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps
e189e3be-a4ac-4395-a670-da4065a066b9	varun.deoghare@gmail.com	Feet-Elevated Inverted Row		2026-07-18 13:23:27.207596	\N	558	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps
ae7eed74-4f6c-401f-a25e-a74777ebb5ed	varun.deoghare@gmail.com	Underhand Inverted Row		2026-07-18 13:23:27.216289	\N	559	BACK	Lats, Rhomboids, Middle Traps, Biceps
5b97d9aa-03e3-4c50-912b-cba12e3106b6	varun.deoghare@gmail.com	Wide-Grip Inverted Row		2026-07-18 13:23:27.224701	\N	560	BACK	Rhomboids, Middle Traps, Rear Delts, Lats, Biceps
57c93cbf-fbfd-407d-97c4-9cbcc6b8772d	varun.deoghare@gmail.com	TRX Row		2026-07-18 13:23:27.233176	\N	561	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps
08ec723d-47fa-4cee-a13b-0a22d1a93721	varun.deoghare@gmail.com	Resistance-Band Row		2026-07-18 13:23:27.241501	\N	562	BACK	Rhomboids, Middle Traps, Lats, Rear Delts, Biceps
db3637a0-a967-4ba7-bcd4-a8d0978b1a3e	varun.deoghare@gmail.com	Single-Arm Resistance-Band Row		2026-07-18 13:23:27.250531	\N	563	BACK	Lats, Rhomboids, Middle Traps, Biceps
89e335e3-21a4-4c9d-ae73-fba545413fc3	varun.deoghare@gmail.com	Reverse Pec Deck Fly		2026-07-18 13:23:27.258223	\N	564	BACK	Rear Delts, Rhomboids, Middle Traps
c4d63e53-637b-4310-b2da-2b0ea02ed739	varun.deoghare@gmail.com	Cable Rear-Delt Fly		2026-07-18 13:23:27.267498	\N	565	BACK	Rear Delts, Rhomboids, Middle Traps
20b76382-0ce3-480a-9a53-3e89def52a72	varun.deoghare@gmail.com	Single-Arm Cable Rear-Delt Fly		2026-07-18 13:23:27.275266	\N	566	BACK	Rear Delts, Rhomboids, Middle Traps
eea8ff6a-92a4-4eb0-9f28-1a58b79cb637	varun.deoghare@gmail.com	Bent-Over Dumbbell Reverse Fly		2026-07-18 13:23:27.283853	\N	567	BACK	Rear Delts, Rhomboids, Middle Traps
867649fc-990d-4523-b509-57a43fcd4471	varun.deoghare@gmail.com	Incline-Bench Reverse Fly		2026-07-18 13:23:27.293326	\N	568	BACK	Rear Delts, Rhomboids, Middle Traps
7dae60cf-c013-4155-899f-28d14ebd5339	varun.deoghare@gmail.com	Rear-Delt Cable Row		2026-07-18 13:23:27.302984	\N	569	BACK	Rear Delts, Rhomboids, Middle Traps, Biceps
256c6df7-1224-4fdf-89ce-3e72dfdee6c4	varun.deoghare@gmail.com	Chest-Supported Wide-Elbow Row		2026-07-18 13:23:27.311296	\N	570	BACK	Rhomboids, Middle Traps, Rear Delts, Lower Traps, Biceps
7e37fe28-29ce-42ee-ab65-0efed8429a47	varun.deoghare@gmail.com	Rope Face Pull		2026-07-18 13:23:27.320478	\N	571	BACK	Rear Delts, Middle Traps, Rhomboids, External Rotators
597eaac7-ff34-4c57-99c3-4e9c61da4803	varun.deoghare@gmail.com	Band Pull-Apart		2026-07-18 13:23:27.329115	\N	572	BACK	Rear Delts, Rhomboids, Middle Traps
107f8c37-eee3-4c6a-bae7-d6f6934db61b	varun.deoghare@gmail.com	Prone Y-Raise		2026-07-18 13:23:27.339611	\N	573	BACK	Lower Traps, Rear Delts, Rotator Cuff
aa07c300-c41d-4880-a58d-166cf167989f	varun.deoghare@gmail.com	Prone T-Raise		2026-07-18 13:23:27.347985	\N	574	BACK	Rear Delts, Middle Traps, Rhomboids
a7ec646a-0eff-4fe6-a071-fc1dbf3233e4	varun.deoghare@gmail.com	Prone W-Raise		2026-07-18 13:23:27.35855	\N	575	BACK	Rear Delts, Middle/Lower Traps, External Rotators
c90bab15-c4de-48d2-8a4c-b7a5b6c6a5a3	varun.deoghare@gmail.com	Dumbbell Shrug		2026-07-18 13:23:27.367923	\N	576	BACK	Upper Traps (Shortened Emphasis), Levator Scapulae
a1f59b5d-8e5d-4931-a7bf-d18ef95899aa	varun.deoghare@gmail.com	Barbell Shrug		2026-07-18 13:23:27.417541	\N	577	BACK	Upper Traps (Shortened Emphasis), Levator Scapulae
82463ec3-fd16-443e-bff6-270e58210109	varun.deoghare@gmail.com	Smith Machine Shrug		2026-07-18 13:23:27.426741	\N	578	BACK	Upper Traps (Shortened Emphasis), Levator Scapulae
5ddb1354-2bee-46eb-90c3-518aedd70ab8	varun.deoghare@gmail.com	Machine Shrug		2026-07-18 13:23:27.439386	\N	579	BACK	Upper Traps (Shortened Emphasis), Levator Scapulae
9978065a-cb63-4713-b666-3960c740548b	varun.deoghare@gmail.com	Cable Shrug		2026-07-18 13:23:27.450694	\N	580	BACK	Upper Traps (Shortened Emphasis), Levator Scapulae
756f3629-25d8-42f6-9b51-c852203f9192	varun.deoghare@gmail.com	Trap-Bar Shrug		2026-07-18 13:23:27.46129	\N	581	BACK	Upper Traps (Shortened Emphasis), Levator Scapulae
e91fca05-39c1-42fc-8c74-89722ed4ebfa	varun.deoghare@gmail.com	Behind-the-Back Barbell Shrug		2026-07-18 13:23:27.470942	\N	582	BACK	Upper Traps, Levator Scapulae
55e26905-7191-410b-8eb7-a42eb669649c	varun.deoghare@gmail.com	Incline Dumbbell Shrug		2026-07-18 13:23:27.480643	\N	583	BACK	Middle Traps, Upper Traps, Rhomboids
c1a6f00b-b854-41ef-8ec2-b04dce860ce0	varun.deoghare@gmail.com	Chest-Supported Shrug		2026-07-18 13:23:27.490507	\N	584	BACK	Middle Traps, Rhomboids
5d536326-708e-4d07-90d0-40228864e742	varun.deoghare@gmail.com	Kelso Shrug		2026-07-18 13:23:27.50099	\N	585	BACK	Middle Traps, Rhomboids
75bfc39c-836e-4741-8a58-123776b8542f	varun.deoghare@gmail.com	Overhead Shrug		2026-07-18 13:23:27.509725	\N	586	BACK	Upper Traps, Lower Traps, Serratus Anterior
5557a80c-9f92-4aa8-9be3-0de5852af026	varun.deoghare@gmail.com	Farmer's Carry		2026-07-18 13:23:27.520087	\N	587	BACK	Upper Traps (Isometric), Forearms, Trunk Stabilizers
38aa74e1-8f70-47c6-a409-893570a75a7d	varun.deoghare@gmail.com	45-Degree Back Extension		2026-07-18 13:23:27.527897	\N	588	BACK	Spinal Erectors, Glutes, Hamstrings
a3f50aff-77bc-4f8a-8c61-15b54d74e4ac	varun.deoghare@gmail.com	Horizontal Back Extension		2026-07-18 13:23:27.537021	\N	589	BACK	Spinal Erectors, Glutes, Hamstrings
a5f1392b-c427-4dcb-bda3-756a05ed8b10	varun.deoghare@gmail.com	Machine Back Extension		2026-07-18 13:23:27.544966	\N	590	BACK	Spinal Erectors
f3ada8c1-3e04-4254-9079-5c95891df190	varun.deoghare@gmail.com	Seated Back Extension		2026-07-18 13:23:27.555189	\N	591	BACK	Spinal Erectors
4b52baa5-9bb5-4ef7-9c49-b5f90b4354f6	varun.deoghare@gmail.com	Reverse Hyperextension		2026-07-18 13:23:27.563955	\N	592	BACK	Spinal Erectors, Glutes, Hamstrings
50af9ccb-c0f1-4691-961b-1b21195964e7	varun.deoghare@gmail.com	Barbell Good Morning		2026-07-18 13:23:27.572985	\N	593	BACK	Spinal Erectors (Isometric), Hamstrings (Lengthened), Glutes (Lengthened)
a57d8cf5-9fb4-4cef-b8b9-a77de783fea8	varun.deoghare@gmail.com	Romanian Deadlift		2026-07-18 13:23:27.583174	\N	594	BACK	Spinal Erectors (Isometric), Hamstrings (Lengthened), Glutes (Lengthened), Adductors
40b40f56-9827-4286-90e0-5aee50da0971	varun.deoghare@gmail.com	Conventional Deadlift		2026-07-18 13:23:27.592068	\N	595	BACK	Spinal Erectors, Glutes, Hamstrings, Quads, Traps
57e37044-04ac-4d79-8a23-8cc2d430572b	varun.deoghare@gmail.com	Sumo Deadlift		2026-07-18 13:23:27.603472	\N	596	BACK	Spinal Erectors, Glutes, Adductors, Quads, Hamstrings, Traps
a66da1af-2fbb-44a3-bb74-24af725b4b09	varun.deoghare@gmail.com	Trap-Bar Deadlift		2026-07-18 13:23:27.612091	\N	597	BACK	Spinal Erectors, Glutes, Quads, Hamstrings, Traps
d2fbbfe9-6101-42c1-a280-7b8d1364d869	varun.deoghare@gmail.com	Rack Pull		2026-07-18 13:23:27.621407	\N	598	BACK	Spinal Erectors, Glutes, Upper Traps, Hamstrings
ce9803fc-90ea-45d9-8db6-70896021e46e	varun.deoghare@gmail.com	Bird Dog		2026-07-18 13:23:27.629464	\N	599	BACK	Spinal Stabilizers, Glutes, Abdominals
5cf052d6-e289-44d7-a5df-a3c8c77aee20	varun.deoghare@gmail.com	Superman Hold		2026-07-18 13:23:27.639344	\N	600	BACK	Spinal Erectors (Shortened Isometric), Glutes
2c079967-ac1e-45cf-ac5c-8a0b907fed5b	varun.deoghare@gmail.com	Jefferson Curl		2026-07-18 13:23:27.647664	\N	601	BACK	Spinal Erectors (Lengthened), Hamstrings
e6e13ed0-10c0-4ba6-beb3-9b8cef501c7e	varun.deoghare@gmail.com	Scapular Pulldown		2026-07-18 13:23:27.656015	\N	602	BACK	Lower Traps, Lats, Rhomboids
1513a3f9-01ee-4b16-88d5-7ae35a59516d	varun.deoghare@gmail.com	Straight-Arm Scapular Pulldown		2026-07-18 13:23:27.663699	\N	603	BACK	Lower Traps, Lats, Rhomboids
585e41bf-18fd-4db1-8e4f-68e7269bcc6e	varun.deoghare@gmail.com	Wall Slide		2026-07-18 13:23:27.672885	\N	604	BACK	Serratus Anterior, Lower Traps, Rotator Cuff
fca6baae-ef7c-4a91-aaa8-1559f431762b	varun.deoghare@gmail.com	Scapular Push-Up		2026-07-18 13:15:52.123184	2026-07-18 13:18:03.693151	317	SHOULDERS	Serratus Anterior, Pecs
a852daca-0bb8-475f-82ff-d5647ae65097	varun.deoghare@gmail.com	Barbell Back Squat		2026-07-18 13:11:47.185782	2026-07-18 13:18:03.693151	1	LEGS	Quads (Lengthened), Glutes (Lengthened), Adductors (Lengthened), Spinal Erectors
212ea1a2-3823-47df-b82a-a0d404476787	varun.deoghare@gmail.com	High-Bar Back Squat		2026-07-18 13:11:47.208976	2026-07-18 13:18:03.693151	2	LEGS	Quads (Lengthened), Glutes (Lengthened), Adductors (Lengthened), Spinal Erectors
52d56787-43d8-4553-9d39-9c136e2f8f39	varun.deoghare@gmail.com	Low-Bar Back Squat		2026-07-18 13:11:47.227792	2026-07-18 13:18:03.693151	3	LEGS	Glutes (Lengthened), Adductors (Lengthened), Quads, Spinal Erectors
7e7c93ff-dc42-4dfa-8bef-ec70d0bb4822	varun.deoghare@gmail.com	Barbell Front Squat		2026-07-18 13:11:47.244581	2026-07-18 13:18:03.693151	4	LEGS	Quads (Lengthened), Glutes, Adductors, Spinal Erectors
6ae3b005-edb5-4130-a13b-c382d713695a	varun.deoghare@gmail.com	Safety Bar Squat		2026-07-18 13:11:47.2573	2026-07-18 13:18:03.693151	5	LEGS	Quads (Lengthened), Glutes (Lengthened), Adductors, Spinal Erectors
48504f59-ec07-4346-a1b6-37d74781f7e1	varun.deoghare@gmail.com	Smith Machine Squat		2026-07-18 13:11:47.34992	2026-07-18 13:18:03.693151	6	LEGS	Quads (Lengthened), Glutes (Lengthened), Adductors
2719eccf-ae7c-4aca-91c4-02264a74f309	varun.deoghare@gmail.com	Heels-Elevated Smith Machine Squat		2026-07-18 13:11:47.37079	2026-07-18 13:18:03.693151	7	LEGS	Quads (Lengthened), Glutes, Adductors
7c3a5ade-77a7-46b7-be30-5e345f16121b	varun.deoghare@gmail.com	Hack Squat		2026-07-18 13:11:47.384976	2026-07-18 13:18:03.693151	8	LEGS	Quads (Lengthened), Glutes (Lengthened), Adductors
68d635b2-323a-48fc-89c4-b4f0e55ac50e	varun.deoghare@gmail.com	Pendulum Squat		2026-07-18 13:11:47.397674	2026-07-18 13:18:03.693151	9	LEGS	Quads (Lengthened), Glutes (Lengthened), Adductors
189983d8-96a0-4f98-b491-ca3ea7094898	varun.deoghare@gmail.com	V-Squat		2026-07-18 13:11:47.408733	2026-07-18 13:18:03.693151	10	LEGS	Quads, Glutes (Lengthened), Adductors
2553b5d4-7660-483b-b7e3-a624fdbb3b9f	varun.deoghare@gmail.com	Reverse V-Squat		2026-07-18 13:11:47.422271	2026-07-18 13:18:03.693151	11	LEGS	Quads (Lengthened), Glutes, Adductors
ab1ab159-00d9-46fc-970d-ec4c6f552093	varun.deoghare@gmail.com	Belt Squat		2026-07-18 13:11:47.43409	2026-07-18 13:18:03.693151	12	LEGS	Quads (Lengthened), Glutes (Lengthened), Adductors
e274a4df-a700-4e48-a12a-e093da7d588e	varun.deoghare@gmail.com	Goblet Squat		2026-07-18 13:11:47.445451	2026-07-18 13:18:03.693151	13	LEGS	Quads (Lengthened), Glutes (Lengthened), Adductors, Spinal Erectors
c0d73997-55b1-4b5b-a6ef-16791515f7c6	varun.deoghare@gmail.com	Dumbbell Squat		2026-07-18 13:11:47.457628	2026-07-18 13:18:03.693151	14	LEGS	Quads (Lengthened), Glutes (Lengthened), Adductors
fe720e36-90b4-4abc-bfe7-01d9f6aa9bf5	varun.deoghare@gmail.com	Landmine Squat		2026-07-18 13:11:47.471912	2026-07-18 13:18:03.693151	15	LEGS	Quads (Lengthened), Glutes, Adductors
52b58a70-af35-44b6-89fa-461de27eb30c	varun.deoghare@gmail.com	Cyclist Squat		2026-07-18 13:11:47.484637	2026-07-18 13:18:03.693151	16	LEGS	Quads (Lengthened), Glutes
72ee95f8-8562-4af3-be6f-f104d9151239	varun.deoghare@gmail.com	Sissy Squat		2026-07-18 13:11:47.497273	2026-07-18 13:18:03.693151	17	LEGS	Quads (Lengthened), especially Rectus Femoris
f0ae54cb-5188-458d-b7f3-522079aa411b	varun.deoghare@gmail.com	Spanish Squat		2026-07-18 13:11:47.507575	2026-07-18 13:18:03.693151	18	LEGS	Quads
27fbee46-e96d-433d-81ed-09278815b505	varun.deoghare@gmail.com	Bodyweight Squat		2026-07-18 13:11:47.518023	2026-07-18 13:18:03.693151	19	LEGS	Quads, Glutes, Adductors
b8d84b4c-98d0-4215-b71e-f43fe14797f3	varun.deoghare@gmail.com	Box Squat		2026-07-18 13:11:47.530895	2026-07-18 13:18:03.693151	20	LEGS	Glutes, Quads, Adductors, Spinal Erectors
7d0d0d20-2920-4ad6-a19f-edfe04df5840	varun.deoghare@gmail.com	Zercher Squat		2026-07-18 13:11:47.542088	2026-07-18 13:18:03.693151	21	LEGS	Quads, Glutes, Adductors, Spinal Erectors
7ba2b061-a2af-4aa2-b165-ddb697e9ba62	varun.deoghare@gmail.com	Wall Sit		2026-07-18 13:11:47.552613	2026-07-18 13:18:03.693151	22	LEGS	Quads (Mid-Range Isometric), Glutes
19761c4b-6c48-4ba6-9641-82ad754a56c4	varun.deoghare@gmail.com	45-Degree Leg Press		2026-07-18 13:11:47.564132	2026-07-18 13:18:03.693151	23	LEGS	Quads (Lengthened to Mid-Range), Glutes (Lengthened), Adductors
922dce4f-4031-4def-bc9e-cf557f1644e1	varun.deoghare@gmail.com	Horizontal Leg Press		2026-07-18 13:11:47.575567	2026-07-18 13:18:03.693151	24	LEGS	Quads (Mid-Range), Glutes, Adductors
5f549404-1ab6-4904-b384-a5ca5ed66ac0	varun.deoghare@gmail.com	Vertical Leg Press		2026-07-18 13:11:47.585404	2026-07-18 13:18:03.693151	25	LEGS	Quads, Glutes (Lengthened), Adductors
54c62312-6cba-4412-948b-ea1834372a47	varun.deoghare@gmail.com	Single-Leg Press		2026-07-18 13:11:47.598877	2026-07-18 13:18:03.693151	26	LEGS	Quads (Lengthened to Mid-Range), Glutes (Lengthened), Adductors
81c0d547-6e33-4e6c-8a5f-26fef9b93a8b	varun.deoghare@gmail.com	Low-Foot Leg Press		2026-07-18 13:11:47.610539	2026-07-18 13:18:03.693151	27	LEGS	Quads (Lengthened), Glutes
51f478cb-b080-4237-8990-bb09171f9015	varun.deoghare@gmail.com	High-Foot Leg Press		2026-07-18 13:11:47.632063	2026-07-18 13:18:03.693151	28	LEGS	Glutes (Lengthened), Adductors, Quads
51709b11-fe15-4add-8c72-cc8d207ebd35	varun.deoghare@gmail.com	Wide-Stance Leg Press		2026-07-18 13:11:47.648585	2026-07-18 13:18:03.693151	29	LEGS	Adductors (Lengthened), Glutes, Quads
8b52ae53-0993-43ad-bc51-42479b83d13a	varun.deoghare@gmail.com	Narrow-Stance Leg Press		2026-07-18 13:11:47.660474	2026-07-18 13:18:03.693151	30	LEGS	Quads, Glutes
2fbd3720-1235-4d08-986e-4a30c60ef506	varun.deoghare@gmail.com	Machine Squat Press		2026-07-18 13:11:47.672386	2026-07-18 13:18:03.693151	31	LEGS	Quads, Glutes, Adductors
76f9440b-adad-41b3-8044-bd71e26fb6cf	varun.deoghare@gmail.com	Stationary Lunge		2026-07-18 13:11:47.684667	2026-07-18 13:18:03.693151	32	LEGS	Quads, Glutes (Lengthened), Adductors
6fe3b32b-fc0d-4706-aa89-47ccee30b87a	varun.deoghare@gmail.com	Forward Lunge		2026-07-18 13:11:47.697362	2026-07-18 13:18:03.693151	33	LEGS	Quads (Lengthened), Glutes, Adductors
9c8da387-dab4-4c73-8ade-c370d760a8c1	varun.deoghare@gmail.com	Reverse Lunge		2026-07-18 13:11:47.710305	2026-07-18 13:18:03.693151	34	LEGS	Glutes (Lengthened), Quads, Adductors
87c61ac0-f999-4ba8-9483-05c8ab5514c1	varun.deoghare@gmail.com	Walking Lunge		2026-07-18 13:11:47.721161	2026-07-18 13:18:03.693151	35	LEGS	Quads, Glutes (Lengthened), Adductors
cfd8c348-ea34-42bd-87c2-50c47dc6795d	varun.deoghare@gmail.com	Dumbbell Lunge		2026-07-18 13:11:47.732787	2026-07-18 13:18:03.693151	36	LEGS	Quads, Glutes (Lengthened), Adductors
9521f1d8-6eef-4fc6-8052-a2c18d4a7696	varun.deoghare@gmail.com	Barbell Lunge		2026-07-18 13:11:47.744925	2026-07-18 13:18:03.693151	37	LEGS	Quads, Glutes (Lengthened), Adductors, Spinal Erectors
caf4cae0-e9b5-4e69-bc70-269b6d946ba7	varun.deoghare@gmail.com	Bulgarian Split Squat		2026-07-18 13:11:47.755474	2026-07-18 13:18:03.693151	38	LEGS	Quads (Lengthened), Glutes (Lengthened), Adductors
cf7a4e90-c554-485a-a69d-54ffebc17dd5	varun.deoghare@gmail.com	Front-Foot-Elevated Split Squat		2026-07-18 13:11:47.766556	2026-07-18 13:18:03.693151	39	LEGS	Glutes (Lengthened), Quads (Lengthened), Adductors
fea6cfdd-208e-40f2-86c0-38d932e191c1	varun.deoghare@gmail.com	Smith Machine Split Squat		2026-07-18 13:11:47.780514	2026-07-18 13:18:03.693151	40	LEGS	Quads, Glutes (Lengthened), Adductors
b5212735-94ce-4272-8398-b2a00dd6fcad	varun.deoghare@gmail.com	Deficit Reverse Lunge		2026-07-18 13:11:47.800969	2026-07-18 13:18:03.693151	41	LEGS	Glutes (Lengthened), Quads, Adductors
e8035d66-c4b3-435a-b82e-32fb2bb1195b	varun.deoghare@gmail.com	Curtsy Lunge		2026-07-18 13:11:47.819427	2026-07-18 13:18:03.693151	42	LEGS	Glutes, Quads, Adductors
a665c136-3db1-4ba0-bad1-1e7ec3f9c966	varun.deoghare@gmail.com	Lateral Lunge		2026-07-18 13:11:47.831196	2026-07-18 13:18:03.693151	43	LEGS	Adductors (Lengthened), Glutes, Quads
747dad4e-7861-46f3-a6f7-4ffecca9dbb6	varun.deoghare@gmail.com	Cossack Squat		2026-07-18 13:11:47.84232	2026-07-18 13:18:03.693151	44	LEGS	Adductors (Lengthened), Glutes, Quads
4bb7e335-b96f-487c-a67c-f04348394c92	varun.deoghare@gmail.com	Step-Up		2026-07-18 13:11:47.852389	2026-07-18 13:18:03.693151	45	LEGS	Glutes (Mid-Range), Quads, Adductors
9142129a-7c70-41b1-9279-43d9a944e66d	varun.deoghare@gmail.com	High Step-Up		2026-07-18 13:11:47.864063	2026-07-18 13:18:03.693151	46	LEGS	Glutes (Lengthened to Mid-Range), Quads, Adductors
e3e71e02-8827-480f-81b2-9b3fabf70106	varun.deoghare@gmail.com	Lateral Step-Up		2026-07-18 13:11:47.875166	2026-07-18 13:18:03.693151	47	LEGS	Gluteus Medius, Gluteus Maximus, Quads
d953c052-b45a-42bf-8c54-269a409435ce	varun.deoghare@gmail.com	Step-Down		2026-07-18 13:11:47.88559	2026-07-18 13:18:03.693151	48	LEGS	Quads, Gluteus Medius, Gluteus Minimus
8bd5944e-0ab7-461d-9133-6cc272855afe	varun.deoghare@gmail.com	Seated Leg Extension		2026-07-18 13:11:47.89853	2026-07-18 13:18:03.693151	49	LEGS	Quads (Shortened Emphasis)
f5826a9e-26e9-45f1-8502-fb643df52519	varun.deoghare@gmail.com	Single-Leg Extension		2026-07-18 13:11:47.911489	2026-07-18 13:18:03.693151	50	LEGS	Quads (Shortened Emphasis)
f104e33f-15b0-4816-a52d-df932190f5af	varun.deoghare@gmail.com	Standing Cable Leg Extension		2026-07-18 13:11:47.922819	2026-07-18 13:18:03.693151	51	LEGS	Quads
baf6948b-90cc-4be7-8aac-7b783c922a7f	varun.deoghare@gmail.com	Reverse Nordic Curl		2026-07-18 13:11:47.942266	2026-07-18 13:18:03.693151	52	LEGS	Quads (Lengthened), especially Rectus Femoris
de380c56-2c5d-4e7b-9894-42ddeab912cd	varun.deoghare@gmail.com	Bodyweight Knee Extension		2026-07-18 13:11:47.952756	2026-07-18 13:18:03.693151	53	LEGS	Quads
77c06deb-2530-4265-a7c2-23b8e0bf9508	varun.deoghare@gmail.com	Barbell Romanian Deadlift		2026-07-18 13:11:47.964371	2026-07-18 13:18:03.693151	54	LEGS	Hamstrings (Lengthened), Glutes (Lengthened), Adductors, Spinal Erectors
87a0eaab-c6ec-49f2-9da0-e2cf2fecf546	varun.deoghare@gmail.com	Dumbbell Romanian Deadlift		2026-07-18 13:11:47.976854	2026-07-18 13:18:03.693151	55	LEGS	Hamstrings (Lengthened), Glutes (Lengthened), Adductors, Spinal Erectors
6ce28d93-9696-4f47-bf33-fdfffdd8e5f6	varun.deoghare@gmail.com	Smith Machine Romanian Deadlift		2026-07-18 13:11:47.993834	2026-07-18 13:18:03.693151	56	LEGS	Hamstrings (Lengthened), Glutes (Lengthened), Adductors, Spinal Erectors
78ff0e54-e8d5-4e02-8aa9-8a2c0f95605e	varun.deoghare@gmail.com	Single-Leg Romanian Deadlift		2026-07-18 13:11:48.005836	2026-07-18 13:18:03.693151	57	LEGS	Hamstrings (Lengthened), Glutes (Lengthened), Adductors, Spinal Erectors
bd124884-3c55-4d27-ad76-1cd513d16897	varun.deoghare@gmail.com	B-Stance Romanian Deadlift		2026-07-18 13:11:48.017329	2026-07-18 13:18:03.693151	58	LEGS	Hamstrings (Lengthened), Glutes (Lengthened), Adductors, Spinal Erectors
83aa58fb-3a24-46ea-8002-ec9ed59a93ff	varun.deoghare@gmail.com	Stiff-Leg Deadlift		2026-07-18 13:11:48.028124	2026-07-18 13:18:03.693151	59	LEGS	Hamstrings (Lengthened), Glutes, Adductors, Spinal Erectors
79df5920-0bd1-4829-b21a-8e288e0a0b80	varun.deoghare@gmail.com	Conventional Deadlift		2026-07-18 13:11:48.040484	2026-07-18 13:18:03.693151	60	LEGS	Glutes, Hamstrings, Quads, Adductors, Spinal Erectors
53b0b1b4-3e47-45cd-86cf-25a883ee1d65	varun.deoghare@gmail.com	Sumo Deadlift		2026-07-18 13:11:48.050223	2026-07-18 13:18:03.693151	61	LEGS	Glutes, Adductors, Quads, Hamstrings, Spinal Erectors
14470f9d-d943-46cc-b844-5cf47015bbab	varun.deoghare@gmail.com	Trap-Bar Deadlift		2026-07-18 13:11:48.061988	2026-07-18 13:18:03.693151	62	LEGS	Quads, Glutes, Hamstrings, Adductors, Spinal Erectors
51d41417-50ac-4435-b407-b19c036b2713	varun.deoghare@gmail.com	Deficit Deadlift		2026-07-18 13:11:48.086579	2026-07-18 13:18:03.693151	63	LEGS	Glutes (Lengthened), Quads, Hamstrings, Adductors, Spinal Erectors
a4db2b80-cd46-4e3f-90b5-1feaaefe3b2b	varun.deoghare@gmail.com	Rack Pull		2026-07-18 13:11:48.099038	2026-07-18 13:18:03.693151	64	LEGS	Glutes, Hamstrings, Adductors, Spinal Erectors
8ea6dda6-c202-4b5c-9756-d21ef4ecc667	varun.deoghare@gmail.com	Barbell Good Morning		2026-07-18 13:11:48.111755	2026-07-18 13:18:03.693151	65	LEGS	Hamstrings (Lengthened), Glutes (Lengthened), Adductors, Spinal Erectors
15b236d2-4a34-4284-a6af-d95683233dd1	varun.deoghare@gmail.com	Cable Pull-Through		2026-07-18 13:11:48.122652	2026-07-18 13:18:03.693151	66	LEGS	Glutes (Mid-Range), Hamstrings (Mid-Range), Adductors
bede4583-b9ab-4195-8f34-c17ee9b1a4d4	varun.deoghare@gmail.com	45-Degree Hip Extension		2026-07-18 13:11:48.133826	2026-07-18 13:18:03.693151	67	LEGS	Glutes (Mid-Range), Hamstrings (Mid-Range), Adductors, Spinal Erectors
cf4c1c5c-cb50-4874-bd3a-44834fd76f32	varun.deoghare@gmail.com	Horizontal Back Extension		2026-07-18 13:11:48.144994	2026-07-18 13:18:03.693151	68	LEGS	Glutes, Hamstrings, Adductors, Spinal Erectors
7704d441-25ca-4114-aa6f-fac472c9708f	varun.deoghare@gmail.com	Reverse Hyperextension		2026-07-18 13:11:48.156218	2026-07-18 13:18:03.693151	69	LEGS	Glutes, Hamstrings, Spinal Erectors
e45cc5c2-85fd-4657-bca8-ca918f06f51b	varun.deoghare@gmail.com	Kettlebell Swing		2026-07-18 13:11:48.168839	2026-07-18 13:18:03.693151	70	LEGS	Glutes, Hamstrings, Adductors, Spinal Erectors
62f06a0f-072a-4568-bc8b-f5f58a2596b6	varun.deoghare@gmail.com	Seated Leg Curl		2026-07-18 13:11:48.182758	2026-07-18 13:18:03.693151	71	LEGS	Hamstrings (Lengthened Emphasis), Gastrocnemius
63141868-b2c4-4e20-88ff-2befaac76884	varun.deoghare@gmail.com	Inclined Seated Leg Curl		2026-07-18 13:11:48.196999	2026-07-18 13:18:03.693151	72	LEGS	Hamstrings (Lengthened Emphasis), Gastrocnemius
3359b7a6-c8b8-4f8e-815f-1951b92d3748	varun.deoghare@gmail.com	Angled Lying Leg Curl		2026-07-18 13:11:48.210042	2026-07-18 13:18:03.693151	73	LEGS	Hamstrings (Mid-to-Lengthened Emphasis), Gastrocnemius
69c49b33-da75-499a-93da-57c465fe2db9	varun.deoghare@gmail.com	Flat Lying Leg Curl		2026-07-18 13:11:48.222774	2026-07-18 13:18:03.693151	74	LEGS	Hamstrings (Shortened Emphasis), Gastrocnemius
c0076171-3cee-4dbe-8f1e-f4c8fe726834	varun.deoghare@gmail.com	Standing Leg Curl		2026-07-18 13:11:48.236234	2026-07-18 13:18:03.693151	75	LEGS	Hamstrings (Shortened Emphasis), Gastrocnemius
c4e68535-f35b-4711-9e49-bdad60dd9963	varun.deoghare@gmail.com	Single-Leg Seated Curl		2026-07-18 13:11:48.250305	2026-07-18 13:18:03.693151	76	LEGS	Hamstrings (Lengthened Emphasis), Gastrocnemius
d6b04c84-6405-4985-ae55-29aa528cda28	varun.deoghare@gmail.com	Single-Leg Lying Curl		2026-07-18 13:11:48.265831	2026-07-18 13:18:03.693151	77	LEGS	Hamstrings, Gastrocnemius
4d534835-dea9-4090-8491-27b34f0fc621	varun.deoghare@gmail.com	Single-Leg Standing Curl		2026-07-18 13:11:48.279238	2026-07-18 13:18:03.693151	78	LEGS	Hamstrings (Shortened Emphasis), Gastrocnemius
7aba5eaa-8d31-402e-ac62-2d5e26edc56c	varun.deoghare@gmail.com	Standing Cable Leg Curl		2026-07-18 13:11:48.291247	2026-07-18 13:18:03.693151	79	LEGS	Hamstrings (Shortened Emphasis), Gastrocnemius
07594e10-7922-4a86-ade9-371a86c398bd	varun.deoghare@gmail.com	Prone Dumbbell Leg Curl		2026-07-18 13:11:48.305494	2026-07-18 13:18:03.693151	80	LEGS	Hamstrings (Shortened Emphasis), Gastrocnemius
e855a30b-cf61-4e2f-a09a-5ef1051c1c7d	varun.deoghare@gmail.com	Stability-Ball Leg Curl		2026-07-18 13:11:48.317316	2026-07-18 13:18:03.693151	81	LEGS	Hamstrings, Glutes, Gastrocnemius
24dd79e5-b378-4161-ae75-d1e2468e845e	varun.deoghare@gmail.com	Slider Leg Curl		2026-07-18 13:11:48.330444	2026-07-18 13:18:03.693151	82	LEGS	Hamstrings, Glutes, Gastrocnemius
c0195429-91e5-40c6-890d-84a598c27caa	varun.deoghare@gmail.com	Nordic Hamstring Curl		2026-07-18 13:11:48.343598	2026-07-18 13:18:03.693151	83	LEGS	Hamstrings (Lengthened), Gastrocnemius
fd242504-567a-4618-ae7f-59d58e918e26	varun.deoghare@gmail.com	Glute-Ham Raise		2026-07-18 13:11:48.35639	2026-07-18 13:18:03.693151	84	LEGS	Hamstrings (Mid-Range), Glutes, Gastrocnemius
0b0f5d77-7ec7-4350-8034-0ed326e5b68c	varun.deoghare@gmail.com	Barbell Hip Thrust		2026-07-18 13:11:48.369082	2026-07-18 13:18:03.693151	85	LEGS	Glutes (Shortened Emphasis), Hamstrings, Adductors
7951a71c-fc4a-4fe1-aaf2-868ed7f68f42	varun.deoghare@gmail.com	Smith Machine Hip Thrust		2026-07-18 13:11:48.38142	2026-07-18 13:18:03.693151	86	LEGS	Glutes (Shortened Emphasis), Hamstrings, Adductors
fb2cf56d-bd9e-4a93-a417-50b4fcff9e63	varun.deoghare@gmail.com	Machine Hip Thrust		2026-07-18 13:11:48.394631	2026-07-18 13:18:03.693151	87	LEGS	Glutes (Shortened Emphasis), Hamstrings, Adductors
000d771a-bb3f-4b64-bef1-9e5aea0c05db	varun.deoghare@gmail.com	Dumbbell Hip Thrust		2026-07-18 13:11:48.409353	2026-07-18 13:18:03.693151	88	LEGS	Glutes (Shortened Emphasis), Hamstrings, Adductors
2ece51bc-7ddb-4e79-a6e2-1507f1a5527a	varun.deoghare@gmail.com	Single-Leg Hip Thrust		2026-07-18 13:11:48.425797	2026-07-18 13:18:03.693151	89	LEGS	Glutes (Shortened Emphasis), Hamstrings, Adductors
a7f4a30a-6c85-4619-9f2b-b0aee7389d18	varun.deoghare@gmail.com	Barbell Glute Bridge		2026-07-18 13:11:48.438584	2026-07-18 13:18:03.693151	90	LEGS	Glutes (Shortened Emphasis), Hamstrings, Adductors
2662c830-c8db-4c8d-8166-3dfef4bdeef6	varun.deoghare@gmail.com	Single-Leg Glute Bridge		2026-07-18 13:11:48.452335	2026-07-18 13:18:03.693151	91	LEGS	Glutes (Shortened Emphasis), Hamstrings, Adductors
394f5f75-7821-4469-af29-eaf99f4ccaac	varun.deoghare@gmail.com	Frog Pump		2026-07-18 13:11:48.466205	2026-07-18 13:18:03.693151	92	LEGS	Glutes (Shortened Emphasis), Adductors
d19c8eb8-299b-4440-abe1-bdf1fb8c7b75	varun.deoghare@gmail.com	Kas Glute Bridge		2026-07-18 13:11:48.479944	2026-07-18 13:18:03.693151	93	LEGS	Glutes (Shortened Emphasis)
cf7f942d-edff-4da3-84a5-972a8cb2e40a	varun.deoghare@gmail.com	Cable Glute Kickback		2026-07-18 13:11:48.494672	2026-07-18 13:18:03.693151	94	LEGS	Gluteus Maximus (Shortened Emphasis)
007e4f48-4af6-4370-ae99-a65fa729720c	varun.deoghare@gmail.com	Machine Glute Kickback		2026-07-18 13:11:48.512224	2026-07-18 13:18:03.693151	95	LEGS	Gluteus Maximus (Shortened Emphasis)
3206951c-6b0d-42c5-8fc7-dbbcc877174c	varun.deoghare@gmail.com	Quadruped Hip Extension		2026-07-18 13:11:48.529424	2026-07-18 13:18:03.693151	96	LEGS	Gluteus Maximus, Hamstrings
337148fa-c2bf-4c19-9d11-b8593904b4b0	varun.deoghare@gmail.com	Seated Hip Abduction		2026-07-18 13:11:48.542604	2026-07-18 13:18:03.693151	97	LEGS	Gluteus Medius, Gluteus Minimus, Upper Gluteus Maximus
a6ab36ff-0cd9-47ce-9690-2b4056186015	varun.deoghare@gmail.com	Standing Cable Hip Abduction		2026-07-18 13:11:48.557266	2026-07-18 13:18:03.693151	98	LEGS	Gluteus Medius, Gluteus Minimus, Tensor Fasciae Latae
34c1dea2-5fbc-4c3e-bb7a-a7e629154d41	varun.deoghare@gmail.com	Machine Standing Hip Abduction		2026-07-18 13:11:48.579958	2026-07-18 13:18:03.693151	99	LEGS	Gluteus Medius, Gluteus Minimus, Upper Gluteus Maximus
d10cfbba-0ab6-4636-b4f7-9402bab6a1bb	varun.deoghare@gmail.com	Side-Lying Hip Abduction		2026-07-18 13:11:48.594616	2026-07-18 13:18:03.693151	100	LEGS	Gluteus Medius, Gluteus Minimus, Tensor Fasciae Latae
2e041b34-6bf0-4819-b1a4-7b5b40dc9f36	varun.deoghare@gmail.com	Banded Lateral Walk		2026-07-18 13:11:48.611348	2026-07-18 13:18:03.693151	101	LEGS	Gluteus Medius, Gluteus Minimus, Upper Gluteus Maximus
7cf62c2f-7e9b-4042-a1da-a3af6db85863	varun.deoghare@gmail.com	Monster Walk		2026-07-18 13:11:48.624041	2026-07-18 13:18:03.693151	102	LEGS	Gluteus Medius, Gluteus Minimus, Upper Gluteus Maximus
e12648dd-4bac-4b13-b51a-521f57152be0	varun.deoghare@gmail.com	Clamshell		2026-07-18 13:11:48.637427	2026-07-18 13:18:03.693151	103	LEGS	Gluteus Medius, Deep Hip External Rotators
5d82df1c-5e7b-475f-bf91-0102539e641d	varun.deoghare@gmail.com	Seated Hip Adduction		2026-07-18 13:11:48.652819	2026-07-18 13:18:03.693151	104	LEGS	Adductors
a75f028d-dadb-45f3-ab66-e5a5a5ec935e	varun.deoghare@gmail.com	Standing Cable Hip Adduction		2026-07-18 13:11:48.668027	2026-07-18 13:18:03.693151	105	LEGS	Adductors
6741e543-7c49-402f-b65e-faffe0b95092	varun.deoghare@gmail.com	Side-Lying Hip Adduction		2026-07-18 13:11:48.6831	2026-07-18 13:18:03.693151	106	LEGS	Adductors
dd198105-5f3f-47db-93a2-cdad342eddae	varun.deoghare@gmail.com	Copenhagen Plank		2026-07-18 13:11:48.698891	2026-07-18 13:18:03.693151	107	LEGS	Adductors (Isometric), Obliques
219e7287-9fe4-4da8-b618-6770f7f04de8	varun.deoghare@gmail.com	Wide-Stance Squat		2026-07-18 13:11:48.711787	2026-07-18 13:18:03.693151	108	LEGS	Adductors (Lengthened), Glutes, Quads
d2059fc7-8ccb-43a5-9c6e-390a92013239	varun.deoghare@gmail.com	Sumo Squat		2026-07-18 13:11:48.725642	2026-07-18 13:18:03.693151	109	LEGS	Adductors (Lengthened), Glutes, Quads
24cb0e5e-ce4c-4a7b-b42d-c83334e4543b	varun.deoghare@gmail.com	Standing Calf Raise		2026-07-18 13:11:48.739109	2026-07-18 13:18:03.693151	110	LEGS	Gastrocnemius (Lengthened), Soleus
22fd367f-019f-4c20-bff5-00419a68516d	varun.deoghare@gmail.com	Smith Machine Standing Calf Raise		2026-07-18 13:11:48.751617	2026-07-18 13:18:03.693151	111	LEGS	Gastrocnemius (Lengthened), Soleus
a5c2cdd2-72ac-4509-bb4b-a855a06e233c	varun.deoghare@gmail.com	Machine Standing Calf Raise		2026-07-18 13:11:48.765683	2026-07-18 13:18:03.693151	112	LEGS	Gastrocnemius (Lengthened), Soleus
abc90e04-499f-487a-8ccf-337eaad96215	varun.deoghare@gmail.com	Single-Leg Standing Calf Raise		2026-07-18 13:11:48.779598	2026-07-18 13:18:03.693151	113	LEGS	Gastrocnemius (Lengthened), Soleus
eb3afe27-70d2-4ed0-a6e8-24faefa8beb5	varun.deoghare@gmail.com	Donkey Calf Raise		2026-07-18 13:11:48.792407	2026-07-18 13:18:03.693151	114	LEGS	Gastrocnemius (Lengthened), Soleus
a6dfa57c-f838-435a-8486-f7fb3bbb97b1	varun.deoghare@gmail.com	Leg Press Calf Press		2026-07-18 13:11:48.806235	2026-07-18 13:18:03.693151	115	LEGS	Gastrocnemius (Lengthened), Soleus
7886f6dc-d601-42cc-ae2e-0c934562bbe6	varun.deoghare@gmail.com	Hack Squat Calf Raise		2026-07-18 13:11:48.817967	2026-07-18 13:18:03.693151	116	LEGS	Gastrocnemius (Lengthened), Soleus
68053308-be90-46f7-82c5-889b593c2b7c	varun.deoghare@gmail.com	Seated Calf Raise		2026-07-18 13:11:48.831662	2026-07-18 13:18:03.693151	117	LEGS	Soleus (Lengthened), Gastrocnemius
e8253ace-226e-4926-99df-9944046d4b45	varun.deoghare@gmail.com	Bent-Knee Calf Raise		2026-07-18 13:11:48.846393	2026-07-18 13:18:03.693151	118	LEGS	Soleus (Lengthened), Gastrocnemius
48017b53-febf-4253-a557-f5128a30b254	varun.deoghare@gmail.com	Bodyweight Calf Raise		2026-07-18 13:11:48.859156	2026-07-18 13:18:03.693151	119	LEGS	Gastrocnemius, Soleus
808167c4-7e2d-42c5-943c-dc270344794f	varun.deoghare@gmail.com	Tibialis Raise		2026-07-18 13:11:48.870421	2026-07-18 13:18:03.693151	120	LEGS	Tibialis Anterior (Shortened Emphasis)
a065ae90-32e0-422c-87c2-e02b7489af23	varun.deoghare@gmail.com	Machine Tibialis Raise		2026-07-18 13:11:48.883547	2026-07-18 13:18:03.693151	121	LEGS	Tibialis Anterior
02219830-4a27-45d8-a69d-f2bc6bf91ad1	varun.deoghare@gmail.com	Banded Dorsiflexion		2026-07-18 13:11:48.897799	2026-07-18 13:18:03.693151	122	LEGS	Tibialis Anterior
a0144d72-90a3-42aa-a11a-0edf217c4cf9	varun.deoghare@gmail.com	Heel Walk		2026-07-18 13:11:48.911485	2026-07-18 13:18:03.693151	123	LEGS	Tibialis Anterior
71aa09f1-e74a-48d3-8f24-1cd5e7fd6563	varun.deoghare@gmail.com	Toe Raise		2026-07-18 13:11:48.924378	2026-07-18 13:18:03.693151	124	LEGS	Tibialis Anterior
a5b4e8de-cba2-48fa-8922-7472ccbee8c7	varun.deoghare@gmail.com	Banded Ankle Inversion		2026-07-18 13:11:48.939813	2026-07-18 13:18:03.693151	125	LEGS	Tibialis Posterior, Tibialis Anterior
e6c24a00-2787-4927-95d2-5a79f39e66e1	varun.deoghare@gmail.com	Banded Ankle Eversion		2026-07-18 13:11:48.958474	2026-07-18 13:18:03.693151	126	LEGS	Fibularis (Peroneal) Muscles
fc8fa66f-e81f-4c8b-b810-9e4be2c185fc	varun.deoghare@gmail.com	Sled Push		2026-07-18 13:11:48.975249	2026-07-18 13:18:03.693151	127	LEGS	Quads, Glutes, Calves
51d48015-6e77-44ee-9cf0-cb3561dda3df	varun.deoghare@gmail.com	Forward Sled Drag		2026-07-18 13:11:48.991417	2026-07-18 13:18:03.693151	128	LEGS	Glutes, Hamstrings, Calves
c90bbdcf-5c66-4418-a32b-f101da823b4a	varun.deoghare@gmail.com	Backward Sled Drag		2026-07-18 13:11:49.008371	2026-07-18 13:18:03.693151	129	LEGS	Quads (Mid-Range), Calves
4bdb043f-a2af-473c-8dad-67afb46d43ee	varun.deoghare@gmail.com	Stair Climbing		2026-07-18 13:11:49.021459	2026-07-18 13:18:03.693151	130	LEGS	Quads, Glutes, Calves
fe61d7c9-ad6a-4706-a389-90b5adbbf109	varun.deoghare@gmail.com	Flat Barbell Bench Press		2026-07-18 13:12:47.104197	2026-07-18 13:18:03.693151	131	CHEST	Pecs (Middle - Lengthened to Mid-Range), Anterior Delts, Triceps
8afe3598-7e9f-49e5-9357-e871e7e9c5a9	varun.deoghare@gmail.com	Flat Dumbbell Bench Press		2026-07-18 13:12:47.119455	2026-07-18 13:18:03.693151	132	CHEST	Pecs (Middle - Lengthened to Mid-Range), Anterior Delts, Triceps
1e2305c2-ecf3-4949-b6f6-1b8d33d6db54	varun.deoghare@gmail.com	Flat Smith Machine Bench Press		2026-07-18 13:12:47.133349	2026-07-18 13:18:03.693151	133	CHEST	Pecs (Middle - Lengthened to Mid-Range), Anterior Delts, Triceps
407330d4-5127-4b95-8f9f-0f150ae2f293	varun.deoghare@gmail.com	Flat Machine Chest Press		2026-07-18 13:12:47.147631	2026-07-18 13:18:03.693151	134	CHEST	Pecs (Middle - Lengthened to Mid-Range), Anterior Delts, Triceps
15179bd8-35c9-4ca2-a055-99ce9f688478	varun.deoghare@gmail.com	Flat Plate-Loaded Chest Press		2026-07-18 13:12:47.16236	2026-07-18 13:18:03.693151	135	CHEST	Pecs (Middle - Lengthened to Mid-Range), Anterior Delts, Triceps
4453f194-1908-497c-8e01-72c73bb30cfc	varun.deoghare@gmail.com	Flat Cable Chest Press		2026-07-18 13:12:47.1736	2026-07-18 13:18:03.693151	136	CHEST	Pecs (Middle - Mid-to-Shortened), Anterior Delts, Triceps
61c8fc64-ff2d-45c9-9c05-4ee7658f7a5a	varun.deoghare@gmail.com	Single-Arm Cable Chest Press		2026-07-18 13:12:47.187651	2026-07-18 13:18:03.693151	137	CHEST	Pecs (Middle - Mid-to-Shortened), Anterior Delts, Triceps
d8356283-b7c6-4bd8-a728-ce15ef160263	varun.deoghare@gmail.com	Single-Arm Machine Chest Press		2026-07-18 13:12:47.200814	2026-07-18 13:18:03.693151	138	CHEST	Pecs (Middle - Lengthened to Shortened), Anterior Delts, Triceps
2fbc7f48-24a2-460c-b39e-c266cbe51a5c	varun.deoghare@gmail.com	Alternating Dumbbell Bench Press		2026-07-18 13:12:47.214337	2026-07-18 13:18:03.693151	139	CHEST	Pecs (Middle), Anterior Delts, Triceps
b109b8fe-208e-4774-a3a3-17b76dceb5ff	varun.deoghare@gmail.com	Dumbbell Squeeze Press		2026-07-18 13:12:47.226366	2026-07-18 13:18:03.693151	140	CHEST	Pecs (Middle - Shortened/Isometric Emphasis), Anterior Delts, Triceps
3bf60d1e-3920-4b74-9191-ca8fc26e008f	varun.deoghare@gmail.com	Hex Press		2026-07-18 13:12:47.238233	2026-07-18 13:18:03.693151	141	CHEST	Pecs (Middle - Shortened/Isometric Emphasis), Anterior Delts, Triceps
d9cbd911-a5b0-43b9-9a82-38cd1a1980dd	varun.deoghare@gmail.com	Floor Barbell Press		2026-07-18 13:12:47.248574	2026-07-18 13:18:03.693151	142	CHEST	Pecs (Middle - Mid-to-Shortened), Anterior Delts, Triceps
99184879-2ee9-49b8-9cd7-4e173ce2e156	varun.deoghare@gmail.com	Floor Dumbbell Press		2026-07-18 13:12:47.261093	2026-07-18 13:18:03.693151	143	CHEST	Pecs (Middle - Mid-to-Shortened), Anterior Delts, Triceps
8f2bf582-d162-461a-86f5-e337b7537789	varun.deoghare@gmail.com	Wide-Grip Barbell Bench Press		2026-07-18 13:12:47.272661	2026-07-18 13:18:03.693151	144	CHEST	Pecs (Middle - Lengthened), Anterior Delts, Triceps
fb7a816d-30e5-47c6-a15a-0a0507ccc707	varun.deoghare@gmail.com	Reverse-Grip Barbell Bench Press		2026-07-18 13:12:47.28583	2026-07-18 13:18:03.693151	145	CHEST	Pecs (Upper), Anterior Delts, Triceps
78885789-3b72-4046-bf0e-a47239363ed6	varun.deoghare@gmail.com	Guillotine Press		2026-07-18 13:12:47.29767	2026-07-18 13:18:03.693151	146	CHEST	Pecs (Upper/Middle - Lengthened), Anterior Delts, Triceps
f9ddba93-761b-4521-9026-fc01a90929bc	varun.deoghare@gmail.com	30-Degree Incline Barbell Press		2026-07-18 13:12:47.308582	2026-07-18 13:18:03.693151	147	CHEST	Pecs (Upper - Lengthened to Mid-Range), Anterior Delts, Triceps
1d8303c7-191e-4564-a30c-24c6f13bd515	varun.deoghare@gmail.com	30-Degree Incline Dumbbell Press		2026-07-18 13:12:47.320756	2026-07-18 13:18:03.693151	148	CHEST	Pecs (Upper - Lengthened to Mid-Range), Anterior Delts, Triceps
3bb98ddb-7cfd-4af9-bee1-859cf30a482f	varun.deoghare@gmail.com	30-Degree Incline Smith Machine Press		2026-07-18 13:12:47.332341	2026-07-18 13:18:03.693151	149	CHEST	Pecs (Upper - Lengthened to Mid-Range), Anterior Delts, Triceps
764fd767-7cfc-4519-9f50-6ca76c6218b5	varun.deoghare@gmail.com	30-Degree Incline Machine Chest Press		2026-07-18 13:12:47.345389	2026-07-18 13:18:03.693151	150	CHEST	Pecs (Upper - Lengthened to Mid-Range), Anterior Delts, Triceps
7adcdcfa-420e-40b5-b87e-bf20087670b3	varun.deoghare@gmail.com	45-Degree Incline Barbell Press		2026-07-18 13:12:47.359249	2026-07-18 13:18:03.693151	151	CHEST	Pecs (Upper), Anterior Delts, Triceps
35306156-cacb-4a5f-9470-fa92d7e0b380	varun.deoghare@gmail.com	45-Degree Incline Dumbbell Press		2026-07-18 13:12:47.370128	2026-07-18 13:18:03.693151	152	CHEST	Pecs (Upper), Anterior Delts, Triceps
94230fab-e730-4a3e-b315-bb7643457fe6	varun.deoghare@gmail.com	45-Degree Incline Smith Machine Press		2026-07-18 13:12:47.380949	2026-07-18 13:18:03.693151	153	CHEST	Pecs (Upper), Anterior Delts, Triceps
f5e12145-c709-4c22-a17e-bf20a278c317	varun.deoghare@gmail.com	Incline Plate-Loaded Chest Press		2026-07-18 13:12:47.39237	2026-07-18 13:18:03.693151	154	CHEST	Pecs (Upper - Lengthened to Mid-Range), Anterior Delts, Triceps
f6d03b48-ef6c-40bc-b0e6-e8687becf2a8	varun.deoghare@gmail.com	Incline Cable Chest Press		2026-07-18 13:12:47.410113	2026-07-18 13:18:03.693151	155	CHEST	Pecs (Upper - Mid-to-Shortened), Anterior Delts, Triceps
1a5ddae1-01e8-475a-8d8f-d68504b08428	varun.deoghare@gmail.com	Single-Arm Incline Cable Chest Press		2026-07-18 13:12:47.422376	2026-07-18 13:18:03.693151	156	CHEST	Pecs (Upper - Mid-to-Shortened), Anterior Delts, Triceps
127bdaa8-717e-4bb8-9773-6282905db253	varun.deoghare@gmail.com	Incline Dumbbell Squeeze Press		2026-07-18 13:12:47.435305	2026-07-18 13:18:03.693151	157	CHEST	Pecs (Upper - Shortened/Isometric Emphasis), Anterior Delts, Triceps
aef3b117-6215-48fc-9df1-b309a0966464	varun.deoghare@gmail.com	Low-Incline Dumbbell Press		2026-07-18 13:12:47.446863	2026-07-18 13:18:03.693151	158	CHEST	Pecs (Upper - Lengthened to Mid-Range), Anterior Delts, Triceps
3ab47165-ed89-44f3-ac31-e612c6af3b8b	varun.deoghare@gmail.com	Low-Incline Smith Machine Press		2026-07-18 13:12:47.460491	2026-07-18 13:18:03.693151	159	CHEST	Pecs (Upper - Lengthened to Mid-Range), Anterior Delts, Triceps
ab8d69a0-dea7-4459-957e-ef2b95b2c8b1	varun.deoghare@gmail.com	Decline Barbell Bench Press		2026-07-18 13:12:47.472661	2026-07-18 13:18:03.693151	160	CHEST	Pecs (Middle/Lower - Lengthened to Mid-Range), Anterior Delts, Triceps
e0ca730b-d70f-44fb-a97d-e4252fcdb92f	varun.deoghare@gmail.com	Decline Dumbbell Bench Press		2026-07-18 13:12:47.484725	2026-07-18 13:18:03.693151	161	CHEST	Pecs (Middle/Lower - Lengthened to Mid-Range), Anterior Delts, Triceps
090ef089-04f7-420f-b66a-a52a8b19660f	varun.deoghare@gmail.com	Decline Smith Machine Press		2026-07-18 13:12:47.49666	2026-07-18 13:18:03.693151	162	CHEST	Pecs (Middle/Lower - Lengthened to Mid-Range), Anterior Delts, Triceps
2d46f28d-fcaf-4864-bcb1-f01f44b0d688	varun.deoghare@gmail.com	Decline Machine Chest Press		2026-07-18 13:12:47.509603	2026-07-18 13:18:03.693151	163	CHEST	Pecs (Middle/Lower - Lengthened to Mid-Range), Anterior Delts, Triceps
90827b2c-36ac-46f7-9605-d3d6bfd37eea	varun.deoghare@gmail.com	Decline Cable Chest Press		2026-07-18 13:12:47.522199	2026-07-18 13:18:03.693151	164	CHEST	Pecs (Middle/Lower - Mid-to-Shortened), Anterior Delts, Triceps
f6f66bfc-f1be-4f59-84a3-9a3243c20f5d	varun.deoghare@gmail.com	High-to-Low Cable Chest Press		2026-07-18 13:12:47.535537	2026-07-18 13:18:03.693151	165	CHEST	Pecs (Middle/Lower - Mid-to-Shortened), Anterior Delts, Triceps
4e7446af-1646-43fd-ba72-54ce576fa214	varun.deoghare@gmail.com	Single-Arm High-to-Low Cable Chest Press		2026-07-18 13:12:47.54765	2026-07-18 13:18:03.693151	166	CHEST	Pecs (Middle/Lower - Mid-to-Shortened), Anterior Delts, Triceps
80b2f88c-c5b0-433f-941f-17d59157d14d	varun.deoghare@gmail.com	Seated Converging Chest Press		2026-07-18 13:12:47.560485	2026-07-18 13:18:03.693151	167	CHEST	Pecs (Middle - Lengthened to Shortened), Anterior Delts, Triceps
f77ab56f-ecbc-44ed-982c-ec81f2927a5a	varun.deoghare@gmail.com	Iso-Lateral Chest Press		2026-07-18 13:12:47.572045	2026-07-18 13:18:03.693151	168	CHEST	Pecs (Middle - Lengthened to Shortened), Anterior Delts, Triceps
d9dae23a-16f2-44e0-a17e-fac553691ac2	varun.deoghare@gmail.com	Standing Cable Chest Press		2026-07-18 13:12:47.584588	2026-07-18 13:18:03.693151	169	CHEST	Pecs (Middle - Mid-to-Shortened), Anterior Delts, Triceps
ed936b52-8cdf-4e65-82f8-b4d323b7b64c	varun.deoghare@gmail.com	Half-Kneeling Single-Arm Cable Press		2026-07-18 13:12:47.595452	2026-07-18 13:18:03.693151	170	CHEST	Pecs (Middle - Mid-to-Shortened), Anterior Delts, Triceps
10279e6c-bdb4-46a7-853e-7a8f1aa9a55f	varun.deoghare@gmail.com	Flat Dumbbell Fly		2026-07-18 13:12:47.606199	2026-07-18 13:18:03.693151	171	CHEST	Pecs (Middle - Lengthened Emphasis), Anterior Delts
04e8236f-a36e-47e0-b660-c48caa369a94	varun.deoghare@gmail.com	Incline Dumbbell Fly		2026-07-18 13:12:47.616472	2026-07-18 13:18:03.693151	172	CHEST	Pecs (Upper - Lengthened Emphasis), Anterior Delts
cafc23b0-0b13-4071-bc65-f359b6d9a152	varun.deoghare@gmail.com	Decline Dumbbell Fly		2026-07-18 13:12:47.627978	2026-07-18 13:18:03.693151	173	CHEST	Pecs (Middle/Lower - Lengthened Emphasis), Anterior Delts
dad853e1-f9b4-4120-a86f-169654e0ab4e	varun.deoghare@gmail.com	Flat Cable Fly		2026-07-18 13:12:47.638929	2026-07-18 13:18:03.693151	174	CHEST	Pecs (Middle - Lengthened to Shortened), Anterior Delts
3a541bea-bc87-45a6-ab7c-d26cbe25bc24	varun.deoghare@gmail.com	Standing Cable Fly		2026-07-18 13:12:47.649055	2026-07-18 13:18:03.693151	175	CHEST	Pecs (Middle - Lengthened to Shortened), Anterior Delts
18c38e8a-d2b3-4e99-90e5-a2e86ddbc1b0	varun.deoghare@gmail.com	Lying Cable Fly		2026-07-18 13:12:47.661624	2026-07-18 13:18:03.693151	176	CHEST	Pecs (Middle - Lengthened to Shortened), Anterior Delts
b455e02b-5cda-4381-a054-29077caf01b7	varun.deoghare@gmail.com	Single-Arm Cable Fly		2026-07-18 13:12:47.676099	2026-07-18 13:18:03.693151	177	CHEST	Pecs (Middle - Lengthened to Shortened), Anterior Delts
1ac953ee-7ffe-4e94-aaa6-1c8828a5057c	varun.deoghare@gmail.com	Cross-Body Single-Arm Cable Fly		2026-07-18 13:12:47.686205	2026-07-18 13:18:03.693151	178	CHEST	Pecs (Middle - Shortened Emphasis), Anterior Delts
3ba39a55-c98b-4a9b-a49e-2f3ad981fb4f	varun.deoghare@gmail.com	Mid-to-Mid Cable Fly		2026-07-18 13:12:47.694823	2026-07-18 13:18:03.693151	179	CHEST	Pecs (Middle - Lengthened to Shortened), Anterior Delts
2eac6c96-580f-4e57-9121-f4942bbf843f	varun.deoghare@gmail.com	Low-to-High Cable Fly		2026-07-18 13:12:47.706193	2026-07-18 13:18:03.693151	180	CHEST	Pecs (Upper - Lengthened to Shortened), Anterior Delts
3318716e-d1a9-4122-b993-ad9526c6c955	varun.deoghare@gmail.com	Single-Arm Low-to-High Cable Fly		2026-07-18 13:12:47.715363	2026-07-18 13:18:03.693151	181	CHEST	Pecs (Upper - Lengthened to Shortened), Anterior Delts
62e2c9d4-d596-4ed2-b50f-debd2bd5b560	varun.deoghare@gmail.com	High-to-Low Cable Fly		2026-07-18 13:12:47.727091	2026-07-18 13:18:03.693151	182	CHEST	Pecs (Middle/Lower - Lengthened to Shortened), Anterior Delts
ec0dcabd-de17-4d6c-a86a-587031eed436	varun.deoghare@gmail.com	Single-Arm High-to-Low Cable Fly		2026-07-18 13:12:47.737594	2026-07-18 13:18:03.693151	183	CHEST	Pecs (Middle/Lower - Lengthened to Shortened), Anterior Delts
de8f8677-18bf-46cf-a610-0a5da93198b9	varun.deoghare@gmail.com	Incline-Bench Cable Fly		2026-07-18 13:12:47.749178	2026-07-18 13:18:03.693151	184	CHEST	Pecs (Upper - Lengthened to Shortened), Anterior Delts
327ff204-a21f-4fcc-a946-7e813165e5e9	varun.deoghare@gmail.com	Decline-Bench Cable Fly		2026-07-18 13:12:47.76082	2026-07-18 13:18:03.693151	185	CHEST	Pecs (Middle/Lower - Lengthened to Shortened), Anterior Delts
3088f2ec-abce-4582-a61a-8ef1fc405ee9	varun.deoghare@gmail.com	Pec Deck Fly		2026-07-18 13:12:47.772645	2026-07-18 13:18:03.693151	186	CHEST	Pecs (Middle - Lengthened to Shortened), Anterior Delts
de32f78a-22a8-41a5-850f-61b7278dee7c	varun.deoghare@gmail.com	Single-Arm Pec Deck Fly		2026-07-18 13:12:47.783356	2026-07-18 13:18:03.693151	187	CHEST	Pecs (Middle - Lengthened to Shortened), Anterior Delts
a4b1dc2a-35ed-4e36-821c-98f40dd89bef	varun.deoghare@gmail.com	Machine Chest Fly		2026-07-18 13:12:47.793147	2026-07-18 13:18:03.693151	188	CHEST	Pecs (Middle - Lengthened to Shortened), Anterior Delts
8082fadf-3fb9-49d4-8e9f-869b4dacb6ea	varun.deoghare@gmail.com	Resistance-Band Chest Fly		2026-07-18 13:12:47.806789	2026-07-18 13:18:03.693151	189	CHEST	Pecs (Middle - Shortened Emphasis), Anterior Delts
e636e300-c40d-4956-8c17-1274ee913b46	varun.deoghare@gmail.com	Resistance-Band Low-to-High Fly		2026-07-18 13:12:47.818326	2026-07-18 13:18:03.693151	190	CHEST	Pecs (Upper - Shortened Emphasis), Anterior Delts
4a553acc-7474-49a3-a43a-a008a36e6407	varun.deoghare@gmail.com	Resistance-Band High-to-Low Fly		2026-07-18 13:12:47.829836	2026-07-18 13:18:03.693151	191	CHEST	Pecs (Middle/Lower - Shortened Emphasis), Anterior Delts
795c666f-9cb8-4131-a675-60a740b38a7d	varun.deoghare@gmail.com	Standard Push-Up		2026-07-18 13:12:47.844274	2026-07-18 13:18:03.693151	192	CHEST	Pecs (Middle), Anterior Delts, Triceps
4dce98ef-42db-49fd-b21a-a3373459cdcf	varun.deoghare@gmail.com	Wide-Grip Push-Up		2026-07-18 13:12:47.858066	2026-07-18 13:18:03.693151	193	CHEST	Pecs (Middle), Anterior Delts, Triceps
8b76c331-019c-4e2d-bad5-4d42838fdd50	varun.deoghare@gmail.com	Incline Push-Up		2026-07-18 13:12:47.870587	2026-07-18 13:18:03.693151	194	CHEST	Pecs (Middle/Lower), Anterior Delts, Triceps
4259011d-d07e-4baa-9e96-43a28cb89ce6	varun.deoghare@gmail.com	Decline Push-Up		2026-07-18 13:12:47.882598	2026-07-18 13:18:03.693151	195	CHEST	Pecs (Upper), Anterior Delts, Triceps
94e179f2-eae7-4f6c-b50c-c4c6e3721e4a	varun.deoghare@gmail.com	Deficit Push-Up		2026-07-18 13:12:47.902146	2026-07-18 13:18:03.693151	196	CHEST	Pecs (Middle - Lengthened Emphasis), Anterior Delts, Triceps
4c238fac-ced4-4360-b9e1-7ffca3e847db	varun.deoghare@gmail.com	Deep Push-Up on Handles		2026-07-18 13:12:47.912371	2026-07-18 13:18:03.693151	197	CHEST	Pecs (Middle - Lengthened Emphasis), Anterior Delts, Triceps
d593036d-6530-4e38-9ddc-b651e4978c84	varun.deoghare@gmail.com	Weighted Push-Up		2026-07-18 13:12:47.926616	2026-07-18 13:18:03.693151	198	CHEST	Pecs (Middle), Anterior Delts, Triceps
c53b2526-f5b5-4789-bea7-84aad38e93a8	varun.deoghare@gmail.com	Banded Push-Up		2026-07-18 13:12:47.937908	2026-07-18 13:18:03.693151	199	CHEST	Pecs (Middle - Mid-to-Shortened), Anterior Delts, Triceps
717fd0f0-e81d-48e4-9131-d8eda91b1119	varun.deoghare@gmail.com	Ring Push-Up		2026-07-18 13:12:47.949748	2026-07-18 13:18:03.693151	200	CHEST	Pecs (Lengthened to Shortened), Anterior Delts, Triceps
ed5bf346-079c-4977-b903-89bc052f53ad	varun.deoghare@gmail.com	Suspension-Trainer Chest Press		2026-07-18 13:12:47.961256	2026-07-18 13:18:03.693151	201	CHEST	Pecs (Lengthened to Shortened), Anterior Delts, Triceps
77c59119-5e96-44b4-8e7d-acfc4aa1abd2	varun.deoghare@gmail.com	Archer Push-Up		2026-07-18 13:12:47.971975	2026-07-18 13:18:03.693151	202	CHEST	Pecs (Lengthened Emphasis on Working Side), Anterior Delts, Triceps
7dd5e247-695d-4417-a5d5-8510f464c1c0	varun.deoghare@gmail.com	Staggered Push-Up		2026-07-18 13:12:47.983849	2026-07-18 13:18:03.693151	203	CHEST	Pecs, Anterior Delts, Triceps
c356e049-d8dd-4178-bdd0-845eaf7c810f	varun.deoghare@gmail.com	Medicine-Ball Push-Up		2026-07-18 13:12:47.995786	2026-07-18 13:18:03.693151	204	CHEST	Pecs, Anterior Delts, Triceps
a32ea51a-10f3-46ec-882c-9d2c67b12d4d	varun.deoghare@gmail.com	Plyometric Push-Up		2026-07-18 13:12:48.007586	2026-07-18 13:18:03.693151	205	CHEST	Pecs, Anterior Delts, Triceps
43e482e9-6ed9-4829-a8df-bf9d0826fda5	varun.deoghare@gmail.com	Clap Push-Up		2026-07-18 13:12:48.021276	2026-07-18 13:18:03.693151	206	CHEST	Pecs, Anterior Delts, Triceps
257d89dc-5d30-458c-9e47-a81c31c3e703	varun.deoghare@gmail.com	Assisted Chest Dip		2026-07-18 13:12:48.029967	2026-07-18 13:18:03.693151	207	CHEST	Pecs (Middle/Lower - Lengthened), Anterior Delts, Triceps
2d6b94f8-7199-47db-a90f-5c70e7d351fa	varun.deoghare@gmail.com	Bodyweight Chest Dip		2026-07-18 13:12:48.040359	2026-07-18 13:18:03.693151	208	CHEST	Pecs (Middle/Lower - Lengthened), Anterior Delts, Triceps
db71cc3d-39b6-4614-8f1f-03dadc6eccde	varun.deoghare@gmail.com	Weighted Chest Dip		2026-07-18 13:12:48.050055	2026-07-18 13:18:03.693151	209	CHEST	Pecs (Middle/Lower - Lengthened), Anterior Delts, Triceps
4924dfb7-ad6e-4d3d-972c-f5ae9a967c55	varun.deoghare@gmail.com	Machine Chest Dip		2026-07-18 13:12:48.06017	2026-07-18 13:18:03.693151	210	CHEST	Pecs (Middle/Lower), Anterior Delts, Triceps
756dcf3a-b825-421d-9daf-6c219d2359d1	varun.deoghare@gmail.com	Bench Cable Chest Dip		2026-07-18 13:12:48.071255	2026-07-18 13:18:03.693151	211	CHEST	Pecs (Middle/Lower - Mid-to-Shortened), Anterior Delts, Triceps
2a6943fd-1258-408f-a62f-292d2173d794	varun.deoghare@gmail.com	Svend Press		2026-07-18 13:12:48.087421	2026-07-18 13:18:03.693151	212	CHEST	Pecs (Shortened/Isometric Emphasis), Anterior Delts, Triceps
8aa49e90-cb71-4848-8c1a-d0106405fe29	varun.deoghare@gmail.com	Plate Pinch Press		2026-07-18 13:12:48.100045	2026-07-18 13:18:03.693151	213	CHEST	Pecs (Shortened/Isometric Emphasis), Anterior Delts, Triceps
5a81a24a-b2b9-46a1-8076-66432d40f2e6	varun.deoghare@gmail.com	Standing Cable Svend Press		2026-07-18 13:12:48.111275	2026-07-18 13:18:03.693151	214	CHEST	Pecs (Shortened Emphasis), Anterior Delts, Triceps
055442e1-1736-4184-966f-be3dcb8d1029	varun.deoghare@gmail.com	Isometric Chest Squeeze		2026-07-18 13:12:48.122415	2026-07-18 13:18:03.693151	215	CHEST	Pecs (Shortened Isometric)
42eb90f8-c86e-40e4-990e-26aa2d4ceb08	varun.deoghare@gmail.com	Isometric Push-Up Hold		2026-07-18 13:12:48.132587	2026-07-18 13:18:03.693151	216	CHEST	Pecs (Isometric), Anterior Delts, Triceps
a07d7915-6e05-4fc3-91cf-de43549f4607	varun.deoghare@gmail.com	Push-Up Plus		2026-07-18 13:12:48.143386	2026-07-18 13:18:03.693151	217	CHEST	Pecs, Anterior Delts, Triceps, Serratus Anterior
c43464ca-e430-43a8-8f0c-5abf6962dd6a	varun.deoghare@gmail.com	Standing Barbell Overhead Press		2026-07-18 13:15:50.786079	2026-07-18 13:18:03.693151	218	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps, Serratus Anterior
fd81179a-b12b-4f32-8f06-44965cde0071	varun.deoghare@gmail.com	Seated Barbell Overhead Press		2026-07-18 13:15:50.80098	2026-07-18 13:18:03.693151	219	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps
703d6193-596f-4be9-b276-5f5d1ca26d99	varun.deoghare@gmail.com	Standing Dumbbell Shoulder Press		2026-07-18 13:15:50.814982	2026-07-18 13:18:03.693151	220	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps
7d49e457-7524-46b8-84f5-3f615cade1f4	varun.deoghare@gmail.com	Seated Dumbbell Shoulder Press		2026-07-18 13:15:50.82793	2026-07-18 13:18:03.693151	221	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps
37c620cf-8630-486f-92e9-8e68c6fbed85	varun.deoghare@gmail.com	Neutral-Grip Dumbbell Shoulder Press		2026-07-18 13:15:50.838395	2026-07-18 13:18:03.693151	222	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
619f5ac3-b893-4667-a873-35d4485a6e94	varun.deoghare@gmail.com	Single-Arm Dumbbell Shoulder Press		2026-07-18 13:15:50.849952	2026-07-18 13:18:03.693151	223	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps
29faca6c-1df7-4800-92dd-fe14ea1c9053	varun.deoghare@gmail.com	Alternating Dumbbell Shoulder Press		2026-07-18 13:15:50.863315	2026-07-18 13:18:03.693151	224	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
2ceb1fb3-3a81-488a-a8e5-fe08e52a0081	varun.deoghare@gmail.com	Arnold Press		2026-07-18 13:15:50.876186	2026-07-18 13:18:03.693151	225	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
62e42edd-28e4-4860-8c39-09c8e5ee102e	varun.deoghare@gmail.com	Smith Machine Shoulder Press		2026-07-18 13:15:50.888748	2026-07-18 13:18:03.693151	226	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
52999ce3-3356-4ca1-8a47-77922a21f67f	varun.deoghare@gmail.com	Behind-the-Neck Barbell Press		2026-07-18 13:15:50.903087	2026-07-18 13:18:03.693151	227	SHOULDERS	Lateral Delts, Anterior Delts, Triceps, Upper Traps
d4398eb6-b702-450f-9a0b-5476f72b887e	varun.deoghare@gmail.com	Machine Shoulder Press		2026-07-18 13:15:50.916047	2026-07-18 13:18:03.693151	228	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
22bd1102-d0ff-452b-9b7c-db4098e12540	varun.deoghare@gmail.com	Neutral-Grip Machine Shoulder Press		2026-07-18 13:15:50.931571	2026-07-18 13:18:03.693151	229	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
885661f2-7d04-401b-9af6-d2d668536aed	varun.deoghare@gmail.com	Plate-Loaded Shoulder Press		2026-07-18 13:15:50.946318	2026-07-18 13:18:03.693151	230	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
185d374e-7d0b-4785-9e23-0d09529b9ca8	varun.deoghare@gmail.com	Iso-Lateral Machine Shoulder Press		2026-07-18 13:15:50.960292	2026-07-18 13:18:03.693151	231	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
26b908c4-ce2d-41cb-88f5-4eae92f0b297	varun.deoghare@gmail.com	Single-Arm Machine Shoulder Press		2026-07-18 13:15:50.973423	2026-07-18 13:18:03.693151	232	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
585698d7-e7f2-4fc7-80e5-67e0cf55a87b	varun.deoghare@gmail.com	Standing Cable Shoulder Press		2026-07-18 13:15:50.987972	2026-07-18 13:18:03.693151	233	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
29f1fa81-1dce-4236-9196-8e234c2abc93	varun.deoghare@gmail.com	Seated Cable Shoulder Press		2026-07-18 13:15:51.002758	2026-07-18 13:18:03.693151	234	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
c6f68387-7b7d-469c-946c-6787bd249ff7	varun.deoghare@gmail.com	Single-Arm Cable Shoulder Press		2026-07-18 13:15:51.016926	2026-07-18 13:18:03.693151	235	SHOULDERS	Anterior Delts, Lateral Delts, Triceps
32a2086b-7488-4612-9465-184bad211769	varun.deoghare@gmail.com	Landmine Press		2026-07-18 13:15:51.033021	2026-07-18 13:18:03.693151	236	SHOULDERS	Anterior Delts, Upper Pecs, Triceps, Serratus Anterior
4ffb7c01-e17c-48fd-bcee-891e103410c4	varun.deoghare@gmail.com	Half-Kneeling Single-Arm Landmine Press		2026-07-18 13:15:51.046495	2026-07-18 13:18:03.693151	237	SHOULDERS	Anterior Delts, Upper Pecs, Triceps, Serratus Anterior
e5b8d250-0c31-49c9-9e4c-143f1147b730	varun.deoghare@gmail.com	Standing Single-Arm Landmine Press		2026-07-18 13:15:51.05852	2026-07-18 13:18:03.693151	238	SHOULDERS	Anterior Delts, Upper Pecs, Triceps, Serratus Anterior
b9d956cb-94f9-4b83-9255-99d8b651215f	varun.deoghare@gmail.com	Viking Press		2026-07-18 13:15:51.072772	2026-07-18 13:18:03.693151	239	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps
646a78b4-813e-48bc-8abd-7d3ed22e9b1a	varun.deoghare@gmail.com	Push Press		2026-07-18 13:15:51.083872	2026-07-18 13:18:03.693151	240	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps, Quads, Glutes
f53dade4-71ba-4681-9fe0-710816186519	varun.deoghare@gmail.com	Bradford Press		2026-07-18 13:15:51.100475	2026-07-18 13:18:03.693151	241	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps
84295475-742e-400b-aa3e-5710e327c2e2	varun.deoghare@gmail.com	Z-Press		2026-07-18 13:15:51.180954	2026-07-18 13:18:03.693151	242	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps
bf0f229e-e360-4c28-b33e-e377ddfae960	varun.deoghare@gmail.com	Pike Push-Up		2026-07-18 13:15:51.193919	2026-07-18 13:18:03.693151	243	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps
1148d299-ddcc-4b2e-90f8-d6228c6826d3	varun.deoghare@gmail.com	Feet-Elevated Pike Push-Up		2026-07-18 13:15:51.204923	2026-07-18 13:18:03.693151	244	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps
6f2634fc-3aca-4771-8539-ffcb02704433	varun.deoghare@gmail.com	Handstand Push-Up		2026-07-18 13:15:51.21844	2026-07-18 13:18:03.693151	245	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps
d7bb0950-9158-42ed-b70c-a5065ad510ac	varun.deoghare@gmail.com	Assisted Handstand Push-Up		2026-07-18 13:15:51.232271	2026-07-18 13:18:03.693151	246	SHOULDERS	Anterior Delts, Lateral Delts, Triceps, Upper Traps
42f5509d-2ad3-4baf-8f93-191e8b8e5616	varun.deoghare@gmail.com	Dumbbell Lateral Raise		2026-07-18 13:15:51.245483	2026-07-18 13:18:03.693151	247	SHOULDERS	Lateral Delts (Mid-to-Shortened Emphasis), Supraspinatus, Upper Traps
c73f75ca-61b2-4a84-94b5-fbc61c2b9d80	varun.deoghare@gmail.com	Seated Dumbbell Lateral Raise		2026-07-18 13:15:51.25629	2026-07-18 13:18:03.693151	248	SHOULDERS	Lateral Delts (Mid-to-Shortened Emphasis), Supraspinatus, Upper Traps
0811c4af-0fb1-4b75-8f97-136fb7f750df	varun.deoghare@gmail.com	Single-Arm Dumbbell Lateral Raise		2026-07-18 13:15:51.268721	2026-07-18 13:18:03.693151	249	SHOULDERS	Lateral Delts (Mid-to-Shortened Emphasis), Supraspinatus, Upper Traps
dd8afef4-700d-4aff-bb75-d122a73b290d	varun.deoghare@gmail.com	Standing Cable Lateral Raise		2026-07-18 13:15:51.280899	2026-07-18 13:18:03.693151	250	SHOULDERS	Lateral Delts (Lengthened to Shortened), Supraspinatus
8fbca57c-3658-4246-a465-44b5953fb333	varun.deoghare@gmail.com	Single-Arm Cable Lateral Raise		2026-07-18 13:15:51.292475	2026-07-18 13:18:03.693151	251	SHOULDERS	Lateral Delts (Lengthened to Shortened), Supraspinatus
155b7fba-3130-4ebd-a1e3-6db360f7b368	varun.deoghare@gmail.com	Behind-the-Body Cable Lateral Raise		2026-07-18 13:15:51.30341	2026-07-18 13:18:03.693151	252	SHOULDERS	Lateral Delts (Lengthened Emphasis), Supraspinatus
747a41f9-101f-4e50-8eeb-967fcf4fbbac	varun.deoghare@gmail.com	Cross-Body Cable Lateral Raise		2026-07-18 13:15:51.314812	2026-07-18 13:18:03.693151	253	SHOULDERS	Lateral Delts (Lengthened Emphasis), Supraspinatus
97f586e8-36dc-4a96-a4b8-aa5ee0a7a57a	varun.deoghare@gmail.com	Cuff Cable Lateral Raise		2026-07-18 13:15:51.324087	2026-07-18 13:18:03.693151	254	SHOULDERS	Lateral Delts (Lengthened to Shortened), Supraspinatus
dc1a980e-ea32-4f54-98ff-67d34aa176b8	varun.deoghare@gmail.com	Seated Cable Lateral Raise		2026-07-18 13:15:51.334471	2026-07-18 13:18:03.693151	255	SHOULDERS	Lateral Delts (Lengthened to Shortened), Supraspinatus
cf0d1745-8504-477d-8113-09a79cbec944	varun.deoghare@gmail.com	Leaning-Away Cable Lateral Raise		2026-07-18 13:15:51.345347	2026-07-18 13:18:03.693151	256	SHOULDERS	Lateral Delts (Mid-to-Shortened Emphasis), Supraspinatus
b7622926-7f0b-4649-b654-40848b758368	varun.deoghare@gmail.com	Lying Cable Lateral Raise		2026-07-18 13:15:51.356019	2026-07-18 13:18:03.693151	257	SHOULDERS	Lateral Delts (Lengthened Emphasis), Supraspinatus
17b8516f-f8df-4b0f-8e88-bc24fe0d4159	varun.deoghare@gmail.com	Incline-Bench Dumbbell Lateral Raise		2026-07-18 13:15:51.368832	2026-07-18 13:18:03.693151	258	SHOULDERS	Lateral Delts (Lengthened Emphasis), Supraspinatus
29119745-8b76-4c9a-9592-2836b0d26215	varun.deoghare@gmail.com	Side-Lying Dumbbell Lateral Raise		2026-07-18 13:15:51.379418	2026-07-18 13:18:03.693151	259	SHOULDERS	Lateral Delts (Lengthened to Mid-Range), Supraspinatus
5f535a9e-6510-41fd-889a-04bae10facd5	varun.deoghare@gmail.com	Machine Lateral Raise		2026-07-18 13:15:51.390967	2026-07-18 13:18:03.693151	260	SHOULDERS	Lateral Delts, Supraspinatus
ed447da6-63ea-4090-b826-d47b6e123a25	varun.deoghare@gmail.com	Single-Arm Machine Lateral Raise		2026-07-18 13:15:51.400807	2026-07-18 13:18:03.693151	261	SHOULDERS	Lateral Delts, Supraspinatus
d652fc0f-4d90-4947-abc9-b4dc8a30d48b	varun.deoghare@gmail.com	Plate Lateral Raise		2026-07-18 13:15:51.411605	2026-07-18 13:18:03.693151	262	SHOULDERS	Lateral Delts (Mid-to-Shortened Emphasis), Supraspinatus, Upper Traps
8f8f677e-521e-4d68-a7cf-11a5d14c6473	varun.deoghare@gmail.com	Resistance-Band Lateral Raise		2026-07-18 13:15:51.420277	2026-07-18 13:18:03.693151	263	SHOULDERS	Lateral Delts (Shortened Emphasis), Supraspinatus
6512fb86-f4ea-4524-9aa3-800d8a34d1c6	varun.deoghare@gmail.com	Partial-Range Lateral Raise		2026-07-18 13:15:51.433957	2026-07-18 13:18:03.693151	264	SHOULDERS	Lateral Delts (Range Dependent), Supraspinatus
e64ff8d1-9e54-467a-bd4b-df292d10db39	varun.deoghare@gmail.com	Lateral Raise Hold		2026-07-18 13:15:51.445953	2026-07-18 13:18:03.693151	265	SHOULDERS	Lateral Delts (Isometric), Supraspinatus, Upper Traps
2d7f64ca-2e47-4226-b817-2a67423c8a94	varun.deoghare@gmail.com	Dumbbell Front Raise		2026-07-18 13:15:51.455663	2026-07-18 13:18:03.693151	266	SHOULDERS	Anterior Delts, Upper Pecs, Serratus Anterior
0b06783b-e3f3-49b4-bbf0-abf60a11799a	varun.deoghare@gmail.com	Alternating Dumbbell Front Raise		2026-07-18 13:15:51.465466	2026-07-18 13:18:03.693151	267	SHOULDERS	Anterior Delts, Upper Pecs, Serratus Anterior
e194e754-cb34-4b96-86cb-de30dd5bc8f5	varun.deoghare@gmail.com	Single-Arm Dumbbell Front Raise		2026-07-18 13:15:51.473888	2026-07-18 13:18:03.693151	268	SHOULDERS	Anterior Delts, Upper Pecs, Serratus Anterior
25650efd-5c5b-4e96-b712-d70d37677ec4	varun.deoghare@gmail.com	Barbell Front Raise		2026-07-18 13:15:51.48389	2026-07-18 13:18:03.693151	269	SHOULDERS	Anterior Delts, Upper Pecs, Serratus Anterior
628ccf3d-583f-4f69-95ed-8bbda03ccfa3	varun.deoghare@gmail.com	EZ-Bar Front Raise		2026-07-18 13:15:51.49468	2026-07-18 13:18:03.693151	270	SHOULDERS	Anterior Delts, Upper Pecs, Serratus Anterior
f3deb9eb-3e0d-43f0-8f1f-875fd1816201	varun.deoghare@gmail.com	Plate Front Raise		2026-07-18 13:15:51.504064	2026-07-18 13:18:03.693151	271	SHOULDERS	Anterior Delts, Upper Pecs, Serratus Anterior
f4fe1ca0-8bfc-4c5b-8e31-e679ff0458e2	varun.deoghare@gmail.com	Standing Cable Front Raise		2026-07-18 13:15:51.51296	2026-07-18 13:18:03.693151	272	SHOULDERS	Anterior Delts (Lengthened to Shortened), Upper Pecs, Serratus Anterior
87705b8c-9d77-40c9-be68-0fa7ef23ecce	varun.deoghare@gmail.com	Single-Arm Cable Front Raise		2026-07-18 13:15:51.629498	2026-07-18 13:18:03.693151	273	SHOULDERS	Anterior Delts (Lengthened to Shortened), Upper Pecs, Serratus Anterior
3a8c3feb-0556-45bf-b14b-eac9d20dd536	varun.deoghare@gmail.com	Behind-the-Body Cable Front Raise		2026-07-18 13:15:51.642764	2026-07-18 13:18:03.693151	274	SHOULDERS	Anterior Delts (Lengthened Emphasis), Upper Pecs
0ee045bf-2116-42f2-80a0-e75249e9a1f4	varun.deoghare@gmail.com	Incline-Bench Dumbbell Front Raise		2026-07-18 13:15:51.654537	2026-07-18 13:18:03.693151	275	SHOULDERS	Anterior Delts (Lengthened Emphasis), Upper Pecs
cfd61406-fc7b-4314-8dfd-363c31d6e754	varun.deoghare@gmail.com	Resistance-Band Front Raise		2026-07-18 13:15:51.664942	2026-07-18 13:18:03.693151	276	SHOULDERS	Anterior Delts (Shortened Emphasis), Upper Pecs
7437a1c5-87d9-4096-ac18-efcecf61940a	varun.deoghare@gmail.com	Machine Front Raise		2026-07-18 13:15:51.675853	2026-07-18 13:18:03.693151	277	SHOULDERS	Anterior Delts, Upper Pecs
6fea4bf6-3ed6-42f3-ba3b-f6de66751f17	varun.deoghare@gmail.com	Reverse Pec Deck Fly		2026-07-18 13:15:51.686916	2026-07-18 13:18:03.693151	278	SHOULDERS	Rear Delts (Lengthened to Shortened), Rhomboids, Middle Traps
57204640-fe70-467e-ac7d-e4a1b0cff12c	varun.deoghare@gmail.com	Single-Arm Reverse Pec Deck Fly		2026-07-18 13:15:51.696618	2026-07-18 13:18:03.693151	279	SHOULDERS	Rear Delts (Lengthened to Shortened), Rhomboids, Middle Traps
474d30a4-969c-4ccd-bde0-f884d0e4ff9a	varun.deoghare@gmail.com	Standing Cable Rear-Delt Fly		2026-07-18 13:15:51.706178	2026-07-18 13:18:03.693151	280	SHOULDERS	Rear Delts (Lengthened to Shortened), Rhomboids, Middle Traps
eb944c41-ed1e-42e1-8afb-5014ffa32f45	varun.deoghare@gmail.com	Single-Arm Cable Rear-Delt Fly		2026-07-18 13:15:51.716791	2026-07-18 13:18:03.693151	281	SHOULDERS	Rear Delts (Lengthened to Shortened), Rhomboids, Middle Traps
ddacb2b3-4a11-4d89-8816-bc49d351f011	varun.deoghare@gmail.com	Cross-Body Cable Rear-Delt Fly		2026-07-18 13:15:51.72667	2026-07-18 13:18:03.693151	282	SHOULDERS	Rear Delts (Lengthened Emphasis), Rhomboids, Middle Traps
61193c04-f249-4451-8f3d-e2e1d434b9ae	varun.deoghare@gmail.com	Bent-Over Dumbbell Reverse Fly		2026-07-18 13:15:51.737725	2026-07-18 13:18:03.693151	283	SHOULDERS	Rear Delts, Rhomboids, Middle Traps
38d0b825-f282-4cec-8ae7-c7fa7fc3fb79	varun.deoghare@gmail.com	Seated Bent-Over Dumbbell Reverse Fly		2026-07-18 13:15:51.747385	2026-07-18 13:18:03.693151	284	SHOULDERS	Rear Delts, Rhomboids, Middle Traps
4aa1cef4-699e-4626-b349-23b0aa70486d	varun.deoghare@gmail.com	Incline-Bench Dumbbell Reverse Fly		2026-07-18 13:15:51.756993	2026-07-18 13:18:03.693151	285	SHOULDERS	Rear Delts, Rhomboids, Middle Traps
2b375998-7e4d-4a83-85f1-cb6c36c7a08b	varun.deoghare@gmail.com	Chest-Supported Rear-Delt Fly		2026-07-18 13:15:51.767536	2026-07-18 13:18:03.693151	286	SHOULDERS	Rear Delts, Rhomboids, Middle Traps
8f4e8644-9515-440c-a1d2-be0dc109db66	varun.deoghare@gmail.com	Resistance-Band Reverse Fly		2026-07-18 13:15:51.780713	2026-07-18 13:18:03.693151	287	SHOULDERS	Rear Delts (Shortened Emphasis), Rhomboids, Middle Traps
7a99b36d-4aa2-4269-8d58-4f8fc643e165	varun.deoghare@gmail.com	Rear-Delt Cable Row		2026-07-18 13:15:51.791943	2026-07-18 13:18:03.693151	288	SHOULDERS	Rear Delts, Rhomboids, Middle Traps, Biceps
5c0ea95c-d843-4570-b73a-1bd9f5e0a3ff	varun.deoghare@gmail.com	Wide-Elbow Dumbbell Row		2026-07-18 13:15:51.801676	2026-07-18 13:18:03.693151	289	SHOULDERS	Rear Delts, Rhomboids, Middle Traps, Biceps
1f9919ca-aca2-4f9d-88bf-c5ff9e709af2	varun.deoghare@gmail.com	Chest-Supported Wide-Elbow Row		2026-07-18 13:15:51.812851	2026-07-18 13:18:03.693151	290	SHOULDERS	Rear Delts, Rhomboids, Middle Traps, Biceps
dbf630e5-3e22-4eac-bba6-d7d544d52520	varun.deoghare@gmail.com	Rear-Delt Machine Row		2026-07-18 13:15:51.823323	2026-07-18 13:18:03.693151	291	SHOULDERS	Rear Delts, Rhomboids, Middle Traps, Biceps
26dc55d6-8cc5-4df3-bc99-cedf767940eb	varun.deoghare@gmail.com	Rope Face Pull		2026-07-18 13:15:51.835804	2026-07-18 13:18:03.693151	292	SHOULDERS	Rear Delts, Middle Traps, Rhomboids, External Rotators
9be7406e-d852-4558-a85e-b9f6f1b4f71b	varun.deoghare@gmail.com	Cable Face Pull		2026-07-18 13:15:51.848601	2026-07-18 13:18:03.693151	293	SHOULDERS	Rear Delts, Middle Traps, Rhomboids, External Rotators
91e10f08-05f9-499e-96fb-3ff7d9b9b5c8	varun.deoghare@gmail.com	Resistance-Band Face Pull		2026-07-18 13:15:51.859758	2026-07-18 13:18:03.693151	294	SHOULDERS	Rear Delts, Middle Traps, Rhomboids, External Rotators
48a76fb6-830c-46b8-8e79-5e97e3f551fc	varun.deoghare@gmail.com	Band Pull-Apart		2026-07-18 13:15:51.871391	2026-07-18 13:18:03.693151	295	SHOULDERS	Rear Delts, Rhomboids, Middle Traps
4559ac1f-bc21-44f0-a988-1201ce748e26	varun.deoghare@gmail.com	Dumbbell Upright Row		2026-07-18 13:15:51.883666	2026-07-18 13:18:03.693151	296	SHOULDERS	Lateral Delts, Upper Traps, Biceps
e4df1b07-817d-4454-87c3-cbb89ef10645	varun.deoghare@gmail.com	Barbell Upright Row		2026-07-18 13:15:51.895515	2026-07-18 13:18:03.693151	297	SHOULDERS	Lateral Delts, Upper Traps, Biceps
0cd1ac00-a108-425b-a241-b3cfd8e62991	varun.deoghare@gmail.com	EZ-Bar Upright Row		2026-07-18 13:15:51.904722	2026-07-18 13:18:03.693151	298	SHOULDERS	Lateral Delts, Upper Traps, Biceps
3c110c8a-6d8a-4d8f-8ecc-df7eec9b9e5c	varun.deoghare@gmail.com	Cable Upright Row		2026-07-18 13:15:51.915012	2026-07-18 13:18:03.693151	299	SHOULDERS	Lateral Delts, Upper Traps, Biceps
9c433aab-e4c2-47e4-bcb8-abd1afc2b2be	varun.deoghare@gmail.com	Rope Upright Row		2026-07-18 13:15:51.926408	2026-07-18 13:18:03.693151	300	SHOULDERS	Lateral Delts, Upper Traps, Biceps
32e2c2cf-8356-42f9-ab47-a8c3205af4ac	varun.deoghare@gmail.com	Wide-Grip Upright Row		2026-07-18 13:15:51.936738	2026-07-18 13:18:03.693151	301	SHOULDERS	Lateral Delts, Upper Traps, Biceps
460a5323-85e4-4cab-851d-cf5249676eed	varun.deoghare@gmail.com	Single-Arm Cable Upright Row		2026-07-18 13:15:51.947304	2026-07-18 13:18:03.693151	302	SHOULDERS	Lateral Delts, Upper Traps, Biceps
b5d9ef26-10bc-4f78-80e6-bedff24eb0de	varun.deoghare@gmail.com	Cable External Rotation at Side		2026-07-18 13:15:51.956201	2026-07-18 13:18:03.693151	303	SHOULDERS	Infraspinatus, Teres Minor
2b7bdf4d-36d9-4047-8d32-a324b17bfed0	varun.deoghare@gmail.com	Resistance-Band External Rotation at Side		2026-07-18 13:15:51.966956	2026-07-18 13:18:03.693151	304	SHOULDERS	Infraspinatus, Teres Minor
842783c4-e227-4e70-8104-f9c277874b0f	varun.deoghare@gmail.com	Side-Lying Dumbbell External Rotation		2026-07-18 13:15:51.976752	2026-07-18 13:18:03.693151	305	SHOULDERS	Infraspinatus, Teres Minor
607d73a8-e5b2-4e1a-8150-700274bcce58	varun.deoghare@gmail.com	Cable External Rotation at 90 Degrees		2026-07-18 13:15:51.986663	2026-07-18 13:18:03.693151	306	SHOULDERS	Infraspinatus, Teres Minor, Rear Delts
cb5aa52d-3706-453d-b3bf-c38b7f65a8b0	varun.deoghare@gmail.com	Resistance-Band External Rotation at 90 Degrees		2026-07-18 13:15:51.997186	2026-07-18 13:18:03.693151	307	SHOULDERS	Infraspinatus, Teres Minor, Rear Delts
b51c87ce-59ee-47d6-917d-264dbb8a3de1	varun.deoghare@gmail.com	Cable Internal Rotation at Side		2026-07-18 13:15:52.006544	2026-07-18 13:18:03.693151	308	SHOULDERS	Subscapularis, Pecs, Lats, Teres Major
7af47343-24d5-4511-8ac4-81e58492626e	varun.deoghare@gmail.com	Resistance-Band Internal Rotation at Side		2026-07-18 13:15:52.018181	2026-07-18 13:18:03.693151	309	SHOULDERS	Subscapularis, Pecs, Lats, Teres Major
5f90d741-6391-4511-ad08-a204e4d31cca	varun.deoghare@gmail.com	Cable Internal Rotation at 90 Degrees		2026-07-18 13:15:52.031021	2026-07-18 13:18:03.693151	310	SHOULDERS	Subscapularis, Pecs, Lats, Teres Major
cde1f637-c41d-4d9b-821f-9fbb1e4c1173	varun.deoghare@gmail.com	Prone Y-Raise		2026-07-18 13:15:52.040392	2026-07-18 13:18:03.693151	311	SHOULDERS	Lower Traps, Rear Delts, Rotator Cuff
b0fa2300-724a-49cb-9c2e-8285facde256	varun.deoghare@gmail.com	Prone T-Raise		2026-07-18 13:15:52.050755	2026-07-18 13:18:03.693151	312	SHOULDERS	Rear Delts, Middle Traps, Rhomboids
7c79e39f-5b2b-4cf0-86e0-8da28c6aa150	varun.deoghare@gmail.com	Prone W-Raise		2026-07-18 13:15:52.064762	2026-07-18 13:18:03.693151	313	SHOULDERS	Rear Delts, Middle/Lower Traps, External Rotators
f0642efc-37ce-4fdb-82b0-160531d00654	varun.deoghare@gmail.com	Cable Y-Raise		2026-07-18 13:15:52.08066	2026-07-18 13:18:03.693151	314	SHOULDERS	Lower Traps, Serratus Anterior, Rear Delts
3f674956-c452-416d-9dea-1640dd57461b	varun.deoghare@gmail.com	Wall Slide		2026-07-18 13:15:52.096169	2026-07-18 13:18:03.693151	315	SHOULDERS	Serratus Anterior, Lower Traps, Rotator Cuff
3ee8ac88-df62-4151-b0d1-1a0f5f4a3f37	varun.deoghare@gmail.com	Foam-Roller Wall Slide		2026-07-18 13:15:52.111382	2026-07-18 13:18:03.693151	316	SHOULDERS	Serratus Anterior, Lower Traps, Rotator Cuff
27c2e126-aa99-4d2f-bc01-3f09ce855d70	varun.deoghare@gmail.com	Push-Up Plus		2026-07-18 13:15:52.132147	2026-07-18 13:18:03.693151	318	SHOULDERS	Serratus Anterior, Pecs, Anterior Delts, Triceps
5a4e29e1-b788-4707-be06-505743f727f5	varun.deoghare@gmail.com	Serratus Cable Punch		2026-07-18 13:15:52.141681	2026-07-18 13:18:03.693151	319	SHOULDERS	Serratus Anterior, Pecs
7a16506e-c07c-411b-be16-16baf015fe22	varun.deoghare@gmail.com	Overhead Carry		2026-07-18 13:15:52.150922	2026-07-18 13:18:03.693151	320	SHOULDERS	Delts (Isometric), Upper Traps, Serratus Anterior, Rotator Cuff
1afc9c19-f1f8-423d-838d-938ab31cfe3b	varun.deoghare@gmail.com	Bottoms-Up Kettlebell Carry		2026-07-18 13:15:52.161279	2026-07-18 13:18:03.693151	321	SHOULDERS	Rotator Cuff, Delts (Isometric), Forearms
61c8e43e-a086-4909-8072-d3b06d5be3f5	varun.deoghare@gmail.com	Waiter Carry		2026-07-18 13:15:52.170201	2026-07-18 13:18:03.693151	322	SHOULDERS	Delts (Isometric), Upper Traps, Serratus Anterior, Rotator Cuff
17888fbe-951c-41c6-b4f8-9f90e19c9c45	varun.deoghare@gmail.com	Turkish Get-Up		2026-07-18 13:15:52.182476	2026-07-18 13:18:03.693151	323	SHOULDERS	Delts (Isometric), Rotator Cuff, Serratus Anterior, Triceps, Core
4e14759b-b195-49ce-bd62-93b085ee4263	varun.deoghare@gmail.com	Shoulder CARs		2026-07-18 13:15:52.191903	2026-07-18 13:18:03.693151	324	SHOULDERS	Delts, Rotator Cuff, Scapular Muscles
dd6dc0cf-c920-4ef5-a177-87d3e381bafb	varun.deoghare@gmail.com	Wall Angel		2026-07-18 13:15:52.200981	2026-07-18 13:18:03.693151	325	SHOULDERS	Rear Delts, Rotator Cuff, Middle/Lower Traps
46a2797a-d696-4001-aeeb-548a220b6a89	varun.deoghare@gmail.com	Cuban Press		2026-07-18 13:15:52.209944	2026-07-18 13:18:03.693151	326	SHOULDERS	External Rotators, Rear Delts, Lateral Delts, Triceps
80d1b956-bb7b-447b-a3a6-e2061531c8cd	varun.deoghare@gmail.com	Dumbbell Cuban Rotation		2026-07-18 13:15:52.220876	2026-07-18 13:18:03.693151	327	SHOULDERS	External Rotators, Rear Delts, Lateral Delts
289aa19f-0f06-445c-9251-faa58a4841b4	varun.deoghare@gmail.com	Cable Cuban Rotation		2026-07-18 13:15:52.23094	2026-07-18 13:18:03.693151	328	SHOULDERS	External Rotators, Rear Delts, Lateral Delts
\.


--
-- Data for Name: exercise_sets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercise_sets (id, exercise_id, set_number, reps, weight, rpe, tempo, rest) FROM stdin;
bd210351-a993-41b4-a2c5-09f41e2a51a9	8d99621f-c144-40d1-bcc3-ffb76353c47b	1	12	\N	\N	\N	\N
61b4fce6-3261-4597-9b65-8f023a620a6d	9c8c74db-1bb7-4f19-8697-c54f8661a25e	1	12	\N	\N	\N	\N
a1c115a5-f807-4467-9382-db5cfee77c66	5345cfce-7cc1-4bd4-b464-074bfabe6524	1	12	\N	\N	\N	\N
4ae9eb0e-0a99-4026-a9a9-09eac63129fc	9c7afa2e-83df-4e29-94d9-e5619203af78	3	6-10	\N	\N	\N	\N
5a31e404-c978-40d8-9ec6-c6fb9cc18c99	7a84f906-3c7a-4c64-b03e-5330b742c863	3	8-12	\N	\N	\N	\N
51f8058a-35a6-48ff-bd4a-a2b96e5e2feb	25b8631f-fcef-47ba-9569-989adffd695f	3	10-15	\N	\N	\N	\N
8200a3c2-517f-47ed-83d8-ecdae096a94c	29d54ae9-cfbd-4d23-ae2c-bab7dcddd948	3	10-15	\N	\N	\N	\N
ffd01708-1b68-42a1-9303-f3ec5c55a220	fffe5abb-dd62-4f95-a1a8-e8a387785b1d	3	10-15	\N	\N	\N	\N
e3086c08-829e-4fd9-b53d-9fc4fdccc83b	fef41fc0-593c-442a-a586-1718d67a65f8	3	1 min	\N	\N	\N	\N
5a62b451-6002-4276-98ec-2c9a890213d7	550b1cf9-9412-430a-a44c-ad97b8dccb0a	3	8-12	\N	\N	\N	\N
1e668827-8ba3-4a65-a098-17a5c4e95070	856dd56d-5189-42b4-a27f-ed0963f5d5d0	3	8-12	\N	\N	\N	\N
7346493e-606c-4d28-aac2-5e54edb42834	b4c557d6-4428-456c-88ba-37b7fa70065e	3	12-15	\N	\N	\N	\N
a87ac0e0-f619-4de4-a616-1000ca3ff10e	96d31acc-4d73-4016-9671-6fae209ac965	3	10-12	\N	\N	\N	\N
c8253bf5-f764-4d39-b412-e9284bc0f74e	878aac12-1b57-40dc-839e-be65544551ef	3	10-12	\N	\N	\N	\N
e4f94e94-3f3f-4dab-a7a9-d72de7e9508f	477cadf5-eb55-4d40-b6c5-6f5155fdaee9	3	12-15	\N	\N	\N	\N
b8205098-1d29-4dd4-890e-78ff9d0e9d91	dbaf2ee3-c8fb-45d3-a9e6-583c64d6f88d	3	8-12	\N	\N	\N	\N
a44b70ee-5f59-41b7-90c8-b95ec7162b08	14f3ca24-d9f8-464c-b1b0-ab30ecb2f4dd	3	8-12	\N	\N	\N	\N
b734be14-ed88-42f2-9fc6-55dd4b2b0a07	234808d5-5b79-4677-8e19-d1248676998f	3	10-15	\N	\N	\N	\N
809e1cc1-a4ba-4f56-ad52-9f996815dd80	ec776557-b100-4a29-9c26-0320034150af	3	8-12	\N	\N	\N	\N
eb3ae7ad-a86b-4d6e-a669-83d0eb127d6d	693de2e9-4912-41e3-8eef-adaac17c2dc8	3	10-15	\N	\N	\N	\N
4b3d5a02-7fbc-44d1-a2d1-feec9e942777	5dd4bce2-2454-47fe-b705-7bb69bfe1411	3	12-15	\N	\N	\N	\N
4a6463c0-4b63-4a49-b801-be446e178192	9af31b45-45d3-49e5-94cd-7e3f9a385b7e	3	10-15	\N	\N	\N	\N
bef9374d-3a31-43a5-b227-70ef730e02d8	3923f3fe-8673-4404-b61a-e4c99580e201	3	10-15	\N	\N	\N	\N
108f327f-e87d-450e-b486-2d67e391db06	9280d8b8-678c-4ee2-9531-697834e187fe	3	10-15	\N	\N	\N	\N
bd436b8b-0bea-4529-9175-e1cc263bfd23	edbef4b6-3089-4c64-8228-c385aaca579a	3	10-15	\N	\N	\N	\N
e59e78ac-4eb1-4694-8f16-0943d48754f7	4a986346-07a3-4d05-bd7e-70604dbe4a9b	3	10-15	\N	\N	\N	\N
e7ebbaf5-d699-4528-b0d8-09f7fb5c8238	b3640c62-399f-4751-b6e2-c59cd8fea410	3	1 min	\N	\N	\N	\N
f503f9eb-86a2-4077-9170-5ddfb41c57f1	f6949ddd-8a77-4e72-b2b6-cf8a1c49f647	3	8-12	\N	\N	\N	\N
81f0b794-b825-46d5-b308-d9b770baa3e9	2a548896-a49c-4d98-86f2-1bb642a269e3	3	10-15	\N	\N	\N	\N
da9ac9b0-28b9-4d6a-8c45-bc0e2a080014	5c91af5d-88d9-437d-b0c7-31d37dd83d29	3	10-15	\N	\N	\N	\N
344a6169-a8a1-41a1-a639-53a4b2a1d996	674efaaf-aca9-44ff-b174-ec8b5b423fca	3	12-15	\N	\N	\N	\N
e28ca5b0-5e35-445e-8de3-1318d94d9ef8	ab4fa1d5-c75a-4808-872f-5bb79d45ee6d	3	10-15	\N	\N	\N	\N
594009c0-446d-46ce-b788-ac2f6afc960b	0d9deb72-8d9a-414f-84f7-2fd45657a54e	3	10-15	\N	\N	\N	\N
ba44aee9-d56b-4fd9-b62b-34d22943dc09	6cbf8a5f-8fc5-4ae2-b165-04cdbe94de90	3	8-12	\N	\N	\N	\N
7da27309-2e57-40f4-9044-58791c024ac8	bf5595e5-a737-428d-af7e-53b94a9edfe2	3	8-12	\N	\N	\N	\N
c2739019-a046-4793-9899-fa76885ea051	c0f04c52-f64b-4c70-8e43-a6deaab2a9ec	3	8-12	\N	\N	\N	\N
f925d027-f527-4ffb-922d-5edfe073a118	2dc18e80-9d94-49c2-bd20-77165195ae26	3	8-12	\N	\N	\N	\N
e93da083-7654-4653-9788-f695d3138108	01556157-1c68-4c99-873a-0764ab52ad1e	3	8-12	\N	\N	\N	\N
fc44c7ac-ef22-4e27-9885-fdeaeb6ba166	e227c8ac-0e64-4598-bc4f-8d4755fd9e14	3	8-12	\N	\N	\N	\N
9de5da72-660f-4bbe-9821-0b765c01d41a	db045c29-6330-443c-9a76-a823b3776b48	3	8-12	\N	\N	\N	\N
0c05519e-6fe9-4e0a-b127-33a15585c707	317c7ab5-f21a-40b0-9117-add392b6ba35	3	8-12	\N	\N	\N	\N
4731426b-8776-4c3b-802a-1a773837f0f8	cb731873-e8ad-4d0f-a884-5c3405089138	3	12-15	\N	\N	\N	\N
63f4732f-6996-47f5-b238-3d4447247fbc	79771884-7f31-4295-9176-e326ef24f5d7	3	12-15	\N	\N	\N	\N
0a71cade-7b16-4766-a23e-2deed6661595	4122e303-191f-4efe-b06d-c498e4cf6d92	3	8-12	\N	\N	\N	\N
9041695a-d9c4-4b8f-a762-fab7754ad051	e8cdd0c7-776d-40b6-a8f7-b159ffee7315	3	8-12	\N	\N	\N	\N
caf77526-c57b-4d80-841f-5f05bbfcd649	10288a03-cfbc-4154-8ccc-d14c41f643cc	3	8-12	\N	\N	\N	\N
3d46cff6-052f-4b56-b7e0-a3e8f01652fc	d8e8b8b5-c354-4bde-8f6f-3fff9a54dba2	3	8-12	\N	\N	\N	\N
bc2d067e-6350-4fc8-b91a-06f64f674117	1e49107d-f303-454f-8a7e-28d6d514cb2d	3	8-12	\N	\N	\N	\N
246d163c-7edd-4590-983f-3ab482c525fa	3d3ee3d7-7718-42eb-bfae-37b5e303731a	3	8-12	\N	\N	\N	\N
26d5f4da-a8da-48a7-b82f-36f0d34a70f3	7a7c0c78-1faa-4b93-84f8-5aa5b828ba07	3	8-12	\N	\N	\N	\N
5e7bcd8a-d12f-42f4-a75e-99751cd88128	347aab5a-81bb-4c24-bbdd-3538b82e50c2	3	8-12	\N	\N	\N	\N
81a341f1-95fe-4608-b8ee-186c13fe5227	30782ca6-038f-49a2-9e8c-7fd28e3839f0	3	8-12	\N	\N	\N	\N
51a7f5c2-a45f-4ff8-b0f6-485035d53ce2	b08507f2-6e0d-4fac-8b8d-30479e187480	3	8-12	\N	\N	\N	\N
da03fcb0-707e-498b-95f2-e1ff98d1ab09	4fca22d2-d902-4b25-8e2c-0f9dca35ed32	3	8-12	\N	\N	\N	\N
afcb5812-a27c-41a8-9428-3f9b0aff7de1	bfcb3d3a-e805-4ff6-bd45-bed2ac62336e	3	8-12	\N	\N	\N	\N
9367a866-d8f6-4f31-a6ab-8e9df435eef0	464a6ba5-b051-44bd-9869-f690d4d7fa7b	3	8-12	\N	\N	\N	\N
4c51d4cb-94be-4c14-a575-828821486005	b30d4604-68b5-46b5-9a76-ead7bf741867	3	8-12	\N	\N	\N	\N
f00b2ba0-5305-4164-af98-a0f48d500070	70139903-755d-4e01-af91-6d783a58c7e6	3	8-12	\N	\N	\N	\N
5b987d39-0e85-4413-98b1-b3c180dc8919	85c81d0a-aa5d-459b-8cda-1c80f05910f0	3	8-12	\N	\N	\N	\N
a48de9e3-5bdf-40b0-810a-54eb61b100c0	b4564cd0-2900-4068-98e3-1739f4ca04ce	3	8-12	\N	\N	\N	\N
2025c66c-9f66-4544-b572-d2fb503d87a0	07c258c5-dfd8-4144-ba5d-106e72f7d336	3	8-12	\N	\N	\N	\N
c5fbcd92-482a-4474-95b8-282fd4adfb7c	d00ce926-2e5b-4d70-8a94-3248e0196276	3	8-12	\N	\N	\N	\N
c97fb10e-78c3-420a-8745-8e98d4d73c9f	2b08c90e-4922-4620-b231-c2c427e8bc41	3	8-12	\N	\N	\N	\N
23ec2dde-a4b7-47c2-b349-8aea031c0528	1656de79-3462-436a-b84e-caa8b58ab339	3	8-12	\N	\N	\N	\N
a1661aa8-82b8-4859-aa03-60e60f743c47	d0c9b1aa-ba90-43da-bf14-0e5f3a9cd105	3	8-12	\N	\N	\N	\N
d6b4dc46-6665-49a5-a7ac-f438f77a9b07	2d2f00cd-4283-42cc-80d2-862419c8acd8	3	8-12	\N	\N	\N	\N
0a4978bb-1064-4313-a887-3953aee5b206	69e7f771-2c58-4e6c-926a-05b076a3fd45	3	12-15	\N	\N	\N	\N
0fab7e5e-b1a8-4f8d-92b2-f100149d0cef	f86a8e11-8f87-4131-8c67-8005b52adaa0	3	12-15	\N	\N	\N	\N
19981ad4-84d0-4648-802b-ad8ca714ad50	5ef7941e-d399-470e-a446-ac5cb34bf177	3	8-12	\N	\N	\N	\N
3e6919fb-74ba-4fe4-ae06-87f9e08081b4	3f2134a1-924f-47e8-a129-943daf68ec2b	3	8-12	\N	\N	\N	\N
29db9436-fec7-4440-a012-ae38fd7db60b	524b71a8-0f7b-4a60-8b2b-2408992e1293	3	8-12	\N	\N	\N	\N
bbf3c678-56ef-4d58-b49c-8f3814e689ab	085fb327-7437-4156-8237-28c4593e207d	3	8-12	\N	\N	\N	\N
7b172a0b-c85c-4ebe-bde5-d963f00ff222	7a5d6dc0-8109-4029-b0c7-271e48dcf58f	3	8-12	\N	\N	\N	\N
03d9e519-ccdf-48bf-ad96-900dd922934c	5f396d8e-ecca-4bea-bbc3-1a866157de44	3	8-12	\N	\N	\N	\N
24034737-52b1-4209-b725-abc633f32b61	27fd929b-4d23-45fa-80d3-47542b0ef8b5	3	8-12	\N	\N	\N	\N
5d29f79d-2591-457f-9e9a-78e89798368b	52510cb5-4ce0-4ae4-b31c-cc2d1b031a8b	3	8-12	\N	\N	\N	\N
18ffa850-0b75-4050-ac06-bf2443e056b5	791f9327-9751-4841-825a-a29df3a6aeca	3	8-12	\N	\N	\N	\N
1b908e2c-42cb-4789-96b6-62c2fabd7092	5b93e6e9-303b-4891-96af-345c4ddc2abf	3	8-12	\N	\N	\N	\N
a3234348-c320-425d-b8fc-1e637bd6078a	b387c792-904f-4ad9-80f9-9388646b7a3c	3	8-12	\N	\N	\N	\N
d4bc69aa-08a8-4f35-93ed-bcfd2a344abf	4e111375-2a4c-44a7-bcaa-33a6856a1c33	3	8-12	\N	\N	\N	\N
ef637996-b5bf-4917-8576-a2ef3e0bdb7f	86aef619-a8fd-4df3-a089-ebd025f4fcbd	3	8-12	\N	\N	\N	\N
067e2bf3-77d4-4940-b170-17fca80207c0	6380086d-f3a5-4ad0-aa73-38448390646b	3	8-12	\N	\N	\N	\N
067287f4-c097-412c-aae8-7fe20d8ad02d	3fef4326-311d-4182-a53c-226eb11e08d4	3	8-12	\N	\N	\N	\N
4c6debe8-2c24-4e7f-9760-98ced0b0a85c	f9a3cda1-f358-4ac4-bb60-df64760c640e	3	8-12	\N	\N	\N	\N
14919d79-8271-44af-81a4-76d0d50062fd	aed0d39d-9290-477f-9328-30dd157e4fbe	3	8-12	\N	\N	\N	\N
db9edd61-bf60-4929-88e6-9cefc3bd20e6	d9c4c4df-fff2-43ad-bcc3-da68c1af0686	3	8-12	\N	\N	\N	\N
9ef2d244-cb54-4cad-b2e0-2cb6c2b06cbb	df8a2e2a-1d68-44be-8921-4246665b647a	3	8-12	\N	\N	\N	\N
a1c390aa-a40d-4e65-9a61-15840e6c45a3	aff1deb2-9ce6-4650-bec2-3b907f70ded9	3	12-15	\N	\N	\N	\N
a07dbad7-0cb5-4d38-abcd-fa302dd4ae36	8649770c-b004-4b9f-826d-013a6b27202b	2	10-15	\N	\N	\N	\N
1c8c9703-aca1-40f2-9c98-e6a9b2150c9f	7faf4c04-3285-4a81-b36d-7eb1e77f3c7e	2	10-15	\N	\N	\N	\N
1512f89b-0556-47c9-98a6-ed773959348f	a62afcdf-b2f0-4105-9321-58f4c8ebcdc4	3	8-12	\N	\N	\N	\N
a3f6fa89-78ff-4cfc-bc89-e880153c2657	768a84f2-7077-46db-9cf0-6c9268332630	3	8-12	\N	\N	\N	\N
94235009-3fad-40af-bf8a-3153cca13f53	4dc3258b-3f6d-4008-8974-7da4810f8d62	3	10-15	\N	\N	\N	\N
39a0e53d-3e4e-4deb-8d68-30d9a61e9662	ddb9fde2-ba6a-4baf-9181-0252b81c2956	2	12(per leg)	\N	\N	\N	\N
a2f023dd-d7c7-447d-b03c-c99dfa0ac3ee	779226bc-b2f5-41b9-89b7-d92cd799e1a6	3	12-15	\N	\N	\N	\N
b5a1c4e0-4d7e-42b8-a752-c81101826e71	79bafa58-332f-4baa-87f9-64dde0a6b686	3	12-15	\N	\N	\N	\N
be9635c5-0e4c-4002-a2bc-c70d475a0b77	3ab259fb-09c4-4cb6-864e-b4984b971900	3	8-12	\N	\N	\N	\N
812abb88-34a0-4f06-9121-e61462a4ae77	aae5fb69-aae4-445b-b225-09eaede7819c	3	8-12	\N	\N	\N	\N
a8a62a20-d0bf-494a-9802-a04e8929dc49	b50435f3-0e06-4c94-9f89-d811ee4cf034	3	8-12	\N	\N	\N	\N
0d184b7d-4f8c-4f20-ae21-524d10723f8b	741afec8-817b-4aa1-91c4-c040493678c4	3	12-15	\N	\N	\N	\N
12a68e75-580d-4452-a11b-6a448467f42b	a83fde46-5b66-4f79-a0a4-7670fc45a0a8	2	10-15	\N	\N	\N	\N
de28e549-581e-4e65-bf6c-abae8864a67d	3aba0241-5165-4ac6-b740-5a8c38ac102e	2	10-15	\N	\N	\N	\N
b8b65e4f-b72c-471b-9434-1967d0772e22	37e2d5be-430e-4f60-96d1-c86a1ab83cb0	2	12-15	\N	\N	\N	\N
9cb142ed-61cc-4159-a90c-4502d1eea120	b11c16d6-e1a8-48d2-9539-cf5c77aaa550	3	8-12	\N	\N	\N	\N
1385b609-c5c4-4a65-ae46-e207e38dfee6	98814777-95fc-4a60-bf92-c46134b4e416	3	8-12	\N	\N	\N	\N
84ec7bb9-1102-4880-bd40-b77ea479e9d2	6135cfd3-203c-44b0-8519-1764b23f0bdd	2	10-15	\N	\N	\N	\N
48e34c51-4beb-43e0-917d-96fc4465667c	309f4855-5001-40d2-9e2c-70f45fffb724	2	10-15	\N	\N	\N	\N
8f412973-ed1b-4880-87cf-0d12c8a631b0	dae2b46a-e77d-42ee-9628-4f21c2441733	2	12-15	\N	\N	\N	\N
4a21f8f6-ae98-4441-83af-a1a9aa6f1de7	508a07da-42ec-4775-bdc9-845c56ebd910	3	12-15	\N	\N	\N	\N
c553c440-598e-404b-af3b-ae47f914e9de	983db977-b294-4164-ad7f-a94dee92a9e6	3	8-12	\N	\N	\N	\N
6d9eb11d-1c00-4a96-99db-f2992d767e5b	1c78bd6e-0e50-45c7-b7d2-98550fcd7e55	2	12-15	\N	\N	\N	\N
318a6dd2-26b3-45d8-97a9-4f7ab6258014	1fa793cb-45e6-4313-81c5-a33d893d9616	3	12-15	\N	\N	\N	\N
0e6afdd7-a531-42d8-aa8b-bed3df95139f	26dd08ef-ab6b-465c-987c-d44bc4d86086	2	12(per leg)	\N	\N	\N	\N
fff0347e-713a-4048-b4f8-ef02a18e7e49	d4cb00ff-480c-470f-8635-6bf030712c81	3	12-15	\N	\N	\N	\N
38850ec9-44b6-46d1-8d68-12ada68fb7e0	7c520d07-5ef1-4dde-a2a7-722fa50e42c9	3	12-15	\N	\N	\N	\N
2f81d54c-3910-4900-be1f-204c6ee82e0c	0b155ead-005c-4a21-bbc2-8e8da381ca6a	3	8-12	\N	\N	\N	\N
ecca5fd9-8764-4664-88cb-a49f2e9aeb4b	80f5cf56-e4df-4d22-b2de-514d2e69935a	3	8-12	\N	\N	\N	\N
71bf03b9-0220-433b-85be-46bbb006ba05	3af48b9d-ded1-409b-baba-fb892be2f17c	3	8-12	\N	\N	\N	\N
5b73dc37-2f43-494f-83cb-2d2522a5eae6	f39387d8-155a-4311-a7a5-3abdc2ee5e83	3	8-12	\N	\N	\N	\N
34736277-598f-4d4c-beb2-c979b103ad2f	db614d18-4caf-4cb2-86fc-d126bda456a1	3	10-15	\N	\N	\N	\N
84061969-6515-4059-9226-b29cefd64377	aff5dc21-dcf3-4da4-afe5-0deb2b97bf83	2	10-15	\N	\N	\N	\N
17749ecf-f9e4-46c4-9a62-e800c17fe265	34cf34a0-8705-47d6-9c0e-596125f5f506	2	10-15	\N	\N	\N	\N
1c6627c2-20d5-49f7-899c-82f7c260aae9	9abf71e1-91e8-42b5-9f44-2d512a33d6cb	3	10-15	\N	\N	\N	\N
24dcc14f-d80a-4c1d-9c76-a6def2b058b4	7b512b6f-8375-468b-bfb1-c312ad2b9035	3	8-12	\N	\N	\N	\N
c877d4dc-8eb3-4985-a73e-5158daa13073	fb84708d-ef17-4a9b-9db1-b91f918b80b3	3	10-15	\N	\N	\N	\N
d238a14e-7e87-4b4f-bb54-721f2e21d523	db5d8830-6559-4a20-8e28-2bc0a4add1b6	3	10-15	\N	\N	\N	\N
d869b8be-603d-42c7-8eb0-6db9d3884c78	239f5d77-2014-410f-b739-d0fbb1f39226	3	10-15	\N	\N	\N	\N
2d6e5b94-ebfa-4c66-a625-3df5acd5dbeb	1c13bbad-d299-43d7-a165-b529c0edee4c	3	30-45 sec	\N	\N	\N	\N
f69d961f-e966-4114-adc4-79d99cd8bd57	cc4f1538-aaf1-4b61-ada9-9d6c202fef47	3	8-12	\N	\N	\N	\N
cf2b3afc-f456-4043-9724-ddcd0573e6bd	a3ad6192-97d1-4be7-95c6-0dfbce00f7b2	3	8-12	\N	\N	\N	\N
3586216a-3ba7-4f8a-82a2-b45038a5b3db	dedfe8a2-4700-4848-a1e7-a9f4bd68897e	3	12-15	\N	\N	\N	\N
48d1c2cc-1931-401c-b86f-03bf44ae467d	cd526831-8194-492f-94b6-63b19ea9f858	3	8-12	\N	\N	\N	\N
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
7fdd3e4b-68cb-4642-ad4a-f9f38b2ac754	6b118c52-21a7-4cee-a800-c416c35cb372	3	8-12	\N	\N	\N	\N
f4e01d76-3220-41f7-9476-6fa50405dfac	3e7bfd11-5ef2-4c06-a899-2116ca2d3aca	3	8-12	\N	\N	\N	\N
dc924c26-a0cf-4caf-ab46-585bebfe37d3	e1c62ad2-49d4-44ea-b1c5-e9cf2c94d00a	3	10-15	\N	\N	\N	\N
3752031b-3135-4694-87ca-f0e12ab8c5a9	8646b489-ffaa-4366-b4d3-cc535ec671bf	2	12-15	\N	\N	\N	\N
9ccff4ca-b6b3-42d9-8978-91ae8d5efde5	5f556a33-9432-4aed-908e-6bfc0cef306b	3	10-15	\N	\N	\N	\N
b934e130-5f91-4407-aff6-5666e3f2cb81	94d5c7f7-b33b-4698-8c41-6be6e3095175	3	8-12	\N	\N	\N	\N
4ec3f82d-3a28-4636-bcaa-f0bedc8c93f1	459d5ad5-50aa-42b4-8d9b-e41828d6ea99	3	8-12	\N	\N	\N	\N
ff515ee5-6206-4256-962a-38b56319ec5d	cddb7fb9-e8c9-4755-93c1-17fe5590eec0	3	12-15	\N	\N	\N	\N
b54b209b-d9ab-42da-b2d6-f5b6f423dc94	40906bbc-e71a-4e24-a882-92d7edeb3574	3	10-15	\N	\N	\N	\N
4eef9db5-f712-4832-83d7-f4db7247016a	aa180a24-dc99-4a81-959e-3aac6770b8d3	3	10-15	\N	\N	\N	\N
b0dd30af-c452-4ce7-bcbf-a7ec79a8291d	8e217c5e-a36c-41f6-9167-488e78f80784	3	10-15	\N	\N	\N	\N
64c320e8-786a-40a5-9458-115c4df200cb	3295efbf-6c65-4b58-88ce-af1accf54414	3	8-12	\N	\N	\N	\N
2fc39ada-cd0f-44ea-afc1-1fcd3fe0a281	e476fe64-b1b3-484b-b6bf-7ee1bf06ce54	2	10-12	\N	\N	\N	\N
207fcff2-a653-43ba-a7ff-19b4ec93b889	a683db0b-63bd-4e73-b2ef-8372241dad60	2	10-12	\N	\N	\N	\N
40a0f74a-8be9-4fe7-8f84-9dfa725a13a0	e759ba57-d215-468f-ba7c-e2572a7fb4d8	2	12	\N	\N	\N	\N
fe9bf273-d55a-4cf4-95af-93b95c8ceb37	0d81342c-ad7d-4306-af78-3ad283f1e5ef	2	12	\N	\N	\N	\N
3716eefc-b88a-4822-ac6c-4d700eaea1d3	95b4020a-6589-47db-83dc-4e6838cf45e3	2	15	\N	\N	\N	\N
a2b34228-5e4f-4c15-9b81-57b19f787488	93ed070e-2fb7-4178-967e-544dea16acd3	2	10(each side)	\N	\N	\N	\N
566fdde3-3817-48b0-9bcb-a92f4960c2b2	cff51caa-3c8a-45d3-8887-54979cb307bd	1	10	\N	\N	\N	\N
beafc108-7ee1-415b-8bc2-8ad7acafe216	424451b1-cb35-413d-b74d-1fee9cd207b5	1	12	\N	\N	\N	\N
b7ee454c-95a7-45fb-8658-1e8c8414dfd8	28ab74c2-54ff-467c-9b43-202555a98d5b	1	10	\N	\N	\N	\N
f7207618-f94f-4e16-a5ce-6690ca318948	7af4afa2-0f17-41a1-ac22-832bd7523815	1	5 Breathes	\N	\N	\N	\N
652af22a-74d9-40cb-82dc-7cd8da83c47d	86a21716-5182-4fb9-b06c-b19b9fcaec24	1	10(each leg)	\N	\N	\N	\N
53fe3a1b-52e1-49a1-afa1-5a7e3684be50	4ecd734b-a181-4b43-8802-2b5a9b7b715f	1	10(each leg)	\N	\N	\N	\N
0dc3aaca-71ad-4dab-9e18-27c8fb699dca	4fc0422a-8be1-4786-9fc7-c9f9db19279a	2	10	\N	\N	\N	\N
71efee72-8448-41db-86c4-41085dd8bacf	1768330c-7ccc-4cc3-9551-7011c629ca6f	2	10	\N	\N	\N	\N
d0b70a06-67b4-4ea1-907a-8c7920538b4a	45738aad-fc3c-4038-a969-7a815b7683e3	2	10 each leg	\N	\N	\N	\N
ddf5ca3a-98d8-477a-83f5-0afe8fa15f42	e38ecd64-b7d2-40c3-bf40-29fbb34a45a8	2	8 each side	\N	\N	\N	\N
a9ad1ead-c1a0-4c5d-8418-93bc50ea72f0	6b762af7-f74e-44ab-96b5-eb3f66b32ebe	2	10	\N	\N	\N	\N
11af3c19-62f7-4618-9cd3-f34d04e5d7fd	913b8164-cbfe-42ce-885b-dbc1c73b5709	1	10	\N	\N	\N	\N
16027319-c343-4d54-8bab-d15e1d33eb30	ecadfa4b-83f9-4a59-be7c-9408189c710d	1	12	\N	\N	\N	\N
4ac1657a-d260-4581-bf8a-5ae4bacd06a9	0a27e078-8f91-4f52-8659-4100d1896bd1	1	10	\N	\N	\N	\N
982a3f72-fb34-4c7b-893e-d58e0d3307c3	d90f5468-8608-4f56-951e-6167fc0a3c28	1	5 Breathes	\N	\N	\N	\N
c74f641d-8646-43b1-87e3-1ff0a1dbe55b	c1188eb0-d73a-44d9-b599-6bd55c371106	1	10(each leg)	\N	\N	\N	\N
ed29d3f6-5b11-4895-8740-52f988eef33a	fc1334c6-98b0-43f8-9a2a-52f5544ad2a8	1	10(each leg)	\N	\N	\N	\N
9f2ac970-ce98-46cf-824c-745641dd7b4c	d8933401-d7d9-4054-9d3f-60ac7c7dbbb3	2	10-12	\N	\N	\N	\N
561e0ddd-0a94-4d8c-8bf4-aeb7fbf6c87d	35a5a2d9-f1b9-41de-aa31-e19a13dd421c	2	10-12	\N	\N	\N	\N
f40e1587-cf00-40f7-b2bf-4aae6232b2f0	cfac5fc0-67ed-4221-9e70-e4a7bc7c647f	2	12	\N	\N	\N	\N
05c06ede-1743-4815-b7b4-951e5b288052	aef0ab0e-2487-4318-b3cf-987757377e1d	2	12	\N	\N	\N	\N
19914afd-c644-4040-9ceb-195f8992ddd0	8e65a39a-3d87-486e-a308-2b447477aefd	2	15	\N	\N	\N	\N
70a236eb-b3a4-420b-adc6-683e54b6e800	f297f7e9-89a6-4647-8e0d-d0461aaa6082	2	10(each side)	\N	\N	\N	\N
f14849cb-0f9e-4e66-a94c-b2f16c527d71	b0122186-9b95-4e0b-a542-8b0ecb24d291	1	10	\N	\N	\N	\N
981c53e9-82ad-40da-b237-2279d953d5c6	26bf61df-013f-45c0-9859-a5bdda77da72	1	12	\N	\N	\N	\N
324b651b-5fed-40b2-8381-08f6db79d08d	760bad5e-1206-4c0e-8445-1ff4ae1b8392	1	10	\N	\N	\N	\N
367fa27c-acd9-4113-a13c-e91f223e3c39	9c20437d-e12e-4112-b5af-a564164b48cb	1	5 Breathes	\N	\N	\N	\N
1bedfd10-082a-4eeb-9868-e8becceba7a8	6b60138f-0122-4f85-a4e1-0a96cbb6f34f	1	10(each leg)	\N	\N	\N	\N
3afbe9e8-2e2d-4faa-9fd9-45cad7b1ed0d	3ce61138-896f-4bb3-94ee-fb396924444b	1	10(each leg)	\N	\N	\N	\N
d34e7d04-baae-4e48-ab7c-0d2583b08a5e	ce223458-7ef0-4d8c-9e03-04f4eaec5ab8	2	10-12	\N	\N	\N	\N
ef7a10ff-3c25-4546-9b7a-828ab8d71336	74647c44-2047-486f-8d59-6e35eb9f87d6	2	10-12	\N	\N	\N	\N
6969ed22-ffd3-4a70-bf04-2d8d0406d166	9fef4d09-cc09-4652-8b95-47b8ddebf364	2	12	\N	\N	\N	\N
feb8c523-d896-4013-95e4-246ce3392be3	45000299-d459-4318-801c-878afc1df41b	2	12	\N	\N	\N	\N
af789a2f-082b-4f66-ace3-f65c654ee05e	f28629a1-fcf6-4de3-af02-dce3ae97240e	2	12	\N	\N	\N	\N
78e10cd0-ac27-470f-9884-4d64df71e61e	2dfc147c-eea9-4693-9987-8fa1b34e5ef6	2	15	\N	\N	\N	\N
e6e381d7-5680-4eed-aed8-9435bdbda9a2	b6df4b2a-1e64-427d-834f-de35bb208276	2	10(each side)	\N	\N	\N	\N
3c6212c7-794d-4c17-9a12-c6c46dcd9d9d	0e7d97c5-d8d7-4d0b-8058-6d02e8adfc06	1	10	\N	\N	\N	\N
4730c48f-8c52-4554-abf7-8b8a6a99249f	d5f95cf7-90ad-4fd0-bf23-534d7ec23aa4	1	12	\N	\N	\N	\N
535277ff-c10c-4b91-ad0a-47e1b3567fd5	633e677f-512f-455d-af47-46425c52747c	1	10	\N	\N	\N	\N
75b54307-c1e9-450b-b693-ee7c6ff29713	c94391c5-49b5-45a5-9511-5bc64ee9d4fd	1	5 Breathes	\N	\N	\N	\N
56b5a985-9e3d-4552-8c9e-6eaf6fd97b84	a398ab54-8547-48b4-8e19-fa295e0a38e7	1	10(each leg)	\N	\N	\N	\N
96be8d97-895d-40ee-b199-1ddf8ef6c892	e6f94e91-0367-487a-a81e-588c63f7aa82	1	10(each leg)	\N	\N	\N	\N
889b8e98-bf96-467d-b4e1-c8a08b5236b1	2107c7e7-ca65-41bb-ab19-c2cbe69812d7	2	10	\N	\N	\N	\N
71e33a7f-5f22-4c55-a55a-b226bee18877	c16a4c16-6857-48bd-aae7-89002ef9e688	2	10	\N	\N	\N	\N
0d0babaa-953d-49a8-86da-eb4752fd25ad	4d5b8e60-a1ea-46ba-b1c3-ce3516cb879d	2	8 each leg	\N	\N	\N	\N
ade6581b-2067-4d43-8909-566de1b4265b	9243fa06-2ce9-404c-bf3a-301b9f157e63	3	8-12	\N	\N	\N	\N
f2ec9b3b-165d-43ae-b0a8-9bdfdf4bbf37	bac53175-7198-4b02-98dc-46367b25ce27	3	8-12	\N	\N	\N	\N
b4c713a1-19a3-4893-bdbc-4e28ebbc21d5	eceeffad-1e49-46b2-963d-00e1a7b50556	3	8-12	\N	\N	\N	\N
55bf20cf-1d9b-46f1-9303-f481fd53886d	e5e16770-43c8-4077-b653-f5d5e569580d	3	8-12	\N	\N	\N	\N
95f8487e-8b7d-415b-9a10-0f1f36599263	b9c4ba24-a063-4164-95a2-3e7dd109b032	3	8-12	\N	\N	\N	\N
09906105-4555-4a9a-ae31-7dab7cca6e10	3069ac39-d57c-4e67-8ee9-fc6bcf84c3c9	3	8-12	\N	\N	\N	\N
6694f7b0-54f1-43b4-af50-38ddc99333b7	7c9f992a-91ec-4877-8287-43eb4d537ba6	2	8 each side	\N	\N	\N	\N
556b5356-8c63-414c-9e6c-dd31f4bb3175	c1ed34dd-6704-4e21-9862-85aec9c6c0f1	2	8 each side	\N	\N	\N	\N
fa218f29-e0e2-4bdc-9dc1-dc8633fed39f	69433820-c542-4179-b44d-50a93a7204af	1	10(each leg)	\N	\N	\N	\N
2ad3d6e2-ba24-4d1c-bae5-2a8bd124a6e1	287e10f7-88e2-4679-a5c2-f7b03db74b1b	1	10(each leg)	\N	\N	\N	\N
38466f59-52cc-4ece-9213-81fb817ca70c	56674a0a-e75c-4fe8-9caa-077f92c5d863	1	10	\N	\N	\N	\N
66e488eb-5a86-4ed3-af03-ae08f421fb31	e4ac9ecf-17fb-4275-b36c-f47a166d9a83	1	12	\N	\N	\N	\N
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
e0a9c30c-32bf-4723-a79b-9ec54198706c	62c58cb9-4268-472f-aa9f-95ec86f50faf	3	10-15	\N	\N	\N	\N
557c68c3-60ba-4b17-b77b-48a8c6603e96	58c49a97-a0db-490a-b7aa-d2c7c274244a	3	10-15	\N	\N	\N	\N
fb324ae4-1ba9-4323-b944-50bd7af20a46	554e0fb1-e0da-4744-8e6a-4503569700bf	3	10-15	\N	\N	\N	\N
a01808e5-3c1b-4ee5-a934-784e2bbb37b7	4a9b282c-5073-4df1-b24f-14cfa84fb1bd	3	30-45 sec	\N	\N	\N	\N
0bcc86b6-6c26-490d-b633-fc86ef48ef12	cbb54f67-4513-41a1-9847-8a719ed82041	3	8-12	\N	\N	\N	\N
9db307ae-0e1e-4e6d-bbc7-ff65eda3d6d1	a6561498-2674-499f-bad4-9a5e44fdba61	3	8-12	\N	\N	\N	\N
7927a59f-806a-400d-9d03-a1b2e46b18f2	49c6a55e-e7ec-4ad5-9b38-669198e2b424	2	10-15	\N	\N	\N	\N
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
fd4b5bec-ae27-449f-ab02-2064c7c662c5	4447150e-4b2d-4c6b-8d44-fa8d1a6e2d05	2	10-15	\N	\N	\N	\N
568ceccf-8ef7-46b1-a632-80612589a4ce	4f9792c9-0489-44df-8645-e49a1c5a744c	3	8-12	\N	\N	\N	\N
d35d3963-e03f-45ea-8f4a-99fcd564f59f	c07ab3bf-4747-415b-8ccc-8167b449be3e	3	8-12	\N	\N	\N	\N
28dbe82c-28ab-4301-ad82-542eb331c7f0	1167bfc7-f781-4958-93c4-8803892865d7	3	8-12	\N	\N	\N	\N
b6700a33-1407-4918-a0b2-aa2f35b7e4c9	20fd3528-94b3-48b1-b1dd-d7ff086db8df	3	8-12	\N	\N	\N	\N
b37b2d9d-7d92-499b-83d6-73713b5d9395	315378f4-5cf4-4185-805b-50ff25fe4f88	3	8-12	\N	\N	\N	\N
14392a76-5f52-4938-ba27-9f236942b185	434628c4-7d38-4678-bf0a-352344baaaf2	3	8-12	\N	\N	\N	\N
c3a35de1-a15a-422a-ae9f-f3319f301e2e	62771565-e7dc-41d8-974f-bdbac57ea30f	3	12-15	\N	\N	\N	\N
d9bd90b6-cd1d-476b-89f1-9c40251594c9	51d5d214-592f-4e86-9916-3daa9bc5510a	3	15	\N	\N	\N	\N
827c4921-227c-4ea4-9fe0-881f61f4d999	3108357c-577d-4f37-9b7a-a29290f83306	3	8-12	\N	\N	\N	\N
84036827-daf6-4860-bc01-a2337de3391a	36be24ce-700c-43fe-93f2-35cbcc07ae7b	3	8-12	\N	\N	\N	\N
6aef4881-8271-437c-9b17-dc4c4da8d4b7	a07a77f2-e1bf-4946-a606-6dc2654ffcdf	3	10-15	\N	\N	\N	\N
7465ae19-22a7-4d6f-93e7-6fa129d6bceb	7ea4847f-59c0-4ffd-add1-8fcdecefaaf8	3	8-12	\N	\N	\N	\N
ac4bda87-8dc0-4396-b6b5-7063ca303020	c3513a63-c2b5-4d56-9825-71294e5b3fde	1	10	\N	\N	\N	\N
6394401d-ad11-49d5-b12e-4c641c8865f7	f5781710-77c1-4ba8-a0c0-d18749315fe6	1	5 Breathes	\N	\N	\N	\N
3028bc62-b24c-427d-8508-801322eb072e	d3293234-2683-48a9-b2af-230c77a37835	3	8-12	\N	\N	\N	\N
012f65ad-db2a-4657-a3e3-7b98ab95f745	ab61c4a5-ffe3-4244-b346-64718501507b	3	8-12	\N	\N	\N	\N
c9ff00dd-93e7-428d-a518-7305e3849f66	0c297aa2-8574-4de2-a7dc-a0b335230ac0	3	12-15	\N	\N	\N	\N
3e196702-64d6-4370-863b-617e54f914a6	91272cb3-e726-42b8-b02b-9d2240c5ef66	3	12-15	\N	\N	\N	\N
6162fc48-5c86-472f-a387-35b2fd4a2ea1	c121883b-5063-484e-b132-6c0e2660cb84	3	12-15	\N	\N	\N	\N
b05e735c-c03d-4676-aa6d-3effe4ebb5e6	9a5a6381-253d-4e8a-850c-84c6cbd51613	3	12-15	\N	\N	\N	\N
18d460e1-9ff3-4594-b9af-692dba26c145	90c64a3c-3237-4c09-b15e-44e6d32878ab	3	8-12	\N	\N	\N	\N
fc549a0e-2fb8-448c-b476-4029e2d249de	4505c6a7-eb62-40d4-9dbb-b5f9e6fb366e	3	8-12	\N	\N	\N	\N
eb49efcb-3299-4029-b6e1-36ecce48e756	fc7c1df1-d26d-43fb-963e-312ed492928d	3	12-15	\N	\N	\N	\N
1fed2ef2-0575-4e7c-8f6c-81532def5abc	9e1b694b-8b9e-438c-8dd1-97832ad4d570	3	8-12	\N	\N	\N	\N
d85256ab-43c4-4c67-b8a5-046fddaa0575	9c37c04f-20c8-493f-9ba7-c8534110a105	3	12-15	\N	\N	\N	\N
cd8f722e-7dd4-408a-b1b9-a14a48a28531	c64b7704-1da7-4f18-a448-bae191121283	2	12-15	\N	\N	\N	\N
e462b5f6-83ce-4bfd-ab72-1d6685ff3fa9	83aeb85d-e8e0-4426-80a6-de2fb458bb2f	3	8-12	\N	\N	\N	\N
d00d23dd-051f-41f5-882f-0e35a8f44383	0380354e-6a3d-4e47-ac95-9852f19a382f	3	8-12	\N	\N	\N	\N
cb07d076-6093-4598-b752-86e25c112b49	69ced390-3d26-47c4-8ce9-daa760f90c1e	3	8-12	\N	\N	\N	\N
bdb96efc-fb64-4a0d-bfcc-12c25ce22efd	6c43e921-5085-44af-9dec-307e00692898	3	8-12	\N	\N	\N	\N
04501070-c097-46b1-b278-ae57725934a4	33726ca4-9e91-4a3c-9cbb-8c7fc3e298a7	3	8-12	\N	\N	\N	\N
325a0703-0986-4f86-9dad-65e66993b640	d59250d4-a266-4d6b-bb60-4700bb1d2669	3	8-12	\N	\N	\N	\N
080419e1-6043-4b9d-a80a-fce08659ff2c	8e4cf7f8-bb90-4b5f-9632-8ad1e62259f0	3	8-12	\N	\N	\N	\N
cc3dff20-30f1-4223-93d0-b56b157cad60	9de55651-2fa7-43cf-9536-173d1e95e3f4	3	8-12	\N	\N	\N	\N
f45a396b-ff8a-47ad-b599-3c91552751b4	7119ab69-135a-4d74-ab65-a2e02c9c56a3	3	8-12	\N	\N	\N	\N
9c45f5f8-8133-435c-a736-460e021da462	9157e51b-5bbb-441e-a868-fc9dcd88fd35	3	8-12	\N	\N	\N	\N
f21ae0c9-b11a-4329-afa3-f47a7509d97b	4f74adbf-7b60-4f56-bde1-1ff1c34f036a	3	8-12	\N	\N	\N	\N
0a79301e-4d8f-459d-9479-f54a43e2cbfe	d91ed1ec-5e5b-4c59-a8b7-509c713abcdb	3	8-12	\N	\N	\N	\N
72b9c4ad-a16d-47d1-8786-dd9243681052	4c2322e6-6e93-4c4c-8f37-20673c992ca8	3	12-15	\N	\N	\N	\N
e0e430be-33cd-418d-a9a0-4df14017bd12	adcc1903-e53a-4789-b11f-0c800d7c832f	3	12-15	\N	\N	\N	\N
fd731443-f857-4379-b901-b573aa74f836	a115430b-5433-4c54-afc6-5d8656694b30	2	10-12	\N	\N	\N	\N
fd57a13e-021b-4102-b114-e3ed3909e2ac	29bec461-6e00-4621-ace6-b4c3426098bf	2	12	\N	\N	\N	\N
cc77dd3f-fd9e-4fa0-a967-174531d80f89	e18efa2e-76f0-4a92-aa8b-65175a343fe5	2	10-12	\N	\N	\N	\N
58da5a01-e7a6-45cd-877c-3ec65da3ddf2	ba0dbb01-dc25-4554-a712-828963208c52	2	12	\N	\N	\N	\N
1dfda3c6-4c1f-428a-b858-dd2d8ce7eeb1	fc16ddf6-2424-41fe-b07d-ebcab8f4bac3	2	12	\N	\N	\N	\N
1b3642e4-1d85-4ca6-b108-1ac43add317d	7041992a-52bf-425c-876e-804a4d32826d	2	15	\N	\N	\N	\N
f68ecb6d-7b81-4684-94b1-a2fae49d3306	c5f7e498-0115-47f2-9d51-e9c8903f8a75	2	10(each side)	\N	\N	\N	\N
e2028caa-e9f2-4cc5-8160-281022584a70	4e829657-edd4-42c1-8fd8-0d28af437ca3	1	10	\N	\N	\N	\N
edb015b8-7621-4cfb-937b-d0ef6b02340c	901c4bd6-14b8-4191-88b1-664716987e9d	1	5 Breathes	\N	\N	\N	\N
c1c85595-81e5-41de-ac96-9c638216a25a	785e3d72-dede-4025-8dc8-29b245875c89	1	10	\N	\N	\N	\N
e086e45f-7d9f-4aa1-aee3-294ed2796482	44e6be67-f6bf-47dc-bc12-69aec38df011	1	12	\N	\N	\N	\N
560e4ab3-f343-493c-90ff-b598cd6e5783	6cf57502-ccf5-4aa0-b09b-ec0dc0794367	1	10(each leg)	\N	\N	\N	\N
b0d3256d-607b-4847-b4e7-1a8c7161e467	8a647902-f2db-4f0e-9953-0ee4c151560c	1	10(each leg)	\N	\N	\N	\N
79e08525-d5ff-4db8-b8e1-cd27202bcc11	9801303b-63f4-4c9e-b81b-f03103060d92	3	8-12	\N	\N	\N	\N
859d576c-6c2b-4fb4-905f-3e2f910f5f7f	ff29d61c-5696-4ccf-8bc5-d1ebb330f6a7	3	8-12	\N	\N	\N	\N
8426fa9b-98ca-46d1-8408-350380cfaf3d	84f6aec0-7796-4833-b85b-d618be979086	3	12-15	\N	\N	\N	\N
6319c882-7b10-49f6-9eb2-721d9a0a7c56	18f7e7c2-c259-4b27-ae87-eb614de12d75	3	12-15	\N	\N	\N	\N
ca0dffe6-39ec-4131-9dfa-5f956f71fd87	5bf23efe-d292-414e-8306-9e31c39a4144	3	8-12	\N	\N	\N	\N
98a01ad7-b2a3-4908-84ca-7dc4602ec7fc	bae4749b-27d8-461a-bae1-337af3dae97a	3	12-15	\N	\N	\N	\N
69afbd19-aaaf-43ec-9b46-ee5dc14c5827	c32e06b2-b2f4-48c9-9a9f-9d6dc4753c5e	3	8-12	\N	\N	\N	\N
50c6225f-3a69-4ecc-8aea-e2a5410eb45e	1a7cc6f5-3d76-4dbd-935c-aa9a689f680d	3	8-12	\N	\N	\N	\N
498b3875-ccdb-4c89-8362-83eb0fabcac6	8fe20d4c-5d15-498b-9fd5-5c4752069e76	3	8-12	\N	\N	\N	\N
c5f2d5d2-645c-47a7-b0ab-ae013adbfb99	5ac92335-0536-4ce8-bdb2-8c5ecf159df5	3	8-12	\N	\N	\N	\N
7756ea47-6cbe-4026-85c1-aadf465ea1a3	73d67a60-5387-40cc-a021-e2eee7a6805d	3	8-12	\N	\N	\N	\N
83370d06-7515-47de-817e-817c94473427	75d233b4-e032-4342-a530-91a480cdfa20	3	8-12	\N	\N	\N	\N
3434de25-8725-45ff-813c-30764e13d3ad	cc0a7bf1-6163-422d-9a9a-fd2b5c072e19	3	30-4 sec	\N	\N	\N	\N
c559ab68-477e-4d18-8f83-a3feb05300e9	cd3bbd0d-e423-4391-9988-001d9d5fceea	3	8-12	\N	\N	\N	\N
9429f124-e3b1-4f00-b7a5-6da772bc3a2b	e3a11030-82e5-4da1-83bc-49e2676f61ce	3	8-12	\N	\N	\N	\N
2f550429-3d3d-4319-96db-c5112af1cbb2	e7aa95a4-e928-4403-b0a1-7e96fc4d52b6	3	15(each side)	\N	\N	\N	\N
1cc326e1-f796-40fa-ad7d-be43e8fe58ea	28512ef6-4959-42e6-a049-a475e18a23da	3	30-45 sec	\N	\N	\N	\N
cc3c36df-a0b7-4fe3-8c95-b74b1a52326a	77aba4a7-f561-4a5f-8d9a-e52203e3b2ae	3	12-15	\N	\N	\N	\N
8b3d3eb3-d45b-49da-9a43-1ae668253c82	4b3e94f2-3650-454a-ab69-c5a9b43a59c2	3	8-12	\N	\N	\N	\N
15607ef4-2e73-4bb5-9196-2faab8af2724	0feb6748-31d5-4d5c-a08b-a16ad29aa742	3	8-12	\N	\N	\N	\N
bef16d94-4a8f-4aa9-b33d-13cdec62dd56	dcc068ea-52ff-4370-a6e2-5a1c1330d464	3	8-12	\N	\N	\N	\N
2691e2dc-4173-4ebb-981a-4a6973d32451	dd1367d0-4a52-4c5d-8952-94f93d4f795f	3	8-12	\N	\N	\N	\N
3d752527-8f80-4ccd-8242-5f053955d7dc	735a779f-45db-4f91-b444-e72de6cc44d0	3	12-15	\N	\N	\N	\N
013382bb-b3b0-4dc8-b0e4-db148113b466	430d105f-0507-4d81-9b7c-ed13642b8de8	3	12-15	\N	\N	\N	\N
4471eb81-e068-414c-bb4b-597e4f1e4764	1de5303f-a1eb-42cc-b6d7-6bdb98816883	3	8-12	\N	\N	\N	\N
fb288715-6a64-4400-ad33-0479c01500c8	204104e3-21c9-475a-bd88-825e7fb4f0c7	2	12-15	\N	\N	\N	\N
8a4fe27f-4b6d-4748-a24b-9bd4cafc5edd	50b6002f-277b-4b40-afc8-4acdaa119f85	3	12-15	\N	\N	\N	\N
85eb6265-a0ef-43ed-a1a6-0f7656449afd	e6cc030b-8e80-4e94-ba1a-b41105f48379	3	12-15	\N	\N	\N	\N
543a2504-0268-449f-af38-9b1bc9654852	bd6b0551-3e93-406d-bef9-93f06de1bf11	3	12-15	\N	\N	\N	\N
739b683b-655b-4edb-9cc6-e3f495355b3d	0ae733c1-976a-44c3-af79-f1651ef6d1cc	2	15-20	\N	\N	\N	\N
0bacea13-c20a-4626-89c2-d3b001fa7afb	9c49db8d-b57e-4667-a6d9-883b0b3f48f4	3	15	\N	\N	\N	\N
4af5612a-6916-4dbd-83c3-9a81b1a5445c	6736c736-ad77-40f2-8c79-4a8a9c88b79c	3	15	\N	\N	\N	\N
13e313e2-35ff-46bc-8e48-ea9f372d8a42	18ee5535-7629-489b-81f3-a7d0efb23fb7	3	8-12	\N	\N	\N	\N
eff030c7-2512-4a47-873c-bfa3796e1e3b	b7dbd1c5-ed05-42de-9785-9918d897a7e5	3	8-12	\N	\N	\N	\N
32aeda34-5673-49dd-958e-fdbb173cd167	0495ad7d-fd05-401a-b29b-e1b90143bfab	3	12-15	\N	\N	\N	\N
1b824bf7-ee6f-40a4-a6a9-583d9bf47675	d61464ad-cc37-4fd9-8019-7a11115e3c83	3	12-15	\N	\N	\N	\N
d0d9fc3b-db33-4780-b2c2-a0e7e87f455c	2621377a-d506-441f-bc91-5692c18c3f31	3	8-12	\N	\N	\N	\N
c73860ae-2bb5-464b-8c96-06e00efd4aa0	73b0f0c3-d7f0-49c2-814f-d2a5c925d19b	3	12-15	\N	\N	\N	\N
0d3cd09a-af09-4bfa-bafb-9ec10ba111d2	5d61a0d3-d98d-4b99-8c16-95564c52b2d7	3	8-12	\N	\N	\N	\N
9f38a93c-57cc-4011-a3dd-1cf389b4d19f	34a71cf2-2bc4-4597-8fce-d59a4d9e2d96	3	8-12	\N	\N	\N	\N
26e0189e-d18e-4e98-b033-977f01844aeb	7eb8a0d1-9658-40d5-90c5-e720382c41c6	3	12-15	\N	\N	\N	\N
ca127032-49e9-426d-bd0a-d063bdc83c55	cb8806da-272c-4aba-8eed-99442aa55e4b	3	12-15	\N	\N	\N	\N
176b0398-d5f6-42a4-801d-1060b93742ff	cf2628cf-c887-4abe-acf1-ffdbc1c17d05	3	8-12	\N	\N	\N	\N
2c172775-521a-49e4-9ebd-f69052712925	570819fb-aefb-43bb-9116-d7b5cca3c949	2	12-15	\N	\N	\N	\N
1f5f1da4-0af5-4134-95b7-299010b9105e	3bbbf4eb-784e-4a09-a416-ee2af0fbe0c5	3	12-15	\N	\N	\N	\N
c24ea082-a387-4ac6-a686-f611e73d976c	8b368c38-2585-4c78-a0aa-4291eeb0bed0	3	12-15	\N	\N	\N	\N
ebc5d748-0443-429c-8dbb-7c4e9c04f884	a1c50189-5b2b-48c4-b2cd-e719ddc56027	3	12-15	\N	\N	\N	\N
76118b59-86c1-41e8-b536-167626f74825	ec716fe1-113a-4370-91ad-1e3191335d2f	2	15-20	\N	\N	\N	\N
f705c9d6-957e-4593-b1a3-61116b9b9828	9293c77a-af4a-47ec-b662-e86fb75cbff9	3	15	\N	\N	\N	\N
46f666a5-4345-4866-8437-1c9851d27b68	1ffb5efd-ee1b-47eb-ad77-6fc31bb61724	3	15	\N	\N	\N	\N
7123cb36-b383-4748-b2ae-972d1512edb7	283a4330-7b46-44a7-8ecb-cab3be31f961	3	12-15	\N	\N	\N	\N
d47cf669-3c6f-4d20-9086-8a84b2ca39a5	a7442f52-cae1-4dbb-9158-2147b1f893a3	3	8-12	\N	\N	\N	\N
d37d8a3b-17d4-4688-bf81-72d57cbd7cf1	51409d5b-8a86-49c3-b9c0-29be07ca4612	3	12-15	\N	\N	\N	\N
2932c29b-9f0a-41d1-87be-5c61a14891cc	9902e42b-e6d4-417b-af9c-0e8e2ce839a4	3	15	\N	\N	\N	\N
3af6f60e-627c-43a8-b67f-fee05e1ae83c	11fb7ebe-fa8a-4820-9516-1b36892a0403	3	15	\N	\N	\N	\N
9d137bd8-8b56-4368-9062-5a58bf33bf8c	6beb0f49-70a9-4e6e-b294-0dc0343c7021	2	15	\N	\N	\N	\N
5d244cb2-8a00-48d0-bb7f-56fa8c6637fb	4782d2ff-3d98-44e7-9fea-fdbe7f4d6ddc	3	8-12	\N	\N	\N	\N
feebd6d2-538f-43b9-8e7d-d9e08c873616	dd0e15ea-529c-40e7-8338-85690c243496	3	8-12	\N	\N	\N	\N
aec06a61-1fbb-4c71-8c8e-6898787e4ca0	0eeb939d-f2f1-4d4f-ba66-fd58c6aba469	3	12-15	\N	\N	\N	\N
625016d3-aa7d-4c22-9b5b-edec550cd96d	a3a5fff5-1d80-426a-beb3-c4550853a688	3	12-15	\N	\N	\N	\N
fbf1f138-b2c1-4230-9cfc-7263cad7ee11	544e44bd-1e9e-4aed-a683-58d11634e118	3	12-15	\N	\N	\N	\N
e977fff6-9f31-4c71-bb50-3895d5bdff98	dc9d4188-02ff-46f6-a30c-48c92387ca9d	3	12-15	\N	\N	\N	\N
f134ba0b-bb39-47c8-8bb9-072217034e2b	a601fa4e-d96d-49a0-b4ae-722a11cea185	3	8-12	\N	\N	\N	\N
1ace0135-69c7-492c-ac84-2b15a2863ad2	3b238555-607a-43be-ae9e-ff136c0d7dec	3	8-12	\N	\N	\N	\N
04df6457-7845-4864-8527-0c7329b2b5b9	0b511a97-1b21-4907-ad93-d6a35334bcb2	3	12-15	\N	\N	\N	\N
3dece72f-9898-4efc-8575-f520088d80da	fff13cf0-b65a-4f5e-b551-63ba2e07270f	3	8-12	\N	\N	\N	\N
f7ad59c4-b80d-4c03-92ef-7476d0b00608	3f0f6177-b9e1-4050-b4b7-bf1efe348fa7	3	12-15	\N	\N	\N	\N
275657cd-7d4b-41f9-81f5-38aff2d700b5	17fa0f88-d1d6-4349-bbe4-cf6d5a93e5b1	2	12-15	\N	\N	\N	\N
cded1d0a-9782-4bd9-8715-ef4786008898	04d7eb01-a128-4db4-891c-97fbe2539ab2	3	12-15	\N	\N	\N	\N
10e8762e-4070-452d-aa97-e501c5158653	9cb83099-9213-42c0-b628-4d3567995c4e	3	8-12	\N	\N	\N	\N
2c409fa1-d139-4c39-a190-3ae06ab97444	320b34c9-f872-40fb-abb5-b6fb436287e5	3	12-15	\N	\N	\N	\N
e3768a91-321f-406f-9f2f-b1e878c662ee	314dec7c-7449-447c-b77a-99e2aca2930e	3	15	\N	\N	\N	\N
515b9a53-52a6-40ea-83e7-dd4bf22a5a7a	e60cd32a-6ded-484c-8f68-26ee84ad2600	3	15	\N	\N	\N	\N
c443530a-851e-4385-8274-1afbaad3222c	55f3224f-a814-49ff-977c-998d6b8f301f	2	15	\N	\N	\N	\N
f634007f-0ddc-4243-9d91-463a8b30a512	0668a04c-f746-4bdc-a5de-54242c727d13	3	8-12	\N	\N	\N	\N
ac34a840-fa74-4ebc-8838-a2f19927036d	57b9711f-9bf8-44f0-8d37-949e52c42c48	3	8-12	\N	\N	\N	\N
7831a647-d8e3-4fc2-95f5-1b8cf1582036	70e841cb-77b3-4972-910b-ffaeed1a2ecc	3	8-12	\N	\N	\N	\N
89604a67-6420-4c12-a351-29825d275962	7dd68ba5-7438-4a91-8469-665ef168704b	3	8-12	\N	\N	\N	\N
c2d0c7a2-4685-4257-948c-1bed80cce113	ee3ed048-e3ab-4879-b9e4-674ee326aacc	3	8-12	\N	\N	\N	\N
ec0587ae-fb50-4cfb-8bfb-c0277229ce86	6b68970f-e954-4511-89b6-1aa4ab0d0805	3	8-12	\N	\N	\N	\N
0ebace0d-0b01-4acc-ab7c-dd8330311651	9feeca0d-d768-4d05-a486-dac4473a12b9	3	8-12	\N	\N	\N	\N
a6f6a794-4281-46b5-8974-38b427f7af84	b8339273-2e2f-412c-b61c-af814ad81c90	3	8-12	\N	\N	\N	\N
65ad3491-d60e-4894-b461-e6fa79579c7d	0eabe17c-523a-4362-829e-acc553431ca8	3	8-12	\N	\N	\N	\N
8a73f56c-1347-4682-9613-fb295e2f44a3	38475491-d35a-4339-8dd9-63f99df24477	3	8-12	\N	\N	\N	\N
36df4f8b-5003-469d-8309-f2e9d82dbe87	cabe16e3-1762-4b87-884c-68893cbc7c24	3	30-4 sec	\N	\N	\N	\N
abfbc7dd-847a-4d7a-958d-7276efdfa4ab	1b191524-c56d-4c0d-822b-5ca14f05c384	3	8-12	\N	\N	\N	\N
08cae978-eac9-4016-a0d8-1e8f2cea2f0b	53daf9ba-b708-4d07-b16a-450b34fb2e2a	3	8-12	\N	\N	\N	\N
720727fc-4348-483f-b308-d706a2431c64	5aae8d1d-ed57-4a4d-a6d2-2ffad3c89ad5	3	12-15	\N	\N	\N	\N
79c111c8-1baa-4f06-967f-e64ebbba7049	609f709c-fcba-452e-b64f-fb2eb7bf8bfb	3	15(each side)	\N	\N	\N	\N
aaa6ae5c-4a1d-41ef-82ba-189312a50855	b3b69350-b0b7-41e1-a0a2-4ff39e0bef32	3	30-45 sec	\N	\N	\N	\N
747ce8e8-21b1-43ae-9e6b-0b2e6fe930f9	865bfa72-fc5d-4b18-b59a-08d2af89e852	3	8-12	\N	\N	\N	\N
5de2d8e8-564d-4021-b619-42b566a60050	e6663882-581b-4a96-a1fb-0d56725efa62	3	8-12	\N	\N	\N	\N
746fd170-c94c-4059-8e8b-0d2187259a49	0a2aaf77-572b-48b3-97ae-dbc9cc475b3b	3	10-15	\N	\N	\N	\N
26d4d4e7-6663-41c6-95e7-c9fdf87ad6fc	ad90ef3c-7f71-40bb-8443-01bb702e6c85	3	10-15	\N	\N	\N	\N
15b7125b-8e7a-4272-80ac-0c883bfb5d54	e89d940f-ca93-4b98-a022-e8098b092197	3	10-15	\N	\N	\N	\N
504b2bd7-7364-4a98-b765-3a614d3a9618	815c76a1-61ff-41ce-96fa-b64be03131e2	3	12-15	\N	\N	\N	\N
1c371bfa-ccf7-46f7-bf7d-6f521fdd14c1	716eed91-5ec6-427a-a3e3-ea3f81ed8320	3	8-12	\N	\N	\N	\N
ac87dc0e-357a-4558-8997-5b8407e1db99	eb3104f6-2861-43d4-982f-2b449bc1a2f5	3	8-12	\N	\N	\N	\N
8a8547da-9f35-4af8-a20c-e9f99078bbfb	5e85c7fc-00ab-4aad-adff-fb68faebf254	3	12-15	\N	\N	\N	\N
fceb0328-241a-45a3-ad7f-71d4741e7ba1	dc809fcd-2b8a-4d1e-9b53-1a5c0a10e75c	3	10-15	\N	\N	\N	\N
47fae3a1-dfc3-47c4-809d-e4e16f12b14f	287a6e7b-86b6-4a6b-a6f2-71a9984e7da4	3	10-15	\N	\N	\N	\N
7f4f67df-b2ee-4a92-9a52-70e948258253	e2b32e40-e0ed-403a-beda-d6c84f4343bc	3	10-15	\N	\N	\N	\N
2f342001-4b67-425f-8f29-827493205f9a	81e60497-50b0-432d-9e30-d3a884adcbea	3	8-12	\N	\N	\N	\N
cba80fbd-50a2-4b22-887b-abf49119dc92	2050613d-07a7-4533-b45b-7453546902ae	3	10-15	\N	\N	\N	\N
97199cf3-4cbe-4409-b0b8-b65563e9f964	3880e992-2798-4a3a-a2ae-7e16ad3f21d0	3	10-15	\N	\N	\N	\N
521c4b53-9064-4257-9208-8f735175f470	93d0fe4a-12dd-4171-a9c2-a8a7f8078914	3	10-15	\N	\N	\N	\N
b4b7d1fc-7fdd-47a2-8685-e786c3bdca75	f573dca3-9343-4a84-a762-418f10bb304e	3	12-15	\N	\N	\N	\N
7074414d-e830-49b6-b538-c7d746534837	4806a2ac-72dd-449d-8e80-70fb18215cc2	3	12-15	\N	\N	\N	\N
8c7e7e20-a601-47cf-a0b5-ee23f0b59fe0	5341b874-65f5-46cc-82ef-6abb13a5ad84	3	8-12	\N	\N	\N	\N
636c13d3-eb50-43bf-bddf-310918c80a82	d7fe20a3-b005-492f-a797-68a03b13897f	3	8-12	\N	\N	\N	\N
bd44c216-096b-46d8-b6b0-3f06eb32ab54	1ccd1b2d-bd24-4ba5-8205-d726e8fa765d	3	10-15	\N	\N	\N	\N
1c92178a-7e52-46ab-a4b6-b9b1ad2aa09c	f7e0aee3-e979-42dc-ad90-bb7ea6351fea	3	10-15	\N	\N	\N	\N
75590d11-8f33-4ead-ae8c-f98af806ee5d	0030b8f9-671f-4515-bf52-462eb727b1ff	3	8-12	\N	\N	\N	\N
fc7c745d-6688-4824-af33-90b2b33414cc	aa22e02c-3409-470a-984d-ab8941dfdeca	3	12-15	\N	\N	\N	\N
9a107192-3a74-491e-b937-ef70a641a2b7	b458c54c-351b-4277-ad97-6d5d22d84930	3	12	\N	\N	\N	\N
64191bc3-578b-42dd-8589-f7373f8c7e4e	5125ac62-eb64-438e-bb13-b77060978ae9	3	10/side	\N	\N	\N	\N
31844435-93e5-4e1c-9b44-c987d65df797	36d531a7-ffb5-4089-8065-5977daa2fe7e	3	15-20	\N	\N	\N	\N
eec75523-f543-49fd-bffb-47b919b6e170	0120de7f-cee6-4cac-979c-6ade0d656d38	3	12	\N	\N	\N	\N
e069cce8-261c-4340-98d8-c49ec616c69a	762c9383-5195-438f-bab5-ad5e60a78082	3	8-10	\N	\N	\N	\N
d868b205-1319-493e-a7d5-1c403767fc8b	2123d118-5a5f-40f0-9c64-10d39cd53a6e	3	8/leg	\N	\N	\N	\N
0c9c9ad4-8d65-46b0-a2a6-262f9604145a	2f29470c-384b-49e4-87f4-1811e02c24be	3	20 sec	\N	\N	\N	\N
8838090b-6c0b-48bf-afe9-71b007bc76c7	4f8844db-d1dc-47b1-a763-a318ed43592e	3	12/side	\N	\N	\N	\N
e338d0a6-48e6-4d89-9202-fe2a9fa022ad	8c8dd26b-ca46-486b-b442-e496d1a51bff	2	20 sec/side	\N	\N	\N	\N
e845c108-360a-4f56-978c-9402950f43a5	e7c770c5-f5db-42a1-bbc0-7b47a7588c21	1	30 sec/side	\N	\N	\N	\N
a405e444-d42e-45f5-a429-c1865375790d	02b4d117-600a-4663-832b-74a80cb35d3e	2	10-12	\N	\N	\N	\N
fc267e08-5fc8-40bf-a37e-24573cd79146	30cccaa0-3ed2-477c-9938-a188410c030e	2	10-12	\N	\N	\N	\N
499e87d5-7304-4e7d-ab7c-fcc628c888de	17173575-ab6b-4623-a265-962dcbd076e5	2	15-20 sec	\N	\N	\N	\N
e3a55a0d-b974-4ef7-b207-070813884678	e1a428a8-0b42-4f10-9bdd-52ce3e124172	2	15-20 sec	\N	\N	\N	\N
b65556dc-9b7c-4100-9a5b-4b2d74c2da3d	95e3e409-b72b-4d14-a140-bb110c6f7638	2	10/side	\N	\N	\N	\N
d57cb62b-548e-4112-9e43-d3b667ff873f	be202e25-0357-41cc-9bea-3a199f47f389	2	10	\N	\N	\N	\N
65a16db8-e247-48d8-9691-92304b322e38	0145f0a2-6015-413e-a60f-58310a6043e1	3	10-15	\N	\N	\N	\N
ca0e2e70-0532-41c7-af34-7ea84fc56ca1	8dae9eae-9a61-4ec9-a7bc-8e0aaed4d7fd	3	8-12	\N	\N	\N	\N
225fe309-b573-4de6-9419-630d00f559e6	5c8fa0a4-c403-4704-bb35-66d4015e5c8b	3	12-15	\N	\N	\N	\N
beb6316a-9f1c-4b7a-ba36-b40a55f197a4	e0892c7c-a382-4d36-9a93-025e05c4fdf2	3	12	\N	\N	\N	\N
f42b0729-3712-4703-b559-c3f78da8cb0d	3752827b-7a60-4ee7-9ef3-c7d57de268c9	3	10/side	\N	\N	\N	\N
db77a147-9ad0-42f2-8ad8-65d622e9ba1d	6f95c836-948c-43da-a90b-87fa162373b2	3	15-20	\N	\N	\N	\N
d94598a2-9066-4402-a170-9a13242eb0da	36adac09-1d1a-4bce-877e-edfae6bfeac9	3	12	\N	\N	\N	\N
e18d74a2-fff2-4476-bd69-35e35a42063c	1fb9a110-405b-413e-b2a6-61cf875bfad7	3	8-10	\N	\N	\N	\N
e90ad6e6-5b0b-4e20-ab96-acbe8424a40f	12559ab7-aebb-438d-a7f5-08656f6fbdd2	3	8/leg	\N	\N	\N	\N
5631bd11-06bd-498c-8f37-03849ee64d2f	1e4c10a6-33fe-49c4-ba10-b055acd92383	3	20 sec	\N	\N	\N	\N
52d3a186-9c65-42b7-92c5-d93906609d1d	edc51e77-37d6-4127-b4d8-906c283b9338	3	12/side	\N	\N	\N	\N
6fb7f031-39dd-4492-8b28-af6d5fe0766c	0631a0df-542c-4937-84d2-a86173cd6725	2	20 sec/side	\N	\N	\N	\N
fd5be7aa-ce44-43ad-8b24-0c2b856cf0eb	1b786d4c-4609-4a47-94f6-9301318bff6b	1	30 sec/side	\N	\N	\N	\N
20d01ec8-83ec-427c-a62a-ea6a16c4e901	53a1d5a7-a270-4fcb-aaf8-0783e36c4b42	2	10-12	\N	\N	\N	\N
430166b6-12c1-49b6-a95b-557006097223	93c266d7-2e98-4e57-ad84-2e90e75e7069	2	10-12	\N	\N	\N	\N
3a0dbeb0-8dcf-4943-993b-00d243471406	d1ea347c-82bf-4e3d-bdd3-0ccfcc5b64ed	2	15-20 sec	\N	\N	\N	\N
3300a229-67a7-4917-9af7-f4e054139c4c	4a3b7069-e1b4-4d50-a0c6-c054e5245a0e	2	15-20 sec	\N	\N	\N	\N
80ff238a-9c8a-4e02-b45d-a7946b94f374	4b610fbe-93cc-4127-b7d3-f37a61ef2153	2	10/side	\N	\N	\N	\N
4823ea4f-fddb-4cba-a1cc-25d678b54cf8	961e438b-375c-4734-8e2b-6c38a8933b75	2	10	\N	\N	\N	\N
49d7fd5e-311b-428b-a023-5ffac03a66f5	8c8bd2b1-04d5-4a0a-b974-55bab59e9a71	3	8-12	\N	\N	\N	\N
9167daef-54a8-4a17-8db7-624cedeb0b7a	2f2afd46-e328-4eef-bc5c-73287392adf0	3	8-12	\N	\N	\N	\N
5e00e1b9-ccfb-49e9-8146-27ae381c0638	c5fbb639-b771-4987-ab94-820decd4b5e4	3	8-12	\N	\N	\N	\N
23d4a0e2-958a-453a-a3d1-93564c35f85c	d3d33afd-4661-4820-8eab-ef264e6014fb	3	8-12	\N	\N	\N	\N
1385ed5c-8e63-4f4c-8a54-c2cdad6d349f	cccd296f-f8e5-41fa-b0b8-34c71938d921	3	8-12	\N	\N	\N	\N
b0c1bb3c-6c45-4eb6-b24f-769c970857ad	4350601b-2d9b-4888-803a-2d7c5ff2f2d6	3	8-12	\N	\N	\N	\N
571c8958-cc55-4d12-8077-47c0284736e7	6f90423e-ae8c-46e6-9582-0b6e88ecc35f	3	30-4 sec	\N	\N	\N	\N
e8cb4e34-95db-4faa-8c36-38cac4776f61	b9e6347d-01cb-4f07-82ae-78bcad0440fb	3	8-12	\N	\N	\N	\N
4ceccecb-edaa-4b07-9748-fd380155843f	f70760b2-7ff4-49b3-aba1-e1cddd61b60c	3	8-12	\N	\N	\N	\N
3310e78a-afda-4edb-bd59-e8eafe67ea9d	d062e162-4e98-4000-be74-2f8c78460fcd	3	15(each side)	\N	\N	\N	\N
5f4ad117-14f3-4be7-b0fb-4650254bf88d	47531ead-9f24-4e92-8a55-684d90737943	3	30-45 sec	\N	\N	\N	\N
6f301b36-ee9e-475b-a367-b1e11a6da5bf	648edddd-74a5-416b-82c3-dfa9fd5cbdca	3	12-15	\N	\N	\N	\N
d5a91f0b-d82b-4b96-b2ff-c5d3e7902ace	1147aee6-ea82-4343-96d7-4760098694b9	3	8-12	\N	\N	\N	\N
5dca2c14-2446-415d-ae79-cd08d5029ea9	573763e8-fd63-489f-be7c-aa7e510410f3	3	8-12	\N	\N	\N	\N
30725924-4027-4382-abee-01e6ee894773	1436cc25-98e9-4c23-a41b-80b2db184fe0	3	8-12	\N	\N	\N	\N
6b4db4d4-f2d3-4fc2-ae4c-ec4207f39d0d	a3c8d1f6-0c7d-4b67-bfa6-ce706cb80f79	3	8-12	\N	\N	\N	\N
cec88178-d751-4fb0-9327-609d227408d5	86e80e19-787b-4ac4-a893-f20dd9473911	3	8-12	\N	\N	\N	\N
4c826826-b623-427b-97da-dab74919e72e	093f66fa-9faf-4c1b-b896-602a2bcf8822	3	8-12	\N	\N	\N	\N
ed4e7416-8eb8-4298-8064-3a3e4d45a5a3	11fc98c4-8afc-4034-a153-f3671334f922	3	8-12	\N	\N	\N	\N
533e9a64-53c2-4c5a-a074-8533363ba35c	089264b5-a6e3-4797-bca0-7dda4c6d4d66	3	8-12	\N	\N	\N	\N
54c1069a-4d02-4a37-93b7-15337e607ec1	b05aad90-fb05-46d2-9a72-6ce54fb844bc	3	8-12	\N	\N	\N	\N
8f9233a4-642a-49af-9325-3fd07091a876	d34763a5-d9ff-49e2-8b2c-cc309eedcdc7	3	8-12	\N	\N	\N	\N
8971f218-6e41-4481-a3b5-815c3a81b8f1	65eee79b-77fd-4df2-94d3-eb5a84198971	3	8-12	\N	\N	\N	\N
c48de1cc-6627-42c9-a7fa-c5434c4cc0b7	1e3bf5bd-d379-4ac4-a267-ccde9cccd43d	3	8-12	\N	\N	\N	\N
398c3d1a-2385-4efb-9786-cabecf44496d	f453c872-e287-4923-8bfb-b0fa3dc81f50	3	30-4 sec	\N	\N	\N	\N
2965875f-a548-4027-8c14-013e53bf860b	7e97acc1-917e-446f-8fa0-8b1483b4da0b	3	8-12	\N	\N	\N	\N
cb6b6c9f-be6b-4955-b383-7ed5f7610fd3	e3eac23c-dc48-454b-8b29-4332b96b20ed	3	8-12	\N	\N	\N	\N
1c8c701b-792a-4120-b9b0-78922061764d	65c7dbff-180d-437d-832b-7aefcdd31e1f	3	12-15	\N	\N	\N	\N
dd5a2588-2468-465c-85bc-cc62314d8c2c	590cbfb8-cae9-4f0e-8180-a24e5bdf06f0	3	15(each side)	\N	\N	\N	\N
54759de9-f479-474d-856a-9613aa50feca	b899f855-0c7d-41ce-971c-d6ff1e7c75f3	3	30-45 sec	\N	\N	\N	\N
c9721fb7-e8e1-4047-aa18-11cd08465395	46750af0-6068-4c88-9228-a42d7f7fb978	3	10-15	\N	\N	\N	\N
65a1730d-24bb-448e-993b-7832c41e8e60	555d096f-1400-4ee1-a10e-59d9ac5f177d	3	10-15	\N	\N	\N	\N
9cfb6968-ece5-4086-8114-e58a54ae3bd5	b55a9f35-09c0-4ad1-a7ea-2c7185f1194b	3	12-15	\N	\N	\N	\N
c793363b-becd-4f6b-aa89-ce39021bad35	b8fbea02-88ff-4b2c-888b-de2d5a5f7c7b	3	8-12	\N	\N	\N	\N
d0db1256-0876-4b48-be36-9709c1683abf	2dcd0206-b9cb-4a79-b71c-36c0f79747eb	3	8-12	\N	\N	\N	\N
012cd660-04c8-4d37-9476-f4ed74d7755c	5dcf220e-d93e-4e06-bdd7-51cb5e4a9713	3	12-15	\N	\N	\N	\N
85524752-a167-4379-88a0-3dc60cf992ec	275a7815-06ab-4eda-9af4-11218c3d97a2	3	10-15	\N	\N	\N	\N
4bb3622e-f4a1-467c-aaa9-04c69a037222	4ccd4316-3496-43de-af62-d14fbceb918a	3	10-15	\N	\N	\N	\N
655fad48-1c5e-4813-b594-16b531ca8d24	4594a4c0-e9e1-430e-96ad-30295f6cc10f	3	10-15	\N	\N	\N	\N
73473f47-dd84-48c9-9286-c2791e487398	fa42a2e3-c214-41f3-9010-bd9970d1d109	3	8-12	\N	\N	\N	\N
1b9f9e5a-f332-4211-86a5-8c40f339d661	7bcee3dc-b35e-4ca1-86f2-db7286c3de5e	3	10-15	\N	\N	\N	\N
4a51cbe9-b9a6-4b15-9812-823ad75a815f	9ca3df87-0e63-4451-b3bb-1078cf6df4b7	3	10-15	\N	\N	\N	\N
dc4c5142-26e8-43ab-8cdb-b1daab32989f	339322a6-89d5-41ec-bd68-7f728e032c47	3	10-15	\N	\N	\N	\N
4573cf14-57fa-4ec0-aef5-18f0638feeb7	2c8f047d-7ae1-4774-aeb8-8b252d48358e	3	12-15	\N	\N	\N	\N
1d72e189-a909-40b1-9ed9-4f8979635941	5932a50a-11a6-4d7c-9d6f-644b44e82c9a	3	12-15	\N	\N	\N	\N
239cbe8a-e41d-4a50-880c-c2fb0224cbcf	a9e24ac2-a60e-4e58-aa9f-d9960d25fcf5	3	8-12	\N	\N	\N	\N
0d0d15b1-9b8b-4d8d-85d2-9331eb4f4337	956ec9cf-ba02-4ada-b6b5-b8cb53502d4f	3	8-12	\N	\N	\N	\N
e97b1104-8ff5-4649-b7a6-bdebf9086d07	dba71ef6-79d8-47be-9345-299e6df5988b	3	12-15	\N	\N	\N	\N
703e9638-1316-4d2a-8773-2a64cca4a4c6	27388afa-e572-4fb4-80b1-5f47f5c328e3	3	8-12	\N	\N	\N	\N
4574c024-7add-43a9-b246-dca75dbc0cd8	30c05fe1-743f-477d-9d95-dfe41b1206c7	3	8-12	\N	\N	\N	\N
d2fd0b89-e8c2-41e1-ad94-28e5d5553873	2b18d28e-3aa6-4f9c-9ebd-c24354d71b64	3	12-15	\N	\N	\N	\N
5c70025e-6146-4558-be4b-a1210068544e	09b52b70-27a6-49a4-8ff0-4ab844810c9b	3	8-12	\N	\N	\N	\N
36afddbe-688a-4472-a51a-88cd6637cf41	52927e49-1fc3-4f91-9ec6-5aaf1149fc08	3	8-12	\N	\N	\N	\N
20f86d90-aebc-4c2b-8773-c008ca6d41db	adb5ab32-a30f-4c3a-881a-f83fb27b43d6	3	12-15	\N	\N	\N	\N
db7db3d1-68b4-49ad-8f5b-b966a9545e8e	d7a4b76b-d96e-4730-bfb4-7c6613cac725	3	8-12	\N	\N	\N	\N
8d7a87ef-36c4-48f6-8367-6893f43569b3	0235b1fa-3375-45db-8664-d3dda0aee61c	3	8-12	\N	\N	\N	\N
4f26867e-c9ab-44ae-9dd6-d9a42885f56a	fa275758-36af-40da-a6db-1a760a57b557	2	12-15	\N	\N	\N	\N
a277fdc2-4536-4a9f-96da-e6c923969d5a	83ae99f1-ab89-4212-8f48-53313c385220	3	12-15	\N	\N	\N	\N
103588c5-c664-4f4f-84d6-3c9d22b3ed0b	8d2343e7-b0c5-4168-a489-c9e1c1c6e10b	3	8-12	\N	\N	\N	\N
376ec304-ae37-47ca-ab6b-5ded8be8882a	ff12600b-3082-4cdf-b966-94f98c5a099f	3	12-15	\N	\N	\N	\N
65aa3c57-a871-4a33-b9fd-a897fc87c996	590b2116-39d9-4275-9b0a-dfc3fba97f39	2	15-20	\N	\N	\N	\N
d52e0ebf-1c59-46d2-857c-38f023ca00d9	3b43c182-05b4-4fee-a090-2abb5e88bc5a	3	12-15	\N	\N	\N	\N
4b405443-e57b-497f-9192-9ee7e8e322a4	25798157-4cbb-434f-89aa-e82bacd616db	3	12-15	\N	\N	\N	\N
3b25a27e-ec03-4c1f-b1c3-422645e63a19	f0f43c24-a59f-4793-a26f-ebab5ccb2dec	3	8-12	\N	\N	\N	\N
90117898-b272-4a9f-a5da-198e52ec210e	383a1213-67e3-4f32-b84f-bb8565e2f047	3	8-12	\N	\N	\N	\N
f9017bd5-6f0d-4962-b411-11167cb033a7	ba194888-8c1d-4070-a82d-6d5588510c83	3	12-15	\N	\N	\N	\N
769353ab-c53d-4120-819a-b337b50a7e7f	cf6738c8-bfba-411b-b608-49c56751eda3	3	8-12	\N	\N	\N	\N
264290a8-52e9-4f1c-b256-99764ea1e8ea	f2d4d79b-054c-4fcd-a90e-d2be31a9c257	3	8-12	\N	\N	\N	\N
1fcaadda-6a91-496b-9acc-67b11f5b2712	88d6954d-2f62-45e7-baad-24d9c4354f32	3	12-15	\N	\N	\N	\N
db745a5a-5393-4433-98cd-f51c4a0f5607	9ee40ead-ab07-41a3-a6c7-1f2eaa5b711d	3	8-12	\N	\N	\N	\N
07d4f0f5-b399-4613-89d2-4dd41836c115	da0c0e4b-5138-4a47-9691-5930f9a62863	3	8-12	\N	\N	\N	\N
72198f8d-5bda-4acf-9f73-68038148b86c	703dedfd-f0a6-49ae-afaf-40cda2c732c7	3	12-15	\N	\N	\N	\N
fba45ede-ef77-4168-8774-2e7b128022ff	0975824f-f8fd-4e22-b51d-2f8a4f963f7d	3	8-12	\N	\N	\N	\N
41056873-30fc-428e-b13a-9e68c3a068c9	5bf7727d-a81b-42e6-9a2b-2218d4461aad	3	8-12	\N	\N	\N	\N
24391bcc-f443-4005-a701-50586e0bc0e3	0cd9bca4-cd57-4aa5-93d9-d5310a08299e	2	12-15	\N	\N	\N	\N
e4d70f6c-cbb0-469e-8df8-783a7b57573b	98c77b35-be5f-4e6b-af41-62b30a5320fc	3	12-15	\N	\N	\N	\N
1c9d33b9-15bf-4b83-9c83-6ae4d5122666	8c007f66-3eab-4909-8966-9af38c9f3c74	3	8-12	\N	\N	\N	\N
9694f558-204c-48ca-8b7c-8793f3277710	b24cf96f-b3fa-47b8-9054-5c3a1e0adfe6	3	12-15	\N	\N	\N	\N
ecf033b6-67ab-48b0-9e58-7c54a0f04aee	14a3a831-3ef4-465c-a6f7-1e9494589490	2	15-20	\N	\N	\N	\N
434334cc-ff54-40dd-a09c-c9d15bfc7c41	5ff1591a-d431-4855-aa49-f5e8efc43240	3	12-15	\N	\N	\N	\N
1b93a8b5-4ad1-4f9c-be77-6729409a2ffb	18665ce1-96c0-4a15-afb6-941d4d2bdaa5	3	12-15	\N	\N	\N	\N
0362fbc7-e02b-4a43-839f-a6796f4dbdf5	b306a1f9-61ec-4577-82cd-acec13d4a731	3	8-12	\N	\N	\N	\N
d783b8da-a888-47cc-9775-17a3a18e4cb9	1a3a3e61-0685-4222-bb40-35aae97f42e1	3	8-12	\N	\N	\N	\N
3fa12b72-ccf2-4840-9886-2dcabb54b81c	56b11850-2d33-4a11-869f-83208379ffac	3	8-12	\N	\N	\N	\N
05b2f3c3-2f0e-48d9-b352-f7674eb4490a	5ae8a640-1e9e-452a-a260-43638dc7052f	3	8-12	\N	\N	\N	\N
b5b1d760-6b45-456f-98d4-d62ec1ac775b	9b0d3afb-de59-4604-99f1-335e19ce9381	3	8-12	\N	\N	\N	\N
8d6fadb3-410c-4a06-8dea-1ccab08c9b82	e6ab2abe-ae87-47a0-82c8-8104d92ee0c2	3	30-45 sec	\N	\N	\N	\N
791cb591-ffa2-4364-9866-c6fde950301c	b16fe888-c333-4f45-9ac6-4951a957f4a8	3	8-12	\N	\N	\N	\N
94b83400-8f09-4bc0-a72b-d2deb540119c	e627f6d1-bc8e-4ed1-b2d7-90e7562174c9	3	8-12	\N	\N	\N	\N
adb73aa6-74c4-4f49-b897-722a09d56776	4670f206-34a5-46d0-9dd0-7f4ec3fff377	3	8-12	\N	\N	\N	\N
61e29633-94d6-463d-ba07-dc19fa500ab6	fa9c6268-dac6-4f46-9ee1-e8e97e737936	3	15-20	\N	\N	\N	\N
9d15eb32-7ba5-44f2-8a48-4f249f7fc445	6722149b-4414-4301-927e-03e63d6d0f06	3	15 Reps(Each Side)	\N	\N	\N	\N
60cedf1c-fe53-44b2-b846-3c5aca65c853	072644fe-508c-44a6-95d3-df8224284a19	3	8-12	\N	\N	\N	\N
a5aecebe-e70b-4f09-9558-3baf372354f6	76b644c9-105a-48ab-815e-d31caeecd286	3	8-12	\N	\N	\N	\N
cc690e1d-949b-4336-bf0f-8ba5487e5e53	b23ae6c1-0c0f-494f-ae2b-2c71e1c00f69	3	8-12	\N	\N	\N	\N
f1a535de-4ab9-4735-9d42-3df13758b64d	8adca385-d111-4133-800b-adb1163d912f	3	8-12	\N	\N	\N	\N
f7e1f297-44f3-4cc0-9d85-4621473e86a4	02ae6935-2da7-4eab-851f-f67e3b92f9e4	3	8-12	\N	\N	\N	\N
a6a47bde-c1f4-40bf-b2b4-5070acff1948	94283970-5f78-43b6-9f6b-e9a34e619d22	3	8-12	\N	\N	\N	\N
8bff494a-8fb8-4b86-bae2-ea5493e8c891	f5890f5c-6969-456c-9b4c-263f2c4faa9a	3	8-12	\N	\N	\N	\N
6f4a9d59-f732-44e8-9777-fc3c367fa123	6a67f5ba-c1fe-4615-bfc7-e8b99b613b53	3	8-12	\N	\N	\N	\N
b00bddbd-21d8-4e96-ad3a-e6cdb102a812	b22acc73-459b-4acf-b40c-e2a3050c63f5	3	8-12	\N	\N	\N	\N
fd3986bc-f673-4798-8916-edf2c0446630	57ddb9db-2fc7-4a62-abc3-53b10dce60ef	3	8-12	\N	\N	\N	\N
1ed40e10-2dc9-47a7-8e41-69f65d0c0abd	03a7c9fc-9274-4b8e-b018-0b412db068c5	3	30-45 sec	\N	\N	\N	\N
7d348bce-a73d-45e7-b999-da6a155c942d	3abd3f92-8134-4c83-baa0-3e99340ad63f	3	8-12	\N	\N	\N	\N
dd81fbe0-8231-4b27-9655-b85b61da5c28	5a0fd021-1510-4582-b73f-ff23ea4bbb18	3	8-12	\N	\N	\N	\N
1c352a22-8346-43fc-83d4-6fcae731dbe4	ca189235-1f1a-4c3c-96fb-669d63369898	3	8-12	\N	\N	\N	\N
494434c0-1f8d-4ed8-91e5-5097db6ba678	25569974-2290-4614-b4f4-e7a333dee615	3	15-20	\N	\N	\N	\N
e639634e-f8c8-4085-9a87-3192c572a8a4	c205f57a-2f22-4bc2-bbba-e13da23e28a1	3	15 Reps(Each Side)	\N	\N	\N	\N
d6cad5d7-e192-40f1-8359-7868126479fe	64686742-a0b6-411f-a811-99730ae8de3e	3	8-12	\N	\N	\N	\N
3f1800fd-2c23-4c11-a357-962fddbd3fa6	1517d501-3f87-4450-8386-3301ffd9ab2b	3	8-12	\N	\N	\N	\N
b657c1d8-abc3-48e3-b2ff-d29cf435cb41	105713dc-dc45-4646-b588-291f31a695aa	3	8-12	\N	\N	\N	\N
93e97833-969e-4b54-9b5e-af184696cb00	8e2a8d2d-2b05-45a7-a9b1-fd449de1d48f	3	8-12	\N	\N	\N	\N
92c24f9e-429c-49d5-b7c0-454f9673f3b4	6140ac76-d28b-4841-b0ee-a8f4501aeb28	3	8-12	\N	\N	\N	\N
32984415-79c3-49e0-8bcc-734981d73dde	ca23ea3a-55a8-4f14-b47d-765eecb3aa29	3	8-12	\N	\N	\N	\N
807188a6-0a0c-4a99-a3fd-5f74b864429e	74250cd9-c66b-4d30-8ed6-c3e2b41bf1d3	3	8-12	\N	\N	\N	\N
77151713-80ad-4c2f-a481-79b094459763	9d18e683-8b9b-4978-bc93-83518755a9c8	3	10-15	\N	\N	\N	\N
8e03f62a-bbe6-4a90-b260-33a7fe808df4	4a9497e0-0e0c-442b-bf8a-7284cee0e495	3	10-15	\N	\N	\N	\N
5bd43963-c016-4949-b6d5-af2362489e07	c963a1e4-19da-4c92-89d1-46125cd78d19	2	12-15	\N	\N	\N	\N
db42622d-81ca-4547-a143-de82a24d7155	5590f525-bba9-4699-a92a-a8facf69b9c8	2	10-12	\N	\N	\N	\N
d870d654-c6ff-43d5-8f1a-9e802485755b	52aa1953-6319-438c-a310-a9b1a8487c80	3	8-12	\N	\N	\N	\N
97480ebe-bcd7-4858-84fb-47e7c9df0085	be4acc51-978b-4e93-85c5-4f2f20c2f817	3	8-12	\N	\N	\N	\N
839c3639-ff61-4a58-b087-d427a6b061af	38056b52-9d7f-4af2-ace6-f311355ffcd3	3	10-12	\N	\N	\N	\N
00812581-b038-4cd5-9704-ac0bfcec6559	6ca8359d-d4ff-4e7e-bca0-07e3855883d8	3	12-15	\N	\N	\N	\N
ea3ac0b4-388a-4357-ade7-76f5eaf9b849	d78975d6-3a2d-4621-bd4d-3e2f9d845bb6	2	10-12	\N	\N	\N	\N
c6ab368a-ba48-45c0-ab3f-dcb77a33936c	118ffe24-ce22-4546-baa9-d6503357c37b	2	12-15	\N	\N	\N	\N
658b4f9d-313f-4fc9-8f2d-3d898840e207	5f7a9f28-3c3a-4f18-b854-3a819ebbcef5	3	8-12	\N	\N	\N	\N
0bbaaf76-ce9f-42fd-9da5-9d36d0d4d666	cd65e5a8-1e7c-4f90-9022-3c313ffb531c	3	8-12	\N	\N	\N	\N
ecdb7c16-6334-4e7a-a2b7-27ba45f3b6e5	5963ce48-7b9e-4d2c-aab4-dbe83a289c03	3	10-15	\N	\N	\N	\N
623a88a1-7a4b-41a5-804e-57eab29a7ee8	bd2c4abe-10ec-4efb-a086-0a24d687a905	3	12-15	\N	\N	\N	\N
19507f10-3e06-4644-b95b-59bcd782bbc1	9817571c-2787-4d1a-aed8-49e28314aa44	2	10-12	\N	\N	\N	\N
e2dc4916-4f97-4130-a85a-41d5fbe0e007	294add7f-f90a-4eac-b4a8-cf268a40c348	2	12-15	\N	\N	\N	\N
dfa89e3f-b4a2-422c-b2bb-a7bf8d798b01	afcc6fb3-2b05-4a11-84aa-50d20f63d4ae	3	8-12	\N	\N	\N	\N
aad547e6-fc8c-4a42-b0d9-ffdadc71672c	ac1ef127-69ac-4e9b-8853-f128c2dc64d8	3	8-12	\N	\N	\N	\N
d305037e-f97e-4109-b357-b75c24f93cd7	a8cdd1c7-8858-423b-be77-617a0379b634	3	8-12	\N	\N	\N	\N
da0d20c8-1da2-4664-b14d-982c5b483b42	8f511a7d-dfb9-4987-bf6f-81c81b12d032	3	8-12	\N	\N	\N	\N
b4772fbf-8cbb-49f5-bfc7-81e1b0a4272a	74585b23-4a21-4dcd-a153-e5baa73168db	3	8-12	\N	\N	\N	\N
a158ba3b-427b-4712-af49-be473957d911	91cefccb-6b96-4125-b49a-a461c8ecbb12	3	8-12	\N	\N	\N	\N
ee251738-c1cb-431e-9bae-f9f263fcc89d	8fab9ccc-77a6-40b5-9c57-a8e0fd0d0eb3	3	8-12	\N	\N	\N	\N
f0991403-41c8-4a8f-994f-5320bde0a9f9	9ffbe234-f7f6-40bf-8faf-48f3c0b900dc	3	8-12	\N	\N	\N	\N
ca0e538c-e764-48eb-bc39-5962a40553de	c00a9db4-1b90-4656-8595-8ba79606431d	3	8-12	\N	\N	\N	\N
8da9f740-39d0-49fa-b5d6-04166a74f98f	8281a856-35cc-47c6-9705-c221114ea0ca	3	8-12	\N	\N	\N	\N
cfb0da5f-7eed-4fbd-9a9a-7128fac242f0	73e4af2d-b537-4080-a7bb-10a2afe1ab25	3	8-12	\N	\N	\N	\N
8b21b4dc-259c-4ee5-a6a3-5484146ef68a	a008f185-233f-471d-a9af-8b6dac08bf72	3	12-15	\N	\N	\N	\N
bfa8867c-ad95-4a0d-ae47-2fafe03d8ce9	b5fb2b26-71ff-4030-9815-21f4bf10a90b	3	8-12	\N	\N	\N	\N
e99d3543-b6bd-476a-af37-e9a627af267f	7c3e18f8-a4e1-40e6-8f4a-2eda284d0846	3	8-12	\N	\N	\N	\N
c5f71c60-7499-4ade-8097-a1a526c2c7ba	faf0f4a0-05c4-40c9-a09b-b555c97fa283	3	8-12	\N	\N	\N	\N
680fd27c-c89b-496a-a8fb-0c6a1a5fb194	b0f001f1-bc00-475a-b090-999e78ca573f	3	8-12	\N	\N	\N	\N
01788399-08e8-4e6d-81dd-83a41015b457	57f34b31-d015-4139-9d85-fab29656c45d	3	12-15	\N	\N	\N	\N
73a88740-d9fc-49f1-bc45-1a8786b8f520	8805071f-818f-4342-9172-74089d0481de	3	12-15	\N	\N	\N	\N
254573b3-e460-498d-ac5e-9e7590ec04a0	f36bd16d-70f6-4c44-aff1-8075ca7f242c	3	8-12	\N	\N	\N	\N
efd85469-28fd-4c19-b80a-05aaf2403dff	2268c6e0-8286-47ae-b54d-7de405c2d84a	3	8-12	\N	\N	\N	\N
4751d496-a324-4b55-be64-e20b71a8a217	836e02e6-d235-452a-a994-e93c129d0e67	3	8-12	\N	\N	\N	\N
c74f36f6-4fa5-4f03-a4fe-45cd9fce4fd2	8497e72a-819a-42af-bf07-e0bfa67e0fc1	3	8-12	\N	\N	\N	\N
df4f5829-85c4-4580-9049-ef9b99d0f6f9	8bbbc881-99ec-4ec4-aca3-087cc7ac9949	3	8-12	\N	\N	\N	\N
37a2fa90-03ae-43ef-8252-a7172cbec393	3f3a5d1f-eece-4a53-a201-b9e0817baed0	3	12-15	\N	\N	\N	\N
8a2740ea-aeec-4ae7-b4e1-a0b3c305230e	6f085679-d0df-478b-a63e-6876b4a07bb7	3	8-12	\N	\N	\N	\N
2bbfc2b2-cc73-43e8-869c-75c17232067d	4885f435-dec3-4965-a241-ee97700e4632	3	8-12	\N	\N	\N	\N
d75a4f20-0d57-455e-b325-b4e21136571e	9790ff1a-8171-4d15-a6d6-cda04f19428e	3	8-12	\N	\N	\N	\N
5f4f0639-47ea-48c1-a0d1-c94f4b530387	614c9971-19da-455b-8e96-16e6583a0fb6	3	8-12	\N	\N	\N	\N
de07c9f4-bbed-4ffc-970d-a527570dd2d3	2c0486da-6159-4e06-a1bd-1a77d7754774	3	12-15	\N	\N	\N	\N
633b1dc5-a93c-4f11-9d48-b682a9e62955	c2c6a7aa-71c3-475d-8631-08f4fb8e7836	3	15(each side)	\N	\N	\N	\N
\.


--
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercises (id, day_id, name, notes, video_url, muscles_trained, muscle_group) FROM stdin;
cbb54f67-4513-41a1-9847-8a719ed82041	e52baf68-2501-4981-a582-da20773603e7	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
a6561498-2674-499f-bad4-9a5e44fdba61	e52baf68-2501-4981-a582-da20773603e7	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
49c6a55e-e7ec-4ad5-9b38-669198e2b424	e52baf68-2501-4981-a582-da20773603e7	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
4447150e-4b2d-4c6b-8d44-fa8d1a6e2d05	e52baf68-2501-4981-a582-da20773603e7	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
4f9792c9-0489-44df-8645-e49a1c5a744c	e52baf68-2501-4981-a582-da20773603e7	Flat Bench Dumbbell Press	\N	https://www.youtube.com/watch?v=3JEKRdfwdxg	Pecs(middle, lower - lengthened),\nAnterior Delts	CHEST
c07ab3bf-4747-415b-8ccc-8167b449be3e	e52baf68-2501-4981-a582-da20773603e7	Chest Supported Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
1167bfc7-f781-4958-93c4-8803892865d7	43e4bd5e-acae-407a-8830-15fd3072b5e5	Smith Machine Squats	\N	https://www.youtube.com/shorts/1nZV2aVjBqo	Quads(Lengthened),\nGlutes(Lengthened),\nSpinal Erectors	LEGS
20fd3528-94b3-48b1-b1dd-d7ff086db8df	43e4bd5e-acae-407a-8830-15fd3072b5e5	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
315378f4-5cf4-4185-805b-50ff25fe4f88	43e4bd5e-acae-407a-8830-15fd3072b5e5	Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
434628c4-7d38-4678-bf0a-352344baaaf2	43e4bd5e-acae-407a-8830-15fd3072b5e5	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
62771565-e7dc-41d8-974f-bdbac57ea30f	43e4bd5e-acae-407a-8830-15fd3072b5e5	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
51d5d214-592f-4e86-9916-3daa9bc5510a	43e4bd5e-acae-407a-8830-15fd3072b5e5	Abdominal Crunch	\N	https://www.youtube.com/watch?v=ZPdx67dVJHg	Rectus Abdominis,\nTransverse Abdominis	ABS
3108357c-577d-4f37-9b7a-a29290f83306	e1a81198-6446-4dc0-bc1f-aae645da8573	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
36be24ce-700c-43fe-93f2-35cbcc07ae7b	e1a81198-6446-4dc0-bc1f-aae645da8573	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
a07a77f2-e1bf-4946-a606-6dc2654ffcdf	e1a81198-6446-4dc0-bc1f-aae645da8573	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
7ea4847f-59c0-4ffd-add1-8fcdecefaaf8	e1a81198-6446-4dc0-bc1f-aae645da8573	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
83aeb85d-e8e0-4426-80a6-de2fb458bb2f	e1a81198-6446-4dc0-bc1f-aae645da8573	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U	Triceps(Long head - Shortened)	TRICEPS
0380354e-6a3d-4e47-ac95-9852f19a382f	e1a81198-6446-4dc0-bc1f-aae645da8573	Pec Deck Fly	\N	https://www.youtube.com/watch?v=Qplb3CTTawM	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts	CHEST
69ced390-3d26-47c4-8ce9-daa760f90c1e	82906921-794a-4dd6-b69c-9602aab50315	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
6c43e921-5085-44af-9dec-307e00692898	82906921-794a-4dd6-b69c-9602aab50315	Chest Supported Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
33726ca4-9e91-4a3c-9cbb-8c7fc3e298a7	82906921-794a-4dd6-b69c-9602aab50315	Dumbell Pullover	\N	https://www.youtube.com/shorts/k_cFbm-KXtI	Lats (shoulder extension - lengthened),\nTeres Major,\nLong Head Triceps,\nSerratus Anterior	BACK
d59250d4-a266-4d6b-bb60-4700bb1d2669	82906921-794a-4dd6-b69c-9602aab50315	Reverse Pec Deck Fly	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	BACK
8e4cf7f8-bb90-4b5f-9632-8ad1e62259f0	82906921-794a-4dd6-b69c-9602aab50315	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
9de55651-2fa7-43cf-9536-173d1e95e3f4	82906921-794a-4dd6-b69c-9602aab50315	Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
7119ab69-135a-4d74-ab65-a2e02c9c56a3	acdb7c18-179b-4624-8c02-d517bab299f1	Leg Press	\N	https://www.youtube.com/watch?v=Ac7D1W0BUF0	Glutes(Lengthened)	LEGS
9157e51b-5bbb-441e-a868-fc9dcd88fd35	acdb7c18-179b-4624-8c02-d517bab299f1	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
4f74adbf-7b60-4f56-bde1-1ff1c34f036a	acdb7c18-179b-4624-8c02-d517bab299f1	Dumbbell Lunges	\N	https://www.youtube.com/watch?v=lotPMgYPbyQ	Quads (lengthened),\nGlutes (lengthened),\nAdductor Magnus,\nGlute Medius (stabilizer),\nHamstrings (stabilizer)	LEGS
d91ed1ec-5e5b-4c59-a8b7-509c713abcdb	acdb7c18-179b-4624-8c02-d517bab299f1	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
4c2322e6-6e93-4c4c-8f37-20673c992ca8	acdb7c18-179b-4624-8c02-d517bab299f1	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
adcc1903-e53a-4789-b11f-0c800d7c832f	acdb7c18-179b-4624-8c02-d517bab299f1	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	LEGS
6cbf8a5f-8fc5-4ae2-b165-04cdbe94de90	77158380-2d78-4b76-ae4c-e82ebf85fcaf	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
bf5595e5-a737-428d-af7e-53b94a9edfe2	77158380-2d78-4b76-ae4c-e82ebf85fcaf	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
c0f04c52-f64b-4c70-8e43-a6deaab2a9ec	77158380-2d78-4b76-ae4c-e82ebf85fcaf	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
2dc18e80-9d94-49c2-bd20-77165195ae26	77158380-2d78-4b76-ae4c-e82ebf85fcaf	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
01556157-1c68-4c99-873a-0764ab52ad1e	77158380-2d78-4b76-ae4c-e82ebf85fcaf	Reverse Pec Deck Fly	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
e227c8ac-0e64-4598-bc4f-8d4755fd9e14	4b8ece09-1c5d-42ba-a79b-b74c0011e155	Leg Press	\N	https://www.youtube.com/watch?v=Ac7D1W0BUF0	Glutes(Lengthened)	LEGS
db045c29-6330-443c-9a76-a823b3776b48	4b8ece09-1c5d-42ba-a79b-b74c0011e155	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
317c7ab5-f21a-40b0-9117-add392b6ba35	4b8ece09-1c5d-42ba-a79b-b74c0011e155	Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
cb731873-e8ad-4d0f-a884-5c3405089138	4b8ece09-1c5d-42ba-a79b-b74c0011e155	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
79771884-7f31-4295-9176-e326ef24f5d7	4b8ece09-1c5d-42ba-a79b-b74c0011e155	Abdominal Crunch	\N	https://www.youtube.com/watch?v=ZPdx67dVJHg	Rectus Abdominis,\nTransverse Abdominis	ABS
4122e303-191f-4efe-b06d-c498e4cf6d92	184afbbe-a166-48cf-b26f-214331a7e379	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
8d99621f-c144-40d1-bcc3-ffb76353c47b	04792deb-f2d8-464d-91ae-de1195f84084	Cat-Cow Pose	\N	https://www.youtube.com/shorts/2of247Kt0tU		
9c8c74db-1bb7-4f19-8697-c54f8661a25e	04792deb-f2d8-464d-91ae-de1195f84084	Thoracic Extensin on Foam Roller	\N	https://www.youtube.com/shorts/j1V-stq6j0g		
5345cfce-7cc1-4bd4-b464-074bfabe6524	04792deb-f2d8-464d-91ae-de1195f84084	Bird Dog	\N	https://www.youtube.com/shorts/X0FpQEjEA40		
9c7afa2e-83df-4e29-94d9-e5619203af78	0aed1ac5-1e17-4bd8-a6f1-fbe0fae81959	Barbell Squats	\N	https://www.youtube.com/watch?v=EBItm_AOzK8	Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
7a84f906-3c7a-4c64-b03e-5330b742c863	0aed1ac5-1e17-4bd8-a6f1-fbe0fae81959	Barbell Hip Thrust	\N	https://www.youtube.com/watch?v=3BxgXcmCM-8		LEGS
25b8631f-fcef-47ba-9569-989adffd695f	0aed1ac5-1e17-4bd8-a6f1-fbe0fae81959	Standing Leg Curl	\N	https://www.youtube.com/shorts/IwcLkHuH7iw		LEGS
29d54ae9-cfbd-4d23-ae2c-bab7dcddd948	0aed1ac5-1e17-4bd8-a6f1-fbe0fae81959	Single Leg Extension	\N			LEGS
fffe5abb-dd62-4f95-a1a8-e8a387785b1d	0aed1ac5-1e17-4bd8-a6f1-fbe0fae81959	Dumbbell Standing Calf Raises	\N	https://www.youtube.com/watch?v=JBZ9qb_ASps	Gastroc, Soleus	LEGS
e8cdd0c7-776d-40b6-a8f7-b159ffee7315	184afbbe-a166-48cf-b26f-214331a7e379	Single Arm Dumbbell Row	\N	https://www.youtube.com/shorts/rO4Q7nW0ygo	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
10288a03-cfbc-4154-8ccc-d14c41f643cc	184afbbe-a166-48cf-b26f-214331a7e379	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
d8e8b8b5-c354-4bde-8f6f-3fff9a54dba2	184afbbe-a166-48cf-b26f-214331a7e379	Chest Supported Dumbbell Abducted Row	\N	https://www.youtube.com/watch?v=fPtSGpS0tgE	Rhomboids\nMid Traps\nRear Delts\nTeres Minor / Infraspinatus\nUpper Lats (minor contribution)	BACK
1e49107d-f303-454f-8a7e-28d6d514cb2d	184afbbe-a166-48cf-b26f-214331a7e379	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
3d3ee3d7-7718-42eb-bfae-37b5e303731a	8561b03c-7db9-4d98-93b2-9fbc65a96f0f	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
7a7c0c78-1faa-4b93-84f8-5aa5b828ba07	8561b03c-7db9-4d98-93b2-9fbc65a96f0f	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
347aab5a-81bb-4c24-bbdd-3538b82e50c2	8561b03c-7db9-4d98-93b2-9fbc65a96f0f	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
30782ca6-038f-49a2-9e8c-7fd28e3839f0	8561b03c-7db9-4d98-93b2-9fbc65a96f0f	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
b08507f2-6e0d-4fac-8b8d-30479e187480	8561b03c-7db9-4d98-93b2-9fbc65a96f0f	Reverse Pec Deck Fly	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
4fca22d2-d902-4b25-8e2c-0f9dca35ed32	f1177bf0-1e23-48c7-98a7-1938fa224dca	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
bfcb3d3a-e805-4ff6-bd45-bed2ac62336e	f1177bf0-1e23-48c7-98a7-1938fa224dca	Single Arm Dumbbell Row	\N	https://www.youtube.com/shorts/rO4Q7nW0ygo	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
464a6ba5-b051-44bd-9869-f690d4d7fa7b	f1177bf0-1e23-48c7-98a7-1938fa224dca	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
b30d4604-68b5-46b5-9a76-ead7bf741867	f1177bf0-1e23-48c7-98a7-1938fa224dca	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
70139903-755d-4e01-af91-6d783a58c7e6	f1177bf0-1e23-48c7-98a7-1938fa224dca	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
0b155ead-005c-4a21-bbc2-8e8da381ca6a	964e8bea-9d6e-46b6-8386-1ca84badfbe8	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
80f5cf56-e4df-4d22-b2de-514d2e69935a	964e8bea-9d6e-46b6-8386-1ca84badfbe8	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
3af48b9d-ded1-409b-baba-fb892be2f17c	964e8bea-9d6e-46b6-8386-1ca84badfbe8	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
f39387d8-155a-4311-a7a5-3abdc2ee5e83	964e8bea-9d6e-46b6-8386-1ca84badfbe8	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
db614d18-4caf-4cb2-86fc-d126bda456a1	964e8bea-9d6e-46b6-8386-1ca84badfbe8	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
aff5dc21-dcf3-4da4-afe5-0deb2b97bf83	964e8bea-9d6e-46b6-8386-1ca84badfbe8	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
34cf34a0-8705-47d6-9c0e-596125f5f506	964e8bea-9d6e-46b6-8386-1ca84badfbe8	Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
9abf71e1-91e8-42b5-9f44-2d512a33d6cb	f8d02043-8b30-4318-972a-a971f641083b	Leg Press	\N	https://www.youtube.com/watch?v=ewwcmskvRgE	Quads(lengthened), Glutes(lengthened), Adductors	LEGS
7b512b6f-8375-468b-bfb1-c312ad2b9035	f8d02043-8b30-4318-972a-a971f641083b	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Hamstrings(lengthened), Glutes(lengthened), Spinal Erectors	LEGS
fb84708d-ef17-4a9b-9db1-b91f918b80b3	f8d02043-8b30-4318-972a-a971f641083b	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(shortened)	LEGS
db5d8830-6559-4a20-8e28-2bc0a4add1b6	f8d02043-8b30-4318-972a-a971f641083b	Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
239f5d77-2014-410f-b739-d0fbb1f39226	f8d02043-8b30-4318-972a-a971f641083b	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
1c13bbad-d299-43d7-a165-b529c0edee4c	f8d02043-8b30-4318-972a-a971f641083b	Planks	\N	https://www.youtube.com/watch?v=Qv00BKMQf6M	Rectus Abdominis, \nTransverse Abdominis	ABS
6b118c52-21a7-4cee-a800-c416c35cb372	3a4e23f3-04b4-4fb0-adaf-5c7079ac2efd	Flat Bench Dumbbell Press	\N	https://www.youtube.com/watch?v=3JEKRdfwdxg	Pecs(middle, lower - lengthened),\nAnterior Delts	CHEST
3e7bfd11-5ef2-4c06-a899-2116ca2d3aca	3a4e23f3-04b4-4fb0-adaf-5c7079ac2efd	Overhead Dumbbell Press	\N	https://www.youtube.com/watch?v=Qscmgbf5AUI	Anterior Delts,\nUpper Pecs	SHOULDER
e1c62ad2-49d4-44ea-b1c5-e9cf2c94d00a	3a4e23f3-04b4-4fb0-adaf-5c7079ac2efd	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
8646b489-ffaa-4366-b4d3-cc535ec671bf	3a4e23f3-04b4-4fb0-adaf-5c7079ac2efd	Pec Deck Fly	\N	https://www.youtube.com/watch?v=Qplb3CTTawM	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts	CHEST
5f556a33-9432-4aed-908e-6bfc0cef306b	3a4e23f3-04b4-4fb0-adaf-5c7079ac2efd	Overhead Triceps Extensions(Cable)	\N	https://www.youtube.com/watch?v=PRnt2HfL39c	Triceps(Lengthened - Long head)	TRICEPS
94d5c7f7-b33b-4698-8c41-6be6e3095175	9bce27c3-63f4-449d-8bc5-0686814c3e1a	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
459d5ad5-50aa-42b4-8d9b-e41828d6ea99	9bce27c3-63f4-449d-8bc5-0686814c3e1a	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
cddb7fb9-e8c9-4755-93c1-17fe5590eec0	9bce27c3-63f4-449d-8bc5-0686814c3e1a	Reverse Pec Deck	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	BACK
40906bbc-e71a-4e24-a882-92d7edeb3574	9bce27c3-63f4-449d-8bc5-0686814c3e1a	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
aa180a24-dc99-4a81-959e-3aac6770b8d3	9bce27c3-63f4-449d-8bc5-0686814c3e1a	Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
8e217c5e-a36c-41f6-9167-488e78f80784	134ac9a8-d242-4c34-9fad-70631386f8d8	Leg Press	\N	https://www.youtube.com/watch?v=ewwcmskvRgE	Quads(lengthened), Glutes(lengthened), Adductors	LEGS
3295efbf-6c65-4b58-88ce-af1accf54414	134ac9a8-d242-4c34-9fad-70631386f8d8	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Hamstrings(lengthened), Glutes(lengthened), Spinal Erectors	LEGS
62c58cb9-4268-472f-aa9f-95ec86f50faf	134ac9a8-d242-4c34-9fad-70631386f8d8	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(shortened)	LEGS
58c49a97-a0db-490a-b7aa-d2c7c274244a	134ac9a8-d242-4c34-9fad-70631386f8d8	Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
554e0fb1-e0da-4744-8e6a-4503569700bf	134ac9a8-d242-4c34-9fad-70631386f8d8	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
4a9b282c-5073-4df1-b24f-14cfa84fb1bd	134ac9a8-d242-4c34-9fad-70631386f8d8	Planks	\N	https://www.youtube.com/watch?v=Qv00BKMQf6M	Rectus Abdominis, \nTransverse Abdominis	ABS
85c81d0a-aa5d-459b-8cda-1c80f05910f0	a413cc7b-4f7c-43f7-bbae-06fdeb4bcda5	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
b4564cd0-2900-4068-98e3-1739f4ca04ce	a413cc7b-4f7c-43f7-bbae-06fdeb4bcda5	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
07c258c5-dfd8-4144-ba5d-106e72f7d336	a413cc7b-4f7c-43f7-bbae-06fdeb4bcda5	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
d00ce926-2e5b-4d70-8a94-3248e0196276	a413cc7b-4f7c-43f7-bbae-06fdeb4bcda5	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
2b08c90e-4922-4620-b231-c2c427e8bc41	a413cc7b-4f7c-43f7-bbae-06fdeb4bcda5	Reverse Pec Deck Fly	\N	https://www.youtube.com/watch?v=7dI8_AsXglI		
1656de79-3462-436a-b84e-caa8b58ab339	90db24ed-7542-44bb-8721-1967f355533d	Leg Press	\N	https://www.youtube.com/watch?v=Ac7D1W0BUF0	Glutes(Lengthened)	LEGS
d0c9b1aa-ba90-43da-bf14-0e5f3a9cd105	90db24ed-7542-44bb-8721-1967f355533d	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
2d2f00cd-4283-42cc-80d2-862419c8acd8	90db24ed-7542-44bb-8721-1967f355533d	Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
69e7f771-2c58-4e6c-926a-05b076a3fd45	90db24ed-7542-44bb-8721-1967f355533d	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
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
f86a8e11-8f87-4131-8c67-8005b52adaa0	90db24ed-7542-44bb-8721-1967f355533d	Abdominal Crunch	\N	https://www.youtube.com/watch?v=ZPdx67dVJHg	Rectus Abdominis,\nTransverse Abdominis	ABS
5ef7941e-d399-470e-a446-ac5cb34bf177	510e7e6e-e315-4903-ae18-e47edce3c2e7	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM		
3f2134a1-924f-47e8-a129-943daf68ec2b	510e7e6e-e315-4903-ae18-e47edce3c2e7	Single Arm Dumbbell Row	\N	https://www.youtube.com/shorts/rO4Q7nW0ygo		
524b71a8-0f7b-4a60-8b2b-2408992e1293	510e7e6e-e315-4903-ae18-e47edce3c2e7	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
085fb327-7437-4156-8237-28c4593e207d	510e7e6e-e315-4903-ae18-e47edce3c2e7	Chest Supported Dumbbell Abducted Row	\N	https://www.youtube.com/watch?v=fPtSGpS0tgE		
7a5d6dc0-8109-4029-b0c7-271e48dcf58f	510e7e6e-e315-4903-ae18-e47edce3c2e7	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc		
5f396d8e-ecca-4bea-bbc3-1a866157de44	21b11897-c0e3-43fe-ae18-d3fb5028069b	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
27fd929b-4d23-45fa-80d3-47542b0ef8b5	21b11897-c0e3-43fe-ae18-d3fb5028069b	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
52510cb5-4ce0-4ae4-b31c-cc2d1b031a8b	21b11897-c0e3-43fe-ae18-d3fb5028069b	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
791f9327-9751-4841-825a-a29df3a6aeca	21b11897-c0e3-43fe-ae18-d3fb5028069b	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
5b93e6e9-303b-4891-96af-345c4ddc2abf	21b11897-c0e3-43fe-ae18-d3fb5028069b	Reverse Pec Deck Fly	\N	https://www.youtube.com/watch?v=7dI8_AsXglI		
b387c792-904f-4ad9-80f9-9388646b7a3c	f9ed67cc-2f7b-46b8-8cfd-49f10fab7eac	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM		
4e111375-2a4c-44a7-bcaa-33a6856a1c33	f9ed67cc-2f7b-46b8-8cfd-49f10fab7eac	Single Arm Dumbbell Row	\N	https://www.youtube.com/shorts/rO4Q7nW0ygo		
86aef619-a8fd-4df3-a089-ebd025f4fcbd	f9ed67cc-2f7b-46b8-8cfd-49f10fab7eac	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
6380086d-f3a5-4ad0-aa73-38448390646b	f9ed67cc-2f7b-46b8-8cfd-49f10fab7eac	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
3fef4326-311d-4182-a53c-226eb11e08d4	f9ed67cc-2f7b-46b8-8cfd-49f10fab7eac	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc		
f9a3cda1-f358-4ac4-bb60-df64760c640e	184ee0ae-5e02-4e60-a0a9-79a46cdc5c50	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
aed0d39d-9290-477f-9328-30dd157e4fbe	184ee0ae-5e02-4e60-a0a9-79a46cdc5c50	Chest Supported Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
d9c4c4df-fff2-43ad-bcc3-da68c1af0686	184ee0ae-5e02-4e60-a0a9-79a46cdc5c50	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
df8a2e2a-1d68-44be-8921-4246665b647a	184ee0ae-5e02-4e60-a0a9-79a46cdc5c50	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
aff1deb2-9ce6-4650-bec2-3b907f70ded9	184ee0ae-5e02-4e60-a0a9-79a46cdc5c50	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
8649770c-b004-4b9f-826d-013a6b27202b	184ee0ae-5e02-4e60-a0a9-79a46cdc5c50	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
7faf4c04-3285-4a81-b36d-7eb1e77f3c7e	184ee0ae-5e02-4e60-a0a9-79a46cdc5c50	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
a62afcdf-b2f0-4105-9321-58f4c8ebcdc4	e5c03a29-6fa8-42e4-85dd-49163d26302e	Barbell Squats	\N	https://www.youtube.com/watch?v=EBItm_AOzK8	Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
768a84f2-7077-46db-9cf0-6c9268332630	e5c03a29-6fa8-42e4-85dd-49163d26302e	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
4dc3258b-3f6d-4008-8974-7da4810f8d62	e5c03a29-6fa8-42e4-85dd-49163d26302e	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
ddb9fde2-ba6a-4baf-9181-0252b81c2956	e5c03a29-6fa8-42e4-85dd-49163d26302e	Dumbbell Lunges	\N	https://www.youtube.com/watch?v=lotPMgYPbyQ		LEGS
779226bc-b2f5-41b9-89b7-d92cd799e1a6	e5c03a29-6fa8-42e4-85dd-49163d26302e	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
79bafa58-332f-4baa-87f9-64dde0a6b686	e5c03a29-6fa8-42e4-85dd-49163d26302e	Abdominal Crunch	\N	https://www.youtube.com/watch?v=ZPdx67dVJHg	Rectus Abdominis,\nTransverse Abdominis	ABS
3ab259fb-09c4-4cb6-864e-b4984b971900	e11447d8-ee6a-4146-8d50-e9182b277820	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
aae5fb69-aae4-445b-b225-09eaede7819c	e11447d8-ee6a-4146-8d50-e9182b277820	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
b50435f3-0e06-4c94-9f89-d811ee4cf034	e11447d8-ee6a-4146-8d50-e9182b277820	Shoulder Machine Press	\N	https://www.youtube.com/watch?v=-c__9gZZjkU	Anterior Delts,\nUpper pecs	SHOULDER
741afec8-817b-4aa1-91c4-c040493678c4	e11447d8-ee6a-4146-8d50-e9182b277820	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
a83fde46-5b66-4f79-a0a4-7670fc45a0a8	e11447d8-ee6a-4146-8d50-e9182b277820	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
3aba0241-5165-4ac6-b740-5a8c38ac102e	e11447d8-ee6a-4146-8d50-e9182b277820	Dumbbell overhead tricep extension	\N	https://www.youtube.com/shorts/T3e390Dl3XU	Triceps (Shortened + Mid)	TRICEPS
37e2d5be-430e-4f60-96d1-c86a1ab83cb0	e11447d8-ee6a-4146-8d50-e9182b277820	Pec Deck Fly	\N	https://www.youtube.com/watch?v=Qplb3CTTawM	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts	CHEST
b11c16d6-e1a8-48d2-9539-cf5c77aaa550	5ad86cd4-334d-49c5-ad12-684c42619bce	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
98814777-95fc-4a60-bf92-c46134b4e416	5ad86cd4-334d-49c5-ad12-684c42619bce	Chest Supported Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
6135cfd3-203c-44b0-8519-1764b23f0bdd	5ad86cd4-334d-49c5-ad12-684c42619bce	Preacher Dumbbell curl on 45 degrees incline bench	\N	https://www.youtube.com/watch?v=i6o-m0BxV8c	Biceps(Shortened)	BICEPS
309f4855-5001-40d2-9e2c-70f45fffb724	5ad86cd4-334d-49c5-ad12-684c42619bce	Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
dae2b46a-e77d-42ee-9628-4f21c2441733	5ad86cd4-334d-49c5-ad12-684c42619bce	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
508a07da-42ec-4775-bdc9-845c56ebd910	5ad86cd4-334d-49c5-ad12-684c42619bce	Reverse Pec Deck	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
983db977-b294-4164-ad7f-a94dee92a9e6	4973a40e-2fd2-4861-ab58-afb138dc485c	Leg Press	\N	https://www.youtube.com/watch?v=Ac7D1W0BUF0	Glutes(Lengthened)	LEGS
1c78bd6e-0e50-45c7-b7d2-98550fcd7e55	4973a40e-2fd2-4861-ab58-afb138dc485c	Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
1fa793cb-45e6-4313-81c5-a33d893d9616	4973a40e-2fd2-4861-ab58-afb138dc485c	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
26dd08ef-ab6b-465c-987c-d44bc4d86086	4973a40e-2fd2-4861-ab58-afb138dc485c	Dumbbell Lunges	\N	https://www.youtube.com/watch?v=lotPMgYPbyQ	Quads(Lengthened)	LEGS
d4cb00ff-480c-470f-8635-6bf030712c81	4973a40e-2fd2-4861-ab58-afb138dc485c	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
7c520d07-5ef1-4dde-a2a7-722fa50e42c9	4973a40e-2fd2-4861-ab58-afb138dc485c	Abdominal Crunch	\N	https://www.youtube.com/watch?v=ZPdx67dVJHg	Rectus Abdominis,\nTransverse Abdominis	ABS
d3293234-2683-48a9-b2af-230c77a37835	08bd2bf4-1340-4666-8518-405f5cb5b11d	Incline Bench Press	\N	https://www.youtube.com/shorts/L9UKMQw1Nss	Pecs(Upper, Middle - Lengthened), Anterior Delt	CHEST
ab61c4a5-ffe3-4244-b346-64718501507b	08bd2bf4-1340-4666-8518-405f5cb5b11d	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
0c297aa2-8574-4de2-a7dc-a0b335230ac0	08bd2bf4-1340-4666-8518-405f5cb5b11d	Cable Lateral Raises	\N	https://www.youtube.com/shorts/lK-Jupl2ciQ	Lateral Delt	SHOULDER
91272cb3-e726-42b8-b02b-9d2240c5ef66	08bd2bf4-1340-4666-8518-405f5cb5b11d	Single Arm Overhead Cable Triceps Extension	\N		Triceps(Lengthened - Long head)	TRICEPS
c121883b-5063-484e-b132-6c0e2660cb84	08bd2bf4-1340-4666-8518-405f5cb5b11d	Cable Triceps Extension	\N		Triceps(Shortened - Long Head)	TRICEPS
e476fe64-b1b3-484b-b6bf-7ee1bf06ce54	08a1f5ce-0d0b-45ed-b96f-3f20b2fdf4ec	Chair Sit to Stand	\N	https://www.youtube.com/shorts/t9VcbcNEW4E	Quads, Glutes	LEGS
a683db0b-63bd-4e73-b2ef-8372241dad60	08a1f5ce-0d0b-45ed-b96f-3f20b2fdf4ec	Wall Pushup	\N	https://www.youtube.com/watch?v=oduG4CjpSw0	Pecs, Front Delts, Triceps	CHEST
e759ba57-d215-468f-ba7c-e2572a7fb4d8	08a1f5ce-0d0b-45ed-b96f-3f20b2fdf4ec	Band/Towel Row	\N	https://www.youtube.com/watch?v=G21XrGlVRTk	Upper Back, Lats, Rear Delts, Biceps	BACK
0d81342c-ad7d-4306-af78-3ad283f1e5ef	08a1f5ce-0d0b-45ed-b96f-3f20b2fdf4ec	Glute Bridge	\N	https://www.youtube.com/watch?v=XLXGydU5DdU	Glutes, Hamstrings	LEGS
95b4020a-6589-47db-83dc-4e6838cf45e3	08a1f5ce-0d0b-45ed-b96f-3f20b2fdf4ec	Standing Heel Raises	\N	https://www.youtube.com/watch?v=dV4Yjv-gsyY	Calves	LEGS
93ed070e-2fb7-4178-967e-544dea16acd3	08a1f5ce-0d0b-45ed-b96f-3f20b2fdf4ec	Seated Marching	\N	https://www.youtube.com/shorts/3uYm4pjByP0	Quads	LEGS
cff51caa-3c8a-45d3-8887-54979cb307bd	e0fdb345-c4b5-4d77-b563-eca93d2d391d	Cat Cow	\N	https://www.youtube.com/shorts/2of247Kt0tU		MOBILITY
424451b1-cb35-413d-b74d-1fee9cd207b5	e0fdb345-c4b5-4d77-b563-eca93d2d391d	Shoulder Rolls	\N	https://www.youtube.com/shorts/A7kgx8gGmPA		MOBILITY
28ab74c2-54ff-467c-9b43-202555a98d5b	e0fdb345-c4b5-4d77-b563-eca93d2d391d	Ankle Rotation	\N	https://www.youtube.com/watch?v=sYAGbGEQMGE		MOBILITY
7af4afa2-0f17-41a1-ac22-832bd7523815	e0fdb345-c4b5-4d77-b563-eca93d2d391d	Deep Breathing	\N	https://www.youtube.com/watch?v=K353fkHYMPs		MOBILITY
86a21716-5182-4fb9-b06c-b19b9fcaec24	e0fdb345-c4b5-4d77-b563-eca93d2d391d	Standing hip extension	\N	https://www.youtube.com/shorts/ysG2GAdq2Uw		MOBILITY
4ecd734b-a181-4b43-8802-2b5a9b7b715f	e0fdb345-c4b5-4d77-b563-eca93d2d391d	Standing hip abduction	\N	https://www.youtube.com/shorts/ITyJfMetA8s		MOBILITY
4fc0422a-8be1-4786-9fc7-c9f9db19279a	484ac1ef-dae6-447d-8655-083b5400ea4e	Supported Squat to Chair	\N	https://www.youtube.com/shorts/nKf8HIHJv2E	Quads, Glutes	LEGS
1768330c-7ccc-4cc3-9551-7011c629ca6f	484ac1ef-dae6-447d-8655-083b5400ea4e	Incline Pushups	\N	https://www.youtube.com/shorts/gICmodwZ0l4	Pecs, Front Delts, Triceps	CHEST
45738aad-fc3c-4038-a969-7a815b7683e3	484ac1ef-dae6-447d-8655-083b5400ea4e	Step Ups	\N	https://www.youtube.com/shorts/85__swd8loc	Quads, Glutes, Calves	LEGS
e38ecd64-b7d2-40c3-bf40-29fbb34a45a8	484ac1ef-dae6-447d-8655-083b5400ea4e	Bird Dog	\N	https://www.youtube.com/shorts/vtwhC3tfVow	Core, Lower Back, Glutes	ABS
6b762af7-f74e-44ab-96b5-eb3f66b32ebe	484ac1ef-dae6-447d-8655-083b5400ea4e	Seated Dumbbell/Water Bottle Press	\N	https://www.youtube.com/watch?v=akdsGRoeeYA	Front Delts, Triceps	SHOULDER
913b8164-cbfe-42ce-885b-dbc1c73b5709	d18561df-8981-43f3-87e5-686c0f4acff3	Cat Cow	\N	https://www.youtube.com/shorts/2of247Kt0tU		MOBILITY
ecadfa4b-83f9-4a59-be7c-9408189c710d	d18561df-8981-43f3-87e5-686c0f4acff3	Shoulder Rolls	\N	https://www.youtube.com/shorts/A7kgx8gGmPA		MOBILITY
0a27e078-8f91-4f52-8659-4100d1896bd1	d18561df-8981-43f3-87e5-686c0f4acff3	Ankle Rotation	\N	https://www.youtube.com/watch?v=sYAGbGEQMGE		MOBILITY
d90f5468-8608-4f56-951e-6167fc0a3c28	d18561df-8981-43f3-87e5-686c0f4acff3	Deep Breathing	\N	https://www.youtube.com/watch?v=K353fkHYMPs		MOBILITY
c1188eb0-d73a-44d9-b599-6bd55c371106	d18561df-8981-43f3-87e5-686c0f4acff3	Standing hip extension	\N	https://www.youtube.com/shorts/ysG2GAdq2Uw		MOBILITY
fc1334c6-98b0-43f8-9a2a-52f5544ad2a8	d18561df-8981-43f3-87e5-686c0f4acff3	Standing hip abduction	\N	https://www.youtube.com/shorts/ITyJfMetA8s		MOBILITY
d8933401-d7d9-4054-9d3f-60ac7c7dbbb3	32848090-13f7-49d7-b9c2-c74a34183820	Chair Sit to Stand	\N	https://www.youtube.com/shorts/t9VcbcNEW4E	Quads, Glutes	LEGS
35a5a2d9-f1b9-41de-aa31-e19a13dd421c	32848090-13f7-49d7-b9c2-c74a34183820	Wall Pushup	\N	https://www.youtube.com/watch?v=oduG4CjpSw0	Pecs, Front Delts, Triceps	CHEST
cfac5fc0-67ed-4221-9e70-e4a7bc7c647f	32848090-13f7-49d7-b9c2-c74a34183820	Band/Towel Row	\N	https://www.youtube.com/watch?v=G21XrGlVRTk	Upper Back, Lats, Rear Delts, Biceps	BACK
aef0ab0e-2487-4318-b3cf-987757377e1d	32848090-13f7-49d7-b9c2-c74a34183820	Glute Bridge	\N	https://www.youtube.com/watch?v=XLXGydU5DdU	Glutes, Hamstrings	LEGS
8e65a39a-3d87-486e-a308-2b447477aefd	32848090-13f7-49d7-b9c2-c74a34183820	Standing Heel Raises	\N	https://www.youtube.com/watch?v=dV4Yjv-gsyY	Calves	LEGS
f297f7e9-89a6-4647-8e0d-d0461aaa6082	32848090-13f7-49d7-b9c2-c74a34183820	Seated Marching	\N	https://www.youtube.com/shorts/3uYm4pjByP0	Quads	LEGS
b0122186-9b95-4e0b-a542-8b0ecb24d291	51a33c7d-77b3-4c65-8c80-30dd2f0d4cc9	Cat Cow	\N	https://www.youtube.com/shorts/2of247Kt0tU		MOBILITY
26bf61df-013f-45c0-9859-a5bdda77da72	51a33c7d-77b3-4c65-8c80-30dd2f0d4cc9	Shoulder Rolls	\N	https://www.youtube.com/shorts/A7kgx8gGmPA		MOBILITY
760bad5e-1206-4c0e-8445-1ff4ae1b8392	51a33c7d-77b3-4c65-8c80-30dd2f0d4cc9	Ankle Rotation	\N	https://www.youtube.com/watch?v=sYAGbGEQMGE		MOBILITY
9c20437d-e12e-4112-b5af-a564164b48cb	51a33c7d-77b3-4c65-8c80-30dd2f0d4cc9	Deep Breathing	\N	https://www.youtube.com/watch?v=K353fkHYMPs		MOBILITY
6b60138f-0122-4f85-a4e1-0a96cbb6f34f	51a33c7d-77b3-4c65-8c80-30dd2f0d4cc9	Standing hip extension	\N	https://www.youtube.com/shorts/ysG2GAdq2Uw		MOBILITY
3ce61138-896f-4bb3-94ee-fb396924444b	51a33c7d-77b3-4c65-8c80-30dd2f0d4cc9	Standing hip abduction	\N	https://www.youtube.com/shorts/ITyJfMetA8s		MOBILITY
ce223458-7ef0-4d8c-9e03-04f4eaec5ab8	a70cbb73-dc3e-4a93-8eed-079317b41064	Chair Sit to Stand	\N	https://www.youtube.com/shorts/t9VcbcNEW4E	Quads, Glutes	LEGS
74647c44-2047-486f-8d59-6e35eb9f87d6	a70cbb73-dc3e-4a93-8eed-079317b41064	Wall Pushup	\N	https://www.youtube.com/watch?v=oduG4CjpSw0	Pecs, Front Delts, Triceps	CHEST
9fef4d09-cc09-4652-8b95-47b8ddebf364	a70cbb73-dc3e-4a93-8eed-079317b41064	Band Pull-apart	\N	https://www.youtube.com/shorts/SuvO4TBwSu4	Rear Delts	BACK
45000299-d459-4318-801c-878afc1df41b	a70cbb73-dc3e-4a93-8eed-079317b41064	Band/Towel Row	\N	https://www.youtube.com/watch?v=G21XrGlVRTk	Upper Back, Lats, Rear Delts, Biceps	BACK
f28629a1-fcf6-4de3-af02-dce3ae97240e	a70cbb73-dc3e-4a93-8eed-079317b41064	Glute Bridge	\N	https://www.youtube.com/watch?v=XLXGydU5DdU	Glutes, Hamstrings	LEGS
2dfc147c-eea9-4693-9987-8fa1b34e5ef6	a70cbb73-dc3e-4a93-8eed-079317b41064	Standing Heel Raises	\N	https://www.youtube.com/watch?v=dV4Yjv-gsyY	Calves	LEGS
b6df4b2a-1e64-427d-834f-de35bb208276	a70cbb73-dc3e-4a93-8eed-079317b41064	Seated Marching	\N	https://www.youtube.com/shorts/3uYm4pjByP0	Quads	LEGS
0e7d97c5-d8d7-4d0b-8058-6d02e8adfc06	7eb36cd9-cd52-45d7-a5dc-e48900379b9a	Cat Cow	\N	https://www.youtube.com/shorts/2of247Kt0tU		MOBILITY
d5f95cf7-90ad-4fd0-bf23-534d7ec23aa4	7eb36cd9-cd52-45d7-a5dc-e48900379b9a	Shoulder Rolls	\N	https://www.youtube.com/shorts/A7kgx8gGmPA		MOBILITY
633e677f-512f-455d-af47-46425c52747c	7eb36cd9-cd52-45d7-a5dc-e48900379b9a	Ankle Rotation	\N	https://www.youtube.com/watch?v=sYAGbGEQMGE		MOBILITY
c94391c5-49b5-45a5-9511-5bc64ee9d4fd	7eb36cd9-cd52-45d7-a5dc-e48900379b9a	Deep Breathing	\N	https://www.youtube.com/watch?v=K353fkHYMPs		MOBILITY
a398ab54-8547-48b4-8e19-fa295e0a38e7	7eb36cd9-cd52-45d7-a5dc-e48900379b9a	Standing hip extension	\N	https://www.youtube.com/shorts/ysG2GAdq2Uw		MOBILITY
e6f94e91-0367-487a-a81e-588c63f7aa82	7eb36cd9-cd52-45d7-a5dc-e48900379b9a	Standing hip abduction	\N	https://www.youtube.com/shorts/ITyJfMetA8s		MOBILITY
2107c7e7-ca65-41bb-ab19-c2cbe69812d7	b5294cac-c19e-4d9d-9fa1-336644662c93	Supported Squat to Chair	\N	https://www.youtube.com/shorts/nKf8HIHJv2E	Quads, Glutes	LEGS
c16a4c16-6857-48bd-aae7-89002ef9e688	b5294cac-c19e-4d9d-9fa1-336644662c93	Incline Pushups	\N	https://www.youtube.com/shorts/gICmodwZ0l4	Pecs, Front Delts, Triceps	CHEST
4d5b8e60-a1ea-46ba-b1c3-ce3516cb879d	b5294cac-c19e-4d9d-9fa1-336644662c93	Step Ups	\N	https://www.youtube.com/shorts/85__swd8loc	Quads, Glutes, Calves	LEGS
7c9f992a-91ec-4877-8287-43eb4d537ba6	b5294cac-c19e-4d9d-9fa1-336644662c93	Bird Dog	\N	https://www.youtube.com/shorts/vtwhC3tfVow	Core, Lower Back, Glutes	ABS
c1ed34dd-6704-4e21-9862-85aec9c6c0f1	b5294cac-c19e-4d9d-9fa1-336644662c93	Dead Bug	\N	https://www.youtube.com/watch?v=mUMVASv0x7U	Core, Lower Back, Glutes	ABS
69433820-c542-4179-b44d-50a93a7204af	0af1f293-2ce9-4f10-b6af-1b36e4faf220	Standing hip extension	\N	https://www.youtube.com/shorts/ysG2GAdq2Uw		MOBILITY
287e10f7-88e2-4679-a5c2-f7b03db74b1b	0af1f293-2ce9-4f10-b6af-1b36e4faf220	Standing hip abduction	\N	https://www.youtube.com/shorts/ITyJfMetA8s		MOBILITY
56674a0a-e75c-4fe8-9caa-077f92c5d863	0af1f293-2ce9-4f10-b6af-1b36e4faf220	Cat Cow	\N	https://www.youtube.com/shorts/2of247Kt0tU		MOBILITY
e4ac9ecf-17fb-4275-b36c-f47a166d9a83	0af1f293-2ce9-4f10-b6af-1b36e4faf220	Shoulder Rolls	\N	https://www.youtube.com/shorts/A7kgx8gGmPA		MOBILITY
c3513a63-c2b5-4d56-9825-71294e5b3fde	0af1f293-2ce9-4f10-b6af-1b36e4faf220	Ankle Rotation	\N	https://www.youtube.com/watch?v=sYAGbGEQMGE		MOBILITY
f5781710-77c1-4ba8-a0c0-d18749315fe6	0af1f293-2ce9-4f10-b6af-1b36e4faf220	Deep Breathing	\N	https://www.youtube.com/watch?v=K353fkHYMPs		MOBILITY
a115430b-5433-4c54-afc6-5d8656694b30	0d19d8b8-4e08-40de-8c16-6579d1504c81	Chair Sit to Stand	\N	https://www.youtube.com/shorts/t9VcbcNEW4E	Quads, Glutes	LEGS
29bec461-6e00-4621-ace6-b4c3426098bf	0d19d8b8-4e08-40de-8c16-6579d1504c81	Band Pull-apart	\N	https://www.youtube.com/shorts/SuvO4TBwSu4	Rear Delts	BACK
e18efa2e-76f0-4a92-aa8b-65175a343fe5	0d19d8b8-4e08-40de-8c16-6579d1504c81	Wall Pushup	\N	https://www.youtube.com/watch?v=oduG4CjpSw0	Pecs, Front Delts, Triceps	CHEST
ba0dbb01-dc25-4554-a712-828963208c52	0d19d8b8-4e08-40de-8c16-6579d1504c81	Band/Towel Row	\N	https://www.youtube.com/watch?v=G21XrGlVRTk	Upper Back, Lats, Rear Delts, Biceps	BACK
fc16ddf6-2424-41fe-b07d-ebcab8f4bac3	0d19d8b8-4e08-40de-8c16-6579d1504c81	Glute Bridge	\N	https://www.youtube.com/watch?v=XLXGydU5DdU	Glutes, Hamstrings	LEGS
7041992a-52bf-425c-876e-804a4d32826d	0d19d8b8-4e08-40de-8c16-6579d1504c81	Standing Heel Raises	\N	https://www.youtube.com/watch?v=dV4Yjv-gsyY	Calves	LEGS
c5f7e498-0115-47f2-9d51-e9c8903f8a75	0d19d8b8-4e08-40de-8c16-6579d1504c81	Seated Marching	\N	https://www.youtube.com/shorts/3uYm4pjByP0	Quads	LEGS
4e829657-edd4-42c1-8fd8-0d28af437ca3	bd78ab96-d993-49a7-8884-d8dc41b58f04	Ankle Rotation	\N	https://www.youtube.com/watch?v=sYAGbGEQMGE		MOBILITY
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
901c4bd6-14b8-4191-88b1-664716987e9d	bd78ab96-d993-49a7-8884-d8dc41b58f04	Deep Breathing	\N	https://www.youtube.com/watch?v=K353fkHYMPs		MOBILITY
785e3d72-dede-4025-8dc8-29b245875c89	bd78ab96-d993-49a7-8884-d8dc41b58f04	Cat Cow	\N	https://www.youtube.com/shorts/2of247Kt0tU		MOBILITY
44e6be67-f6bf-47dc-bc12-69aec38df011	bd78ab96-d993-49a7-8884-d8dc41b58f04	Shoulder Rolls	\N	https://www.youtube.com/shorts/A7kgx8gGmPA		MOBILITY
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
6cf57502-ccf5-4aa0-b09b-ec0dc0794367	bd78ab96-d993-49a7-8884-d8dc41b58f04	Standing hip extension	\N	https://www.youtube.com/shorts/ysG2GAdq2Uw		MOBILITY
8a647902-f2db-4f0e-9953-0ee4c151560c	bd78ab96-d993-49a7-8884-d8dc41b58f04	Standing hip abduction	\N	https://www.youtube.com/shorts/ITyJfMetA8s		MOBILITY
9801303b-63f4-4c9e-b81b-f03103060d92	4e43cd1c-e6d2-43ed-9095-1a69ef0dd8ef	Incline Barbell Chest Press	\N	https://www.youtube.com/watch?v=6YaZyZyeito	Pecs(Upper, Middle - Lengthened), Anterior Delt	CHEST
ff29d61c-5696-4ccf-8bc5-d1ebb330f6a7	4e43cd1c-e6d2-43ed-9095-1a69ef0dd8ef	Seated Cable Chest Press	\N	https://www.youtube.com/watch?v=aQ5VspphLjE	Pecs(Upper, middle - shortened), Anterior Delts	CHEST
84f6aec0-7796-4833-b85b-d618be979086	4e43cd1c-e6d2-43ed-9095-1a69ef0dd8ef	Dumbbell Chest Fly	\N	https://www.youtube.com/watch?v=Nhvz9EzdJ4U	Pecs(Upper, middle - Lengthened),\nAnterior Delts	CHEST
18f7e7c2-c259-4b27-ae87-eb614de12d75	4e43cd1c-e6d2-43ed-9095-1a69ef0dd8ef	Chest Supported Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=pDzjKXU3Lto	Lateral Delt	SHOULDER
5bf23efe-d292-414e-8306-9e31c39a4144	4e43cd1c-e6d2-43ed-9095-1a69ef0dd8ef	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U	Triceps(Long head - Lengthened)	TRICEPS
bae4749b-27d8-461a-bae1-337af3dae97a	4e43cd1c-e6d2-43ed-9095-1a69ef0dd8ef	Single Arm Triceps Crossover	\N	https://www.youtube.com/watch?v=lC9NRhFN7X4	Tricpes(Shortened - Long Head)	TRICEPS
dcc068ea-52ff-4370-a6e2-5a1c1330d464	cf4d1661-6b65-4590-8e14-1dfee2c7ddf4	Single Arm Lat Pulldown	\N	https://www.youtube.com/shorts/paOm0L4zrCE	Lats(Vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
dd1367d0-4a52-4c5d-8952-94f93d4f795f	cf4d1661-6b65-4590-8e14-1dfee2c7ddf4	Seated Cable Row	\N	https://www.youtube.com/watch?v=mnUUQWcqHPQ	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
735a779f-45db-4f91-b444-e72de6cc44d0	cf4d1661-6b65-4590-8e14-1dfee2c7ddf4	Incline Dumbell Curl	\N	https://www.youtube.com/watch?v=EiPYwFGeMwc	Biceps(Lengthened)	BICEPS
430d105f-0507-4d81-9b7c-ed13642b8de8	cf4d1661-6b65-4590-8e14-1dfee2c7ddf4	Preacher Curl Machine	\N	https://www.youtube.com/watch?v=e1Lh7RVV2NQ	Biceps(Shortened)	BICEPS
1de5303f-a1eb-42cc-b6d7-6bdb98816883	cf4d1661-6b65-4590-8e14-1dfee2c7ddf4	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM	Upper Traps	BACK
204104e3-21c9-475a-bd88-825e7fb4f0c7	cf4d1661-6b65-4590-8e14-1dfee2c7ddf4	Rear Delt Cable Pull	\N	https://www.youtube.com/watch?v=JUKuGImz51U	Rear Delts,\nRhomboids	SHOULDER
50b6002f-277b-4b40-afc8-4acdaa119f85	e4f06846-76cb-4894-9b09-637c1d331898	Barbell Squats	\N	https://www.youtube.com/watch?v=EBItm_AOzK8	Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
e6cc030b-8e80-4e94-ba1a-b41105f48379	e4f06846-76cb-4894-9b09-637c1d331898	Seated Leg Extension	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
bd6b0551-3e93-406d-bef9-93f06de1bf11	e4f06846-76cb-4894-9b09-637c1d331898	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
0ae733c1-976a-44c3-af79-f1651ef6d1cc	e4f06846-76cb-4894-9b09-637c1d331898	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
9c49db8d-b57e-4667-a6d9-883b0b3f48f4	e4f06846-76cb-4894-9b09-637c1d331898	Reverse Crunches	\N	https://www.youtube.com/watch?v=U-eR6Pt1gZA&pp=0gcJCcUKAYcqIYzv	Rectus Abdominis, Transverse Abdominis	ABS
6736c736-ad77-40f2-8c79-4a8a9c88b79c	e4f06846-76cb-4894-9b09-637c1d331898	Side Bending with cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
18ee5535-7629-489b-81f3-a7d0efb23fb7	6ee37999-5c57-428d-bb59-7c06d637c27f	Incline Barbell Chest Press	\N	https://www.youtube.com/watch?v=6YaZyZyeito	Pecs(Upper, Middle - Lengthened), Anterior Delt	CHEST
b7dbd1c5-ed05-42de-9785-9918d897a7e5	6ee37999-5c57-428d-bb59-7c06d637c27f	Seated Cable Chest Press	\N	https://www.youtube.com/watch?v=aQ5VspphLjE	Pecs(Upper, middle - shortened), Anterior Delts	CHEST
0495ad7d-fd05-401a-b29b-e1b90143bfab	6ee37999-5c57-428d-bb59-7c06d637c27f	Dumbbell Chest Fly	\N	https://www.youtube.com/watch?v=Nhvz9EzdJ4U	Pecs(Upper, middle - Lengthened),\nAnterior Delts	CHEST
d61464ad-cc37-4fd9-8019-7a11115e3c83	6ee37999-5c57-428d-bb59-7c06d637c27f	Chest Supported Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=pDzjKXU3Lto	Lateral Delt	SHOULDER
2621377a-d506-441f-bc91-5692c18c3f31	6ee37999-5c57-428d-bb59-7c06d637c27f	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U	Triceps(Long head - Lengthened)	TRICEPS
73b0f0c3-d7f0-49c2-814f-d2a5c925d19b	6ee37999-5c57-428d-bb59-7c06d637c27f	Single Arm Triceps Crossover	\N	https://www.youtube.com/watch?v=lC9NRhFN7X4	Tricpes(Shortened - Long Head)	TRICEPS
5d61a0d3-d98d-4b99-8c16-95564c52b2d7	b6f26856-f06c-4baf-9b3c-cb2e022a9573	Single Arm Lat Pulldown	\N	https://www.youtube.com/shorts/paOm0L4zrCE	Lats(Vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
34a71cf2-2bc4-4597-8fce-d59a4d9e2d96	b6f26856-f06c-4baf-9b3c-cb2e022a9573	Seated Cable Row	\N	https://www.youtube.com/watch?v=mnUUQWcqHPQ	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
7eb8a0d1-9658-40d5-90c5-e720382c41c6	b6f26856-f06c-4baf-9b3c-cb2e022a9573	Incline Dumbell Curl	\N	https://www.youtube.com/watch?v=EiPYwFGeMwc	Biceps(Lengthened)	BICEPS
cb8806da-272c-4aba-8eed-99442aa55e4b	b6f26856-f06c-4baf-9b3c-cb2e022a9573	Preacher Curl Machine	\N	https://www.youtube.com/watch?v=e1Lh7RVV2NQ	Biceps(Shortened)	BICEPS
cf2628cf-c887-4abe-acf1-ffdbc1c17d05	b6f26856-f06c-4baf-9b3c-cb2e022a9573	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM	Upper Traps	BACK
570819fb-aefb-43bb-9116-d7b5cca3c949	b6f26856-f06c-4baf-9b3c-cb2e022a9573	Rear Delt Cable Pull	\N	https://www.youtube.com/watch?v=JUKuGImz51U	Rear Delts,\nRhomboids	SHOULDER
3bbbf4eb-784e-4a09-a416-ee2af0fbe0c5	3e4d7190-2289-4214-a9fd-7de7a02b8c0e	Barbell Squats	\N	https://www.youtube.com/watch?v=EBItm_AOzK8	Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
8b368c38-2585-4c78-a0aa-4291eeb0bed0	3e4d7190-2289-4214-a9fd-7de7a02b8c0e	Seated Leg Extension	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
a1c50189-5b2b-48c4-b2cd-e719ddc56027	3e4d7190-2289-4214-a9fd-7de7a02b8c0e	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
ec716fe1-113a-4370-91ad-1e3191335d2f	3e4d7190-2289-4214-a9fd-7de7a02b8c0e	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
9293c77a-af4a-47ec-b662-e86fb75cbff9	3e4d7190-2289-4214-a9fd-7de7a02b8c0e	Reverse Crunches	\N	https://www.youtube.com/watch?v=U-eR6Pt1gZA&pp=0gcJCcUKAYcqIYzv	Rectus Abdominis, Transverse Abdominis	ABS
1ffb5efd-ee1b-47eb-ad77-6fc31bb61724	3e4d7190-2289-4214-a9fd-7de7a02b8c0e	Side Bending with cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
9a5a6381-253d-4e8a-850c-84c6cbd51613	08bd2bf4-1340-4666-8518-405f5cb5b11d	Cable Fly	\N	https://www.youtube.com/shorts/MD1IfN687a8	Pecs(Upper, middle - shortened, active throughout ROM ), Anterior Delts	CHEST
90c64a3c-3237-4c09-b15e-44e6d32878ab	ef6faf74-7441-464f-b499-5f04f9bbeefc	Single Arm Lat Pulldown	\N	https://www.youtube.com/shorts/paOm0L4zrCE	Lats(Vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
4505c6a7-eb62-40d4-9dbb-b5f9e6fb366e	ef6faf74-7441-464f-b499-5f04f9bbeefc	Seated Cable Row	\N	https://www.youtube.com/shorts/3cR8rElT5sY	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
fc7c1df1-d26d-43fb-963e-312ed492928d	ef6faf74-7441-464f-b499-5f04f9bbeefc	Barbell Shrugs	\N	https://www.youtube.com/watch?v=larn3Asl6oM	Upper Traps	BACK
9e1b694b-8b9e-438c-8dd1-97832ad4d570	ef6faf74-7441-464f-b499-5f04f9bbeefc	Single Arm DB Preacher Curls	\N	https://www.youtube.com/shorts/Mg0NnlF5NZQ	Biceps(Shortened)	BICEPS
9c37c04f-20c8-493f-9ba7-c8534110a105	ef6faf74-7441-464f-b499-5f04f9bbeefc	Incline Dumbell Curl	\N	https://www.youtube.com/shorts/Bi88U34pdE4	Biceps(Lengthened)	BICEPS
c64b7704-1da7-4f18-a448-bae191121283	ef6faf74-7441-464f-b499-5f04f9bbeefc	Cable Rear Delt Fly	\N	https://www.youtube.com/shorts/iidcl0mf_4c	Rear Delts,\nRhomboids	BACK
283a4330-7b46-44a7-8ecb-cab3be31f961	7372cb03-eccb-4936-a81d-c7ffb3a2370a	Barbell Squats	\N		Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
a7442f52-cae1-4dbb-9158-2147b1f893a3	7372cb03-eccb-4936-a81d-c7ffb3a2370a	Stiff Leg Deadlift(Barbell)	\N		Hamstrings(Lengthened),\nGlutes(Lengthened)	LEGS
51409d5b-8a86-49c3-b9c0-29be07ca4612	7372cb03-eccb-4936-a81d-c7ffb3a2370a	Leg Extensions	\N		Quads(Shortened)	LEGS
9902e42b-e6d4-417b-af9c-0e8e2ce839a4	7372cb03-eccb-4936-a81d-c7ffb3a2370a	Abdominal Crunch	\N		Rectus Abdominis,\nTransverse Abdominis	ABS
11fb7ebe-fa8a-4820-9516-1b36892a0403	7372cb03-eccb-4936-a81d-c7ffb3a2370a	Side Bending with Cable	\N	https://www.youtube.com/shorts/RvCR6YWkQiA	Obliques	ABS
6beb0f49-70a9-4e6e-b294-0dc0343c7021	7372cb03-eccb-4936-a81d-c7ffb3a2370a	Dumbbell Single Leg Standing Calf Raise	\N	https://www.youtube.com/watch?v=KcTEGifMTDY	Gastroc, Soleus	LEGS
4782d2ff-3d98-44e7-9fea-fdbe7f4d6ddc	2f65579e-9f11-430c-a26c-1774109b79db	Incline Bench Press	\N	https://www.youtube.com/shorts/L9UKMQw1Nss	Pecs(Upper, Middle - Lengthened), Anterior Delt	CHEST
dd0e15ea-529c-40e7-8338-85690c243496	2f65579e-9f11-430c-a26c-1774109b79db	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
0eeb939d-f2f1-4d4f-ba66-fd58c6aba469	2f65579e-9f11-430c-a26c-1774109b79db	Cable Lateral Raises	\N	https://www.youtube.com/shorts/lK-Jupl2ciQ	Lateral Delt	SHOULDER
a3a5fff5-1d80-426a-beb3-c4550853a688	2f65579e-9f11-430c-a26c-1774109b79db	Single Arm Overhead Cable Triceps Extension	\N		Triceps(Lengthened - Long head)	TRICEPS
544e44bd-1e9e-4aed-a683-58d11634e118	2f65579e-9f11-430c-a26c-1774109b79db	Cable Triceps Extension	\N		Triceps(Shortened - Long Head)	TRICEPS
dc9d4188-02ff-46f6-a30c-48c92387ca9d	2f65579e-9f11-430c-a26c-1774109b79db	Cable Fly	\N	https://www.youtube.com/shorts/MD1IfN687a8	Pecs(Upper, middle - shortened, active throughout ROM ), Anterior Delts	CHEST
a601fa4e-d96d-49a0-b4ae-722a11cea185	a312e638-eb49-4743-a146-09eaa154c30e	Single Arm Lat Pulldown	\N	https://www.youtube.com/shorts/paOm0L4zrCE	Lats(Vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
3b238555-607a-43be-ae9e-ff136c0d7dec	a312e638-eb49-4743-a146-09eaa154c30e	Seated Cable Row	\N	https://www.youtube.com/shorts/3cR8rElT5sY	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
0b511a97-1b21-4907-ad93-d6a35334bcb2	a312e638-eb49-4743-a146-09eaa154c30e	Barbell Shrugs	\N	https://www.youtube.com/watch?v=larn3Asl6oM	Upper Traps	BACK
fff13cf0-b65a-4f5e-b551-63ba2e07270f	a312e638-eb49-4743-a146-09eaa154c30e	Single Arm DB Preacher Curls	\N	https://www.youtube.com/shorts/Mg0NnlF5NZQ	Biceps(Shortened)	BICEPS
3f0f6177-b9e1-4050-b4b7-bf1efe348fa7	a312e638-eb49-4743-a146-09eaa154c30e	Incline Dumbell Curl	\N	https://www.youtube.com/shorts/Bi88U34pdE4	Biceps(Lengthened)	BICEPS
17fa0f88-d1d6-4349-bbe4-cf6d5a93e5b1	a312e638-eb49-4743-a146-09eaa154c30e	Cable Rear Delt Fly	\N	https://www.youtube.com/shorts/iidcl0mf_4c	Rear Delts,\nRhomboids	BACK
04d7eb01-a128-4db4-891c-97fbe2539ab2	32a8e514-590f-45ca-bede-2c6d98c3006d	Barbell Squats	\N		Quads(Lengthened), Glutes(Lengthened), Spinal Erectors	LEGS
9cb83099-9213-42c0-b628-4d3567995c4e	32a8e514-590f-45ca-bede-2c6d98c3006d	Stiff Leg Deadlift(Barbell)	\N		Hamstrings(Lengthened),\nGlutes(Lengthened)	LEGS
320b34c9-f872-40fb-abb5-b6fb436287e5	32a8e514-590f-45ca-bede-2c6d98c3006d	Leg Extensions	\N		Quads(Shortened)	LEGS
314dec7c-7449-447c-b77a-99e2aca2930e	32a8e514-590f-45ca-bede-2c6d98c3006d	Abdominal Crunch	\N		Rectus Abdominis,\nTransverse Abdominis	ABS
e60cd32a-6ded-484c-8f68-26ee84ad2600	32a8e514-590f-45ca-bede-2c6d98c3006d	Side Bending with Cable	\N	https://www.youtube.com/shorts/RvCR6YWkQiA	Obliques	ABS
55f3224f-a814-49ff-977c-998d6b8f301f	32a8e514-590f-45ca-bede-2c6d98c3006d	Dumbbell Single Leg Standing Calf Raise	\N	https://www.youtube.com/watch?v=KcTEGifMTDY	Gastroc, Soleus	LEGS
f7e0aee3-e979-42dc-ad90-bb7ea6351fea	879f1dc5-1e02-459d-9339-5ccd6918468c	Chair Squats	\N	https://www.youtube.com/shorts/ATYX9LAbpdY	Quadriceps, Glutes, Adductors	LEGS
0030b8f9-671f-4515-bf52-462eb727b1ff	879f1dc5-1e02-459d-9339-5ccd6918468c	Wall Push-up	\N	https://www.youtube.com/shorts/JlrVJaPn5o4	Pectoralis Major, Anterior Delts, Triceps	CHEST
aa22e02c-3409-470a-984d-ab8941dfdeca	879f1dc5-1e02-459d-9339-5ccd6918468c	Glute Bridge	\N	https://www.youtube.com/shorts/mSuDY5J0Fwo	Glutes, Hamstrings	LEGS
b458c54c-351b-4277-ad97-6d5d22d84930	879f1dc5-1e02-459d-9339-5ccd6918468c	Standing Hip Hinge	\N	https://www.youtube.com/shorts/9Ww7jGzO09M	Hamstrings (Lengthened), Glutes, Lower Back	LEGS
5125ac62-eb64-438e-bb13-b77060978ae9	879f1dc5-1e02-459d-9339-5ccd6918468c	Dead Bug	\N	https://www.youtube.com/shorts/5c-vucY3beU	Rectus Abdominis, Transverse Abdominis, Core Stabilizers	ABS
36d531a7-ffb5-4089-8065-5977daa2fe7e	879f1dc5-1e02-459d-9339-5ccd6918468c	Standing Calf Raises	\N	https://www.youtube.com/watch?v=7ZJZP1Vr1zM	Gastroc, Soleus	LEGS
0120de7f-cee6-4cac-979c-6ade0d656d38	58195833-191d-4414-af0e-b85b7ff76470	Box Squat(Chair)	\N	https://www.youtube.com/shorts/9FwV5CKn9-Y	Quadriceps, Glutes, Adductors	LEGS
762c9383-5195-438f-bab5-ad5e60a78082	58195833-191d-4414-af0e-b85b7ff76470	Incline Push-up(Table/Kitchen Counter)	\N	https://www.youtube.com/shorts/gICmodwZ0l4	Pectoralis Major, Anterior Delts, Triceps	CHEST
2123d118-5a5f-40f0-9c64-10d39cd53a6e	58195833-191d-4414-af0e-b85b7ff76470	Assisted Reverse Lunge	\N	https://www.youtube.com/watch?v=7r4VC2pBc7I	Quadriceps, Glutes, Hamstrings	LEGS
2f29470c-384b-49e4-87f4-1811e02c24be	58195833-191d-4414-af0e-b85b7ff76470	Superman Hold	\N	https://www.youtube.com/shorts/eKB5rv5c7FQ	Erector Spinae, Glutes, Posterior Shoulder	BACK
4f8844db-d1dc-47b1-a763-a318ed43592e	58195833-191d-4414-af0e-b85b7ff76470	Standing Side Leg Raise	\N	https://www.youtube.com/shorts/1TUM8EutxOQ	Glute Medius, Glute Minimus	LEGS
8c8dd26b-ca46-486b-b442-e496d1a51bff	58195833-191d-4414-af0e-b85b7ff76470	Side Plank (Bent Knees)	\N	https://www.youtube.com/shorts/OxUqMcC944g	Obliques, Transverse Abdominis, Glute Medius	ABS
e7c770c5-f5db-42a1-bbc0-7b47a7588c21	1a814d00-224e-44e5-9ac7-39f3ac0a49ed	Pendulum Swings	\N	https://www.youtube.com/watch?v=bVPyY0oXfmc	Shoulder Joint Mobility	SHOULDER
02b4d117-600a-4663-832b-74a80cb35d3e	1a814d00-224e-44e5-9ac7-39f3ac0a49ed	Wall Slides	\N	https://www.youtube.com/shorts/OtgQDv7u1TM	Serratus Anterior, Lower Traps, Rotator Cuff	SHOULDER
30cccaa0-3ed2-477c-9938-a188410c030e	1a814d00-224e-44e5-9ac7-39f3ac0a49ed	Scapular Wall Push-ups	\N	https://www.youtube.com/shorts/JilBkjwhFHc	Serratus Anterior, Scapular Stabilizers	SHOULDER
17173575-ab6b-4623-a265-962dcbd076e5	1a814d00-224e-44e5-9ac7-39f3ac0a49ed	External Rotation Isometric (Against Wall)	\N	https://www.youtube.com/shorts/kWtMKNnjyd0	Infraspinatus, Teres Minor	SHOULDER
e1a428a8-0b42-4f10-9bdd-52ce3e124172	1a814d00-224e-44e5-9ac7-39f3ac0a49ed	Internal Rotation Isometric (Against Wall)	\N	https://www.youtube.com/shorts/ewhkUx4SAQE	Subscapularis	SHOULDER
95e3e409-b72b-4d14-a140-bb110c6f7638	1a814d00-224e-44e5-9ac7-39f3ac0a49ed	Bird Dog	\N	https://www.youtube.com/shorts/vtwhC3tfVow	Core Stabilizers, Glutes, Lower Back	ABS
be202e25-0357-41cc-9bea-3a199f47f389	1a814d00-224e-44e5-9ac7-39f3ac0a49ed	Cat-Cow	\N	https://www.youtube.com/shorts/2of247Kt0tU	Thoracic Spine, Lumbar Spine	MOBILITY
0145f0a2-6015-413e-a60f-58310a6043e1	853797e0-30e9-4374-8077-fdcc99a84c12	Chair Squats	\N	https://www.youtube.com/shorts/ATYX9LAbpdY	Quadriceps, Glutes, Adductors	LEGS
8dae9eae-9a61-4ec9-a7bc-8e0aaed4d7fd	853797e0-30e9-4374-8077-fdcc99a84c12	Wall Push-up	\N	https://www.youtube.com/shorts/JlrVJaPn5o4	Pectoralis Major, Anterior Delts, Triceps	CHEST
5c8fa0a4-c403-4704-bb35-66d4015e5c8b	853797e0-30e9-4374-8077-fdcc99a84c12	Glute Bridge	\N	https://www.youtube.com/shorts/mSuDY5J0Fwo	Glutes, Hamstrings	LEGS
e0892c7c-a382-4d36-9a93-025e05c4fdf2	853797e0-30e9-4374-8077-fdcc99a84c12	Standing Hip Hinge	\N	https://www.youtube.com/shorts/9Ww7jGzO09M	Hamstrings (Lengthened), Glutes, Lower Back	LEGS
3752827b-7a60-4ee7-9ef3-c7d57de268c9	853797e0-30e9-4374-8077-fdcc99a84c12	Dead Bug	\N	https://www.youtube.com/shorts/5c-vucY3beU	Rectus Abdominis, Transverse Abdominis, Core Stabilizers	ABS
6f95c836-948c-43da-a90b-87fa162373b2	853797e0-30e9-4374-8077-fdcc99a84c12	Standing Calf Raises	\N	https://www.youtube.com/watch?v=7ZJZP1Vr1zM	Gastroc, Soleus	LEGS
36adac09-1d1a-4bce-877e-edfae6bfeac9	0809c388-02d6-4f14-87ee-5c67b41605fe	Box Squat(Chair)	\N	https://www.youtube.com/shorts/9FwV5CKn9-Y	Quadriceps, Glutes, Adductors	LEGS
1fb9a110-405b-413e-b2a6-61cf875bfad7	0809c388-02d6-4f14-87ee-5c67b41605fe	Incline Push-up(Table/Kitchen Counter)	\N	https://www.youtube.com/shorts/gICmodwZ0l4	Pectoralis Major, Anterior Delts, Triceps	CHEST
12559ab7-aebb-438d-a7f5-08656f6fbdd2	0809c388-02d6-4f14-87ee-5c67b41605fe	Assisted Reverse Lunge	\N	https://www.youtube.com/watch?v=7r4VC2pBc7I	Quadriceps, Glutes, Hamstrings	LEGS
1e4c10a6-33fe-49c4-ba10-b055acd92383	0809c388-02d6-4f14-87ee-5c67b41605fe	Superman Hold	\N	https://www.youtube.com/shorts/eKB5rv5c7FQ	Erector Spinae, Glutes, Posterior Shoulder	BACK
edc51e77-37d6-4127-b4d8-906c283b9338	0809c388-02d6-4f14-87ee-5c67b41605fe	Standing Side Leg Raise	\N	https://www.youtube.com/shorts/1TUM8EutxOQ	Glute Medius, Glute Minimus	LEGS
0631a0df-542c-4937-84d2-a86173cd6725	0809c388-02d6-4f14-87ee-5c67b41605fe	Side Plank (Bent Knees)	\N	https://www.youtube.com/shorts/OxUqMcC944g	Obliques, Transverse Abdominis, Glute Medius	ABS
1b786d4c-4609-4a47-94f6-9301318bff6b	cc518a9b-28b3-4672-959b-cff09d0bfb67	Pendulum Swings	\N	https://www.youtube.com/watch?v=bVPyY0oXfmc	Shoulder Joint Mobility	SHOULDER
53a1d5a7-a270-4fcb-aaf8-0783e36c4b42	cc518a9b-28b3-4672-959b-cff09d0bfb67	Wall Slides	\N	https://www.youtube.com/shorts/OtgQDv7u1TM	Serratus Anterior, Lower Traps, Rotator Cuff	SHOULDER
93c266d7-2e98-4e57-ad84-2e90e75e7069	cc518a9b-28b3-4672-959b-cff09d0bfb67	Scapular Wall Push-ups	\N	https://www.youtube.com/shorts/JilBkjwhFHc	Serratus Anterior, Scapular Stabilizers	SHOULDER
d1ea347c-82bf-4e3d-bdd3-0ccfcc5b64ed	cc518a9b-28b3-4672-959b-cff09d0bfb67	External Rotation Isometric (Against Wall)	\N	https://www.youtube.com/shorts/kWtMKNnjyd0	Infraspinatus, Teres Minor	SHOULDER
4a3b7069-e1b4-4d50-a0c6-c054e5245a0e	cc518a9b-28b3-4672-959b-cff09d0bfb67	Internal Rotation Isometric (Against Wall)	\N	https://www.youtube.com/shorts/ewhkUx4SAQE	Subscapularis	SHOULDER
4b610fbe-93cc-4127-b7d3-f37a61ef2153	cc518a9b-28b3-4672-959b-cff09d0bfb67	Bird Dog	\N	https://www.youtube.com/shorts/vtwhC3tfVow	Core Stabilizers, Glutes, Lower Back	ABS
961e438b-375c-4734-8e2b-6c38a8933b75	cc518a9b-28b3-4672-959b-cff09d0bfb67	Cat-Cow	\N	https://www.youtube.com/shorts/2of247Kt0tU	Thoracic Spine, Lumbar Spine	MOBILITY
c32e06b2-b2f4-48c9-9a9f-9d6dc4753c5e	d37ddc0e-46a5-4509-b9c2-dd4b4aab76b3	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
1a7cc6f5-3d76-4dbd-935c-aa9a689f680d	d37ddc0e-46a5-4509-b9c2-dd4b4aab76b3	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
8fe20d4c-5d15-498b-9fd5-5c4752069e76	d37ddc0e-46a5-4509-b9c2-dd4b4aab76b3	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Delt	SHOULDER
5ac92335-0536-4ce8-bdb2-8c5ecf159df5	d37ddc0e-46a5-4509-b9c2-dd4b4aab76b3	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Tricpes(Long Head - Shortened)	TRICEPS
73d67a60-5387-40cc-a021-e2eee7a6805d	d37ddc0e-46a5-4509-b9c2-dd4b4aab76b3	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U	Triceps(Long head - Lengthened)	TRICEPS
75d233b4-e032-4342-a530-91a480cdfa20	d37ddc0e-46a5-4509-b9c2-dd4b4aab76b3	Reverse Pec Deck	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delt	SHOULDER
cc0a7bf1-6163-422d-9a9a-fd2b5c072e19	a6eb2754-41d7-4dc3-a334-a72d4e3ec158	Wall Sits	\N	https://www.youtube.com/watch?v=c38NDc644rs	Quads ΓÇô Isometric (Mid)\nGlutes ΓÇô Isometric (Mid)\nErector Spinae	LEGS
cd3bbd0d-e423-4391-9988-001d9d5fceea	a6eb2754-41d7-4dc3-a334-a72d4e3ec158	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
e3a11030-82e5-4da1-83bc-49e2676f61ce	a6eb2754-41d7-4dc3-a334-a72d4e3ec158	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
e7aa95a4-e928-4403-b0a1-7e96fc4d52b6	a6eb2754-41d7-4dc3-a334-a72d4e3ec158	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
28512ef6-4959-42e6-a049-a475e18a23da	a6eb2754-41d7-4dc3-a334-a72d4e3ec158	Planks	\N	https://www.youtube.com/watch?v=Qv00BKMQf6M	Rectus Abdominis, \nTransverse Abdominis	ABS
77aba4a7-f561-4a5f-8d9a-e52203e3b2ae	a6eb2754-41d7-4dc3-a334-a72d4e3ec158	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
4b3e94f2-3650-454a-ab69-c5a9b43a59c2	c12b3c68-0d9e-415e-8b51-3cb137872a9a	Machine Lat Pull Down	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical), Teres Major, Rear Delt, Lower Traps	BACK
0feb6748-31d5-4d5c-a08b-a16ad29aa742	c12b3c68-0d9e-415e-8b51-3cb137872a9a	Single Arm Dumbbell Row	\N	https://www.youtube.com/shorts/rO4Q7nW0ygo	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
0668a04c-f746-4bdc-a5de-54242c727d13	c12b3c68-0d9e-415e-8b51-3cb137872a9a	Dumbbell Pullover	\N	https://www.youtube.com/shorts/pRLIZFFoQ-M	Lats (lower) ΓÇô Lengthened\nChest (pectoralis major)\nTriceps (long head)\nSerratus Anterior	BACK
57b9711f-9bf8-44f0-8d37-949e52c42c48	c12b3c68-0d9e-415e-8b51-3cb137872a9a	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
70e841cb-77b3-4972-910b-ffaeed1a2ecc	c12b3c68-0d9e-415e-8b51-3cb137872a9a	Seated Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
fef41fc0-593c-442a-a586-1718d67a65f8	0aed1ac5-1e17-4bd8-a6f1-fbe0fae81959	Planks	\N	https://www.youtube.com/watch?v=Qv00BKMQf6M	Rectus Abdominis, \nTransverse Abdominis	ABS
550b1cf9-9412-430a-a44c-ad97b8dccb0a	7c58dd02-4964-4c70-9b5d-d9175a56ed02	Flat Bench Barbell Press	\N		Pecs(middle, lower - lengthened), Anterior Delts	CHEST
856dd56d-5189-42b4-a27f-ed0963f5d5d0	7c58dd02-4964-4c70-9b5d-d9175a56ed02	Incline Machine Chest Press	\N	https://www.youtube.com/watch?v=xH2z4eyy3gA	Upper Pecs	CHEST
b4c557d6-4428-456c-88ba-37b7fa70065e	7c58dd02-4964-4c70-9b5d-d9175a56ed02	Cable Lateral Raises	\N	https://www.youtube.com/watch?v=JFzKbUggz7E	Lateral Delt	SHOULDER
96d31acc-4d73-4016-9671-6fae209ac965	7c58dd02-4964-4c70-9b5d-d9175a56ed02	Single Arm Cable Pushdown	\N	https://www.youtube.com/shorts/w5a5sErWIEw	Triceps	TRICEPS
878aac12-1b57-40dc-839e-be65544551ef	7c58dd02-4964-4c70-9b5d-d9175a56ed02	Dumbbell Overhead Tricep Extensions	\N	https://www.youtube.com/shorts/ekEo-BSg0_U	Triceps	TRICEPS
477cadf5-eb55-4d40-b6c5-6f5155fdaee9	7c58dd02-4964-4c70-9b5d-d9175a56ed02	Pec Deck Fly	\N	https://www.youtube.com/watch?v=Qplb3CTTawM	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts	CHEST
dbaf2ee3-c8fb-45d3-a9e6-583c64d6f88d	04f08640-fdd4-4e64-9e91-bfcd7abe2323	Single Arm Lat Pulldown	\N	https://www.youtube.com/watch?v=Q9Ng4nxUbmY		BACK
14f3ca24-d9f8-464c-b1b0-ab30ecb2f4dd	04f08640-fdd4-4e64-9e91-bfcd7abe2323	Machine Abducted Arm Row	\N	https://www.youtube.com/watch?v=_e-uUKF6wOs		BACK
234808d5-5b79-4677-8e19-d1248676998f	04f08640-fdd4-4e64-9e91-bfcd7abe2323	Standing Cable Pullover	\N	https://www.youtube.com/shorts/1yG2jw7zO0M		BACK
ec776557-b100-4a29-9c26-0320034150af	04f08640-fdd4-4e64-9e91-bfcd7abe2323	Standing Ez Bar Biceps Curl	\N	https://www.youtube.com/shorts/pT-wvBPSMZU		BICEPS
693de2e9-4912-41e3-8eef-adaac17c2dc8	04f08640-fdd4-4e64-9e91-bfcd7abe2323	Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
5dd4bce2-2454-47fe-b705-7bb69bfe1411	04f08640-fdd4-4e64-9e91-bfcd7abe2323	Dumbbell Rear Delt Fly	\N	https://www.youtube.com/shorts/69H1bCtOzew	Rear Delts	BACK
9af31b45-45d3-49e5-94cd-7e3f9a385b7e	6a77b098-8e32-44ed-bacd-07107434edc5	45° Hip Extension	\N	https://www.youtube.com/watch?v=lUd9L5hSwaA		LEGS
3923f3fe-8673-4404-b61a-e4c99580e201	6a77b098-8e32-44ed-bacd-07107434edc5	Leg Press	\N	https://www.youtube.com/watch?v=Ac7D1W0BUF0	Glutes(Lengthened)	LEGS
9280d8b8-678c-4ee2-9531-697834e187fe	6a77b098-8e32-44ed-bacd-07107434edc5	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
edbef4b6-3089-4c64-8228-c385aaca579a	6a77b098-8e32-44ed-bacd-07107434edc5	Single Leg Extensions	\N		Quads(Shortened)	LEGS
4a986346-07a3-4d05-bd7e-70604dbe4a9b	6a77b098-8e32-44ed-bacd-07107434edc5	Dumbbell Standing Calf Raises	\N	https://www.youtube.com/watch?v=JBZ9qb_ASps	Gastroc, Soleus	LEGS
b3640c62-399f-4751-b6e2-c59cd8fea410	6a77b098-8e32-44ed-bacd-07107434edc5	Planks	\N	https://www.youtube.com/watch?v=Qv00BKMQf6M	Rectus Abdominis, \nTransverse Abdominis	ABS
f6949ddd-8a77-4e72-b2b6-cf8a1c49f647	1483daf2-8d1f-4d98-9e40-cfa2d7bc8694	Shoulder Smith Machine Press	\N	https://www.youtube.com/watch?v=yQQeaRV4gOk	Anterior Delts, Upper pecs	SHOULDER
2a548896-a49c-4d98-86f2-1bb642a269e3	1483daf2-8d1f-4d98-9e40-cfa2d7bc8694	Chest Supported Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
5c91af5d-88d9-437d-b0c7-31d37dd83d29	1483daf2-8d1f-4d98-9e40-cfa2d7bc8694	Standing Chest Cable Fly (High - Low)	\N	https://www.youtube.com/watch?v=NDCQWCiFLQ0		CHEST
674efaaf-aca9-44ff-b174-ec8b5b423fca	1483daf2-8d1f-4d98-9e40-cfa2d7bc8694	Dumbbell Rear Delt Fly	\N	https://www.youtube.com/shorts/69H1bCtOzew		BACK
ab4fa1d5-c75a-4808-872f-5bb79d45ee6d	1483daf2-8d1f-4d98-9e40-cfa2d7bc8694	Bayesian Cable Curl	\N	https://www.youtube.com/watch?v=1G4AX4JeiiA		BICEPS
0d9deb72-8d9a-414f-84f7-2fd45657a54e	1483daf2-8d1f-4d98-9e40-cfa2d7bc8694	One Arm Overhead Triceps Extension(Cable)	\N	https://www.youtube.com/watch?v=PRnt2HfL39c	Triceps(Long Head - Lengthened)	TRICEPS
7dd68ba5-7438-4a91-8469-665ef168704b	c12b3c68-0d9e-415e-8b51-3cb137872a9a	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
ee3ed048-e3ab-4879-b9e4-674ee326aacc	45401246-6d2f-476a-8c37-e9ee758bc037	Overhead Dumbbell Press	\N	https://www.youtube.com/watch?v=Qscmgbf5AUI	Anterior Delts,\nUpper Pecs	SHOULDER
6b68970f-e954-4511-89b6-1aa4ab0d0805	45401246-6d2f-476a-8c37-e9ee758bc037	Machine Lat Pull Down	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical), Teres Major, Rear Delt, Lower Traps	BACK
9feeca0d-d768-4d05-a486-dac4473a12b9	45401246-6d2f-476a-8c37-e9ee758bc037	Chest Supported Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
b8339273-2e2f-412c-b61c-af814ad81c90	45401246-6d2f-476a-8c37-e9ee758bc037	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Tricpes(Long Head - Shortened)	TRICEPS
0eabe17c-523a-4362-829e-acc553431ca8	45401246-6d2f-476a-8c37-e9ee758bc037	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
38475491-d35a-4339-8dd9-63f99df24477	45401246-6d2f-476a-8c37-e9ee758bc037	Flat Bench Dumbbell Press	\N	https://www.youtube.com/watch?v=3JEKRdfwdxg	Pecs(middle, lower - lengthened),\nAnterior Delts	CHEST
cabe16e3-1762-4b87-884c-68893cbc7c24	1879410a-d91a-437c-ac8e-f8c834536550	Wall Sits	\N	https://www.youtube.com/watch?v=c38NDc644rs	Quads ΓÇô Isometric (Mid)\nGlutes ΓÇô Isometric (Mid)\nErector Spinae	LEGS
1b191524-c56d-4c0d-822b-5ca14f05c384	1879410a-d91a-437c-ac8e-f8c834536550	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
53daf9ba-b708-4d07-b16a-450b34fb2e2a	1879410a-d91a-437c-ac8e-f8c834536550	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
5aae8d1d-ed57-4a4d-a6d2-2ffad3c89ad5	1879410a-d91a-437c-ac8e-f8c834536550	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
609f709c-fcba-452e-b64f-fb2eb7bf8bfb	1879410a-d91a-437c-ac8e-f8c834536550	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
b3b69350-b0b7-41e1-a0a2-4ff39e0bef32	1879410a-d91a-437c-ac8e-f8c834536550	Planks	\N	https://www.youtube.com/watch?v=Qv00BKMQf6M	Rectus Abdominis, \nTransverse Abdominis	ABS
8c8bd2b1-04d5-4a0a-b974-55bab59e9a71	705e785a-bea6-4464-955f-1547fdeb7df4	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
2f2afd46-e328-4eef-bc5c-73287392adf0	705e785a-bea6-4464-955f-1547fdeb7df4	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
c5fbb639-b771-4987-ab94-820decd4b5e4	705e785a-bea6-4464-955f-1547fdeb7df4	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
d3d33afd-4661-4820-8eab-ef264e6014fb	705e785a-bea6-4464-955f-1547fdeb7df4	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
cccd296f-f8e5-41fa-b0b8-34c71938d921	705e785a-bea6-4464-955f-1547fdeb7df4	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U		
4350601b-2d9b-4888-803a-2d7c5ff2f2d6	705e785a-bea6-4464-955f-1547fdeb7df4	Reverse Pec Deck	\N	https://www.youtube.com/watch?v=7dI8_AsXglI		
6f90423e-ae8c-46e6-9582-0b6e88ecc35f	18185182-78b0-4f41-8ccb-74df93375d8f	Wall Sits	\N	https://www.youtube.com/watch?v=c38NDc644rs		
b9e6347d-01cb-4f07-82ae-78bcad0440fb	18185182-78b0-4f41-8ccb-74df93375d8f	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs		
f70760b2-7ff4-49b3-aba1-e1cddd61b60c	18185182-78b0-4f41-8ccb-74df93375d8f	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
d062e162-4e98-4000-be74-2f8c78460fcd	18185182-78b0-4f41-8ccb-74df93375d8f	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk		
47531ead-9f24-4e92-8a55-684d90737943	18185182-78b0-4f41-8ccb-74df93375d8f	Planks	\N	https://www.youtube.com/watch?v=Qv00BKMQf6M	Rectus Abdominis, \nTransverse Abdominis	ABS
648edddd-74a5-416b-82c3-dfa9fd5cbdca	18185182-78b0-4f41-8ccb-74df93375d8f	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo		
1147aee6-ea82-4343-96d7-4760098694b9	bb5117ed-38cb-4a8c-a58d-73294f25e49f	Machine Lat Pull Down	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM		
573763e8-fd63-489f-be7c-aa7e510410f3	bb5117ed-38cb-4a8c-a58d-73294f25e49f	Single Arm Dumbbell Row	\N	https://www.youtube.com/shorts/rO4Q7nW0ygo		
1436cc25-98e9-4c23-a41b-80b2db184fe0	bb5117ed-38cb-4a8c-a58d-73294f25e49f	Dumbbell Pullover	\N	https://www.youtube.com/shorts/pRLIZFFoQ-M		
a3c8d1f6-0c7d-4b67-bfa6-ce706cb80f79	bb5117ed-38cb-4a8c-a58d-73294f25e49f	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
86e80e19-787b-4ac4-a893-f20dd9473911	bb5117ed-38cb-4a8c-a58d-73294f25e49f	Seated Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q		
093f66fa-9faf-4c1b-b896-602a2bcf8822	bb5117ed-38cb-4a8c-a58d-73294f25e49f	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc		
11fc98c4-8afc-4034-a153-f3671334f922	bc7bd712-9ef0-4b3f-a184-0b2ff45cf48e	Overhead Dumbbell Press	\N	https://www.youtube.com/watch?v=Qscmgbf5AUI	Anterior Delts,\nUpper Pecs	SHOULDER
089264b5-a6e3-4797-bca0-7dda4c6d4d66	bc7bd712-9ef0-4b3f-a184-0b2ff45cf48e	Machine Lat Pull Down	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM		
b05aad90-fb05-46d2-9a72-6ce54fb844bc	bc7bd712-9ef0-4b3f-a184-0b2ff45cf48e	Chest Supported Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
d34763a5-d9ff-49e2-8b2c-cc309eedcdc7	bc7bd712-9ef0-4b3f-a184-0b2ff45cf48e	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
65eee79b-77fd-4df2-94d3-eb5a84198971	bc7bd712-9ef0-4b3f-a184-0b2ff45cf48e	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
1e3bf5bd-d379-4ac4-a267-ccde9cccd43d	bc7bd712-9ef0-4b3f-a184-0b2ff45cf48e	Flat Bench Dumbbell Press	\N	https://www.youtube.com/watch?v=3JEKRdfwdxg	Pecs(middle, lower - lengthened),\nAnterior Delts	CHEST
f453c872-e287-4923-8bfb-b0fa3dc81f50	89973e1a-3564-4eb4-bb93-a4659fba7fd7	Wall Sits	\N	https://www.youtube.com/watch?v=c38NDc644rs		
7e97acc1-917e-446f-8fa0-8b1483b4da0b	89973e1a-3564-4eb4-bb93-a4659fba7fd7	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs		
e3eac23c-dc48-454b-8b29-4332b96b20ed	89973e1a-3564-4eb4-bb93-a4659fba7fd7	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
65c7dbff-180d-437d-832b-7aefcdd31e1f	89973e1a-3564-4eb4-bb93-a4659fba7fd7	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo		
590cbfb8-cae9-4f0e-8180-a24e5bdf06f0	89973e1a-3564-4eb4-bb93-a4659fba7fd7	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk		
b899f855-0c7d-41ce-971c-d6ff1e7c75f3	89973e1a-3564-4eb4-bb93-a4659fba7fd7	Planks	\N	https://www.youtube.com/watch?v=Qv00BKMQf6M	Rectus Abdominis, \nTransverse Abdominis	ABS
865bfa72-fc5d-4b18-b59a-08d2af89e852	08a6f4fc-0ef1-4a7f-b98c-f5da5e9e0fbe	Incline Smith Machine Chest Press	\N	https://www.youtube.com/watch?v=xH2z4eyy3gA	Pecs (upper) ΓÇô Mid, Anterior Delts, Triceps	CHEST
e6663882-581b-4a96-a1fb-0d56725efa62	08a6f4fc-0ef1-4a7f-b98c-f5da5e9e0fbe	High to Low Cable Chest Press	\N	https://www.youtube.com/watch?v=64vMQ-bgMWI	Pecs (middle, lower) ΓÇô Shortened + Mid, Anterior Delts	CHEST
0a2aaf77-572b-48b3-97ae-dbc9cc475b3b	08a6f4fc-0ef1-4a7f-b98c-f5da5e9e0fbe	Cable Lateral Raises	\N	https://www.youtube.com/watch?v=JFzKbUggz7E	Lateral Delt	SHOULDER
ad90ef3c-7f71-40bb-8443-01bb702e6c85	08a6f4fc-0ef1-4a7f-b98c-f5da5e9e0fbe	Single Arm Overhead Triceps Extension (Cable)	\N	https://www.youtube.com/watch?v=PRnt2HfL39c	Triceps (Long Head) ΓÇô Lengthened	TRICEPS
e89d940f-ca93-4b98-a022-e8098b092197	08a6f4fc-0ef1-4a7f-b98c-f5da5e9e0fbe	Machine Triceps Extension	\N	https://www.youtube.com/watch?v=MFRVOkyJyDk	Triceps (Lateral, Medial) ΓÇô Mid + Lengthened	TRICEPS
815c76a1-61ff-41ce-96fa-b64be03131e2	08a6f4fc-0ef1-4a7f-b98c-f5da5e9e0fbe	Machine Crunches	\N		Abs ΓÇô Shortened	ABS
716eed91-5ec6-427a-a3e3-ea3f81ed8320	aa3208cc-68a3-4c1a-84f8-96ea156963f5	Neutral Grip Seated Cable Row	\N	https://www.youtube.com/watch?v=mnUUQWcqHPQ	Lats (lower, middle) ΓÇô Shortened, Teres Major, Biceps	BACK
ba194888-8c1d-4070-a82d-6d5588510c83	64ffc5a4-c33e-4247-b2e7-f029bc02459d	Cable Lateral Raises	\N	https://www.youtube.com/watch?v=JFzKbUggz7E	Lateral Delt	SHOULDER
eb3104f6-2861-43d4-982f-2b449bc1a2f5	aa3208cc-68a3-4c1a-84f8-96ea156963f5	Cable Machine Neutral Grip Lat Pull Down	\N	https://www.youtube.com/watch?v=xEDDlzTKpG4	Lats (vertical fibres) ΓÇô Mid + Shortened, Teres Major, Biceps	BACK
5e85c7fc-00ab-4aad-adff-fb68faebf254	aa3208cc-68a3-4c1a-84f8-96ea156963f5	Rear Delt Cable Pull	\N	https://www.youtube.com/watch?v=JUKuGImz51U	Rear Delts ΓÇô Shortened, External Rotators, Mid/Lower Traps	SHOULDER
dc809fcd-2b8a-4d1e-9b53-1a5c0a10e75c	aa3208cc-68a3-4c1a-84f8-96ea156963f5	Preacher Curl Machine	\N	https://www.youtube.com/watch?v=e1Lh7RVV2NQ	Biceps(Shortened)	BICEPS
287a6e7b-86b6-4a6b-a6f2-71a9984e7da4	aa3208cc-68a3-4c1a-84f8-96ea156963f5	Seated Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachialis ΓÇô Mid, Biceps, Forearms	BICEPS
e2b32e40-e0ed-403a-beda-d6c84f4343bc	aa3208cc-68a3-4c1a-84f8-96ea156963f5	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM	Upper Traps	BACK
81e60497-50b0-432d-9e30-d3a884adcbea	1def5e01-6980-42fb-90d8-57170d023762	Smith Machine Squats	\N		Quads(Lengthened),\nGlutes(Lengthened),\nSpinal Erectors	LEGS
2050613d-07a7-4533-b45b-7453546902ae	1def5e01-6980-42fb-90d8-57170d023762	Hip Extension on 45 degree bench	\N	https://www.youtube.com/watch?v=lUd9L5hSwaA	Hamstrings, Glutes ΓÇô Lengthened + Mid, Spinal Erectors	LEGS
3880e992-2798-4a3a-a2ae-7e16ad3f21d0	1def5e01-6980-42fb-90d8-57170d023762	Seated Single Leg Extensions	\N		Quads(Shortened)	LEGS
93d0fe4a-12dd-4171-a9c2-a8a7f8078914	1def5e01-6980-42fb-90d8-57170d023762	Seated Single Leg Curl	\N		Hamstrings(Lengthened)	LEGS
f573dca3-9343-4a84-a762-418f10bb304e	1def5e01-6980-42fb-90d8-57170d023762	Calf Press	\N	https://www.youtube.com/shorts/-pktcXXJo7A	Gastroc, Soleus	LEGS
4806a2ac-72dd-449d-8e80-70fb18215cc2	1def5e01-6980-42fb-90d8-57170d023762	Wood Choppers	\N	https://www.youtube.com/watch?v=iWxTGXIViro	Obliques	ABS
5341b874-65f5-46cc-82ef-6abb13a5ad84	e7f662f3-ab85-48f8-b63d-d7955796ce5b	Incline Smith Machine Chest Press	\N	https://www.youtube.com/watch?v=xH2z4eyy3gA	Pecs (upper) ΓÇô Mid, Anterior Delts, Triceps	CHEST
d7fe20a3-b005-492f-a797-68a03b13897f	e7f662f3-ab85-48f8-b63d-d7955796ce5b	High to Low Cable Chest Press	\N	https://www.youtube.com/watch?v=64vMQ-bgMWI	Pecs (middle, lower) ΓÇô Shortened + Mid, Anterior Delts	CHEST
1ccd1b2d-bd24-4ba5-8205-d726e8fa765d	e7f662f3-ab85-48f8-b63d-d7955796ce5b	Cable Lateral Raises	\N	https://www.youtube.com/watch?v=JFzKbUggz7E	Lateral Delt	SHOULDER
46750af0-6068-4c88-9228-a42d7f7fb978	e7f662f3-ab85-48f8-b63d-d7955796ce5b	Single Arm Overhead Triceps Extension (Cable)	\N	https://www.youtube.com/watch?v=PRnt2HfL39c	Triceps (Long Head) ΓÇô Lengthened	TRICEPS
555d096f-1400-4ee1-a10e-59d9ac5f177d	e7f662f3-ab85-48f8-b63d-d7955796ce5b	Machine Triceps Extension	\N	https://www.youtube.com/watch?v=MFRVOkyJyDk	Triceps (Lateral, Medial) ΓÇô Mid + Lengthened	TRICEPS
b55a9f35-09c0-4ad1-a7ea-2c7185f1194b	e7f662f3-ab85-48f8-b63d-d7955796ce5b	Machine Crunches	\N		Abs ΓÇô Shortened	ABS
b8fbea02-88ff-4b2c-888b-de2d5a5f7c7b	e0f7006d-1ac4-4049-95fa-9d0dd8eb7780	Neutral Grip Seated Cable Row	\N	https://www.youtube.com/watch?v=mnUUQWcqHPQ	Lats (lower, middle) ΓÇô Shortened, Teres Major, Biceps	BACK
2dcd0206-b9cb-4a79-b71c-36c0f79747eb	e0f7006d-1ac4-4049-95fa-9d0dd8eb7780	Cable Machine Neutral Grip Lat Pull Down	\N	https://www.youtube.com/watch?v=xEDDlzTKpG4	Lats (vertical fibres) ΓÇô Mid + Shortened, Teres Major, Biceps	BACK
5dcf220e-d93e-4e06-bdd7-51cb5e4a9713	e0f7006d-1ac4-4049-95fa-9d0dd8eb7780	Rear Delt Cable Pull	\N	https://www.youtube.com/watch?v=JUKuGImz51U	Rear Delts ΓÇô Shortened, External Rotators, Mid/Lower Traps	SHOULDER
275a7815-06ab-4eda-9af4-11218c3d97a2	e0f7006d-1ac4-4049-95fa-9d0dd8eb7780	Preacher Curl Machine	\N	https://www.youtube.com/watch?v=e1Lh7RVV2NQ	Biceps(Shortened)	BICEPS
4ccd4316-3496-43de-af62-d14fbceb918a	e0f7006d-1ac4-4049-95fa-9d0dd8eb7780	Seated Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachialis ΓÇô Mid, Biceps, Forearms	BICEPS
4594a4c0-e9e1-430e-96ad-30295f6cc10f	e0f7006d-1ac4-4049-95fa-9d0dd8eb7780	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM	Upper Traps	BACK
fa42a2e3-c214-41f3-9010-bd9970d1d109	7f41fe9d-8377-4e8e-9d28-33c1632d1c76	Smith Machine Squats	\N		Quads(Lengthened),\nGlutes(Lengthened),\nSpinal Erectors	LEGS
7bcee3dc-b35e-4ca1-86f2-db7286c3de5e	7f41fe9d-8377-4e8e-9d28-33c1632d1c76	Hip Extension on 45 degree bench	\N	https://www.youtube.com/watch?v=lUd9L5hSwaA	Hamstrings, Glutes ΓÇô Lengthened + Mid, Spinal Erectors	LEGS
9ca3df87-0e63-4451-b3bb-1078cf6df4b7	7f41fe9d-8377-4e8e-9d28-33c1632d1c76	Seated Single Leg Extensions	\N		Quads(Shortened)	LEGS
339322a6-89d5-41ec-bd68-7f728e032c47	7f41fe9d-8377-4e8e-9d28-33c1632d1c76	Seated Single Leg Curl	\N		Hamstrings(Lengthened)	LEGS
2c8f047d-7ae1-4774-aeb8-8b252d48358e	7f41fe9d-8377-4e8e-9d28-33c1632d1c76	Calf Press	\N	https://www.youtube.com/shorts/-pktcXXJo7A	Gastroc, Soleus	LEGS
5932a50a-11a6-4d7c-9d6f-644b44e82c9a	7f41fe9d-8377-4e8e-9d28-33c1632d1c76	Wood Choppers	\N	https://www.youtube.com/watch?v=iWxTGXIViro	Obliques	ABS
a9e24ac2-a60e-4e58-aa9f-d9960d25fcf5	a061f6f4-61dd-4206-8a5f-03f55c5f7867	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
956ec9cf-ba02-4ada-b6b5-b8cb53502d4f	a061f6f4-61dd-4206-8a5f-03f55c5f7867	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
dba71ef6-79d8-47be-9345-299e6df5988b	a061f6f4-61dd-4206-8a5f-03f55c5f7867	Cable Lateral Raises	\N	https://www.youtube.com/watch?v=JFzKbUggz7E	Lateral Delt	SHOULDER
27388afa-e572-4fb4-80b1-5f47f5c328e3	a061f6f4-61dd-4206-8a5f-03f55c5f7867	Ez Bar Lying Triceps Extension	\N	https://www.youtube.com/watch?v=iyIe7qdGtdE	Triceps(Long head - Lengthened)	TRICEPS
30c05fe1-743f-477d-9d95-dfe41b1206c7	a061f6f4-61dd-4206-8a5f-03f55c5f7867	Single Arm Triceps Crossover	\N	https://www.youtube.com/watch?v=lC9NRhFN7X4	Triceps(Long Head - Shortened)	TRICEPS
2b18d28e-3aa6-4f9c-9ebd-c24354d71b64	a061f6f4-61dd-4206-8a5f-03f55c5f7867	Pec Deck Fly	\N	https://www.youtube.com/watch?v=Qplb3CTTawM	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts	CHEST
09b52b70-27a6-49a4-8ff0-4ab844810c9b	c257bc54-9ada-4d53-a640-37590cda5612	Cable Machine Neutral Grip Lat Pull Down	\N	https://www.youtube.com/watch?v=xEDDlzTKpG4	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
52927e49-1fc3-4f91-9ec6-5aaf1149fc08	c257bc54-9ada-4d53-a640-37590cda5612	Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
adb5ab32-a30f-4c3a-881a-f83fb27b43d6	c257bc54-9ada-4d53-a640-37590cda5612	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM&pp=0gcJCcUKAYcqIYzv	Upper Traps	BACK
d7a4b76b-d96e-4730-bfb4-7c6613cac725	c257bc54-9ada-4d53-a640-37590cda5612	Incline Dumbell Curl	\N	https://www.youtube.com/watch?v=EiPYwFGeMwc	Biceps(Lengthened)	BICEPS
0235b1fa-3375-45db-8664-d3dda0aee61c	c257bc54-9ada-4d53-a640-37590cda5612	Strict Hammer Curl	\N	https://www.youtube.com/watch?v=vgy3Ay0QUTc	Brachioradialis	BICEPS
fa275758-36af-40da-a6db-1a760a57b557	c257bc54-9ada-4d53-a640-37590cda5612	Cable Rear Delt Fly	\N	https://www.youtube.com/watch?v=me0PJqCEqDU	Teres Major,\nRear Delt, \nMiddle Traps, \nRhomboids	SHOULDER
83ae99f1-ab89-4212-8f48-53313c385220	75849670-a2e0-45dd-b611-a2f7ca95dd53	V Squat(Quad Dominant)	\N	https://www.youtube.com/shorts/_t4HyUwmAE8	Quads(Lengthened)	LEGS
8d2343e7-b0c5-4168-a489-c9e1c1c6e10b	75849670-a2e0-45dd-b611-a2f7ca95dd53	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
ff12600b-3082-4cdf-b966-94f98c5a099f	75849670-a2e0-45dd-b611-a2f7ca95dd53	Lying Leg Curl	\N		Hamstrings(Less Lengthened)	LEGS
590b2116-39d9-4275-9b0a-dfc3fba97f39	75849670-a2e0-45dd-b611-a2f7ca95dd53	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
3b43c182-05b4-4fee-a090-2abb5e88bc5a	75849670-a2e0-45dd-b611-a2f7ca95dd53	Reverse Crunches	\N	https://www.youtube.com/watch?v=U-eR6Pt1gZA	Rectus Abdominis, Transverse Abdominis	ABS
25798157-4cbb-434f-89aa-e82bacd616db	75849670-a2e0-45dd-b611-a2f7ca95dd53	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
f0f43c24-a59f-4793-a26f-ebab5ccb2dec	64ffc5a4-c33e-4247-b2e7-f029bc02459d	Flat Bench Barbell Press	\N	https://www.youtube.com/watch?v=t3JACKmMTz0	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
383a1213-67e3-4f32-b84f-bb8565e2f047	64ffc5a4-c33e-4247-b2e7-f029bc02459d	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
cf6738c8-bfba-411b-b608-49c56751eda3	64ffc5a4-c33e-4247-b2e7-f029bc02459d	Ez Bar Lying Triceps Extension	\N	https://www.youtube.com/watch?v=iyIe7qdGtdE	Triceps(Long head - Lengthened)	TRICEPS
f2d4d79b-054c-4fcd-a90e-d2be31a9c257	64ffc5a4-c33e-4247-b2e7-f029bc02459d	Single Arm Triceps Crossover	\N	https://www.youtube.com/watch?v=lC9NRhFN7X4	Triceps(Long Head - Shortened)	TRICEPS
88d6954d-2f62-45e7-baad-24d9c4354f32	64ffc5a4-c33e-4247-b2e7-f029bc02459d	Pec Deck Fly	\N	https://www.youtube.com/watch?v=Qplb3CTTawM	Pecs(Upper, middle - shortened, active throughout ROM ),\nAnterior Delts	CHEST
9ee40ead-ab07-41a3-a6c7-1f2eaa5b711d	a9585906-0ed8-4f91-88ad-f9cfd2875175	Cable Machine Neutral Grip Lat Pull Down	\N	https://www.youtube.com/watch?v=xEDDlzTKpG4	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
da0c0e4b-5138-4a47-9691-5930f9a62863	a9585906-0ed8-4f91-88ad-f9cfd2875175	Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
703dedfd-f0a6-49ae-afaf-40cda2c732c7	a9585906-0ed8-4f91-88ad-f9cfd2875175	Cable Shrugs	\N	https://www.youtube.com/watch?v=hkbJOCAJNuM&pp=0gcJCcUKAYcqIYzv	Upper Traps	BACK
0975824f-f8fd-4e22-b51d-2f8a4f963f7d	a9585906-0ed8-4f91-88ad-f9cfd2875175	Incline Dumbell Curl	\N	https://www.youtube.com/watch?v=EiPYwFGeMwc	Biceps(Lengthened)	BICEPS
5bf7727d-a81b-42e6-9a2b-2218d4461aad	a9585906-0ed8-4f91-88ad-f9cfd2875175	Strict Hammer Curl	\N	https://www.youtube.com/watch?v=vgy3Ay0QUTc	Brachioradialis	BICEPS
0cd9bca4-cd57-4aa5-93d9-d5310a08299e	a9585906-0ed8-4f91-88ad-f9cfd2875175	Cable Rear Delt Fly	\N	https://www.youtube.com/watch?v=me0PJqCEqDU	Teres Major,\nRear Delt, \nMiddle Traps, \nRhomboids	SHOULDER
98c77b35-be5f-4e6b-af41-62b30a5320fc	3551ca4e-ca79-4e23-a2bf-fa682b71bec1	V Squat(Quad Dominant)	\N	https://www.youtube.com/shorts/_t4HyUwmAE8	Quads(Lengthened)	LEGS
8c007f66-3eab-4909-8966-9af38c9f3c74	3551ca4e-ca79-4e23-a2bf-fa682b71bec1	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
b24cf96f-b3fa-47b8-9054-5c3a1e0adfe6	3551ca4e-ca79-4e23-a2bf-fa682b71bec1	Lying Leg Curl	\N		Hamstrings(Less Lengthened)	LEGS
14a3a831-3ef4-465c-a6f7-1e9494589490	3551ca4e-ca79-4e23-a2bf-fa682b71bec1	Standing Calf Raises	\N	https://www.youtube.com/watch?v=fTF-8GqOWRo	Gastroc, Soleus	LEGS
5ff1591a-d431-4855-aa49-f5e8efc43240	3551ca4e-ca79-4e23-a2bf-fa682b71bec1	Reverse Crunches	\N	https://www.youtube.com/watch?v=U-eR6Pt1gZA	Rectus Abdominis, Transverse Abdominis	ABS
18665ce1-96c0-4a15-afb6-941d4d2bdaa5	3551ca4e-ca79-4e23-a2bf-fa682b71bec1	Side Bending with Cable	\N	https://www.youtube.com/watch?v=xwjvYjlyJvk	Obliques	ABS
b306a1f9-61ec-4577-82cd-acec13d4a731	c66c082e-d347-4116-b78f-8e83d58278c8	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
1a3a3e61-0685-4222-bb40-35aae97f42e1	c66c082e-d347-4116-b78f-8e83d58278c8	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
56b11850-2d33-4a11-869f-83208379ffac	c66c082e-d347-4116-b78f-8e83d58278c8	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
5ae8a640-1e9e-452a-a260-43638dc7052f	c66c082e-d347-4116-b78f-8e83d58278c8	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
9b0d3afb-de59-4604-99f1-335e19ce9381	c66c082e-d347-4116-b78f-8e83d58278c8	Resverse Pec Deck Fly	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
e6ab2abe-ae87-47a0-82c8-8104d92ee0c2	962f95f6-0cbc-4ecb-a552-712f25b2d932	Wall Sit	\N	https://www.youtube.com/watch?v=c38NDc644rs	Quads	LEGS
b16fe888-c333-4f45-9ac6-4951a957f4a8	962f95f6-0cbc-4ecb-a552-712f25b2d932	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
e627f6d1-bc8e-4ed1-b2d7-90e7562174c9	962f95f6-0cbc-4ecb-a552-712f25b2d932	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
4670f206-34a5-46d0-9dd0-7f4ec3fff377	962f95f6-0cbc-4ecb-a552-712f25b2d932	Hip Abduction	\N	https://www.youtube.com/watch?v=H98IP8rARy4	Hip Abductors	LEGS
fa9c6268-dac6-4f46-9ee1-e8e97e737936	962f95f6-0cbc-4ecb-a552-712f25b2d932	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
6722149b-4414-4301-927e-03e63d6d0f06	962f95f6-0cbc-4ecb-a552-712f25b2d932	Dead Bugs	\N	https://www.youtube.com/watch?v=mUMVASv0x7U	Rectus Abdominis	ABS
072644fe-508c-44a6-95d3-df8224284a19	8e5ac9f9-2068-46d7-b41f-8ded4c4efbab	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
76b644c9-105a-48ab-815e-d31caeecd286	8e5ac9f9-2068-46d7-b41f-8ded4c4efbab	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
b23ae6c1-0c0f-494f-ae2b-2c71e1c00f69	8e5ac9f9-2068-46d7-b41f-8ded4c4efbab	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
8adca385-d111-4133-800b-adb1163d912f	8e5ac9f9-2068-46d7-b41f-8ded4c4efbab	Bench Supported Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
02ae6935-2da7-4eab-851f-f67e3b92f9e4	8e5ac9f9-2068-46d7-b41f-8ded4c4efbab	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
94283970-5f78-43b6-9f6b-e9a34e619d22	d0a91048-8306-4490-8761-533de11b4724	30 Degree Incline Dumbbell Press	\N	https://www.youtube.com/watch?v=mR6_jMWNlQI	Pecs(upper, middle) - Lengthened, Anterior Delts	CHEST
f5890f5c-6969-456c-9b4c-263f2c4faa9a	d0a91048-8306-4490-8761-533de11b4724	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower) ΓÇô Shortened + Mid\nAnterior Delts\nTriceps	CHEST
6a67f5ba-c1fe-4615-bfc7-e8b99b613b53	d0a91048-8306-4490-8761-533de11b4724	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
b22acc73-459b-4acf-b40c-e2a3050c63f5	d0a91048-8306-4490-8761-533de11b4724	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
57ddb9db-2fc7-4a62-abc3-53b10dce60ef	d0a91048-8306-4490-8761-533de11b4724	Resverse Pec Deck Fly	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
03a7c9fc-9274-4b8e-b018-0b412db068c5	75dc67f5-cd58-449b-91d8-74af6f4e13f1	Wall Sit	\N	https://www.youtube.com/watch?v=c38NDc644rs	Quads	LEGS
3abd3f92-8134-4c83-baa0-3e99340ad63f	75dc67f5-cd58-449b-91d8-74af6f4e13f1	Romanian Dumbbell Deadlift	\N	https://www.youtube.com/watch?v=1bBe2ADxqKo	Glutes(Lengthened)	LEGS
5a0fd021-1510-4582-b73f-ff23ea4bbb18	75dc67f5-cd58-449b-91d8-74af6f4e13f1	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
ca189235-1f1a-4c3c-96fb-669d63369898	75dc67f5-cd58-449b-91d8-74af6f4e13f1	Hip Abduction	\N	https://www.youtube.com/watch?v=H98IP8rARy4	Hip Abductors	LEGS
25569974-2290-4614-b4f4-e7a333dee615	75dc67f5-cd58-449b-91d8-74af6f4e13f1	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=D0Ky2IxISHc	Gastroc, Soleus	LEGS
c205f57a-2f22-4bc2-bbba-e13da23e28a1	75dc67f5-cd58-449b-91d8-74af6f4e13f1	Dead Bugs	\N	https://www.youtube.com/watch?v=mUMVASv0x7U	Rectus Abdominis	ABS
64686742-a0b6-411f-a811-99730ae8de3e	ec5bc8eb-07f6-4e35-8bf2-66d1e9bf7379	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
1517d501-3f87-4450-8386-3301ffd9ab2b	ec5bc8eb-07f6-4e35-8bf2-66d1e9bf7379	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
105713dc-dc45-4646-b588-291f31a695aa	ec5bc8eb-07f6-4e35-8bf2-66d1e9bf7379	Bench Supported Dumbbell Curl	\N	https://www.youtube.com/watch?v=jGB98671sHg	Biceps	BICEPS
8e2a8d2d-2b05-45a7-a9b1-fd449de1d48f	ec5bc8eb-07f6-4e35-8bf2-66d1e9bf7379	Bench Supported Hammer Curl	\N	https://www.youtube.com/watch?v=ddq-QLxiN4Q	Brachioradialis	BICEPS
6140ac76-d28b-4841-b0ee-a8f4501aeb28	ec5bc8eb-07f6-4e35-8bf2-66d1e9bf7379	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
ca23ea3a-55a8-4f14-b47d-765eecb3aa29	86652d93-6784-49c6-bba6-8772eeef8128	Smith Machine Flat Chest Press	\N	https://www.youtube.com/watch?v=8MULputkx4Q	Pecs(middle, lower - lengthened), Anterior Delts	CHEST
74250cd9-c66b-4d30-8ed6-c3e2b41bf1d3	86652d93-6784-49c6-bba6-8772eeef8128	Machine Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
9d18e683-8b9b-4978-bc93-83518755a9c8	86652d93-6784-49c6-bba6-8772eeef8128	Leg Press	\N	https://www.youtube.com/watch?v=Ac7D1W0BUF0	Glutes(Lengthened)\nQuads(Mid + Lengthened)	LEGS
4a9497e0-0e0c-442b-bf8a-7284cee0e495	86652d93-6784-49c6-bba6-8772eeef8128	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Lengthened)	LEGS
c963a1e4-19da-4c92-89d1-46125cd78d19	86652d93-6784-49c6-bba6-8772eeef8128	Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=UDPaZ2CEYh0	Lateral Deltoid ΓÇô Mid + Shortened	SHOULDER
5590f525-bba9-4699-a92a-a8facf69b9c8	86652d93-6784-49c6-bba6-8772eeef8128	Triceps Pulley Pushdown	\N	https://www.youtube.com/watch?v=CHz2KNxqGqY	Triceps (Shortened + Mid)	TRICEPS
52aa1953-6319-438c-a310-a9b1a8487c80	6748c195-2b16-4848-81bc-e73c2e1ba995	Chest Supported Seated Machine Row	\N	https://www.youtube.com/watch?v=HPJBURAxCzg	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
be4acc51-978b-4e93-85c5-4f2f20c2f817	6748c195-2b16-4848-81bc-e73c2e1ba995	Smith Machine Incline Chest Press	\N	https://www.youtube.com/watch?v=xH2z4eyy3gA	Pecs(Upper, Middle - Lengthened),\nAnterior Delt	CHEST
38056b52-9d7f-4af2-ace6-f311355ffcd3	6748c195-2b16-4848-81bc-e73c2e1ba995	Goblet Squat to Box	\N	https://www.youtube.com/watch?v=4pbWohi6z_U	Quads(Mid, Lengthened)	LEGS
6ca8359d-d4ff-4e7e-bca0-07e3855883d8	6748c195-2b16-4848-81bc-e73c2e1ba995	Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
d78975d6-3a2d-4621-bd4d-3e2f9d845bb6	6748c195-2b16-4848-81bc-e73c2e1ba995	Bench Supported Dumbbell Curl	\N		Biceps	BICEPS
118ffe24-ce22-4546-baa9-d6503357c37b	6748c195-2b16-4848-81bc-e73c2e1ba995	Standing Calf Raises(Smith Machine)	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Gastroc, Soleus	LEGS
5f7a9f28-3c3a-4f18-b854-3a819ebbcef5	09e257c2-87c2-4cd3-9bc0-32b72754dc4f	Flat Machine Chest Press	\N	https://www.youtube.com/watch?v=_69Kbze7idE	Pecs (middle, lower)\nShortened + Mid\nAnterior Delts\nTriceps	CHEST
cd65e5a8-1e7c-4f90-9022-3c313ffb531c	09e257c2-87c2-4cd3-9bc0-32b72754dc4f	Lat Pulldown	\N	https://www.youtube.com/watch?v=C1ZjTbCEMOM	Lats(vertical),\nTeres Major,\nRear Delt,\nLower Traps	BACK
5963ce48-7b9e-4d2c-aab4-dbe83a289c03	09e257c2-87c2-4cd3-9bc0-32b72754dc4f	Leg Press	\N	https://www.youtube.com/watch?v=Ac7D1W0BUF0	Glutes(Lengthened)	LEGS
bd2c4abe-10ec-4efb-a086-0a24d687a905	09e257c2-87c2-4cd3-9bc0-32b72754dc4f	Glute Bridge	\N	https://www.youtube.com/watch?v=XLXGydU5DdU	Glutes(Shortened)	LEGS
9817571c-2787-4d1a-aed8-49e28314aa44	09e257c2-87c2-4cd3-9bc0-32b72754dc4f	Overhead Dumbbell Press	\N	https://www.youtube.com/watch?v=Qscmgbf5AUI	Anterior Delts,\nUpper Pecs	SHOULDER
294add7f-f90a-4eac-b4a8-cf268a40c348	09e257c2-87c2-4cd3-9bc0-32b72754dc4f	Abdominal Crunch	\N	https://www.youtube.com/watch?v=ZPdx67dVJHg	Rectus Abdominis,\nTransverse Abdominis	ABS
afcc6fb3-2b05-4a11-84aa-50d20f63d4ae	58e4c9d6-f4b7-44ef-a6dd-1c57fafd97e4	Flat Bench Dumbbell Press	\N	https://www.youtube.com/watch?v=3JEKRdfwdxg	Pecs(middle, lower - lengthened),\nAnterior Delts	CHEST
ac1ef127-69ac-4e9b-8853-f128c2dc64d8	58e4c9d6-f4b7-44ef-a6dd-1c57fafd97e4	Incline Dumbell Chest Fly	\N	https://www.youtube.com/watch?v=JSDpq14vCZ8	Pecs (upper) ΓÇô Lengthened\nAnterior Delts\nBiceps (long head)\nSerratus Anterior	CHEST
a8cdd1c7-8858-423b-be77-617a0379b634	58e4c9d6-f4b7-44ef-a6dd-1c57fafd97e4	Chest Supported Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=pDzjKXU3Lto	Side Delts	SHOULDER
8f511a7d-dfb9-4987-bf6f-81c81b12d032	58e4c9d6-f4b7-44ef-a6dd-1c57fafd97e4	Dumbbell Lying Triceps Extension	\N	https://www.youtube.com/watch?v=WDsI67J463U	Triceps(Long Head - Lengthened)	TRICEPS
74585b23-4a21-4dcd-a153-e5baa73168db	58e4c9d6-f4b7-44ef-a6dd-1c57fafd97e4	Smith Machine Triceps Press/Incline Close Grip Barbell Bench Press	\N	https://www.youtube.com/watch?v=K1xbj4SRhGg	Triceps(Long Head - Shortened/Normal)	TRICEPS
91cefccb-6b96-4125-b49a-a461c8ecbb12	58e4c9d6-f4b7-44ef-a6dd-1c57fafd97e4	Reverse Pec Deck	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
8fab9ccc-77a6-40b5-9c57-a8e0fd0d0eb3	04e0b6cf-575e-4ba2-8640-ad1136e5cf11	Neutral Grip Lat Pull Down	\N	https://www.youtube.com/watch?v=xEDDlzTKpG4	Lats (upper, lower) ΓÇô Lengthened\nBiceps\nTeres Major\nRear Delts\nRhomboids\nMiddle Traps	BACK
9ffbe234-f7f6-40bf-8faf-48f3c0b900dc	04e0b6cf-575e-4ba2-8640-ad1136e5cf11	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
c00a9db4-1b90-4656-8595-8ba79606431d	04e0b6cf-575e-4ba2-8640-ad1136e5cf11	Dumbbell Pullover	\N	https://www.youtube.com/shorts/k_cFbm-KXtI	Lats (lower) ΓÇô Lengthened\nChest\nTriceps (long head)	BACK
8281a856-35cc-47c6-9705-c221114ea0ca	04e0b6cf-575e-4ba2-8640-ad1136e5cf11	Incline Dumbell Curl	\N	https://www.youtube.com/watch?v=EiPYwFGeMwc	Biceps(Lengthened)	BICEPS
73e4af2d-b537-4080-a7bb-10a2afe1ab25	04e0b6cf-575e-4ba2-8640-ad1136e5cf11	Preacher Dumbbell curl on 45 degrees incline bench	\N	https://www.youtube.com/watch?v=i6o-m0BxV8c	Biceps(Shortened)	BICEPS
a008f185-233f-471d-a9af-8b6dac08bf72	04e0b6cf-575e-4ba2-8640-ad1136e5cf11	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
b5fb2b26-71ff-4030-9815-21f4bf10a90b	4001c526-4c4e-4527-bf3c-3dced667f757	Dumbbell Lunges	\N	https://www.youtube.com/watch?v=lotPMgYPbyQ	Quads ΓÇô Lengthened\nGlutes\nHamstrings\nAdductors\nCalves	LEGS
7c3e18f8-a4e1-40e6-8f4a-2eda284d0846	4001c526-4c4e-4527-bf3c-3dced667f757	Stiff Leg Deadlift(Dumbbell)	\N	https://www.youtube.com/watch?v=5ExizhPmqbo	Hamstrings(Lengthened),\nGlutes(Lengthened)	LEGS
faf0f4a0-05c4-40c9-a09b-b555c97fa283	4001c526-4c4e-4527-bf3c-3dced667f757	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
b0f001f1-bc00-475a-b090-999e78ca573f	4001c526-4c4e-4527-bf3c-3dced667f757	Seated Leg Curl	\N	https://www.youtube.com/watch?v=K11URVdYCIQ	Hamstrings(Shortened)	LEGS
57f34b31-d015-4139-9d85-fab29656c45d	4001c526-4c4e-4527-bf3c-3dced667f757	Calf Press	\N	https://www.youtube.com/shorts/-pktcXXJo7A	Gastroc, Soleus	LEGS
8805071f-818f-4342-9172-74089d0481de	4001c526-4c4e-4527-bf3c-3dced667f757	Crunches	\N	https://www.youtube.com/watch?v=ZPdx67dVJHg	ABS	ABS
f36bd16d-70f6-4c44-aff1-8075ca7f242c	4a6b4c75-d8cb-40f5-bba2-ad38341960ea	Seated Dumbbell Shoulder Press	\N	https://www.youtube.com/watch?v=Qscmgbf5AUI	Anterior Delts,\nUpper Pecs	SHOULDER
2268c6e0-8286-47ae-b54d-7de405c2d84a	4a6b4c75-d8cb-40f5-bba2-ad38341960ea	Dumbbell Chest Supported Row	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Lats(Horizontal), Teres Major, Rear Delt, Middle Traps, Rhomboids	BACK
836e02e6-d235-452a-a994-e93c129d0e67	4a6b4c75-d8cb-40f5-bba2-ad38341960ea	Chest Supported Dumbbell Lateral Raises	\N	https://www.youtube.com/watch?v=BTczx2h-HQk	Side Delts	SHOULDER
8497e72a-819a-42af-bf07-e0bfa67e0fc1	4a6b4c75-d8cb-40f5-bba2-ad38341960ea	Dumbbell Pullover	\N	https://www.youtube.com/shorts/k_cFbm-KXtI	Lats (lower) ΓÇô Lengthened\nChest\nTriceps (long head)	BACK
8bbbc881-99ec-4ec4-aca3-087cc7ac9949	4a6b4c75-d8cb-40f5-bba2-ad38341960ea	Reverse Pec Deck	\N	https://www.youtube.com/watch?v=7dI8_AsXglI	Rear Delts	SHOULDER
3f3a5d1f-eece-4a53-a201-b9e0817baed0	4a6b4c75-d8cb-40f5-bba2-ad38341960ea	Smith Machine Shrugs	\N	https://www.youtube.com/watch?v=KGXy1vA8VFc	Upper Traps	BACK
6f085679-d0df-478b-a63e-6876b4a07bb7	1b4d8484-8c7b-43c5-855a-5e1e80fa8334	Pendulum Squat	\N	https://www.youtube.com/shorts/RsSGq7aN_ww	Quads(Lengthened)	LEGS
4885f435-dec3-4965-a241-ee97700e4632	1b4d8484-8c7b-43c5-855a-5e1e80fa8334	Reverse V Squat	\N	https://www.youtube.com/shorts/3p9vc0nL5eE	Hamstrings(Lengthened),\nGlutes(Lengthened)	LEGS
9790ff1a-8171-4d15-a6d6-cda04f19428e	1b4d8484-8c7b-43c5-855a-5e1e80fa8334	Seated Leg Extensions	\N	https://www.youtube.com/watch?v=_8LrQw_LYrs	Quads(Shortened)	LEGS
614c9971-19da-455b-8e96-16e6583a0fb6	1b4d8484-8c7b-43c5-855a-5e1e80fa8334	Hip Abduction	\N	https://www.youtube.com/watch?v=G_8LItOiZ0Q	Hip Abductors	LEGS
2c0486da-6159-4e06-a1bd-1a77d7754774	1b4d8484-8c7b-43c5-855a-5e1e80fa8334	Calf Press	\N	https://www.youtube.com/shorts/-pktcXXJo7A	Gastroc, Soleus	LEGS
c2c6a7aa-71c3-475d-8631-08f4fb8e7836	1b4d8484-8c7b-43c5-855a-5e1e80fa8334	Russian Twists	\N	https://www.youtube.com/shorts/rTTBzWIsUIM	Obliques	ABS
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
9	9	add target steps count to workout plans	SQL	V9__add_target_steps_count_to_workout_plans.sql	1289976639	postgres	2026-06-11 08:20:53.355091	56	t
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
8a7c3f0f-9331-4640-9d00-18a486708904	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	t	2026-03-27 04:16:38.02247
a75726dc-b020-4f2a-9162-c21677a9094b	c5def8cb-87f5-4deb-866e-17b0c1e76d15	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	t	2026-05-08 03:15:23.938523
b57f6569-e004-4398-b0f6-e2bf7f94478c	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	t	2026-05-12 13:52:16.08647
722889a7-ab2e-48c3-8eb4-e5ad1cd2c9b4	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	f	2026-04-06 03:20:21.604886
1e8600e6-1439-49fb-b7fa-d3655f80d55d	dbca39d7-faa6-4cf6-929a-1436658823a3	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	t	2026-05-17 16:41:18.009327
ae8919f6-3874-4c1f-a6b6-3df7ec884c60	3c55f055-32e9-4fa6-bcfc-a2a7834c0b1c	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	t	2026-05-20 12:10:46.134966
dbe8ce7f-cb79-4ce4-9647-d58c1d3858f8	5683db29-d4cd-4a5b-ab89-67af581ef4df	57ee19de-9c3f-49bf-83d2-20a56100a64e	varun.deoghare@gmail.com	t	2026-05-24 07:55:17.361752
cc621c36-f06c-4b34-9674-e33cf2ee43f8	405418ef-045c-4c31-96f9-85346230c5ac	6ae0f3fa-0233-4160-ba88-11f4b8ae7e38	varun.deoghare@gmail.com	t	2026-05-24 13:20:15.445
adf027af-16dc-47e3-a957-b2091c0ab3a9	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	f	2026-03-19 13:36:30.077944
8594d556-e1e4-4e39-a345-6f593470c462	fae2f698-9831-47ae-be34-4495126c79fc	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	t	2026-05-27 04:13:34.786302
9b30f17b-5ef3-457b-a5eb-e72c1a02e97a	d92d5aad-8968-4c1c-afb7-2a12932e73c4	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	t	2026-05-29 03:28:46.627242
4b8b37e3-ecb7-4e54-9740-432bde4b902c	df876ef1-988a-4ea0-9302-cbc50911087e	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	t	2026-06-11 13:49:23.336176
ca66c2ac-ef58-4090-a912-450ae6dde013	cc478162-1601-4847-893d-e5ff6274fc0c	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	t	2026-06-11 13:58:44.386579
f67d0b61-f9c9-4897-9ea7-2ed6358fe41d	906bdcbe-2b1e-47d8-ae41-79248292b190	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	t	2026-07-05 14:01:32.363838
d7d8278f-00ba-405b-93e5-6d9bc8a1f1c1	ad779c07-b498-48ca-b539-ac53435e4d44	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	t	2026-07-07 03:38:42.301529
0edded78-9619-4dde-ac8c-2658efa1bcaa	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	f	2026-03-28 14:03:43.674218
91fda3ef-0e7a-450b-9b0a-923c16ffa57b	026016d0-3b10-4ce6-afb9-2a521a9a2979	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	t	2026-07-13 14:57:53.792105
\.


--
-- Data for Name: workout_days; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workout_days (id, plan_id, day_name) FROM stdin;
964e8bea-9d6e-46b6-8386-1ca84badfbe8	d92d5aad-8968-4c1c-afb7-2a12932e73c4	Day 1
f8d02043-8b30-4318-972a-a971f641083b	d92d5aad-8968-4c1c-afb7-2a12932e73c4	Day 2
3a4e23f3-04b4-4fb0-adaf-5c7079ac2efd	d92d5aad-8968-4c1c-afb7-2a12932e73c4	Day 3
9bce27c3-63f4-449d-8bc5-0686814c3e1a	d92d5aad-8968-4c1c-afb7-2a12932e73c4	Day 4
134ac9a8-d242-4c34-9fad-70631386f8d8	d92d5aad-8968-4c1c-afb7-2a12932e73c4	Day 5
08bd2bf4-1340-4666-8518-405f5cb5b11d	ca59d371-e6cc-440c-941c-94271aa61761	Day 1
d0d37bf5-dc62-4565-99b8-ddb444cb5709	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 1
ef6faf74-7441-464f-b499-5f04f9bbeefc	ca59d371-e6cc-440c-941c-94271aa61761	Day 2
7372cb03-eccb-4936-a81d-c7ffb3a2370a	ca59d371-e6cc-440c-941c-94271aa61761	Day 3
2f65579e-9f11-430c-a26c-1774109b79db	ca59d371-e6cc-440c-941c-94271aa61761	Day 4
a312e638-eb49-4743-a146-09eaa154c30e	ca59d371-e6cc-440c-941c-94271aa61761	Day 5
32a8e514-590f-45ca-bede-2c6d98c3006d	ca59d371-e6cc-440c-941c-94271aa61761	Day 6
7153214c-b458-4994-965c-4ec106fc2e89	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 2
d1295d2c-403d-4f17-aae7-c7e29425922d	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 3
f80a503e-dc08-4f1c-8ac2-ab9c7d5677df	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 4
f0bd8432-ca33-4b42-844f-96aab00096c3	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 5
5b3e4b93-8826-4602-ad3a-534fb2c6ee75	d9ee8604-ec0a-4beb-9df7-68eb619d17d2	Day 6
618c40a6-be57-4d79-a7da-73a09588d6db	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 1
873c3aa5-87c7-41be-bd3b-80a771762af2	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 2
3e84e704-fd23-4895-b171-b75c8665b377	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 3
e7a690f4-892e-4f2d-85fb-b0425fb07084	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 4
e6616aca-8b74-4f41-91d7-d5c08593578e	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 5
99744c9a-0ede-4480-ba98-fa22cb1f47eb	9fd58431-91f6-4e1e-9f58-f6e7f6128d06	Day 6
879f1dc5-1e02-459d-9339-5ccd6918468c	906bdcbe-2b1e-47d8-ae41-79248292b190	Day 1
58195833-191d-4414-af0e-b85b7ff76470	906bdcbe-2b1e-47d8-ae41-79248292b190	Day 2
1a814d00-224e-44e5-9ac7-39f3ac0a49ed	906bdcbe-2b1e-47d8-ae41-79248292b190	Day 3
853797e0-30e9-4374-8077-fdcc99a84c12	906bdcbe-2b1e-47d8-ae41-79248292b190	Day 4
0809c388-02d6-4f14-87ee-5c67b41605fe	906bdcbe-2b1e-47d8-ae41-79248292b190	Day 5
cc518a9b-28b3-4672-959b-cff09d0bfb67	906bdcbe-2b1e-47d8-ae41-79248292b190	Day 6
d37ddc0e-46a5-4509-b9c2-dd4b4aab76b3	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	Day 1
a6eb2754-41d7-4dc3-a334-a72d4e3ec158	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	Day 2
c12b3c68-0d9e-415e-8b51-3cb137872a9a	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	Day 3
45401246-6d2f-476a-8c37-e9ee758bc037	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	Day 4
1879410a-d91a-437c-ac8e-f8c834536550	f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	Day 5
04792deb-f2d8-464d-91ae-de1195f84084	026016d0-3b10-4ce6-afb9-2a521a9a2979	Warmup
0aed1ac5-1e17-4bd8-a6f1-fbe0fae81959	026016d0-3b10-4ce6-afb9-2a521a9a2979	Day 1
7c58dd02-4964-4c70-9b5d-d9175a56ed02	026016d0-3b10-4ce6-afb9-2a521a9a2979	Day 2
04f08640-fdd4-4e64-9e91-bfcd7abe2323	026016d0-3b10-4ce6-afb9-2a521a9a2979	Day 3
705e785a-bea6-4464-955f-1547fdeb7df4	df876ef1-988a-4ea0-9302-cbc50911087e	Day 1
18185182-78b0-4f41-8ccb-74df93375d8f	df876ef1-988a-4ea0-9302-cbc50911087e	Day 2
bb5117ed-38cb-4a8c-a58d-73294f25e49f	df876ef1-988a-4ea0-9302-cbc50911087e	Day 3
bc7bd712-9ef0-4b3f-a184-0b2ff45cf48e	df876ef1-988a-4ea0-9302-cbc50911087e	Day 4
89973e1a-3564-4eb4-bb93-a4659fba7fd7	df876ef1-988a-4ea0-9302-cbc50911087e	Day 5
08a6f4fc-0ef1-4a7f-b98c-f5da5e9e0fbe	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 1
aa3208cc-68a3-4c1a-84f8-96ea156963f5	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 2
1def5e01-6980-42fb-90d8-57170d023762	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 3
e7f662f3-ab85-48f8-b63d-d7955796ce5b	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 4
e0f7006d-1ac4-4049-95fa-9d0dd8eb7780	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 5
7f41fe9d-8377-4e8e-9d28-33c1632d1c76	dbca39d7-faa6-4cf6-929a-1436658823a3	Day 6
a061f6f4-61dd-4206-8a5f-03f55c5f7867	a2577221-541d-428d-84d5-c411246dcc8c	Day 1
c257bc54-9ada-4d53-a640-37590cda5612	a2577221-541d-428d-84d5-c411246dcc8c	Day 2
75849670-a2e0-45dd-b611-a2f7ca95dd53	a2577221-541d-428d-84d5-c411246dcc8c	Day 3
64ffc5a4-c33e-4247-b2e7-f029bc02459d	a2577221-541d-428d-84d5-c411246dcc8c	Day 4
6a77b098-8e32-44ed-bacd-07107434edc5	026016d0-3b10-4ce6-afb9-2a521a9a2979	Day 4
1483daf2-8d1f-4d98-9e40-cfa2d7bc8694	026016d0-3b10-4ce6-afb9-2a521a9a2979	Day 5
e52baf68-2501-4981-a582-da20773603e7	ad779c07-b498-48ca-b539-ac53435e4d44	Day 1
43e4bd5e-acae-407a-8830-15fd3072b5e5	ad779c07-b498-48ca-b539-ac53435e4d44	Day 2
e1a81198-6446-4dc0-bc1f-aae645da8573	ad779c07-b498-48ca-b539-ac53435e4d44	Day 3
82906921-794a-4dd6-b69c-9602aab50315	ad779c07-b498-48ca-b539-ac53435e4d44	Day 4
a9585906-0ed8-4f91-88ad-f9cfd2875175	a2577221-541d-428d-84d5-c411246dcc8c	Day 5
3551ca4e-ca79-4e23-a2bf-fa682b71bec1	a2577221-541d-428d-84d5-c411246dcc8c	Day 6
c66c082e-d347-4116-b78f-8e83d58278c8	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 1
962f95f6-0cbc-4ecb-a552-712f25b2d932	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 2
8e5ac9f9-2068-46d7-b41f-8ded4c4efbab	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 3
d0a91048-8306-4490-8761-533de11b4724	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 4
75dc67f5-cd58-449b-91d8-74af6f4e13f1	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 5
ec5bc8eb-07f6-4e35-8bf2-66d1e9bf7379	c5def8cb-87f5-4deb-866e-17b0c1e76d15	Day 6
86652d93-6784-49c6-bba6-8772eeef8128	fae2f698-9831-47ae-be34-4495126c79fc	Day 1
6748c195-2b16-4848-81bc-e73c2e1ba995	fae2f698-9831-47ae-be34-4495126c79fc	Day 3
09e257c2-87c2-4cd3-9bc0-32b72754dc4f	fae2f698-9831-47ae-be34-4495126c79fc	Day 5
58e4c9d6-f4b7-44ef-a6dd-1c57fafd97e4	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	Day 1
04e0b6cf-575e-4ba2-8640-ad1136e5cf11	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	Day 2
4001c526-4c4e-4527-bf3c-3dced667f757	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	Day 3
4a6b4c75-d8cb-40f5-bba2-ad38341960ea	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	Day 4
acdb7c18-179b-4624-8c02-d517bab299f1	ad779c07-b498-48ca-b539-ac53435e4d44	Day 5
1b4d8484-8c7b-43c5-855a-5e1e80fa8334	043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	Day 5
77158380-2d78-4b76-ae4c-e82ebf85fcaf	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	Day 1
4b8ece09-1c5d-42ba-a79b-b74c0011e155	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	Day 2
184afbbe-a166-48cf-b26f-214331a7e379	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	Day 3
8561b03c-7db9-4d98-93b2-9fbc65a96f0f	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	Day 4
f1177bf0-1e23-48c7-98a7-1938fa224dca	61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	Day 5
a413cc7b-4f7c-43f7-bbae-06fdeb4bcda5	cc478162-1601-4847-893d-e5ff6274fc0c	Day 1
90db24ed-7542-44bb-8721-1967f355533d	cc478162-1601-4847-893d-e5ff6274fc0c	Day 2
510e7e6e-e315-4903-ae18-e47edce3c2e7	cc478162-1601-4847-893d-e5ff6274fc0c	Day 3
21b11897-c0e3-43fe-ae18-d3fb5028069b	cc478162-1601-4847-893d-e5ff6274fc0c	Day 4
f9ed67cc-2f7b-46b8-8cfd-49f10fab7eac	cc478162-1601-4847-893d-e5ff6274fc0c	Day 5
184ee0ae-5e02-4e60-a0a9-79a46cdc5c50	3c55f055-32e9-4fa6-bcfc-a2a7834c0b1c	Day 1
e5c03a29-6fa8-42e4-85dd-49163d26302e	3c55f055-32e9-4fa6-bcfc-a2a7834c0b1c	Day 2
e11447d8-ee6a-4146-8d50-e9182b277820	3c55f055-32e9-4fa6-bcfc-a2a7834c0b1c	Day 3
5ad86cd4-334d-49c5-ad12-684c42619bce	3c55f055-32e9-4fa6-bcfc-a2a7834c0b1c	Day 4
4973a40e-2fd2-4861-ab58-afb138dc485c	3c55f055-32e9-4fa6-bcfc-a2a7834c0b1c	Day 5
08a1f5ce-0d0b-45ed-b96f-3f20b2fdf4ec	5683db29-d4cd-4a5b-ab89-67af581ef4df	Day 1
e0fdb345-c4b5-4d77-b563-eca93d2d391d	5683db29-d4cd-4a5b-ab89-67af581ef4df	Day 2
484ac1ef-dae6-447d-8655-083b5400ea4e	5683db29-d4cd-4a5b-ab89-67af581ef4df	Day 3
d18561df-8981-43f3-87e5-686c0f4acff3	5683db29-d4cd-4a5b-ab89-67af581ef4df	Day 4
32848090-13f7-49d7-b9c2-c74a34183820	5683db29-d4cd-4a5b-ab89-67af581ef4df	Day 5
51a33c7d-77b3-4c65-8c80-30dd2f0d4cc9	5683db29-d4cd-4a5b-ab89-67af581ef4df	Day 6
a70cbb73-dc3e-4a93-8eed-079317b41064	405418ef-045c-4c31-96f9-85346230c5ac	Day 1
7eb36cd9-cd52-45d7-a5dc-e48900379b9a	405418ef-045c-4c31-96f9-85346230c5ac	Day 2
b5294cac-c19e-4d9d-9fa1-336644662c93	405418ef-045c-4c31-96f9-85346230c5ac	Day 3
0af1f293-2ce9-4f10-b6af-1b36e4faf220	405418ef-045c-4c31-96f9-85346230c5ac	Day 4
0d19d8b8-4e08-40de-8c16-6579d1504c81	405418ef-045c-4c31-96f9-85346230c5ac	Day 5
bd78ab96-d993-49a7-8884-d8dc41b58f04	405418ef-045c-4c31-96f9-85346230c5ac	Day 6
4e43cd1c-e6d2-43ed-9095-1a69ef0dd8ef	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 1
cf4d1661-6b65-4590-8e14-1dfee2c7ddf4	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 2
e4f06846-76cb-4894-9b09-637c1d331898	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 3
6ee37999-5c57-428d-bb59-7c06d637c27f	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 4
b6f26856-f06c-4baf-9b3c-cb2e022a9573	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 5
3e4d7190-2289-4214-a9fd-7de7a02b8c0e	da8e814d-f49b-4e96-9afd-e484c9e440f6	Day 6
\.


--
-- Data for Name: workout_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workout_plans (id, member_id, coach_email, title, notes, created_at, updated_at, target_steps_count) FROM stdin;
9fd58431-91f6-4e1e-9f58-f6e7f6128d06	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	Push Pull Legs (8-10 weeks)	Steps Target : 8k Daily	2026-03-19 13:36:28.402106	\N	\N
d9ee8604-ec0a-4beb-9df7-68eb619d17d2	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	Push-Lower-Pull-Lower-Push-Pull	Steps Target : 12000 Daily	2026-04-06 03:20:18.822365	\N	\N
f9a689f5-7b4c-4c47-8c89-ac54464a2ebb	ac5f869c-9115-4f0a-9f68-d02c0275570c	varun.deoghare@gmail.com	Gym based workout		2026-03-27 04:16:36.507894	\N	8000
df876ef1-988a-4ea0-9302-cbc50911087e	0e06681a-b803-432e-99f0-8fdf61e1bdcb	varun.deoghare@gmail.com	Gym based workout		2026-06-11 13:49:22.011258	\N	8000
dbca39d7-faa6-4cf6-929a-1436658823a3	19fea79e-0cd4-4196-a8c5-09ba95f28629	varun.deoghare@gmail.com	Push Pull Legs Phase 2		2026-05-17 16:41:16.626651	\N	12000
a2577221-541d-428d-84d5-c411246dcc8c	b4f7aef7-e790-4017-b54b-de6d215940ce	varun.deoghare@gmail.com	Push Pull Legs (8-10 weeks)		2026-03-15 12:49:13.51916	\N	10000
c5def8cb-87f5-4deb-866e-17b0c1e76d15	8bfd0ed7-70b6-42da-91d2-c8c984e522ae	varun.deoghare@gmail.com	Push-Legs-Pull		2026-05-08 03:15:22.061623	\N	6000
fae2f698-9831-47ae-be34-4495126c79fc	ac007cd0-71ae-45ae-875a-342fbafca921	varun.deoghare@gmail.com	3-Day Full Body	Day 1(Workout) - Day 2(Rest) - Day 3(Workout) - Day 4(Rest) - Day 5(Workout) - Day 6(Rest) - Day 7(Rest)	2026-05-27 04:13:34.118481	\N	6000
043a0b2c-e60e-4a01-b9af-926d7dc7d9a6	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	Push-Pull-Legs-Upper-Lower		2026-03-28 14:03:43.228464	\N	12000
61ef1bf9-ab95-4b02-b6d9-c1f04d14d758	f47345ea-a6df-40b0-928b-9d88c3e05350	varun.deoghare@gmail.com	Push ΓÇô Lower ΓÇô Pull ΓÇô Push ΓÇô Pull		2026-05-12 13:52:15.894094	\N	6000
cc478162-1601-4847-893d-e5ff6274fc0c	80026e92-8f66-4cfb-852a-e92f48f7ea38	varun.deoghare@gmail.com	Push-Lower-Pull-Push-Pull		2026-06-11 13:58:43.660339	\N	6000
3c55f055-32e9-4fa6-bcfc-a2a7834c0b1c	fcf48abc-f075-4158-a40a-1ebc3cdfd9a2	varun.deoghare@gmail.com	Upper - Lower - Push - Pull - Legs		2026-05-20 12:10:45.904539	\N	6000
5683db29-d4cd-4a5b-ab89-67af581ef4df	57ee19de-9c3f-49bf-83d2-20a56100a64e	varun.deoghare@gmail.com	Full Body Senior Plan(4 Weeks)	Walk 20-30 mins at comfortable pace\nBreathe normally during all exercises\nRest 45–60 sec between sets\nStop if dizziness/chest discomfort occurs	2026-05-24 07:55:16.677435	\N	5000
405418ef-045c-4c31-96f9-85346230c5ac	6ae0f3fa-0233-4160-ba88-11f4b8ae7e38	varun.deoghare@gmail.com	Full Body Senior Plan(4 Weeks)	Walk 20-30 mins at comfortable pace\nBreathe normally during all exercises\nRest 45–60 sec between sets\nStop if dizziness/chest discomfort occurs 	2026-05-24 13:20:14.983688	\N	5000
da8e814d-f49b-4e96-9afd-e484c9e440f6	8c06bb51-e6eb-4bfe-95b7-d437423e6afa	varun.deoghare@gmail.com	Push Pull Legs (8-10 weeks)		2026-03-15 14:54:52.519471	\N	12000
d92d5aad-8968-4c1c-afb7-2a12932e73c4	dc3a7e5d-f6ee-4d80-9f3f-388743cc6518	varun.deoghare@gmail.com	Upper - Lower - Push - Pull - Lower		2026-05-29 03:28:46.498183	\N	6000
ca59d371-e6cc-440c-941c-94271aa61761	525dc6ab-79fa-49f9-af15-1e482244c495	varun.deoghare@gmail.com	Push Pull Legs (8-10 weeks)		2026-03-16 11:46:50.730681	\N	10000
906bdcbe-2b1e-47d8-ae41-79248292b190	930eeb2e-e6d4-44f0-9636-d980c65db931	varun.deoghare@gmail.com	Home Based Workout		2026-07-05 14:01:31.715716	\N	6000
ad779c07-b498-48ca-b539-ac53435e4d44	e7720152-a475-463a-a2a5-120af6cdfce6	varun.deoghare@gmail.com	5-Day Upper / Lower / Push / Pull / Legs		2026-07-07 03:38:41.898764	\N	8000
026016d0-3b10-4ce6-afb9-2a521a9a2979	5ca9f8b0-b1de-4444-b5a2-e9529903b76d	varun.deoghare@gmail.com	Lower– Push – Pull – Lower – Upper		2026-07-13 14:57:52.833095	\N	12000
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

\unrestrict V5ifg2GglPdzOMAGJRoAcFoH2Be2kFi2DFaVIhRL12sEwNaabIbghPSHJjyRnaU

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict IEE6dPhIUfzSGWIdhTdeAaeV2rornsEkCzhiXC8SLAkKiwywdp2w9EntE8347ae

-- Dumped from database version 15.18 (Debian 15.18-1.pgdg13+1)
-- Dumped by pg_dump version 15.18 (Debian 15.18-1.pgdg13+1)

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

\unrestrict IEE6dPhIUfzSGWIdhTdeAaeV2rornsEkCzhiXC8SLAkKiwywdp2w9EntE8347ae

--
-- PostgreSQL database cluster dump complete
--


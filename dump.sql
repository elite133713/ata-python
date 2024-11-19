--
-- PostgreSQL database dump
--

-- Dumped from database version 15.9
-- Dumped by pg_dump version 15.9

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
-- Name: movies; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.movies
(
    id           integer           NOT NULL,
    title        character varying NOT NULL,
    genre        character varying NOT NULL,
    release_date date              NOT NULL
);


ALTER TABLE public.movies OWNER TO sa;

--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE
SEQUENCE public.movies_id_seq
    AS integer
    START
WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE
1;


ALTER TABLE public.movies_id_seq OWNER TO sa;

--
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER
SEQUENCE public.movies_id_seq OWNED BY public.movies.id;


--
-- Name: sales; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.sales
(
    id           integer NOT NULL,
    theater_id   integer NOT NULL,
    movie_id     integer NOT NULL,
    sale_date    date    NOT NULL,
    tickets_sold integer NOT NULL
);


ALTER TABLE public.sales OWNER TO sa;

--
-- Name: sales_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE
SEQUENCE public.sales_id_seq
    AS integer
    START
WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE
1;


ALTER TABLE public.sales_id_seq OWNER TO sa;

--
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER
SEQUENCE public.sales_id_seq OWNED BY public.sales.id;


--
-- Name: theaters; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.theaters
(
    id       integer           NOT NULL,
    name     character varying NOT NULL,
    location character varying NOT NULL
);


ALTER TABLE public.theaters OWNER TO sa;

--
-- Name: theaters_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE
SEQUENCE public.theaters_id_seq
    AS integer
    START
WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE
1;


ALTER TABLE public.theaters_id_seq OWNER TO sa;

--
-- Name: theaters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER
SEQUENCE public.theaters_id_seq OWNED BY public.theaters.id;


--
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);


--
-- Name: sales id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);


--
-- Name: theaters id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.theaters ALTER COLUMN id SET DEFAULT nextval('public.theaters_id_seq'::regclass);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- Name: theaters theaters_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.theaters
    ADD CONSTRAINT theaters_pkey PRIMARY KEY (id);


--
-- Name: idx_theater_movie_date; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_theater_movie_date ON public.sales USING btree (theater_id, movie_id, sale_date);


--
-- Name: ix_sales_movie_id; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX ix_sales_movie_id ON public.sales USING btree (movie_id);


--
-- Name: ix_sales_sale_date; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX ix_sales_sale_date ON public.sales USING btree (sale_date);


--
-- Name: ix_sales_theater_id; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX ix_sales_theater_id ON public.sales USING btree (theater_id);


--
-- Name: sales sales_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- Name: sales sales_theater_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_theater_id_fkey FOREIGN KEY (theater_id) REFERENCES public.theaters(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

\restrict amHTF7yA7AKBngE6kOLarRmVIwYtfetw2zfRs7khVUT6tnswuoKNAGTf9qFRR4A

-- Dumped from database version 17.7 (bdc8956)
-- Dumped by pg_dump version 18.1

-- Started on 2026-01-03 10:24:46

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
-- TOC entry 6 (class 2615 OID 24576)
-- Name: drizzle; Type: SCHEMA; Schema: -; Owner: neondb_owner
--

CREATE SCHEMA drizzle;


ALTER SCHEMA drizzle OWNER TO neondb_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 24577)
-- Name: __drizzle_migrations; Type: TABLE; Schema: drizzle; Owner: neondb_owner
--

CREATE TABLE drizzle.__drizzle_migrations (
    id integer NOT NULL,
    hash text NOT NULL,
    created_at bigint
);


ALTER TABLE drizzle.__drizzle_migrations OWNER TO neondb_owner;

--
-- TOC entry 219 (class 1259 OID 24582)
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE; Schema: drizzle; Owner: neondb_owner
--

CREATE SEQUENCE drizzle.__drizzle_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3742 (class 0 OID 0)
-- Dependencies: 219
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: drizzle; Owner: neondb_owner
--

ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNED BY drizzle.__drizzle_migrations.id;


--
-- TOC entry 220 (class 1259 OID 24583)
-- Name: budget_negotiations; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.budget_negotiations (
    id integer NOT NULL,
    project_id integer NOT NULL,
    proposed_by integer NOT NULL,
    original_price numeric(12,2) NOT NULL,
    proposed_price numeric(12,2) NOT NULL,
    message text,
    status character varying(50) DEFAULT 'pending'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    responded_at timestamp without time zone
);


ALTER TABLE public.budget_negotiations OWNER TO neondb_owner;

--
-- TOC entry 221 (class 1259 OID 24590)
-- Name: budget_negotiations_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.budget_negotiations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.budget_negotiations_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3743 (class 0 OID 0)
-- Dependencies: 221
-- Name: budget_negotiations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.budget_negotiations_id_seq OWNED BY public.budget_negotiations.id;


--
-- TOC entry 256 (class 1259 OID 106497)
-- Name: client_billing_info; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.client_billing_info (
    id integer NOT NULL,
    user_id integer NOT NULL,
    legal_name character varying(255) NOT NULL,
    document_type character varying(50) DEFAULT 'CI'::character varying NOT NULL,
    document_number character varying(50) NOT NULL,
    address text,
    city character varying(100),
    country character varying(100) DEFAULT 'Paraguay'::character varying,
    phone character varying(20),
    is_default boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    client_type character varying(50) DEFAULT 'persona_fisica'::character varying NOT NULL,
    department character varying(100),
    email character varying(255),
    observations text
);


ALTER TABLE public.client_billing_info OWNER TO neondb_owner;

--
-- TOC entry 3744 (class 0 OID 0)
-- Dependencies: 256
-- Name: COLUMN client_billing_info.client_type; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.client_billing_info.client_type IS 'Tipo de cliente: persona_fisica, empresa, consumidor_final, extranjero';


--
-- TOC entry 3745 (class 0 OID 0)
-- Dependencies: 256
-- Name: COLUMN client_billing_info.department; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.client_billing_info.department IS 'Departamento del Paraguay: Itapúa, Central, Alto Paraná, etc.';


--
-- TOC entry 3746 (class 0 OID 0)
-- Dependencies: 256
-- Name: COLUMN client_billing_info.email; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.client_billing_info.email IS 'Email obligatorio para envío de facturas en PDF';


--
-- TOC entry 3747 (class 0 OID 0)
-- Dependencies: 256
-- Name: COLUMN client_billing_info.observations; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.client_billing_info.observations IS 'Observaciones adicionales: Sucursal Central, Proyecto Web, etc.';


--
-- TOC entry 255 (class 1259 OID 106496)
-- Name: client_billing_info_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.client_billing_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_billing_info_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3748 (class 0 OID 0)
-- Dependencies: 255
-- Name: client_billing_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.client_billing_info_id_seq OWNED BY public.client_billing_info.id;


--
-- TOC entry 258 (class 1259 OID 106518)
-- Name: company_billing_info; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.company_billing_info (
    id integer NOT NULL,
    company_name character varying(255) NOT NULL,
    ruc character varying(20) NOT NULL,
    address text NOT NULL,
    city character varying(100) NOT NULL,
    country character varying(100) DEFAULT 'Paraguay'::character varying,
    phone character varying(20),
    email character varying(255),
    website character varying(255),
    tax_regime character varying(100),
    economic_activity character varying(255),
    logo_url text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    timbrado_number character varying(20),
    vigencia_timbrado character varying(20),
    vencimiento_timbrado character varying(20),
    boleta_prefix character varying(20) DEFAULT '001-001'::character varying,
    boleta_sequence integer DEFAULT 1,
    titular_name character varying(255),
    department character varying(100) DEFAULT 'Itapúa'::character varying,
    iva_percentage numeric(5,2) DEFAULT 10.00,
    is_signature_process_enabled boolean DEFAULT true
);


ALTER TABLE public.company_billing_info OWNER TO neondb_owner;

--
-- TOC entry 3749 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN company_billing_info.titular_name; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.company_billing_info.titular_name IS 'Nombre completo del titular de la empresa (persona física)';


--
-- TOC entry 3750 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN company_billing_info.department; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.company_billing_info.department IS 'Departamento del Paraguay: Itapúa, Central, Alto Paraná, etc.';


--
-- TOC entry 257 (class 1259 OID 106517)
-- Name: company_billing_info_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.company_billing_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.company_billing_info_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3751 (class 0 OID 0)
-- Dependencies: 257
-- Name: company_billing_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.company_billing_info_id_seq OWNED BY public.company_billing_info.id;


--
-- TOC entry 260 (class 1259 OID 122881)
-- Name: exchange_rate_config; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.exchange_rate_config (
    id integer NOT NULL,
    usd_to_guarani numeric(10,2) NOT NULL,
    updated_by integer NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.exchange_rate_config OWNER TO neondb_owner;

--
-- TOC entry 259 (class 1259 OID 122880)
-- Name: exchange_rate_config_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.exchange_rate_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exchange_rate_config_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3752 (class 0 OID 0)
-- Dependencies: 259
-- Name: exchange_rate_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.exchange_rate_config_id_seq OWNED BY public.exchange_rate_config.id;


--
-- TOC entry 270 (class 1259 OID 409601)
-- Name: hero_slider_config; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.hero_slider_config (
    id integer NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    auto_play_interval integer DEFAULT 5000 NOT NULL,
    transition_duration integer DEFAULT 800 NOT NULL,
    transition_effect character varying(50) DEFAULT 'fade'::character varying NOT NULL,
    show_controls boolean DEFAULT true NOT NULL,
    show_dots boolean DEFAULT true NOT NULL,
    pause_on_hover boolean DEFAULT true NOT NULL,
    updated_by integer,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.hero_slider_config OWNER TO neondb_owner;

--
-- TOC entry 269 (class 1259 OID 409600)
-- Name: hero_slider_config_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.hero_slider_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hero_slider_config_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3753 (class 0 OID 0)
-- Dependencies: 269
-- Name: hero_slider_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.hero_slider_config_id_seq OWNED BY public.hero_slider_config.id;


--
-- TOC entry 268 (class 1259 OID 393217)
-- Name: hero_slides; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.hero_slides (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    subtitle text,
    description text,
    image_url text,
    button_text character varying(100),
    button_link character varying(255),
    display_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    background_color character varying(50),
    media_type text DEFAULT 'image'::text,
    background_color_opacity integer DEFAULT 100
);


ALTER TABLE public.hero_slides OWNER TO neondb_owner;

--
-- TOC entry 267 (class 1259 OID 393216)
-- Name: hero_slides_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.hero_slides_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hero_slides_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3754 (class 0 OID 0)
-- Dependencies: 267
-- Name: hero_slides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.hero_slides_id_seq OWNED BY public.hero_slides.id;


--
-- TOC entry 222 (class 1259 OID 24591)
-- Name: invoices; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.invoices (
    id integer NOT NULL,
    invoice_number character varying(100) NOT NULL,
    project_id integer NOT NULL,
    client_id integer NOT NULL,
    amount numeric(12,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    due_date timestamp without time zone NOT NULL,
    paid_date timestamp without time zone,
    description text,
    tax_amount numeric(12,2) DEFAULT 0.00,
    discount_amount numeric(12,2) DEFAULT 0.00,
    total_amount numeric(12,2) NOT NULL,
    payment_method_id integer,
    notes text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    currency character varying(3) DEFAULT 'PYG'::character varying NOT NULL,
    payment_stage_id integer,
    exchange_rate_used numeric(10,2),
    sifen_cdc character varying(44),
    sifen_protocolo character varying(50),
    sifen_estado character varying(20),
    sifen_xml text,
    sifen_fecha_envio timestamp without time zone,
    sifen_mensaje_error text,
    sifen_qr character varying(1000),
    client_snapshot_type character varying(50),
    client_snapshot_legal_name character varying(255),
    client_snapshot_document_type character varying(50),
    client_snapshot_document_number character varying(50),
    client_snapshot_address text,
    client_snapshot_city character varying(100),
    client_snapshot_department character varying(100),
    client_snapshot_country character varying(100),
    client_snapshot_email character varying(255),
    client_snapshot_phone character varying(20),
    issue_date_snapshot character varying(50),
    issue_date_time_snapshot character varying(50)
);


ALTER TABLE public.invoices OWNER TO neondb_owner;

--
-- TOC entry 3755 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN invoices.exchange_rate_used; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.exchange_rate_used IS 'Tipo de cambio USD a PYG usado al momento de generar la factura. Este valor queda fijo y no cambia aunque el tipo de cambio se actualice después.';


--
-- TOC entry 3756 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN invoices.sifen_cdc; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_cdc IS 'Código de Control SIFEN de 44 dígitos';


--
-- TOC entry 3757 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN invoices.sifen_protocolo; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_protocolo IS 'Protocolo de autorización devuelto por SIFEN';


--
-- TOC entry 3758 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN invoices.sifen_estado; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_estado IS 'Estado de la factura en SIFEN: aceptado, rechazado, pendiente';


--
-- TOC entry 3759 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN invoices.sifen_xml; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_xml IS 'XML completo enviado a SIFEN';


--
-- TOC entry 3760 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN invoices.sifen_fecha_envio; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_fecha_envio IS 'Fecha y hora de envío a SIFEN';


--
-- TOC entry 3761 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN invoices.sifen_mensaje_error; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_mensaje_error IS 'Mensaje de error si la factura fue rechazada por SIFEN';


--
-- TOC entry 3762 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN invoices.sifen_qr; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_qr IS 'URL del código QR para verificación en e-Kuatia SET';


--
-- TOC entry 223 (class 1259 OID 24601)
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.invoices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoices_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 223
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.invoices_id_seq OWNED BY public.invoices.id;


--
-- TOC entry 266 (class 1259 OID 311297)
-- Name: legal_pages; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.legal_pages (
    id integer NOT NULL,
    page_type character varying(50) NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    last_updated_by integer,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.legal_pages OWNER TO neondb_owner;

--
-- TOC entry 265 (class 1259 OID 311296)
-- Name: legal_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.legal_pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.legal_pages_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 265
-- Name: legal_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.legal_pages_id_seq OWNED BY public.legal_pages.id;


--
-- TOC entry 224 (class 1259 OID 24611)
-- Name: notifications; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    type character varying(50) DEFAULT 'info'::character varying NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.notifications OWNER TO neondb_owner;

--
-- TOC entry 225 (class 1259 OID 24619)
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 225
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- TOC entry 226 (class 1259 OID 24620)
-- Name: partners; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.partners (
    id integer NOT NULL,
    user_id integer NOT NULL,
    referral_code character varying(50) NOT NULL,
    commission_rate numeric(5,2) DEFAULT 25.00 NOT NULL,
    total_earnings numeric(12,2) DEFAULT 0.00 NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.partners OWNER TO neondb_owner;

--
-- TOC entry 227 (class 1259 OID 24626)
-- Name: partners_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.partners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partners_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 227
-- Name: partners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.partners_id_seq OWNED BY public.partners.id;


--
-- TOC entry 264 (class 1259 OID 303105)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.password_reset_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token character varying(255) NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    used boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.password_reset_tokens OWNER TO neondb_owner;

--
-- TOC entry 263 (class 1259 OID 303104)
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.password_reset_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.password_reset_tokens_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 263
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.password_reset_tokens_id_seq OWNED BY public.password_reset_tokens.id;


--
-- TOC entry 228 (class 1259 OID 24627)
-- Name: payment_methods; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payment_methods (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type character varying(50) NOT NULL,
    is_default boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    details jsonb NOT NULL
);


ALTER TABLE public.payment_methods OWNER TO neondb_owner;

--
-- TOC entry 229 (class 1259 OID 24636)
-- Name: payment_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payment_methods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_methods_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 229
-- Name: payment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payment_methods_id_seq OWNED BY public.payment_methods.id;


--
-- TOC entry 230 (class 1259 OID 24637)
-- Name: payment_stages; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payment_stages (
    id integer NOT NULL,
    project_id integer NOT NULL,
    stage_name text NOT NULL,
    stage_percentage integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    required_progress integer DEFAULT 0 NOT NULL,
    status text DEFAULT 'pending'::character varying NOT NULL,
    payment_link text,
    paid_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    payment_method character varying(50),
    payment_data jsonb,
    proof_file_url text,
    exchange_rate_used numeric(10,2)
);


ALTER TABLE public.payment_stages OWNER TO neondb_owner;

--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN payment_stages.exchange_rate_used; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.payment_stages.exchange_rate_used IS 'Tipo de cambio USD a PYG usado al momento del pago. Este valor queda fijo y no cambia aunque el tipo de cambio se actualice después.';


--
-- TOC entry 231 (class 1259 OID 24645)
-- Name: payment_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payment_stages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_stages_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 231
-- Name: payment_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payment_stages_id_seq OWNED BY public.payment_stages.id;


--
-- TOC entry 232 (class 1259 OID 24646)
-- Name: payments; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    project_id integer NOT NULL,
    amount numeric(12,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    payment_data jsonb,
    created_at timestamp without time zone DEFAULT now(),
    stage character varying(50) DEFAULT 'full'::character varying,
    stage_percentage numeric(5,2) DEFAULT 100.00,
    payment_method character varying(100),
    transaction_id character varying(255)
);


ALTER TABLE public.payments OWNER TO neondb_owner;

--
-- TOC entry 233 (class 1259 OID 24655)
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 233
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- TOC entry 234 (class 1259 OID 24656)
-- Name: portfolio; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.portfolio (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    category character varying(100) NOT NULL,
    technologies text NOT NULL,
    image_url text NOT NULL,
    demo_url text,
    completed_at timestamp without time zone NOT NULL,
    featured boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.portfolio OWNER TO neondb_owner;

--
-- TOC entry 235 (class 1259 OID 24665)
-- Name: portfolio_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.portfolio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.portfolio_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 235
-- Name: portfolio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.portfolio_id_seq OWNED BY public.portfolio.id;


--
-- TOC entry 236 (class 1259 OID 24666)
-- Name: project_files; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_files (
    id integer NOT NULL,
    project_id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    file_url text NOT NULL,
    file_type character varying(100),
    uploaded_by integer NOT NULL,
    file_size integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.project_files OWNER TO neondb_owner;

--
-- TOC entry 237 (class 1259 OID 24672)
-- Name: project_files_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.project_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_files_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 237
-- Name: project_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.project_files_id_seq OWNED BY public.project_files.id;


--
-- TOC entry 238 (class 1259 OID 24673)
-- Name: project_messages; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_messages (
    id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.project_messages OWNER TO neondb_owner;

--
-- TOC entry 239 (class 1259 OID 24679)
-- Name: project_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.project_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_messages_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 239
-- Name: project_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.project_messages_id_seq OWNED BY public.project_messages.id;


--
-- TOC entry 240 (class 1259 OID 24680)
-- Name: project_timeline; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_timeline (
    id integer NOT NULL,
    project_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    status character varying(50) DEFAULT 'pending'::character varying,
    estimated_date timestamp without time zone,
    completed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.project_timeline OWNER TO neondb_owner;

--
-- TOC entry 241 (class 1259 OID 24687)
-- Name: project_timeline_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.project_timeline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_timeline_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 241
-- Name: project_timeline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.project_timeline_id_seq OWNED BY public.project_timeline.id;


--
-- TOC entry 242 (class 1259 OID 24688)
-- Name: projects; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price numeric(12,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    progress integer DEFAULT 0 NOT NULL,
    client_id integer NOT NULL,
    partner_id integer,
    delivery_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    start_date timestamp without time zone
);


ALTER TABLE public.projects OWNER TO neondb_owner;

--
-- TOC entry 243 (class 1259 OID 24697)
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 243
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- TOC entry 244 (class 1259 OID 24698)
-- Name: referrals; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.referrals (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    client_id integer NOT NULL,
    project_id integer,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    commission_amount numeric(12,2) DEFAULT 0.00 NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.referrals OWNER TO neondb_owner;

--
-- TOC entry 245 (class 1259 OID 24704)
-- Name: referrals_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.referrals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referrals_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 245
-- Name: referrals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.referrals_id_seq OWNED BY public.referrals.id;


--
-- TOC entry 246 (class 1259 OID 24705)
-- Name: sessions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.sessions (
    sid character varying NOT NULL,
    sess jsonb NOT NULL,
    expire timestamp without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO neondb_owner;

--
-- TOC entry 247 (class 1259 OID 24710)
-- Name: ticket_responses; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.ticket_responses (
    id integer NOT NULL,
    ticket_id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    is_from_support boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.ticket_responses OWNER TO neondb_owner;

--
-- TOC entry 248 (class 1259 OID 24717)
-- Name: ticket_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.ticket_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ticket_responses_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 248
-- Name: ticket_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.ticket_responses_id_seq OWNED BY public.ticket_responses.id;


--
-- TOC entry 249 (class 1259 OID 24718)
-- Name: tickets; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.tickets (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    status character varying(50) DEFAULT 'open'::character varying NOT NULL,
    priority character varying(50) DEFAULT 'medium'::character varying NOT NULL,
    user_id integer NOT NULL,
    project_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.tickets OWNER TO neondb_owner;

--
-- TOC entry 250 (class 1259 OID 24727)
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tickets_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 250
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- TOC entry 262 (class 1259 OID 196609)
-- Name: transactions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    invoice_id integer NOT NULL,
    payment_method_id integer NOT NULL,
    user_id integer NOT NULL,
    amount numeric(12,2) NOT NULL,
    currency character varying(3) DEFAULT 'USD'::character varying NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    transaction_id character varying(255),
    payment_data jsonb,
    created_at timestamp without time zone DEFAULT now(),
    completed_at timestamp without time zone
);


ALTER TABLE public.transactions OWNER TO neondb_owner;

--
-- TOC entry 261 (class 1259 OID 196608)
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 261
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- TOC entry 251 (class 1259 OID 24745)
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    full_name character varying(255) NOT NULL,
    role character varying(50) DEFAULT 'client'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    whatsapp_number character varying(50)
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- TOC entry 252 (class 1259 OID 24754)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 252
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 254 (class 1259 OID 49153)
-- Name: work_modalities; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.work_modalities (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    subtitle character varying(255),
    badge_text character varying(100),
    badge_variant character varying(50) DEFAULT 'secondary'::character varying,
    description text NOT NULL,
    price_text character varying(255) NOT NULL,
    price_subtitle character varying(255),
    features jsonb NOT NULL,
    button_text character varying(255) DEFAULT 'Solicitar Cotización'::character varying NOT NULL,
    button_variant character varying(50) DEFAULT 'default'::character varying,
    is_popular boolean DEFAULT false,
    is_active boolean DEFAULT true,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.work_modalities OWNER TO neondb_owner;

--
-- TOC entry 253 (class 1259 OID 49152)
-- Name: work_modalities_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.work_modalities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.work_modalities_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3782 (class 0 OID 0)
-- Dependencies: 253
-- Name: work_modalities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.work_modalities_id_seq OWNED BY public.work_modalities.id;


--
-- TOC entry 3317 (class 2604 OID 24755)
-- Name: __drizzle_migrations id; Type: DEFAULT; Schema: drizzle; Owner: neondb_owner
--

ALTER TABLE ONLY drizzle.__drizzle_migrations ALTER COLUMN id SET DEFAULT nextval('drizzle.__drizzle_migrations_id_seq'::regclass);


--
-- TOC entry 3318 (class 2604 OID 24756)
-- Name: budget_negotiations id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations ALTER COLUMN id SET DEFAULT nextval('public.budget_negotiations_id_seq'::regclass);


--
-- TOC entry 3393 (class 2604 OID 106500)
-- Name: client_billing_info id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.client_billing_info ALTER COLUMN id SET DEFAULT nextval('public.client_billing_info_id_seq'::regclass);


--
-- TOC entry 3400 (class 2604 OID 106521)
-- Name: company_billing_info id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.company_billing_info ALTER COLUMN id SET DEFAULT nextval('public.company_billing_info_id_seq'::regclass);


--
-- TOC entry 3410 (class 2604 OID 122884)
-- Name: exchange_rate_config id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.exchange_rate_config ALTER COLUMN id SET DEFAULT nextval('public.exchange_rate_config_id_seq'::regclass);


--
-- TOC entry 3432 (class 2604 OID 409604)
-- Name: hero_slider_config id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.hero_slider_config ALTER COLUMN id SET DEFAULT nextval('public.hero_slider_config_id_seq'::regclass);


--
-- TOC entry 3425 (class 2604 OID 393220)
-- Name: hero_slides id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.hero_slides ALTER COLUMN id SET DEFAULT nextval('public.hero_slides_id_seq'::regclass);


--
-- TOC entry 3321 (class 2604 OID 24757)
-- Name: invoices id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices ALTER COLUMN id SET DEFAULT nextval('public.invoices_id_seq'::regclass);


--
-- TOC entry 3421 (class 2604 OID 311300)
-- Name: legal_pages id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.legal_pages ALTER COLUMN id SET DEFAULT nextval('public.legal_pages_id_seq'::regclass);


--
-- TOC entry 3328 (class 2604 OID 24759)
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- TOC entry 3332 (class 2604 OID 24760)
-- Name: partners id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners ALTER COLUMN id SET DEFAULT nextval('public.partners_id_seq'::regclass);


--
-- TOC entry 3418 (class 2604 OID 303108)
-- Name: password_reset_tokens id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.password_reset_tokens ALTER COLUMN id SET DEFAULT nextval('public.password_reset_tokens_id_seq'::regclass);


--
-- TOC entry 3336 (class 2604 OID 24761)
-- Name: payment_methods id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_methods ALTER COLUMN id SET DEFAULT nextval('public.payment_methods_id_seq'::regclass);


--
-- TOC entry 3340 (class 2604 OID 24762)
-- Name: payment_stages id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_stages ALTER COLUMN id SET DEFAULT nextval('public.payment_stages_id_seq'::regclass);


--
-- TOC entry 3345 (class 2604 OID 24763)
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- TOC entry 3350 (class 2604 OID 24764)
-- Name: portfolio id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.portfolio ALTER COLUMN id SET DEFAULT nextval('public.portfolio_id_seq'::regclass);


--
-- TOC entry 3355 (class 2604 OID 24765)
-- Name: project_files id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files ALTER COLUMN id SET DEFAULT nextval('public.project_files_id_seq'::regclass);


--
-- TOC entry 3357 (class 2604 OID 24766)
-- Name: project_messages id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages ALTER COLUMN id SET DEFAULT nextval('public.project_messages_id_seq'::regclass);


--
-- TOC entry 3359 (class 2604 OID 24767)
-- Name: project_timeline id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_timeline ALTER COLUMN id SET DEFAULT nextval('public.project_timeline_id_seq'::regclass);


--
-- TOC entry 3362 (class 2604 OID 24768)
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- TOC entry 3367 (class 2604 OID 24769)
-- Name: referrals id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals ALTER COLUMN id SET DEFAULT nextval('public.referrals_id_seq'::regclass);


--
-- TOC entry 3371 (class 2604 OID 24770)
-- Name: ticket_responses id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses ALTER COLUMN id SET DEFAULT nextval('public.ticket_responses_id_seq'::regclass);


--
-- TOC entry 3374 (class 2604 OID 24771)
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- TOC entry 3414 (class 2604 OID 196612)
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- TOC entry 3379 (class 2604 OID 24774)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3384 (class 2604 OID 49156)
-- Name: work_modalities id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.work_modalities ALTER COLUMN id SET DEFAULT nextval('public.work_modalities_id_seq'::regclass);


--
-- TOC entry 3684 (class 0 OID 24577)
-- Dependencies: 218
-- Data for Name: __drizzle_migrations; Type: TABLE DATA; Schema: drizzle; Owner: neondb_owner
--

COPY drizzle.__drizzle_migrations (id, hash, created_at) FROM stdin;
\.


--
-- TOC entry 3686 (class 0 OID 24583)
-- Dependencies: 220
-- Data for Name: budget_negotiations; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.budget_negotiations (id, project_id, proposed_by, original_price, proposed_price, message, status, created_at, responded_at) FROM stdin;
\.


--
-- TOC entry 3722 (class 0 OID 106497)
-- Dependencies: 256
-- Data for Name: client_billing_info; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.client_billing_info (id, user_id, legal_name, document_type, document_number, address, city, country, phone, is_default, created_at, updated_at, client_type, department, email, observations) FROM stdin;
1	2	david maidana kiroga	Documento_Extranjero	94499982	la madeselva 4508		Argentina	+541160123437	t	2025-09-30 03:19:11.00619	2026-01-03 04:32:29.032	consumidor_final	Alto Paraguay	alfagroupstoreok@gmail.com	
2	2	David Maidana kiñon	Documento_Extranjero	94499982	La Madreselva 4508	Buenos Aires (Capital)	Argentina	1170624214	t	2026-01-01 17:32:18.986821	2026-01-03 04:33:31.168	extranjero	Buenos Aires	alfagroupstoreok@gmail.com	
\.


--
-- TOC entry 3724 (class 0 OID 106518)
-- Dependencies: 258
-- Data for Name: company_billing_info; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.company_billing_info (id, company_name, ruc, address, city, country, phone, email, website, tax_regime, economic_activity, logo_url, is_active, created_at, updated_at, timbrado_number, vigencia_timbrado, vencimiento_timbrado, boleta_prefix, boleta_sequence, titular_name, department, iva_percentage, is_signature_process_enabled) FROM stdin;
1	SOFTWAREPAR	4220058-0	Barrio Residencial – Carlos A. López – Itapúa	CARLOS A. LOPEZ	Paraguay	+595 985 990 046	softwarepar.lat@gmail.com	https://softwarepar.lat	IRE SIMPLE	62090 - Otras actividades de tecnología de la información		t	2025-09-30 02:51:18.953684	2026-01-03 03:56:04.375103	18398622	24/10/2025	24/10/2026	001-001	44	JHONI FABIAN BENITEZ DE LA CRUZ	ITAPUA	10.00	t
2	SOFTWAREPAR	4220058-0	Barrio Residencial	Carlos Antonio López	Paraguay	+595 985 990 046	softwarepar.lat@gmail.com	https://softwarepar.lat	Pequeño Contribuyente - RESIMPLE	Desarrollo de software y servicios informáticos		f	2025-09-30 02:58:37.188036	2026-01-01 14:40:51.195	7777777	01/10/2025	30/09/2027	001-001	1	JHONI FABIAN BENITEZ DE LA CRUZ	Itapúa	10.00	t
3	SOFTWAREPAR	4220058-0	Barrio Residencial	Carlos Antonio López	Paraguay	+595 985 990 046	softwarepar.lat@gmail.com	https://softwarepar.lat	Pequeño Contribuyente - RESIMPLE	Desarrollo de software y servicios informáticos		f	2025-09-30 02:58:46.531403	2026-01-01 14:40:51.195	15378596	01/10/2025	30/09/2027	001-001	1	JHONI FABIAN BENITEZ DE LA CRUZ	Itapúa	10.00	t
\.


--
-- TOC entry 3726 (class 0 OID 122881)
-- Dependencies: 260
-- Data for Name: exchange_rate_config; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.exchange_rate_config (id, usd_to_guarani, updated_by, is_active, created_at, updated_at) FROM stdin;
1	7300.00	1	f	2025-09-30 15:52:54.875118	2025-12-31 04:01:35.027
2	7200.00	1	f	2025-09-30 15:53:34.668394	2025-12-31 04:01:35.027
3	7300.00	1	f	2025-10-01 00:51:06.648818	2025-12-31 04:01:35.027
4	7.06	1	f	2025-10-11 22:40:02.85167	2025-12-31 04:01:35.027
5	7.06	1	f	2025-10-11 22:41:08.5435	2025-12-31 04:01:35.027
6	7.06	1	f	2025-10-11 22:41:25.8804	2025-12-31 04:01:35.027
7	7.06	1	f	2025-10-11 22:41:38.616533	2025-12-31 04:01:35.027
8	7060.00	1	f	2025-10-11 22:41:46.744348	2025-12-31 04:01:35.027
9	7300.00	1	f	2025-10-11 22:52:06.802565	2025-12-31 04:01:35.027
10	7060.00	1	f	2025-10-11 22:56:29.278781	2025-12-31 04:01:35.027
11	7300.00	1	f	2025-10-11 23:20:17.365582	2025-12-31 04:01:35.027
12	7100.00	1	f	2025-10-16 23:28:08.713638	2025-12-31 04:01:35.027
13	7094.31	1	f	2025-10-23 21:27:17.142526	2025-12-31 04:01:35.027
14	7094.31	1	f	2025-10-27 11:34:04.812641	2025-12-31 04:01:35.027
15	7076.80	1	f	2025-10-27 11:34:12.202781	2025-12-31 04:01:35.027
16	7076.80	1	f	2025-12-31 04:01:22.337243	2025-12-31 04:01:35.027
17	6783.54	1	t	2025-12-31 04:01:35.533799	2025-12-31 04:01:35.533799
\.


--
-- TOC entry 3736 (class 0 OID 409601)
-- Dependencies: 270
-- Data for Name: hero_slider_config; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.hero_slider_config (id, is_enabled, auto_play_interval, transition_duration, transition_effect, show_controls, show_dots, pause_on_hover, updated_by, updated_at) FROM stdin;
1	t	5000	200	slide	t	t	f	1	2025-11-02 19:05:18.159
\.


--
-- TOC entry 3734 (class 0 OID 393217)
-- Dependencies: 268
-- Data for Name: hero_slides; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.hero_slides (id, title, subtitle, description, image_url, button_text, button_link, display_order, is_active, created_at, updated_at, background_color, media_type, background_color_opacity) FROM stdin;
1	SoftwarePar: Tu Partner Tecnológico en Paraguay	Desarrollo de Software a Medida en Paraguay	Somos la empresa paraguaya líder en desarrollo de software a medida, apps web y móviles, y facturación electrónica SIFEN. Con más de 50 proyectos completados y soporte 24/7, transformamos las ideas de empresas paraguayas en soluciones tecnológicas exitosas.	https://images.donweb.com/img/crear-sitio-web/sitiosimple-header-bg.mp4	Cotización Gratuita	#contacto	1	t	2025-10-31 20:30:00.769934	2025-12-31 03:59:28.211	#0055ff	video	1
3	SoftwarePar: Tu Partner Tecnológico en Paraguay 2	Desarrollo de Software a Medida en Paraguay	Somos la empresa paraguaya líder en desarrollo de software a medida, apps web y móviles, y facturación electrónica SIFEN. Con más de 50 proyectos completados y soporte 24/7, transformamos las ideas de empresas paraguayas en soluciones tecnológicas exitosas.	https://images.donweb.com/img/crear-sitio-web/sitiosimple-home-explicativo.mp4	Cotización Gratuita	#contacto	3	f	2025-12-31 03:57:07.455565	2025-12-31 19:37:55.187	#3b82f6	video	100
\.


--
-- TOC entry 3688 (class 0 OID 24591)
-- Dependencies: 222
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.invoices (id, invoice_number, project_id, client_id, amount, status, due_date, paid_date, description, tax_amount, discount_amount, total_amount, payment_method_id, notes, created_at, updated_at, currency, payment_stage_id, exchange_rate_used, sifen_cdc, sifen_protocolo, sifen_estado, sifen_xml, sifen_fecha_envio, sifen_mensaje_error, sifen_qr, client_snapshot_type, client_snapshot_legal_name, client_snapshot_document_type, client_snapshot_document_number, client_snapshot_address, client_snapshot_city, client_snapshot_department, client_snapshot_country, client_snapshot_email, client_snapshot_phone, issue_date_snapshot, issue_date_time_snapshot) FROM stdin;
106	001-001-0000042	46	2	37.50	paid	2026-01-03 04:14:15.753	2026-01-03 04:14:15.753	\N	0.00	0.00	37.50	\N	\N	2026-01-03 04:14:15.829005	2026-01-03 04:14:28.821	USD	153	6783.54	01042200580001001000004212026010317413656714	\N	aceptado	\N	2026-01-03 04:14:17.357	Documento procesado	https://ekuatia.set.gov.py/consultas-test/qr?nVersion=150&Id=01042200580001001000004212026010317413656714&dFeEmiDE=323032362d30312d30335430343a31343a3136&dNumIDRec=94499982&dTotGralOpe=0&dTotIVA=0&cItems=1&DigestValue=53577235574a4857584e4d51473065454a754b34496b476938676e78545a4b4431627468487a6e3032654d3d&IdCSC=0001&cHashQR=5e5b0648dd7ac65a903b34f5a402da7673546d727f0b9f503d415e819da86687	extranjero	David Maidana	Documento_Extranjero	94499982	La Madreselva 4508	Buenos Aires (Capital)	Buenos Aires	Argentina	alfagroupstoreok@gmail.com	1170624214	3/1/2026	03/01/2026, 04:14
104	001-001-0000040	46	2	37.50	paid	2026-01-03 04:00:15.315	2026-01-03 04:00:15.315	\N	0.00	0.00	37.50	\N	\N	2026-01-03 04:00:15.388935	2026-01-03 04:00:36.73	USD	151	6783.54	01042200580001001000004012026010317412816386	\N	aceptado	\N	2026-01-03 04:00:17.044	Documento procesado	https://ekuatia.set.gov.py/consultas-test/qr?nVersion=150&Id=01042200580001001000004012026010317412816386&dFeEmiDE=323032362d30312d30335430343a30303a3136&dRucRec=80000000&dTotGralOpe=0&dTotIVA=0&cItems=1&DigestValue=7458474f6d5657456a656a4763627a326159514b75752b3347774669722f4a58715a4561747548526949383d&IdCSC=0001&cHashQR=1a89b5209b58b5959efb95fe5c2d64aab4d9923bfa7bee944f3a64c5fbc8933b	empresa	ALFA GROUP STORE	RUC	80000000-1	Barrio Residencial – Carlos A. López – Itapúa	Carlos Antonio López	Itapúa	Paraguay	alfagroupstoreok@gmail.com	+595985990044	3/1/2026	03/01/2026, 04:00
107	001-001-0000043	46	2	37.50	paid	2026-01-03 04:22:56.225	2026-01-03 04:22:56.225	\N	0.00	0.00	37.50	\N	\N	2026-01-03 04:22:56.29813	2026-01-03 04:23:09.469	USD	154	6783.54	01042200580001001000004312026010317414177135	\N	aceptado	\N	2026-01-03 04:22:57.752	Documento procesado	https://ekuatia.set.gov.py/consultas-test/qr?nVersion=150&Id=01042200580001001000004312026010317414177135&dFeEmiDE=323032362d30312d30335430343a32323a3537&dNumIDRec=94499982&dTotGralOpe=0&dTotIVA=0&cItems=1&DigestValue=364c57526f5559395573625263595263562f67383534554c44396b2f714a502f346c4833316555333469633d&IdCSC=0001&cHashQR=1438fb8c6e1bfe263721238ea5c99cff5d401fbf3e502f9d59ae569c95049e20	extranjero	David Maidana	Documento_Extranjero	94499982	La Madreselva 4508	Buenos Aires (Capital)	Buenos Aires	Argentina	alfagroupstoreok@gmail.com	1170624214	3/1/2026	03/01/2026, 04:23
105	001-001-0000041	46	2	37.50	paid	2026-01-03 04:10:46.014	2026-01-03 04:10:46.014	\N	0.00	0.00	37.50	\N	\N	2026-01-03 04:10:46.087477	2026-01-03 04:11:01.988	USD	152	6783.54	01042200580001001000004112026010317413446663	\N	aceptado	\N	2026-01-03 04:10:47.264	Documento procesado	https://ekuatia.set.gov.py/consultas-test/qr?nVersion=150&Id=01042200580001001000004112026010317413446663&dFeEmiDE=323032362d30312d30335430343a31303a3436&dNumIDRec=94499982&dTotGralOpe=0&dTotIVA=0&cItems=1&DigestValue=75514778707878586d4d636f564c6f4a66734d644f7a355642686d6539466f6f63655a6b2f564f4b7635383d&IdCSC=0001&cHashQR=c8d5b5a487c095fde9222fa8ac9c199e7f4a7b2205a9b19acf0556571ece73d3	consumidor_final	david maidana	Documento_Extranjero	94499982	la madeselva 4508	Buenos Aires (Capital)	Buenos Aires	Argentina	alfagroupstoreok@gmail.com	+595985990044	3/1/2026	03/01/2026, 04:11
\.


--
-- TOC entry 3732 (class 0 OID 311297)
-- Dependencies: 266
-- Data for Name: legal_pages; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.legal_pages (id, page_type, title, content, last_updated_by, is_active, created_at, updated_at) FROM stdin;
2	privacy	Política de Privacidad	<h1>Política de Privacidad</h1>\n<p><strong>Última actualización:</strong> Octubre 2025</p>\n\n<h2>1. Información que recopilamos</h2>\n<h3>1.1 Información personal</h3>\n<ul>\n  <li>Nombre completo y datos de contacto</li>\n  <li>Dirección de correo electrónico</li>\n  <li>Número de teléfono</li>\n  <li>Información de facturación (RUC, dirección)</li>\n  <li>Datos de empresa o negocio (si aplica)</li>\n</ul>\n\n<h3>1.2 Información técnica</h3>\n<ul>\n  <li>Dirección IP, tipo de dispositivo y navegador</li>\n  <li>Datos de uso y navegación en la plataforma</li>\n  <li>Cookies y tecnologías similares</li>\n  <li>Registros de actividad y seguridad del sistema</li>\n</ul>\n\n<h2>2. Cómo utilizamos la información</h2>\n<ul>\n  <li>Prestar y mejorar nuestros servicios digitales</li>\n  <li>Procesar pagos y emitir facturación electrónica conforme a la SET (Paraguay)</li>\n  <li>Comunicarnos contigo sobre proyectos, soporte o actualizaciones</li>\n  <li>Cumplir con obligaciones legales, fiscales y de seguridad informática</li>\n  <li>Personalizar tu experiencia en el sitio y panel del cliente</li>\n</ul>\n\n<h2>3. Compartir información</h2>\n<p>No vendemos ni transferimos tu información personal. Podemos compartir datos solo en los siguientes casos:</p>\n<ul>\n  <li>Con proveedores de servicios tecnológicos confiables (hosting, pasarelas de pago, facturación electrónica)</li>\n  <li>Cuando lo requiera la ley o una autoridad competente</li>\n  <li>Para proteger los derechos o seguridad de SoftwarePar y sus usuarios</li>\n  <li>Con tu consentimiento expreso</li>\n</ul>\n\n<h2>4. Seguridad de datos</h2>\n<ul>\n  <li>Cifrado SSL/TLS en todas las transmisiones</li>\n  <li>Servidores seguros con acceso restringido</li>\n  <li>Copias de seguridad y monitoreo continuo</li>\n  <li>Autenticación segura en el panel del cliente</li>\n</ul>\n\n<h2>5. Cookies y tecnologías similares</h2>\n<p>Usamos cookies para optimizar tu experiencia:</p>\n<ul>\n  <li><strong>Esenciales:</strong> necesarias para el funcionamiento del sitio</li>\n  <li><strong>Preferencias:</strong> guardan configuraciones del usuario</li>\n  <li><strong>Analíticas:</strong> ayudan a mejorar el rendimiento del sitio</li>\n  <li><strong>Marketing:</strong> permiten mostrar contenido relevante (no obligatorio)</li>\n</ul>\n\n<h2>6. Tus derechos</h2>\n<p>Podés solicitar en cualquier momento:</p>\n<ul>\n  <li>Acceso a tus datos personales</li>\n  <li>Corrección o actualización de la información</li>\n  <li>Eliminación de tu cuenta o datos personales</li>\n  <li>Restricción o retiro del consentimiento para tratamiento de datos</li>\n</ul>\n\n<h2>7. Retención de datos</h2>\n<p>Conservamos los datos únicamente durante el tiempo necesario para los fines descritos o según las normas fiscales paraguayas.</p>\n\n<h2>8. Transferencias internacionales</h2>\n<p>Algunos servicios pueden utilizar servidores ubicados fuera de Paraguay. Nos aseguramos de que cumplan con estándares adecuados de protección de datos.</p>\n\n<h2>9. Usuarios menores de edad</h2>\n<p>Nuestros servicios están dirigidos a mayores de 18 años. No recopilamos intencionalmente información de menores sin consentimiento verificable de los padres o tutores.</p>\n\n<h2>10. Cambios en la política</h2>\n<p>Podemos modificar esta política para reflejar cambios legales o técnicos. Las actualizaciones se publicarán en este mismo apartado con la nueva fecha de vigencia.</p>\n\n<h2>11. Contacto</h2>\n<p>Para consultas o solicitudes relacionadas con privacidad:</p>\n<p>\n📧 <strong>Email:</strong> softwarepar.lat@gmail.com<br>\n📞 <strong>Teléfono:</strong> +595 985 990 046<br>\n📍 <strong>Dirección:</strong> Barrio Residencial – Carlos Antonio López – Itapúa – Paraguay\n</p>\n\n<p><em>Esta política cumple con la normativa vigente de protección de datos personales y obligaciones fiscales según las leyes de la República del Paraguay.</em></p>\n	1	t	2025-10-17 02:38:39.302516	2025-10-17 03:17:14.547
1	terms	Términos y Condiciones de Servicio	<h1>Términos y Condiciones de Servicio</h1>\n<p><strong>Última actualización:</strong> Octubre 2025</p>\n\n<h2>1. Aceptación de los Términos</h2>\n<p>Al contratar o utilizar los servicios de <strong>SoftwarePar</strong>, el usuario acepta estos Términos y Condiciones, así como las políticas complementarias publicadas en el sitio web.</p>\n\n<h2>2. Descripción del Servicio</h2>\n<p>SoftwarePar ofrece soluciones tecnológicas y de desarrollo digital, incluyendo:</p>\n<ul>\n  <li>Desarrollo de sitios web y sistemas administrativos</li>\n  <li>Diseño y mantenimiento de plataformas online</li>\n  <li>Servicios de hosting, dominios y soporte técnico</li>\n  <li>Facturación electrónica y automatización de procesos</li>\n</ul>\n\n<h2>3. Modalidades de Trabajo</h2>\n<h3>3.1 Desarrollo Personalizado</h3>\n<p>El cliente contrata el desarrollo de un sistema, aplicación o sitio web adaptado a sus necesidades. Incluye entrega de código, acceso al panel de administración y soporte según plan.</p>\n\n<h3>3.2 Mantenimiento y Soporte</h3>\n<p>SoftwarePar ofrece planes de mantenimiento técnico, actualizaciones de seguridad y asistencia remota para proyectos ya implementados.</p>\n\n<h2>4. Pagos y Facturación</h2>\n<ul>\n  <li>Los pagos se realizan en guaraníes (PYG) o dólares estadounidenses (USD) según el tipo de cambio vigente.</li>\n  <li>Métodos aceptados: Mango, Ueno, Banco Solar, transferencia o efectivo.</li>\n  <li>Se emite <strong>Boleta RESIMPLE o Factura Electrónica</strong> conforme a la normativa de la <strong>SET Paraguay</strong>.</li>\n  <li>Los precios publicados no incluyen servicios de terceros (hosting, dominio, etc.) salvo que se indique lo contrario.</li>\n  <li>Los pagos deben completarse antes de la entrega final del proyecto o activación del servicio.</li>\n</ul>\n\n<h2>5. Propiedad Intelectual</h2>\n<ul>\n  <li>En proyectos personalizados, el cliente obtiene los derechos de uso del sistema entregado.</li>\n  <li>SoftwarePar mantiene la titularidad del código fuente y componentes reutilizables del sistema base.</li>\n  <li>El cliente no podrá revender ni redistribuir el software sin autorización escrita.</li>\n</ul>\n\n<h2>6. Garantías y Soporte</h2>\n<ul>\n  <li>Todos los proyectos incluyen <strong>6 meses de garantía técnica</strong> por errores o fallas atribuibles al desarrollo.</li>\n  <li>Incluye actualizaciones de seguridad menores y soporte remoto.</li>\n  <li>Cambios funcionales o rediseños no forman parte de la garantía.</li>\n</ul>\n\n<h2>7. Limitación de Responsabilidad</h2>\n<p>SoftwarePar no será responsable por:</p>\n<ul>\n  <li>Daños indirectos, pérdida de datos o interrupciones causadas por terceros (hosting, DNS, proveedores externos).</li>\n  <li>Fallos derivados de configuraciones modificadas por el cliente.</li>\n  <li>Retrasos debidos a causas de fuerza mayor.</li>\n</ul>\n\n<h2>8. Modificaciones del Servicio</h2>\n<p>SoftwarePar puede actualizar, mejorar o interrumpir temporalmente servicios por mantenimiento o razones técnicas. Los cambios sustanciales serán notificados al cliente con anticipación razonable.</p>\n\n<h2>9. Privacidad y Protección de Datos</h2>\n<p>El tratamiento de los datos personales del cliente se realiza conforme a nuestra <a href="/privacidad">Política de Privacidad vigente</a>.</p>\n\n<h2>10. Contacto</h2>\n<p>\n📧 <strong>Email:</strong> softwarepar.lat@gmail.com<br>\n📞 <strong>Teléfono:</strong> +595 985 990 046<br>\n📍 <strong>Dirección:</strong> Barrio Residencial – Carlos Antonio López – Itapúa – Paraguay\n</p>\n\n<p><em>Estos términos se ajustan a la normativa comercial y tributaria vigente de la República del Paraguay.</em></p>\n	1	t	2025-10-17 02:38:39.302516	2025-10-17 03:17:24.728
3	cookies	Política de Cookies	<h1>Política de Cookies</h1>\n<p><strong>Última actualización:</strong> Octubre 2025</p>\n\n<h2>1. ¿Qué son las cookies?</h2>\n<p>Las cookies son pequeños archivos de texto que se almacenan en tu dispositivo cuando visitás un sitio web. Sirven para recordar tus preferencias, mejorar tu experiencia de navegación y recopilar información anónima sobre cómo se usa el sitio.</p>\n\n<h2>2. ¿Qué tipos de cookies utilizamos?</h2>\n\n<h3>a) Cookies esenciales</h3>\n<p>Necesarias para el funcionamiento básico del sitio y el acceso a funciones seguras (por ejemplo, inicio de sesión en el panel de clientes o procesamiento de pagos).</p>\n\n<h3>b) Cookies de preferencias</h3>\n<p>Permiten recordar configuraciones, idioma y personalizaciones del usuario.</p>\n\n<h3>c) Cookies analíticas</h3>\n<p>Nos ayudan a entender cómo los visitantes usan el sitio (por ejemplo, páginas más vistas, duración de la visita). Estas cookies son anónimas y se usan para mejorar el rendimiento general del sitio.</p>\n\n<h3>d) Cookies de marketing</h3>\n<p>Podrían emplearse para mostrar anuncios o promociones relevantes en función de tus intereses (solo si aceptás su uso).</p>\n\n<h2>3. ¿Por qué usamos cookies?</h2>\n<ul>\n  <li>Garantizar el funcionamiento técnico del sitio web</li>\n  <li>Recordar tus preferencias de usuario</li>\n  <li>Analizar el tráfico y rendimiento del sitio</li>\n  <li>Mejorar la seguridad y la experiencia del usuario</li>\n</ul>\n<p>No usamos cookies para almacenar información sensible como contraseñas, datos financieros o personales.</p>\n\n<h2>4. Gestión y control de cookies</h2>\n<p>Podés configurar tu navegador para aceptar, rechazar o eliminar cookies en cualquier momento. Tené en cuenta que desactivar las cookies esenciales puede afectar el funcionamiento de algunas partes del sitio.</p>\n\n<p><strong>Guías útiles:</strong></p>\n<ul>\n  <li><a href="https://support.google.com/chrome/answer/95647" target="_blank">Google Chrome</a></li>\n  <li><a href="https://support.mozilla.org/es/kb/Deshabilitar%20cookies%20de%20sitios%20web" target="_blank">Mozilla Firefox</a></li>\n  <li><a href="https://support.microsoft.com/es-es/microsoft-edge/eliminar-cookies-en-microsoft-edge-63947406-40ac-c3b8-57b9-2a946a29ae09" target="_blank">Microsoft Edge</a></li>\n  <li><a href="https://support.apple.com/es-es/guide/safari/sfri11471/mac" target="_blank">Safari</a></li>\n</ul>\n\n<h2>5. Consentimiento</h2>\n<p>Al continuar navegando en nuestro sitio, se asume que aceptás el uso de cookies según los términos de esta política. Si preferís no aceptar ciertas cookies, podés configurarlas a través del banner de consentimiento o desde la configuración de tu navegador.</p>\n\n<h2>6. Cambios en esta política</h2>\n<p>Podemos actualizar esta Política de Cookies ocasionalmente para reflejar cambios técnicos o normativos. La fecha de actualización se indicará siempre al inicio del documento.</p>\n\n<h2>7. Contacto</h2>\n<p>Si tenés dudas sobre esta política o el uso de cookies en nuestro sitio, podés contactarnos en:</p>\n<p>\n📧 <strong>Email:</strong> softwarepar.lat@gmail.com<br>\n📞 <strong>Teléfono:</strong> +595 985 990 046<br>\n📍 <strong>Dirección:</strong> Barrio Residencial – Carlos Antonio López – Itapúa – Paraguay\n</p>\n\n<p><em>Esta política se aplica conforme a las normas de protección de datos y privacidad vigentes en la República del Paraguay.</em></p>\n	\N	t	2025-10-17 02:38:39.302516	2025-10-17 02:38:39.302516
\.


--
-- TOC entry 3690 (class 0 OID 24611)
-- Dependencies: 224
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.notifications (id, user_id, title, message, type, is_read, created_at) FROM stdin;
1	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 15:22:27.801728
2	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 15:22:29.29057
3	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 16:04:59.1094
4	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 16:05:01.06248
5	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 16:14:07.278636
6	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 16:14:08.456755
7	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Proyecto de Prueba - Notificaciones"	info	f	2025-09-29 16:22:56.985883
8	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Proyecto de Prueba - Notificaciones" ha sido creado y está siendo revisado	success	f	2025-09-29 16:22:58.619185
9	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Proyecto de Prueba - Notificaciones"	info	f	2025-09-29 16:24:24.385947
10	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Proyecto de Prueba - Notificaciones" ha sido creado y está siendo revisado	success	f	2025-09-29 16:24:26.024409
11	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $250	warning	f	2025-09-29 16:28:03.27255
12	1	💬 Nuevo Mensaje	Cliente te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-29 16:29:04.202682
13	2	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-29 16:29:19.050779
14	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango. Comprobante adjunto: photo-1621607512214-68297480165e.jpg. Requiere verificación.	warning	f	2025-09-29 16:33:02.920794
15	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-29 16:34:28.86734
16	1	🚀 Nuevo Proyecto Creado	Cliente de Prueba ha creado el proyecto "Proyecto de Prueba Email - 2025-09-29T17:04:14.890Z"	info	f	2025-09-29 17:04:15.495878
19	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-09-29T17:04:14.890Z" actualizado: Estado cambiado a: En Progreso - Progreso actualizado a 25%	info	f	2025-09-29 17:04:22.801791
20	1	🎫 Nuevo Ticket de Soporte	Cliente de Prueba ha creado el ticket: "Ticket de Prueba - Consulta sobre el proyecto"	warning	f	2025-09-29 17:04:28.837308
21	1	💬 Nuevo Mensaje	Cliente de Prueba te ha enviado un mensaje en "Proyecto de Prueba Email - 2025-09-29T17:04:14.890Z"	info	f	2025-09-29 17:04:30.854736
23	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-09-29T17:04:14.890Z" actualizado: Estado cambiado a: Completado - Progreso actualizado a 100%	info	f	2025-09-29 17:04:32.768153
24	1	🚀 Nuevo Proyecto Creado	Cliente de Prueba ha creado el proyecto "Proyecto de Prueba Email - 2025-09-29T20:59:55.385Z"	info	f	2025-09-29 20:59:56.078026
27	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-09-29T20:59:55.385Z" actualizado: Estado cambiado a: En Progreso - Progreso actualizado a 25%	info	f	2025-09-29 21:00:02.64845
28	1	🎫 Nuevo Ticket de Soporte	Cliente de Prueba ha creado el ticket: "Ticket de Prueba - Consulta sobre el proyecto"	warning	f	2025-09-29 21:00:06.457302
29	1	💬 Nuevo Mensaje	Cliente de Prueba te ha enviado un mensaje en "Proyecto de Prueba Email - 2025-09-29T20:59:55.385Z"	info	f	2025-09-29 21:00:07.901123
31	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-09-29T20:59:55.385Z" actualizado: Estado cambiado a: Completado - Progreso actualizado a 100%	info	f	2025-09-29 21:00:09.697936
32	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "test"	info	f	2025-09-29 21:23:40.922568
33	2	✅ Proyecto Creado Exitosamente	Tu proyecto "test" ha sido creado y está siendo revisado	success	f	2025-09-29 21:23:45.226111
34	2	💵 Contraoferta Recibida	Proyecto "test": Precio propuesto $275	warning	f	2025-09-29 21:25:29.630751
35	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 21:34:03.102939
36	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 21:34:07.469534
37	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $350	warning	f	2025-09-29 21:35:52.647467
38	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 21:43:09.483022
39	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 21:43:11.43281
40	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $425	warning	f	2025-09-29 21:44:44.354683
41	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango. Comprobante adjunto: photo-1621607512214-68297480165e.jpg. Requiere verificación.	warning	f	2025-09-29 21:48:39.830617
42	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-29 21:51:05.529997
43	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 22:15:36.111101
44	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 22:15:38.218791
45	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $300	warning	f	2025-09-29 22:16:16.453416
46	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 22:19:55.443582
47	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 22:19:58.822728
48	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $175	warning	f	2025-09-29 22:20:41.491543
49	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango. Comprobante adjunto: solar.png. Requiere verificación.	warning	f	2025-09-29 22:23:25.064449
50	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-29 22:24:37.558769
51	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-30 00:48:24.046749
52	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-30 00:48:27.403274
53	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $350	warning	f	2025-09-30 00:49:41.279789
54	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-09-30 01:17:59.337382
55	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-30 01:30:01.574974
56	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-30 15:27:12.173577
57	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-30 15:27:14.82863
58	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $300	warning	f	2025-09-30 15:28:35.512127
59	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante adjunto: web.png. Requiere verificación.	warning	f	2025-09-30 16:06:23.188881
60	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-30 16:07:58.839348
61	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Comprobante adjunto: SoftwarePar_Boleta_RESIMPLE_INV-STAGE-11-21.pdf. Requiere verificación.	warning	f	2025-10-01 00:13:01.768413
62	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-01 00:15:33.059709
63	2	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-10-01 00:29:04.839846
64	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-11 22:15:24.853925
65	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-11 22:15:29.904124
66	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante adjunto: mango.png. Requiere verificación.	warning	f	2025-10-11 22:17:58.148412
67	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-11 22:19:23.045109
68	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-11 23:05:38.496069
69	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-11 23:05:43.270383
70	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante adjunto: vaquita.png. Requiere verificación.	warning	f	2025-10-11 23:08:03.911822
71	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-11 23:09:13.746072
72	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-11 23:15:06.06969
73	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-11 23:15:10.911339
74	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-11 23:15:55.242363
75	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-11 23:16:33.097658
76	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-13 13:18:33.17086
77	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-13 13:18:35.681804
78	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Comprobante adjunto: test.pdf. Requiere verificación.	warning	f	2025-10-13 13:21:03.728985
79	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 13:21:50.284589
80	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Comprobante adjunto: SoftwarePar_Boleta_RESIMPLE_INV-STAGE-13-29.pdf. Requiere verificación.	warning	f	2025-10-13 13:32:25.751135
81	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 13:34:11.315857
82	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Comprobante adjunto: SoftwarePar_Boleta_RESIMPLE_INV-STAGE-13-29 (5).pdf. Requiere verificación.	warning	f	2025-10-13 13:38:26.616232
83	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 13:39:42.471936
84	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Comprobante adjunto: SoftwarePar_Boleta_STAGE-37.pdf. Requiere verificación.	warning	f	2025-10-13 13:45:44.036969
85	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 13:46:47.27615
86	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-13 13:51:58.592275
87	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-13 13:52:02.393137
88	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante adjunto: SoftwarePar_Boleta_RESIMPLE_INV-STAGE-12-26.pdf. Requiere verificación.	warning	f	2025-10-13 13:53:17.853019
89	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 13:53:48.471558
169	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-16 22:12:21.652321
90	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Comprobante adjunto: test.pdf. Requiere verificación.	warning	f	2025-10-13 14:04:37.526987
91	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 14:04:58.61289
92	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 14:11:40.573681
93	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 14:12:03.657864
94	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 14:21:56.228171
95	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 14:22:15.22891
96	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-13 18:44:13.136684
97	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-13 18:44:15.335464
98	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 18:45:22.640981
99	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 18:45:36.825278
100	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 18:53:45.920305
101	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 18:54:09.997894
102	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 21:01:20.212056
103	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 21:01:40.806027
104	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 21:10:01.525454
105	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 21:10:39.626911
106	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgranded"	info	f	2025-10-13 21:14:23.407293
107	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgranded" ha sido creado y está siendo revisado	success	f	2025-10-13 21:14:26.069294
108	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 21:15:23.790188
109	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 21:23:54.035635
110	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 22:37:38.239067
111	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 22:38:17.166068
112	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 22:41:50.8051
113	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 22:41:56.191719
114	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 22:42:20.807783
115	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 22:49:06.627952
116	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 22:49:34.518232
117	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-14 09:07:00.593906
118	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-14 09:07:04.343869
119	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:07:47.377102
120	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:08:13.046894
121	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:11:42.117195
122	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:12:03.469593
123	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:19:25.206562
124	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:19:54.599331
125	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:26:12.806799
126	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:26:34.848457
127	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-14 09:33:55.082564
128	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-14 09:33:57.948028
170	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-16 22:12:24.593247
129	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:34:39.165296
130	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:34:57.818171
131	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:40:36.797084
132	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:40:56.518825
133	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 10:48:36.181802
134	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 10:49:03.528791
135	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 10:53:03.195423
136	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 10:53:26.113745
137	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-14 11:06:14.867751
138	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-14 11:06:17.302926
139	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 11:06:52.686205
140	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 11:07:24.509935
141	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-14 11:19:07.088084
142	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-14 11:19:09.54806
143	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 11:20:10.606717
144	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 11:20:28.441181
145	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 11:43:53.708622
146	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 11:44:21.97128
147	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 11:55:50.091502
148	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 11:56:14.119634
149	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 12:09:01.301016
150	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 12:09:18.209609
151	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-14 12:21:10.844266
152	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-14 12:21:13.238308
153	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 12:22:30.130968
154	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 12:22:43.440597
155	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 12:57:38.263555
156	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 12:58:00.880166
157	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 13:05:18.542601
158	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 13:05:51.25104
159	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-15 12:00:53.369798
160	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-15 12:01:42.894931
161	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-15 12:10:19.113086
162	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-15 12:10:21.279803
163	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-15 12:13:55.158073
164	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-15 12:14:27.372555
165	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-15 14:18:58.394766
166	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-15 14:19:31.974644
167	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-15 14:23:13.807737
168	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-15 14:48:19.218459
171	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-16 22:27:33.797048
172	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-16 22:27:37.180992
173	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-16 22:28:52.637902
174	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-16 22:31:54.19637
175	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-16 22:31:56.718905
176	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-16 22:33:26.400542
177	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-16 22:34:01.098872
178	1	💬 Nuevo Mensaje	Cliente te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-10-16 22:46:10.876792
179	2	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-10-16 22:46:21.595433
180	2	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-10-16 22:46:47.330548
181	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-16 23:29:51.174725
182	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-16 23:30:48.886559
183	1	🚀 Nuevo Proyecto Creado	Cliente de Prueba ha creado el proyecto "Proyecto de Prueba Email - 2025-10-17T03:00:53.810Z"	info	f	2025-10-17 03:00:54.472916
186	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-10-17T03:00:53.810Z" actualizado: Estado cambiado a: En Progreso - Progreso actualizado a 25%	info	f	2025-10-17 03:00:58.588019
187	1	🎫 Nuevo Ticket de Soporte	Cliente de Prueba ha creado el ticket: "Ticket de Prueba - Consulta sobre el proyecto"	warning	f	2025-10-17 03:01:00.950191
188	1	💬 Nuevo Mensaje	Cliente de Prueba te ha enviado un mensaje en "Proyecto de Prueba Email - 2025-10-17T03:00:53.810Z"	info	f	2025-10-17 03:01:02.26791
190	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-10-17T03:00:53.810Z" actualizado: Estado cambiado a: Completado - Progreso actualizado a 100%	info	f	2025-10-17 03:01:04.266813
191	1	📋 Payment Proof Received	Client Cliente submitted payment proof for "Pre-entrega - 90% Completado" via Ueno Bank. No attachment. Requires verification.	warning	f	2025-10-17 05:01:39.218358
192	2	✅ Payment Approved	Your payment for the stage "Pre-entrega - 90% Completado" has been verified and approved. We are continuing with development!	success	f	2025-10-17 05:02:05.468301
193	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-17 12:58:12.508806
194	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-17 12:58:14.026887
195	2	💵 Contraoferta Recibida	Proyecto "Barbershop": Precio propuesto $200	warning	f	2025-10-17 13:03:07.721253
196	1	📋 Payment Proof Received	Client Cliente submitted payment proof for "Anticipo - Inicio del Proyecto" via Ueno Bank. No attachment. Requires verification.	warning	f	2025-10-17 13:05:23.275704
197	2	✅ Payment Approved	Your payment for the stage "Anticipo - Inicio del Proyecto" has been verified and approved. We are continuing with development!	success	f	2025-10-17 13:05:54.710813
198	1	📋 Payment Proof Received	Client Cliente submitted payment proof for "Avance 50% - Desarrollo" via Ueno Bank. No attachment. Requires verification.	warning	f	2025-10-17 14:30:09.785083
199	2	✅ Payment Approved	Your payment for the stage "Avance 50% - Desarrollo" has been verified and approved. We are continuing with development!	success	f	2025-10-17 14:31:05.093631
200	1	📋 Payment Proof Received	Client Cliente submitted payment proof for "Pre-entrega - 90% Completado" via Ueno Bank. No attachment. Requires verification.	warning	f	2025-10-17 14:38:07.872808
201	2	✅ Payment Approved	Your payment for the stage "Pre-entrega - 90% Completado" has been verified and approved. We are continuing with development!	success	f	2025-10-17 14:38:43.677333
202	1	📋 Payment Proof Received	Client Cliente submitted payment proof for "Entrega Final" via Mango (TU FINANCIERA). No attachment. Requires verification.	warning	f	2025-10-17 15:00:46.736088
203	2	✅ Payment Approved	Your payment for the stage "Entrega Final" has been verified and approved. We are continuing with development!	success	f	2025-10-17 15:01:33.991686
204	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-17 16:18:28.453639
205	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-17 16:18:30.532049
206	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $175	warning	f	2025-10-17 16:20:30.856278
207	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-18 15:29:29.20048
208	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-18 15:33:58.779144
209	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbería "	info	f	2025-10-22 14:43:52.852439
210	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbería " ha sido creado y está siendo revisado	success	f	2025-10-22 14:43:55.022811
211	2	💵 Contraoferta Recibida	Proyecto "Barbería ": Precio propuesto $200	warning	f	2025-10-22 14:50:20.713927
212	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante: Comprobante-Vaquita (1).pdf. Requiere verificación.	warning	f	2025-10-22 14:55:53.806691
213	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-22 16:15:17.566203
214	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "Barbershop"	info	f	2025-10-22 18:47:47.218983
215	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-22 18:47:49.620905
216	2	💵 Contraoferta Recibida	Proyecto "Barbershop": Precio propuesto $200.00 USD (₲1.420.000 PYG)	warning	f	2025-10-22 18:48:54.93034
217	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "FrigoMgrande"	info	f	2025-10-22 19:04:11.796945
218	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-22 19:04:13.43204
219	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante: test.jpg. Requiere verificación.	warning	f	2025-10-22 19:06:10.13834
220	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-22 19:06:52.919373
221	2	💰 Pago Disponible	Nueva etapa de pago disponible: Avance 50% - Desarrollo - $25.00 USD (₲177.500 PYG)	success	f	2025-10-22 19:07:37.475026
222	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Comprobante: 960px-Flag_of_the_United_States_(Pantone).svg.png. Requiere verificación.	warning	f	2025-10-22 19:08:43.662387
223	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-22 19:09:14.498336
224	2	💰 Pago Disponible	Nueva etapa de pago disponible: Pre-entrega - 90% Completado - $25.00 USD (₲177.500 PYG)	success	f	2025-10-22 19:09:46.231631
225	2	💰 Pago Disponible	Nueva etapa de pago disponible: Entrega Final - $25.00 USD (₲177.500 PYG)	success	f	2025-10-22 19:11:39.95531
226	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "Barbershop"	info	f	2025-10-22 19:15:56.414961
227	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-22 19:15:58.861631
228	2	💵 Contraoferta Recibida	Proyecto "Barbershop": Precio propuesto $200.00 USD (₲1.420.000 PYG)	warning	f	2025-10-22 19:16:58.026977
229	2	💵 Contraoferta Recibida	Proyecto "Barbershop": Precio propuesto $175.00 USD (₲1.242.500 PYG)	warning	f	2025-10-22 19:19:06.883685
230	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "FrigoMgrande"	info	f	2025-10-22 19:29:46.940133
231	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-22 19:29:48.796019
232	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $150.00 USD (₲1.065.000 PYG)	warning	f	2025-10-22 19:31:28.696694
233	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante: Imagen de WhatsApp 2025-10-06 a las 10.02.43_bda3beac.jpg. Requiere verificación.	warning	f	2025-10-22 19:34:42.469397
234	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-22 19:35:16.810651
235	2	💰 Pago Disponible	Nueva etapa de pago disponible: Avance 50% - Desarrollo - $31.25	success	f	2025-10-22 19:38:58.240084
236	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Comprobante: Imagen de WhatsApp 2025-10-06 a las 10.02.43_bda3beac.jpg. Requiere verificación.	warning	f	2025-10-22 19:40:00.408572
237	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-22 19:40:53.406968
238	2	💰 Pago Disponible	Nueva etapa de pago disponible: Pre-entrega - 90% Completado - $31.25	success	f	2025-10-22 19:42:51.913421
239	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Comprobante: Imagen de WhatsApp 2025-10-06 a las 10.02.43_bda3beac.jpg. Requiere verificación.	warning	f	2025-10-22 19:43:25.578197
240	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-22 19:59:38.951733
241	2	💰 Pago Disponible	Nueva etapa de pago disponible: Entrega Final - $31.25	success	f	2025-10-22 20:00:28.579394
242	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Comprobante: ueno.png. Requiere verificación.	warning	f	2025-10-22 20:00:59.673164
243	2	❌ Pago Rechazado	Tu comprobante de pago para "Entrega Final" fue rechazado. Motivo: rechazado bla. Por favor envía un nuevo comprobante.	error	f	2025-10-22 20:08:14.326033
244	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Comprobante: SoftwarePar_Boleta_RESIMPLE_INV-STAGE-11-21.pdf. Requiere verificación.	warning	f	2025-10-22 20:09:33.087019
245	2	❌ Pago Rechazado	Tu comprobante de pago para "Entrega Final" fue rechazado. Motivo: tetxdfdfdfdf. Por favor envía un nuevo comprobante.	error	f	2025-10-23 19:52:33.919503
246	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Comprobante: Imagen de WhatsApp 2025-10-06 a las 10.02.43_bda3beac.jpg. Requiere verificación.	warning	f	2025-10-23 19:58:35.001743
247	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-23 20:06:03.658818
248	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "Barbería"	info	f	2025-10-24 18:50:41.62569
249	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbería" ha sido creado y está siendo revisado	success	f	2025-10-24 18:50:43.948762
250	1	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "Barbería"	info	f	2025-10-27 10:09:52.611876
251	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "FrigoMgrande"	info	f	2025-11-05 22:21:55.371583
252	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-11-05 22:22:01.622633
253	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-12-31 04:23:30.102041
254	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-12-31 04:23:48.099189
255	2	💰 Pago Disponible	Nueva etapa de pago disponible: Avance 50% - Desarrollo - $187.50	success	f	2026-01-01 14:42:10.048292
256	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Comprobante: resuelto.jpg. Requiere verificación.	warning	f	2026-01-01 14:43:27.004528
257	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-01 14:44:25.335746
300	2	💰 Pago Disponible	Nueva etapa de pago disponible: Entrega Final - $87.50	success	f	2026-01-02 08:14:22.769473
258	2	💰 Pago Disponible	Nueva etapa de pago disponible: Pre-entrega - 90% Completado - $187.50	success	f	2026-01-01 15:00:30.83981
259	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Comprobante: file_00000000045871f5921646e89f18d489.png. Requiere verificación.	warning	f	2026-01-01 15:04:25.925415
260	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-01 15:05:35.837852
261	2	💰 Pago Disponible	Nueva etapa de pago disponible: Entrega Final - $187.50	success	f	2026-01-01 18:13:43.776325
262	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-01 18:15:56.579066
263	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-01 18:17:00.51019
264	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "Barbershop"	info	f	2026-01-01 18:38:06.187644
265	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2026-01-01 18:38:10.986823
266	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante: file_00000000f5e471f58cc65cbf50cab070.png. Requiere verificación.	warning	f	2026-01-01 18:40:10.416145
267	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-01 18:40:39.069391
268	2	💰 Pago Disponible	Nueva etapa de pago disponible: Avance 50% - Desarrollo - $75.00	success	f	2026-01-01 18:53:06.468649
269	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Comprobante: file_00000000045871f5921646e89f18d489.png. Requiere verificación.	warning	f	2026-01-01 18:53:45.884261
270	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-01 18:54:46.002673
271	2	💰 Pago Disponible	Nueva etapa de pago disponible: Pre-entrega - 90% Completado - $75.00	success	f	2026-01-01 18:59:54.058339
272	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Comprobante: resuelto.jpg. Requiere verificación.	warning	f	2026-01-01 19:01:28.03976
273	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-01 19:02:14.345443
274	2	💰 Pago Disponible	Nueva etapa de pago disponible: Entrega Final - $75.00	success	f	2026-01-01 19:55:32.079485
275	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Comprobante: file_00000000f5e471f58cc65cbf50cab070.png. Requiere verificación.	warning	f	2026-01-01 19:56:14.679213
276	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-01 19:56:53.07672
277	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "Barbershop"	info	f	2026-01-01 20:17:01.242177
278	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2026-01-01 20:17:04.944275
279	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante: file_00000000f5e471f58cc65cbf50cab070.png. Requiere verificación.	warning	f	2026-01-01 20:17:45.719942
280	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-01 20:18:02.084688
281	2	💰 Pago Disponible	Nueva etapa de pago disponible: Avance 50% - Desarrollo - $87.50	success	f	2026-01-01 21:22:53.864919
282	2	💰 Pago Disponible	Nueva etapa de pago disponible: Pre-entrega - 90% Completado - $87.50	success	f	2026-01-01 21:22:58.368159
283	2	💰 Pago Disponible	Nueva etapa de pago disponible: Entrega Final - $87.50	success	f	2026-01-01 21:23:07.842792
284	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Avance 50% - Desarrollo" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-01 21:25:12.026913
285	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-01 21:25:34.237583
286	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 01:54:07.277169
287	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 01:54:33.018234
288	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 02:02:59.242739
289	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 02:03:11.573487
290	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "FrigoMgrande"	info	f	2026-01-02 02:10:13.293731
291	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2026-01-02 02:10:15.488665
292	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 02:10:59.700771
293	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 02:11:17.531625
294	2	💰 Pago Disponible	Nueva etapa de pago disponible: Avance 50% - Desarrollo - $87.50	success	f	2026-01-02 02:20:00.690211
295	2	💰 Pago Disponible	Nueva etapa de pago disponible: Pre-entrega - 90% Completado - $87.50	success	f	2026-01-02 02:20:05.22803
296	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Avance 50% - Desarrollo" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 02:20:19.190376
297	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 02:20:32.651557
298	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 07:59:50.494547
299	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 08:01:03.435903
301	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 08:14:44.300793
302	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 08:15:12.03021
303	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "Barbershop"	info	f	2026-01-02 08:41:28.742417
304	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2026-01-02 08:41:32.672735
305	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 08:42:16.33465
306	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 08:42:28.624254
307	2	💰 Pago Disponible	Nueva etapa de pago disponible: Avance 50% - Desarrollo - $125.00	success	f	2026-01-02 08:46:05.576921
308	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Avance 50% - Desarrollo" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 08:46:48.097833
309	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 08:47:22.453488
310	2	💰 Pago Disponible	Nueva etapa de pago disponible: Pre-entrega - 90% Completado - $125.00	success	f	2026-01-02 08:50:34.883798
311	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 08:51:00.074038
312	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 08:51:40.522436
313	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "Barbershop"	info	f	2026-01-02 20:28:37.605712
314	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2026-01-02 20:28:40.110022
315	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante: Imagen de WhatsApp 2025-10-06 a las 10.02.43_bda3beac.jpg. Requiere verificación.	warning	f	2026-01-02 20:29:38.153839
316	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 20:29:45.968961
317	2	💰 Pago Disponible	Nueva etapa de pago disponible: Avance 50% - Desarrollo - $125.00	success	f	2026-01-02 20:43:21.331174
318	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Avance 50% - Desarrollo" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 20:43:43.334768
319	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 20:44:17.823066
320	2	💰 Pago Disponible	Nueva etapa de pago disponible: Pre-entrega - 90% Completado - $125.00	success	f	2026-01-02 20:49:49.46758
321	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 20:50:23.393004
322	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 20:50:39.364754
323	2	💰 Pago Disponible	Nueva etapa de pago disponible: Entrega Final - $125.00	success	f	2026-01-02 20:57:14.406019
324	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 20:57:42.803986
325	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 20:57:54.565671
326	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "Barbershop"	info	f	2026-01-02 21:03:32.597389
327	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2026-01-02 21:03:37.001685
328	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-02 21:04:16.080421
329	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-02 21:04:24.598386
330	2	💰 Pago Disponible	Nueva etapa de pago disponible: Avance 50% - Desarrollo - $125.00	success	f	2026-01-03 00:24:59.227256
331	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Comprobante: solar.png. Requiere verificación.	warning	f	2026-01-03 00:25:23.140928
332	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-03 00:26:10.912008
333	2	💰 Pago Disponible	Nueva etapa de pago disponible: Pre-entrega - 90% Completado - $125.00	success	f	2026-01-03 00:36:12.460086
334	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-03 00:36:48.77541
335	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-03 00:37:14.46134
336	2	💰 Pago Disponible	Nueva etapa de pago disponible: Entrega Final - $125.00	success	f	2026-01-03 00:50:06.885617
337	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-03 00:50:28.078128
338	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-03 00:51:03.765005
339	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "Corte Clásicoss"	info	f	2026-01-03 02:55:39.188081
340	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Corte Clásicoss" ha sido creado y está siendo revisado	success	f	2026-01-03 02:55:43.257476
341	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-03 02:56:09.293118
342	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-03 02:56:14.592891
343	2	💰 Pago Disponible	Nueva etapa de pago disponible: Avance 50% - Desarrollo - $87.50	success	f	2026-01-03 03:06:44.761235
344	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Avance 50% - Desarrollo" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-03 03:06:58.098455
345	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-03 03:07:38.849421
346	2	💰 Pago Disponible	Nueva etapa de pago disponible: Pre-entrega - 90% Completado - $87.50	success	f	2026-01-03 03:17:06.176754
347	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-03 03:17:37.43913
348	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-03 03:18:09.971433
349	2	💰 Pago Disponible	Nueva etapa de pago disponible: Entrega Final - $87.50	success	f	2026-01-03 03:31:11.921905
350	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-03 03:31:33.784704
351	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-03 03:31:40.208672
352	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "mantenimiento base de datos"	info	f	2026-01-03 03:59:00.072016
353	2	✅ Proyecto Creado Exitosamente	Tu proyecto "mantenimiento base de datos" ha sido creado y está siendo revisado	success	f	2026-01-03 03:59:06.859593
354	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-03 03:59:57.283855
355	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-03 04:00:10.58677
356	2	💰 Pago Disponible	Nueva etapa de pago disponible: Avance 50% - Desarrollo - $37.50	success	f	2026-01-03 04:09:52.045525
357	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Avance 50% - Desarrollo" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-03 04:10:14.415673
358	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-03 04:10:42.89557
359	2	💰 Pago Disponible	Nueva etapa de pago disponible: Pre-entrega - 90% Completado - $37.50	success	f	2026-01-03 04:13:03.84019
360	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Comprobante: controle-universal-lcd-led-tv-ecopower-ep-8613.jpg. Requiere verificación.	warning	f	2026-01-03 04:13:31.073
361	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-03 04:14:10.995054
362	2	💰 Pago Disponible	Nueva etapa de pago disponible: Entrega Final - $37.50	success	f	2026-01-03 04:22:04.766151
363	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2026-01-03 04:22:25.255222
364	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2026-01-03 04:22:53.304077
\.


--
-- TOC entry 3692 (class 0 OID 24620)
-- Dependencies: 226
-- Data for Name: partners; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.partners (id, user_id, referral_code, commission_rate, total_earnings, created_at) FROM stdin;
\.


--
-- TOC entry 3730 (class 0 OID 303105)
-- Dependencies: 264
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.password_reset_tokens (id, user_id, token, expires_at, used, created_at) FROM stdin;
1	2	6ec92e042b5ebb6f264c3654752b01656001307db21dc030929befc3cf42acc6	2025-10-17 01:47:57.784	t	2025-10-17 00:47:57.85948
2	2	$2b$10$c6yUqnYxLCkuMnoVT4iIVOtByvGkMxLWLvbLIY5PhSwro0jnu2V/y	2025-10-18 03:30:22.299	f	2025-10-17 03:30:22.375134
3	2	$2b$10$Sgv3gmV4dQ1pfvtolznK8.6oQwSJQ1ODBSqVSow9QJcNAFHfj.X7y	2025-10-18 03:35:30.778	f	2025-10-17 03:35:30.855229
4	2	dfc4115ed78a347b4154b81c8cd342656e22cfbffb8edf87728f227fe82bb1e5	2025-10-18 03:46:10.465	t	2025-10-17 03:46:10.540924
\.


--
-- TOC entry 3694 (class 0 OID 24627)
-- Dependencies: 228
-- Data for Name: payment_methods; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payment_methods (id, user_id, type, is_default, is_active, created_at, details) FROM stdin;
\.


--
-- TOC entry 3696 (class 0 OID 24637)
-- Dependencies: 230
-- Data for Name: payment_stages; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payment_stages (id, project_id, stage_name, stage_percentage, amount, required_progress, status, payment_link, paid_date, created_at, updated_at, payment_method, payment_data, proof_file_url, exchange_rate_used) FROM stdin;
151	46	Anticipo - Inicio del Proyecto	25	37.50	0	paid	\N	2026-01-03 04:00:10.38	2026-01-03 03:59:20.93524	2026-01-03 04:00:10.38	Ueno Bank	{"method": "Ueno Bank", "fileInfo": null, "confirmedAt": "2026-01-03T03:59:56.938Z", "confirmedBy": 2}	\N	6783.54
152	46	Avance 50% - Desarrollo	25	37.50	25	paid	\N	2026-01-03 04:10:42.684	2026-01-03 03:59:21.073655	2026-01-03 04:10:42.684	Ueno Bank	{"method": "Ueno Bank", "fileInfo": null, "confirmedAt": "2026-01-03T04:10:14.083Z", "confirmedBy": 2}	\N	6783.54
153	46	Pre-entrega - 90% Completado	25	37.50	50	paid	\N	2026-01-03 04:14:10.785	2026-01-03 03:59:21.210571	2026-01-03 04:14:10.785	Mango (TU FINANCIERA)	{"method": "Mango (TU FINANCIERA)", "fileInfo": {"fileName": "controle-universal-lcd-led-tv-ecopower-ep-8613.jpg", "fileSize": 44678, "fileType": "image/jpeg"}, "confirmedAt": "2026-01-03T04:13:30.732Z", "confirmedBy": 2, "originalFileName": "controle-universal-lcd-led-tv-ecopower-ep-8613.jpg"}	stage_153_1767413610730.jpg	6783.54
154	46	Entrega Final	25	37.50	75	paid	\N	2026-01-03 04:22:53.098	2026-01-03 03:59:21.369641	2026-01-03 04:22:53.098	Mango (TU FINANCIERA)	{"method": "Mango (TU FINANCIERA)", "fileInfo": null, "confirmedAt": "2026-01-03T04:22:24.915Z", "confirmedBy": 2}	\N	6783.54
\.


--
-- TOC entry 3698 (class 0 OID 24646)
-- Dependencies: 232
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payments (id, project_id, amount, status, payment_data, created_at, stage, stage_percentage, payment_method, transaction_id) FROM stdin;
\.


--
-- TOC entry 3700 (class 0 OID 24656)
-- Dependencies: 234
-- Data for Name: portfolio; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.portfolio (id, title, description, category, technologies, image_url, demo_url, completed_at, featured, is_active, created_at, updated_at) FROM stdin;
7	BaberShop	Aplicación web completa para gestión de barbería con sistema de reservas online, panel administrativo y soporte multiidioma (Español/Portugués). Incluye catálogo de servicios con precios en múltiples monedas (USD, BRL, PYG), galería de trabajos, gestión de personal y configuración de horarios. Sistema responsive con diseño moderno y funcionalidades avanzadas de administración.	Web App	[]	https://i.ibb.co/8DwC9CCg/web.png	https://barbershop.softwarepar.lat	2025-09-23 00:00:00	f	t	2025-09-24 23:27:36.539547	2025-10-06 14:53:42.559
2	Dashboard Analytics	Dashboard interactivo para analisis de datos con graficos en tiempo real y reportes personalizables.	Dashboard	[]	https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800	https://demo-dashboard.softwarepar.lat	2024-02-10 00:00:00	t	t	2025-08-27 14:44:09.899342	2025-10-06 14:53:53.928
3	App Movil Delivery1	Aplicacion movil para delivery de comida con seguimiento en tiempo real y multiples metodos de pago.	Mobile App	[]	https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800		2024-03-05 00:00:00	f	t	2025-08-27 14:44:09.899342	2025-10-06 14:54:01.97
4	Sistema CRM	Sistema de gestion de relaciones con clientes con automatizacion de marketing y seguimiento de ventas.	Web App	[]	https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800	https://demo-crm.softwarepar.lat	2024-01-28 00:00:00	f	t	2025-08-27 14:44:09.899342	2025-10-06 14:54:09.764
1	E-commerce Moderno	Plataforma de comercio electronico con carrito de compras, pagos integrados y panel de administracion completo.	E-commerce	[]	https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800	https://demo-ecommerce.softwarepar.lat	2024-01-15 00:00:00	t	t	2025-08-27 14:44:09.899342	2025-10-06 14:54:21.675
\.


--
-- TOC entry 3702 (class 0 OID 24666)
-- Dependencies: 236
-- Data for Name: project_files; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_files (id, project_id, file_name, file_url, file_type, uploaded_by, file_size, created_at) FROM stdin;
\.


--
-- TOC entry 3704 (class 0 OID 24673)
-- Dependencies: 238
-- Data for Name: project_messages; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_messages (id, project_id, user_id, message, created_at) FROM stdin;
\.


--
-- TOC entry 3706 (class 0 OID 24680)
-- Dependencies: 240
-- Data for Name: project_timeline; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_timeline (id, project_id, title, description, status, estimated_date, completed_at, created_at) FROM stdin;
217	46	Analysis and Planning	Requirements analysis and project planning	completed	\N	2026-01-03 04:09:44.719	2026-01-03 03:59:24.621954
218	46	Design and Architecture	Interface design and system architecture	completed	\N	2026-01-03 04:09:47.463	2026-01-03 03:59:24.761073
219	46	Development - Phase 1	Core functionality development (50% of the project)	completed	\N	2026-01-03 04:12:59.335	2026-01-03 03:59:24.896422
220	46	Development - Phase 2	Complete development and optimizations (90% of the project)	completed	\N	2026-01-03 04:13:05.838	2026-01-03 03:59:25.033321
221	46	Testing and QA	Exhaustive testing and quality assurance	completed	\N	2026-01-03 04:22:00.597	2026-01-03 03:59:25.168969
222	46	Entrega Final	Entrega del proyecto completado y documentación	completed	\N	2026-01-03 04:22:07.142	2026-01-03 03:59:25.307601
\.


--
-- TOC entry 3708 (class 0 OID 24688)
-- Dependencies: 242
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.projects (id, name, description, price, status, progress, client_id, partner_id, delivery_date, created_at, updated_at, start_date) FROM stdin;
46	mantenimiento base de datos	mantenimiento base de dato mssql	150.00	in_progress	100	2	\N	\N	2026-01-03 03:58:59.528398	2026-01-03 04:22:07.635	\N
\.


--
-- TOC entry 3710 (class 0 OID 24698)
-- Dependencies: 244
-- Data for Name: referrals; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.referrals (id, partner_id, client_id, project_id, status, commission_amount, created_at) FROM stdin;
\.


--
-- TOC entry 3712 (class 0 OID 24705)
-- Dependencies: 246
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.sessions (sid, sess, expire) FROM stdin;
\.


--
-- TOC entry 3713 (class 0 OID 24710)
-- Dependencies: 247
-- Data for Name: ticket_responses; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.ticket_responses (id, ticket_id, user_id, message, is_from_support, created_at) FROM stdin;
\.


--
-- TOC entry 3715 (class 0 OID 24718)
-- Dependencies: 249
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.tickets (id, title, description, status, priority, user_id, project_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3728 (class 0 OID 196609)
-- Dependencies: 262
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.transactions (id, invoice_id, payment_method_id, user_id, amount, currency, status, transaction_id, payment_data, created_at, completed_at) FROM stdin;
\.


--
-- TOC entry 3717 (class 0 OID 24745)
-- Dependencies: 251
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (id, email, password, full_name, role, is_active, created_at, updated_at, whatsapp_number) FROM stdin;
2	alfagroupstoreok@gmail.com	$2b$10$YWLG9p67FrC4Zvk1QecXkO9CVy9Nj2a2eo2mgWT56BEKJUkjEzHWS	Pablo	client	t	2025-09-29 15:15:32.71422	2025-10-22 14:48:44.368	+59512121212
1	softwarepar.lat@gmail.com	$2b$10$rCSJbeDjhH4xdJhfMfO1Su1n56XflnD0OMJNJDewdpcBnoBNoiHZK	Administrador SoftwarePar	admin	t	2025-08-26 22:32:54.933839	2025-10-16 23:55:25.087	\N
\.


--
-- TOC entry 3720 (class 0 OID 49153)
-- Dependencies: 254
-- Data for Name: work_modalities; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.work_modalities (id, title, subtitle, badge_text, badge_variant, description, price_text, price_subtitle, features, button_text, button_variant, is_popular, is_active, display_order, created_at, updated_at) FROM stdin;
4	Compra Completa	Tradicional	Tradicional	secondary	Recibe el código fuente completo y propiedad total del proyecto	$2,500 - $15,000	Precio según complejidad	"[\\"Código fuente completo incluido\\",\\"Propiedad intelectual total\\",\\"Documentación técnica completa\\",\\"3 meses de soporte incluido\\",\\"Capacitación del equipo\\",\\"Deployment en tu servidor\\"]"	Solicitar Cotización	default	f	f	1	2025-09-23 12:20:20.459498	2025-10-06 15:02:52.189
3	Modelo SaaS	Más Popular	Más Popular	secondary	Accede al software como servicio con pagos mensuales flexibles	$50 - $200	por mes	["Sin inversión inicial alta", "Actualizaciones automáticas", "Soporte técnico incluido", "Escalabilidad garantizada", "Copias de seguridad automáticas", "Acceso 24/7 desde cualquier lugar"]	Comenzar Ahora	default	t	f	2	2025-09-23 12:07:05.836181	2025-09-23 12:15:18.484
1	Compra Completa	Tradicional	Tradicional	default	Recibe el código fuente completo y propiedad total del proyecto	$2,500 - $15,000	Precio según complejidad	"[\\"Código fuente completo incluido\\",\\"Propiedad intelectual total\\",\\"Documentación técnica completa\\",\\"3 meses de soporte incluido\\",\\"Capacitación del equipo\\",\\"Deployment en tu servidor\\"]"	Solicitar Cotización	default	f	f	1	2025-09-23 12:01:27.883544	2025-09-23 12:19:00.669
5	Partnership	Innovador	Más Popular	default	Paga menos, conviértete en partner y genera ingresos revendendolo	40% - 60%	+ comisiones por ventas	["Precio reducido inicial", "Código de referido único", "20-40% comisión por venta", "Dashboard de ganancias", "Sistema de licencias", "Soporte y marketing incluido"]	Convertirse en Partner	default	t	f	2	2025-09-23 12:20:20.459498	2025-09-23 12:21:44.001
6	Lanzamiento Web	Tu sitio profesional listo en pocos días	Ideal para Emprendedores	default	Ideal para negocios y emprendedores que desean una página web moderna, rápida y optimizada. Incluye dominio, hosting, y soporte técnico por 30 días.	Gs 1.500.000	Entrega en 7 a 15 días	"[\\"Diseño web profesional (hasta 5 secciones)\\",\\"Dominio .com o .com.py incluido\\",\\"Hosting y certificado SSL\\",\\"Diseño responsive (PC, tablet, móvil)\\",\\"Formulario de contacto y WhatsApp directo\\",\\"Optimización SEO básica\\",\\"Soporte técnico 30 días\\"]"	Cotizar mi web profesional	default	f	t	1	2025-10-06 15:00:30.907659	2025-10-06 15:00:30.907659
2	Partnership	Innovador	Más Popular	default	Paga menos, conviértete en partner y genera ingresos revendendolo	40% - 70%	+ comisiones por ventas	"[\\"Precio reducido inicial\\",\\"Código de referido único\\",\\"20-40% comisión por venta\\",\\"Dashboard de ganancias\\",\\"Sistema de licencias\\",\\"Soporte y marketing incluido\\"]"	Convertirse en Partner	default	t	f	2	2025-09-23 12:01:27.883544	2025-10-06 15:02:46.881
7	Desarrollo Avanzado	Soluciones web y apps a medida para tu empresa	Más Popular	secondary	Perfecto para empresas que necesitan sistemas personalizados, paneles administrativos y aplicaciones con integraciones avanzadas.	Gs. 3.500.000	Precio según complejidad	"[\\"Sistema web o app personalizada\\",\\"Panel administrativo completo\\",\\"Integración con pagos y facturación\\",\\"Usuarios y roles personalizados\\",\\"Reportes y dashboard\\",\\"Diseño exclusivo adaptado a tu marca\\",\\"Garantía técnica 6 meses\\",\\"Implementación en servidor\\"]"	Solicitar Cotización	default	t	t	2	2025-10-06 15:02:26.43384	2025-10-06 15:03:17.764
\.


--
-- TOC entry 3783 (class 0 OID 0)
-- Dependencies: 219
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE SET; Schema: drizzle; Owner: neondb_owner
--

SELECT pg_catalog.setval('drizzle.__drizzle_migrations_id_seq', 1, false);


--
-- TOC entry 3784 (class 0 OID 0)
-- Dependencies: 221
-- Name: budget_negotiations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.budget_negotiations_id_seq', 17, true);


--
-- TOC entry 3785 (class 0 OID 0)
-- Dependencies: 255
-- Name: client_billing_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.client_billing_info_id_seq', 2, true);


--
-- TOC entry 3786 (class 0 OID 0)
-- Dependencies: 257
-- Name: company_billing_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.company_billing_info_id_seq', 3, true);


--
-- TOC entry 3787 (class 0 OID 0)
-- Dependencies: 259
-- Name: exchange_rate_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.exchange_rate_config_id_seq', 17, true);


--
-- TOC entry 3788 (class 0 OID 0)
-- Dependencies: 269
-- Name: hero_slider_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.hero_slider_config_id_seq', 1, true);


--
-- TOC entry 3789 (class 0 OID 0)
-- Dependencies: 267
-- Name: hero_slides_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.hero_slides_id_seq', 3, true);


--
-- TOC entry 3790 (class 0 OID 0)
-- Dependencies: 223
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.invoices_id_seq', 107, true);


--
-- TOC entry 3791 (class 0 OID 0)
-- Dependencies: 265
-- Name: legal_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.legal_pages_id_seq', 9, true);


--
-- TOC entry 3792 (class 0 OID 0)
-- Dependencies: 225
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.notifications_id_seq', 364, true);


--
-- TOC entry 3793 (class 0 OID 0)
-- Dependencies: 227
-- Name: partners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.partners_id_seq', 1, false);


--
-- TOC entry 3794 (class 0 OID 0)
-- Dependencies: 263
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.password_reset_tokens_id_seq', 4, true);


--
-- TOC entry 3795 (class 0 OID 0)
-- Dependencies: 229
-- Name: payment_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payment_methods_id_seq', 1, false);


--
-- TOC entry 3796 (class 0 OID 0)
-- Dependencies: 231
-- Name: payment_stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payment_stages_id_seq', 154, true);


--
-- TOC entry 3797 (class 0 OID 0)
-- Dependencies: 233
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- TOC entry 3798 (class 0 OID 0)
-- Dependencies: 235
-- Name: portfolio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.portfolio_id_seq', 7, true);


--
-- TOC entry 3799 (class 0 OID 0)
-- Dependencies: 237
-- Name: project_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.project_files_id_seq', 1, false);


--
-- TOC entry 3800 (class 0 OID 0)
-- Dependencies: 239
-- Name: project_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.project_messages_id_seq', 10, true);


--
-- TOC entry 3801 (class 0 OID 0)
-- Dependencies: 241
-- Name: project_timeline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.project_timeline_id_seq', 222, true);


--
-- TOC entry 3802 (class 0 OID 0)
-- Dependencies: 243
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.projects_id_seq', 46, true);


--
-- TOC entry 3803 (class 0 OID 0)
-- Dependencies: 245
-- Name: referrals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.referrals_id_seq', 1, false);


--
-- TOC entry 3804 (class 0 OID 0)
-- Dependencies: 248
-- Name: ticket_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.ticket_responses_id_seq', 1, false);


--
-- TOC entry 3805 (class 0 OID 0)
-- Dependencies: 250
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.tickets_id_seq', 3, true);


--
-- TOC entry 3806 (class 0 OID 0)
-- Dependencies: 261
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);


--
-- TOC entry 3807 (class 0 OID 0)
-- Dependencies: 252
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- TOC entry 3808 (class 0 OID 0)
-- Dependencies: 253
-- Name: work_modalities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.work_modalities_id_seq', 7, true);


--
-- TOC entry 3442 (class 2606 OID 24776)
-- Name: __drizzle_migrations __drizzle_migrations_pkey; Type: CONSTRAINT; Schema: drizzle; Owner: neondb_owner
--

ALTER TABLE ONLY drizzle.__drizzle_migrations
    ADD CONSTRAINT __drizzle_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3444 (class 2606 OID 24778)
-- Name: budget_negotiations budget_negotiations_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations
    ADD CONSTRAINT budget_negotiations_pkey PRIMARY KEY (id);


--
-- TOC entry 3485 (class 2606 OID 106509)
-- Name: client_billing_info client_billing_info_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.client_billing_info
    ADD CONSTRAINT client_billing_info_pkey PRIMARY KEY (id);


--
-- TOC entry 3487 (class 2606 OID 106529)
-- Name: company_billing_info company_billing_info_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.company_billing_info
    ADD CONSTRAINT company_billing_info_pkey PRIMARY KEY (id);


--
-- TOC entry 3489 (class 2606 OID 122889)
-- Name: exchange_rate_config exchange_rate_config_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.exchange_rate_config
    ADD CONSTRAINT exchange_rate_config_pkey PRIMARY KEY (id);


--
-- TOC entry 3505 (class 2606 OID 409614)
-- Name: hero_slider_config hero_slider_config_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.hero_slider_config
    ADD CONSTRAINT hero_slider_config_pkey PRIMARY KEY (id);


--
-- TOC entry 3501 (class 2606 OID 393228)
-- Name: hero_slides hero_slides_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.hero_slides
    ADD CONSTRAINT hero_slides_pkey PRIMARY KEY (id);


--
-- TOC entry 3446 (class 2606 OID 24780)
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- TOC entry 3497 (class 2606 OID 311309)
-- Name: legal_pages legal_pages_page_type_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.legal_pages
    ADD CONSTRAINT legal_pages_page_type_key UNIQUE (page_type);


--
-- TOC entry 3499 (class 2606 OID 311307)
-- Name: legal_pages legal_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.legal_pages
    ADD CONSTRAINT legal_pages_pkey PRIMARY KEY (id);


--
-- TOC entry 3448 (class 2606 OID 24784)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- TOC entry 3450 (class 2606 OID 24786)
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- TOC entry 3452 (class 2606 OID 24788)
-- Name: partners partners_referral_code_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_referral_code_unique UNIQUE (referral_code);


--
-- TOC entry 3493 (class 2606 OID 303112)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3495 (class 2606 OID 303114)
-- Name: password_reset_tokens password_reset_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3454 (class 2606 OID 24790)
-- Name: payment_methods payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_pkey PRIMARY KEY (id);


--
-- TOC entry 3456 (class 2606 OID 24792)
-- Name: payment_stages payment_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_stages
    ADD CONSTRAINT payment_stages_pkey PRIMARY KEY (id);


--
-- TOC entry 3458 (class 2606 OID 24794)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- TOC entry 3460 (class 2606 OID 24796)
-- Name: portfolio portfolio_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.portfolio
    ADD CONSTRAINT portfolio_pkey PRIMARY KEY (id);


--
-- TOC entry 3462 (class 2606 OID 24798)
-- Name: project_files project_files_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_pkey PRIMARY KEY (id);


--
-- TOC entry 3464 (class 2606 OID 24800)
-- Name: project_messages project_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages
    ADD CONSTRAINT project_messages_pkey PRIMARY KEY (id);


--
-- TOC entry 3466 (class 2606 OID 24802)
-- Name: project_timeline project_timeline_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_timeline
    ADD CONSTRAINT project_timeline_pkey PRIMARY KEY (id);


--
-- TOC entry 3468 (class 2606 OID 24804)
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- TOC entry 3470 (class 2606 OID 24806)
-- Name: referrals referrals_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (id);


--
-- TOC entry 3473 (class 2606 OID 24808)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- TOC entry 3475 (class 2606 OID 24810)
-- Name: ticket_responses ticket_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses
    ADD CONSTRAINT ticket_responses_pkey PRIMARY KEY (id);


--
-- TOC entry 3477 (class 2606 OID 24812)
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- TOC entry 3491 (class 2606 OID 196619)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 3479 (class 2606 OID 24818)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 3481 (class 2606 OID 24820)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3483 (class 2606 OID 49169)
-- Name: work_modalities work_modalities_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.work_modalities
    ADD CONSTRAINT work_modalities_pkey PRIMARY KEY (id);


--
-- TOC entry 3471 (class 1259 OID 24821)
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX "IDX_session_expire" ON public.sessions USING btree (expire);


--
-- TOC entry 3502 (class 1259 OID 393230)
-- Name: idx_hero_slides_active; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_hero_slides_active ON public.hero_slides USING btree (is_active);


--
-- TOC entry 3503 (class 1259 OID 393229)
-- Name: idx_hero_slides_order; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_hero_slides_order ON public.hero_slides USING btree (display_order);


--
-- TOC entry 3506 (class 2606 OID 32797)
-- Name: budget_negotiations budget_negotiations_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations
    ADD CONSTRAINT budget_negotiations_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- TOC entry 3507 (class 2606 OID 32802)
-- Name: budget_negotiations budget_negotiations_proposed_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations
    ADD CONSTRAINT budget_negotiations_proposed_by_users_id_fk FOREIGN KEY (proposed_by) REFERENCES public.users(id);


--
-- TOC entry 3531 (class 2606 OID 253967)
-- Name: client_billing_info client_billing_info_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.client_billing_info
    ADD CONSTRAINT client_billing_info_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3532 (class 2606 OID 253962)
-- Name: exchange_rate_config exchange_rate_config_updated_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.exchange_rate_config
    ADD CONSTRAINT exchange_rate_config_updated_by_users_id_fk FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- TOC entry 3538 (class 2606 OID 409615)
-- Name: hero_slider_config hero_slider_config_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.hero_slider_config
    ADD CONSTRAINT hero_slider_config_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- TOC entry 3508 (class 2606 OID 32812)
-- Name: invoices invoices_client_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_client_id_users_id_fk FOREIGN KEY (client_id) REFERENCES public.users(id);


--
-- TOC entry 3509 (class 2606 OID 32817)
-- Name: invoices invoices_payment_method_id_payment_methods_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_payment_method_id_payment_methods_id_fk FOREIGN KEY (payment_method_id) REFERENCES public.payment_methods(id);


--
-- TOC entry 3510 (class 2606 OID 253957)
-- Name: invoices invoices_payment_stage_id_payment_stages_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_payment_stage_id_payment_stages_id_fk FOREIGN KEY (payment_stage_id) REFERENCES public.payment_stages(id);


--
-- TOC entry 3511 (class 2606 OID 32807)
-- Name: invoices invoices_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- TOC entry 3537 (class 2606 OID 311310)
-- Name: legal_pages legal_pages_last_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.legal_pages
    ADD CONSTRAINT legal_pages_last_updated_by_fkey FOREIGN KEY (last_updated_by) REFERENCES public.users(id);


--
-- TOC entry 3512 (class 2606 OID 24833)
-- Name: notifications notifications_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3513 (class 2606 OID 24838)
-- Name: partners partners_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3536 (class 2606 OID 303115)
-- Name: password_reset_tokens password_reset_tokens_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3514 (class 2606 OID 32822)
-- Name: payment_methods payment_methods_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3515 (class 2606 OID 32827)
-- Name: payment_stages payment_stages_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_stages
    ADD CONSTRAINT payment_stages_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- TOC entry 3516 (class 2606 OID 24843)
-- Name: payments payments_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- TOC entry 3517 (class 2606 OID 32832)
-- Name: project_files project_files_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- TOC entry 3518 (class 2606 OID 32837)
-- Name: project_files project_files_uploaded_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_uploaded_by_users_id_fk FOREIGN KEY (uploaded_by) REFERENCES public.users(id);


--
-- TOC entry 3519 (class 2606 OID 32842)
-- Name: project_messages project_messages_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages
    ADD CONSTRAINT project_messages_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- TOC entry 3520 (class 2606 OID 32847)
-- Name: project_messages project_messages_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages
    ADD CONSTRAINT project_messages_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3521 (class 2606 OID 32852)
-- Name: project_timeline project_timeline_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_timeline
    ADD CONSTRAINT project_timeline_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- TOC entry 3522 (class 2606 OID 24848)
-- Name: projects projects_client_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_client_id_users_id_fk FOREIGN KEY (client_id) REFERENCES public.users(id);


--
-- TOC entry 3523 (class 2606 OID 24853)
-- Name: projects projects_partner_id_partners_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_partner_id_partners_id_fk FOREIGN KEY (partner_id) REFERENCES public.partners(id);


--
-- TOC entry 3524 (class 2606 OID 24858)
-- Name: referrals referrals_client_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_client_id_users_id_fk FOREIGN KEY (client_id) REFERENCES public.users(id);


--
-- TOC entry 3525 (class 2606 OID 24863)
-- Name: referrals referrals_partner_id_partners_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_partner_id_partners_id_fk FOREIGN KEY (partner_id) REFERENCES public.partners(id);


--
-- TOC entry 3526 (class 2606 OID 24868)
-- Name: referrals referrals_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- TOC entry 3527 (class 2606 OID 24874)
-- Name: ticket_responses ticket_responses_ticket_id_tickets_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses
    ADD CONSTRAINT ticket_responses_ticket_id_tickets_id_fk FOREIGN KEY (ticket_id) REFERENCES public.tickets(id);


--
-- TOC entry 3528 (class 2606 OID 24879)
-- Name: ticket_responses ticket_responses_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses
    ADD CONSTRAINT ticket_responses_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3529 (class 2606 OID 24884)
-- Name: tickets tickets_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- TOC entry 3530 (class 2606 OID 24889)
-- Name: tickets tickets_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3533 (class 2606 OID 253972)
-- Name: transactions transactions_invoice_id_invoices_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_invoice_id_invoices_id_fk FOREIGN KEY (invoice_id) REFERENCES public.invoices(id);


--
-- TOC entry 3534 (class 2606 OID 253977)
-- Name: transactions transactions_payment_method_id_payment_methods_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_payment_method_id_payment_methods_id_fk FOREIGN KEY (payment_method_id) REFERENCES public.payment_methods(id);


--
-- TOC entry 3535 (class 2606 OID 253982)
-- Name: transactions transactions_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2175 (class 826 OID 16394)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- TOC entry 2174 (class 826 OID 16393)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


-- Completed on 2026-01-03 10:25:03

--
-- PostgreSQL database dump complete
--

\unrestrict amHTF7yA7AKBngE6kOLarRmVIwYtfetw2zfRs7khVUT6tnswuoKNAGTf9qFRR4A


CREATE TABLE public.vip_packages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    days integer NOT NULL,
    ken_price integer NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT vip_packages_pkey PRIMARY KEY (id)
);

CREATE INDEX idx_vip_packages_active ON public.vip_packages USING btree (is_active, sort_order) WHERE deleted_at IS NULL;

CREATE TABLE public.vip_purchases (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    package_id uuid,
    package_name character varying(100) NOT NULL,
    days integer NOT NULL,
    ken_price integer NOT NULL,
    ken_balance_after integer NOT NULL,
    vip_end_time_after timestamp without time zone NOT NULL,
    source character varying(20) DEFAULT 'package' NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT vip_purchases_pkey PRIMARY KEY (id)
);

ALTER TABLE ONLY public.vip_purchases
    ADD CONSTRAINT fk_vp_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.vip_purchases
    ADD CONSTRAINT fk_vp_package FOREIGN KEY (package_id) REFERENCES public.vip_packages(id) ON DELETE SET NULL;

CREATE INDEX idx_vp_user ON public.vip_purchases USING btree (user_id, created_at DESC) WHERE deleted_at IS NULL;

INSERT INTO public.vip_packages (name, days, ken_price, sort_order) VALUES
    ('Gói 7 ngày', 7, 70, 1),
    ('Gói 30 ngày', 30, 250, 2),
    ('Gói 90 ngày', 90, 600, 3),
    ('Gói 365 ngày', 365, 2000, 4);

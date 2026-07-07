CREATE TABLE IF NOT EXISTS public.wheels (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    ken_cost integer DEFAULT 0 NOT NULL,
    free_daily_enabled boolean DEFAULT false NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT wheels_pkey PRIMARY KEY (id),
    CONSTRAINT wheels_ken_cost_check CHECK ((ken_cost >= 0))
);

CREATE INDEX IF NOT EXISTS idx_wheels_list ON public.wheels USING btree (sort_order) WHERE (deleted_at IS NULL);

CREATE TABLE IF NOT EXISTS public.wheel_segments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    wheel_id uuid NOT NULL,
    kind character varying(20) NOT NULL,
    label character varying(100) NOT NULL,
    color character varying(9) DEFAULT '' NOT NULL,
    weight numeric(10,4) DEFAULT 0 NOT NULL,
    ken_amount integer,
    ken_min integer,
    ken_max integer,
    vip_days integer,
    vip_type_id smallint,
    is_super_lucky boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT wheel_segments_pkey PRIMARY KEY (id),
    CONSTRAINT wheel_segments_kind_check CHECK (((kind)::text = ANY ((ARRAY['miss'::character varying, 'ken_fixed'::character varying, 'ken_random'::character varying, 'vip_days'::character varying, 'vip_item'::character varying, 'vip_random'::character varying])::text[]))),
    CONSTRAINT wheel_segments_weight_check CHECK ((weight >= (0)::numeric)),
    CONSTRAINT fk_wheel_segments_wheel FOREIGN KEY (wheel_id) REFERENCES public.wheels(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_wheel_segments_wheel ON public.wheel_segments USING btree (wheel_id, sort_order);

CREATE TABLE IF NOT EXISTS public.wheel_segment_options (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    segment_id uuid NOT NULL,
    label character varying(100) NOT NULL,
    weight numeric(10,4) DEFAULT 0 NOT NULL,
    vip_type_id smallint,
    vip_days integer,
    ken_amount integer,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT wheel_segment_options_pkey PRIMARY KEY (id),
    CONSTRAINT wheel_segment_options_weight_check CHECK ((weight >= (0)::numeric)),
    CONSTRAINT fk_wheel_segment_options_segment FOREIGN KEY (segment_id) REFERENCES public.wheel_segments(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_wheel_segment_options_segment ON public.wheel_segment_options USING btree (segment_id, sort_order);

CREATE TABLE IF NOT EXISTS public.wheel_spins (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    wheel_id uuid NOT NULL,
    wheel_name character varying(100) NOT NULL,
    ken_cost integer DEFAULT 0 NOT NULL,
    is_free boolean DEFAULT false NOT NULL,
    segment_id uuid,
    segment_kind character varying(20) NOT NULL,
    reward_label character varying(100),
    ken_amount integer,
    vip_days integer,
    vip_type_id smallint,
    is_super_lucky boolean DEFAULT false NOT NULL,
    metadata jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT wheel_spins_pkey PRIMARY KEY (id),
    CONSTRAINT fk_wheel_spins_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_wheel_spins_user ON public.wheel_spins USING btree (user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_wheel_spins_wheel ON public.wheel_spins USING btree (wheel_id, created_at DESC);

CREATE TABLE IF NOT EXISTS public.wheel_free_claims (
    user_id uuid NOT NULL,
    wheel_id uuid NOT NULL,
    claim_date date NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT wheel_free_claims_pkey PRIMARY KEY (user_id, wheel_id, claim_date),
    CONSTRAINT fk_wheel_free_claims_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

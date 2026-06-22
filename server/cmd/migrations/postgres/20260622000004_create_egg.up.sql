CREATE TABLE public.egg_packs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name varchar(100) NOT NULL,
    ken_cost integer NOT NULL DEFAULT 0,
    is_enabled boolean NOT NULL DEFAULT true,
    sort_order integer NOT NULL DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT egg_packs_pkey PRIMARY KEY (id),
    CONSTRAINT egg_packs_ken_cost_check CHECK (ken_cost >= 0)
);
CREATE INDEX idx_egg_packs_list ON public.egg_packs USING btree (sort_order) WHERE deleted_at IS NULL;

CREATE TABLE public.egg_categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    pack_id uuid NOT NULL,
    type varchar(20) NOT NULL,
    label varchar(100) NOT NULL,
    weight numeric(10,4) NOT NULL DEFAULT 0,
    is_active boolean NOT NULL DEFAULT true,
    sort_order integer NOT NULL DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT egg_categories_pkey PRIMARY KEY (id),
    CONSTRAINT egg_categories_type_check CHECK (type IN ('nothing', 'vip_icon', 'ken', 'vip_days')),
    CONSTRAINT egg_categories_weight_check CHECK (weight >= 0),
    CONSTRAINT fk_egg_cat_pack FOREIGN KEY (pack_id) REFERENCES public.egg_packs(id) ON DELETE CASCADE
);
CREATE INDEX idx_egg_cat_pack ON public.egg_categories USING btree (pack_id, sort_order);

CREATE TABLE public.egg_rewards (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    category_id uuid NOT NULL,
    label varchar(100) NOT NULL,
    weight numeric(10,4) NOT NULL DEFAULT 0,
    vip_type_id smallint,
    ken_amount integer,
    vip_days integer,
    is_super_lucky boolean NOT NULL DEFAULT false,
    is_active boolean NOT NULL DEFAULT true,
    sort_order integer NOT NULL DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT egg_rewards_pkey PRIMARY KEY (id),
    CONSTRAINT egg_rewards_weight_check CHECK (weight >= 0),
    CONSTRAINT fk_egg_reward_cat FOREIGN KEY (category_id) REFERENCES public.egg_categories(id) ON DELETE CASCADE
);
CREATE INDEX idx_egg_reward_cat ON public.egg_rewards USING btree (category_id, sort_order);

CREATE TABLE public.egg_draws (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    pack_id uuid NOT NULL,
    pack_name varchar(100) NOT NULL,
    ken_cost integer NOT NULL,
    category_type varchar(20) NOT NULL,
    reward_type varchar(20),
    reward_label varchar(100),
    vip_type_id smallint,
    ken_amount integer,
    vip_days integer,
    is_super_lucky boolean NOT NULL DEFAULT false,
    ken_tx_id uuid,
    metadata jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT egg_draws_pkey PRIMARY KEY (id),
    CONSTRAINT fk_egg_draws_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);
CREATE INDEX idx_egg_draws_user ON public.egg_draws USING btree (user_id, created_at DESC);
CREATE INDEX idx_egg_draws_pack ON public.egg_draws USING btree (pack_id, created_at DESC);

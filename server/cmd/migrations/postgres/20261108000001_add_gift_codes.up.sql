CREATE TABLE IF NOT EXISTS public.gift_code_campaigns (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    kind character varying(10) NOT NULL,
    code_prefix character varying(8) DEFAULT ''::character varying NOT NULL,
    code_length smallint DEFAULT 0 NOT NULL,
    total_uses integer NOT NULL,
    used_count integer DEFAULT 0 NOT NULL,
    rewards jsonb NOT NULL,
    success_message character varying(150) DEFAULT ''::character varying NOT NULL,
    send_notification boolean DEFAULT true NOT NULL,
    min_account_age_days smallint DEFAULT 0 NOT NULL,
    allow_web boolean DEFAULT true NOT NULL,
    allow_android boolean DEFAULT true NOT NULL,
    allow_ios boolean DEFAULT false NOT NULL,
    one_per_device boolean DEFAULT true NOT NULL,
    starts_at timestamp with time zone,
    ends_at timestamp with time zone NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    created_by uuid,
    updated_by uuid,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT gift_code_campaigns_pkey PRIMARY KEY (id),
    CONSTRAINT gift_code_campaigns_kind_check CHECK (((kind)::text = ANY ((ARRAY['shared'::character varying, 'unique'::character varying])::text[]))),
    CONSTRAINT gift_code_campaigns_total_uses_check CHECK ((total_uses > 0)),
    CONSTRAINT gift_code_campaigns_used_count_check CHECK ((used_count >= 0 AND used_count <= total_uses)),
    CONSTRAINT gift_code_campaigns_age_check CHECK ((min_account_age_days >= 0)),
    CONSTRAINT gift_code_campaigns_time_check CHECK ((starts_at IS NULL OR starts_at < ends_at)),
    CONSTRAINT fk_gift_code_campaigns_created_by FOREIGN KEY (created_by) REFERENCES public.admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_gift_code_campaigns_updated_by FOREIGN KEY (updated_by) REFERENCES public.admin_users(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_gift_code_campaigns_deleted_at ON public.gift_code_campaigns USING btree (deleted_at);

CREATE INDEX IF NOT EXISTS idx_gift_code_campaigns_created ON public.gift_code_campaigns USING btree (created_at DESC);

CREATE TABLE IF NOT EXISTS public.gift_codes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    campaign_id uuid NOT NULL,
    code character varying(32) NOT NULL,
    used_by uuid,
    used_at timestamp with time zone,
    locked_at timestamp with time zone,
    locked_by uuid,
    lock_reason character varying(200) DEFAULT ''::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT gift_codes_pkey PRIMARY KEY (id),
    CONSTRAINT fk_gift_codes_campaign FOREIGN KEY (campaign_id) REFERENCES public.gift_code_campaigns(id) ON DELETE CASCADE,
    CONSTRAINT fk_gift_codes_used_by FOREIGN KEY (used_by) REFERENCES public.users(id) ON DELETE SET NULL,
    CONSTRAINT fk_gift_codes_locked_by FOREIGN KEY (locked_by) REFERENCES public.admin_users(id) ON DELETE SET NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_gift_codes_code ON public.gift_codes USING btree (code);

CREATE INDEX IF NOT EXISTS idx_gift_codes_campaign ON public.gift_codes USING btree (campaign_id, created_at, id);

CREATE TABLE IF NOT EXISTS public.gift_code_redemptions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    campaign_id uuid NOT NULL,
    code_id uuid NOT NULL,
    user_id uuid NOT NULL,
    device_key character varying(128),
    device_id character varying(128) DEFAULT ''::character varying NOT NULL,
    device_name character varying(255) DEFAULT ''::character varying NOT NULL,
    platform character varying(10) NOT NULL,
    ip_address character varying(45) DEFAULT ''::character varying NOT NULL,
    rewards jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT gift_code_redemptions_pkey PRIMARY KEY (id),
    CONSTRAINT fk_gift_code_redemptions_campaign FOREIGN KEY (campaign_id) REFERENCES public.gift_code_campaigns(id) ON DELETE CASCADE,
    CONSTRAINT fk_gift_code_redemptions_code FOREIGN KEY (code_id) REFERENCES public.gift_codes(id) ON DELETE CASCADE,
    CONSTRAINT fk_gift_code_redemptions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_gift_code_redemptions_user ON public.gift_code_redemptions USING btree (campaign_id, user_id);

CREATE UNIQUE INDEX IF NOT EXISTS uq_gift_code_redemptions_device ON public.gift_code_redemptions USING btree (campaign_id, device_key);

CREATE INDEX IF NOT EXISTS idx_gift_code_redemptions_campaign_created ON public.gift_code_redemptions USING btree (campaign_id, created_at DESC, id DESC);

CREATE INDEX IF NOT EXISTS idx_gift_code_redemptions_created ON public.gift_code_redemptions USING btree (created_at);

CREATE INDEX IF NOT EXISTS idx_gift_code_redemptions_device ON public.gift_code_redemptions USING btree (device_id, created_at);

CREATE TABLE IF NOT EXISTS public.gift_code_attempts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    campaign_id uuid,
    code_input character varying(40) NOT NULL,
    reason character varying(20) NOT NULL,
    device_id character varying(128) DEFAULT ''::character varying NOT NULL,
    device_name character varying(255) DEFAULT ''::character varying NOT NULL,
    platform character varying(10) NOT NULL,
    ip_address character varying(45) DEFAULT ''::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT gift_code_attempts_pkey PRIMARY KEY (id),
    CONSTRAINT fk_gift_code_attempts_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT fk_gift_code_attempts_campaign FOREIGN KEY (campaign_id) REFERENCES public.gift_code_campaigns(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_gift_code_attempts_created ON public.gift_code_attempts USING btree (created_at DESC);

CREATE INDEX IF NOT EXISTS idx_gift_code_attempts_user_created ON public.gift_code_attempts USING btree (user_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_gift_code_attempts_device_created ON public.gift_code_attempts USING btree (device_id, created_at DESC);

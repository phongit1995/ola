CREATE TABLE public.ken_chests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reward_mode varchar(10) NOT NULL,
    ken_amount integer,
    ken_min integer,
    ken_max integer,
    max_recipients integer NOT NULL,
    claimed_recipients integer NOT NULL DEFAULT 0,
    duration_seconds integer NOT NULL DEFAULT 90,
    status varchar(12) NOT NULL DEFAULT 'active',
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_by uuid,
    claims_count integer NOT NULL DEFAULT 0,
    total_ken_given bigint NOT NULL DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT ken_chests_pkey PRIMARY KEY (id),
    CONSTRAINT ken_chests_reward_mode_check CHECK (reward_mode IN ('fixed', 'random')),
    CONSTRAINT ken_chests_status_check CHECK (status IN ('active', 'expired', 'deleted')),
    CONSTRAINT ken_chests_max_recipients_check CHECK (max_recipients > 0),
    CONSTRAINT ken_chests_duration_check CHECK (duration_seconds BETWEEN 30 AND 600),
    CONSTRAINT ken_chests_claimed_check CHECK (claimed_recipients >= 0 AND claimed_recipients <= max_recipients),
    CONSTRAINT ken_chests_fixed_amount_check CHECK (
        reward_mode <> 'fixed' OR (ken_amount IS NOT NULL AND ken_amount > 0)
    ),
    CONSTRAINT ken_chests_random_range_check CHECK (
        reward_mode <> 'random' OR (ken_min IS NOT NULL AND ken_max IS NOT NULL AND ken_min > 0 AND ken_max >= ken_min)
    )
);
CREATE INDEX idx_ken_chests_active ON public.ken_chests USING btree (status, expires_at) WHERE deleted_at IS NULL;

CREATE TABLE public.ken_chest_claims (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    chest_id uuid NOT NULL,
    user_id uuid NOT NULL,
    ken_amount integer NOT NULL DEFAULT 0,
    is_empty boolean NOT NULL DEFAULT false,
    ken_tx_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT ken_chest_claims_pkey PRIMARY KEY (id),
    CONSTRAINT uq_ken_chest_claim UNIQUE (chest_id, user_id),
    CONSTRAINT fk_ken_chest_claims_chest FOREIGN KEY (chest_id) REFERENCES public.ken_chests(id) ON DELETE CASCADE,
    CONSTRAINT fk_ken_chest_claims_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);
CREATE INDEX idx_ken_chest_claims_chest ON public.ken_chest_claims USING btree (chest_id, created_at DESC);
CREATE INDEX idx_ken_chest_claims_user ON public.ken_chest_claims USING btree (user_id, created_at DESC);

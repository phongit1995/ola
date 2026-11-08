ALTER TABLE public.users ADD COLUMN IF NOT EXISTS avatar_frame_id character varying(8);

ALTER TABLE public.user_settings ADD COLUMN IF NOT EXISTS avatar_frame_store_privacy smallint DEFAULT 0 NOT NULL;

CREATE TABLE IF NOT EXISTS public.avatar_frame_shop_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    frame_id character varying(8) NOT NULL,
    ken_price integer NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT avatar_frame_shop_items_pkey PRIMARY KEY (id),
    CONSTRAINT avatar_frame_shop_items_ken_price_check CHECK ((ken_price >= 0))
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_avatar_frame_shop_items_frame ON public.avatar_frame_shop_items USING btree (frame_id) WHERE (deleted_at IS NULL);

CREATE INDEX IF NOT EXISTS idx_avatar_frame_shop_items_active ON public.avatar_frame_shop_items USING btree (is_active, sort_order) WHERE (deleted_at IS NULL);

CREATE TABLE IF NOT EXISTS public.user_avatar_frames (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    frame_id character varying(8) NOT NULL,
    source character varying(20) NOT NULL,
    acquired_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT user_avatar_frames_pkey PRIMARY KEY (id),
    CONSTRAINT user_avatar_frames_source_check CHECK (((source)::text = ANY ((ARRAY['purchase'::character varying, 'gift'::character varying, 'transfer'::character varying])::text[]))),
    CONSTRAINT fk_user_avatar_frames_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_avatar_frames_owner ON public.user_avatar_frames USING btree (user_id, frame_id) WHERE (deleted_at IS NULL);

CREATE INDEX IF NOT EXISTS idx_user_avatar_frames_frame ON public.user_avatar_frames USING btree (frame_id) WHERE (deleted_at IS NULL);

CREATE TABLE IF NOT EXISTS public.avatar_frame_purchases (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    recipient_user_id uuid,
    shop_item_id uuid,
    frame_id character varying(8) NOT NULL,
    ken_price integer NOT NULL,
    ken_balance_after integer NOT NULL,
    source character varying(20) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT avatar_frame_purchases_pkey PRIMARY KEY (id),
    CONSTRAINT avatar_frame_purchases_source_check CHECK (((source)::text = ANY ((ARRAY['purchase'::character varying, 'gift'::character varying])::text[]))),
    CONSTRAINT fk_avatar_frame_purchases_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT fk_avatar_frame_purchases_recipient FOREIGN KEY (recipient_user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_avatar_frame_purchases_user ON public.avatar_frame_purchases USING btree (user_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_avatar_frame_purchases_recipient ON public.avatar_frame_purchases USING btree (recipient_user_id, created_at DESC) WHERE (recipient_user_id IS NOT NULL);

CREATE INDEX IF NOT EXISTS idx_avatar_frame_purchases_created ON public.avatar_frame_purchases USING btree (created_at DESC);

CREATE TABLE IF NOT EXISTS public.avatar_frame_transfers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    from_user_id uuid NOT NULL,
    to_user_id uuid NOT NULL,
    frame_id character varying(8) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT avatar_frame_transfers_pkey PRIMARY KEY (id),
    CONSTRAINT avatar_frame_transfers_not_self CHECK ((from_user_id <> to_user_id)),
    CONSTRAINT fk_avatar_frame_transfers_from FOREIGN KEY (from_user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT fk_avatar_frame_transfers_to FOREIGN KEY (to_user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_avatar_frame_transfers_from ON public.avatar_frame_transfers USING btree (from_user_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_avatar_frame_transfers_to ON public.avatar_frame_transfers USING btree (to_user_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_avatar_frame_transfers_created ON public.avatar_frame_transfers USING btree (created_at DESC);

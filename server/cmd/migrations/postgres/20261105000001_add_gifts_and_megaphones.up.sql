CREATE TABLE IF NOT EXISTS public.gifts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(60) NOT NULL,
    name_en character varying(60) DEFAULT ''::character varying NOT NULL,
    image_url character varying(500) NOT NULL,
    ken_price integer NOT NULL,
    charm_points integer NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT gifts_pkey PRIMARY KEY (id),
    CONSTRAINT gifts_ken_price_check CHECK ((ken_price > 0)),
    CONSTRAINT gifts_charm_points_check CHECK ((charm_points >= 0))
);

CREATE INDEX IF NOT EXISTS idx_gifts_deleted_at ON public.gifts USING btree (deleted_at);

CREATE TABLE IF NOT EXISTS public.gift_transactions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sender_id uuid NOT NULL,
    receiver_id uuid NOT NULL,
    gift_id uuid NOT NULL,
    gift_name character varying(60) NOT NULL,
    gift_image_url character varying(500) NOT NULL,
    quantity integer NOT NULL,
    unit_price integer NOT NULL,
    total_ken integer NOT NULL,
    charm_points integer NOT NULL,
    source character varying(20) NOT NULL,
    conversation_id uuid,
    message_id character varying(64) DEFAULT ''::character varying NOT NULL,
    note character varying(100) DEFAULT ''::character varying NOT NULL,
    client_request_id character varying(64) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT gift_transactions_pkey PRIMARY KEY (id),
    CONSTRAINT gift_transactions_quantity_check CHECK ((quantity > 0)),
    CONSTRAINT gift_transactions_source_check CHECK (((source)::text = ANY ((ARRAY['chat'::character varying, 'profile'::character varying])::text[]))),
    CONSTRAINT gift_transactions_not_self CHECK ((sender_id <> receiver_id)),
    CONSTRAINT fk_gift_transactions_sender FOREIGN KEY (sender_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT fk_gift_transactions_receiver FOREIGN KEY (receiver_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT fk_gift_transactions_gift FOREIGN KEY (gift_id) REFERENCES public.gifts(id)
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_gift_transactions_client_request ON public.gift_transactions USING btree (sender_id, client_request_id);

CREATE INDEX IF NOT EXISTS idx_gift_transactions_receiver_created ON public.gift_transactions USING btree (receiver_id, created_at DESC, id DESC);

CREATE INDEX IF NOT EXISTS idx_gift_transactions_sender_created ON public.gift_transactions USING btree (sender_id, created_at DESC, id DESC);

CREATE INDEX IF NOT EXISTS idx_gift_transactions_created ON public.gift_transactions USING btree (created_at);

CREATE TABLE IF NOT EXISTS public.user_gift_wall (
    receiver_id uuid NOT NULL,
    gift_id uuid NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    last_received_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT user_gift_wall_pkey PRIMARY KEY (receiver_id, gift_id),
    CONSTRAINT fk_user_gift_wall_receiver FOREIGN KEY (receiver_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_gift_wall_gift FOREIGN KEY (gift_id) REFERENCES public.gifts(id)
);

ALTER TABLE public.users
    ADD COLUMN IF NOT EXISTS charm integer DEFAULT 0 NOT NULL;

CREATE TABLE IF NOT EXISTS public.megaphones (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sender_id uuid NOT NULL,
    content character varying(200) NOT NULL,
    ken_price integer NOT NULL,
    show_at timestamp with time zone NOT NULL,
    display_seconds integer NOT NULL,
    status character varying(20) DEFAULT 'active'::character varying NOT NULL,
    removed_by uuid,
    removed_reason character varying(200) DEFAULT ''::character varying NOT NULL,
    removed_at timestamp with time zone,
    client_request_id character varying(64) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT megaphones_pkey PRIMARY KEY (id),
    CONSTRAINT megaphones_ken_price_check CHECK ((ken_price >= 0)),
    CONSTRAINT megaphones_display_seconds_check CHECK ((display_seconds > 0)),
    CONSTRAINT megaphones_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'removed'::character varying])::text[]))),
    CONSTRAINT fk_megaphones_sender FOREIGN KEY (sender_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_megaphones_client_request ON public.megaphones USING btree (sender_id, client_request_id);

CREATE INDEX IF NOT EXISTS idx_megaphones_show_at ON public.megaphones USING btree (show_at DESC, id DESC);

CREATE INDEX IF NOT EXISTS idx_megaphones_sender_created ON public.megaphones USING btree (sender_id, created_at DESC);

ALTER TABLE public.reports DROP CONSTRAINT IF EXISTS reports_target_type_check;

ALTER TABLE public.reports
    ADD CONSTRAINT reports_target_type_check CHECK (((target_type)::text = ANY ((ARRAY['account'::character varying, 'post'::character varying, 'comment'::character varying, 'story_comment'::character varying, 'message'::character varying, 'room_message'::character varying, 'moment'::character varying, 'megaphone'::character varying])::text[])));

ALTER TABLE public.user_violations DROP CONSTRAINT IF EXISTS user_violations_source_check;

ALTER TABLE public.user_violations
    ADD CONSTRAINT user_violations_source_check CHECK (((source)::text = ANY ((ARRAY['report'::character varying, 'me_hide'::character varying, 'megaphone_remove'::character varying])::text[])));

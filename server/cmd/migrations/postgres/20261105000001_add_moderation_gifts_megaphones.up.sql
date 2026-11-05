ALTER TABLE public.users
    ADD COLUMN IF NOT EXISTS locked_until timestamp with time zone,
    ADD COLUMN IF NOT EXISTS lock_reason character varying(20) DEFAULT ''::character varying NOT NULL;

CREATE TABLE IF NOT EXISTS public.user_violations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    source character varying(20) NOT NULL,
    target_type character varying(20) NOT NULL,
    target_id character varying(64) NOT NULL,
    report_id uuid,
    reason character varying(20) NOT NULL,
    severity character varying(20) NOT NULL,
    points smallint DEFAULT 0 NOT NULL,
    content_removed boolean DEFAULT false NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    admin_id uuid,
    revoked_at timestamp with time zone,
    revoked_by uuid,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT user_violations_pkey PRIMARY KEY (id),
    CONSTRAINT user_violations_source_check CHECK (((source)::text = ANY ((ARRAY['report'::character varying, 'me_hide'::character varying, 'megaphone_remove'::character varying])::text[]))),
    CONSTRAINT user_violations_severity_check CHECK (((severity)::text = ANY ((ARRAY['none'::character varying, 'violation'::character varying, 'deliberate'::character varying])::text[]))),
    CONSTRAINT user_violations_points_check CHECK ((points >= 0)),
    CONSTRAINT fk_user_violations_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_violations_report FOREIGN KEY (report_id) REFERENCES public.reports(id) ON DELETE SET NULL,
    CONSTRAINT fk_user_violations_admin FOREIGN KEY (admin_id) REFERENCES public.admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_user_violations_revoked_by FOREIGN KEY (revoked_by) REFERENCES public.admin_users(id) ON DELETE SET NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_violations_content ON public.user_violations USING btree (target_type, target_id) WHERE ((revoked_at IS NULL) AND (points > 0) AND ((target_type)::text <> 'account'::text));

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_violations_report ON public.user_violations USING btree (report_id) WHERE ((report_id IS NOT NULL) AND (revoked_at IS NULL) AND (points > 0));

CREATE INDEX IF NOT EXISTS idx_user_violations_user_created ON public.user_violations USING btree (user_id, created_at DESC);

ALTER TABLE public.me
    ADD COLUMN IF NOT EXISTS hidden_by character varying(10),
    ADD COLUMN IF NOT EXISTS hidden_at timestamp with time zone;

ALTER TABLE public.me DROP CONSTRAINT IF EXISTS me_hidden_by_check;

ALTER TABLE public.me
    ADD CONSTRAINT me_hidden_by_check CHECK (((hidden_by IS NULL) OR ((hidden_by)::text = ANY ((ARRAY['owner'::character varying, 'admin'::character varying, 'clan'::character varying])::text[]))));

ALTER TABLE public.game_matches DROP CONSTRAINT IF EXISTS game_matches_ken_delta_check;

ALTER TABLE public.game_matches
    ADD CONSTRAINT game_matches_ken_delta_check
    CHECK (ken_delta >= 0 AND ken_delta::bigint <= bet::bigint * GREATEST(player_count - 1, 1));

CREATE TABLE IF NOT EXISTS public.gifts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(60) NOT NULL,
    name_en character varying(60) DEFAULT ''::character varying NOT NULL,
    image_url character varying(500) NOT NULL,
    ken_price integer NOT NULL,
    charm_points integer NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    animation character varying(20) DEFAULT 'random'::character varying NOT NULL,
    sender_charm_percent smallint DEFAULT 50 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT gifts_pkey PRIMARY KEY (id),
    CONSTRAINT gifts_ken_price_check CHECK ((ken_price > 0)),
    CONSTRAINT gifts_charm_points_check CHECK ((charm_points >= 0)),
    CONSTRAINT gifts_sender_charm_percent_range CHECK ((sender_charm_percent >= 0 AND sender_charm_percent <= 100))
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
    sender_charm_points integer DEFAULT 0 NOT NULL,
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

ALTER TABLE public.user_settings
    ADD COLUMN IF NOT EXISTS gift_wall_privacy smallint DEFAULT 0 NOT NULL;

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

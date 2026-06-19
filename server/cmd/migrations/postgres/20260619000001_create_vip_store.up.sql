CREATE TABLE public.user_vip_icons (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    vip_icon_id smallint NOT NULL,
    is_locked boolean DEFAULT false NOT NULL,
    source character varying(20) DEFAULT 'purchase' NOT NULL,
    acquired_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT user_vip_icons_pkey PRIMARY KEY (id)
);

ALTER TABLE ONLY public.user_vip_icons
    ADD CONSTRAINT fk_uvi_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

CREATE INDEX idx_uvi_user ON public.user_vip_icons USING btree (user_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_uvi_user_type ON public.user_vip_icons USING btree (user_id, vip_icon_id) WHERE deleted_at IS NULL;

ALTER TABLE public.users ADD COLUMN vip_store_privacy smallint DEFAULT 0 NOT NULL;

UPDATE public.users SET vip_used = NULL WHERE vip_used IS NOT NULL AND vip_used !~ '^[0-9]+$';

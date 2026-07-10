CREATE TABLE IF NOT EXISTS public.vip_transfers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    from_user_id uuid NOT NULL,
    to_user_id uuid NOT NULL,
    vip_icon_id smallint NOT NULL,
    instance_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT vip_transfers_pkey PRIMARY KEY (id),
    CONSTRAINT fk_vip_transfers_from FOREIGN KEY (from_user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT fk_vip_transfers_to FOREIGN KEY (to_user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_vip_transfers_from ON public.vip_transfers USING btree (from_user_id, created_at DESC) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_vip_transfers_to ON public.vip_transfers USING btree (to_user_id, created_at DESC) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_vip_transfers_created_at ON public.vip_transfers USING btree (created_at DESC) WHERE (deleted_at IS NULL);

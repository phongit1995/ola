DROP TABLE IF EXISTS public.vip_icon_types;

CREATE TABLE public.vip_shop_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    vip_type_id smallint NOT NULL,
    ken_price integer NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT vip_shop_items_pkey PRIMARY KEY (id)
);

CREATE UNIQUE INDEX idx_vip_shop_type_unique ON public.vip_shop_items USING btree (vip_type_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_vip_shop_active ON public.vip_shop_items USING btree (is_active, sort_order) WHERE deleted_at IS NULL;

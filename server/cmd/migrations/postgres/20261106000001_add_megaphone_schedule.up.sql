ALTER TABLE public.megaphones
    ADD COLUMN IF NOT EXISTS type character varying(20) DEFAULT 'message'::character varying NOT NULL,
    ADD COLUMN IF NOT EXISTS weight smallint DEFAULT 3 NOT NULL,
    ADD COLUMN IF NOT EXISTS expires_at timestamp with time zone,
    ADD COLUMN IF NOT EXISTS first_played_at timestamp with time zone,
    ADD COLUMN IF NOT EXISTS gift_transaction_id uuid;

UPDATE public.megaphones
SET expires_at = show_at + display_seconds * interval '1 second',
    first_played_at = show_at
WHERE expires_at IS NULL AND show_at <= now();

UPDATE public.megaphones
SET expires_at = now() + interval '30 minutes'
WHERE expires_at IS NULL;

ALTER TABLE public.megaphones
    ALTER COLUMN expires_at SET DEFAULT (now() + interval '30 minutes'),
    ALTER COLUMN expires_at SET NOT NULL;

ALTER TABLE public.megaphones
    ADD CONSTRAINT megaphones_type_check CHECK (((type)::text = ANY ((ARRAY['message'::character varying, 'gift'::character varying])::text[]))),
    ADD CONSTRAINT megaphones_weight_check CHECK ((weight > 0)),
    ADD CONSTRAINT fk_megaphones_gift_transaction FOREIGN KEY (gift_transaction_id) REFERENCES public.gift_transactions(id);

CREATE UNIQUE INDEX IF NOT EXISTS uq_megaphones_gift_transaction ON public.megaphones USING btree (gift_transaction_id) WHERE (gift_transaction_id IS NOT NULL);

CREATE INDEX IF NOT EXISTS idx_megaphones_active_expires ON public.megaphones USING btree (expires_at) WHERE ((status)::text = 'active'::text);

ALTER TABLE public.gifts ADD COLUMN IF NOT EXISTS announce_enabled boolean DEFAULT false NOT NULL;

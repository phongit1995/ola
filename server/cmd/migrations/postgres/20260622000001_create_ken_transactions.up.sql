CREATE TABLE public.ken_transactions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    direction character varying(10) NOT NULL,
    type character varying(40) NOT NULL,
    amount integer NOT NULL,
    balance_before integer NOT NULL,
    balance_after integer NOT NULL,
    description character varying(255),
    ref_type character varying(40),
    ref_id uuid,
    actor_type character varying(20),
    actor_id uuid,
    metadata jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT ken_transactions_pkey PRIMARY KEY (id),
    CONSTRAINT ken_transactions_direction_check CHECK (direction IN ('credit', 'debit')),
    CONSTRAINT ken_transactions_amount_check CHECK (amount > 0),
    CONSTRAINT ken_transactions_balance_after_check CHECK (balance_after >= 0)
);

ALTER TABLE ONLY public.ken_transactions
    ADD CONSTRAINT fk_ken_tx_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

CREATE INDEX idx_ken_tx_user ON public.ken_transactions USING btree (user_id, created_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX idx_ken_tx_user_type ON public.ken_transactions USING btree (user_id, type, created_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX idx_ken_tx_user_direction ON public.ken_transactions USING btree (user_id, direction, created_at DESC) WHERE deleted_at IS NULL;

INSERT INTO public.ken_transactions
    (id, user_id, direction, type, amount, balance_before, balance_after, description, ref_type, ref_id, actor_type, created_at, updated_at)
SELECT
    gen_random_uuid(),
    vp.user_id,
    'debit',
    CASE vp.source WHEN 'icon' THEN 'VIP_ICON' ELSE 'VIP_PACKAGE' END,
    vp.ken_price,
    vp.ken_balance_after + vp.ken_price,
    vp.ken_balance_after,
    vp.package_name,
    'vip_purchase',
    vp.id,
    'system',
    vp.created_at,
    vp.created_at
FROM public.vip_purchases vp
WHERE vp.deleted_at IS NULL
  AND vp.ken_price > 0;

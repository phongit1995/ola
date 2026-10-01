CREATE TABLE IF NOT EXISTS public.word_chain_hint_purchases (
    user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    session_id uuid NOT NULL,
    turn bigint NOT NULL,
    word character varying(100) NOT NULL,
    hints text[] NOT NULL DEFAULT '{}',
    price integer NOT NULL,
    ken_transaction_id uuid NOT NULL REFERENCES public.ken_transactions(id),
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT word_chain_hint_purchases_pkey PRIMARY KEY (user_id, session_id, turn)
);

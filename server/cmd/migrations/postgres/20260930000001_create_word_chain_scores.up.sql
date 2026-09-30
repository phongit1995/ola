CREATE TABLE IF NOT EXISTS public.word_chain_scores (
    message_id uuid NOT NULL,
    session_id uuid NOT NULL,
    user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    word character varying(100) NOT NULL,
    previous_word character varying(100) NOT NULL,
    points smallint DEFAULT 1 NOT NULL,
    is_win boolean DEFAULT false NOT NULL,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT word_chain_scores_pkey PRIMARY KEY (message_id)
);

CREATE INDEX IF NOT EXISTS idx_word_chain_scores_created_at ON public.word_chain_scores (created_at);

CREATE INDEX IF NOT EXISTS idx_word_chain_scores_wins ON public.word_chain_scores (created_at DESC, message_id DESC) WHERE is_win;

CREATE INDEX IF NOT EXISTS idx_word_chain_scores_user_wins ON public.word_chain_scores (user_id, created_at DESC, message_id DESC) WHERE is_win;

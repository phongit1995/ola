CREATE INDEX IF NOT EXISTS idx_word_chain_scores_user_points ON public.word_chain_scores (user_id) INCLUDE (points, is_win);

ALTER TABLE public.game_matches ADD COLUMN IF NOT EXISTS end_reason varchar(16);

ALTER TABLE public.game_match_players ADD COLUMN IF NOT EXISTS exit_reason varchar(16);

CREATE INDEX IF NOT EXISTS idx_user_game_levels_game_exp ON public.user_game_levels (game_id, exp DESC);

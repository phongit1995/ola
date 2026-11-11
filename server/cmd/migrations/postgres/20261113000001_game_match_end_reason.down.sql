DROP INDEX IF EXISTS public.idx_user_game_levels_game_exp;

ALTER TABLE public.game_match_players DROP COLUMN IF EXISTS exit_reason;

ALTER TABLE public.game_matches DROP COLUMN IF EXISTS end_reason;

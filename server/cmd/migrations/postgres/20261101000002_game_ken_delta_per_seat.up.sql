ALTER TABLE public.game_matches DROP CONSTRAINT IF EXISTS game_matches_ken_delta_check;

ALTER TABLE public.game_matches
    ADD CONSTRAINT game_matches_ken_delta_check
    CHECK (ken_delta >= 0 AND ken_delta::bigint <= bet::bigint * GREATEST(player_count - 1, 1));

ALTER TABLE game_matches
    ADD COLUMN IF NOT EXISTS player_count integer NOT NULL DEFAULT 2;

ALTER TABLE game_matches
    DROP CONSTRAINT IF EXISTS game_matches_player_count_check;
ALTER TABLE game_matches
    ADD CONSTRAINT game_matches_player_count_check CHECK (player_count >= 2 AND player_count <= 8) NOT VALID;
ALTER TABLE game_matches VALIDATE CONSTRAINT game_matches_player_count_check;

ALTER TABLE game_matches
    DROP CONSTRAINT IF EXISTS game_matches_result_players_check;
ALTER TABLE game_matches
    ADD CONSTRAINT game_matches_result_players_check CHECK (
        (
            player_count = 2
            AND (
                (winner_id IS NULL AND loser_id IS NULL)
                OR (
                    winner_id IS NOT NULL
                    AND loser_id IS NOT NULL
                    AND winner_id <> loser_id
                    AND winner_id IN (player0_id, player1_id)
                    AND loser_id IN (player0_id, player1_id)
                )
            )
        )
        OR (
            player_count > 2
            AND loser_id IS NULL
        )
    ) NOT VALID;
ALTER TABLE game_matches VALIDATE CONSTRAINT game_matches_result_players_check;

CREATE TABLE IF NOT EXISTS game_match_players (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    game_match_id uuid NOT NULL,
    user_id uuid NOT NULL,
    seat integer NOT NULL,
    place integer,
    ken_delta integer NOT NULL DEFAULT 0,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT game_match_players_pkey PRIMARY KEY (id),
    CONSTRAINT game_match_players_match_fkey FOREIGN KEY (game_match_id) REFERENCES game_matches (id) ON DELETE CASCADE,
    CONSTRAINT game_match_players_user_fkey FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT game_match_players_seat_check CHECK (seat >= 0 AND seat <= 7),
    CONSTRAINT game_match_players_place_check CHECK (place IS NULL OR (place >= 1 AND place <= 8)),
    CONSTRAINT game_match_players_match_seat_key UNIQUE (game_match_id, seat),
    CONSTRAINT game_match_players_match_user_key UNIQUE (game_match_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_game_match_players_user ON game_match_players (user_id);
CREATE INDEX IF NOT EXISTS idx_game_match_players_match ON game_match_players (game_match_id);

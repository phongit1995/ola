DROP TABLE IF EXISTS game_match_players;

ALTER TABLE game_matches
    DROP CONSTRAINT IF EXISTS game_matches_result_players_check;
ALTER TABLE game_matches
    ADD CONSTRAINT game_matches_result_players_check CHECK (
        (winner_id IS NULL AND loser_id IS NULL)
        OR (
            winner_id IS NOT NULL
            AND loser_id IS NOT NULL
            AND winner_id <> loser_id
            AND winner_id IN (player0_id, player1_id)
            AND loser_id IN (player0_id, player1_id)
        )
    ) NOT VALID;

ALTER TABLE game_matches
    DROP CONSTRAINT IF EXISTS game_matches_player_count_check;
ALTER TABLE game_matches
    DROP COLUMN IF EXISTS player_count;

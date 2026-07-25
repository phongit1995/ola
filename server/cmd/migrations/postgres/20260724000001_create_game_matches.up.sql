CREATE TABLE IF NOT EXISTS game_matches (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    game_id varchar(50) NOT NULL,
    match_id varchar(64) NOT NULL,
    player0_id uuid NOT NULL,
    player1_id uuid NOT NULL,
    winner_id uuid,
    loser_id uuid,
    status varchar(10) NOT NULL DEFAULT 'playing',
    reason varchar(20) NOT NULL DEFAULT '',
    mode varchar(10) NOT NULL,
    bet integer NOT NULL DEFAULT 0,
    ken_delta integer NOT NULL DEFAULT 0,
    move_count integer NOT NULL DEFAULT 0,
    started_at timestamptz NOT NULL,
    escrowed_at timestamptz NOT NULL,
    finished_at timestamptz,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamptz,
    CONSTRAINT game_matches_pkey PRIMARY KEY (id),
    CONSTRAINT game_matches_players_distinct_check CHECK (player0_id <> player1_id),
    CONSTRAINT game_matches_mode_check CHECK (mode IN ('queue', 'room')),
    CONSTRAINT game_matches_status_check CHECK (status IN ('playing', 'finished')),
    CONSTRAINT game_matches_reason_check CHECK (reason IN ('', 'win', 'draw', 'forfeit', 'timeout', 'disconnect', 'void')),
    CONSTRAINT game_matches_bet_check CHECK (bet >= 0 AND bet <= 1073741823),
    CONSTRAINT game_matches_ken_delta_check CHECK (ken_delta >= 0 AND ken_delta <= bet),
    CONSTRAINT game_matches_move_count_check CHECK (move_count >= 0),
    CONSTRAINT game_matches_result_players_check CHECK (
        (winner_id IS NULL AND loser_id IS NULL)
        OR (
            winner_id IS NOT NULL
            AND loser_id IS NOT NULL
            AND winner_id <> loser_id
            AND winner_id IN (player0_id, player1_id)
            AND loser_id IN (player0_id, player1_id)
        )
    ),
    CONSTRAINT game_matches_lifecycle_check CHECK (
        (
            status = 'playing'
            AND finished_at IS NULL
            AND reason = ''
            AND winner_id IS NULL
            AND loser_id IS NULL
            AND ken_delta = 0
        )
        OR (
            status = 'finished'
            AND finished_at IS NOT NULL
            AND reason <> ''
            AND (
                (reason IN ('win', 'forfeit', 'timeout') AND winner_id IS NOT NULL)
                OR (reason IN ('draw', 'void') AND winner_id IS NULL)
                OR reason = 'disconnect'
            )
        )
    ),
    CONSTRAINT game_matches_timestamp_order_check CHECK (
        started_at <= escrowed_at
        AND (finished_at IS NULL OR escrowed_at <= finished_at)
    ),
    CONSTRAINT fk_game_matches_player0 FOREIGN KEY (player0_id) REFERENCES users(id) ON DELETE RESTRICT,
    CONSTRAINT fk_game_matches_player1 FOREIGN KEY (player1_id) REFERENCES users(id) ON DELETE RESTRICT,
    CONSTRAINT fk_game_matches_winner FOREIGN KEY (winner_id) REFERENCES users(id) ON DELETE RESTRICT,
    CONSTRAINT fk_game_matches_loser FOREIGN KEY (loser_id) REFERENCES users(id) ON DELETE RESTRICT
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_game_matches_match ON game_matches USING btree (match_id);
CREATE INDEX IF NOT EXISTS idx_game_matches_game_status_finished ON game_matches USING btree (game_id, status, finished_at DESC);
CREATE INDEX IF NOT EXISTS idx_game_matches_winner ON game_matches USING btree (winner_id);
CREATE INDEX IF NOT EXISTS idx_game_matches_loser ON game_matches USING btree (loser_id);
CREATE INDEX IF NOT EXISTS idx_game_matches_player0 ON game_matches USING btree (player0_id);
CREATE INDEX IF NOT EXISTS idx_game_matches_player1 ON game_matches USING btree (player1_id);
CREATE INDEX IF NOT EXISTS idx_game_matches_deleted_at ON game_matches USING btree (deleted_at);
CREATE INDEX IF NOT EXISTS idx_game_matches_playing_started ON game_matches USING btree (started_at)
    WHERE status = 'playing' AND deleted_at IS NULL;

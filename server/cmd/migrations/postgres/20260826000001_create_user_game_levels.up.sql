CREATE TABLE IF NOT EXISTS user_game_levels (
    user_id uuid NOT NULL,
    game_id varchar(50) NOT NULL,
    exp bigint NOT NULL DEFAULT 0,
    level integer NOT NULL DEFAULT 1,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_game_levels_pkey PRIMARY KEY (user_id, game_id),
    CONSTRAINT user_game_levels_exp_check CHECK (exp >= 0),
    CONSTRAINT user_game_levels_level_check CHECK (level >= 1 AND level <= 99),
    CONSTRAINT fk_user_game_levels_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_user_game_levels_game_exp ON user_game_levels USING btree (game_id, exp DESC);

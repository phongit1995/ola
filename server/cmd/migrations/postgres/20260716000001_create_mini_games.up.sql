CREATE TABLE IF NOT EXISTS mini_games (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    slug varchar(50) NOT NULL,
    name varchar(100) NOT NULL,
    description varchar(300),
    icon_url varchar(500),
    game_url varchar(500) NOT NULL,
    is_enabled boolean NOT NULL DEFAULT true,
    sort_order integer NOT NULL DEFAULT 0,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamptz,
    CONSTRAINT mini_games_pkey PRIMARY KEY (id)
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_mini_games_slug ON mini_games USING btree (slug) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_mini_games_enabled_sort ON mini_games USING btree (is_enabled, sort_order);
CREATE INDEX IF NOT EXISTS idx_mini_games_deleted_at ON mini_games USING btree (deleted_at);

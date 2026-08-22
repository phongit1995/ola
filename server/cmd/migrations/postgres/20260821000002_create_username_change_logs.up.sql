CREATE TABLE IF NOT EXISTS username_change_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    old_username varchar(50) NOT NULL,
    new_username varchar(50) NOT NULL,
    cost integer NOT NULL DEFAULT 0,
    actor_type varchar(10) NOT NULL DEFAULT 'user',
    actor_id uuid,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT username_change_logs_pkey PRIMARY KEY (id)
);

CREATE INDEX IF NOT EXISTS idx_username_change_logs_user_created ON username_change_logs USING btree (user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_username_change_logs_created ON username_change_logs USING btree (created_at DESC);

CREATE TABLE IF NOT EXISTS announcements (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title varchar(200) NOT NULL,
    content text DEFAULT '',
    link varchar(500),
    is_active boolean NOT NULL DEFAULT false,
    starts_at timestamptz,
    ends_at timestamptz,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamptz,
    CONSTRAINT announcements_pkey PRIMARY KEY (id)
);

CREATE INDEX IF NOT EXISTS idx_announcements_active_created ON announcements USING btree (is_active, created_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_announcements_deleted_at ON announcements USING btree (deleted_at);

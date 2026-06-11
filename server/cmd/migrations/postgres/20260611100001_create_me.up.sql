CREATE TABLE IF NOT EXISTS me (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    author_id     UUID NOT NULL,
    content       TEXT,
    images        JSONB,
    visibility    VARCHAR(20) NOT NULL DEFAULT 'public',
    like_count    INT NOT NULL DEFAULT 0,
    dislike_count INT NOT NULL DEFAULT 0,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at    TIMESTAMP,
    CONSTRAINT fk_me_author FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_me_deleted_at ON me(deleted_at);
CREATE INDEX IF NOT EXISTS idx_me_author ON me(author_id) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_me_visibility_created ON me(visibility, created_at DESC) WHERE deleted_at IS NULL;

DROP INDEX IF EXISTS idx_me_visibility_created;
DROP INDEX IF EXISTS idx_me_author;

CREATE INDEX IF NOT EXISTS idx_me_public_created_id
    ON me(visibility, created_at DESC, id DESC) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_me_author_created_id
    ON me(author_id, created_at DESC, id DESC) WHERE deleted_at IS NULL;

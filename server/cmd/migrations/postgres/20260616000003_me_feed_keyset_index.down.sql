DROP INDEX IF EXISTS idx_me_public_created_id;
DROP INDEX IF EXISTS idx_me_author_created_id;

CREATE INDEX IF NOT EXISTS idx_me_author
    ON me(author_id) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_me_visibility_created
    ON me(visibility, created_at DESC) WHERE deleted_at IS NULL;

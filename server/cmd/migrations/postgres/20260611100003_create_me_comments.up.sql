ALTER TABLE me ADD COLUMN IF NOT EXISTS comment_count INT NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS me_comments (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    post_id    UUID NOT NULL,
    author_id  UUID NOT NULL,
    content    TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    CONSTRAINT fk_me_comments_post FOREIGN KEY (post_id) REFERENCES me(id) ON DELETE CASCADE,
    CONSTRAINT fk_me_comments_author FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_me_comments_deleted_at ON me_comments(deleted_at);
CREATE INDEX IF NOT EXISTS idx_me_comments_post_created ON me_comments(post_id, created_at DESC) WHERE deleted_at IS NULL;

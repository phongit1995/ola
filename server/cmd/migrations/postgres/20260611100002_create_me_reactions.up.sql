CREATE TABLE IF NOT EXISTS me_reactions (
    post_id    UUID NOT NULL,
    user_id    UUID NOT NULL,
    type       VARCHAR(10) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (post_id, user_id),
    CONSTRAINT fk_me_reactions_post FOREIGN KEY (post_id) REFERENCES me(id) ON DELETE CASCADE,
    CONSTRAINT fk_me_reactions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_me_reactions_user ON me_reactions(user_id);

CREATE INDEX IF NOT EXISTS idx_me_reactions_post_type_created
    ON me_reactions(post_id, type, created_at DESC);

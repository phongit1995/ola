ALTER TABLE public.admin_sessions
    ADD COLUMN previous_refresh_token_hash character(64),
    ADD COLUMN last_rotated_at timestamp without time zone,
    ADD COLUMN refresh_retry_response bytea,
    ADD CONSTRAINT admin_sessions_previous_refresh_token_hash_check
        CHECK (previous_refresh_token_hash IS NULL OR length(previous_refresh_token_hash) = 64),
    ADD CONSTRAINT admin_sessions_refresh_retry_state_check CHECK (
        (previous_refresh_token_hash IS NULL AND last_rotated_at IS NULL AND refresh_retry_response IS NULL)
        OR
        (previous_refresh_token_hash IS NOT NULL AND last_rotated_at IS NOT NULL AND refresh_retry_response IS NOT NULL)
    );

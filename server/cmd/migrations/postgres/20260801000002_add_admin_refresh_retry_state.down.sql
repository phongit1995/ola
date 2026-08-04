ALTER TABLE public.admin_sessions
    DROP CONSTRAINT IF EXISTS admin_sessions_refresh_retry_state_check,
    DROP CONSTRAINT IF EXISTS admin_sessions_previous_refresh_token_hash_check,
    DROP COLUMN IF EXISTS refresh_retry_response,
    DROP COLUMN IF EXISTS last_rotated_at,
    DROP COLUMN IF EXISTS previous_refresh_token_hash;

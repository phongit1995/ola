CREATE UNIQUE INDEX IF NOT EXISTS ux_user_sessions_active_device
    ON public.user_sessions (user_id, device_id)
    WHERE device_id <> '' AND revoked_at IS NULL;

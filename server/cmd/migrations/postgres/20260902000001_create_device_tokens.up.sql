CREATE TABLE IF NOT EXISTS public.device_tokens (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    session_id uuid NOT NULL REFERENCES public.user_sessions(id) ON DELETE CASCADE ON UPDATE CASCADE,
    device_id character varying(128) NOT NULL,
    platform character varying(20) NOT NULL,
    token text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT device_tokens_pkey PRIMARY KEY (id),
    CONSTRAINT device_tokens_platform_check CHECK (platform IN ('android', 'ios', 'web'))
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_device_tokens_token ON public.device_tokens (token);
CREATE UNIQUE INDEX IF NOT EXISTS uq_device_tokens_user_device ON public.device_tokens (user_id, device_id);
CREATE INDEX IF NOT EXISTS idx_device_tokens_session ON public.device_tokens (session_id);

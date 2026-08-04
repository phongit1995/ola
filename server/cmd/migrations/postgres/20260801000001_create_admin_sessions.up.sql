CREATE TABLE public.admin_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    admin_id uuid NOT NULL,
    refresh_token_hash character(64) NOT NULL,
    user_agent text,
    ip_address character varying(45),
    last_active_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT admin_sessions_pkey PRIMARY KEY (id),
    CONSTRAINT admin_sessions_admin_id_fkey FOREIGN KEY (admin_id)
        REFERENCES public.admin_users(id) ON DELETE CASCADE,
    CONSTRAINT admin_sessions_refresh_token_hash_check
        CHECK (length(refresh_token_hash) = 64)
);

CREATE INDEX idx_admin_sessions_admin_id
    ON public.admin_sessions USING btree (admin_id);

CREATE INDEX idx_admin_sessions_active
    ON public.admin_sessions USING btree (admin_id, last_active_at DESC)
    WHERE revoked_at IS NULL AND deleted_at IS NULL;

CREATE INDEX idx_admin_sessions_deleted_at
    ON public.admin_sessions USING btree (deleted_at);

CREATE INDEX idx_admin_sessions_expires_at
    ON public.admin_sessions USING btree (expires_at);

-- Legacy admin refresh tokens do not carry a session id or token-use claim and
-- must not remain usable after the session-based flow is deployed.
UPDATE public.admin_users SET refresh_token = NULL WHERE refresh_token IS NOT NULL;

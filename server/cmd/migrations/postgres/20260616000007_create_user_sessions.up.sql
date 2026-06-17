CREATE TABLE public.user_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    refresh_token text NOT NULL,
    device_name character varying(255),
    platform character varying(20),
    device_id character varying(128),
    app_version character varying(40),
    user_agent text,
    ip_address character varying(45),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_active_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    revoked_at timestamp without time zone,
    deleted_at timestamp without time zone,
    CONSTRAINT user_sessions_pkey PRIMARY KEY (id)
);

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT fk_user_sessions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

CREATE INDEX idx_user_sessions_user ON public.user_sessions USING btree (user_id);
CREATE INDEX idx_user_sessions_active ON public.user_sessions USING btree (user_id, revoked_at);
CREATE INDEX idx_user_sessions_device ON public.user_sessions USING btree (user_id, device_id);

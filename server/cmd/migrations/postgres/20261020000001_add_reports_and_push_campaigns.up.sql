CREATE TABLE public.reports (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reporter_id uuid NOT NULL,
    target_type character varying(20) NOT NULL,
    target_id character varying(64) NOT NULL,
    context_id character varying(64),
    reported_user_id uuid,
    reason character varying(20) NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    snapshot jsonb,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    handled_by uuid,
    handled_at timestamp with time zone,
    handler_note text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT reports_target_type_check CHECK (((target_type)::text = ANY ((ARRAY['account'::character varying, 'post'::character varying, 'comment'::character varying, 'story_comment'::character varying, 'message'::character varying, 'room_message'::character varying])::text[]))),
    CONSTRAINT reports_reason_check CHECK (((reason)::text = ANY ((ARRAY['spam'::character varying, 'sensitive'::character varying, 'scam'::character varying, 'harassment'::character varying, 'other'::character varying])::text[]))),
    CONSTRAINT reports_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'resolved'::character varying, 'dismissed'::character varying])::text[])))
);

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT fk_reports_reporter FOREIGN KEY (reporter_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT fk_reports_reported_user FOREIGN KEY (reported_user_id) REFERENCES public.users(id) ON DELETE SET NULL;

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT fk_reports_handled_by FOREIGN KEY (handled_by) REFERENCES public.admin_users(id) ON DELETE SET NULL;

CREATE UNIQUE INDEX uq_reports_pending_reporter_target ON public.reports USING btree (reporter_id, target_type, target_id) WHERE (((status)::text = 'pending'::text) AND (deleted_at IS NULL));

CREATE INDEX idx_reports_status_created ON public.reports USING btree (status, created_at DESC) WHERE (deleted_at IS NULL);

CREATE INDEX idx_reports_target ON public.reports USING btree (target_type, target_id) WHERE (deleted_at IS NULL);

CREATE INDEX idx_reports_reported_user ON public.reports USING btree (reported_user_id) WHERE (deleted_at IS NULL);

CREATE INDEX idx_reports_deleted_at ON public.reports USING btree (deleted_at);

CREATE TABLE public.push_campaigns (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_by uuid,
    audience character varying(20) NOT NULL,
    target_user_id uuid,
    title character varying(100) NOT NULL,
    body character varying(500) NOT NULL,
    status character varying(20) DEFAULT 'queued'::character varying NOT NULL,
    total_devices integer DEFAULT 0 NOT NULL,
    success_count integer DEFAULT 0 NOT NULL,
    failure_count integer DEFAULT 0 NOT NULL,
    error text DEFAULT ''::text NOT NULL,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT push_campaigns_audience_check CHECK (((audience)::text = ANY ((ARRAY['all'::character varying, 'vip'::character varying, 'user'::character varying])::text[]))),
    CONSTRAINT push_campaigns_status_check CHECK (((status)::text = ANY ((ARRAY['queued'::character varying, 'sending'::character varying, 'done'::character varying, 'failed'::character varying])::text[])))
);

ALTER TABLE ONLY public.push_campaigns
    ADD CONSTRAINT push_campaigns_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.push_campaigns
    ADD CONSTRAINT fk_push_campaigns_created_by FOREIGN KEY (created_by) REFERENCES public.admin_users(id) ON DELETE SET NULL;

ALTER TABLE ONLY public.push_campaigns
    ADD CONSTRAINT fk_push_campaigns_target_user FOREIGN KEY (target_user_id) REFERENCES public.users(id) ON DELETE SET NULL;

CREATE INDEX idx_push_campaigns_created ON public.push_campaigns USING btree (created_at DESC) WHERE (deleted_at IS NULL);

CREATE INDEX idx_push_campaigns_deleted_at ON public.push_campaigns USING btree (deleted_at);

ALTER TABLE public.users
    ADD COLUMN IF NOT EXISTS locked_until timestamp with time zone,
    ADD COLUMN IF NOT EXISTS lock_reason character varying(20) DEFAULT ''::character varying NOT NULL;

CREATE TABLE IF NOT EXISTS public.user_violations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    source character varying(20) NOT NULL,
    target_type character varying(20) NOT NULL,
    target_id character varying(64) NOT NULL,
    report_id uuid,
    reason character varying(20) NOT NULL,
    severity character varying(20) NOT NULL,
    points smallint DEFAULT 0 NOT NULL,
    content_removed boolean DEFAULT false NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    admin_id uuid,
    revoked_at timestamp with time zone,
    revoked_by uuid,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT user_violations_pkey PRIMARY KEY (id),
    CONSTRAINT user_violations_source_check CHECK (((source)::text = ANY ((ARRAY['report'::character varying, 'me_hide'::character varying])::text[]))),
    CONSTRAINT user_violations_severity_check CHECK (((severity)::text = ANY ((ARRAY['none'::character varying, 'violation'::character varying, 'deliberate'::character varying])::text[]))),
    CONSTRAINT user_violations_points_check CHECK ((points >= 0)),
    CONSTRAINT fk_user_violations_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_violations_report FOREIGN KEY (report_id) REFERENCES public.reports(id) ON DELETE SET NULL,
    CONSTRAINT fk_user_violations_admin FOREIGN KEY (admin_id) REFERENCES public.admin_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_user_violations_revoked_by FOREIGN KEY (revoked_by) REFERENCES public.admin_users(id) ON DELETE SET NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_violations_content ON public.user_violations USING btree (target_type, target_id) WHERE ((revoked_at IS NULL) AND (points > 0) AND ((target_type)::text <> 'account'::text));

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_violations_report ON public.user_violations USING btree (report_id) WHERE ((report_id IS NOT NULL) AND (revoked_at IS NULL) AND (points > 0));

CREATE INDEX IF NOT EXISTS idx_user_violations_user_created ON public.user_violations USING btree (user_id, created_at DESC);

ALTER TABLE public.me
    ADD COLUMN IF NOT EXISTS hidden_by character varying(10),
    ADD COLUMN IF NOT EXISTS hidden_at timestamp with time zone;

ALTER TABLE public.me DROP CONSTRAINT IF EXISTS me_hidden_by_check;

ALTER TABLE public.me
    ADD CONSTRAINT me_hidden_by_check CHECK (((hidden_by IS NULL) OR ((hidden_by)::text = ANY ((ARRAY['owner'::character varying, 'admin'::character varying, 'clan'::character varying])::text[]))));

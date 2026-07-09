CREATE TABLE public.ken_chest_auto_jobs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) DEFAULT ''::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    schedule_type character varying(10) DEFAULT 'interval'::character varying NOT NULL,
    interval_min_minutes integer,
    interval_max_minutes integer,
    daily_times jsonb,
    reward_mode character varying(10) NOT NULL,
    ken_amount integer,
    ken_min integer,
    ken_max integer,
    max_recipients integer NOT NULL,
    duration_seconds integer DEFAULT 90 NOT NULL,
    remaining_runs integer,
    run_count integer DEFAULT 0 NOT NULL,
    next_run_at timestamp with time zone,
    last_run_at timestamp with time zone,
    created_by uuid,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT ken_chest_auto_jobs_pkey PRIMARY KEY (id),
    CONSTRAINT ken_chest_auto_jobs_schedule_type_check CHECK (((schedule_type)::text = ANY ((ARRAY['interval'::character varying, 'daily'::character varying])::text[]))),
    CONSTRAINT ken_chest_auto_jobs_reward_mode_check CHECK (((reward_mode)::text = ANY ((ARRAY['fixed'::character varying, 'random'::character varying])::text[]))),
    CONSTRAINT ken_chest_auto_jobs_duration_check CHECK (((duration_seconds >= 30) AND (duration_seconds <= 600))),
    CONSTRAINT ken_chest_auto_jobs_max_recipients_check CHECK ((max_recipients > 0)),
    CONSTRAINT ken_chest_auto_jobs_remaining_runs_check CHECK ((remaining_runs IS NULL OR remaining_runs >= 0)),
    CONSTRAINT ken_chest_auto_jobs_interval_check CHECK ((((schedule_type)::text <> 'interval'::text) OR ((interval_min_minutes IS NOT NULL) AND (interval_max_minutes IS NOT NULL) AND (interval_min_minutes > 0) AND (interval_max_minutes >= interval_min_minutes)))),
    CONSTRAINT ken_chest_auto_jobs_daily_check CHECK ((((schedule_type)::text <> 'daily'::text) OR ((daily_times IS NOT NULL) AND (jsonb_array_length(daily_times) > 0)))),
    CONSTRAINT ken_chest_auto_jobs_fixed_amount_check CHECK ((((reward_mode)::text <> 'fixed'::text) OR ((ken_amount IS NOT NULL) AND (ken_amount > 0)))),
    CONSTRAINT ken_chest_auto_jobs_random_range_check CHECK ((((reward_mode)::text <> 'random'::text) OR ((ken_min IS NOT NULL) AND (ken_max IS NOT NULL) AND (ken_min > 0) AND (ken_max >= ken_min))))
);

CREATE INDEX idx_ken_chest_auto_jobs_enabled_next ON public.ken_chest_auto_jobs USING btree (enabled, next_run_at);

CREATE TABLE public.ken_chest_auto_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT ken_chest_auto_settings_pkey PRIMARY KEY (id)
);

INSERT INTO public.ken_chest_auto_settings (enabled) VALUES (true);

ALTER TABLE public.ken_chests ADD COLUMN source character varying(10) DEFAULT 'manual'::character varying NOT NULL;
ALTER TABLE public.ken_chests ADD COLUMN auto_job_id uuid;
ALTER TABLE public.ken_chests ADD CONSTRAINT ken_chests_source_check CHECK (((source)::text = ANY ((ARRAY['manual'::character varying, 'auto'::character varying])::text[])));
ALTER TABLE public.ken_chests ADD CONSTRAINT ken_chests_auto_job_id_fkey FOREIGN KEY (auto_job_id) REFERENCES public.ken_chest_auto_jobs(id) ON DELETE SET NULL;

CREATE INDEX idx_ken_chests_source ON public.ken_chests USING btree (source);

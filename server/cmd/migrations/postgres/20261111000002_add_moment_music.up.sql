ALTER TABLE public.moments
    ADD COLUMN IF NOT EXISTS music_url text NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS music_object character varying(500) NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS music_title character varying(80) NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS music_start_ms integer NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS music_duration_ms integer NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS music_source_hash character varying(64) NOT NULL DEFAULT '';

CREATE INDEX IF NOT EXISTS idx_moments_music_source_hash ON public.moments USING btree (music_source_hash) WHERE music_source_hash <> '';

CREATE TABLE IF NOT EXISTS public.moment_music_blocks (
    hash character varying(64) PRIMARY KEY,
    title character varying(80) NOT NULL DEFAULT '',
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE public.reports DROP CONSTRAINT IF EXISTS reports_reason_check;

ALTER TABLE public.reports ADD CONSTRAINT reports_reason_check CHECK (((reason)::text = ANY ((ARRAY['spam'::character varying, 'sensitive'::character varying, 'scam'::character varying, 'harassment'::character varying, 'copyright'::character varying, 'other'::character varying])::text[])));

CREATE TABLE IF NOT EXISTS public.moment_music_delete_queue (
    object_name character varying(500) PRIMARY KEY,
    attempts integer NOT NULL DEFAULT 0,
    next_attempt_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_moment_music_delete_queue_next_attempt ON public.moment_music_delete_queue USING btree (next_attempt_at);

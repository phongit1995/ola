DROP TABLE IF EXISTS public.moment_music_delete_queue;

UPDATE public.reports SET reason = 'other' WHERE reason = 'copyright';

ALTER TABLE public.reports DROP CONSTRAINT IF EXISTS reports_reason_check;

ALTER TABLE public.reports ADD CONSTRAINT reports_reason_check CHECK (((reason)::text = ANY ((ARRAY['spam'::character varying, 'sensitive'::character varying, 'scam'::character varying, 'harassment'::character varying, 'other'::character varying])::text[])));

DROP TABLE IF EXISTS public.moment_music_blocks;

DROP INDEX IF EXISTS public.idx_moments_music_source_hash;

ALTER TABLE public.moments
    DROP COLUMN IF EXISTS music_url,
    DROP COLUMN IF EXISTS music_object,
    DROP COLUMN IF EXISTS music_title,
    DROP COLUMN IF EXISTS music_start_ms,
    DROP COLUMN IF EXISTS music_duration_ms,
    DROP COLUMN IF EXISTS music_source_hash;

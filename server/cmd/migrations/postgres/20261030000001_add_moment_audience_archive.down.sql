ALTER TABLE public.moments
    DROP COLUMN IF EXISTS audience_archived_at,
    DROP COLUMN IF EXISTS archived_reactors_lost,
    DROP COLUMN IF EXISTS archived_viewers_lost,
    DROP COLUMN IF EXISTS archived_reactors,
    DROP COLUMN IF EXISTS archived_viewers;

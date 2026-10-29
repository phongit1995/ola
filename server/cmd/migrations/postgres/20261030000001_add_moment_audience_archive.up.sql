ALTER TABLE public.moments
    ADD COLUMN archived_viewers jsonb,
    ADD COLUMN archived_reactors jsonb,
    ADD COLUMN archived_viewers_lost boolean DEFAULT false NOT NULL,
    ADD COLUMN archived_reactors_lost boolean DEFAULT false NOT NULL,
    ADD COLUMN audience_archived_at timestamp with time zone;

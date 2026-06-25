ALTER TABLE public.users ADD COLUMN IF NOT EXISTS anti_count integer NOT NULL DEFAULT 0;

UPDATE public.users u
SET anti_count = (
    SELECT COUNT(*) FROM relationships r
    WHERE r.addressee_id = u.id
      AND r.status = 'blocked'
      AND r.deleted_at IS NULL
);

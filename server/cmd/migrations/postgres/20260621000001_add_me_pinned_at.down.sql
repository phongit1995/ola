DROP INDEX IF EXISTS idx_me_author_pinned;

ALTER TABLE public.me DROP COLUMN IF EXISTS pinned_at;

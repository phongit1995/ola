DROP INDEX IF EXISTS public.idx_reels_created;

ALTER TABLE public.reels DROP COLUMN IF EXISTS enabled;

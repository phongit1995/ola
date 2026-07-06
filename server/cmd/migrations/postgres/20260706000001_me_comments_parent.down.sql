DROP INDEX IF EXISTS public.idx_me_comments_parent_created;

ALTER TABLE ONLY public.me_comments DROP CONSTRAINT IF EXISTS fk_me_comments_parent;

ALTER TABLE public.me_comments DROP COLUMN IF EXISTS parent_id;

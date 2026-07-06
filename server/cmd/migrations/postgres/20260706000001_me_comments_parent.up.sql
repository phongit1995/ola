ALTER TABLE public.me_comments ADD COLUMN IF NOT EXISTS parent_id uuid;

ALTER TABLE ONLY public.me_comments
    ADD CONSTRAINT fk_me_comments_parent FOREIGN KEY (parent_id) REFERENCES public.me_comments(id) ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_me_comments_parent_created ON public.me_comments USING btree (parent_id, created_at) WHERE (deleted_at IS NULL);

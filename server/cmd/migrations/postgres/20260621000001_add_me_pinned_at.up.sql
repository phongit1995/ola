ALTER TABLE public.me ADD COLUMN pinned_at timestamp without time zone;

CREATE INDEX idx_me_author_pinned ON public.me USING btree (author_id, pinned_at DESC NULLS LAST, created_at DESC, id DESC) WHERE deleted_at IS NULL;

ALTER TABLE public.reels ADD COLUMN enabled boolean DEFAULT true NOT NULL;

CREATE INDEX idx_reels_created ON public.reels USING btree (created_at DESC);

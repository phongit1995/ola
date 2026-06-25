CREATE TABLE public.profile_views (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    viewer_id uuid NOT NULL,
    owner_id uuid NOT NULL,
    viewed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT profile_views_pkey PRIMARY KEY (id),
    CONSTRAINT uq_profile_views_owner_viewer UNIQUE (owner_id, viewer_id)
);

ALTER TABLE ONLY public.profile_views
    ADD CONSTRAINT fk_profile_views_viewer FOREIGN KEY (viewer_id) REFERENCES public.users(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.profile_views
    ADD CONSTRAINT fk_profile_views_owner FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;

CREATE INDEX idx_profile_views_owner_time ON public.profile_views USING btree (owner_id, viewed_at DESC);

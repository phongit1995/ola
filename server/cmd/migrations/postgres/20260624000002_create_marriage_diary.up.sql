CREATE TABLE public.marriage_diary_entries (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    marriage_id uuid NOT NULL,
    author_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT marriage_diary_entries_pkey PRIMARY KEY (id)
);

ALTER TABLE ONLY public.marriage_diary_entries
    ADD CONSTRAINT fk_mde_marriage FOREIGN KEY (marriage_id) REFERENCES public.marriages(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.marriage_diary_entries
    ADD CONSTRAINT fk_mde_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;

CREATE INDEX idx_mde_marriage ON public.marriage_diary_entries USING btree (marriage_id, created_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX idx_mde_author ON public.marriage_diary_entries USING btree (author_id) WHERE deleted_at IS NULL;

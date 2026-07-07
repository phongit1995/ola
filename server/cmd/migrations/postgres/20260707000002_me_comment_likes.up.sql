ALTER TABLE public.me_comments ADD COLUMN IF NOT EXISTS like_count integer DEFAULT 0 NOT NULL;

CREATE TABLE IF NOT EXISTS public.me_comment_likes (
    comment_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE ONLY public.me_comment_likes
    ADD CONSTRAINT me_comment_likes_pkey PRIMARY KEY (comment_id, user_id);

ALTER TABLE ONLY public.me_comment_likes
    ADD CONSTRAINT fk_me_comment_likes_comment FOREIGN KEY (comment_id) REFERENCES public.me_comments(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.me_comment_likes
    ADD CONSTRAINT fk_me_comment_likes_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_me_comment_likes_user ON public.me_comment_likes USING btree (user_id);

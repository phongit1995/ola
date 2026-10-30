ALTER TABLE public.moments ADD COLUMN IF NOT EXISTS comment_count integer DEFAULT 0 NOT NULL;

CREATE TABLE IF NOT EXISTS public.moment_comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    moment_id uuid NOT NULL,
    author_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT moment_comments_pkey PRIMARY KEY (id),
    CONSTRAINT uq_moment_comments_author UNIQUE (moment_id, author_id),
    CONSTRAINT fk_moment_comments_moment FOREIGN KEY (moment_id) REFERENCES public.moments(id) ON DELETE CASCADE,
    CONSTRAINT fk_moment_comments_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_moment_comments_moment_created ON public.moment_comments USING btree (moment_id, created_at DESC, id DESC);

ALTER TABLE public.me_notifications ADD COLUMN IF NOT EXISTS actor_count integer DEFAULT 1 NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uq_me_notifications_moment_reaction ON public.me_notifications USING btree (recipient_id, post_id) WHERE ((type)::text = 'moment_reaction'::text);

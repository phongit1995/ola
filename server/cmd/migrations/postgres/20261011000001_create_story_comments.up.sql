CREATE TABLE IF NOT EXISTS public.story_comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    story_id uuid NOT NULL REFERENCES public.stories(id) ON DELETE CASCADE,
    author_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    parent_id uuid REFERENCES public.story_comments(id) ON DELETE SET NULL,
    content text NOT NULL,
    like_count integer DEFAULT 0 NOT NULL,
    created_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamptz,
    CONSTRAINT story_comments_pkey PRIMARY KEY (id)
);

CREATE INDEX IF NOT EXISTS idx_story_comments_story ON public.story_comments (story_id, created_at DESC, id DESC) WHERE deleted_at IS NULL;

CREATE INDEX IF NOT EXISTS idx_story_comments_author ON public.story_comments (author_id);

CREATE TABLE IF NOT EXISTS public.story_comment_likes (
    comment_id uuid NOT NULL REFERENCES public.story_comments(id) ON DELETE CASCADE,
    user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    created_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT story_comment_likes_pkey PRIMARY KEY (comment_id, user_id)
);

CREATE TABLE IF NOT EXISTS public.story_unlocks (
    user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    story_id uuid NOT NULL REFERENCES public.stories(id) ON DELETE CASCADE,
    source character varying(20) NOT NULL,
    comment_id uuid REFERENCES public.story_comments(id) ON DELETE SET NULL,
    created_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT story_unlocks_pkey PRIMARY KEY (user_id, story_id)
);

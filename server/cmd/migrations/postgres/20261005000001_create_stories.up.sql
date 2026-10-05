CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;

CREATE TABLE IF NOT EXISTS public.stories (
    id bigserial NOT NULL,
    source character varying(30) DEFAULT 'vnkings' NOT NULL,
    source_story_id bigint NOT NULL,
    slug character varying(255) NOT NULL,
    source_url text NOT NULL,
    title character varying(500) NOT NULL,
    author_name character varying(200) DEFAULT '' NOT NULL,
    source_author_id bigint,
    kind character varying(10) NOT NULL,
    genres text[] DEFAULT '{}' NOT NULL,
    tags text[] DEFAULT '{}' NOT NULL,
    intro text DEFAULT '' NOT NULL,
    cover_url text,
    status character varying(20) DEFAULT 'unknown' NOT NULL,
    age_rating character varying(100) DEFAULT '' NOT NULL,
    chapter_count integer DEFAULT 0 NOT NULL,
    word_count integer DEFAULT 0 NOT NULL,
    view_count bigint DEFAULT 0 NOT NULL,
    comment_count integer DEFAULT 0 NOT NULL,
    like_count integer DEFAULT 0 NOT NULL,
    published_at timestamptz NOT NULL,
    source_updated_at timestamptz NOT NULL,
    last_chapter_at timestamptz,
    crawled_at timestamptz,
    content_hash bytea,
    search_text text DEFAULT '' NOT NULL,
    is_hidden boolean DEFAULT false NOT NULL,
    created_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT stories_pkey PRIMARY KEY (id),
    CONSTRAINT stories_source_story_key UNIQUE (source, source_story_id),
    CONSTRAINT stories_kind_check CHECK (kind IN ('short', 'long')),
    CONSTRAINT stories_status_check CHECK (status IN ('ongoing', 'completed', 'unknown'))
);

CREATE OR REPLACE FUNCTION public.stories_set_search_text() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.search_text := lower(public.unaccent('public.unaccent'::regdictionary, NEW.title || ' ' || NEW.author_name));
    RETURN NEW;
END;
$$;

CREATE TRIGGER stories_search_text
    BEFORE INSERT OR UPDATE OF title, author_name ON public.stories
    FOR EACH ROW EXECUTE FUNCTION public.stories_set_search_text();

CREATE INDEX IF NOT EXISTS idx_stories_activity ON public.stories ((COALESCE(last_chapter_at, source_updated_at)) DESC, id DESC) WHERE NOT is_hidden;

CREATE INDEX IF NOT EXISTS idx_stories_views ON public.stories (view_count DESC, id DESC) WHERE NOT is_hidden;

CREATE INDEX IF NOT EXISTS idx_stories_published ON public.stories (published_at DESC, id DESC) WHERE NOT is_hidden;

CREATE INDEX IF NOT EXISTS idx_stories_genres ON public.stories USING gin (genres);

CREATE INDEX IF NOT EXISTS idx_stories_search_text ON public.stories USING gin (search_text public.gin_trgm_ops);

CREATE TABLE IF NOT EXISTS public.story_chapters (
    id bigserial NOT NULL,
    story_id bigint NOT NULL REFERENCES public.stories(id) ON DELETE CASCADE,
    source_chapter_id bigint NOT NULL,
    "position" integer NOT NULL,
    title character varying(500) NOT NULL,
    source_url text NOT NULL,
    content_text text DEFAULT '' NOT NULL,
    word_count integer DEFAULT 0 NOT NULL,
    published_at timestamptz,
    crawled_at timestamptz,
    content_hash bytea,
    created_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT story_chapters_pkey PRIMARY KEY (id),
    CONSTRAINT story_chapters_source_key UNIQUE (story_id, source_chapter_id),
    CONSTRAINT story_chapters_position_key UNIQUE (story_id, "position") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE public.moments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    author_id uuid NOT NULL,
    type character varying(10) NOT NULL,
    "position" smallint DEFAULT 0 NOT NULL,
    background character varying(32) DEFAULT ''::character varying NOT NULL,
    overlays jsonb DEFAULT '[]'::jsonb NOT NULL,
    media_url text DEFAULT ''::text NOT NULL,
    media_object character varying(500) DEFAULT ''::character varying NOT NULL,
    source_object character varying(500) DEFAULT ''::character varying NOT NULL,
    thumb_url text DEFAULT ''::text NOT NULL,
    thumb_object character varying(500) DEFAULT ''::character varying NOT NULL,
    width integer DEFAULT 0 NOT NULL,
    height integer DEFAULT 0 NOT NULL,
    duration double precision DEFAULT 0 NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    mime_type character varying(50) DEFAULT ''::character varying NOT NULL,
    visibility character varying(20) DEFAULT 'friend'::character varying NOT NULL,
    status character varying(20) DEFAULT 'ready'::character varying NOT NULL,
    processing_attempts smallint DEFAULT 0 NOT NULL,
    processing_failures smallint DEFAULT 0 NOT NULL,
    processing_started_at timestamp with time zone,
    processing_retry_at timestamp with time zone,
    purged_at timestamp with time zone,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    enabled boolean DEFAULT true NOT NULL,
    hidden_by character varying(10),
    hidden_at timestamp with time zone,
    viewer_count integer DEFAULT 0 NOT NULL,
    reaction_counts jsonb DEFAULT '{}'::jsonb NOT NULL,
    comment_count integer DEFAULT 0 NOT NULL,
    CONSTRAINT moments_hidden_by_check CHECK (((hidden_by IS NULL) OR ((hidden_by)::text = ANY ((ARRAY['owner'::character varying, 'admin'::character varying])::text[])))),
    CONSTRAINT moments_type_check CHECK (((type)::text = ANY ((ARRAY['image'::character varying, 'video'::character varying, 'text'::character varying])::text[]))),
    CONSTRAINT moments_visibility_check CHECK (((visibility)::text = ANY ((ARRAY['public'::character varying, 'friend'::character varying])::text[]))),
    CONSTRAINT moments_status_check CHECK (((status)::text = ANY ((ARRAY['ready'::character varying, 'processing'::character varying, 'failed'::character varying, 'purging'::character varying, 'purged'::character varying])::text[])))
);

ALTER TABLE ONLY public.moments
    ADD CONSTRAINT moments_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.moments
    ADD CONSTRAINT fk_moments_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;

CREATE INDEX idx_moments_author_expires ON public.moments USING btree (author_id, expires_at) WHERE (deleted_at IS NULL);

CREATE INDEX idx_moments_expires ON public.moments USING btree (expires_at);

CREATE INDEX idx_moments_unpurged ON public.moments USING btree (expires_at) WHERE ((status)::text <> 'purged'::text);

CREATE INDEX idx_moments_processing ON public.moments USING btree (created_at) WHERE (((status)::text = 'processing'::text) AND (deleted_at IS NULL));

CREATE INDEX idx_moments_source_leftover ON public.moments USING btree (created_at) WHERE (((status)::text = 'ready'::text) AND ((source_object)::text <> ''::text));

CREATE INDEX idx_moments_created ON public.moments USING btree (created_at DESC);

CREATE INDEX idx_moments_author_created ON public.moments USING btree (author_id, created_at DESC) WHERE (deleted_at IS NULL);

CREATE INDEX idx_moments_purge_candidates ON public.moments USING btree (created_at, id) WHERE ((status)::text IN ('ready', 'failed', 'purging')) AND ((type)::text <> 'text');

CREATE TABLE public.moment_comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    moment_id uuid NOT NULL,
    author_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE ONLY public.moment_comments
    ADD CONSTRAINT moment_comments_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.moment_comments
    ADD CONSTRAINT uq_moment_comments_author UNIQUE (moment_id, author_id);

ALTER TABLE ONLY public.moment_comments
    ADD CONSTRAINT fk_moment_comments_moment FOREIGN KEY (moment_id) REFERENCES public.moments(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.moment_comments
    ADD CONSTRAINT fk_moment_comments_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;

CREATE INDEX idx_moment_comments_moment_created ON public.moment_comments USING btree (moment_id, created_at DESC, id DESC);

ALTER TABLE public.reports DROP CONSTRAINT reports_target_type_check;

ALTER TABLE public.reports
    ADD CONSTRAINT reports_target_type_check CHECK (((target_type)::text = ANY ((ARRAY['account'::character varying, 'post'::character varying, 'comment'::character varying, 'story_comment'::character varying, 'message'::character varying, 'room_message'::character varying, 'moment'::character varying])::text[])));

WITH normalized AS (
    SELECT id, reporter_id, target_type, status, deleted_at, created_at, (target_id)::text AS target_id,
        CASE
            WHEN (target_id)::text ~* '^(urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|\{[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\}|[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|[0-9a-f]{32})$'
                THEN ((regexp_replace((target_id)::text, '^urn:uuid:', '', 'i'))::uuid)::text
            ELSE (target_id)::text
        END AS canonical
    FROM public.reports
    WHERE ((target_type)::text = ANY ((ARRAY['account'::character varying, 'post'::character varying, 'comment'::character varying, 'story_comment'::character varying, 'message'::character varying, 'moment'::character varying])::text[]))
), duplicates AS (
    SELECT id FROM (
        SELECT id, row_number() OVER (
            PARTITION BY reporter_id, target_type, canonical
            ORDER BY (target_id = canonical) DESC, created_at ASC, id ASC
        ) AS rn
        FROM normalized
        WHERE ((status)::text = 'pending'::text) AND (deleted_at IS NULL)
    ) ranked
    WHERE rn > 1
)
UPDATE public.reports r
SET target_id = n.canonical,
    deleted_at = CASE WHEN d.id IS NULL THEN r.deleted_at ELSE CURRENT_TIMESTAMP END
FROM normalized n
LEFT JOIN duplicates d ON d.id = n.id
WHERE r.id = n.id AND (n.target_id <> n.canonical OR d.id IS NOT NULL);

ALTER TABLE public.me_notifications ADD COLUMN actor_count integer DEFAULT 1 NOT NULL;

CREATE UNIQUE INDEX uq_me_notifications_moment_reaction ON public.me_notifications USING btree (recipient_id, post_id) WHERE ((type)::text = 'moment_reaction'::text);

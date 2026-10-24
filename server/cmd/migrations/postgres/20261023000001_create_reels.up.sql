CREATE TABLE public.reels (
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
    CONSTRAINT reels_type_check CHECK (((type)::text = ANY ((ARRAY['image'::character varying, 'video'::character varying, 'text'::character varying])::text[]))),
    CONSTRAINT reels_visibility_check CHECK (((visibility)::text = ANY ((ARRAY['public'::character varying, 'friend'::character varying])::text[]))),
    CONSTRAINT reels_status_check CHECK (((status)::text = ANY ((ARRAY['ready'::character varying, 'processing'::character varying, 'failed'::character varying, 'purging'::character varying, 'purged'::character varying])::text[])))
);

ALTER TABLE ONLY public.reels
    ADD CONSTRAINT reels_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.reels
    ADD CONSTRAINT fk_reels_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;

CREATE INDEX idx_reels_author_expires ON public.reels USING btree (author_id, expires_at) WHERE (deleted_at IS NULL);

CREATE INDEX idx_reels_expires ON public.reels USING btree (expires_at);

CREATE INDEX idx_reels_unpurged ON public.reels USING btree (expires_at) WHERE ((status)::text <> 'purged'::text);

CREATE INDEX idx_reels_processing ON public.reels USING btree (created_at) WHERE (((status)::text = 'processing'::text) AND (deleted_at IS NULL));

CREATE INDEX idx_reels_source_leftover ON public.reels USING btree (created_at) WHERE (((status)::text = 'ready'::text) AND ((source_object)::text <> ''::text));

ALTER TABLE public.reports DROP CONSTRAINT reports_target_type_check;

ALTER TABLE public.reports
    ADD CONSTRAINT reports_target_type_check CHECK (((target_type)::text = ANY ((ARRAY['account'::character varying, 'post'::character varying, 'comment'::character varying, 'story_comment'::character varying, 'message'::character varying, 'room_message'::character varying, 'reel'::character varying])::text[])));

WITH normalized AS (
    SELECT id, reporter_id, target_type, status, deleted_at, created_at, (target_id)::text AS target_id,
        CASE
            WHEN (target_id)::text ~* '^(urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|\{[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\}|[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|[0-9a-f]{32})$'
                THEN ((regexp_replace((target_id)::text, '^urn:uuid:', '', 'i'))::uuid)::text
            ELSE (target_id)::text
        END AS canonical
    FROM public.reports
    WHERE ((target_type)::text = ANY ((ARRAY['account'::character varying, 'post'::character varying, 'comment'::character varying, 'story_comment'::character varying, 'message'::character varying, 'reel'::character varying])::text[]))
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

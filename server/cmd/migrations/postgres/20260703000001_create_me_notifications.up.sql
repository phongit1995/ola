CREATE TABLE IF NOT EXISTS public.me_notifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    recipient_id uuid NOT NULL,
    actor_id uuid NOT NULL,
    type character varying(20) NOT NULL,
    post_id uuid NOT NULL,
    comment_id uuid,
    preview text,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT me_notifications_pkey PRIMARY KEY (id)
);

CREATE INDEX IF NOT EXISTS idx_me_notifications_recipient_created ON public.me_notifications USING btree (recipient_id, created_at DESC) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_me_notifications_recipient_unread ON public.me_notifications USING btree (recipient_id, is_read) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_me_notifications_deleted_at ON public.me_notifications USING btree (deleted_at);
CREATE UNIQUE INDEX IF NOT EXISTS uq_me_notifications_like ON public.me_notifications USING btree (recipient_id, actor_id, post_id) WHERE (type = 'like');

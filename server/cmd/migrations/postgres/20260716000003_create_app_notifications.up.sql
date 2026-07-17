CREATE TABLE IF NOT EXISTS public.app_notifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    recipient_id uuid NOT NULL,
    actor_id uuid,
    type character varying(30) NOT NULL,
    ref_id uuid,
    preview text,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT app_notifications_pkey PRIMARY KEY (id)
);

CREATE INDEX IF NOT EXISTS idx_app_notifications_recipient_created ON public.app_notifications USING btree (recipient_id, created_at DESC) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_app_notifications_recipient_unread ON public.app_notifications USING btree (recipient_id, is_read) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_app_notifications_deleted_at ON public.app_notifications USING btree (deleted_at);
CREATE UNIQUE INDEX IF NOT EXISTS uq_app_notifications_recipient_type_ref ON public.app_notifications USING btree (recipient_id, type, ref_id) WHERE (ref_id IS NOT NULL);

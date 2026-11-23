CREATE TABLE IF NOT EXISTS public.user_megaphone_tickets (
    id uuid DEFAULT gen_random_uuid() NOT NULL PRIMARY KEY,
    user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    source character varying(20) NOT NULL,
    source_ref uuid,
    expires_at timestamp with time zone,
    used_at timestamp with time zone,
    megaphone_id uuid,
    revoked_at timestamp with time zone,
    revoked_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_user_megaphone_tickets_expiry CHECK (expires_at IS NULL OR expires_at > created_at)
);

CREATE INDEX IF NOT EXISTS idx_user_megaphone_tickets_usable
    ON public.user_megaphone_tickets (user_id, expires_at)
    WHERE used_at IS NULL AND revoked_at IS NULL;

CREATE INDEX IF NOT EXISTS idx_user_megaphone_tickets_user_created
    ON public.user_megaphone_tickets (user_id, created_at DESC);

ALTER TABLE public.megaphones ADD COLUMN IF NOT EXISTS ticket_id uuid;

CREATE INDEX IF NOT EXISTS idx_megaphones_ticket_id
    ON public.megaphones (ticket_id)
    WHERE ticket_id IS NOT NULL;

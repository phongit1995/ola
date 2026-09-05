CREATE TABLE IF NOT EXISTS public.room_user_blocks (
    user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    blocked_user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT room_user_blocks_pkey PRIMARY KEY (user_id, blocked_user_id),
    CONSTRAINT room_user_blocks_not_self CHECK (user_id <> blocked_user_id)
);

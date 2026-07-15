ALTER TABLE public.users ADD COLUMN email_verified boolean NOT NULL DEFAULT false;
ALTER TABLE public.users ADD COLUMN email_verified_at timestamptz;

CREATE UNIQUE INDEX idx_users_email_verified_unique
    ON public.users (lower(email))
    WHERE email_verified = true AND deleted_at IS NULL;

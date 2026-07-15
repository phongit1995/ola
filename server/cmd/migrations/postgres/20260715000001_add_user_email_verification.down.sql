DROP INDEX IF EXISTS idx_users_email_verified_unique;
ALTER TABLE public.users DROP COLUMN IF EXISTS email_verified_at;
ALTER TABLE public.users DROP COLUMN IF EXISTS email_verified;

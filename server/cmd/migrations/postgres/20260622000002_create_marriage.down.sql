DROP TABLE IF EXISTS public.marriages;
DROP TABLE IF EXISTS public.marriage_proposals;

DROP INDEX IF EXISTS idx_users_spouse;
ALTER TABLE public.users DROP CONSTRAINT IF EXISTS fk_users_spouse;
ALTER TABLE public.users
    DROP COLUMN IF EXISTS spouse_id;

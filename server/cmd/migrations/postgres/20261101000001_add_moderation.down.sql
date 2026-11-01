ALTER TABLE public.me DROP CONSTRAINT IF EXISTS me_hidden_by_check;

ALTER TABLE public.me
    DROP COLUMN IF EXISTS hidden_at,
    DROP COLUMN IF EXISTS hidden_by;

DROP TABLE IF EXISTS public.user_violations;

ALTER TABLE public.users
    DROP COLUMN IF EXISTS lock_reason,
    DROP COLUMN IF EXISTS locked_until;

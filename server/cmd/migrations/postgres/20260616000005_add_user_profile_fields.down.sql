ALTER TABLE public.users
    DROP COLUMN IF EXISTS marriage,
    DROP COLUMN IF EXISTS cover_photo,
    DROP COLUMN IF EXISTS verified,
    DROP COLUMN IF EXISTS kisses;

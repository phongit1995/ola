ALTER TABLE public.rooms
    DROP COLUMN IF EXISTS vip_min_members,
    DROP COLUMN IF EXISTS vip_required;

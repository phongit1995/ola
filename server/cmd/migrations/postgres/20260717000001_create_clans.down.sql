DROP INDEX IF EXISTS idx_me_clan_author;
DROP INDEX IF EXISTS idx_me_clan_created;
ALTER TABLE public.me DROP COLUMN IF EXISTS clan_id;

DROP TABLE IF EXISTS public.clan_bans CASCADE;
DROP TABLE IF EXISTS public.clan_members CASCADE;
DROP TABLE IF EXISTS public.clans CASCADE;

ALTER TABLE public.egg_packs ADD COLUMN IF NOT EXISTS megaphone_enabled boolean DEFAULT true NOT NULL;

ALTER TABLE public.egg_packs ADD COLUMN IF NOT EXISTS odds_visibility jsonb DEFAULT '{"web":{"enabled":false,"disableVersions":[]},"android":{"enabled":true,"disableVersions":[]},"ios":{"enabled":true,"disableVersions":[]}}'::jsonb NOT NULL;

ALTER TABLE public.wheels ADD COLUMN IF NOT EXISTS megaphone_enabled boolean DEFAULT true NOT NULL;

ALTER TABLE public.wheels ADD COLUMN IF NOT EXISTS odds_visibility jsonb DEFAULT '{"web":{"enabled":false,"disableVersions":[]},"android":{"enabled":true,"disableVersions":[]},"ios":{"enabled":true,"disableVersions":[]}}'::jsonb NOT NULL;

ALTER TABLE public.megaphones ADD COLUMN IF NOT EXISTS lucky_reward jsonb;

ALTER TABLE public.megaphones DROP CONSTRAINT IF EXISTS megaphones_type_check;

ALTER TABLE public.megaphones
    ADD CONSTRAINT megaphones_type_check CHECK (((type)::text = ANY ((ARRAY['message'::character varying, 'gift'::character varying, 'lucky'::character varying])::text[])));

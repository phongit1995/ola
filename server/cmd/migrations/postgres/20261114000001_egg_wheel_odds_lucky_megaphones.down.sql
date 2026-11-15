DELETE FROM public.megaphones WHERE type = 'lucky';

ALTER TABLE public.megaphones DROP CONSTRAINT IF EXISTS megaphones_type_check;

ALTER TABLE public.megaphones
    ADD CONSTRAINT megaphones_type_check CHECK (((type)::text = ANY ((ARRAY['message'::character varying, 'gift'::character varying])::text[])));

ALTER TABLE public.megaphones DROP COLUMN IF EXISTS lucky_reward;

ALTER TABLE public.wheels DROP COLUMN IF EXISTS odds_visibility;

ALTER TABLE public.wheels DROP COLUMN IF EXISTS megaphone_enabled;

ALTER TABLE public.egg_packs DROP COLUMN IF EXISTS odds_visibility;

ALTER TABLE public.egg_packs DROP COLUMN IF EXISTS megaphone_enabled;

DELETE FROM public.reports WHERE target_type = 'megaphone';

ALTER TABLE public.reports DROP CONSTRAINT IF EXISTS reports_target_type_check;

ALTER TABLE public.reports
    ADD CONSTRAINT reports_target_type_check CHECK (((target_type)::text = ANY ((ARRAY['account'::character varying, 'post'::character varying, 'comment'::character varying, 'story_comment'::character varying, 'message'::character varying, 'room_message'::character varying, 'moment'::character varying])::text[])));

DROP TABLE IF EXISTS public.megaphones;

ALTER TABLE public.user_settings
    DROP COLUMN IF EXISTS gift_wall_privacy;

ALTER TABLE public.users
    DROP COLUMN IF EXISTS charm;

DROP TABLE IF EXISTS public.user_gift_wall;

DROP TABLE IF EXISTS public.gift_transactions;

DROP TABLE IF EXISTS public.gifts;

ALTER TABLE public.game_matches DROP CONSTRAINT IF EXISTS game_matches_ken_delta_check;

ALTER TABLE public.game_matches
    ADD CONSTRAINT game_matches_ken_delta_check
    CHECK (ken_delta >= 0 AND ken_delta <= bet) NOT VALID;

ALTER TABLE public.me DROP CONSTRAINT IF EXISTS me_hidden_by_check;

ALTER TABLE public.me
    DROP COLUMN IF EXISTS hidden_at,
    DROP COLUMN IF EXISTS hidden_by;

DROP TABLE IF EXISTS public.user_violations;

ALTER TABLE public.users
    DROP COLUMN IF EXISTS lock_reason,
    DROP COLUMN IF EXISTS locked_until;

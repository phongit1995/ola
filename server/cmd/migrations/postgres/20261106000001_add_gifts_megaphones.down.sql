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

DELETE FROM public.user_violations WHERE source = 'megaphone_remove';

ALTER TABLE public.user_violations DROP CONSTRAINT IF EXISTS user_violations_source_check;

ALTER TABLE public.user_violations
    ADD CONSTRAINT user_violations_source_check CHECK (((source)::text = ANY ((ARRAY['report'::character varying, 'me_hide'::character varying])::text[])));

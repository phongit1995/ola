DELETE FROM public.reports WHERE target_type = 'moment';

ALTER TABLE public.reports DROP CONSTRAINT reports_target_type_check;

ALTER TABLE public.reports
    ADD CONSTRAINT reports_target_type_check CHECK (((target_type)::text = ANY ((ARRAY['account'::character varying, 'post'::character varying, 'comment'::character varying, 'story_comment'::character varying, 'message'::character varying, 'room_message'::character varying])::text[])));

DROP TABLE IF EXISTS public.moments;

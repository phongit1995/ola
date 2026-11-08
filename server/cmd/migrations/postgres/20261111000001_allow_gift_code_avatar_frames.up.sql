ALTER TABLE public.user_avatar_frames DROP CONSTRAINT IF EXISTS user_avatar_frames_source_check;
ALTER TABLE public.user_avatar_frames ADD CONSTRAINT user_avatar_frames_source_check CHECK (((source)::text = ANY ((ARRAY['purchase'::character varying, 'gift'::character varying, 'transfer'::character varying, 'gift_code'::character varying])::text[])));

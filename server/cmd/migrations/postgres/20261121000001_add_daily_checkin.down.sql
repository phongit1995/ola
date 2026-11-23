UPDATE public.user_avatar_frames SET source = 'admin' WHERE source = 'checkin';
ALTER TABLE public.user_avatar_frames DROP CONSTRAINT IF EXISTS user_avatar_frames_source_check;
ALTER TABLE public.user_avatar_frames ADD CONSTRAINT user_avatar_frames_source_check CHECK (((source)::text = ANY ((ARRAY['purchase'::character varying, 'gift'::character varying, 'transfer'::character varying, 'gift_code'::character varying, 'admin'::character varying])::text[])));

DROP INDEX IF EXISTS public.idx_game_matches_player1_finished;
DROP INDEX IF EXISTS public.idx_game_matches_player0_finished;
DROP INDEX IF EXISTS public.idx_story_comments_author_created;
DROP INDEX IF EXISTS public.idx_moment_comments_author_created;
DROP INDEX IF EXISTS public.idx_me_reactions_user_updated;
DROP INDEX IF EXISTS public.idx_me_comments_author_created;

DROP TABLE IF EXISTS public.user_checkins;
DROP TABLE IF EXISTS public.checkin_slots;
DROP TABLE IF EXISTS public.checkin_months;

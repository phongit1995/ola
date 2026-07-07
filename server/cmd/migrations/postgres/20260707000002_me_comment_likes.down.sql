DROP TABLE IF EXISTS public.me_comment_likes;

ALTER TABLE public.me_comments DROP COLUMN IF EXISTS like_count;

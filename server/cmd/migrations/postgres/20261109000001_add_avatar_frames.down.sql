DROP TABLE IF EXISTS public.avatar_frame_transfers;

DROP TABLE IF EXISTS public.avatar_frame_purchases;

DROP TABLE IF EXISTS public.user_avatar_frames;

DROP TABLE IF EXISTS public.avatar_frame_shop_items;

ALTER TABLE public.user_settings DROP COLUMN IF EXISTS avatar_frame_store_privacy;

ALTER TABLE public.users DROP COLUMN IF EXISTS avatar_frame_id;

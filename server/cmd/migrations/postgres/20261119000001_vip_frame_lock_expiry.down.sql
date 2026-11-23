DROP TRIGGER IF EXISTS user_avatar_frames_lock_gift_code ON public.user_avatar_frames;

DROP TRIGGER IF EXISTS user_vip_icons_lock_gift_code ON public.user_vip_icons;

DROP FUNCTION IF EXISTS public.lock_gift_code_item();

ALTER TABLE public.users DROP COLUMN IF EXISTS avatar_frame_expires_at;

ALTER TABLE public.users DROP COLUMN IF EXISTS vip_used_expires_at;

UPDATE public.user_avatar_frames t SET deleted_at = now()
WHERE t.deleted_at IS NULL AND t.expires_at IS NOT NULL AND EXISTS (
    SELECT 1 FROM public.user_avatar_frames p
    WHERE p.user_id = t.user_id AND p.frame_id = t.frame_id AND p.deleted_at IS NULL AND p.expires_at IS NULL
);

DROP INDEX IF EXISTS public.uq_user_avatar_frames_owner_timed;

DROP INDEX IF EXISTS public.uq_user_avatar_frames_owner_permanent;

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_avatar_frames_owner ON public.user_avatar_frames USING btree (user_id, frame_id) WHERE (deleted_at IS NULL);

ALTER TABLE public.user_avatar_frames DROP COLUMN IF EXISTS expires_at;

ALTER TABLE public.user_avatar_frames DROP COLUMN IF EXISTS locked;

ALTER TABLE public.user_vip_icons DROP COLUMN IF EXISTS expires_at;

ALTER TABLE public.user_vip_icons DROP COLUMN IF EXISTS locked;

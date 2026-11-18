ALTER TABLE public.user_vip_icons ADD COLUMN IF NOT EXISTS locked boolean DEFAULT false NOT NULL;

ALTER TABLE public.user_vip_icons ADD COLUMN IF NOT EXISTS expires_at timestamp with time zone;

CREATE OR REPLACE FUNCTION public.lock_gift_code_item() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.source = 'gift_code' THEN
        NEW.locked := true;
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS user_vip_icons_lock_gift_code ON public.user_vip_icons;

CREATE TRIGGER user_vip_icons_lock_gift_code BEFORE INSERT ON public.user_vip_icons FOR EACH ROW EXECUTE FUNCTION public.lock_gift_code_item();

UPDATE public.user_vip_icons SET locked = true WHERE source = 'gift_code';

ALTER TABLE public.user_avatar_frames ADD COLUMN IF NOT EXISTS locked boolean DEFAULT false NOT NULL;

ALTER TABLE public.user_avatar_frames ADD COLUMN IF NOT EXISTS expires_at timestamp with time zone;

DROP TRIGGER IF EXISTS user_avatar_frames_lock_gift_code ON public.user_avatar_frames;

CREATE TRIGGER user_avatar_frames_lock_gift_code BEFORE INSERT ON public.user_avatar_frames FOR EACH ROW EXECUTE FUNCTION public.lock_gift_code_item();

UPDATE public.user_avatar_frames SET locked = true WHERE source = 'gift_code';

DROP INDEX IF EXISTS public.uq_user_avatar_frames_owner;

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_avatar_frames_owner_permanent ON public.user_avatar_frames USING btree (user_id, frame_id) WHERE ((deleted_at IS NULL) AND (expires_at IS NULL));

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_avatar_frames_owner_timed ON public.user_avatar_frames USING btree (user_id, frame_id) WHERE ((deleted_at IS NULL) AND (expires_at IS NOT NULL));

ALTER TABLE public.users ADD COLUMN IF NOT EXISTS vip_used_expires_at timestamp with time zone;

ALTER TABLE public.users ADD COLUMN IF NOT EXISTS avatar_frame_expires_at timestamp with time zone;

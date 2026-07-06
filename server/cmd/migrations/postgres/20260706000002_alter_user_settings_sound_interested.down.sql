ALTER TABLE public.user_settings
    ADD COLUMN show_online boolean DEFAULT true NOT NULL,
    ADD COLUMN notif_vibrate boolean DEFAULT true NOT NULL,
    DROP COLUMN show_interested,
    DROP COLUMN sound_game,
    DROP COLUMN sound_ken;

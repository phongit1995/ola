ALTER TABLE public.user_settings
    ADD COLUMN show_interested boolean DEFAULT true NOT NULL,
    ADD COLUMN sound_game boolean DEFAULT true NOT NULL,
    ADD COLUMN sound_ken boolean DEFAULT true NOT NULL,
    DROP COLUMN show_online,
    DROP COLUMN notif_vibrate;

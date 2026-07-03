CREATE TABLE IF NOT EXISTS public.user_settings (
    user_id uuid NOT NULL,
    message_privacy character varying(20) DEFAULT 'all' NOT NULL,
    me_visibility character varying(20) DEFAULT 'all' NOT NULL,
    comment_privacy character varying(20) DEFAULT 'all' NOT NULL,
    show_online boolean DEFAULT true NOT NULL,
    show_birthday boolean DEFAULT true NOT NULL,
    notif_message boolean DEFAULT true NOT NULL,
    notif_sound boolean DEFAULT true NOT NULL,
    notif_vibrate boolean DEFAULT true NOT NULL,
    font_size character varying(20) DEFAULT 'medium' NOT NULL,
    wallpaper_url text DEFAULT '' NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT user_settings_pkey PRIMARY KEY (user_id),
    CONSTRAINT user_settings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

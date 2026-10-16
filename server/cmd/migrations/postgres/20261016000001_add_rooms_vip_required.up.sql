ALTER TABLE public.rooms
    ADD COLUMN vip_required boolean DEFAULT false NOT NULL,
    ADD COLUMN vip_min_members integer DEFAULT 0 NOT NULL CONSTRAINT rooms_vip_min_members_check CHECK (vip_min_members >= 0);

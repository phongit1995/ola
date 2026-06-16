ALTER TABLE public.users
    ADD COLUMN marriage character varying(20) DEFAULT 'single'::character varying NOT NULL,
    ADD COLUMN cover_photo character varying(500),
    ADD COLUMN verified boolean DEFAULT false NOT NULL,
    ADD COLUMN kisses integer DEFAULT 0 NOT NULL;

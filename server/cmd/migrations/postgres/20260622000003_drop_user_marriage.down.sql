ALTER TABLE public.users ADD COLUMN marriage character varying(20) DEFAULT 'single'::character varying NOT NULL;

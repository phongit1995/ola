CREATE TABLE IF NOT EXISTS public.clans (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    handle character varying(32) NOT NULL,
    owner_id uuid NOT NULL,
    description text,
    avatar character varying(500) DEFAULT '' NOT NULL,
    cover character varying(500) DEFAULT '' NOT NULL,
    policy smallint DEFAULT 0 NOT NULL,
    member_public_post boolean DEFAULT false NOT NULL,
    member_count integer DEFAULT 1 NOT NULL,
    visit_count bigint DEFAULT 0 NOT NULL,
    me_top_post_id uuid,
    room_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT clans_pkey PRIMARY KEY (id),
    CONSTRAINT fk_clans_owner FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_clans_handle ON public.clans USING btree (handle) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_clans_owner ON public.clans USING btree (owner_id) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_clans_deleted_at ON public.clans USING btree (deleted_at);

CREATE TABLE IF NOT EXISTS public.clan_members (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    clan_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role character varying(12) DEFAULT 'member' NOT NULL,
    verified boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT clan_members_pkey PRIMARY KEY (id),
    CONSTRAINT fk_clan_members_clan FOREIGN KEY (clan_id) REFERENCES public.clans(id) ON DELETE CASCADE,
    CONSTRAINT fk_clan_members_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_clan_members_clan_user ON public.clan_members USING btree (clan_id, user_id) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_clan_members_user ON public.clan_members USING btree (user_id) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_clan_members_clan_role ON public.clan_members USING btree (clan_id, role) WHERE (deleted_at IS NULL);
CREATE UNIQUE INDEX IF NOT EXISTS uq_clan_members_one_owner ON public.clan_members USING btree (clan_id) WHERE (role = 'owner' AND deleted_at IS NULL);
CREATE UNIQUE INDEX IF NOT EXISTS uq_clan_members_one_deputy ON public.clan_members USING btree (clan_id) WHERE (role = 'deputy' AND deleted_at IS NULL);
CREATE UNIQUE INDEX IF NOT EXISTS uq_clan_members_one_ambassador ON public.clan_members USING btree (clan_id) WHERE (role = 'ambassador' AND deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_clan_members_deleted_at ON public.clan_members USING btree (deleted_at);

CREATE TABLE IF NOT EXISTS public.clan_bans (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    clan_id uuid NOT NULL,
    user_id uuid NOT NULL,
    banned_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT clan_bans_pkey PRIMARY KEY (id),
    CONSTRAINT fk_clan_bans_clan FOREIGN KEY (clan_id) REFERENCES public.clans(id) ON DELETE CASCADE,
    CONSTRAINT fk_clan_bans_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_clan_bans_clan_user ON public.clan_bans USING btree (clan_id, user_id) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_clan_bans_deleted_at ON public.clan_bans USING btree (deleted_at);

ALTER TABLE public.me ADD COLUMN IF NOT EXISTS clan_id uuid;
CREATE INDEX IF NOT EXISTS idx_me_clan_created ON public.me USING btree (clan_id, created_at DESC) WHERE (clan_id IS NOT NULL AND deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_me_clan_author ON public.me USING btree (clan_id, author_id) WHERE (clan_id IS NOT NULL AND deleted_at IS NULL);

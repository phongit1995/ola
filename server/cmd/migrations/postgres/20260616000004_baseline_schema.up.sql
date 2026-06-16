CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;

CREATE TABLE public.admin_users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    full_name character varying(100),
    email character varying(255),
    avatar character varying(500),
    role character varying(20) DEFAULT 'ADMIN'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    refresh_token text,
    last_login_ip character varying(45),
    last_login_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);

CREATE TABLE public.calls (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    conversation_id uuid NOT NULL,
    caller_id uuid NOT NULL,
    call_type character varying(10) NOT NULL,
    room_name character varying(255) NOT NULL,
    status character varying(20) DEFAULT 'ringing'::character varying NOT NULL,
    participants uuid[] DEFAULT '{}'::uuid[] NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    answered_at timestamp without time zone,
    ended_at timestamp without time zone,
    duration_seconds integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT check_call_status CHECK (((status)::text = ANY ((ARRAY['ringing'::character varying, 'active'::character varying, 'ended'::character varying, 'missed'::character varying, 'declined'::character varying])::text[]))),
    CONSTRAINT check_call_type CHECK (((call_type)::text = ANY ((ARRAY['audio'::character varying, 'video'::character varying])::text[])))
);

CREATE TABLE public.me (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    author_id uuid NOT NULL,
    content text,
    images jsonb,
    visibility character varying(20) DEFAULT 'public'::character varying NOT NULL,
    like_count integer DEFAULT 0 NOT NULL,
    dislike_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    comment_count integer DEFAULT 0 NOT NULL,
    mentions jsonb,
    sticker character varying(500),
    check_in jsonb,
    enabled boolean DEFAULT true NOT NULL
);

CREATE TABLE public.me_comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    post_id uuid NOT NULL,
    author_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);

CREATE TABLE public.me_reactions (
    post_id uuid NOT NULL,
    user_id uuid NOT NULL,
    type character varying(10) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE public.relationships (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    requester_id uuid NOT NULL,
    addressee_id uuid NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    actioned_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT check_no_self_relationship CHECK ((requester_id <> addressee_id)),
    CONSTRAINT check_relationship_status CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'accepted'::character varying, 'rejected'::character varying, 'blocked'::character varying])::text[])))
);

CREATE TABLE public.rooms (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(150) NOT NULL,
    description text,
    image_url character varying(500),
    max_members integer DEFAULT 0 NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    index integer DEFAULT 0 NOT NULL
);

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255),
    password character varying(255) NOT NULL,
    avatar character varying(500),
    phone character varying(20),
    full_name character varying(100),
    bio text DEFAULT 'hello ola!!!'::text,
    date_of_birth date,
    custom_info jsonb,
    refresh_token text,
    token_expires_at timestamp without time zone,
    last_login_ip character varying(45),
    last_login_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    is_active boolean DEFAULT true NOT NULL,
    gender character varying(10) DEFAULT 'male'::character varying NOT NULL,
    ken integer DEFAULT 0 NOT NULL,
    vip_used character varying(50),
    vip_end_time timestamp without time zone,
    follower_count integer DEFAULT 0 NOT NULL,
    following_count integer DEFAULT 0 NOT NULL
);

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_room_name_key UNIQUE (room_name);

ALTER TABLE ONLY public.me_comments
    ADD CONSTRAINT me_comments_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.me
    ADD CONSTRAINT me_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.me_reactions
    ADD CONSTRAINT me_reactions_pkey PRIMARY KEY (post_id, user_id);

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT relationships_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT unique_relationship UNIQUE (requester_id, addressee_id);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);

CREATE INDEX idx_admin_users_deleted_at ON public.admin_users USING btree (deleted_at);

CREATE UNIQUE INDEX idx_admin_users_username_lower ON public.admin_users USING btree (lower((username)::text)) WHERE (deleted_at IS NULL);

CREATE INDEX idx_calls_caller ON public.calls USING btree (caller_id, started_at DESC);

CREATE INDEX idx_calls_conv_started ON public.calls USING btree (conversation_id, started_at DESC);

CREATE INDEX idx_calls_status ON public.calls USING btree (status) WHERE ((status)::text = ANY ((ARRAY['ringing'::character varying, 'active'::character varying])::text[]));

CREATE INDEX idx_me_author_created_id ON public.me USING btree (author_id, created_at DESC, id DESC) WHERE (deleted_at IS NULL);

CREATE INDEX idx_me_comments_deleted_at ON public.me_comments USING btree (deleted_at);

CREATE INDEX idx_me_comments_post_created ON public.me_comments USING btree (post_id, created_at DESC) WHERE (deleted_at IS NULL);

CREATE INDEX idx_me_deleted_at ON public.me USING btree (deleted_at);

CREATE INDEX idx_me_enabled ON public.me USING btree (enabled) WHERE (deleted_at IS NULL);

CREATE INDEX idx_me_mentions ON public.me USING gin (mentions) WHERE (deleted_at IS NULL);

CREATE INDEX idx_me_public_created_id ON public.me USING btree (visibility, created_at DESC, id DESC) WHERE (deleted_at IS NULL);

CREATE INDEX idx_me_reactions_post_type_created ON public.me_reactions USING btree (post_id, type, created_at DESC);

CREATE INDEX idx_me_reactions_user ON public.me_reactions USING btree (user_id);

CREATE INDEX idx_relationships_actioned_at ON public.relationships USING btree (actioned_at);

CREATE INDEX idx_relationships_addressee_status ON public.relationships USING btree (addressee_id, status);

CREATE INDEX idx_relationships_deleted_at ON public.relationships USING btree (deleted_at);

CREATE INDEX idx_relationships_requester_addressee ON public.relationships USING btree (requester_id, addressee_id);

CREATE INDEX idx_relationships_requester_status ON public.relationships USING btree (requester_id, status);

CREATE INDEX idx_rooms_deleted_at ON public.rooms USING btree (deleted_at);

CREATE INDEX idx_rooms_enabled ON public.rooms USING btree (enabled) WHERE (deleted_at IS NULL);

CREATE INDEX idx_rooms_index ON public.rooms USING btree (index) WHERE (deleted_at IS NULL);

CREATE INDEX idx_users_deleted_at ON public.users USING btree (deleted_at);

CREATE INDEX idx_users_email ON public.users USING btree (email) WHERE (deleted_at IS NULL);

CREATE INDEX idx_users_token_expires_at ON public.users USING btree (token_expires_at) WHERE (token_expires_at IS NOT NULL);

CREATE INDEX idx_users_username ON public.users USING btree (username) WHERE (deleted_at IS NULL);

CREATE UNIQUE INDEX idx_users_username_lower ON public.users USING btree (lower((username)::text)) WHERE (deleted_at IS NULL);

CREATE TRIGGER update_relationships_updated_at BEFORE UPDATE ON public.relationships FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT fk_calls_caller FOREIGN KEY (caller_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.me
    ADD CONSTRAINT fk_me_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.me_comments
    ADD CONSTRAINT fk_me_comments_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.me_comments
    ADD CONSTRAINT fk_me_comments_post FOREIGN KEY (post_id) REFERENCES public.me(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.me_reactions
    ADD CONSTRAINT fk_me_reactions_post FOREIGN KEY (post_id) REFERENCES public.me(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.me_reactions
    ADD CONSTRAINT fk_me_reactions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT fk_relationships_addressee FOREIGN KEY (addressee_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT fk_relationships_requester FOREIGN KEY (requester_id) REFERENCES public.users(id) ON DELETE CASCADE;


INSERT INTO public.admin_users (username, password, full_name, role)
SELECT 'admin', crypt('admin@123', gen_salt('bf')), 'Super Admin', 'SUPER_ADMIN'
WHERE NOT EXISTS (SELECT 1 FROM public.admin_users WHERE LOWER(username) = 'admin');

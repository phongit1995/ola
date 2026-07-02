--
-- PostgreSQL database dump
--


-- Dumped from database version 15.17
-- Dumped by pg_dump version 15.17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

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


--
-- Name: calls; Type: TABLE; Schema: public; Owner: -
--

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
    CONSTRAINT check_call_status CHECK (((status)::text = ANY (ARRAY[('ringing'::character varying)::text, ('active'::character varying)::text, ('ended'::character varying)::text, ('missed'::character varying)::text, ('declined'::character varying)::text]))),
    CONSTRAINT check_call_type CHECK (((call_type)::text = ANY (ARRAY[('audio'::character varying)::text, ('video'::character varying)::text])))
);


--
-- Name: egg_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.egg_categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    pack_id uuid NOT NULL,
    type character varying(20) NOT NULL,
    label character varying(100) NOT NULL,
    weight numeric(10,4) DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT egg_categories_type_check CHECK (((type)::text = ANY ((ARRAY['nothing'::character varying, 'vip_icon'::character varying, 'ken'::character varying, 'vip_days'::character varying])::text[]))),
    CONSTRAINT egg_categories_weight_check CHECK ((weight >= (0)::numeric))
);


--
-- Name: egg_draws; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.egg_draws (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    pack_id uuid NOT NULL,
    pack_name character varying(100) NOT NULL,
    ken_cost integer NOT NULL,
    category_type character varying(20) NOT NULL,
    reward_type character varying(20),
    reward_label character varying(100),
    vip_type_id smallint,
    ken_amount integer,
    vip_days integer,
    is_super_lucky boolean DEFAULT false NOT NULL,
    ken_tx_id uuid,
    metadata jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: egg_packs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.egg_packs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    ken_cost integer DEFAULT 0 NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT egg_packs_ken_cost_check CHECK ((ken_cost >= 0))
);


--
-- Name: egg_rewards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.egg_rewards (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    category_id uuid NOT NULL,
    label character varying(100) NOT NULL,
    weight numeric(10,4) DEFAULT 0 NOT NULL,
    vip_type_id smallint,
    ken_amount integer,
    vip_days integer,
    is_super_lucky boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT egg_rewards_weight_check CHECK ((weight >= (0)::numeric))
);


--
-- Name: follows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.follows (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    follower_id uuid NOT NULL,
    followee_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT check_no_self_follow CHECK ((follower_id <> followee_id))
);


--
-- Name: ken_chest_claims; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ken_chest_claims (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    chest_id uuid NOT NULL,
    user_id uuid NOT NULL,
    ken_amount integer DEFAULT 0 NOT NULL,
    is_empty boolean DEFAULT false NOT NULL,
    ken_tx_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: ken_chests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ken_chests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reward_mode character varying(10) NOT NULL,
    ken_amount integer,
    ken_min integer,
    ken_max integer,
    max_recipients integer NOT NULL,
    claimed_recipients integer DEFAULT 0 NOT NULL,
    duration_seconds integer DEFAULT 90 NOT NULL,
    status character varying(12) DEFAULT 'active'::character varying NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_by uuid,
    claims_count integer DEFAULT 0 NOT NULL,
    total_ken_given bigint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT ken_chests_claimed_check CHECK (((claimed_recipients >= 0) AND (claimed_recipients <= max_recipients))),
    CONSTRAINT ken_chests_duration_check CHECK (((duration_seconds >= 30) AND (duration_seconds <= 600))),
    CONSTRAINT ken_chests_fixed_amount_check CHECK ((((reward_mode)::text <> 'fixed'::text) OR ((ken_amount IS NOT NULL) AND (ken_amount > 0)))),
    CONSTRAINT ken_chests_max_recipients_check CHECK ((max_recipients > 0)),
    CONSTRAINT ken_chests_random_range_check CHECK ((((reward_mode)::text <> 'random'::text) OR ((ken_min IS NOT NULL) AND (ken_max IS NOT NULL) AND (ken_min > 0) AND (ken_max >= ken_min)))),
    CONSTRAINT ken_chests_reward_mode_check CHECK (((reward_mode)::text = ANY ((ARRAY['fixed'::character varying, 'random'::character varying])::text[]))),
    CONSTRAINT ken_chests_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'expired'::character varying, 'deleted'::character varying])::text[])))
);


--
-- Name: ken_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ken_transactions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    direction character varying(10) NOT NULL,
    type character varying(40) NOT NULL,
    amount integer NOT NULL,
    balance_before integer NOT NULL,
    balance_after integer NOT NULL,
    description character varying(255),
    ref_type character varying(40),
    ref_id uuid,
    actor_type character varying(20),
    actor_id uuid,
    metadata jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT ken_transactions_amount_check CHECK ((amount > 0)),
    CONSTRAINT ken_transactions_balance_after_check CHECK ((balance_after >= 0)),
    CONSTRAINT ken_transactions_direction_check CHECK (((direction)::text = ANY ((ARRAY['credit'::character varying, 'debit'::character varying])::text[])))
);


--
-- Name: marriage_diary_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marriage_diary_entries (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    marriage_id uuid NOT NULL,
    author_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: marriage_proposals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marriage_proposals (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    proposer_id uuid NOT NULL,
    addressee_id uuid NOT NULL,
    message character varying(500),
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    responded_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT marriage_proposals_no_self_check CHECK ((proposer_id <> addressee_id)),
    CONSTRAINT marriage_proposals_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'accepted'::character varying, 'rejected'::character varying, 'cancelled'::character varying])::text[])))
);


--
-- Name: marriages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marriages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_low_id uuid NOT NULL,
    user_high_id uuid NOT NULL,
    status character varying(20) DEFAULT 'active'::character varying NOT NULL,
    proposal_id uuid,
    married_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    divorced_at timestamp without time zone,
    divorced_by uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT marriages_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'divorced'::character varying])::text[]))),
    CONSTRAINT marriages_user_order_check CHECK ((user_low_id < user_high_id))
);


--
-- Name: me; Type: TABLE; Schema: public; Owner: -
--

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
    enabled boolean DEFAULT true NOT NULL,
    pinned_at timestamp without time zone
);


--
-- Name: me_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.me_comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    post_id uuid NOT NULL,
    author_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: me_reactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.me_reactions (
    post_id uuid NOT NULL,
    user_id uuid NOT NULL,
    type character varying(10) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: pen_shots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pen_shots (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    shooter_id uuid NOT NULL,
    shooter_side character varying(8) NOT NULL,
    bet_amount integer NOT NULL,
    status character varying(16) DEFAULT 'open'::character varying NOT NULL,
    keeper_id uuid,
    keeper_side character varying(8),
    result character varying(16),
    winner_id uuid,
    pot integer,
    commission integer,
    payout integer,
    shoot_tx_id uuid,
    catch_tx_id uuid,
    payout_tx_id uuid,
    refund_tx_id uuid,
    settled_at timestamp without time zone,
    cancelled_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT pen_shots_bet_check CHECK ((bet_amount > 0)),
    CONSTRAINT pen_shots_keeper_side_check CHECK (((keeper_side)::text = ANY ((ARRAY['left'::character varying, 'right'::character varying])::text[]))),
    CONSTRAINT pen_shots_no_self_check CHECK (((keeper_id IS NULL) OR (keeper_id <> shooter_id))),
    CONSTRAINT pen_shots_result_check CHECK (((result)::text = ANY ((ARRAY['saved'::character varying, 'goal'::character varying])::text[]))),
    CONSTRAINT pen_shots_side_check CHECK (((shooter_side)::text = ANY ((ARRAY['left'::character varying, 'right'::character varying])::text[]))),
    CONSTRAINT pen_shots_status_check CHECK (((status)::text = ANY ((ARRAY['open'::character varying, 'settled'::character varying, 'cancelled'::character varying])::text[])))
);


--
-- Name: profile_views; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profile_views (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    viewer_id uuid NOT NULL,
    owner_id uuid NOT NULL,
    viewed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: relationships; Type: TABLE; Schema: public; Owner: -
--

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
    CONSTRAINT check_relationship_status CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('accepted'::character varying)::text, ('rejected'::character varying)::text, ('blocked'::character varying)::text])))
);


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: -
--

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


--
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    refresh_token text NOT NULL,
    device_name character varying(255),
    platform character varying(20),
    device_id character varying(128),
    app_version character varying(40),
    user_agent text,
    ip_address character varying(45),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_active_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    revoked_at timestamp without time zone,
    deleted_at timestamp without time zone
);


--
-- Name: user_vip_icons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_vip_icons (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    vip_icon_id smallint NOT NULL,
    is_locked boolean DEFAULT false NOT NULL,
    source character varying(20) DEFAULT 'purchase'::character varying NOT NULL,
    acquired_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

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
    following_count integer DEFAULT 0 NOT NULL,
    cover_photo character varying(500),
    verified boolean DEFAULT false NOT NULL,
    kisses integer DEFAULT 0 NOT NULL,
    bio_image character varying(500),
    vip_store_privacy smallint DEFAULT 0 NOT NULL,
    spouse_id uuid,
    vip_used_instance_id uuid,
    anti_count integer DEFAULT 0 NOT NULL
);


--
-- Name: vip_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vip_packages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    days integer NOT NULL,
    ken_price integer NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: vip_purchases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vip_purchases (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    package_id uuid,
    package_name character varying(100) NOT NULL,
    days integer NOT NULL,
    ken_price integer NOT NULL,
    ken_balance_after integer NOT NULL,
    vip_end_time_after timestamp without time zone NOT NULL,
    source character varying(20) DEFAULT 'package'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: vip_shop_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vip_shop_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    vip_type_id smallint NOT NULL,
    ken_price integer NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: calls calls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_pkey PRIMARY KEY (id);


--
-- Name: calls calls_room_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_room_name_key UNIQUE (room_name);


--
-- Name: egg_categories egg_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.egg_categories
    ADD CONSTRAINT egg_categories_pkey PRIMARY KEY (id);


--
-- Name: egg_draws egg_draws_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.egg_draws
    ADD CONSTRAINT egg_draws_pkey PRIMARY KEY (id);


--
-- Name: egg_packs egg_packs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.egg_packs
    ADD CONSTRAINT egg_packs_pkey PRIMARY KEY (id);


--
-- Name: egg_rewards egg_rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.egg_rewards
    ADD CONSTRAINT egg_rewards_pkey PRIMARY KEY (id);


--
-- Name: follows follows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (id);


--
-- Name: ken_chest_claims ken_chest_claims_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ken_chest_claims
    ADD CONSTRAINT ken_chest_claims_pkey PRIMARY KEY (id);


--
-- Name: ken_chests ken_chests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ken_chests
    ADD CONSTRAINT ken_chests_pkey PRIMARY KEY (id);


--
-- Name: ken_transactions ken_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ken_transactions
    ADD CONSTRAINT ken_transactions_pkey PRIMARY KEY (id);


--
-- Name: marriage_diary_entries marriage_diary_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marriage_diary_entries
    ADD CONSTRAINT marriage_diary_entries_pkey PRIMARY KEY (id);


--
-- Name: marriage_proposals marriage_proposals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marriage_proposals
    ADD CONSTRAINT marriage_proposals_pkey PRIMARY KEY (id);


--
-- Name: marriages marriages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marriages
    ADD CONSTRAINT marriages_pkey PRIMARY KEY (id);


--
-- Name: me_comments me_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_comments
    ADD CONSTRAINT me_comments_pkey PRIMARY KEY (id);


--
-- Name: me me_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me
    ADD CONSTRAINT me_pkey PRIMARY KEY (id);


--
-- Name: me_reactions me_reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_reactions
    ADD CONSTRAINT me_reactions_pkey PRIMARY KEY (post_id, user_id);


--
-- Name: pen_shots pen_shots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pen_shots
    ADD CONSTRAINT pen_shots_pkey PRIMARY KEY (id);


--
-- Name: profile_views profile_views_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile_views
    ADD CONSTRAINT profile_views_pkey PRIMARY KEY (id);


--
-- Name: relationships relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT relationships_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: follows unique_follow; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT unique_follow UNIQUE (follower_id, followee_id);


--
-- Name: relationships unique_relationship; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT unique_relationship UNIQUE (requester_id, addressee_id);


--
-- Name: ken_chest_claims uq_ken_chest_claim; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ken_chest_claims
    ADD CONSTRAINT uq_ken_chest_claim UNIQUE (chest_id, user_id);


--
-- Name: profile_views uq_profile_views_owner_viewer; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile_views
    ADD CONSTRAINT uq_profile_views_owner_viewer UNIQUE (owner_id, viewer_id);


--
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (id);


--
-- Name: user_vip_icons user_vip_icons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_vip_icons
    ADD CONSTRAINT user_vip_icons_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: vip_packages vip_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vip_packages
    ADD CONSTRAINT vip_packages_pkey PRIMARY KEY (id);


--
-- Name: vip_purchases vip_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vip_purchases
    ADD CONSTRAINT vip_purchases_pkey PRIMARY KEY (id);


--
-- Name: vip_shop_items vip_shop_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vip_shop_items
    ADD CONSTRAINT vip_shop_items_pkey PRIMARY KEY (id);


--
-- Name: idx_admin_users_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_users_deleted_at ON public.admin_users USING btree (deleted_at);


--
-- Name: idx_admin_users_username_lower; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_admin_users_username_lower ON public.admin_users USING btree (lower((username)::text)) WHERE (deleted_at IS NULL);


--
-- Name: idx_calls_caller; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_calls_caller ON public.calls USING btree (caller_id, started_at DESC);


--
-- Name: idx_calls_conv_started; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_calls_conv_started ON public.calls USING btree (conversation_id, started_at DESC);


--
-- Name: idx_calls_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_calls_status ON public.calls USING btree (status) WHERE ((status)::text = ANY (ARRAY[('ringing'::character varying)::text, ('active'::character varying)::text]));


--
-- Name: idx_egg_cat_pack; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_egg_cat_pack ON public.egg_categories USING btree (pack_id, sort_order);


--
-- Name: idx_egg_draws_pack; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_egg_draws_pack ON public.egg_draws USING btree (pack_id, created_at DESC);


--
-- Name: idx_egg_draws_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_egg_draws_user ON public.egg_draws USING btree (user_id, created_at DESC);


--
-- Name: idx_egg_packs_list; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_egg_packs_list ON public.egg_packs USING btree (sort_order) WHERE (deleted_at IS NULL);


--
-- Name: idx_egg_reward_cat; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_egg_reward_cat ON public.egg_rewards USING btree (category_id, sort_order);


--
-- Name: idx_follows_followee; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_follows_followee ON public.follows USING btree (followee_id);


--
-- Name: idx_follows_follower; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_follows_follower ON public.follows USING btree (follower_id);


--
-- Name: idx_ken_chest_claims_chest; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ken_chest_claims_chest ON public.ken_chest_claims USING btree (chest_id, created_at DESC);


--
-- Name: idx_ken_chest_claims_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ken_chest_claims_user ON public.ken_chest_claims USING btree (user_id, created_at DESC);


--
-- Name: idx_ken_chests_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ken_chests_active ON public.ken_chests USING btree (status, expires_at) WHERE (deleted_at IS NULL);


--
-- Name: idx_ken_tx_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ken_tx_user ON public.ken_transactions USING btree (user_id, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_ken_tx_user_direction; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ken_tx_user_direction ON public.ken_transactions USING btree (user_id, direction, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_ken_tx_user_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ken_tx_user_type ON public.ken_transactions USING btree (user_id, type, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_m_active_pair_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_m_active_pair_unique ON public.marriages USING btree (user_low_id, user_high_id) WHERE (((status)::text = 'active'::text) AND (deleted_at IS NULL));


--
-- Name: idx_m_high; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_m_high ON public.marriages USING btree (user_high_id, status) WHERE (deleted_at IS NULL);


--
-- Name: idx_m_low; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_m_low ON public.marriages USING btree (user_low_id, status) WHERE (deleted_at IS NULL);


--
-- Name: idx_mde_author; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mde_author ON public.marriage_diary_entries USING btree (author_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_mde_marriage; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mde_marriage ON public.marriage_diary_entries USING btree (marriage_id, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_me_author_created_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_author_created_id ON public.me USING btree (author_id, created_at DESC, id DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_me_author_pinned; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_author_pinned ON public.me USING btree (author_id, pinned_at DESC NULLS LAST, created_at DESC, id DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_me_comments_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_comments_deleted_at ON public.me_comments USING btree (deleted_at);


--
-- Name: idx_me_comments_post_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_comments_post_created ON public.me_comments USING btree (post_id, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_me_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_deleted_at ON public.me USING btree (deleted_at);


--
-- Name: idx_me_enabled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_enabled ON public.me USING btree (enabled) WHERE (deleted_at IS NULL);


--
-- Name: idx_me_mentions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_mentions ON public.me USING gin (mentions) WHERE (deleted_at IS NULL);


--
-- Name: idx_me_public_created_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_public_created_id ON public.me USING btree (visibility, created_at DESC, id DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_me_reactions_post_type_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_reactions_post_type_created ON public.me_reactions USING btree (post_id, type, created_at DESC);


--
-- Name: idx_me_reactions_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_reactions_user ON public.me_reactions USING btree (user_id);


--
-- Name: idx_mp_addressee; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mp_addressee ON public.marriage_proposals USING btree (addressee_id, status, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_mp_pending_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_mp_pending_unique ON public.marriage_proposals USING btree (proposer_id, addressee_id) WHERE (((status)::text = 'pending'::text) AND (deleted_at IS NULL));


--
-- Name: idx_mp_proposer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mp_proposer ON public.marriage_proposals USING btree (proposer_id, status, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_pen_shots_keeper; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pen_shots_keeper ON public.pen_shots USING btree (keeper_id, created_at DESC) WHERE ((keeper_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: idx_pen_shots_open; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pen_shots_open ON public.pen_shots USING btree (created_at DESC) WHERE (((status)::text = 'open'::text) AND (deleted_at IS NULL));


--
-- Name: idx_pen_shots_open_bet; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pen_shots_open_bet ON public.pen_shots USING btree (bet_amount, created_at DESC) WHERE (((status)::text = 'open'::text) AND (deleted_at IS NULL));


--
-- Name: idx_pen_shots_shooter; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pen_shots_shooter ON public.pen_shots USING btree (shooter_id, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_profile_views_owner_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_profile_views_owner_time ON public.profile_views USING btree (owner_id, viewed_at DESC);


--
-- Name: idx_relationships_actioned_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_relationships_actioned_at ON public.relationships USING btree (actioned_at);


--
-- Name: idx_relationships_addressee_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_relationships_addressee_status ON public.relationships USING btree (addressee_id, status);


--
-- Name: idx_relationships_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_relationships_deleted_at ON public.relationships USING btree (deleted_at);


--
-- Name: idx_relationships_requester_addressee; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_relationships_requester_addressee ON public.relationships USING btree (requester_id, addressee_id);


--
-- Name: idx_relationships_requester_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_relationships_requester_status ON public.relationships USING btree (requester_id, status);


--
-- Name: idx_rooms_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rooms_deleted_at ON public.rooms USING btree (deleted_at);


--
-- Name: idx_rooms_enabled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rooms_enabled ON public.rooms USING btree (enabled) WHERE (deleted_at IS NULL);


--
-- Name: idx_rooms_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rooms_index ON public.rooms USING btree (index) WHERE (deleted_at IS NULL);


--
-- Name: idx_user_sessions_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_sessions_active ON public.user_sessions USING btree (user_id, revoked_at);


--
-- Name: idx_user_sessions_device; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_sessions_device ON public.user_sessions USING btree (user_id, device_id);


--
-- Name: idx_user_sessions_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_sessions_user ON public.user_sessions USING btree (user_id);


--
-- Name: idx_users_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_deleted_at ON public.users USING btree (deleted_at);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_email ON public.users USING btree (email) WHERE (deleted_at IS NULL);


--
-- Name: idx_users_spouse; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_spouse ON public.users USING btree (spouse_id) WHERE (spouse_id IS NOT NULL);


--
-- Name: idx_users_token_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_token_expires_at ON public.users USING btree (token_expires_at) WHERE (token_expires_at IS NOT NULL);


--
-- Name: idx_users_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_username ON public.users USING btree (username) WHERE (deleted_at IS NULL);


--
-- Name: idx_users_username_lower; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_users_username_lower ON public.users USING btree (lower((username)::text)) WHERE (deleted_at IS NULL);


--
-- Name: idx_uvi_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_uvi_user ON public.user_vip_icons USING btree (user_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_uvi_user_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_uvi_user_type ON public.user_vip_icons USING btree (user_id, vip_icon_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_vip_packages_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_vip_packages_active ON public.vip_packages USING btree (is_active, sort_order) WHERE (deleted_at IS NULL);


--
-- Name: idx_vip_shop_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_vip_shop_active ON public.vip_shop_items USING btree (is_active, sort_order) WHERE (deleted_at IS NULL);


--
-- Name: idx_vip_shop_type_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_vip_shop_type_unique ON public.vip_shop_items USING btree (vip_type_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_vp_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_vp_user ON public.vip_purchases USING btree (user_id, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: relationships update_relationships_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_relationships_updated_at BEFORE UPDATE ON public.relationships FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: users update_users_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: calls fk_calls_caller; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT fk_calls_caller FOREIGN KEY (caller_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: egg_categories fk_egg_cat_pack; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.egg_categories
    ADD CONSTRAINT fk_egg_cat_pack FOREIGN KEY (pack_id) REFERENCES public.egg_packs(id) ON DELETE CASCADE;


--
-- Name: egg_draws fk_egg_draws_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.egg_draws
    ADD CONSTRAINT fk_egg_draws_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: egg_rewards fk_egg_reward_cat; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.egg_rewards
    ADD CONSTRAINT fk_egg_reward_cat FOREIGN KEY (category_id) REFERENCES public.egg_categories(id) ON DELETE CASCADE;


--
-- Name: follows fk_follows_followee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT fk_follows_followee FOREIGN KEY (followee_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: follows fk_follows_follower; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT fk_follows_follower FOREIGN KEY (follower_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: ken_chest_claims fk_ken_chest_claims_chest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ken_chest_claims
    ADD CONSTRAINT fk_ken_chest_claims_chest FOREIGN KEY (chest_id) REFERENCES public.ken_chests(id) ON DELETE CASCADE;


--
-- Name: ken_chest_claims fk_ken_chest_claims_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ken_chest_claims
    ADD CONSTRAINT fk_ken_chest_claims_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: ken_transactions fk_ken_tx_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ken_transactions
    ADD CONSTRAINT fk_ken_tx_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marriages fk_m_high; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marriages
    ADD CONSTRAINT fk_m_high FOREIGN KEY (user_high_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marriages fk_m_low; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marriages
    ADD CONSTRAINT fk_m_low FOREIGN KEY (user_low_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marriages fk_m_proposal; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marriages
    ADD CONSTRAINT fk_m_proposal FOREIGN KEY (proposal_id) REFERENCES public.marriage_proposals(id) ON DELETE SET NULL;


--
-- Name: marriage_diary_entries fk_mde_author; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marriage_diary_entries
    ADD CONSTRAINT fk_mde_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marriage_diary_entries fk_mde_marriage; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marriage_diary_entries
    ADD CONSTRAINT fk_mde_marriage FOREIGN KEY (marriage_id) REFERENCES public.marriages(id) ON DELETE CASCADE;


--
-- Name: me fk_me_author; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me
    ADD CONSTRAINT fk_me_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: me_comments fk_me_comments_author; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_comments
    ADD CONSTRAINT fk_me_comments_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: me_comments fk_me_comments_post; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_comments
    ADD CONSTRAINT fk_me_comments_post FOREIGN KEY (post_id) REFERENCES public.me(id) ON DELETE CASCADE;


--
-- Name: me_reactions fk_me_reactions_post; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_reactions
    ADD CONSTRAINT fk_me_reactions_post FOREIGN KEY (post_id) REFERENCES public.me(id) ON DELETE CASCADE;


--
-- Name: me_reactions fk_me_reactions_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_reactions
    ADD CONSTRAINT fk_me_reactions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marriage_proposals fk_mp_addressee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marriage_proposals
    ADD CONSTRAINT fk_mp_addressee FOREIGN KEY (addressee_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marriage_proposals fk_mp_proposer; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marriage_proposals
    ADD CONSTRAINT fk_mp_proposer FOREIGN KEY (proposer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: pen_shots fk_pen_keeper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pen_shots
    ADD CONSTRAINT fk_pen_keeper FOREIGN KEY (keeper_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: pen_shots fk_pen_shooter; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pen_shots
    ADD CONSTRAINT fk_pen_shooter FOREIGN KEY (shooter_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: profile_views fk_profile_views_owner; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile_views
    ADD CONSTRAINT fk_profile_views_owner FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: profile_views fk_profile_views_viewer; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile_views
    ADD CONSTRAINT fk_profile_views_viewer FOREIGN KEY (viewer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: relationships fk_relationships_addressee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT fk_relationships_addressee FOREIGN KEY (addressee_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: relationships fk_relationships_requester; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT fk_relationships_requester FOREIGN KEY (requester_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_sessions fk_user_sessions_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT fk_user_sessions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users fk_users_spouse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_spouse FOREIGN KEY (spouse_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: user_vip_icons fk_uvi_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_vip_icons
    ADD CONSTRAINT fk_uvi_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: vip_purchases fk_vp_package; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vip_purchases
    ADD CONSTRAINT fk_vp_package FOREIGN KEY (package_id) REFERENCES public.vip_packages(id) ON DELETE SET NULL;


--
-- Name: vip_purchases fk_vp_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vip_purchases
    ADD CONSTRAINT fk_vp_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--



--
-- Seed data
--

INSERT INTO public.admin_users (username, password, full_name, role)
SELECT 'admin', public.crypt('admin@123', public.gen_salt('bf')), 'Super Admin', 'SUPER_ADMIN'
WHERE NOT EXISTS (SELECT 1 FROM public.admin_users WHERE LOWER(username) = 'admin');

INSERT INTO public.vip_packages (name, days, ken_price, sort_order) VALUES
    ('Gói 7 ngày', 7, 70, 1),
    ('Gói 30 ngày', 30, 250, 2),
    ('Gói 90 ngày', 90, 600, 3),
    ('Gói 365 ngày', 365, 2000, 4);

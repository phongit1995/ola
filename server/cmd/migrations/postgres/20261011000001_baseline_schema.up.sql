-- Baseline: toàn bộ schema sau migration 20261011000001, sinh bằng pg_dump --schema-only từ DB chạy đủ chuỗi migration cũ.
-- Không sửa file này cho thay đổi mới: DB đã ở version này sẽ không chạy lại nó. Viết migration mới với version lớn hơn.
--
-- PostgreSQL database dump
--


-- Dumped from database version 15.19 (Debian 15.19-1.pgdg13+2)
-- Dumped by pg_dump version 15.19 (Debian 15.19-1.pgdg13+2)


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: stories_set_search_text(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.stories_set_search_text() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.search_text := lower(public.unaccent('public.unaccent'::regdictionary, NEW.title || ' ' || NEW.author_name));
    RETURN NEW;
END;
$$;


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


--
-- Name: admin_audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_audit_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    admin_id uuid NOT NULL,
    method character varying(10) NOT NULL,
    resource character varying(60) NOT NULL,
    path character varying(300) NOT NULL,
    route character varying(300),
    status integer NOT NULL,
    ip character varying(45),
    detail jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: admin_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    admin_id uuid NOT NULL,
    refresh_token_hash character(64) NOT NULL,
    user_agent text,
    ip_address character varying(45),
    last_active_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    previous_refresh_token_hash character(64),
    last_rotated_at timestamp without time zone,
    refresh_retry_response bytea,
    CONSTRAINT admin_sessions_previous_refresh_token_hash_check CHECK (((previous_refresh_token_hash IS NULL) OR (length(previous_refresh_token_hash) = 64))),
    CONSTRAINT admin_sessions_refresh_retry_state_check CHECK ((((previous_refresh_token_hash IS NULL) AND (last_rotated_at IS NULL) AND (refresh_retry_response IS NULL)) OR ((previous_refresh_token_hash IS NOT NULL) AND (last_rotated_at IS NOT NULL) AND (refresh_retry_response IS NOT NULL)))),
    CONSTRAINT admin_sessions_refresh_token_hash_check CHECK ((length(refresh_token_hash) = 64))
);


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
-- Name: announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcements (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(200) NOT NULL,
    content text DEFAULT ''::text,
    link character varying(500),
    is_active boolean DEFAULT false NOT NULL,
    starts_at timestamp with time zone,
    ends_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: app_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_notifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    recipient_id uuid NOT NULL,
    actor_id uuid,
    type character varying(30) NOT NULL,
    ref_id uuid,
    preview text,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: app_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_settings (
    key character varying(100) NOT NULL,
    value jsonb DEFAULT '{}'::jsonb NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
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
-- Name: clan_bans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clan_bans (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    clan_id uuid NOT NULL,
    user_id uuid NOT NULL,
    banned_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: clan_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clan_members (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    clan_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role character varying(12) DEFAULT 'member'::character varying NOT NULL,
    verified boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: clans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clans (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    handle character varying(32) NOT NULL,
    owner_id uuid NOT NULL,
    description text,
    avatar character varying(500) DEFAULT ''::character varying NOT NULL,
    cover character varying(500) DEFAULT ''::character varying NOT NULL,
    policy smallint DEFAULT 0 NOT NULL,
    member_public_post boolean DEFAULT false NOT NULL,
    member_count integer DEFAULT 1 NOT NULL,
    visit_count bigint DEFAULT 0 NOT NULL,
    me_top_post_id uuid,
    room_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: device_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.device_tokens (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    session_id uuid NOT NULL,
    device_id character varying(128) NOT NULL,
    platform character varying(20) NOT NULL,
    token text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT device_tokens_platform_check CHECK (((platform)::text = ANY ((ARRAY['android'::character varying, 'ios'::character varying, 'web'::character varying])::text[])))
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
    CONSTRAINT egg_categories_type_check CHECK (((type)::text = ANY (ARRAY[('nothing'::character varying)::text, ('vip_icon'::character varying)::text, ('ken'::character varying)::text, ('vip_days'::character varying)::text]))),
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
-- Name: game_match_players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.game_match_players (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    game_match_id uuid NOT NULL,
    user_id uuid NOT NULL,
    seat integer NOT NULL,
    place integer,
    ken_delta integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT game_match_players_place_check CHECK (((place IS NULL) OR ((place >= 1) AND (place <= 8)))),
    CONSTRAINT game_match_players_seat_check CHECK (((seat >= 0) AND (seat <= 7)))
);


--
-- Name: game_matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.game_matches (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    game_id character varying(50) NOT NULL,
    match_id character varying(64) NOT NULL,
    player0_id uuid NOT NULL,
    player1_id uuid NOT NULL,
    winner_id uuid,
    loser_id uuid,
    status character varying(10) DEFAULT 'playing'::character varying NOT NULL,
    reason character varying(20) DEFAULT ''::character varying NOT NULL,
    mode character varying(10) NOT NULL,
    bet integer DEFAULT 0 NOT NULL,
    ken_delta integer DEFAULT 0 NOT NULL,
    move_count integer DEFAULT 0 NOT NULL,
    started_at timestamp with time zone NOT NULL,
    escrowed_at timestamp with time zone NOT NULL,
    finished_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    player_count integer DEFAULT 2 NOT NULL,
    CONSTRAINT game_matches_bet_check CHECK (((bet >= 0) AND (bet <= 1073741823))),
    CONSTRAINT game_matches_ken_delta_check CHECK (((ken_delta >= 0) AND (ken_delta <= bet))),
    CONSTRAINT game_matches_lifecycle_check CHECK (((((status)::text = 'playing'::text) AND (finished_at IS NULL) AND ((reason)::text = ''::text) AND (winner_id IS NULL) AND (loser_id IS NULL) AND (ken_delta = 0)) OR (((status)::text = 'finished'::text) AND (finished_at IS NOT NULL) AND ((reason)::text <> ''::text) AND ((((reason)::text = ANY ((ARRAY['win'::character varying, 'forfeit'::character varying, 'timeout'::character varying])::text[])) AND (winner_id IS NOT NULL)) OR (((reason)::text = ANY ((ARRAY['draw'::character varying, 'void'::character varying])::text[])) AND (winner_id IS NULL)) OR ((reason)::text = 'disconnect'::text))))),
    CONSTRAINT game_matches_mode_check CHECK (((mode)::text = ANY ((ARRAY['queue'::character varying, 'room'::character varying])::text[]))),
    CONSTRAINT game_matches_move_count_check CHECK ((move_count >= 0)),
    CONSTRAINT game_matches_player_count_check CHECK (((player_count >= 2) AND (player_count <= 8))),
    CONSTRAINT game_matches_players_distinct_check CHECK ((player0_id <> player1_id)),
    CONSTRAINT game_matches_reason_check CHECK (((reason)::text = ANY ((ARRAY[''::character varying, 'win'::character varying, 'draw'::character varying, 'forfeit'::character varying, 'timeout'::character varying, 'disconnect'::character varying, 'void'::character varying])::text[]))),
    CONSTRAINT game_matches_result_players_check CHECK ((((player_count = 2) AND (((winner_id IS NULL) AND (loser_id IS NULL)) OR ((winner_id IS NOT NULL) AND (loser_id IS NOT NULL) AND (winner_id <> loser_id) AND ((winner_id = player0_id) OR (winner_id = player1_id)) AND ((loser_id = player0_id) OR (loser_id = player1_id))))) OR ((player_count > 2) AND (loser_id IS NULL)))),
    CONSTRAINT game_matches_status_check CHECK (((status)::text = ANY ((ARRAY['playing'::character varying, 'finished'::character varying])::text[]))),
    CONSTRAINT game_matches_timestamp_order_check CHECK (((started_at <= escrowed_at) AND ((finished_at IS NULL) OR (escrowed_at <= finished_at))))
);


--
-- Name: ken_chest_auto_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ken_chest_auto_jobs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) DEFAULT ''::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    schedule_type character varying(10) DEFAULT 'interval'::character varying NOT NULL,
    interval_min_minutes integer,
    interval_max_minutes integer,
    daily_times jsonb,
    reward_mode character varying(10) NOT NULL,
    ken_amount integer,
    ken_min integer,
    ken_max integer,
    max_recipients integer NOT NULL,
    duration_seconds integer DEFAULT 90 NOT NULL,
    remaining_runs integer,
    run_count integer DEFAULT 0 NOT NULL,
    next_run_at timestamp with time zone,
    last_run_at timestamp with time zone,
    created_by uuid,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT ken_chest_auto_jobs_daily_check CHECK ((((schedule_type)::text <> 'daily'::text) OR ((daily_times IS NOT NULL) AND (jsonb_array_length(daily_times) > 0)))),
    CONSTRAINT ken_chest_auto_jobs_duration_check CHECK (((duration_seconds >= 30) AND (duration_seconds <= 600))),
    CONSTRAINT ken_chest_auto_jobs_fixed_amount_check CHECK ((((reward_mode)::text <> 'fixed'::text) OR ((ken_amount IS NOT NULL) AND (ken_amount > 0)))),
    CONSTRAINT ken_chest_auto_jobs_interval_check CHECK ((((schedule_type)::text <> 'interval'::text) OR ((interval_min_minutes IS NOT NULL) AND (interval_max_minutes IS NOT NULL) AND (interval_min_minutes > 0) AND (interval_max_minutes >= interval_min_minutes)))),
    CONSTRAINT ken_chest_auto_jobs_max_recipients_check CHECK ((max_recipients > 0)),
    CONSTRAINT ken_chest_auto_jobs_random_range_check CHECK ((((reward_mode)::text <> 'random'::text) OR ((ken_min IS NOT NULL) AND (ken_max IS NOT NULL) AND (ken_min > 0) AND (ken_max >= ken_min)))),
    CONSTRAINT ken_chest_auto_jobs_remaining_runs_check CHECK (((remaining_runs IS NULL) OR (remaining_runs >= 0))),
    CONSTRAINT ken_chest_auto_jobs_reward_mode_check CHECK (((reward_mode)::text = ANY (ARRAY[('fixed'::character varying)::text, ('random'::character varying)::text]))),
    CONSTRAINT ken_chest_auto_jobs_schedule_type_check CHECK (((schedule_type)::text = ANY (ARRAY[('interval'::character varying)::text, ('daily'::character varying)::text])))
);


--
-- Name: ken_chest_auto_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ken_chest_auto_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
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
    source character varying(10) DEFAULT 'manual'::character varying NOT NULL,
    auto_job_id uuid,
    CONSTRAINT ken_chests_claimed_check CHECK (((claimed_recipients >= 0) AND (claimed_recipients <= max_recipients))),
    CONSTRAINT ken_chests_duration_check CHECK (((duration_seconds >= 30) AND (duration_seconds <= 600))),
    CONSTRAINT ken_chests_fixed_amount_check CHECK ((((reward_mode)::text <> 'fixed'::text) OR ((ken_amount IS NOT NULL) AND (ken_amount > 0)))),
    CONSTRAINT ken_chests_max_recipients_check CHECK ((max_recipients > 0)),
    CONSTRAINT ken_chests_random_range_check CHECK ((((reward_mode)::text <> 'random'::text) OR ((ken_min IS NOT NULL) AND (ken_max IS NOT NULL) AND (ken_min > 0) AND (ken_max >= ken_min)))),
    CONSTRAINT ken_chests_reward_mode_check CHECK (((reward_mode)::text = ANY (ARRAY[('fixed'::character varying)::text, ('random'::character varying)::text]))),
    CONSTRAINT ken_chests_source_check CHECK (((source)::text = ANY (ARRAY[('manual'::character varying)::text, ('auto'::character varying)::text]))),
    CONSTRAINT ken_chests_status_check CHECK (((status)::text = ANY (ARRAY[('active'::character varying)::text, ('expired'::character varying)::text, ('deleted'::character varying)::text])))
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
    CONSTRAINT ken_transactions_direction_check CHECK (((direction)::text = ANY (ARRAY[('credit'::character varying)::text, ('debit'::character varying)::text])))
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
    CONSTRAINT marriage_proposals_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('accepted'::character varying)::text, ('rejected'::character varying)::text, ('cancelled'::character varying)::text])))
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
    CONSTRAINT marriages_status_check CHECK (((status)::text = ANY (ARRAY[('active'::character varying)::text, ('divorced'::character varying)::text]))),
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
    pinned_at timestamp without time zone,
    clan_id uuid,
    audios jsonb
);


--
-- Name: me_comment_likes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.me_comment_likes (
    comment_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
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
    deleted_at timestamp without time zone,
    parent_id uuid,
    like_count integer DEFAULT 0 NOT NULL
);


--
-- Name: me_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.me_notifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    recipient_id uuid NOT NULL,
    actor_id uuid NOT NULL,
    type character varying(20) NOT NULL,
    post_id uuid NOT NULL,
    comment_id uuid,
    preview text,
    is_read boolean DEFAULT false NOT NULL,
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
-- Name: mini_games; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mini_games (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    slug character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(300),
    icon_url character varying(500),
    game_url character varying(500) NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
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
    CONSTRAINT pen_shots_keeper_side_check CHECK (((keeper_side)::text = ANY (ARRAY[('left'::character varying)::text, ('right'::character varying)::text]))),
    CONSTRAINT pen_shots_no_self_check CHECK (((keeper_id IS NULL) OR (keeper_id <> shooter_id))),
    CONSTRAINT pen_shots_result_check CHECK (((result)::text = ANY (ARRAY[('saved'::character varying)::text, ('goal'::character varying)::text]))),
    CONSTRAINT pen_shots_side_check CHECK (((shooter_side)::text = ANY (ARRAY[('left'::character varying)::text, ('right'::character varying)::text]))),
    CONSTRAINT pen_shots_status_check CHECK (((status)::text = ANY (ARRAY[('open'::character varying)::text, ('settled'::character varying)::text, ('cancelled'::character varying)::text])))
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
-- Name: room_user_blocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_user_blocks (
    user_id uuid NOT NULL,
    blocked_user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT room_user_blocks_not_self CHECK ((user_id <> blocked_user_id))
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
-- Name: stories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    source character varying(30) DEFAULT 'vnkings'::character varying NOT NULL,
    source_story_id character varying(100) NOT NULL,
    slug character varying(255) NOT NULL,
    source_url text NOT NULL,
    title character varying(500) NOT NULL,
    author_name character varying(200) DEFAULT ''::character varying NOT NULL,
    source_author_id character varying(100),
    kind character varying(10) NOT NULL,
    genres text[] DEFAULT '{}'::text[] NOT NULL,
    tags text[] DEFAULT '{}'::text[] NOT NULL,
    intro text DEFAULT ''::text NOT NULL,
    cover_url text,
    status character varying(20) DEFAULT 'unknown'::character varying NOT NULL,
    age_rating character varying(100) DEFAULT ''::character varying NOT NULL,
    chapter_count integer DEFAULT 0 NOT NULL,
    word_count integer DEFAULT 0 NOT NULL,
    view_count bigint DEFAULT 0 NOT NULL,
    comment_count integer DEFAULT 0 NOT NULL,
    like_count integer DEFAULT 0 NOT NULL,
    published_at timestamp with time zone NOT NULL,
    source_updated_at timestamp with time zone NOT NULL,
    last_chapter_at timestamp with time zone,
    crawled_at timestamp with time zone,
    content_hash bytea,
    search_text text DEFAULT ''::text NOT NULL,
    is_hidden boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT stories_kind_check CHECK (((kind)::text = ANY ((ARRAY['short'::character varying, 'long'::character varying])::text[]))),
    CONSTRAINT stories_status_check CHECK (((status)::text = ANY ((ARRAY['ongoing'::character varying, 'completed'::character varying, 'unknown'::character varying])::text[])))
);


--
-- Name: story_chapters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.story_chapters (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    story_id uuid NOT NULL,
    source_chapter_id character varying(100) NOT NULL,
    "position" integer NOT NULL,
    title character varying(500) NOT NULL,
    source_url text NOT NULL,
    content_text text DEFAULT ''::text NOT NULL,
    word_count integer DEFAULT 0 NOT NULL,
    published_at timestamp with time zone,
    crawled_at timestamp with time zone,
    content_hash bytea,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: story_comment_likes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.story_comment_likes (
    comment_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: story_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.story_comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    story_id uuid NOT NULL,
    author_id uuid NOT NULL,
    parent_id uuid,
    content text NOT NULL,
    like_count integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: story_unlocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.story_unlocks (
    user_id uuid NOT NULL,
    story_id uuid NOT NULL,
    source character varying(20) NOT NULL,
    comment_id uuid,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: topup_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topup_transactions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_tx_id character varying(120) NOT NULL,
    description character varying(500) DEFAULT ''::character varying NOT NULL,
    amount bigint NOT NULL,
    type character varying(10) NOT NULL,
    status character varying(30) NOT NULL,
    matched_username character varying(50),
    user_id uuid,
    ken_amount bigint DEFAULT 0 NOT NULL,
    ken_tx_id uuid,
    note character varying(255),
    raw jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bonus_ken bigint DEFAULT 0 NOT NULL,
    bonus_percent integer DEFAULT 0 NOT NULL
);


--
-- Name: user_game_levels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_game_levels (
    user_id uuid NOT NULL,
    game_id character varying(50) NOT NULL,
    exp bigint DEFAULT 0 NOT NULL,
    level integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT user_game_levels_exp_check CHECK ((exp >= 0)),
    CONSTRAINT user_game_levels_level_check CHECK (((level >= 1) AND (level <= 99)))
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
-- Name: user_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_settings (
    user_id uuid NOT NULL,
    message_privacy character varying(20) DEFAULT 'all'::character varying NOT NULL,
    me_visibility character varying(20) DEFAULT 'all'::character varying NOT NULL,
    comment_privacy character varying(20) DEFAULT 'all'::character varying NOT NULL,
    show_birthday boolean DEFAULT true NOT NULL,
    notif_message boolean DEFAULT true NOT NULL,
    notif_sound boolean DEFAULT true NOT NULL,
    font_size character varying(20) DEFAULT 'medium'::character varying NOT NULL,
    wallpaper_url text DEFAULT ''::text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    show_interested boolean DEFAULT true NOT NULL,
    sound_game boolean DEFAULT true NOT NULL,
    sound_ken boolean DEFAULT true NOT NULL,
    vip_store_privacy smallint DEFAULT 0 NOT NULL
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
-- Name: username_change_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.username_change_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    old_username character varying(50) NOT NULL,
    new_username character varying(50) NOT NULL,
    cost integer DEFAULT 0 NOT NULL,
    actor_type character varying(10) DEFAULT 'user'::character varying NOT NULL,
    actor_id uuid,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
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
    bio text,
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
    spouse_id uuid,
    vip_used_instance_id uuid,
    anti_count integer DEFAULT 0 NOT NULL,
    email_verified boolean DEFAULT false NOT NULL,
    email_verified_at timestamp with time zone
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
-- Name: vip_transfers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vip_transfers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    from_user_id uuid NOT NULL,
    to_user_id uuid NOT NULL,
    vip_icon_id smallint NOT NULL,
    instance_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: wheel_free_claims; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wheel_free_claims (
    user_id uuid NOT NULL,
    wheel_id uuid NOT NULL,
    claim_date date NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: wheel_segment_options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wheel_segment_options (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    segment_id uuid NOT NULL,
    label character varying(100) NOT NULL,
    weight numeric(10,4) DEFAULT 0 NOT NULL,
    vip_type_id smallint,
    vip_days integer,
    ken_amount integer,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT wheel_segment_options_weight_check CHECK ((weight >= (0)::numeric))
);


--
-- Name: wheel_segments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wheel_segments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    wheel_id uuid NOT NULL,
    kind character varying(20) NOT NULL,
    label character varying(100) NOT NULL,
    weight numeric(10,4) DEFAULT 0 NOT NULL,
    ken_amount integer,
    ken_min integer,
    ken_max integer,
    vip_days integer,
    vip_type_id smallint,
    is_super_lucky boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT wheel_segments_kind_check CHECK (((kind)::text = ANY (ARRAY[('miss'::character varying)::text, ('ken_fixed'::character varying)::text, ('ken_random'::character varying)::text, ('vip_days'::character varying)::text, ('vip_item'::character varying)::text, ('vip_random'::character varying)::text]))),
    CONSTRAINT wheel_segments_weight_check CHECK ((weight >= (0)::numeric))
);


--
-- Name: wheel_spins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wheel_spins (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    wheel_id uuid NOT NULL,
    wheel_name character varying(100) NOT NULL,
    ken_cost integer DEFAULT 0 NOT NULL,
    is_free boolean DEFAULT false NOT NULL,
    segment_id uuid,
    segment_kind character varying(20) NOT NULL,
    reward_label character varying(100),
    ken_amount integer,
    vip_days integer,
    vip_type_id smallint,
    is_super_lucky boolean DEFAULT false NOT NULL,
    metadata jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: wheels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wheels (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    ken_cost integer DEFAULT 0 NOT NULL,
    free_daily_enabled boolean DEFAULT false NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT wheels_ken_cost_check CHECK ((ken_cost >= 0))
);


--
-- Name: word_chain_hint_purchases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.word_chain_hint_purchases (
    user_id uuid NOT NULL,
    session_id uuid NOT NULL,
    turn bigint NOT NULL,
    word character varying(100) NOT NULL,
    hints text[] DEFAULT '{}'::text[] NOT NULL,
    price integer NOT NULL,
    ken_transaction_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: word_chain_scores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.word_chain_scores (
    message_id uuid NOT NULL,
    session_id uuid NOT NULL,
    user_id uuid NOT NULL,
    word character varying(100) NOT NULL,
    previous_word character varying(100) NOT NULL,
    points smallint DEFAULT 1 NOT NULL,
    is_win boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: admin_audit_logs admin_audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_audit_logs
    ADD CONSTRAINT admin_audit_logs_pkey PRIMARY KEY (id);


--
-- Name: admin_sessions admin_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_sessions
    ADD CONSTRAINT admin_sessions_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: app_notifications app_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_notifications
    ADD CONSTRAINT app_notifications_pkey PRIMARY KEY (id);


--
-- Name: app_settings app_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_settings
    ADD CONSTRAINT app_settings_pkey PRIMARY KEY (key);


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
-- Name: clan_bans clan_bans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clan_bans
    ADD CONSTRAINT clan_bans_pkey PRIMARY KEY (id);


--
-- Name: clan_members clan_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clan_members
    ADD CONSTRAINT clan_members_pkey PRIMARY KEY (id);


--
-- Name: clans clans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clans
    ADD CONSTRAINT clans_pkey PRIMARY KEY (id);


--
-- Name: device_tokens device_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_tokens
    ADD CONSTRAINT device_tokens_pkey PRIMARY KEY (id);


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
-- Name: game_match_players game_match_players_match_seat_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_match_players
    ADD CONSTRAINT game_match_players_match_seat_key UNIQUE (game_match_id, seat);


--
-- Name: game_match_players game_match_players_match_user_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_match_players
    ADD CONSTRAINT game_match_players_match_user_key UNIQUE (game_match_id, user_id);


--
-- Name: game_match_players game_match_players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_match_players
    ADD CONSTRAINT game_match_players_pkey PRIMARY KEY (id);


--
-- Name: game_matches game_matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_matches
    ADD CONSTRAINT game_matches_pkey PRIMARY KEY (id);


--
-- Name: ken_chest_auto_jobs ken_chest_auto_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ken_chest_auto_jobs
    ADD CONSTRAINT ken_chest_auto_jobs_pkey PRIMARY KEY (id);


--
-- Name: ken_chest_auto_settings ken_chest_auto_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ken_chest_auto_settings
    ADD CONSTRAINT ken_chest_auto_settings_pkey PRIMARY KEY (id);


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
-- Name: me_comment_likes me_comment_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_comment_likes
    ADD CONSTRAINT me_comment_likes_pkey PRIMARY KEY (comment_id, user_id);


--
-- Name: me_comments me_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_comments
    ADD CONSTRAINT me_comments_pkey PRIMARY KEY (id);


--
-- Name: me_notifications me_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_notifications
    ADD CONSTRAINT me_notifications_pkey PRIMARY KEY (id);


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
-- Name: mini_games mini_games_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mini_games
    ADD CONSTRAINT mini_games_pkey PRIMARY KEY (id);


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
-- Name: room_user_blocks room_user_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_user_blocks
    ADD CONSTRAINT room_user_blocks_pkey PRIMARY KEY (user_id, blocked_user_id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: stories stories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT stories_pkey PRIMARY KEY (id);


--
-- Name: stories stories_source_story_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT stories_source_story_key UNIQUE (source, source_story_id);


--
-- Name: story_chapters story_chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_chapters
    ADD CONSTRAINT story_chapters_pkey PRIMARY KEY (id);


--
-- Name: story_chapters story_chapters_position_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_chapters
    ADD CONSTRAINT story_chapters_position_key UNIQUE (story_id, "position") DEFERRABLE INITIALLY DEFERRED;


--
-- Name: story_chapters story_chapters_source_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_chapters
    ADD CONSTRAINT story_chapters_source_key UNIQUE (story_id, source_chapter_id);


--
-- Name: story_comment_likes story_comment_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_comment_likes
    ADD CONSTRAINT story_comment_likes_pkey PRIMARY KEY (comment_id, user_id);


--
-- Name: story_comments story_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_comments
    ADD CONSTRAINT story_comments_pkey PRIMARY KEY (id);


--
-- Name: story_unlocks story_unlocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_unlocks
    ADD CONSTRAINT story_unlocks_pkey PRIMARY KEY (user_id, story_id);


--
-- Name: topup_transactions topup_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topup_transactions
    ADD CONSTRAINT topup_transactions_pkey PRIMARY KEY (id);


--
-- Name: topup_transactions topup_transactions_provider_tx_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topup_transactions
    ADD CONSTRAINT topup_transactions_provider_tx_id_key UNIQUE (provider_tx_id);


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
-- Name: user_game_levels user_game_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_game_levels
    ADD CONSTRAINT user_game_levels_pkey PRIMARY KEY (user_id, game_id);


--
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (id);


--
-- Name: user_settings user_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT user_settings_pkey PRIMARY KEY (user_id);


--
-- Name: user_vip_icons user_vip_icons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_vip_icons
    ADD CONSTRAINT user_vip_icons_pkey PRIMARY KEY (id);


--
-- Name: username_change_logs username_change_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.username_change_logs
    ADD CONSTRAINT username_change_logs_pkey PRIMARY KEY (id);


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
-- Name: vip_transfers vip_transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vip_transfers
    ADD CONSTRAINT vip_transfers_pkey PRIMARY KEY (id);


--
-- Name: wheel_free_claims wheel_free_claims_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wheel_free_claims
    ADD CONSTRAINT wheel_free_claims_pkey PRIMARY KEY (user_id, wheel_id, claim_date);


--
-- Name: wheel_segment_options wheel_segment_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wheel_segment_options
    ADD CONSTRAINT wheel_segment_options_pkey PRIMARY KEY (id);


--
-- Name: wheel_segments wheel_segments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wheel_segments
    ADD CONSTRAINT wheel_segments_pkey PRIMARY KEY (id);


--
-- Name: wheel_spins wheel_spins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wheel_spins
    ADD CONSTRAINT wheel_spins_pkey PRIMARY KEY (id);


--
-- Name: wheels wheels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wheels
    ADD CONSTRAINT wheels_pkey PRIMARY KEY (id);


--
-- Name: word_chain_hint_purchases word_chain_hint_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.word_chain_hint_purchases
    ADD CONSTRAINT word_chain_hint_purchases_pkey PRIMARY KEY (user_id, session_id, turn);


--
-- Name: word_chain_scores word_chain_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.word_chain_scores
    ADD CONSTRAINT word_chain_scores_pkey PRIMARY KEY (message_id);


--
-- Name: idx_admin_audit_logs_admin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_audit_logs_admin ON public.admin_audit_logs USING btree (admin_id, created_at DESC);


--
-- Name: idx_admin_audit_logs_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_audit_logs_created_at ON public.admin_audit_logs USING btree (created_at DESC);


--
-- Name: idx_admin_audit_logs_resource; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_audit_logs_resource ON public.admin_audit_logs USING btree (resource, created_at DESC);


--
-- Name: idx_admin_sessions_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_sessions_active ON public.admin_sessions USING btree (admin_id, last_active_at DESC) WHERE ((revoked_at IS NULL) AND (deleted_at IS NULL));


--
-- Name: idx_admin_sessions_admin_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_sessions_admin_id ON public.admin_sessions USING btree (admin_id);


--
-- Name: idx_admin_sessions_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_sessions_deleted_at ON public.admin_sessions USING btree (deleted_at);


--
-- Name: idx_admin_sessions_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_sessions_expires_at ON public.admin_sessions USING btree (expires_at);


--
-- Name: idx_admin_users_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_users_deleted_at ON public.admin_users USING btree (deleted_at);


--
-- Name: idx_admin_users_username_lower; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_admin_users_username_lower ON public.admin_users USING btree (lower((username)::text)) WHERE (deleted_at IS NULL);


--
-- Name: idx_announcements_active_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_announcements_active_created ON public.announcements USING btree (is_active, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_announcements_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_announcements_deleted_at ON public.announcements USING btree (deleted_at);


--
-- Name: idx_app_notifications_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_app_notifications_deleted_at ON public.app_notifications USING btree (deleted_at);


--
-- Name: idx_app_notifications_recipient_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_app_notifications_recipient_created ON public.app_notifications USING btree (recipient_id, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_app_notifications_recipient_unread; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_app_notifications_recipient_unread ON public.app_notifications USING btree (recipient_id, is_read) WHERE (deleted_at IS NULL);


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
-- Name: idx_clan_bans_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clan_bans_deleted_at ON public.clan_bans USING btree (deleted_at);


--
-- Name: idx_clan_members_clan_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clan_members_clan_role ON public.clan_members USING btree (clan_id, role) WHERE (deleted_at IS NULL);


--
-- Name: idx_clan_members_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clan_members_deleted_at ON public.clan_members USING btree (deleted_at);


--
-- Name: idx_clan_members_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clan_members_user ON public.clan_members USING btree (user_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_clans_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clans_deleted_at ON public.clans USING btree (deleted_at);


--
-- Name: idx_clans_owner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clans_owner ON public.clans USING btree (owner_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_device_tokens_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_device_tokens_session ON public.device_tokens USING btree (session_id);


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
-- Name: idx_game_match_players_match; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_game_match_players_match ON public.game_match_players USING btree (game_match_id);


--
-- Name: idx_game_match_players_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_game_match_players_user ON public.game_match_players USING btree (user_id);


--
-- Name: idx_game_matches_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_game_matches_deleted_at ON public.game_matches USING btree (deleted_at);


--
-- Name: idx_game_matches_game_status_finished; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_game_matches_game_status_finished ON public.game_matches USING btree (game_id, status, finished_at DESC);


--
-- Name: idx_game_matches_loser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_game_matches_loser ON public.game_matches USING btree (loser_id);


--
-- Name: idx_game_matches_match; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_game_matches_match ON public.game_matches USING btree (match_id);


--
-- Name: idx_game_matches_player0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_game_matches_player0 ON public.game_matches USING btree (player0_id);


--
-- Name: idx_game_matches_player1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_game_matches_player1 ON public.game_matches USING btree (player1_id);


--
-- Name: idx_game_matches_playing_started; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_game_matches_playing_started ON public.game_matches USING btree (started_at) WHERE (((status)::text = 'playing'::text) AND (deleted_at IS NULL));


--
-- Name: idx_game_matches_winner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_game_matches_winner ON public.game_matches USING btree (winner_id);


--
-- Name: idx_ken_chest_auto_jobs_enabled_next; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ken_chest_auto_jobs_enabled_next ON public.ken_chest_auto_jobs USING btree (enabled, next_run_at);


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
-- Name: idx_ken_chests_source; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ken_chests_source ON public.ken_chests USING btree (source);


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
-- Name: idx_me_clan_author; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_clan_author ON public.me USING btree (clan_id, author_id) WHERE ((clan_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: idx_me_clan_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_clan_created ON public.me USING btree (clan_id, created_at DESC) WHERE ((clan_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: idx_me_comment_likes_comment_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_comment_likes_comment_created ON public.me_comment_likes USING btree (comment_id, created_at DESC);


--
-- Name: idx_me_comment_likes_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_comment_likes_user ON public.me_comment_likes USING btree (user_id);


--
-- Name: idx_me_comments_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_comments_deleted_at ON public.me_comments USING btree (deleted_at);


--
-- Name: idx_me_comments_parent_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_comments_parent_created ON public.me_comments USING btree (parent_id, created_at) WHERE (deleted_at IS NULL);


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
-- Name: idx_me_notifications_comment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_notifications_comment_id ON public.me_notifications USING btree (comment_id) WHERE (comment_id IS NOT NULL);


--
-- Name: idx_me_notifications_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_notifications_deleted_at ON public.me_notifications USING btree (deleted_at);


--
-- Name: idx_me_notifications_recipient_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_notifications_recipient_created ON public.me_notifications USING btree (recipient_id, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_me_notifications_recipient_unread; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_me_notifications_recipient_unread ON public.me_notifications USING btree (recipient_id, is_read) WHERE (deleted_at IS NULL);


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
-- Name: idx_mini_games_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mini_games_deleted_at ON public.mini_games USING btree (deleted_at);


--
-- Name: idx_mini_games_enabled_sort; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mini_games_enabled_sort ON public.mini_games USING btree (is_enabled, sort_order);


--
-- Name: idx_mini_games_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_mini_games_slug ON public.mini_games USING btree (slug) WHERE (deleted_at IS NULL);


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
-- Name: idx_pen_shots_settled_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pen_shots_settled_at ON public.pen_shots USING btree (settled_at) WHERE ((status)::text = 'settled'::text);


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
-- Name: idx_stories_activity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stories_activity ON public.stories USING btree (COALESCE(last_chapter_at, source_updated_at) DESC, id DESC) WHERE (NOT is_hidden);


--
-- Name: idx_stories_genres; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stories_genres ON public.stories USING gin (genres);


--
-- Name: idx_stories_published; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stories_published ON public.stories USING btree (published_at DESC, id DESC) WHERE (NOT is_hidden);


--
-- Name: idx_stories_search_text; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stories_search_text ON public.stories USING gin (search_text public.gin_trgm_ops);


--
-- Name: idx_stories_views; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stories_views ON public.stories USING btree (view_count DESC, COALESCE(last_chapter_at, source_updated_at) DESC, id DESC) WHERE (NOT is_hidden);


--
-- Name: idx_story_comments_author; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_story_comments_author ON public.story_comments USING btree (author_id);


--
-- Name: idx_story_comments_story; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_story_comments_story ON public.story_comments USING btree (story_id, created_at DESC, id DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_topup_transactions_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_topup_transactions_created ON public.topup_transactions USING btree (created_at DESC);


--
-- Name: idx_topup_transactions_status_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_topup_transactions_status_created ON public.topup_transactions USING btree (status, created_at DESC);


--
-- Name: idx_topup_transactions_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_topup_transactions_user ON public.topup_transactions USING btree (user_id);


--
-- Name: idx_user_game_levels_game_exp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_game_levels_game_exp ON public.user_game_levels USING btree (game_id, exp DESC);


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
-- Name: idx_username_change_logs_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_username_change_logs_created ON public.username_change_logs USING btree (created_at DESC);


--
-- Name: idx_username_change_logs_user_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_username_change_logs_user_created ON public.username_change_logs USING btree (user_id, created_at DESC);


--
-- Name: idx_users_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_deleted_at ON public.users USING btree (deleted_at);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_email ON public.users USING btree (email) WHERE (deleted_at IS NULL);


--
-- Name: idx_users_email_verified_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_users_email_verified_unique ON public.users USING btree (lower((email)::text)) WHERE ((email_verified = true) AND (deleted_at IS NULL));


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
-- Name: idx_vip_transfers_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_vip_transfers_created_at ON public.vip_transfers USING btree (created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_vip_transfers_from; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_vip_transfers_from ON public.vip_transfers USING btree (from_user_id, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_vip_transfers_to; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_vip_transfers_to ON public.vip_transfers USING btree (to_user_id, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_vp_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_vp_user ON public.vip_purchases USING btree (user_id, created_at DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_wheel_segment_options_segment; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wheel_segment_options_segment ON public.wheel_segment_options USING btree (segment_id, sort_order);


--
-- Name: idx_wheel_segments_wheel; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wheel_segments_wheel ON public.wheel_segments USING btree (wheel_id, sort_order);


--
-- Name: idx_wheel_spins_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wheel_spins_user ON public.wheel_spins USING btree (user_id, created_at DESC);


--
-- Name: idx_wheel_spins_wheel; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wheel_spins_wheel ON public.wheel_spins USING btree (wheel_id, created_at DESC);


--
-- Name: idx_wheels_list; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wheels_list ON public.wheels USING btree (sort_order) WHERE (deleted_at IS NULL);


--
-- Name: idx_word_chain_scores_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_word_chain_scores_created_at ON public.word_chain_scores USING btree (created_at);


--
-- Name: idx_word_chain_scores_user_points; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_word_chain_scores_user_points ON public.word_chain_scores USING btree (user_id) INCLUDE (points, is_win);


--
-- Name: idx_word_chain_scores_user_wins; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_word_chain_scores_user_wins ON public.word_chain_scores USING btree (user_id, created_at DESC, message_id DESC) WHERE is_win;


--
-- Name: idx_word_chain_scores_wins; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_word_chain_scores_wins ON public.word_chain_scores USING btree (created_at DESC, message_id DESC) WHERE is_win;


--
-- Name: uq_app_notifications_recipient_type_ref; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_app_notifications_recipient_type_ref ON public.app_notifications USING btree (recipient_id, type, ref_id) WHERE (ref_id IS NOT NULL);


--
-- Name: uq_clan_bans_clan_user; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_clan_bans_clan_user ON public.clan_bans USING btree (clan_id, user_id) WHERE (deleted_at IS NULL);


--
-- Name: uq_clan_members_clan_user; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_clan_members_clan_user ON public.clan_members USING btree (clan_id, user_id) WHERE (deleted_at IS NULL);


--
-- Name: uq_clan_members_one_ambassador; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_clan_members_one_ambassador ON public.clan_members USING btree (clan_id) WHERE (((role)::text = 'ambassador'::text) AND (deleted_at IS NULL));


--
-- Name: uq_clan_members_one_deputy; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_clan_members_one_deputy ON public.clan_members USING btree (clan_id) WHERE (((role)::text = 'deputy'::text) AND (deleted_at IS NULL));


--
-- Name: uq_clan_members_one_owner; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_clan_members_one_owner ON public.clan_members USING btree (clan_id) WHERE (((role)::text = 'owner'::text) AND (deleted_at IS NULL));


--
-- Name: uq_clans_handle; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_clans_handle ON public.clans USING btree (handle) WHERE (deleted_at IS NULL);


--
-- Name: uq_device_tokens_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_device_tokens_token ON public.device_tokens USING btree (token);


--
-- Name: uq_device_tokens_user_device; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_device_tokens_user_device ON public.device_tokens USING btree (user_id, device_id);


--
-- Name: uq_me_notifications_comment_like; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_me_notifications_comment_like ON public.me_notifications USING btree (recipient_id, actor_id, comment_id) WHERE ((type)::text = 'comment_like'::text);


--
-- Name: uq_me_notifications_like; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_me_notifications_like ON public.me_notifications USING btree (recipient_id, actor_id, post_id) WHERE ((type)::text = 'like'::text);


--
-- Name: ux_user_sessions_active_device; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ux_user_sessions_active_device ON public.user_sessions USING btree (user_id, device_id) WHERE (((device_id)::text <> ''::text) AND (revoked_at IS NULL));


--
-- Name: stories stories_search_text; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER stories_search_text BEFORE INSERT OR UPDATE OF title, author_name ON public.stories FOR EACH ROW EXECUTE FUNCTION public.stories_set_search_text();


--
-- Name: relationships update_relationships_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_relationships_updated_at BEFORE UPDATE ON public.relationships FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: users update_users_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: admin_sessions admin_sessions_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_sessions
    ADD CONSTRAINT admin_sessions_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;


--
-- Name: device_tokens device_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_tokens
    ADD CONSTRAINT device_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.user_sessions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: device_tokens device_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_tokens
    ADD CONSTRAINT device_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: calls fk_calls_caller; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT fk_calls_caller FOREIGN KEY (caller_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: clan_bans fk_clan_bans_clan; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clan_bans
    ADD CONSTRAINT fk_clan_bans_clan FOREIGN KEY (clan_id) REFERENCES public.clans(id) ON DELETE CASCADE;


--
-- Name: clan_bans fk_clan_bans_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clan_bans
    ADD CONSTRAINT fk_clan_bans_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: clan_members fk_clan_members_clan; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clan_members
    ADD CONSTRAINT fk_clan_members_clan FOREIGN KEY (clan_id) REFERENCES public.clans(id) ON DELETE CASCADE;


--
-- Name: clan_members fk_clan_members_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clan_members
    ADD CONSTRAINT fk_clan_members_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: clans fk_clans_owner; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clans
    ADD CONSTRAINT fk_clans_owner FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;


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
-- Name: game_matches fk_game_matches_loser; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_matches
    ADD CONSTRAINT fk_game_matches_loser FOREIGN KEY (loser_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: game_matches fk_game_matches_player0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_matches
    ADD CONSTRAINT fk_game_matches_player0 FOREIGN KEY (player0_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: game_matches fk_game_matches_player1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_matches
    ADD CONSTRAINT fk_game_matches_player1 FOREIGN KEY (player1_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: game_matches fk_game_matches_winner; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_matches
    ADD CONSTRAINT fk_game_matches_winner FOREIGN KEY (winner_id) REFERENCES public.users(id) ON DELETE RESTRICT;


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
-- Name: me_comment_likes fk_me_comment_likes_comment; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_comment_likes
    ADD CONSTRAINT fk_me_comment_likes_comment FOREIGN KEY (comment_id) REFERENCES public.me_comments(id) ON DELETE CASCADE;


--
-- Name: me_comment_likes fk_me_comment_likes_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_comment_likes
    ADD CONSTRAINT fk_me_comment_likes_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: me_comments fk_me_comments_author; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_comments
    ADD CONSTRAINT fk_me_comments_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: me_comments fk_me_comments_parent; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.me_comments
    ADD CONSTRAINT fk_me_comments_parent FOREIGN KEY (parent_id) REFERENCES public.me_comments(id) ON DELETE CASCADE;


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
-- Name: user_game_levels fk_user_game_levels_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_game_levels
    ADD CONSTRAINT fk_user_game_levels_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


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
-- Name: vip_transfers fk_vip_transfers_from; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vip_transfers
    ADD CONSTRAINT fk_vip_transfers_from FOREIGN KEY (from_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: vip_transfers fk_vip_transfers_to; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vip_transfers
    ADD CONSTRAINT fk_vip_transfers_to FOREIGN KEY (to_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


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
-- Name: wheel_free_claims fk_wheel_free_claims_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wheel_free_claims
    ADD CONSTRAINT fk_wheel_free_claims_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: wheel_segment_options fk_wheel_segment_options_segment; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wheel_segment_options
    ADD CONSTRAINT fk_wheel_segment_options_segment FOREIGN KEY (segment_id) REFERENCES public.wheel_segments(id) ON DELETE CASCADE;


--
-- Name: wheel_segments fk_wheel_segments_wheel; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wheel_segments
    ADD CONSTRAINT fk_wheel_segments_wheel FOREIGN KEY (wheel_id) REFERENCES public.wheels(id) ON DELETE CASCADE;


--
-- Name: wheel_spins fk_wheel_spins_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wheel_spins
    ADD CONSTRAINT fk_wheel_spins_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: game_match_players game_match_players_match_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_match_players
    ADD CONSTRAINT game_match_players_match_fkey FOREIGN KEY (game_match_id) REFERENCES public.game_matches(id) ON DELETE CASCADE;


--
-- Name: game_match_players game_match_players_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_match_players
    ADD CONSTRAINT game_match_players_user_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: ken_chests ken_chests_auto_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ken_chests
    ADD CONSTRAINT ken_chests_auto_job_id_fkey FOREIGN KEY (auto_job_id) REFERENCES public.ken_chest_auto_jobs(id) ON DELETE SET NULL;


--
-- Name: room_user_blocks room_user_blocks_blocked_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_user_blocks
    ADD CONSTRAINT room_user_blocks_blocked_user_id_fkey FOREIGN KEY (blocked_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: room_user_blocks room_user_blocks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_user_blocks
    ADD CONSTRAINT room_user_blocks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: story_chapters story_chapters_story_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_chapters
    ADD CONSTRAINT story_chapters_story_id_fkey FOREIGN KEY (story_id) REFERENCES public.stories(id) ON DELETE CASCADE;


--
-- Name: story_comment_likes story_comment_likes_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_comment_likes
    ADD CONSTRAINT story_comment_likes_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.story_comments(id) ON DELETE CASCADE;


--
-- Name: story_comment_likes story_comment_likes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_comment_likes
    ADD CONSTRAINT story_comment_likes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: story_comments story_comments_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_comments
    ADD CONSTRAINT story_comments_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: story_comments story_comments_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_comments
    ADD CONSTRAINT story_comments_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.story_comments(id) ON DELETE SET NULL;


--
-- Name: story_comments story_comments_story_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_comments
    ADD CONSTRAINT story_comments_story_id_fkey FOREIGN KEY (story_id) REFERENCES public.stories(id) ON DELETE CASCADE;


--
-- Name: story_unlocks story_unlocks_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_unlocks
    ADD CONSTRAINT story_unlocks_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.story_comments(id) ON DELETE SET NULL;


--
-- Name: story_unlocks story_unlocks_story_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_unlocks
    ADD CONSTRAINT story_unlocks_story_id_fkey FOREIGN KEY (story_id) REFERENCES public.stories(id) ON DELETE CASCADE;


--
-- Name: story_unlocks story_unlocks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_unlocks
    ADD CONSTRAINT story_unlocks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_settings user_settings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT user_settings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: word_chain_hint_purchases word_chain_hint_purchases_ken_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.word_chain_hint_purchases
    ADD CONSTRAINT word_chain_hint_purchases_ken_transaction_id_fkey FOREIGN KEY (ken_transaction_id) REFERENCES public.ken_transactions(id);


--
-- Name: word_chain_hint_purchases word_chain_hint_purchases_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.word_chain_hint_purchases
    ADD CONSTRAINT word_chain_hint_purchases_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: word_chain_scores word_chain_scores_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.word_chain_scores
    ADD CONSTRAINT word_chain_scores_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


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

INSERT INTO public.ken_chest_auto_settings (enabled) VALUES (true);

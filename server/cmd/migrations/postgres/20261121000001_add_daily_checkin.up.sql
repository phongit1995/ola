CREATE TABLE IF NOT EXISTS public.checkin_months (
    month date PRIMARY KEY CHECK (EXTRACT(DAY FROM month) = 1),
    slot_count smallint NOT NULL CHECK (slot_count BETWEEN 1 AND 31),
    published_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS public.checkin_slots (
    month date NOT NULL REFERENCES public.checkin_months(month) ON DELETE CASCADE,
    slot smallint NOT NULL CHECK (slot BETWEEN 1 AND 31),
    gifts jsonb DEFAULT '[]'::jsonb NOT NULL,
    featured boolean NOT NULL,
    require_vip boolean NOT NULL,
    task character varying(32),
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (month, slot),
    CONSTRAINT checkin_slots_task_check CHECK (((jsonb_array_length(gifts) = 0) = (task IS NULL)))
);

CREATE TABLE IF NOT EXISTS public.user_checkins (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    day date NOT NULL,
    month date NOT NULL REFERENCES public.checkin_months(month),
    slot smallint NOT NULL,
    task character varying(32),
    reward_status character varying(12) NOT NULL,
    reward_snapshot jsonb NOT NULL,
    reward_result jsonb,
    vip_at_checkin boolean NOT NULL,
    client_request_id character varying(64) NOT NULL,
    task_done_at timestamp with time zone,
    claimed_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT user_checkins_reward_status_check CHECK (((reward_status)::text = ANY ((ARRAY['none'::character varying, 'pending'::character varying, 'claimed'::character varying])::text[])))
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_checkins_day ON public.user_checkins USING btree (user_id, day);
CREATE UNIQUE INDEX IF NOT EXISTS uq_user_checkins_slot ON public.user_checkins USING btree (user_id, month, slot);
CREATE UNIQUE INDEX IF NOT EXISTS uq_user_checkins_client_request ON public.user_checkins USING btree (user_id, client_request_id);
CREATE INDEX IF NOT EXISTS idx_user_checkins_month_created ON public.user_checkins USING btree (month, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_me_comments_author_created ON public.me_comments USING btree (author_id, created_at DESC) WHERE (deleted_at IS NULL);
CREATE INDEX IF NOT EXISTS idx_me_reactions_user_updated ON public.me_reactions USING btree (user_id, updated_at DESC);
CREATE INDEX IF NOT EXISTS idx_moment_comments_author_created ON public.moment_comments USING btree (author_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_game_matches_player0_finished ON public.game_matches USING btree (player0_id, finished_at) WHERE (((status)::text = 'finished'::text) AND (deleted_at IS NULL));
CREATE INDEX IF NOT EXISTS idx_game_matches_player1_finished ON public.game_matches USING btree (player1_id, finished_at) WHERE (((status)::text = 'finished'::text) AND (deleted_at IS NULL));
CREATE INDEX IF NOT EXISTS idx_story_comments_author_created ON public.story_comments USING btree (author_id, created_at DESC) WHERE (deleted_at IS NULL);

ALTER TABLE public.user_avatar_frames DROP CONSTRAINT IF EXISTS user_avatar_frames_source_check;
ALTER TABLE public.user_avatar_frames ADD CONSTRAINT user_avatar_frames_source_check CHECK (((source)::text = ANY ((ARRAY['purchase'::character varying, 'gift'::character varying, 'transfer'::character varying, 'gift_code'::character varying, 'admin'::character varying, 'checkin'::character varying])::text[])));

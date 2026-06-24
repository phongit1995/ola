CREATE TABLE public.pen_shots (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    shooter_id uuid NOT NULL,
    shooter_side character varying(8) NOT NULL,
    bet_amount integer NOT NULL,
    status character varying(16) DEFAULT 'open' NOT NULL,
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
    CONSTRAINT pen_shots_pkey PRIMARY KEY (id),
    CONSTRAINT pen_shots_side_check CHECK (shooter_side IN ('left', 'right')),
    CONSTRAINT pen_shots_keeper_side_check CHECK (keeper_side IN ('left', 'right')),
    CONSTRAINT pen_shots_status_check CHECK (status IN ('open', 'settled', 'cancelled')),
    CONSTRAINT pen_shots_result_check CHECK (result IN ('saved', 'goal')),
    CONSTRAINT pen_shots_bet_check CHECK (bet_amount > 0),
    CONSTRAINT pen_shots_no_self_check CHECK (keeper_id IS NULL OR keeper_id <> shooter_id)
);

ALTER TABLE ONLY public.pen_shots
    ADD CONSTRAINT fk_pen_shooter FOREIGN KEY (shooter_id) REFERENCES public.users(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.pen_shots
    ADD CONSTRAINT fk_pen_keeper FOREIGN KEY (keeper_id) REFERENCES public.users(id) ON DELETE SET NULL;

CREATE INDEX idx_pen_shots_open ON public.pen_shots USING btree (created_at DESC) WHERE status = 'open' AND deleted_at IS NULL;
CREATE INDEX idx_pen_shots_open_bet ON public.pen_shots USING btree (bet_amount, created_at DESC) WHERE status = 'open' AND deleted_at IS NULL;
CREATE INDEX idx_pen_shots_shooter ON public.pen_shots USING btree (shooter_id, created_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX idx_pen_shots_keeper ON public.pen_shots USING btree (keeper_id, created_at DESC) WHERE keeper_id IS NOT NULL AND deleted_at IS NULL;

ALTER TABLE public.users
    ADD COLUMN spouse_id uuid;

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_spouse FOREIGN KEY (spouse_id) REFERENCES public.users(id) ON DELETE SET NULL;

CREATE INDEX idx_users_spouse ON public.users USING btree (spouse_id) WHERE spouse_id IS NOT NULL;

CREATE TABLE public.marriage_proposals (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    proposer_id uuid NOT NULL,
    addressee_id uuid NOT NULL,
    message character varying(500),
    status character varying(20) DEFAULT 'pending' NOT NULL,
    responded_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT marriage_proposals_pkey PRIMARY KEY (id),
    CONSTRAINT marriage_proposals_status_check CHECK (status IN ('pending', 'accepted', 'rejected', 'cancelled')),
    CONSTRAINT marriage_proposals_no_self_check CHECK (proposer_id <> addressee_id)
);

ALTER TABLE ONLY public.marriage_proposals
    ADD CONSTRAINT fk_mp_proposer FOREIGN KEY (proposer_id) REFERENCES public.users(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.marriage_proposals
    ADD CONSTRAINT fk_mp_addressee FOREIGN KEY (addressee_id) REFERENCES public.users(id) ON DELETE CASCADE;

CREATE UNIQUE INDEX idx_mp_pending_unique ON public.marriage_proposals USING btree (proposer_id, addressee_id) WHERE status = 'pending' AND deleted_at IS NULL;
CREATE INDEX idx_mp_addressee ON public.marriage_proposals USING btree (addressee_id, status, created_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX idx_mp_proposer ON public.marriage_proposals USING btree (proposer_id, status, created_at DESC) WHERE deleted_at IS NULL;

CREATE TABLE public.marriages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_low_id uuid NOT NULL,
    user_high_id uuid NOT NULL,
    status character varying(20) DEFAULT 'active' NOT NULL,
    proposal_id uuid,
    married_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    divorced_at timestamp without time zone,
    divorced_by uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT marriages_pkey PRIMARY KEY (id),
    CONSTRAINT marriages_status_check CHECK (status IN ('active', 'divorced')),
    CONSTRAINT marriages_user_order_check CHECK (user_low_id < user_high_id)
);

ALTER TABLE ONLY public.marriages
    ADD CONSTRAINT fk_m_low FOREIGN KEY (user_low_id) REFERENCES public.users(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.marriages
    ADD CONSTRAINT fk_m_high FOREIGN KEY (user_high_id) REFERENCES public.users(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.marriages
    ADD CONSTRAINT fk_m_proposal FOREIGN KEY (proposal_id) REFERENCES public.marriage_proposals(id) ON DELETE SET NULL;

CREATE UNIQUE INDEX idx_m_active_pair_unique ON public.marriages USING btree (user_low_id, user_high_id) WHERE status = 'active' AND deleted_at IS NULL;
CREATE INDEX idx_m_low ON public.marriages USING btree (user_low_id, status) WHERE deleted_at IS NULL;
CREATE INDEX idx_m_high ON public.marriages USING btree (user_high_id, status) WHERE deleted_at IS NULL;

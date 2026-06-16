CREATE TABLE public.follows (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    follower_id uuid NOT NULL,
    followee_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT follows_pkey PRIMARY KEY (id),
    CONSTRAINT check_no_self_follow CHECK ((follower_id <> followee_id)),
    CONSTRAINT unique_follow UNIQUE (follower_id, followee_id)
);

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT fk_follows_follower FOREIGN KEY (follower_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT fk_follows_followee FOREIGN KEY (followee_id) REFERENCES public.users(id) ON DELETE CASCADE;

CREATE INDEX idx_follows_follower ON public.follows USING btree (follower_id);
CREATE INDEX idx_follows_followee ON public.follows USING btree (followee_id);

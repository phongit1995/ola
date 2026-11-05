ALTER TABLE public.gifts ADD COLUMN sender_charm_percent smallint DEFAULT 50 NOT NULL;
ALTER TABLE public.gifts ADD CONSTRAINT gifts_sender_charm_percent_range CHECK (sender_charm_percent BETWEEN 0 AND 100);
ALTER TABLE public.gift_transactions ADD COLUMN sender_charm_points integer DEFAULT 0 NOT NULL;

ALTER TABLE public.gift_transactions DROP COLUMN IF EXISTS sender_charm_points;
ALTER TABLE public.gifts DROP CONSTRAINT IF EXISTS gifts_sender_charm_percent_range;
ALTER TABLE public.gifts DROP COLUMN IF EXISTS sender_charm_percent;

ALTER TABLE public.users ADD COLUMN vip_store_privacy smallint DEFAULT 0 NOT NULL;

UPDATE public.users u
SET vip_store_privacy = us.vip_store_privacy
FROM public.user_settings us
WHERE u.id = us.user_id AND us.vip_store_privacy <> 0;

ALTER TABLE public.user_settings DROP COLUMN vip_store_privacy;

ALTER TABLE public.user_settings ADD COLUMN vip_store_privacy smallint DEFAULT 0 NOT NULL;

UPDATE public.user_settings us
SET vip_store_privacy = u.vip_store_privacy
FROM public.users u
WHERE us.user_id = u.id AND u.vip_store_privacy <> 0;

INSERT INTO public.user_settings (user_id, vip_store_privacy)
SELECT u.id, u.vip_store_privacy
FROM public.users u
WHERE u.vip_store_privacy <> 0
  AND NOT EXISTS (SELECT 1 FROM public.user_settings us WHERE us.user_id = u.id);

ALTER TABLE public.users DROP COLUMN vip_store_privacy;

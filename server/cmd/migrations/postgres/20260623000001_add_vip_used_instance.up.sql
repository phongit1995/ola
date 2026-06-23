ALTER TABLE public.users ADD COLUMN IF NOT EXISTS vip_used_instance_id uuid;

UPDATE public.users u
SET vip_used_instance_id = (
    SELECT v.id FROM user_vip_icons v
    WHERE v.user_id = u.id
      AND v.vip_icon_id::text = u.vip_used
      AND v.deleted_at IS NULL
    ORDER BY v.acquired_at DESC
    LIMIT 1
)
WHERE u.vip_used IS NOT NULL AND u.vip_used <> '';

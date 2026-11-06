ALTER TABLE public.gifts DROP COLUMN IF EXISTS announce_enabled;

DELETE FROM public.megaphones WHERE type = 'gift';

DROP INDEX IF EXISTS public.idx_megaphones_active_expires;
DROP INDEX IF EXISTS public.uq_megaphones_gift_transaction;

ALTER TABLE public.megaphones
    DROP CONSTRAINT IF EXISTS fk_megaphones_gift_transaction,
    DROP CONSTRAINT IF EXISTS megaphones_weight_check,
    DROP CONSTRAINT IF EXISTS megaphones_type_check,
    DROP COLUMN IF EXISTS gift_transaction_id,
    DROP COLUMN IF EXISTS first_played_at,
    DROP COLUMN IF EXISTS expires_at,
    DROP COLUMN IF EXISTS weight,
    DROP COLUMN IF EXISTS type;

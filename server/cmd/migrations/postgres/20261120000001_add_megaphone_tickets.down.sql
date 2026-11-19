DROP INDEX IF EXISTS public.idx_megaphones_ticket_id;

ALTER TABLE public.megaphones DROP COLUMN IF EXISTS ticket_id;

DROP TABLE IF EXISTS public.user_megaphone_tickets;

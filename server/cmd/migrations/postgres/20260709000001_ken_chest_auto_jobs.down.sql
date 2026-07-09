DROP INDEX IF EXISTS idx_ken_chests_source;
ALTER TABLE public.ken_chests DROP CONSTRAINT IF EXISTS ken_chests_auto_job_id_fkey;
ALTER TABLE public.ken_chests DROP CONSTRAINT IF EXISTS ken_chests_source_check;
ALTER TABLE public.ken_chests DROP COLUMN IF EXISTS auto_job_id;
ALTER TABLE public.ken_chests DROP COLUMN IF EXISTS source;

DROP TABLE IF EXISTS public.ken_chest_auto_settings;
DROP TABLE IF EXISTS public.ken_chest_auto_jobs;

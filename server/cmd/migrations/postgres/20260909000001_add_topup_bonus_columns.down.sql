ALTER TABLE topup_transactions
    DROP COLUMN IF EXISTS bonus_ken,
    DROP COLUMN IF EXISTS bonus_percent;

ALTER TABLE topup_transactions
    ADD COLUMN IF NOT EXISTS bonus_ken bigint NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS bonus_percent integer NOT NULL DEFAULT 0;

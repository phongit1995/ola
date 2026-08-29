CREATE TABLE IF NOT EXISTS topup_transactions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_tx_id varchar(120) NOT NULL,
    description varchar(500) NOT NULL DEFAULT '',
    amount bigint NOT NULL,
    type varchar(10) NOT NULL,
    status varchar(30) NOT NULL,
    matched_username varchar(50),
    user_id uuid,
    ken_amount bigint NOT NULL DEFAULT 0,
    ken_tx_id uuid,
    note varchar(255),
    raw jsonb,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT topup_transactions_pkey PRIMARY KEY (id),
    CONSTRAINT topup_transactions_provider_tx_id_key UNIQUE (provider_tx_id)
);

CREATE INDEX IF NOT EXISTS idx_topup_transactions_status_created ON topup_transactions USING btree (status, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_topup_transactions_user ON topup_transactions USING btree (user_id);
CREATE INDEX IF NOT EXISTS idx_topup_transactions_created ON topup_transactions USING btree (created_at DESC);

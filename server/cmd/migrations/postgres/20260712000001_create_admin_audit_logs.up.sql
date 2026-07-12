CREATE TABLE IF NOT EXISTS admin_audit_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    admin_id uuid NOT NULL,
    method varchar(10) NOT NULL,
    resource varchar(60) NOT NULL,
    path varchar(300) NOT NULL,
    route varchar(300),
    status integer NOT NULL,
    ip varchar(45),
    detail jsonb,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT admin_audit_logs_pkey PRIMARY KEY (id)
);

CREATE INDEX IF NOT EXISTS idx_admin_audit_logs_created_at ON admin_audit_logs USING btree (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_admin_audit_logs_admin ON admin_audit_logs USING btree (admin_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_admin_audit_logs_resource ON admin_audit_logs USING btree (resource, created_at DESC);

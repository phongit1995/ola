CREATE TABLE IF NOT EXISTS admin_users (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username          VARCHAR(255) NOT NULL,
    password          VARCHAR(255) NOT NULL,
    full_name         VARCHAR(100),
    email             VARCHAR(255),
    avatar            VARCHAR(500),
    role              VARCHAR(20) NOT NULL DEFAULT 'ADMIN',
    is_active         BOOLEAN NOT NULL DEFAULT TRUE,
    refresh_token     TEXT,
    last_login_ip     VARCHAR(45),
    last_login_at     TIMESTAMP,
    created_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at        TIMESTAMP
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_admin_users_username_lower
    ON admin_users (LOWER(username))
    WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_admin_users_deleted_at ON admin_users(deleted_at);

INSERT INTO admin_users (username, password, full_name, role)
SELECT 'admin', crypt('admin@123', gen_salt('bf')), 'Super Admin', 'SUPER_ADMIN'
WHERE NOT EXISTS (
    SELECT 1 FROM admin_users WHERE LOWER(username) = 'admin'
);

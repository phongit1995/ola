CREATE TABLE IF NOT EXISTS rooms (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(150) NOT NULL,
    description   TEXT,
    image_url     VARCHAR(500),
    max_members   INT NOT NULL DEFAULT 0,
    member_count  INT NOT NULL DEFAULT 0,
    enabled       BOOLEAN NOT NULL DEFAULT TRUE,
    created_by    UUID NOT NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at    TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_rooms_deleted_at ON rooms(deleted_at);
CREATE INDEX IF NOT EXISTS idx_rooms_enabled ON rooms(enabled) WHERE deleted_at IS NULL;

CREATE TABLE IF NOT EXISTS room_members (
    room_id    UUID NOT NULL,
    user_id    UUID NOT NULL,
    joined_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (room_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_room_members_user ON room_members(user_id);

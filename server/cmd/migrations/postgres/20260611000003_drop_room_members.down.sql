ALTER TABLE rooms ADD COLUMN IF NOT EXISTS member_count INT NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS room_members (
    room_id    UUID NOT NULL,
    user_id    UUID NOT NULL,
    joined_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (room_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_room_members_user ON room_members(user_id);

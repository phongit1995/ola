CREATE TABLE IF NOT EXISTS chat_keyspace.conversation_cleared_by_user (
    user_id         uuid,
    conversation_id uuid,
    cleared_before  timeuuid,
    cleared_at      timestamp,
    PRIMARY KEY (user_id, conversation_id)
);

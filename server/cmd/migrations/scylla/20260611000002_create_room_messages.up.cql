CREATE TABLE IF NOT EXISTS chat_keyspace.room_messages (
    room_id       uuid,
    message_id    timeuuid,
    sender_id     uuid,
    sender_name   text,
    sender_avatar text,
    content       text,
    created_at    timestamp,
    PRIMARY KEY ((room_id), message_id)
) WITH CLUSTERING ORDER BY (message_id DESC)
  AND compaction = {
      'class': 'TimeWindowCompactionStrategy',
      'compaction_window_size': 1,
      'compaction_window_unit': 'DAYS'
  };

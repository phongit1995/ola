-- Baseline gộp nhiều migration nên không rollback: DROP toàn bộ schema ở đây sẽ xoá sạch dữ liệu.
DO $$
BEGIN
    RAISE EXCEPTION 'Baseline 20261011000001 không rollback được. Schema vẫn nguyên; khôi phục trạng thái migration bằng: UPDATE schema_migrations SET version = 20261011000001, dirty = false;';
END
$$;

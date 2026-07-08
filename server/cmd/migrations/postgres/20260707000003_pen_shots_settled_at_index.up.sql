CREATE INDEX IF NOT EXISTS idx_pen_shots_settled_at ON pen_shots (settled_at) WHERE status = 'settled';

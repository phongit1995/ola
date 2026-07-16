CREATE UNIQUE INDEX IF NOT EXISTS uq_me_notifications_comment_like ON public.me_notifications USING btree (recipient_id, actor_id, comment_id) WHERE (type = 'comment_like');
CREATE INDEX IF NOT EXISTS idx_me_notifications_comment_id ON public.me_notifications USING btree (comment_id) WHERE (comment_id IS NOT NULL);

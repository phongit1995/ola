import { useCallback, useEffect, useState } from 'react';
import { MeService } from '@services';
import type { PostComment } from '@app-types';
import { toApiError, toast } from '@lib';
import i18n from '@/i18n';

interface UseMeCommentsOptions {
  onDelta?: (delta: number) => void;
}

export function useMeComments(postId: string, options: UseMeCommentsOptions = {}) {
  const { onDelta } = options;
  const [comments, setComments] = useState<PostComment[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [replyTarget, setReplyTarget] = useState<PostComment | null>(null);

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const result = await MeService.comments(postId, { limit: 50 });
        if (!active) return;
        setComments(result.items);
        setTotal(result.total);
      } catch (err) {
        console.error('load comments failed', err);
        if (active) setError(true);
      } finally {
        if (active) setLoading(false);
      }
    })();
    return () => {
      active = false;
    };
  }, [postId]);

  const add = useCallback(
    async (content: string): Promise<boolean> => {
      const text = content.trim();
      if (text === '' || submitting) return false;
      setSubmitting(true);
      try {
        const created = await MeService.addComment(postId, {
          content: text,
          parentId: replyTarget?.id,
        });
        setComments((current) => [...current, created]);
        setTotal((value) => value + 1);
        setReplyTarget(null);
        onDelta?.(1);
        toast.success(i18n.t('me.commentSent'));
        return true;
      } catch (err) {
        if (toApiError(err).status === 403) {
          toast.error(i18n.t('me.commentErrFriendsOnly'));
          return false;
        }
        console.error('add comment failed', err);
        toast.error(i18n.t('me.commentSendError'));
        return false;
      } finally {
        setSubmitting(false);
      }
    },
    [postId, submitting, onDelta, replyTarget]
  );

  const remove = useCallback(
    async (commentId: string) => {
      const snapshot = comments;
      setComments((current) => current.filter((item) => item.id !== commentId));
      setTotal((value) => Math.max(0, value - 1));
      try {
        await MeService.deleteComment(postId, commentId);
        onDelta?.(-1);
        toast.success(i18n.t('me.commentDeleted'));
      } catch (err) {
        console.error('delete comment failed', err);
        setComments(snapshot);
        setTotal((value) => value + 1);
        toast.error(i18n.t('me.commentDeleteError'));
      }
    },
    [postId, comments, onDelta]
  );

  return { comments, total, loading, error, submitting, add, remove, replyTarget, setReplyTarget };
}

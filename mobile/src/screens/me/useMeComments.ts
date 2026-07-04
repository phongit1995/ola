import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { MeService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { PostComment } from '@ola/shared/types';

interface UseMeCommentsOptions {
  onDelta?: (delta: number) => void;
}

export function useMeComments(postId: string, options: UseMeCommentsOptions = {}) {
  const { onDelta } = options;
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [comments, setComments] = useState<PostComment[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const result = await MeService.comments(postId, { limit: 50 });
        if (!active) return;
        setComments(result.items);
        setTotal(result.total);
      } catch {
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
        const created = await MeService.addComment(postId, { content: text });
        setComments((current) => [...current, created]);
        setTotal((value) => value + 1);
        onDelta?.(1);
        return true;
      } catch {
        push('error', t('me.commentSendError'));
        return false;
      } finally {
        setSubmitting(false);
      }
    },
    [postId, submitting, onDelta, push, t]
  );

  const remove = useCallback(
    async (commentId: string) => {
      const snapshot = comments;
      setComments((current) => current.filter((item) => item.id !== commentId));
      setTotal((value) => Math.max(0, value - 1));
      try {
        await MeService.deleteComment(postId, commentId);
        onDelta?.(-1);
        push('success', t('me.commentDeleted'));
      } catch {
        setComments(snapshot);
        setTotal((value) => value + 1);
        push('error', t('me.commentDeleteError'));
      }
    },
    [postId, comments, onDelta, push, t]
  );

  return { comments, total, loading, error, submitting, add, remove };
}

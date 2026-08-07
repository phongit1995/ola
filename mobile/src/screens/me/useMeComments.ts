import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { MeService } from '@ola/shared/services';
import { toApiError } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { selfLiker } from '@ola/shared/stores/feed/selfLiker';
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
  const [replyTarget, setReplyTarget] = useState<PostComment | null>(null);
  const commentsRef = useRef<PostComment[]>([]);
  const pendingLikes = useRef<Set<string>>(new Set());

  useEffect(() => {
    commentsRef.current = comments;
  }, [comments]);

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
        const created = await MeService.addComment(postId, {
          content: text,
          parentId: replyTarget?.id,
        });
        setComments((current) => [...current, created]);
        setTotal((value) => value + 1);
        setReplyTarget(null);
        onDelta?.(1);
        push('success', t('me.commentSent'));
        return true;
      } catch (err) {
        if (toApiError(err).status === 403) {
          push('error', t('me.commentErrFriendsOnly'));
          return false;
        }
        push('error', t('me.commentSendError'));
        return false;
      } finally {
        setSubmitting(false);
      }
    },
    [postId, submitting, onDelta, replyTarget, push, t]
  );

  const like = useCallback(
    async (commentId: string) => {
      if (pendingLikes.current.has(commentId)) return;
      const target = commentsRef.current.find((item) => item.id === commentId);
      if (target == null) return;
      pendingLikes.current.add(commentId);

      const self = selfLiker();
      const nextLiked = !target.liked;
      const currentLikers = target.topLikers ?? [];
      const nextLikers =
        self == null
          ? currentLikers
          : nextLiked
            ? [self, ...currentLikers.filter((liker) => liker.id !== self.id)].slice(0, 3)
            : currentLikers.filter((liker) => liker.id !== self.id);
      const optimistic: PostComment = {
        ...target,
        liked: nextLiked,
        likeCount: Math.max(0, target.likeCount + (target.liked ? -1 : 1)),
        topLikers: nextLikers,
      };
      setComments((current) =>
        current.map((item) => (item.id === commentId ? optimistic : item))
      );

      try {
        const updated = await MeService.likeComment(postId, commentId);
        setComments((current) =>
          current.map((item) =>
            item.id === commentId
              ? {
                  ...item,
                  liked: updated.liked,
                  likeCount: updated.likeCount,
                  topLikers: updated.topLikers ?? [],
                }
              : item
          )
        );
      } catch {
        setComments((current) =>
          current.map((item) => (item.id === commentId ? target : item))
        );
        push('error', t('me.commentLikeError'));
      } finally {
        pendingLikes.current.delete(commentId);
      }
    },
    [postId, push, t]
  );

  const remove = useCallback(
    async (commentId: string) => {
      const snapshot = commentsRef.current;
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
    [postId, onDelta, push, t]
  );

  return { comments, total, loading, error, submitting, add, remove, like, replyTarget, setReplyTarget };
}

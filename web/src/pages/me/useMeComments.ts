import { useCallback, useEffect, useRef, useState } from 'react';
import { MeService } from '@services';
import type { PostAuthor, PostComment } from '@app-types';
import { toApiError, toast } from '@lib';
import { useAuthStore } from '@/store/authStore';
import i18n from '@/i18n';

function selfLiker(): PostAuthor | null {
  const user = useAuthStore.getState().user;
  if (user == null) return null;
  return {
    id: user.id,
    username: user.username,
    fullName: user.fullName,
    avatar: user.avatar ?? undefined,
    isSelf: true,
  };
}

interface UseMeCommentsOptions {
  onDelta?: (delta: number) => void;
}

export function useMeComments(
  postId: string,
  options: UseMeCommentsOptions = {}
) {
  const { onDelta } = options;
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
          ? [
              self,
              ...currentLikers.filter((liker) => liker.id !== self.id),
            ].slice(0, 3)
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
      } catch (err) {
        console.error('like comment failed', err);
        setComments((current) =>
          current.map((item) => (item.id === commentId ? target : item))
        );
        toast.error(i18n.t('me.commentLikeError'));
      } finally {
        pendingLikes.current.delete(commentId);
      }
    },
    [postId]
  );

  const remove = useCallback(
    async (commentId: string) => {
      const snapshot = commentsRef.current;
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
    [postId, onDelta]
  );

  return {
    comments,
    total,
    loading,
    error,
    submitting,
    add,
    remove,
    like,
    replyTarget,
    setReplyTarget,
  };
}

import { useCallback, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { toApiError } from '@ola/shared/lib';
import { useStoryCommentStore } from '@ola/shared/stores/story/storyCommentStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { StoryComment } from '@ola/shared/types';
import { RATE_LIMITED_STATUS } from './constants';
import { commentUnlockMinChars, currentStoryAccess } from './useStoryAccess';

export function useStoryCommentActions(storyId: string) {
  const { t } = useTranslation();
  const push = useToastStore((state) => state.push);
  const sendComment = useStoryCommentStore((state) => state.send);
  const [sending, setSending] = useState(false);
  const sendingRef = useRef(false);

  const send = useCallback(
    async (content: string, parentId?: string): Promise<boolean> => {
      const text = content.trim();
      if (text === '' || sendingRef.current) return false;
      const neededUnlock = commentUnlockMinChars(currentStoryAccess(storyId)) != null;
      sendingRef.current = true;
      setSending(true);
      try {
        const result = await sendComment(storyId, text, parentId);
        if (result.unlocked && neededUnlock) push('success', t('story.commentUnlocked'));
        return true;
      } catch (error) {
        push(
          'error',
          toApiError(error).status === RATE_LIMITED_STATUS
            ? t('story.commentRateLimited')
            : t('story.commentSendError')
        );
        return false;
      } finally {
        sendingRef.current = false;
        setSending(false);
      }
    },
    [storyId, sendComment, push, t]
  );

  return { sending, send };
}

export function useStoryCommentListActions(threadId: string) {
  const { t } = useTranslation();
  const push = useToastStore((state) => state.push);
  const removeComment = useStoryCommentStore((state) => state.remove);
  const toggleCommentLike = useStoryCommentStore((state) => state.toggleLike);

  const remove = useCallback(
    async (comment: StoryComment) => {
      try {
        await removeComment(comment.storyId, comment.id);
        push('success', t('story.commentDeleted'));
      } catch {
        push('error', t('story.commentDeleteError'));
      }
    },
    [removeComment, push, t]
  );

  const toggleLike = useCallback(
    async (commentId: string) => {
      try {
        await toggleCommentLike(threadId, commentId);
      } catch {
        push('error', t('story.commentLikeError'));
      }
    },
    [threadId, toggleCommentLike, push, t]
  );

  return { remove, toggleLike };
}

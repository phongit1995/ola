import { useCallback, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { toApiError } from '@ola/shared/lib';
import { useStoryCommentStore } from '@ola/shared/stores/story/storyCommentStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { RATE_LIMITED_STATUS } from './constants';
import { commentUnlockMinChars, currentStoryAccess } from './storyAccess';

export function useStoryCommentActions(storyId: string) {
  const { t } = useTranslation();
  const push = useToastStore((state) => state.push);
  const sendComment = useStoryCommentStore((state) => state.send);
  const removeComment = useStoryCommentStore((state) => state.remove);
  const toggleCommentLike = useStoryCommentStore((state) => state.toggleLike);
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

  const remove = useCallback(
    async (commentId: string) => {
      try {
        await removeComment(storyId, commentId);
        push('success', t('story.commentDeleted'));
      } catch {
        push('error', t('story.commentDeleteError'));
      }
    },
    [storyId, removeComment, push, t]
  );

  const toggleLike = useCallback(
    async (commentId: string) => {
      try {
        await toggleCommentLike(storyId, commentId);
      } catch {
        push('error', t('story.commentLikeError'));
      }
    },
    [storyId, toggleCommentLike, push, t]
  );

  return { sending, send, remove, toggleLike };
}

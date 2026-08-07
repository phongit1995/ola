import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { MeService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { toApiError } from '@ola/shared/lib';
import type { Post } from '@ola/shared/types';

export function useQuickComment(
  posts: Post[],
  adjustCommentCount: (id: string, delta: number) => void
) {
  const { t } = useTranslation();
  const push = useToastStore(s => s.push);
  const [quickCommentPostId, setQuickCommentPostId] = useState<string | null>(null);
  const [quickSubmitting, setQuickSubmitting] = useState(false);

  const quickPost =
    quickCommentPostId != null ? posts.find(p => p.id === quickCommentPostId) ?? null : null;
  const quickContextLabel =
    quickPost == null
      ? undefined
      : quickPost.content != null && quickPost.content !== ''
        ? quickPost.content
        : quickPost.author?.username;

  async function submitQuickComment(text: string): Promise<boolean> {
    const id = quickCommentPostId;
    const content = text.trim();
    if (id == null || content === '') return false;
    setQuickSubmitting(true);
    try {
      await MeService.addComment(id, { content });
      adjustCommentCount(id, 1);
      push('success', t('me.commentSent'));
      setQuickCommentPostId(null);
      return true;
    } catch (err) {
      push(
        'error',
        toApiError(err).status === 403
          ? t('me.commentErrFriendsOnly')
          : t('me.commentSendError')
      );
      return false;
    } finally {
      setQuickSubmitting(false);
    }
  }

  return {
    quickCommentPostId,
    setQuickCommentPostId,
    quickSubmitting,
    submitQuickComment,
    quickContextLabel,
  };
}

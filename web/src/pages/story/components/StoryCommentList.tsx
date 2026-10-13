import { useCallback, useEffect, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { Spinner } from '@components';
import { createTimeFormatter, toast } from '@lib';
import { useStoryCommentStore } from '@ola/shared/stores/story/storyCommentStore';
import type { StoryComment } from '@app-types';
import type { ReaderPalette } from '../interface';
import { StoryCommentItem } from './StoryCommentItem';
import { StoryStateMessage } from './StoryStateMessage';

interface StoryCommentListProps {
  threadId: string;
  palette: ReaderPalette;
  emptyText: string;
  onReply: (comment: StoryComment) => void;
  onDeleted?: (commentId: string) => void;
  onOpenStory?: (storyId: string) => void;
}

export function StoryCommentList({
  threadId,
  palette,
  emptyText,
  onReply,
  onDeleted,
  onOpenStory,
}: StoryCommentListProps) {
  const { t, i18n } = useTranslation();
  const thread = useStoryCommentStore((state) => state.threads[threadId]);
  const load = useStoryCommentStore((state) => state.load);
  const loadMore = useStoryCommentStore((state) => state.loadMore);
  const items = thread?.items ?? [];
  const status = thread?.status ?? 'loading';
  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );

  useEffect(() => {
    void load(threadId);
  }, [threadId, load]);

  const toggleLike = useCallback(
    (commentId: string) => {
      useStoryCommentStore
        .getState()
        .toggleLike(threadId, commentId)
        .catch(() => toast.error(t('story.commentLikeError')));
    },
    [threadId, t]
  );

  const remove = useCallback(
    async (comment: StoryComment) => {
      try {
        await useStoryCommentStore
          .getState()
          .remove(comment.storyId, comment.id);
        onDeleted?.(comment.id);
        toast.success(t('story.commentDeleted'));
      } catch {
        toast.error(t('story.commentDeleteError'));
      }
    },
    [onDeleted, t]
  );

  if (items.length === 0 && status === 'error') {
    return (
      <StoryStateMessage
        kind="error"
        text={t('story.commentLoadError')}
        onRetry={() => void load(threadId)}
        style={{ color: palette.muted }}
      />
    );
  }
  if (items.length === 0 && status !== 'ready') {
    return (
      <div className="flex justify-center py-10">
        <Spinner tone="muted" />
      </div>
    );
  }
  if (items.length === 0) {
    return (
      <p
        className="px-6 py-10 text-center text-sm"
        style={{ color: palette.muted }}
      >
        {emptyText}
      </p>
    );
  }
  return (
    <>
      <ul>
        {items.map((comment) => (
          <StoryCommentItem
            key={comment.id}
            comment={comment}
            time={formatTime(comment.createdAt)}
            palette={palette}
            onReply={onReply}
            onToggleLike={toggleLike}
            onDelete={remove}
            onOpenStory={onOpenStory}
          />
        ))}
      </ul>
      {thread?.nextCursor != null && (
        <div className="flex justify-center py-3">
          <button
            type="button"
            disabled={thread.loadingMore}
            onClick={() => void loadMore(threadId)}
            className="flex h-9 min-w-36 items-center justify-center rounded-full border border-ola-primary px-4 text-sm text-ola-primary-ink disabled:opacity-60"
          >
            {thread.loadingMore ? (
              <Spinner size={18} />
            ) : (
              t('story.commentLoadMore')
            )}
          </button>
        </div>
      )}
    </>
  );
}

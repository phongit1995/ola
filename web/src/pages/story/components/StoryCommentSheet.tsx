import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Spinner } from '@components';
import { createTimeFormatter, formatCompactCount, toast } from '@lib';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useStoryCommentStore } from '@ola/shared/stores/story/storyCommentStore';
import type { StoryComment } from '@app-types';
import type { ReaderPalette } from '../interface';
import { ReaderSheet } from './ReaderSheet';
import { StoryCommentComposer } from './StoryCommentComposer';
import { StoryCommentItem } from './StoryCommentItem';
import { StoryStateMessage } from './StoryStateMessage';

interface StoryCommentSheetProps {
  storyId: string;
  palette: ReaderPalette;
  onClose: () => void;
}

export function StoryCommentSheet({
  storyId,
  palette,
  onClose,
}: StoryCommentSheetProps) {
  const { t, i18n } = useTranslation();
  const thread = useStoryCommentStore((state) => state.threads[storyId]);
  const load = useStoryCommentStore((state) => state.load);
  const loadMore = useStoryCommentStore((state) => state.loadMore);
  const commentCount = useStoryStore(
    (state) => state.stories[storyId]?.commentCount ?? 0
  );
  const [replyTarget, setReplyTarget] = useState<StoryComment | null>(null);
  const items = thread?.items ?? [];
  const status = thread?.status ?? 'loading';
  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );
  const title =
    commentCount > 0
      ? `${t('story.comments')} (${formatCompactCount(commentCount, i18n.language)})`
      : t('story.comments');

  useEffect(() => {
    void load(storyId);
  }, [storyId, load]);

  const toggleLike = useCallback(
    (commentId: string) => {
      useStoryCommentStore
        .getState()
        .toggleLike(storyId, commentId)
        .catch(() => toast.error(t('story.commentLikeError')));
    },
    [storyId, t]
  );

  const remove = useCallback(
    async (commentId: string) => {
      try {
        await useStoryCommentStore.getState().remove(storyId, commentId);
        setReplyTarget((target) => (target?.id === commentId ? null : target));
        toast.success(t('story.commentDeleted'));
      } catch {
        toast.error(t('story.commentDeleteError'));
      }
    },
    [storyId, t]
  );

  function renderList() {
    if (items.length === 0 && status === 'error') {
      return (
        <StoryStateMessage
          kind="error"
          text={t('story.commentLoadError')}
          onRetry={() => void load(storyId)}
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
          {t('story.commentEmpty')}
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
              onReply={setReplyTarget}
              onToggleLike={toggleLike}
              onDelete={remove}
            />
          ))}
        </ul>
        {thread?.nextCursor != null && (
          <div className="flex justify-center py-3">
            <button
              type="button"
              disabled={thread.loadingMore}
              onClick={() => void loadMore(storyId)}
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

  return (
    <ReaderSheet
      title={title}
      palette={palette}
      onClose={onClose}
      className="h-[85%]"
    >
      <div className="min-h-0 flex-1 overflow-y-auto font-sans">
        {renderList()}
      </div>
      <StoryCommentComposer
        storyId={storyId}
        palette={palette}
        replyTarget={replyTarget}
        onCancelReply={() => setReplyTarget(null)}
        onSent={() => setReplyTarget(null)}
      />
    </ReaderSheet>
  );
}

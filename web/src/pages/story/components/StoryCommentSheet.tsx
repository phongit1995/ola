import { useCallback, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { formatCompactCount } from '@lib';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import type { StoryComment } from '@app-types';
import type { ReaderPalette } from '../types';
import { ReaderSheet } from './ReaderSheet';
import { StoryCommentComposer } from './StoryCommentComposer';
import { StoryCommentList } from './StoryCommentList';

interface StoryCommentSheetProps {
  storyId: string;
  palette: ReaderPalette;
  initialReplyTarget?: StoryComment;
  onClose: () => void;
}

export function StoryCommentSheet({
  storyId,
  palette,
  initialReplyTarget,
  onClose,
}: StoryCommentSheetProps) {
  const { t, i18n } = useTranslation();
  const commentCount = useStoryStore(
    (state) => state.stories[storyId]?.commentCount ?? 0
  );
  const [replyTarget, setReplyTarget] = useState<StoryComment | null>(
    initialReplyTarget ?? null
  );
  const title =
    commentCount > 0
      ? `${t('story.comments')} (${formatCompactCount(commentCount, i18n.language)})`
      : t('story.comments');

  const clearDeletedReply = useCallback((commentId: string) => {
    setReplyTarget((target) => (target?.id === commentId ? null : target));
  }, []);

  return (
    <ReaderSheet
      title={title}
      palette={palette}
      onClose={onClose}
      className="h-[85%]"
    >
      <div className="min-h-0 flex-1 overflow-y-auto font-sans">
        <StoryCommentList
          threadId={storyId}
          palette={palette}
          emptyText={t('story.commentEmpty')}
          onReply={setReplyTarget}
          onDeleted={clearDeletedReply}
        />
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

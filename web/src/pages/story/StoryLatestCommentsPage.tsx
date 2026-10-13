import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader } from '@components';
import { STORY_LATEST_COMMENTS_THREAD } from '@constants';
import type { StoryComment } from '@app-types';
import { READER_PALETTES, STORY_SCREEN_CLASS } from './constants';
import { StoryCommentList } from './components/StoryCommentList';
import { StoryCommentSheet } from './components/StoryCommentSheet';

interface StoryLatestCommentsPageProps {
  onBack: () => void;
  onOpenStory: (storyId: string) => void;
}

export function StoryLatestCommentsPage({
  onBack,
  onOpenStory,
}: StoryLatestCommentsPageProps) {
  const { t } = useTranslation();
  const [replyTarget, setReplyTarget] = useState<StoryComment | null>(null);

  return (
    <FullScreenOverlay position="absolute" className={STORY_SCREEN_CLASS}>
      <ScreenHeader title={t('story.latestComments')} onBack={onBack} />
      <main className="flex-1 overflow-y-auto bg-white">
        <StoryCommentList
          threadId={STORY_LATEST_COMMENTS_THREAD}
          palette={READER_PALETTES.light}
          emptyText={t('story.latestCommentsEmpty')}
          onReply={setReplyTarget}
          onOpenStory={onOpenStory}
        />
      </main>
      {replyTarget && (
        <StoryCommentSheet
          storyId={replyTarget.storyId}
          palette={READER_PALETTES.light}
          initialReplyTarget={replyTarget}
          onClose={() => setReplyTarget(null)}
        />
      )}
    </FullScreenOverlay>
  );
}

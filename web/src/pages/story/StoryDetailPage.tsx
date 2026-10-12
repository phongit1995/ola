import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader } from '@components';
import { cn, splitStoryParagraphs } from '@lib';
import { STORY_KIND } from '@constants';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useStoryPrefsStore } from '@ola/shared/stores/story/storyPrefsStore';
import { READER_PALETTES } from './constants';
import { StoryChapterList } from './components/StoryChapterList';
import { StoryCommentSheet } from './components/StoryCommentSheet';
import { StoryDetailHeading } from './components/StoryDetailHeading';
import { StoryDetailHero } from './components/StoryDetailHero';
import { StoryDetailSkeleton } from './components/StoryDetailSkeleton';
import { StoryFreeReadsBadge } from './components/StoryFreeReadsBadge';
import { StoryIcon } from './components/StoryIcons';
import { StoryStateMessage } from './components/StoryStateMessage';

const SCREEN_CLASS =
  'animate-ola-screen-in bg-ola-surface motion-reduce:animate-none';

interface StoryDetailPageProps {
  storyId: string;
  onBack: () => void;
  onRead: (position: number) => void;
}

export function StoryDetailPage({
  storyId,
  onBack,
  onRead,
}: StoryDetailPageProps) {
  const { t } = useTranslation();
  const story = useStoryStore((state) => state.stories[storyId]);
  const status = useStoryStore((state) => state.storyStatus[storyId]);
  const chapters = useStoryStore((state) => state.chapters[storyId]);
  const loadStory = useStoryStore((state) => state.loadStory);
  const storyAccess = useStoryStore((state) => state.storyAccess[storyId]);
  const progress = useStoryPrefsStore((state) => state.progress[storyId]);
  const [introExpanded, setIntroExpanded] = useState(false);
  const [commentsOpen, setCommentsOpen] = useState(false);

  useEffect(() => {
    void loadStory(storyId);
  }, [storyId, loadStory]);

  if (!story) {
    return (
      <FullScreenOverlay position="absolute" className={SCREEN_CLASS}>
        <ScreenHeader title="" onBack={onBack} />
        {status === 'error' ? (
          <div className="flex flex-1 flex-col items-center justify-center">
            <StoryStateMessage
              kind="error"
              text={t('story.loadError')}
              onRetry={() => void loadStory(storyId)}
            />
          </div>
        ) : (
          <StoryDetailSkeleton />
        )}
      </FullScreenOverlay>
    );
  }

  const isShort = story.kind === STORY_KIND.short;
  const introParagraphs = splitStoryParagraphs(story.intro);
  const access = storyAccess ?? story.access;
  const showFreeReads = access?.enabled && !access.vip && !access.unlocked;
  const readingProgress = isShort ? undefined : progress;
  const readPosition = readingProgress?.position ?? null;

  return (
    <FullScreenOverlay position="absolute" className={SCREEN_CLASS}>
      <ScreenHeader title={story.title} onBack={onBack}>
        {showFreeReads && <StoryFreeReadsBadge access={access} />}
      </ScreenHeader>
      <main className="flex-1 overflow-y-auto">
        <StoryDetailHero
          story={story}
          isShort={isShort}
          readLabel={
            readPosition != null
              ? t('story.readContinue', { position: readPosition })
              : t(isShort ? 'story.readShort' : 'story.readFromStart')
          }
          progress={readingProgress}
          onRead={() => onRead(readPosition ?? 1)}
          onComments={() => setCommentsOpen(true)}
        />

        <section className="mt-2 bg-white px-4 py-3">
          <StoryDetailHeading>{t('story.intro')}</StoryDetailHeading>
          <div
            className={cn(
              'relative mt-2',
              !introExpanded && 'max-h-26 overflow-hidden'
            )}
          >
            <div className="space-y-2 text-sm leading-6.5 text-black/70">
              {introParagraphs.map((paragraph, index) => (
                <p key={index}>{paragraph}</p>
              ))}
            </div>
            {!introExpanded && (
              <span
                aria-hidden="true"
                className="pointer-events-none absolute inset-x-0 bottom-0 h-10 bg-linear-to-t from-white via-white/70 to-transparent"
              />
            )}
          </div>
          <button
            type="button"
            aria-expanded={introExpanded}
            onClick={() => setIntroExpanded((value) => !value)}
            className="mt-1 flex items-center text-sm font-medium text-ola-primary-dark"
          >
            {t(introExpanded ? 'story.showLess' : 'story.showMore')}
            <StoryIcon
              name="arrowDropDown"
              className={cn(
                'h-5 w-5 transition-transform duration-200 motion-reduce:transition-none',
                introExpanded && 'rotate-180'
              )}
            />
          </button>
        </section>

        {!isShort && (
          <StoryChapterList
            chapters={chapters}
            chapterCount={story.chapterCount}
            readPosition={readPosition}
            failed={status === 'error'}
            onRetry={() => void loadStory(storyId)}
            onOpen={onRead}
          />
        )}
      </main>
      {commentsOpen && (
        <StoryCommentSheet
          storyId={storyId}
          palette={READER_PALETTES.light}
          onClose={() => setCommentsOpen(false)}
        />
      )}
    </FullScreenOverlay>
  );
}

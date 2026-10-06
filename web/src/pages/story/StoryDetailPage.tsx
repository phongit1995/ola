import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader, Spinner } from '@components';
import {
  cn,
  formatCompactCount,
  formatDateSlashDMY,
  splitStoryParagraphs,
} from '@lib';
import { STORY_KIND } from '@constants';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useStoryPrefsStore } from '@ola/shared/stores/story/storyPrefsStore';
import type { StoryChapterItem } from '@app-types';
import { StoryCover } from './components/StoryCover';
import { SortIcon } from './components/StoryIcons';
import { StoryStatusBadge, StoryTag } from './components/StoryTags';

const INTRO_PREVIEW_LINES = 'line-clamp-4';

interface StatProps {
  label: string;
  value: string;
}

function Stat({ label, value }: StatProps) {
  return (
    <div className="flex flex-col items-center gap-0.5">
      <span className="text-base font-bold text-black/87">{value}</span>
      <span className="text-[11px] text-black/54">{label}</span>
    </div>
  );
}

interface ChapterRowProps {
  chapter: StoryChapterItem;
  current: boolean;
  onOpen: (position: number) => void;
}

function ChapterRow({ chapter, current, onOpen }: ChapterRowProps) {
  const { t } = useTranslation();
  return (
    <li>
      <button
        type="button"
        onClick={() => onOpen(chapter.position)}
        className="flex w-full items-center gap-2 px-4 py-3 text-left active:bg-black/5"
      >
        <span
          className={cn(
            'min-w-0 flex-1 truncate text-sm',
            current ? 'font-semibold text-ola-primary-ink' : 'text-black/80'
          )}
        >
          {chapter.title}
        </span>
        {chapter.isNew && (
          <span className="shrink-0 rounded bg-ola-accent px-1 text-[10px] leading-4 font-bold text-white uppercase">
            {t('story.newBadge')}
          </span>
        )}
        {current && (
          <span className="shrink-0 text-[11px] text-ola-primary-ink">
            {t('story.reading')}
          </span>
        )}
        <span className="shrink-0 text-xs text-black/40">
          {formatDateSlashDMY(chapter.publishedAt ?? '')}
        </span>
      </button>
    </li>
  );
}

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
  const { t, i18n } = useTranslation();
  const story = useStoryStore((state) => state.stories[storyId]);
  const status = useStoryStore((state) => state.storyStatus[storyId]);
  const chapters = useStoryStore((state) => state.chapters[storyId]);
  const loadStory = useStoryStore((state) => state.loadStory);
  const progress = useStoryPrefsStore((state) => state.progress[storyId]);
  const [introExpanded, setIntroExpanded] = useState(false);
  const [newestFirst, setNewestFirst] = useState(false);

  useEffect(() => {
    void loadStory(storyId);
  }, [storyId, loadStory]);

  const orderedChapters = useMemo(
    () => (newestFirst ? [...(chapters ?? [])].reverse() : (chapters ?? [])),
    [chapters, newestFirst]
  );

  if (!story) {
    return (
      <FullScreenOverlay position="absolute" className="bg-ola-surface">
        <ScreenHeader title="" onBack={onBack} />
        <div className="flex flex-1 flex-col items-center justify-center gap-3 text-sm text-black/54">
          {status === 'error' ? (
            <>
              {t('story.loadError')}
              <button
                type="button"
                onClick={() => void loadStory(storyId)}
                className="rounded-full bg-ola-button px-4 py-1.5 text-ola-on-primary"
              >
                {t('story.retry')}
              </button>
            </>
          ) : (
            <Spinner />
          )}
        </div>
      </FullScreenOverlay>
    );
  }

  const isShort = story.kind === STORY_KIND.short;
  const introParagraphs = splitStoryParagraphs(story.intro);
  const locale = i18n.language;

  return (
    <FullScreenOverlay position="absolute" className="bg-ola-surface">
      <ScreenHeader title={story.title} onBack={onBack} />
      <main className="flex-1 overflow-y-auto">
        <section className="bg-white px-4 pt-4 pb-3">
          <div className="flex gap-4">
            <StoryCover
              title={story.title}
              coverUrl={story.coverUrl}
              size="lg"
              className="w-28 shrink-0"
            />
            <div className="flex min-w-0 flex-1 flex-col">
              <h1 className="text-lg leading-6 font-bold text-black/87">
                {story.title}
              </h1>
              <div className="mt-2 flex flex-wrap gap-1">
                <StoryStatusBadge status={story.status} />
                {isShort && <StoryTag>{t('story.kindShort')}</StoryTag>}
              </div>
              <div className="mt-2 flex flex-wrap gap-1">
                {story.genres.map((genre) => (
                  <StoryTag key={genre}>{genre}</StoryTag>
                ))}
              </div>
            </div>
          </div>
          <div className="mt-4 grid grid-cols-4 rounded-lg bg-ola-surface py-2">
            <Stat
              label={t('story.statChapters')}
              value={story.chapterCount.toLocaleString(locale)}
            />
            <Stat
              label={t('story.statViews')}
              value={formatCompactCount(story.viewCount, locale)}
            />
            <Stat
              label={t('story.statWords')}
              value={formatCompactCount(story.wordCount, locale)}
            />
            <Stat
              label={t('story.statComments')}
              value={formatCompactCount(story.commentCount, locale)}
            />
          </div>
          <div className="mt-4 flex gap-2">
            {progress && !isShort ? (
              <>
                <button
                  type="button"
                  onClick={() => onRead(progress.position)}
                  className="h-10 flex-1 rounded-full bg-ola-button text-sm font-semibold text-ola-on-primary active:opacity-90"
                >
                  {t('story.readContinue', { position: progress.position })}
                </button>
                <button
                  type="button"
                  onClick={() => onRead(1)}
                  className="h-10 rounded-full border border-ola-primary px-4 text-sm text-ola-primary-ink active:bg-ola-primary/10"
                >
                  {t('story.readFromStart')}
                </button>
              </>
            ) : (
              <button
                type="button"
                onClick={() => onRead(1)}
                className="h-10 flex-1 rounded-full bg-ola-button text-sm font-semibold text-ola-on-primary active:opacity-90"
              >
                {t(isShort ? 'story.readShort' : 'story.readFromStart')}
              </button>
            )}
          </div>
        </section>

        <section className="mt-2 bg-white px-4 py-3">
          <h2 className="text-[15px] font-bold text-black/87">
            {t('story.intro')}
          </h2>
          <div
            className={cn(
              'mt-2 space-y-2 text-sm leading-6 text-black/75',
              !introExpanded && INTRO_PREVIEW_LINES
            )}
          >
            {introParagraphs.map((paragraph, index) => (
              <p key={index}>{paragraph}</p>
            ))}
          </div>
          <button
            type="button"
            onClick={() => setIntroExpanded((value) => !value)}
            className="mt-1 text-sm text-ola-primary-ink"
          >
            {t(introExpanded ? 'story.showLess' : 'story.showMore')}
          </button>
          {story.sourceUrl && (
            <a
              href={story.sourceUrl}
              target="_blank"
              rel="noreferrer"
              className="mt-2 block text-xs text-black/45 underline"
            >
              {t('story.sourceFrom', {
                host: new URL(story.sourceUrl).hostname,
              })}
            </a>
          )}
        </section>

        {!isShort && (
          <section className="mt-2 bg-white pb-4">
            <div className="flex items-center justify-between px-4 pt-3 pb-1">
              <h2 className="text-[15px] font-bold text-black/87">
                {t('story.chapterList')}
                <span className="ml-1 font-normal text-black/54">
                  ({story.chapterCount})
                </span>
              </h2>
              <button
                type="button"
                onClick={() => setNewestFirst((value) => !value)}
                className="flex items-center gap-1 text-[13px] text-black/60"
              >
                <SortIcon className="h-4 w-4" />
                {t(newestFirst ? 'story.orderNewest' : 'story.orderOldest')}
              </button>
            </div>
            {chapters ? (
              <ul className="divide-y divide-black/6">
                {orderedChapters.map((chapter) => (
                  <ChapterRow
                    key={chapter.id}
                    chapter={chapter}
                    current={progress?.position === chapter.position}
                    onOpen={onRead}
                  />
                ))}
              </ul>
            ) : (
              <div className="flex justify-center py-6">
                <Spinner />
              </div>
            )}
          </section>
        )}
      </main>
    </FullScreenOverlay>
  );
}

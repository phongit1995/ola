import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { useHorizontalDragScroll } from '../useHorizontalDragScroll';
import { cn, formatCompactCount, storyReadPercent } from '@lib';
import type { Story, StoryProgress } from '@app-types';
import { STORY_SECTION_ART, type StorySectionArt } from '../constants';
import { StoryCover } from './StoryCover';
import { StoryIcon } from './StoryIcons';
import { StoryMeta } from './StoryTags';

const PODIUM_SIZE = 3;

interface StorySectionTitleProps {
  art: StorySectionArt;
  children: ReactNode;
}

export function StorySectionTitle({ art, children }: StorySectionTitleProps) {
  return (
    <h2 className="flex items-center gap-2 text-[15px] font-bold text-black/87">
      <img
        src={STORY_SECTION_ART[art]}
        alt=""
        className="h-7 w-7 shrink-0 select-none"
        draggable={false}
      />
      {children}
    </h2>
  );
}

interface StoryShelfProps {
  title: string;
  art: StorySectionArt;
  action?: ReactNode;
  children: ReactNode;
}

export function StoryShelf({ title, art, action, children }: StoryShelfProps) {
  const scrollRef = useHorizontalDragScroll();

  return (
    <section className="bg-white py-3">
      <div className="flex items-center gap-2 px-3">
        <div className="min-w-0 flex-1">
          <StorySectionTitle art={art}>{title}</StorySectionTitle>
        </div>
        {action}
      </div>
      <ul
        ref={scrollRef}
        className="mt-2 flex gap-3 overflow-x-auto px-3 pb-1 select-none [scrollbar-width:none]"
      >
        {children}
      </ul>
    </section>
  );
}

interface TopStoryCardProps {
  story: Story;
  rank: number;
  onOpen: (storyId: string) => void;
}

export function TopStoryCard({ story, rank, onOpen }: TopStoryCardProps) {
  const { i18n } = useTranslation();
  return (
    <li className="w-[104px] shrink-0">
      <button
        type="button"
        onClick={() => onOpen(story.id)}
        className="w-full text-left active:opacity-80"
      >
        <StoryCover title={story.title} coverUrl={story.coverUrl}>
          <span
            className={cn(
              'absolute top-0 left-0 rounded-br-md px-1.5 py-0.5 text-xs font-bold text-white',
              rank <= PODIUM_SIZE ? 'bg-ola-accent' : 'bg-black/55'
            )}
          >
            {rank}
          </span>
        </StoryCover>
        <span className="mt-1.5 line-clamp-2 text-[13px] leading-4 font-medium text-black/87">
          {story.title}
        </span>
        <StoryMeta
          icon="visibility"
          className="mt-0.5 text-[11px] text-black/54"
        >
          {formatCompactCount(story.viewCount, i18n.language)}
        </StoryMeta>
      </button>
    </li>
  );
}

interface ContinueCardProps {
  progress: StoryProgress;
  onOpen: (progress: StoryProgress) => void;
  onRemove: (storyId: string) => void;
}

export function ContinueCard({ progress, onOpen, onRemove }: ContinueCardProps) {
  const { t } = useTranslation();
  const percent = storyReadPercent(progress.position, progress.chapterCount);
  return (
    <li className="relative w-[104px] shrink-0">
      <button
        type="button"
        onClick={() => onOpen(progress)}
        className="w-full text-left active:opacity-80"
      >
        <StoryCover title={progress.storyTitle} coverUrl={progress.coverUrl}>
          <span className="absolute inset-x-0 bottom-0 h-1 bg-black/30">
            <span
              className="block h-full bg-ola-primary"
              style={{ width: `${percent}%` }}
            />
          </span>
        </StoryCover>
        <span className="mt-1.5 line-clamp-2 text-[13px] leading-4 font-medium text-black/87">
          {progress.storyTitle}
        </span>
        <StoryMeta
          icon="bookmark"
          className="mt-0.5 text-[11px] text-black/54"
          iconClassName="h-3.5 w-3.5 text-black/70"
        >
          {t('story.chapterProgress', {
            position: progress.position,
            count: progress.chapterCount,
          })}
        </StoryMeta>
      </button>
      <button
        type="button"
        aria-label={t('story.removeRecent')}
        title={t('story.removeRecent')}
        onClick={() => onRemove(progress.storyId)}
        className="absolute top-1 right-1 flex h-6 w-6 items-center justify-center rounded-full bg-black/55 text-white hover:bg-black/70 active:bg-black/80"
      >
        <StoryIcon name="close" className="h-3.5 w-3.5" />
      </button>
    </li>
  );
}

import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { cn, formatCompactCount } from '@lib';
import type { Story, StoryProgress } from '@app-types';
import { StoryCover } from './StoryCover';
import { EyeIcon } from './StoryIcons';

const PODIUM_SIZE = 3;

interface StoryShelfProps {
  title: string;
  children: ReactNode;
}

export function StoryShelf({ title, children }: StoryShelfProps) {
  return (
    <section className="bg-white py-3">
      <h2 className="px-3 text-[15px] font-bold text-black/87">{title}</h2>
      <ul className="mt-2 flex gap-3 overflow-x-auto px-3 pb-1 [scrollbar-width:none]">
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
        <span className="mt-0.5 inline-flex items-center gap-0.5 text-[11px] text-black/54">
          <EyeIcon className="h-3 w-3" />
          {formatCompactCount(story.viewCount, i18n.language)}
        </span>
      </button>
    </li>
  );
}

interface ContinueCardProps {
  progress: StoryProgress;
  onOpen: (progress: StoryProgress) => void;
}

export function ContinueCard({ progress, onOpen }: ContinueCardProps) {
  const { t } = useTranslation();
  const percent = Math.round(
    (progress.position / Math.max(progress.chapterCount, 1)) * 100
  );
  return (
    <li className="w-[104px] shrink-0">
      <button
        type="button"
        onClick={() => onOpen(progress)}
        className="w-full text-left active:opacity-80"
      >
        <StoryCover title={progress.storyTitle}>
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
        <span className="mt-0.5 block text-[11px] text-black/54">
          {t('story.chapterProgress', {
            position: progress.position,
            count: progress.chapterCount,
          })}
        </span>
      </button>
    </li>
  );
}

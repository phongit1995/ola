import { useTranslation } from 'react-i18next';
import { formatCompactCount, formatDateSlashDMY } from '@lib';
import { STORY_KIND } from '@constants';
import type { Story } from '@app-types';
import { StoryCover } from './StoryCover';
import { StoryMeta, StoryStatusBadge, StoryTag } from './StoryTags';

const ROW_GENRE_LIMIT = 2;

interface StoryRowProps {
  story: Story;
  onOpen: (storyId: string) => void;
}

export function StoryRow({ story, onOpen }: StoryRowProps) {
  const { t, i18n } = useTranslation();
  const isShort = story.kind === STORY_KIND.short;

  return (
    <li>
      <button
        type="button"
        onClick={() => onOpen(story.id)}
        className="flex w-full gap-3 px-3 py-3 text-left active:bg-black/5"
      >
        <StoryCover
          title={story.title}
          coverUrl={story.coverUrl}
          size="sm"
          className="w-16 shrink-0"
        />
        <span className="flex min-w-0 flex-1 flex-col">
          <span className="line-clamp-2 text-[15px] leading-5 font-semibold text-black/87">
            {story.title}
          </span>
          <span className="mt-1.5 flex flex-wrap items-center gap-1">
            <StoryStatusBadge status={story.status} />
            {story.genres.slice(0, ROW_GENRE_LIMIT).map((genre) => (
              <StoryTag key={genre}>{genre}</StoryTag>
            ))}
          </span>
          <span className="mt-1.5 flex items-center gap-3 text-xs text-black/54">
            <StoryMeta icon={isShort ? 'article' : 'menuBook'}>
              {isShort
                ? t('story.kindShort')
                : t('story.chapterCount', { count: story.chapterCount })}
            </StoryMeta>
            <StoryMeta icon="visibility">
              {formatCompactCount(story.viewCount, i18n.language)}
            </StoryMeta>
            <StoryMeta icon="schedule" className="ml-auto shrink-0">
              {formatDateSlashDMY(story.lastChapterAt ?? story.updatedAt)}
            </StoryMeta>
          </span>
        </span>
      </button>
    </li>
  );
}

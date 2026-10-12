import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { cn, formatDateSlashDMY } from '@lib';
import type { StoryChapterItem } from '@app-types';
import { StoryDetailHeading } from './StoryDetailHeading';
import { StoryIcon } from './StoryIcons';
import { StoryStateMessage } from './StoryStateMessage';

const SKELETON_ROWS = [72, 58, 66, 80, 61, 70];

interface ChapterRowProps {
  chapter: StoryChapterItem;
  readPosition: number | null;
  onOpen: (position: number) => void;
}

function ChapterRow({ chapter, readPosition, onOpen }: ChapterRowProps) {
  const { t } = useTranslation();
  const current = readPosition === chapter.position;
  const read = readPosition != null && chapter.position < readPosition;
  return (
    <li>
      <button
        type="button"
        aria-current={current ? 'true' : undefined}
        onClick={() => onOpen(chapter.position)}
        className={cn(
          'flex w-full items-center gap-2 border-l-[3px] py-3 pr-4 pl-3.25 text-left transition-colors duration-150 motion-reduce:transition-none',
          current
            ? 'border-ola-primary bg-ola-primary-light'
            : 'border-transparent hover:bg-black/3 active:bg-black/5'
        )}
      >
        <span
          className={cn(
            'min-w-0 flex-1 truncate text-sm',
            current
              ? 'font-semibold text-ola-primary-dark'
              : read
                ? 'text-violet-600'
                : 'text-black/80'
          )}
        >
          {chapter.title}
        </span>
        {chapter.isNew && (
          <span className="shrink-0 rounded-full bg-ola-accent px-1.5 text-[10px] leading-4 font-bold text-white uppercase">
            {t('story.newBadge')}
          </span>
        )}
        {current && (
          <span className="flex shrink-0 items-center gap-0.5 rounded-full bg-ola-primary/15 px-2 py-0.5 text-[11px] font-medium text-ola-primary-dark">
            <StoryIcon name="bookmark" className="h-3 w-3" />
            {t('story.reading')}
          </span>
        )}
        <span
          className={cn(
            'shrink-0 text-xs tabular-nums',
            read ? 'text-violet-400' : 'text-black/40'
          )}
        >
          {formatDateSlashDMY(chapter.publishedAt ?? '')}
        </span>
      </button>
    </li>
  );
}

interface StoryChapterListProps {
  chapters?: StoryChapterItem[];
  chapterCount: number;
  readPosition: number | null;
  failed: boolean;
  onRetry: () => void;
  onOpen: (position: number) => void;
}

export function StoryChapterList({
  chapters,
  chapterCount,
  readPosition,
  failed,
  onRetry,
  onOpen,
}: StoryChapterListProps) {
  const { t, i18n } = useTranslation();
  const [newestFirst, setNewestFirst] = useState(false);
  const ordered = useMemo(
    () => (newestFirst ? [...(chapters ?? [])].reverse() : (chapters ?? [])),
    [chapters, newestFirst]
  );

  function renderBody() {
    if (chapters) {
      return (
        <ul
          key={String(newestFirst)}
          className="animate-ola-fade-in divide-y divide-black/6 motion-reduce:animate-none"
        >
          {ordered.map((chapter) => (
            <ChapterRow
              key={chapter.id}
              chapter={chapter}
              readPosition={readPosition}
              onOpen={onOpen}
            />
          ))}
        </ul>
      );
    }
    if (failed) {
      return (
        <StoryStateMessage
          kind="error"
          text={t('story.loadError')}
          onRetry={onRetry}
          className="py-6"
        />
      );
    }
    return (
      <ul
        aria-busy="true"
        className="animate-pulse divide-y divide-black/6 motion-reduce:animate-none"
      >
        {SKELETON_ROWS.map((width, index) => (
          <li key={index} className="flex items-center gap-3 px-4 py-3.5">
            <span
              className="h-3.5 rounded bg-black/8"
              style={{ width: `${width}%` }}
            />
            <span className="ml-auto h-3 w-16 rounded bg-black/6" />
          </li>
        ))}
      </ul>
    );
  }

  return (
    <section className="mt-2 bg-white pb-2">
      <div className="flex items-center justify-between gap-2 px-4 pt-3 pb-2">
        <StoryDetailHeading>
          {t('story.chapterList')}
          <span className="font-normal text-black/40 tabular-nums">
            ({chapterCount.toLocaleString(i18n.language)})
          </span>
        </StoryDetailHeading>
        <div className="flex shrink-0 rounded-full bg-black/5 p-0.5 text-xs">
          {[false, true].map((newest) => {
            const active = newestFirst === newest;
            return (
              <button
                key={String(newest)}
                type="button"
                aria-pressed={active}
                onClick={() => setNewestFirst(newest)}
                className={cn(
                  'rounded-full px-2.5 py-1 transition-[background-color,color,box-shadow] duration-200 motion-reduce:transition-none',
                  active
                    ? 'bg-white font-semibold text-black/87 shadow-sm'
                    : 'text-black/50 hover:text-black/70'
                )}
              >
                {t(newest ? 'story.orderNewest' : 'story.orderOldest')}
              </button>
            );
          })}
        </div>
      </div>
      {renderBody()}
    </section>
  );
}

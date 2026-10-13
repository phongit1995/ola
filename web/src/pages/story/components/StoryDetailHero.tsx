import { useTranslation } from 'react-i18next';
import { formatCompactCount, formatDateSlashDMY, storyReadPercent } from '@lib';
import type { Story, StoryIconName, StoryProgress } from '@app-types';
import { StoryCover } from './StoryCover';
import { StoryIcon } from './StoryIcons';
import { StoryMeta, StoryStatusBadge, StoryTag } from './StoryTags';

const RISE_CLASS = 'animate-ola-rise-in motion-reduce:animate-none';

interface StatProps {
  icon: StoryIconName;
  label: string;
  value: string;
}

function Stat({ icon, label, value }: StatProps) {
  return (
    <div className="flex flex-col items-center gap-0.5">
      <span className="flex items-center gap-1 text-base font-bold text-black/87 tabular-nums">
        <StoryIcon
          name={icon}
          className="h-4 w-4 shrink-0 text-ola-primary-dark"
        />
        {value}
      </span>
      <span className="text-[11px] text-black/50">{label}</span>
    </div>
  );
}

interface StoryDetailHeroProps {
  story: Story;
  isShort: boolean;
  readLabel: string;
  progress?: StoryProgress;
  onRead: () => void;
  onComments: () => void;
}

export function StoryDetailHero({
  story,
  isShort,
  readLabel,
  progress,
  onRead,
  onComments,
}: StoryDetailHeroProps) {
  const { t, i18n } = useTranslation();
  const locale = i18n.language;
  const percent = progress
    ? storyReadPercent(progress.position, story.chapterCount)
    : null;

  return (
    <section className="relative overflow-hidden bg-white px-4 pt-4 pb-4">
      <span
        aria-hidden="true"
        className="absolute inset-x-0 top-0 h-28 bg-linear-to-b from-ola-primary-light to-transparent"
      />
      <div className="relative flex gap-4">
        <StoryCover
          title={story.title}
          coverUrl={story.coverUrl}
          size="lg"
          className={`w-28 shrink-0 rounded-lg shadow-[0_8px_20px_-6px_rgba(0,0,0,.4)] ring-1 ring-black/5 ${RISE_CLASS}`}
        />
        <div
          className={`flex min-w-0 flex-1 flex-col [animation-delay:60ms] ${RISE_CLASS}`}
        >
          <h1 className="line-clamp-3 font-reader-serif text-xl leading-7 font-bold text-black/87">
            {story.title}
          </h1>
          <div className="mt-2 flex flex-wrap gap-1">
            <StoryStatusBadge status={story.status} />
            {isShort && <StoryTag>{t('story.kindShort')}</StoryTag>}
            {story.genres.map((genre) => (
              <StoryTag key={genre}>{genre}</StoryTag>
            ))}
          </div>
          <StoryMeta
            icon="schedule"
            className="mt-auto pt-2 text-xs text-black/54 tabular-nums"
            iconClassName="h-3.5 w-3.5 text-black/40"
          >
            {formatDateSlashDMY(story.lastChapterAt ?? story.updatedAt)}
          </StoryMeta>
        </div>
      </div>
      <div
        className={`relative mt-4 grid grid-cols-3 divide-x divide-black/6 rounded-xl bg-white py-2.5 shadow-[0_1px_4px_rgba(0,0,0,.06)] ring-1 ring-black/5 [animation-delay:120ms] ${RISE_CLASS}`}
      >
        <Stat
          icon="menuBook"
          label={t('story.statChapters')}
          value={story.chapterCount.toLocaleString(locale)}
        />
        <Stat
          icon="visibility"
          label={t('story.statViews')}
          value={formatCompactCount(story.viewCount, locale)}
        />
        <Stat
          icon="article"
          label={t('story.statWords')}
          value={formatCompactCount(story.wordCount, locale)}
        />
      </div>
      <div className="relative mt-4 flex gap-2">
        <button
          type="button"
          onClick={onRead}
          className="flex h-11 min-w-0 flex-1 items-center justify-center gap-1.5 rounded-full bg-linear-to-r from-ola-primary to-ola-primary-dark px-4 text-sm font-semibold text-ola-on-primary shadow-[0_4px_12px_-4px_rgba(85,139,47,.6)] transition-[transform,box-shadow] duration-150 hover:shadow-[0_6px_16px_-4px_rgba(85,139,47,.7)] active:scale-[.98] motion-reduce:transition-none"
        >
          <StoryIcon name="menuBook" className="h-5 w-5 shrink-0" />
          <span className="truncate">{readLabel}</span>
        </button>
        <button
          type="button"
          aria-label={t('story.comments')}
          onClick={onComments}
          className="flex h-11 shrink-0 items-center gap-1.5 rounded-full border border-ola-primary/60 px-4 text-sm font-semibold text-ola-primary-dark tabular-nums transition-[background-color,transform] duration-150 hover:bg-ola-primary/5 active:scale-95 motion-reduce:transition-none"
        >
          <StoryIcon name="chatBubble" className="h-4 w-4" />
          {formatCompactCount(story.commentCount, locale)}
        </button>
      </div>
      {percent != null && (
        <div className="relative mt-3 flex items-center gap-2 text-[11px] text-black/50">
          <span className="h-1 flex-1 overflow-hidden rounded-full bg-black/6">
            <span
              className="block h-full origin-left animate-ola-grow-x rounded-full bg-ola-primary motion-reduce:animate-none"
              style={{ transform: `scaleX(${percent / 100})` }}
            />
          </span>
          <span className="shrink-0 tabular-nums">
            {t('story.readPercent', { percent })}
          </span>
        </div>
      )}
    </section>
  );
}

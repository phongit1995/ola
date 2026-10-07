import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { HomeHeader } from '@components/HomeHeader';
import { Placeholder } from '@components/Placeholder';
import { SearchIcon, Spinner } from '@components';
import { cn } from '@lib';
import { useHorizontalDragScroll } from '@hooks';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useStoryPrefsStore } from '@ola/shared/stores/story/storyPrefsStore';
import type { StoryProgress, StoryStatusFilter } from '@app-types';
import { useStoryOverlayStore } from '@/store/storyOverlayStore';
import {
  SEARCH_DEBOUNCE_MS,
  SORT_OPTIONS,
  STATUS_FILTER_OPTIONS,
} from './constants';
import {
  ContinueCard,
  StoryShelf,
  TopStoryCard,
} from './components/StoryCards';
import { StoryRow } from './components/StoryRow';

interface ChipProps {
  active: boolean;
  onClick: () => void;
  children: string;
}

function Chip({ active, onClick, children }: ChipProps) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        'shrink-0 rounded-full border px-3 py-1 text-[13px] whitespace-nowrap',
        active
          ? 'border-ola-primary bg-ola-primary text-ola-on-primary'
          : 'border-ola-border-strong bg-white text-black/70 active:bg-black/5'
      )}
    >
      {children}
    </button>
  );
}

export function StoryPanel() {
  const { t } = useTranslation();
  const genresRef = useHorizontalDragScroll();
  const genres = useStoryStore((state) => state.genres);
  const topViewed = useStoryStore((state) => state.topViewed);
  const list = useStoryStore((state) => state.list);
  const loadHome = useStoryStore((state) => state.loadHome);
  const setFilter = useStoryStore((state) => state.setFilter);
  const loadMore = useStoryStore((state) => state.loadMore);
  const progress = useStoryPrefsStore((state) => state.progress);
  const openStory = useStoryOverlayStore((state) => state.openStory);
  const openReader = useStoryOverlayStore((state) => state.openReader);
  const [query, setQuery] = useState(list.filter.q);
  const { filter } = list;
  const searching = filter.q !== '';
  const firstLoad = list.status === 'loading' && list.items.length === 0;

  const recent = useMemo(
    () => Object.values(progress).sort((a, b) => b.updatedAt - a.updatedAt),
    [progress]
  );

  useEffect(() => {
    if (useStoryStore.getState().list.status === 'idle') void loadHome();
  }, [loadHome]);

  useEffect(() => {
    const trimmed = query.trim();
    if (trimmed === filter.q) return;
    const timer = setTimeout(
      () => void setFilter({ q: trimmed }),
      SEARCH_DEBOUNCE_MS
    );
    return () => clearTimeout(timer);
  }, [query, filter.q, setFilter]);

  function continueReading(item: StoryProgress) {
    openReader(item.storyId, item.position);
  }

  function renderList() {
    if (firstLoad) {
      return (
        <div className="flex justify-center py-10">
          <Spinner />
        </div>
      );
    }
    if (list.status === 'error' && list.items.length === 0) {
      return (
        <div className="flex flex-col items-center gap-3 py-10 text-sm text-black/54">
          {t('story.loadError')}
          <button
            type="button"
            onClick={() => void setFilter(filter)}
            className="rounded-full bg-ola-button px-4 py-1.5 text-ola-on-primary"
          >
            {t('story.retry')}
          </button>
        </div>
      );
    }
    if (list.items.length === 0) {
      return (
        <Placeholder
          text={t(searching ? 'story.searchEmpty' : 'story.empty')}
        />
      );
    }
    return (
      <>
        <ul className="divide-y divide-black/6">
          {list.items.map((story) => (
            <StoryRow key={story.id} story={story} onOpen={openStory} />
          ))}
        </ul>
        {list.hasMore && (
          <div className="flex justify-center py-4">
            <button
              type="button"
              disabled={list.status === 'loading'}
              onClick={() => void loadMore()}
              className="flex h-9 min-w-36 items-center justify-center rounded-full border border-ola-primary px-4 text-sm text-ola-primary-ink disabled:opacity-60"
            >
              {list.status === 'loading' ? (
                <Spinner size={18} />
              ) : (
                t('story.loadMore')
              )}
            </button>
          </div>
        )}
      </>
    );
  }

  return (
    <>
      <HomeHeader>
        <label className="flex h-9 w-full items-center gap-2 rounded-full bg-white/20 px-3">
          <SearchIcon className="h-5 w-5 shrink-0 text-white/80" />
          <input
            value={query}
            onChange={(event) => setQuery(event.target.value)}
            placeholder={t('story.searchPlaceholder')}
            className="min-w-0 flex-1 bg-transparent text-base text-white outline-none placeholder:text-white/70"
          />
          {query !== '' && (
            <button
              type="button"
              aria-label={t('common.clear')}
              onClick={() => setQuery('')}
              className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full text-lg leading-none text-white/80 hover:bg-white/15"
            >
              ×
            </button>
          )}
        </label>
      </HomeHeader>
      <main className="relative flex-1 overflow-y-auto bg-ola-surface">
        {!searching && recent.length > 0 && (
          <StoryShelf title={t('story.continueReading')}>
            {recent.map((item) => (
              <ContinueCard
                key={item.storyId}
                progress={item}
                onOpen={continueReading}
              />
            ))}
          </StoryShelf>
        )}
        {!searching && topViewed.length > 0 && (
          <div className={cn(recent.length > 0 && 'mt-2')}>
            <StoryShelf title={t('story.topViewed')}>
              {topViewed.map((story, index) => (
                <TopStoryCard
                  key={story.id}
                  story={story}
                  rank={index + 1}
                  onOpen={openStory}
                />
              ))}
            </StoryShelf>
          </div>
        )}
        <section className={cn('bg-white', !searching && 'mt-2')}>
          <div className="flex items-center justify-between px-3 pt-3">
            <h2 className="text-[15px] font-bold text-black/87">
              {t(searching ? 'story.searchResults' : 'story.allStories')}
            </h2>
            {list.status === 'loading' && list.items.length > 0 && (
              <Spinner size={16} />
            )}
          </div>
          <div
            ref={genresRef}
            className="mt-2 flex gap-2 overflow-x-auto px-3 select-none [scrollbar-width:none]"
          >
            <Chip
              active={filter.genre === ''}
              onClick={() => void setFilter({ genre: '' })}
            >
              {t('story.allGenres')}
            </Chip>
            {genres.map((genre) => (
              <Chip
                key={genre.name}
                active={filter.genre === genre.name}
                onClick={() => void setFilter({ genre: genre.name })}
              >
                {genre.name}
              </Chip>
            ))}
          </div>
          <div className="mt-2 flex items-center gap-1 border-b border-black/6 px-3">
            <div role="tablist" className="flex min-w-0 flex-1 gap-4">
              {SORT_OPTIONS.map((option) => (
                <button
                  key={option.value}
                  type="button"
                  role="tab"
                  aria-selected={filter.sort === option.value}
                  onClick={() => void setFilter({ sort: option.value })}
                  className={cn(
                    '-mb-px border-b-2 py-2 text-[13px] whitespace-nowrap',
                    filter.sort === option.value
                      ? 'border-ola-primary font-semibold text-ola-primary-ink'
                      : 'border-transparent text-black/54'
                  )}
                >
                  {t(option.labelKey)}
                </button>
              ))}
            </div>
            <select
              value={filter.status}
              aria-label={t('story.statusAll')}
              onChange={(event) =>
                void setFilter({
                  status: event.target.value as StoryStatusFilter,
                })
              }
              className="shrink-0 rounded border border-ola-border-strong bg-white py-1 pr-1 pl-2 text-[13px] text-black/70 outline-none"
            >
              {STATUS_FILTER_OPTIONS.map((option) => (
                <option key={option.value} value={option.value}>
                  {t(option.labelKey)}
                </option>
              ))}
            </select>
          </div>
          {renderList()}
        </section>
      </main>
    </>
  );
}

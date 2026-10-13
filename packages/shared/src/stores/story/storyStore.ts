import { create } from 'zustand';
import { STORY_SORT, STORY_STATUS_FILTER } from '../../constants/story';
import { StoryService } from '../../services/story.service';
import {
  STORY_NEW_CHAPTER_MS,
  STORY_PAGE_SIZE,
  STORY_TOP_LIMIT,
  storyChapterKey,
} from '../../lib/story';
import type { Story, StoryChapter, StoryChapterSummary } from '../../types/api/story.type';
import type {
  StoryChapterItem,
  StoryListFilter,
  StoryStoreState,
} from '../../types/client/story.type';

const DEFAULT_FILTER: StoryListFilter = {
  sort: STORY_SORT.updated,
  genre: '',
  status: STORY_STATUS_FILTER.all,
  q: '',
};

let listRequest = 0;
let session = 0;

function initialState() {
  return {
    genres: [],
    topViewed: [],
    list: { filter: DEFAULT_FILTER, items: [], total: 0, hasMore: false, status: 'idle' as const },
    stories: {},
    storyStatus: {},
    chapters: {},
    chapterContents: {},
    chapterStatus: {},
    chapterLocks: {},
    storyAccess: {},
  };
}

function storiesById(stories: Story[]): Record<string, Story> {
  return Object.fromEntries(stories.map((story) => [story.id, story]));
}

function toChapterItems(chapters: StoryChapterSummary[], nowMs: number): StoryChapterItem[] {
  return chapters.map((chapter) => ({
    ...chapter,
    isNew:
      chapter.publishedAt !== null &&
      nowMs - new Date(chapter.publishedAt).getTime() < STORY_NEW_CHAPTER_MS,
  }));
}

function withoutKeys<T>(record: Record<string, T>, keys: string[]): Record<string, T> {
  const next = { ...record };
  keys.forEach((key) => delete next[key]);
  return next;
}

function refreshChapterNavigation(
  contents: Record<string, StoryChapter>,
  chapters: StoryChapterSummary[]
): Record<string, StoryChapter> {
  const updated = { ...contents };
  chapters.forEach((summary, index) => {
    const key = storyChapterKey(summary.storyId, summary.position);
    const cached = updated[key];
    if (!cached || cached.id !== summary.id) return;
    const prevPosition = chapters[index - 1]?.position ?? null;
    const nextPosition = chapters[index + 1]?.position ?? null;
    if (cached.prevPosition === prevPosition && cached.nextPosition === nextPosition) return;
    updated[key] = { ...cached, prevPosition, nextPosition };
  });
  return updated;
}

export const useStoryStore = create<StoryStoreState>((set, get) => {
  function reloadLocks(matches: (chapter: StoryChapter) => boolean) {
    const locked = Object.entries(get().chapterLocks).filter(([, chapter]) => matches(chapter));
    const keys = locked.map(([key]) => key);
    set((state) => ({
      chapterLocks: withoutKeys(state.chapterLocks, keys),
      chapterStatus: withoutKeys(state.chapterStatus, keys),
    }));
    locked.forEach(([, chapter]) => void get().loadChapter(chapter.storyId, chapter.position));
  }

  async function fetchPage(filter: StoryListFilter, append: boolean) {
    const request = ++listRequest;
    const offset = append ? get().list.items.length : 0;
    set((state) => ({
      list: {
        ...(append ? state.list : { items: [], total: 0, hasMore: false }),
        filter,
        status: 'loading',
      },
    }));
    try {
      const result = await StoryService.list({
        sort: filter.sort,
        status: filter.status,
        genre: filter.genre || undefined,
        q: filter.q || undefined,
        offset,
        limit: STORY_PAGE_SIZE,
      });
      if (request !== listRequest) return;
      set((state) => ({
        list: {
          filter,
          items: append ? [...state.list.items, ...result.items] : result.items,
          total: result.total,
          hasMore: result.hasMore,
          status: 'ready',
        },
        stories: { ...state.stories, ...storiesById(result.items) },
      }));
    } catch {
      if (request !== listRequest) return;
      set((state) => ({ list: { ...state.list, status: 'error' } }));
    }
  }

  return {
    ...initialState(),

    loadHome: async () => {
      const current = session;
      const [genres, top] = await Promise.all([
        StoryService.genres().catch(() => null),
        StoryService.list({ sort: STORY_SORT.views, limit: STORY_TOP_LIMIT }).catch(() => null),
        fetchPage(get().list.filter, false),
      ]);
      if (current !== session) return;
      set((state) => ({
        genres: genres ?? state.genres,
        topViewed: top?.items ?? state.topViewed,
        stories: { ...state.stories, ...storiesById(top?.items ?? []) },
      }));
    },

    setFilter: (patch) => fetchPage({ ...get().list.filter, ...patch }, false),

    loadMore: async () => {
      const { list } = get();
      if (list.status === 'loading' || !list.hasMore) return;
      await fetchPage(list.filter, true);
    },

    loadStory: async (storyId) => {
      if (get().storyStatus[storyId] === 'loading') return;
      const current = session;
      set((state) => ({ storyStatus: { ...state.storyStatus, [storyId]: 'loading' } }));
      const [storyResult, chaptersResult] = await Promise.allSettled([
        StoryService.detail(storyId),
        StoryService.chapters(storyId),
      ]);
      if (current !== session) return;
      const storyLoaded = storyResult.status === 'fulfilled';
      const chaptersLoaded = chaptersResult.status === 'fulfilled';
      const nowMs = Date.now();
      set((state) => ({
        ...(storyLoaded && {
          stories: { ...state.stories, [storyId]: storyResult.value },
        }),
        ...(storyLoaded &&
          storyResult.value.access && {
            storyAccess: { ...state.storyAccess, [storyId]: storyResult.value.access },
          }),
        ...(chaptersLoaded && {
          chapters: {
            ...state.chapters,
            [storyId]: toChapterItems(chaptersResult.value, nowMs),
          },
          chapterContents: refreshChapterNavigation(state.chapterContents, chaptersResult.value),
        }),
        storyStatus: {
          ...state.storyStatus,
          [storyId]: storyLoaded && chaptersLoaded ? 'ready' : 'error',
        },
      }));
    },

    loadChapter: async (storyId, position) => {
      const key = storyChapterKey(storyId, position);
      const { chapterContents, chapterStatus, chapters } = get();
      if (chapterContents[key] || chapterStatus[key] === 'loading') return;
      const current = session;
      set((state) => ({ chapterStatus: { ...state.chapterStatus, [key]: 'loading' } }));
      try {
        const chapter = await StoryService.chapter(storyId, position);
        if (current !== session) return;
        if (chapter.locked) {
          set((state) => ({
            chapterLocks: { ...state.chapterLocks, [key]: chapter },
            chapterStatus: { ...state.chapterStatus, [key]: 'locked' },
            storyAccess: { ...state.storyAccess, [storyId]: chapter.access },
          }));
          return;
        }
        set((state) => {
          const contents = { ...state.chapterContents, [key]: chapter };
          const latestChapters = state.chapters[storyId];
          return {
            chapterContents:
              latestChapters && latestChapters !== chapters[storyId]
                ? refreshChapterNavigation(contents, latestChapters)
                : contents,
            chapterStatus: { ...state.chapterStatus, [key]: 'ready' },
            chapterLocks: withoutKeys(state.chapterLocks, [key]),
            storyAccess: { ...state.storyAccess, [storyId]: chapter.access },
          };
        });
      } catch {
        if (current !== session) return;
        set((state) => ({ chapterStatus: { ...state.chapterStatus, [key]: 'error' } }));
      }
    },

    prefetchChapter: async (storyId, position) => {
      const key = storyChapterKey(storyId, position);
      const { chapterContents, chapterStatus } = get();
      if (chapterContents[key] || chapterStatus[key]) return;
      const current = session;
      try {
        const chapter = await StoryService.chapter(storyId, position, true);
        if (current !== session || chapter.locked || get().chapterContents[key] || get().chapterStatus[key]) {
          return;
        }
        set((state) => ({
          chapterContents: { ...state.chapterContents, [key]: chapter },
          chapterStatus: { ...state.chapterStatus, [key]: 'ready' },
        }));
      } catch {
        return;
      }
    },

    markUnlocked: (storyId) => {
      set((state) => {
        const current = state.storyAccess[storyId];
        return current
          ? { storyAccess: { ...state.storyAccess, [storyId]: { ...current, unlocked: true } } }
          : {};
      });
      reloadLocks((chapter) => chapter.storyId === storyId);
    },

    reloadLocked: () => reloadLocks(() => true),

    setCommentCount: (storyId, count) =>
      set((state) => {
        const story = state.stories[storyId];
        return story ? { stories: { ...state.stories, [storyId]: { ...story, commentCount: count } } } : {};
      }),

    reset: () => {
      session += 1;
      listRequest += 1;
      set(initialState());
    },
  };
});

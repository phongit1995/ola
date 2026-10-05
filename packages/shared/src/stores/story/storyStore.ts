import { create } from 'zustand';
import { STORY_SORT, STORY_STATUS_FILTER } from '../../constants/story';
import { StoryService } from '../../services/story.service';
import {
  STORY_NEW_CHAPTER_MS,
  STORY_PAGE_SIZE,
  STORY_TOP_LIMIT,
  storyChapterKey,
} from '../../lib/story';
import type { Story, StoryChapterSummary } from '../../types/api/story.type';
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

export const useStoryStore = create<StoryStoreState>((set, get) => {
  async function fetchPage(filter: StoryListFilter, append: boolean) {
    const request = ++listRequest;
    const offset = append ? get().list.items.length : 0;
    set((state) => ({ list: { ...state.list, filter, status: 'loading' } }));
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
    genres: [],
    topViewed: [],
    list: { filter: DEFAULT_FILTER, items: [], total: 0, hasMore: false, status: 'idle' },
    stories: {},
    storyStatus: {},
    chapters: {},
    chapterContents: {},
    chapterStatus: {},

    loadHome: async () => {
      const [genres, top] = await Promise.all([
        StoryService.genres().catch(() => null),
        StoryService.list({ sort: STORY_SORT.views, limit: STORY_TOP_LIMIT }).catch(() => null),
        fetchPage(get().list.filter, false),
      ]);
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
      set((state) => ({ storyStatus: { ...state.storyStatus, [storyId]: 'loading' } }));
      try {
        const [story, chapters] = await Promise.all([
          StoryService.detail(storyId),
          StoryService.chapters(storyId),
        ]);
        const nowMs = Date.now();
        set((state) => ({
          stories: { ...state.stories, [storyId]: story },
          chapters: { ...state.chapters, [storyId]: toChapterItems(chapters, nowMs) },
          storyStatus: { ...state.storyStatus, [storyId]: 'ready' },
        }));
      } catch {
        set((state) => ({ storyStatus: { ...state.storyStatus, [storyId]: 'error' } }));
      }
    },

    loadChapter: async (storyId, position) => {
      const key = storyChapterKey(storyId, position);
      const { chapterContents, chapterStatus } = get();
      if (chapterContents[key] || chapterStatus[key] === 'loading') return;
      set((state) => ({ chapterStatus: { ...state.chapterStatus, [key]: 'loading' } }));
      try {
        const chapter = await StoryService.chapter(storyId, position);
        set((state) => ({
          chapterContents: { ...state.chapterContents, [key]: chapter },
          chapterStatus: { ...state.chapterStatus, [key]: 'ready' },
        }));
      } catch {
        set((state) => ({ chapterStatus: { ...state.chapterStatus, [key]: 'error' } }));
      }
    },
  };
});

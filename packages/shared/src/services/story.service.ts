import { STORY_SORT, STORY_STATUS_FILTER } from '../constants/story';
import { foldVietnamese, STORY_PAGE_SIZE } from '../lib/story';
import type {
  Story,
  StoryChapter,
  StoryChapterSummary,
  StoryGenreItem,
  StoryListQuery,
  StoryListResult,
  StorySort,
} from '../types/api/story.type';
import { MOCK_STORIES, mockChapter, mockChapterSummaries } from './story.mock';

const MOCK_LATENCY_MS = 150;

const SORTERS: Record<StorySort, (a: Story, b: Story) => number> = {
  updated: (a, b) => b.updatedAt.localeCompare(a.updatedAt),
  views: (a, b) => b.viewCount - a.viewCount,
  new: (a, b) => b.publishedAt.localeCompare(a.publishedAt),
};

function delay<T>(value: T): Promise<T> {
  return new Promise((resolve) => setTimeout(() => resolve(value), MOCK_LATENCY_MS));
}

function notFound(): Promise<never> {
  return delay(null).then(() => {
    throw new Error('STORY_NOT_FOUND');
  });
}

function matchesQuery(story: Story, query: StoryListQuery): boolean {
  if (query.genre && !story.genres.includes(query.genre)) return false;
  if (query.status && query.status !== STORY_STATUS_FILTER.all && story.status !== query.status) return false;
  const needle = foldVietnamese(query.q ?? '');
  if (!needle) return true;
  return foldVietnamese(`${story.title} ${story.authorName}`).includes(needle);
}

export class StoryService {
  static list(query: StoryListQuery = {}): Promise<StoryListResult> {
    const offset = query.offset ?? 0;
    const limit = query.limit ?? STORY_PAGE_SIZE;
    const matched = MOCK_STORIES.filter((story) => matchesQuery(story, query)).sort(
      SORTERS[query.sort ?? STORY_SORT.updated]
    );
    return delay({
      items: matched.slice(offset, offset + limit),
      total: matched.length,
      hasMore: offset + limit < matched.length,
    });
  }

  static genres(): Promise<StoryGenreItem[]> {
    const counts = new Map<string, number>();
    for (const story of MOCK_STORIES) {
      for (const genre of story.genres) counts.set(genre, (counts.get(genre) ?? 0) + 1);
    }
    const genres = [...counts.entries()]
      .map(([name, count]) => ({ name, count }))
      .sort((a, b) => b.count - a.count || a.name.localeCompare(b.name, 'vi'));
    return delay(genres);
  }

  static detail(storyId: string): Promise<Story> {
    const story = MOCK_STORIES.find((item) => item.id === storyId);
    return story ? delay(story) : notFound();
  }

  static chapters(storyId: string): Promise<StoryChapterSummary[]> {
    const chapters = mockChapterSummaries(storyId);
    return chapters ? delay(chapters) : notFound();
  }

  static chapter(storyId: string, position: number): Promise<StoryChapter> {
    const chapter = mockChapter(storyId, position);
    return chapter ? delay(chapter) : notFound();
  }
}

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

interface StoryDataIndex {
  stories: Story[];
  chapters: Record<string, StoryChapterSummary[]>;
  mock?: boolean;
}

type ChapterContents = Record<string, string>;

function storyActivityAt(story: Story): string {
  return story.lastChapterAt ?? story.updatedAt;
}

const SORTERS: Record<StorySort, (a: Story, b: Story) => number> = {
  updated: (a, b) => storyActivityAt(b).localeCompare(storyActivityAt(a)),
  views: (a, b) => b.viewCount - a.viewCount,
  new: (a, b) => b.publishedAt.localeCompare(a.publishedAt),
};

let storyDataUrl = '/story-data';
let indexRequest: Promise<StoryDataIndex> | null = null;
const contentRequests = new Map<string, Promise<ChapterContents>>();

export function setStoryDataUrl(url: string): void {
  storyDataUrl = url;
  indexRequest = null;
  contentRequests.clear();
}

function mockIndex(): StoryDataIndex {
  return {
    stories: MOCK_STORIES,
    chapters: Object.fromEntries(
      MOCK_STORIES.map((story) => [story.id, mockChapterSummaries(story.id) ?? []])
    ),
    mock: true,
  };
}

async function fetchJson<T>(path: string): Promise<T> {
  const response = await fetch(`${storyDataUrl}/${path}`);
  if (!response.ok || !response.headers.get('content-type')?.includes('json')) {
    throw new Error('STORY_DATA_UNAVAILABLE');
  }
  return (await response.json()) as T;
}

function loadIndex(): Promise<StoryDataIndex> {
  indexRequest ??= fetchJson<StoryDataIndex>('index.json').catch(() => mockIndex());
  return indexRequest;
}

function loadContents(storyId: string): Promise<ChapterContents> {
  let request = contentRequests.get(storyId);
  if (!request) {
    request = fetchJson<ChapterContents>(`chapters/${storyId}.json`);
    request.catch(() => contentRequests.delete(storyId));
    contentRequests.set(storyId, request);
  }
  return request;
}

function notFound(): never {
  throw new Error('STORY_NOT_FOUND');
}

function matchesQuery(story: Story, query: StoryListQuery): boolean {
  if (query.genre && !story.genres.includes(query.genre)) return false;
  if (query.status && query.status !== STORY_STATUS_FILTER.all && story.status !== query.status)
    return false;
  const needle = foldVietnamese(query.q ?? '');
  if (!needle) return true;
  return foldVietnamese(`${story.title} ${story.authorName}`).includes(needle);
}

export class StoryService {
  static async list(query: StoryListQuery = {}): Promise<StoryListResult> {
    const { stories } = await loadIndex();
    const offset = query.offset ?? 0;
    const limit = query.limit ?? STORY_PAGE_SIZE;
    const matched = stories
      .filter((story) => matchesQuery(story, query))
      .sort(SORTERS[query.sort ?? STORY_SORT.updated]);
    return {
      items: matched.slice(offset, offset + limit),
      total: matched.length,
      hasMore: offset + limit < matched.length,
    };
  }

  static async genres(): Promise<StoryGenreItem[]> {
    const { stories } = await loadIndex();
    const counts = new Map<string, number>();
    for (const story of stories) {
      for (const genre of story.genres) counts.set(genre, (counts.get(genre) ?? 0) + 1);
    }
    return [...counts.entries()]
      .map(([name, count]) => ({ name, count }))
      .sort((a, b) => b.count - a.count || a.name.localeCompare(b.name, 'vi'));
  }

  static async detail(storyId: string): Promise<Story> {
    const { stories } = await loadIndex();
    return stories.find((story) => story.id === storyId) ?? notFound();
  }

  static async chapters(storyId: string): Promise<StoryChapterSummary[]> {
    const { chapters } = await loadIndex();
    return chapters[storyId] ?? notFound();
  }

  static async chapter(storyId: string, position: number): Promise<StoryChapter> {
    const index = await loadIndex();
    if (index.mock) return mockChapter(storyId, position) ?? notFound();
    const summaries = index.chapters[storyId] ?? notFound();
    const summary = summaries.find((item) => item.position === position) ?? notFound();
    const contents = await loadContents(storyId);
    return {
      ...summary,
      content: contents[String(position)] ?? '',
      prevPosition: position > 1 ? position - 1 : null,
      nextPosition: position < summaries.length ? position + 1 : null,
    };
  }
}

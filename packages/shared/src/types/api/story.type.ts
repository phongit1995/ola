export type StoryKind = 'short' | 'long';

export type StoryStatus = 'ongoing' | 'completed' | 'unknown';

export type StorySort = 'updated' | 'views' | 'new';

export type StoryStatusFilter = 'all' | 'ongoing' | 'completed';

export interface Story {
  id: string;
  slug: string;
  title: string;
  authorName: string;
  kind: StoryKind;
  genres: string[];
  tags: string[];
  intro: string;
  coverUrl: string | null;
  status: StoryStatus;
  chapterCount: number;
  wordCount: number;
  viewCount: number;
  commentCount: number;
  publishedAt: string;
  updatedAt: string;
  lastChapterAt: string | null;
  likeCount: number;
  ageRating: string;
  sourceUrl: string;
}

export interface StoryGenreItem {
  name: string;
  count: number;
}

export interface StoryGenreListResult {
  items: StoryGenreItem[];
}

export interface StoryChapterSummary {
  id: string;
  storyId: string;
  position: number;
  title: string;
  wordCount: number;
  publishedAt: string | null;
}

export interface StoryChapterListResult {
  items: StoryChapterSummary[];
}

export interface StoryChapter extends StoryChapterSummary {
  content: string;
  prevPosition: number | null;
  nextPosition: number | null;
}

export interface StoryListQuery {
  sort?: StorySort;
  genre?: string;
  status?: StoryStatusFilter;
  q?: string;
  offset?: number;
  limit?: number;
}

export interface StoryListResult {
  items: Story[];
  total: number;
  hasMore: boolean;
}

export type StoryKind = 'short' | 'long';

export type StoryStatus = 'ongoing' | 'completed' | 'unknown';

export type StorySort = 'updated' | 'views' | 'new';

export type StoryStatusFilter = 'all' | 'ongoing' | 'completed';

export interface StoryAccess {
  enabled: boolean;
  vip: boolean;
  unlocked: boolean;
  freeLimit: number;
  freeUsed: number;
  commentMinChars: number;
}

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
  access?: StoryAccess;
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
  locked: boolean;
  access: StoryAccess;
}

export interface StoryCommentAuthor {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  vipUsed?: string | null;
  vipEndTime?: string | null;
}

export interface StoryCommentReply {
  commentId: string;
  authorName: string;
  excerpt: string;
}

export interface StoryCommentStory {
  id: string;
  title: string;
  coverUrl?: string | null;
}

export interface StoryComment {
  id: string;
  storyId: string;
  parentId?: string;
  content: string;
  author?: StoryCommentAuthor;
  replyTo?: StoryCommentReply;
  story?: StoryCommentStory;
  likeCount: number;
  liked: boolean;
  mine: boolean;
  createdAt: string;
}

export interface StoryCommentListQuery {
  cursor?: string;
  limit?: number;
}

export interface StoryCommentListResult {
  items: StoryComment[];
  nextCursor?: string;
}

export interface CreateStoryCommentRequest {
  content: string;
  parentId?: string;
}

export interface CreateStoryCommentResult {
  comment: StoryComment;
  commentCount: number;
  unlocked: boolean;
}

export interface DeleteStoryCommentResult {
  commentCount: number;
}

export interface StoryCommentLikeResult {
  liked: boolean;
  likeCount: number;
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

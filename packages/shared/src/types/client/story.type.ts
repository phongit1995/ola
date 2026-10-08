import type {
  Story,
  StoryChapter,
  StoryChapterSummary,
  StoryGenreItem,
  StorySort,
  StoryStatusFilter,
} from '../api/story.type';

export type { StoryIconName } from '../../constants/storyIcons';

export type StoryLoadStatus = 'idle' | 'loading' | 'ready' | 'error';

export type StoryReaderTheme = 'light' | 'sepia' | 'green' | 'gray' | 'dark';

export type StoryReaderFont = 'serif' | 'sans';

export interface StoryChapterItem extends StoryChapterSummary {
  isNew: boolean;
}

export interface StoryListFilter {
  sort: StorySort;
  genre: string;
  status: StoryStatusFilter;
  q: string;
}

export interface StoryListSlice {
  filter: StoryListFilter;
  items: Story[];
  total: number;
  hasMore: boolean;
  status: StoryLoadStatus;
}

export interface StoryStoreState {
  genres: StoryGenreItem[];
  topViewed: Story[];
  list: StoryListSlice;
  stories: Record<string, Story>;
  storyStatus: Record<string, StoryLoadStatus>;
  chapters: Record<string, StoryChapterItem[]>;
  chapterContents: Record<string, StoryChapter>;
  chapterStatus: Record<string, StoryLoadStatus>;
  loadHome: () => Promise<void>;
  setFilter: (patch: Partial<StoryListFilter>) => Promise<void>;
  loadMore: () => Promise<void>;
  loadStory: (storyId: string) => Promise<void>;
  loadChapter: (storyId: string, position: number) => Promise<void>;
}

export interface StoryProgress {
  storyId: string;
  storyTitle: string;
  coverUrl?: string | null;
  position: number;
  chapterTitle: string;
  chapterCount: number;
  updatedAt: number;
}

export interface StoryReaderPrefs {
  theme: StoryReaderTheme;
  font: StoryReaderFont;
  fontSize: number;
  lineHeight: number;
}

export interface PersistedStoryPrefs {
  reader: StoryReaderPrefs;
  progress: Record<string, StoryProgress>;
}

export interface StoryPrefsState extends PersistedStoryPrefs {
  setReader: (patch: Partial<StoryReaderPrefs>) => void;
  saveProgress: (progress: Omit<StoryProgress, 'updatedAt'>) => void;
}

export interface StoryConfigState {
  enabled: boolean | null;
  load: () => Promise<void>;
}

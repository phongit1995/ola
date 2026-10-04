import type { StoryKind, StorySort, StoryStatus, StoryStatusFilter } from '../types/api/story.type';

export const STORY_STATUS = {
  ongoing: 'ongoing',
  completed: 'completed',
  unknown: 'unknown',
} as const satisfies Record<string, StoryStatus>;

export const STORY_KIND = {
  short: 'short',
  long: 'long',
} as const satisfies Record<string, StoryKind>;

export const STORY_SORT = {
  updated: 'updated',
  views: 'views',
  new: 'new',
} as const satisfies Record<string, StorySort>;

export const STORY_STATUS_FILTER = {
  all: 'all',
  ongoing: 'ongoing',
  completed: 'completed',
} as const satisfies Record<string, StoryStatusFilter>;

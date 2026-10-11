import type { TFunction } from 'i18next';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import type { StoryAccess } from '@ola/shared/types';

export type StoryAccessTone = 'positive' | 'neutral' | 'warning';

export interface StoryAccessLine {
  label: string;
  tone: StoryAccessTone;
}

export function storyAccessLine(t: TFunction, access: StoryAccess | undefined): StoryAccessLine | null {
  if (!access?.enabled) return null;
  if (access.vip) return { label: t('story.accessVip'), tone: 'positive' };
  if (access.unlocked) return { label: t('story.accessUnlocked'), tone: 'positive' };
  const left = Math.max(0, access.freeLimit - access.freeUsed);
  return left > 0
    ? { label: t('story.accessFree', { left, limit: access.freeLimit }), tone: 'neutral' }
    : { label: t('story.accessNoneLeft', { limit: access.freeLimit }), tone: 'warning' };
}

export function commentUnlockMinChars(access: StoryAccess | undefined): number | null {
  return access?.enabled && !access.vip && !access.unlocked ? access.commentMinChars : null;
}

export function currentStoryAccess(storyId: string): StoryAccess | undefined {
  const state = useStoryStore.getState();
  return state.storyAccess[storyId] ?? state.stories[storyId]?.access;
}

export function useStoryAccess(storyId: string): StoryAccess | undefined {
  const tracked = useStoryStore((state) => state.storyAccess[storyId]);
  const fromStory = useStoryStore((state) => state.stories[storyId]?.access);
  return tracked ?? fromStory;
}

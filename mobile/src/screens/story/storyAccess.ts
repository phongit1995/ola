import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import type { StoryAccess } from '@ola/shared/types';

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

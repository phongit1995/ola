import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { sharedPersistStorage } from '../../platform/persistStorage';
import {
  clampStoryFontSize,
  isStoryId,
  STORY_READER_DEFAULTS,
  STORY_RECENT_LIMIT,
} from '../../lib/story';
import type {
  PersistedStoryPrefs,
  StoryPrefsState,
  StoryProgress,
} from '../../types/client/story.type';

function keepRecent(progress: Record<string, StoryProgress>): Record<string, StoryProgress> {
  const recent = Object.values(progress)
    .sort((a, b) => b.updatedAt - a.updatedAt)
    .slice(0, STORY_RECENT_LIMIT);
  return Object.fromEntries(recent.map((item) => [item.storyId, item]));
}

export const useStoryPrefsStore = create<StoryPrefsState>()(
  persist(
    (set) => ({
      reader: STORY_READER_DEFAULTS,
      progress: {},
      setReader: (patch) =>
        set((state) => {
          const reader = { ...state.reader, ...patch };
          return { reader: { ...reader, fontSize: clampStoryFontSize(reader.fontSize) } };
        }),
      saveProgress: (progress) =>
        set((state) => ({
          progress: keepRecent({
            ...state.progress,
            [progress.storyId]: { ...progress, updatedAt: Date.now() },
          }),
        })),
    }),
    {
      name: 'ola.story.prefs',
      version: 1,
      storage: sharedPersistStorage<PersistedStoryPrefs>(),
      migrate: (persisted) => {
        const saved = persisted as Partial<PersistedStoryPrefs> | undefined;
        const progress = Object.fromEntries(
          Object.entries(saved?.progress ?? {}).filter(([storyId]) => isStoryId(storyId))
        );
        return { reader: { ...STORY_READER_DEFAULTS, ...saved?.reader }, progress };
      },
      partialize: (state) => ({ reader: state.reader, progress: state.progress }),
      merge: (persisted, current) => {
        const saved = persisted as Partial<PersistedStoryPrefs> | undefined;
        return {
          ...current,
          reader: { ...STORY_READER_DEFAULTS, ...saved?.reader },
          progress: saved?.progress ?? current.progress,
        };
      },
    }
  )
);

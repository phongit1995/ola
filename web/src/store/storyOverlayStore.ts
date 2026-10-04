import { create } from 'zustand';

export type StoryScreen =
  | { kind: 'detail'; storyId: string }
  | { kind: 'reader'; storyId: string; position: number };

interface StoryOverlayState {
  stack: StoryScreen[];
  openStory: (storyId: string) => void;
  openReader: (storyId: string, position: number) => void;
  goToChapter: (position: number) => void;
  back: () => void;
}

export const useStoryOverlayStore = create<StoryOverlayState>((set) => ({
  stack: [],
  openStory: (storyId) =>
    set((state) => ({ stack: [...state.stack, { kind: 'detail', storyId }] })),
  openReader: (storyId, position) =>
    set((state) => ({
      stack: [...state.stack, { kind: 'reader', storyId, position }],
    })),
  goToChapter: (position) =>
    set((state) => {
      const top = state.stack.at(-1);
      if (top?.kind !== 'reader') return state;
      return { stack: [...state.stack.slice(0, -1), { ...top, position }] };
    }),
  back: () => set((state) => ({ stack: state.stack.slice(0, -1) })),
}));

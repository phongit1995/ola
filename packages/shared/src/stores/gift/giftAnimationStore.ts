import { create } from 'zustand';
import type { GiftAnimationState } from '../../types/client/gift.type';

export const useGiftAnimationStore = create<GiftAnimationState>((set, get) => ({
  queue: [],
  seen: new Set<string>(),
  play: (item) => {
    if (get().seen.has(item.id)) return;
    set((state) => ({
      queue: [...state.queue, item],
      seen: new Set(state.seen).add(item.id),
    }));
  },
  next: () => set((state) => ({ queue: state.queue.slice(1) })),
}));

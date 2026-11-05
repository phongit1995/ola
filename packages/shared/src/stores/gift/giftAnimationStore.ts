import { create } from 'zustand';
import { pickGiftAnimation } from '../../lib/gift';
import type { GiftAnimationState } from '../../types/client/gift.type';

export const useGiftAnimationStore = create<GiftAnimationState>((set, get) => ({
  queue: [],
  seen: new Set<string>(),
  lastAnimation: null,
  play: (item) => {
    if (get().seen.has(item.id)) return;
    const seed = item.seed ?? Math.random();
    const animation = pickGiftAnimation(item.animation, seed, get().lastAnimation);
    set((state) => ({
      queue: [...state.queue, { ...item, seed, animation }],
      seen: new Set(state.seen).add(item.id),
      lastAnimation: animation,
    }));
  },
  next: () => set((state) => ({ queue: state.queue.slice(1) })),
}));

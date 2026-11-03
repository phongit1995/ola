import { create } from 'zustand';

export interface GiftAnimationItem {
  id: string;
  imageUrl: string;
  name: string;
  quantity: number;
  charmPoints: number;
  caption?: string;
}

interface GiftAnimationState {
  queue: GiftAnimationItem[];
  seen: Set<string>;
  play: (item: GiftAnimationItem) => void;
  next: () => void;
}

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

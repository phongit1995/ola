import { create } from 'zustand';
import type { TabKey } from '@components/BottomTabBar';

export type HomeNavIntent = 'meComposer' | 'momentComposer';

interface HomeNavState {
  seq: number;
  tab: TabKey | null;
  intent: HomeNavIntent | null;
  go: (tab: TabKey, intent?: HomeNavIntent) => void;
  takeIntent: (intent: HomeNavIntent) => boolean;
}

export const useHomeNavStore = create<HomeNavState>((set, get) => ({
  seq: 0,
  tab: null,
  intent: null,
  go: (tab, intent) => set((state) => ({ seq: state.seq + 1, tab, intent: intent ?? null })),
  takeIntent: (intent) => {
    if (get().intent !== intent) return false;
    set({ intent: null });
    return true;
  },
}));

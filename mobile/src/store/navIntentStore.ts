import { create } from 'zustand';

export type NavIntent = 'meComposer' | 'momentComposer';

interface NavIntentState {
  intent: NavIntent | null;
  request: (intent: NavIntent) => void;
  take: (intent: NavIntent) => boolean;
}

export const useNavIntentStore = create<NavIntentState>((set, get) => ({
  intent: null,
  request: (intent) => set({ intent }),
  take: (intent) => {
    if (get().intent !== intent) return false;
    set({ intent: null });
    return true;
  },
}));

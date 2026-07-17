import { create } from 'zustand';
import { registerOnLogout } from '@ola/shared/stores/authStore';

export type ClanOverlayEntry =
  | { kind: 'home' }
  | { kind: 'clan'; handle?: string; id?: string }
  | { kind: 'manage'; clanId: string }
  | { kind: 'members'; clanId: string }
  | { kind: 'bans'; clanId: string };

interface ClanOverlayState {
  stack: ClanOverlayEntry[];
  open: (entry: ClanOverlayEntry) => void;
  push: (entry: ClanOverlayEntry) => void;
  back: () => void;
  reset: () => void;
}

export const useClanOverlayStore = create<ClanOverlayState>((set) => ({
  stack: [],
  open: (entry) => set({ stack: [entry] }),
  push: (entry) => set((state) => ({ stack: [...state.stack, entry] })),
  back: () => set((state) => ({ stack: state.stack.slice(0, -1) })),
  reset: () => set({ stack: [] }),
}));

registerOnLogout(() => useClanOverlayStore.getState().reset());

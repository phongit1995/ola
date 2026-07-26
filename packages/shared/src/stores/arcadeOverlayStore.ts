import { create } from 'zustand';
import type { MiniGame } from '../types';

interface ArcadeOverlayState {
  active: MiniGame | null;
  minimized: boolean;
  notify: boolean;
  open: (game: MiniGame) => boolean;
  minimize: () => void;
  restore: () => void;
  setNotify: (value: boolean) => void;
  close: () => void;
}

export const useArcadeOverlayStore = create<ArcadeOverlayState>((set, get) => ({
  active: null,
  minimized: false,
  notify: false,
  open: (game) => {
    const current = get().active;
    if (current != null && current.id !== game.id) return false;
    set({
      active: current ?? game,
      minimized: false,
      notify: false,
    });
    return true;
  },
  minimize: () => set({ minimized: true, notify: false }),
  restore: () => set({ minimized: false, notify: false }),
  setNotify: (value) =>
    set((state) => ({ notify: value && state.minimized })),
  close: () => set({ active: null, minimized: false, notify: false }),
}));

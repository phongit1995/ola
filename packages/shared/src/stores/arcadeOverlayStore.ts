import { create } from 'zustand';
import type { ArcadeOverlayState } from '../types/client/arcade.type';

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

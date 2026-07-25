import { create } from 'zustand';
import type { MiniGame } from '@ola/shared/types';

interface ArcadeOverlayState {
  active: MiniGame | null;
  minimized: boolean;
  notify: boolean;
  open: (game: MiniGame) => void;
  minimize: () => void;
  restore: () => void;
  setNotify: (value: boolean) => void;
  close: () => void;
}

export const useArcadeOverlayStore = create<ArcadeOverlayState>((set) => ({
  active: null,
  minimized: false,
  notify: false,
  open: (game) => set({ active: game, minimized: false, notify: false }),
  minimize: () => set({ minimized: true }),
  restore: () => set({ minimized: false, notify: false }),
  setNotify: (value) => set({ notify: value }),
  close: () => set({ active: null, minimized: false, notify: false }),
}));

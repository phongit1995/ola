import { create } from 'zustand';
import type { MiniGame } from '@ola/shared/types';

interface ArcadeOverlayState {
  active: MiniGame | null;
  open: (game: MiniGame) => void;
  close: () => void;
}

export const useArcadeOverlayStore = create<ArcadeOverlayState>((set) => ({
  active: null,
  open: (game) => set({ active: game }),
  close: () => set({ active: null }),
}));

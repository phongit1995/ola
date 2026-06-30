import { create } from 'zustand';

export type GameOverlayKind = 'pen' | 'egg';

interface GameOverlayState {
  active: GameOverlayKind | null;
  open: (game: GameOverlayKind) => void;
  close: () => void;
}

export const useGameOverlayStore = create<GameOverlayState>((set) => ({
  active: null,
  open: (game) => set({ active: game }),
  close: () => set({ active: null }),
}));

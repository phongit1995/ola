import { create } from 'zustand';
import { MiniGameService } from '@ola/shared/services';
import type { MiniGame } from '@ola/shared/types';

interface ArcadeState {
  games: MiniGame[];
  loaded: boolean;
  active: MiniGame | null;
  fetchGames: () => Promise<void>;
  open: (game: MiniGame) => void;
  close: () => void;
}

export const useArcadeStore = create<ArcadeState>((set, get) => ({
  games: [],
  loaded: false,
  active: null,
  fetchGames: async () => {
    if (get().loaded) return;
    try {
      const games = await MiniGameService.list();
      set({ games, loaded: true });
    } catch {
      set({ loaded: true });
    }
  },
  open: (game) => set({ active: game }),
  close: () => set({ active: null }),
}));

import { create } from 'zustand';
import { MiniGameService } from '../services';
import type { MiniGame } from '../types';

interface ArcadeState {
  games: MiniGame[];
  loaded: boolean;
  fetchGames: () => Promise<void>;
}

export const useArcadeStore = create<ArcadeState>((set, get) => ({
  games: [],
  loaded: false,
  fetchGames: async () => {
    if (get().loaded) return;
    try {
      const games = await MiniGameService.list();
      set({ games, loaded: true });
    } catch {
      set({ loaded: true });
    }
  },
}));

import { create } from 'zustand';
import { MiniGameService } from '../services/miniGame.service';
import type { ArcadeState } from '../types/client/arcade.type';

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

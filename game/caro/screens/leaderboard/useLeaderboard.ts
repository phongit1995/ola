import { create } from 'zustand';
import type { LeaderboardPeriod } from '../../../src/sdk';

type PageUpdate = number | ((current: number) => number);

interface LeaderboardState {
  period: LeaderboardPeriod;
  page: number;
  setPeriod: (period: LeaderboardPeriod) => void;
  setPage: (update: PageUpdate) => void;
}

export const useLeaderboard = create<LeaderboardState>()((set) => ({
  period: 'day',
  page: 0,
  setPeriod: (period) => set({ period, page: 0 }),
  setPage: (update) =>
    set((state) => ({
      page: typeof update === 'function' ? update(state.page) : update,
    })),
}));

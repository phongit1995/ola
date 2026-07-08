import { create } from 'zustand';
import { toApiError, toast } from '@lib';
import { PenService } from '@services';
import type { PenLeaderboardEntry, PenLeaderboardPeriod } from '@app-types';
import { withPenVip } from './penVip';

export const PEN_LEADERBOARD_PAGE = 10;

interface PenLeaderboardState {
  period: PenLeaderboardPeriod;
  page: number;
  loading: boolean;
  cache: Partial<Record<PenLeaderboardPeriod, PenLeaderboardEntry[]>>;
  setPeriod: (period: PenLeaderboardPeriod) => void;
  setPage: (page: number) => void;
  load: (period: PenLeaderboardPeriod) => Promise<void>;
  reset: () => void;
}

const initial = {
  period: 'day' as PenLeaderboardPeriod,
  page: 0,
  loading: false,
  cache: {},
};

export const usePenLeaderboardStore = create<PenLeaderboardState>((set, get) => ({
  ...initial,
  setPeriod: (period) => {
    set({ period, page: 0 });
    void get().load(period);
  },
  setPage: (page) => set({ page }),
  load: async (period) => {
    if (get().cache[period]) return;
    set({ loading: true });
    try {
      const res = await PenService.leaderboard(period);
      const items = res.items.map((e) => ({ ...e, user: withPenVip(e.user) ?? e.user }));
      set((state) => ({ cache: { ...state.cache, [period]: items }, loading: false }));
    } catch (e) {
      set({ loading: false });
      toast.error(toApiError(e).message);
    }
  },
  reset: () => set({ ...initial, cache: {} }),
}));

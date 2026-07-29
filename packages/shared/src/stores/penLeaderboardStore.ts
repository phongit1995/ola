import { create } from 'zustand';
import { toApiError } from '../lib/apiError';
import { toast } from '../lib/toast';
import { PenService } from '../services/pen.service';
import type { PenLeaderboardState } from '../types/client/pen.type';
import { initialPenLeaderboardState } from './penLeaderboard.state';
import { withPenVip } from './penVip';

export { PEN_LEADERBOARD_PAGE_SIZE as PEN_LEADERBOARD_PAGE } from '../constants/pen';

export const usePenLeaderboardStore = create<PenLeaderboardState>((set, get) => ({
  ...initialPenLeaderboardState,
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
  reset: () => set({ ...initialPenLeaderboardState, cache: {} }),
}));

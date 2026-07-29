import { create } from 'zustand';
import { PEN_HISTORY_PAGE_SIZE } from '../constants/pen';
import { toApiError } from '../lib/apiError';
import { toast } from '../lib/toast';
import { PenService } from '../services/pen.service';
import type { PenHistoryState } from '../types/client/penHistory.type';
import { createEmptyPenHistorySections } from './penHistory.state';
import { mapPenShot } from './penVip';

export { PEN_HISTORY_PAGE_SIZE as PEN_HISTORY_PAGE } from '../constants/pen';
export type { PenHistorySection } from '../types/client/penHistory.type';

export const usePenHistoryStore = create<PenHistoryState>((set) => ({
  sections: createEmptyPenHistorySections(),
  load: async (section, page) => {
    set((state) => ({
      sections: { ...state.sections, [section]: { ...state.sections[section], loading: true, page } },
    }));
    try {
      const params = {
        limit: PEN_HISTORY_PAGE_SIZE,
        offset: page * PEN_HISTORY_PAGE_SIZE,
      };
      const res =
        section === 'all'
          ? await PenService.allHistory(params)
          : await PenService.history({ role: section, ...params });
      set((state) => ({
        sections: {
          ...state.sections,
          [section]: { items: res.items.map(mapPenShot), total: res.total, page, loading: false },
        },
      }));
    } catch (e) {
      set((state) => ({
        sections: { ...state.sections, [section]: { ...state.sections[section], loading: false } },
      }));
      toast.error(toApiError(e).message);
    }
  },
  reset: () => set({ sections: createEmptyPenHistorySections() }),
}));

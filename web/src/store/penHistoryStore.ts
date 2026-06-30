import { create } from 'zustand';
import { toApiError, toast } from '@lib';
import { PenService } from '@services';
import type { PenShotView } from '@app-types';
import { mapPenShot } from './penVip';

export const PEN_HISTORY_PAGE = 10;

export type PenHistorySection = 'shoot' | 'catch' | 'all';

interface PenHistorySectionState {
  items: PenShotView[];
  page: number;
  total: number;
  loading: boolean;
}

interface PenHistoryState {
  sections: Record<PenHistorySection, PenHistorySectionState>;
  load: (section: PenHistorySection, page: number) => Promise<void>;
  reset: () => void;
}

const emptySection: PenHistorySectionState = { items: [], page: 0, total: 0, loading: true };

function emptySections(): Record<PenHistorySection, PenHistorySectionState> {
  return { shoot: { ...emptySection }, catch: { ...emptySection }, all: { ...emptySection } };
}

export const usePenHistoryStore = create<PenHistoryState>((set) => ({
  sections: emptySections(),
  load: async (section, page) => {
    set((state) => ({
      sections: { ...state.sections, [section]: { ...state.sections[section], loading: true, page } },
    }));
    try {
      const params = { limit: PEN_HISTORY_PAGE, offset: page * PEN_HISTORY_PAGE };
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
  reset: () => set({ sections: emptySections() }),
}));

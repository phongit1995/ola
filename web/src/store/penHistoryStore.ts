import { create } from 'zustand';
import { activeVipTypeId, toApiError, toast } from '@lib';
import { PenService } from '@services';
import type { PenShotView, PenUserBrief } from '@app-types';

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

function withVip(user?: PenUserBrief): PenUserBrief | undefined {
  if (user == null) return user;
  return { ...user, vipTypeId: activeVipTypeId(user.vipUsed, user.vipEndTime) };
}

function mapShot(shot: PenShotView): PenShotView {
  return { ...shot, shooter: withVip(shot.shooter), keeper: withVip(shot.keeper) };
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
          [section]: { items: res.items.map(mapShot), total: res.total, page, loading: false },
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

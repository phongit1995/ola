import { create } from 'zustand';
import { toApiError, toast } from '@lib';
import { PenService } from '@services';
import type { PenShotView } from '@app-types';
import { mapPenShot } from './penVip';

export const PEN_SHOTS_PAGE = 10;
export const PEN_SHOTS_PAGE_MOBILE = 12;

interface PenState {
  shots: PenShotView[];
  loading: boolean;
  page: number;
  total: number;
  pageSize: number;
  loadShots: (page?: number) => Promise<void>;
  setPageSize: (size: number) => void;
}

export const usePenStore = create<PenState>((set, get) => ({
  shots: [],
  loading: true,
  page: 0,
  total: 0,
  pageSize: 0,
  loadShots: async (page) => {
    const target = page ?? get().page;
    const limit = get().pageSize || PEN_SHOTS_PAGE;
    set({ loading: true });
    try {
      const res = await PenService.listOpenShots({
        sort: 'newest',
        limit,
        offset: target * limit,
      });
      set({ shots: res.items.map(mapPenShot), total: res.total, page: target, loading: false });
    } catch (e) {
      set({ loading: false });
      toast.error(toApiError(e).message);
    }
  },
  setPageSize: (size) => {
    if (size <= 0 || size === get().pageSize) return;
    set({ pageSize: size });
    void get().loadShots(0);
  },
}));

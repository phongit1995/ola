import { create } from 'zustand';
import { PEN_SHOTS_PAGE_SIZE } from '../constants/pen';
import { toApiError } from '../lib/apiError';
import { toast } from '../lib/toast';
import { PenService } from '../services/pen.service';
import type { PenState } from '../types/client/pen.type';
import { mapPenShot } from './penVip';

export {
  PEN_SHOTS_MOBILE_PAGE_SIZE as PEN_SHOTS_PAGE_MOBILE,
  PEN_SHOTS_PAGE_SIZE as PEN_SHOTS_PAGE,
} from '../constants/pen';

export const usePenStore = create<PenState>((set, get) => ({
  shots: [],
  loading: true,
  page: 0,
  total: 0,
  pageSize: 0,
  loadShots: async (page) => {
    const target = page ?? get().page;
    const limit = get().pageSize || PEN_SHOTS_PAGE_SIZE;
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

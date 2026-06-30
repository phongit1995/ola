import { create } from 'zustand';
import { activeVipTypeId, toApiError, toast } from '@lib';
import { PenService } from '@services';
import type { PenShotView } from '@app-types';

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

function withShooterVip(shot: PenShotView): PenShotView {
  if (shot.shooter == null) return shot;
  return {
    ...shot,
    shooter: {
      ...shot.shooter,
      vipTypeId: activeVipTypeId(shot.shooter.vipUsed, shot.shooter.vipEndTime),
    },
  };
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
      set({ shots: res.items.map(withShooterVip), total: res.total, page: target, loading: false });
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

import { create } from 'zustand';
import { activeVipTypeId, toApiError, toast } from '@lib';
import { PenService } from '@services';
import type { PenShotView } from '@app-types';

interface PenState {
  shots: PenShotView[];
  loading: boolean;
  loadShots: () => Promise<void>;
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

export const usePenStore = create<PenState>((set) => ({
  shots: [],
  loading: true,
  loadShots: async () => {
    set({ loading: true });
    try {
      const res = await PenService.listOpenShots({ sort: 'newest', limit: 20 });
      set({ shots: res.items.map(withShooterVip), loading: false });
    } catch (e) {
      set({ loading: false });
      toast.error(toApiError(e).message);
    }
  },
}));

import { useEffect } from 'react';
import { create } from 'zustand';
import { isVipActive } from '../../lib/vip';
import type { MomentConfigState } from '../../types/client/moment.type';
import { loadAppConfig } from '../appConfigStore';
import { useAuthStore } from '../auth/authStore';

export const useMomentConfigStore = create<MomentConfigState>((set, get) => ({
  enabled: null,
  videoVipRequired: false,

  load: async () => {
    const config = await loadAppConfig('moment');
    if (config != null) {
      set({
        enabled: config.enabled,
        videoVipRequired: config.videoVipRequired === true,
      });
      return;
    }
    if (get().enabled == null) set({ enabled: true });
  },
}));

function useLoadMomentConfig() {
  const load = useMomentConfigStore((state) => state.load);

  useEffect(() => {
    void load();
  }, [load]);
}

export function useMomentEnabled(): boolean {
  useLoadMomentConfig();
  return useMomentConfigStore((state) => state.enabled) === true;
}

export function useMomentVideoLocked(): boolean {
  useLoadMomentConfig();
  const required = useMomentConfigStore((state) => state.videoVipRequired);
  const vipEndTime = useAuthStore((state) => state.user?.vipEndTime);
  return required && !isVipActive(vipEndTime);
}

import { create } from 'zustand';
import type { VipDayTransferConfigState } from '../../types/client/vipPurchase.type';
import { loadAppConfig, useAppConfigStore } from '../appConfigStore';

export const useVipDayTransferConfigStore = create<VipDayTransferConfigState>((set) => ({
  config: null,

  load: async () => {
    const config = await loadAppConfig('vipDayTransfer');
    set({ config });
  },

  refresh: async () => {
    const loaded = await useAppConfigStore.getState().load({ force: true });
    if (!loaded) return;
    set({ config: useAppConfigStore.getState().configs.vipDayTransfer ?? null });
  },
}));

export function selectVipDayTransferEnabled(state: VipDayTransferConfigState): boolean {
  return state.config?.enabled ?? false;
}

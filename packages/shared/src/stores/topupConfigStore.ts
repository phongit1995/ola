import { create } from 'zustand';
import { toApiError } from '../lib/apiError';
import { toast } from '../lib/toast';
import type { TopupConfigState } from '../types/client/settings.type';
import { loadAppConfig, useAppConfigStore } from './appConfigStore';

export const useTopupConfigStore = create<TopupConfigState>((set, get) => ({
  config: null,
  loading: false,

  load: async () => {
    if (get().loading) return;
    set({ loading: true });
    const config = await loadAppConfig('topup');
    if (config != null) {
      set({ config, loading: false });
      return;
    }
    set({ loading: false });
    if (get().config == null) toast.error(toApiError(useAppConfigStore.getState().error).message);
  },
}));

export function selectTopupEnabled(state: TopupConfigState): boolean {
  return state.config?.enabled ?? false;
}

export function selectTopupVisibleOnMobile(state: TopupConfigState): boolean {
  return state.config?.enabled === true && state.config?.enabledMobile === true;
}

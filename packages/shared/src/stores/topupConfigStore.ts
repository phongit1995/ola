import { create } from 'zustand';
import { toApiError } from '../lib/apiError';
import { toast } from '../lib/toast';
import { SettingsService } from '../services/settings.service';
import type { TopupConfigState } from '../types/client/settings.type';

export const useTopupConfigStore = create<TopupConfigState>((set, get) => ({
  config: null,
  loading: false,

  load: async () => {
    if (get().loading) return;
    set({ loading: true });
    try {
      const config = await SettingsService.topupConfig();
      set({ config, loading: false });
    } catch (error) {
      set({ loading: false });
      if (get().config == null) toast.error(toApiError(error).message);
    }
  },
}));

export function selectTopupEnabled(state: TopupConfigState): boolean {
  return state.config?.enabled ?? false;
}

export function selectTopupVisibleOnMobile(state: TopupConfigState): boolean {
  return state.config?.enabled === true && state.config?.enabledMobile === true;
}

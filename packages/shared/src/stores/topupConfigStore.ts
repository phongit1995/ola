import { create } from 'zustand';
import { toApiError, toast } from '../lib';
import { SettingsService } from '../services';
import type { TopupConfigResult } from '../types';

interface TopupConfigState {
  config: TopupConfigResult | null;
  loading: boolean;
  load: () => Promise<void>;
}

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

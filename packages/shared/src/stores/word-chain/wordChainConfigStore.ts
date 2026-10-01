import { create } from 'zustand';
import { SettingsService } from '../../services/settings.service';
import type { WordChainConfigState } from '../../types/client/wordChain.type';

export const useWordChainConfigStore = create<WordChainConfigState>((set) => ({
  enabled: false,

  load: async () => {
    const config = await SettingsService.wordChainConfig().catch(() => null);
    set({ enabled: config?.enabled ?? true });
  },

  markDisabled: () => set({ enabled: false }),
}));

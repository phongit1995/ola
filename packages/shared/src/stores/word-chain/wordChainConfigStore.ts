import { create } from 'zustand';
import { SettingsService } from '../../services/settings.service';
import type { WordChainConfigState } from '../../types/client/wordChain.type';

export const useWordChainConfigStore = create<WordChainConfigState>((set) => ({
  enabled: true,

  load: async () => {
    const config = await SettingsService.wordChainConfig().catch(() => null);
    if (config != null) set({ enabled: config.enabled });
  },

  markDisabled: () => set({ enabled: false }),
}));

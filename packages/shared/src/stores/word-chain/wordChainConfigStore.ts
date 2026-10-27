import { create } from 'zustand';
import type { WordChainConfigState } from '../../types/client/wordChain.type';
import { loadAppConfig } from '../appConfigStore';

export const useWordChainConfigStore = create<WordChainConfigState>((set) => ({
  enabled: false,

  load: async () => {
    const config = await loadAppConfig('wordChain');
    set({ enabled: config?.enabled ?? true });
  },

  markDisabled: () => set({ enabled: false }),
}));

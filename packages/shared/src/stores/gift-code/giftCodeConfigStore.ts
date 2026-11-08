import { create } from 'zustand';
import type { GiftCodeConfigState } from '../../types/client/giftCode.type';
import { loadAppConfig } from '../appConfigStore';

export const useGiftCodeConfigStore = create<GiftCodeConfigState>((set) => ({
  config: null,

  load: async () => {
    const config = await loadAppConfig('giftCode');
    if (config != null) set({ config });
  },
}));

export function selectGiftCodeEnabled(state: GiftCodeConfigState): boolean {
  return state.config?.enabled ?? false;
}

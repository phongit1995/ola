import { create } from 'zustand';
import { MEGAPHONE_SENDER_DISPLAY } from '../../constants/megaphone';
import type { MegaphoneSenderDisplay } from '../../types/api/megaphone.type';
import type { MegaphoneConfigState } from '../../types/client/megaphone.type';
import { loadAppConfig } from '../appConfigStore';

export const useMegaphoneConfigStore = create<MegaphoneConfigState>((set) => ({
  config: null,

  load: async () => {
    const config = await loadAppConfig('megaphone');
    if (config != null) set({ config });
  },
}));

export function selectMegaphoneEnabled(state: MegaphoneConfigState): boolean {
  return state.config?.enabled ?? true;
}

export function selectMegaphoneSenderDisplay(state: MegaphoneConfigState): MegaphoneSenderDisplay {
  return state.config?.senderDisplay ?? MEGAPHONE_SENDER_DISPLAY.vip;
}

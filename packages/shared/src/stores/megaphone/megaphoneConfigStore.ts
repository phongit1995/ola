import { create } from 'zustand';
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

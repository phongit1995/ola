import { create } from 'zustand';
import { MegaphoneService } from '../../services/megaphone.service';
import type { MegaphoneTicketState } from '../../types/client/megaphone.type';
import { registerOnLogout } from '../auth/authStore';

export const useMegaphoneTicketStore = create<MegaphoneTicketState>((set) => ({
  tickets: [],
  loaded: false,

  load: async () => {
    try {
      const { items } = await MegaphoneService.tickets();
      set({ tickets: items, loaded: true });
    } catch {
      set({ loaded: true });
    }
  },

  reset: () => set({ tickets: [], loaded: false }),
}));

export function selectMegaphoneTicketCount(state: MegaphoneTicketState): number {
  return state.tickets.length;
}

registerOnLogout(() => useMegaphoneTicketStore.getState().reset());

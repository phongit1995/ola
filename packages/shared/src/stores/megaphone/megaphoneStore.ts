import { create } from 'zustand';
import { pendingMegaphones, sortMegaphones } from '../../lib/megaphone';
import { MegaphoneService } from '../../services/megaphone.service';
import type { MegaphoneState } from '../../types/client/megaphone.type';
import { registerOnLogout } from '../auth/authStore';

function offsetFrom(serverTime: string | undefined, fallback: number): number {
  const parsed = serverTime != null ? Date.parse(serverTime) : NaN;
  return Number.isNaN(parsed) ? fallback : parsed - Date.now();
}

export const useMegaphoneStore = create<MegaphoneState>((set, get) => ({
  items: [],
  removedIds: {},
  clockOffset: 0,
  synced: false,
  receive: (megaphone, serverTime) => {
    const clockOffset = offsetFrom(serverTime, get().clockOffset);
    const others = get().items.filter((item) => item.id !== megaphone.id);
    set({
      clockOffset,
      items: sortMegaphones(pendingMegaphones([...others, megaphone], Date.now() + clockOffset)),
    });
  },
  remove: (id) => {
    const { items, removedIds } = get();
    set({ items: items.filter((item) => item.id !== id), removedIds: { ...removedIds, [id]: true } });
  },
  sync: async () => {
    try {
      const result = await MegaphoneService.active();
      const clockOffset = offsetFrom(result.serverTime, get().clockOffset);
      set({
        clockOffset,
        synced: true,
        items: sortMegaphones(pendingMegaphones(result.items, Date.now() + clockOffset)),
      });
    } catch {
      set({ synced: true });
    }
  },
  reset: () => set({ items: [], removedIds: {}, clockOffset: 0, synced: false }),
}));

registerOnLogout(() => useMegaphoneStore.getState().reset());

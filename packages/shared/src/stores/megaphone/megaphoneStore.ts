import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { activeSeenIds, megaphoneExpiresAtMs } from '../../lib/megaphone';
import { sharedPersistStorage } from '../../platform/persistStorage';
import type { MegaphoneState, PersistedMegaphoneState } from '../../types/client/megaphone.type';
import { registerOnLogout } from '../auth/authStore';
import { useRoomFilterStore } from '../room/roomFilterStore';
import { selectMegaphoneEnabled, useMegaphoneConfigStore } from './megaphoneConfigStore';

export const useMegaphoneStore = create<MegaphoneState>()(
  persist(
    (set, get) => ({
      current: null,
      removedIds: {},
      seenIds: {},
      play: (megaphone) => {
        if (!selectMegaphoneEnabled(useMegaphoneConfigStore.getState())) return;
        const { seenIds, removedIds } = get();
        if (seenIds[megaphone.id] != null || removedIds[megaphone.id] != null) return;
        if (useRoomFilterStore.getState().blockedUserIds.includes(megaphone.sender.id)) return;
        set({ current: megaphone });
      },
      stop: (id) => {
        if (get().current?.id === id) set({ current: null });
      },
      markSeen: (id) => {
        const { current, seenIds } = get();
        if (current?.id !== id) return;
        set({
          current: null,
          seenIds: { ...activeSeenIds(seenIds, Date.now()), [id]: megaphoneExpiresAtMs(current) },
        });
      },
      remove: (id) => {
        const { current, removedIds } = get();
        set({ current: current?.id === id ? null : current, removedIds: { ...removedIds, [id]: true } });
      },
      reset: () => set({ current: null, removedIds: {} }),
    }),
    {
      name: 'ola.megaphone',
      storage: sharedPersistStorage<PersistedMegaphoneState>(),
      partialize: (state) => ({ seenIds: state.seenIds }),
    }
  )
);

registerOnLogout(() => useMegaphoneStore.getState().reset());

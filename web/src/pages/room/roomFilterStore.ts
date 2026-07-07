import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { DEFAULT_ROOM_FILTERS } from '@/pages/room/data';
import type { RoomFilters } from '@/pages/room/types';

const MAX_BLOCKED_USERS = 500;

interface RoomFilterState {
  filters: RoomFilters;
  blockedUserIds: string[];
  setFilters: (filters: RoomFilters) => void;
  blockUser: (userId: string) => void;
  unblockUser: (userId: string) => void;
  isBlocked: (userId: string) => boolean;
}

export const useRoomFilterStore = create<RoomFilterState>()(
  persist(
    (set, get) => ({
      filters: DEFAULT_ROOM_FILTERS,
      blockedUserIds: [],
      setFilters: (filters) => set({ filters }),
      blockUser: (userId) =>
        set((state) =>
          state.blockedUserIds.includes(userId)
            ? state
            : { blockedUserIds: [...state.blockedUserIds, userId].slice(-MAX_BLOCKED_USERS) }
        ),
      unblockUser: (userId) =>
        set((state) => ({
          blockedUserIds: state.blockedUserIds.filter((id) => id !== userId),
        })),
      isBlocked: (userId) => get().blockedUserIds.includes(userId),
    }),
    {
      name: 'ola.roomFilter',
      partialize: (state) => ({ filters: state.filters, blockedUserIds: state.blockedUserIds }),
    }
  )
);

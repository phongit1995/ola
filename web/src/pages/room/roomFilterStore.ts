import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { DEFAULT_ROOM_FILTERS } from '@/pages/room/data';
import type { RoomFilters } from '@/pages/room/types';

interface RoomFilterState {
  filters: RoomFilters;
  setFilters: (filters: RoomFilters) => void;
}

export const useRoomFilterStore = create<RoomFilterState>()(
  persist(
    (set) => ({
      filters: DEFAULT_ROOM_FILTERS,
      setFilters: (filters) => set({ filters }),
    }),
    { name: 'ola.roomFilter' }
  )
);

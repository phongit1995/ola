import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { sharedPersistStorage } from '../platform/persistStorage';
import type { RoomFilters, RoomMember } from '../types';

export const DEFAULT_ROOM_FILTERS: RoomFilters = {
  showAll: true,
  media: false,
  female: false,
  male: false,
  flexible: false,
};

export function memberMatchesFilter(member: RoomMember, filters: RoomFilters): boolean {
  if (filters.showAll) return true;
  const anyGender = filters.female || filters.male || filters.flexible;
  if (!anyGender) return true;
  if (filters.female && member.gender === 'female') return true;
  if (filters.male && member.gender === 'male') return true;
  if (filters.flexible && member.gender !== 'female' && member.gender !== 'male') return true;
  return false;
}

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
    { name: 'ola.roomFilter', storage: sharedPersistStorage<RoomFilterState>() }
  )
);

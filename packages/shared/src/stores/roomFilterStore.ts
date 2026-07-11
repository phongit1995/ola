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
    { name: 'ola.roomFilter', storage: sharedPersistStorage<RoomFilterState>() }
  )
);

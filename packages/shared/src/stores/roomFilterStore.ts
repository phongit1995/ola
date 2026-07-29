import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import {
  DEFAULT_ROOM_FILTERS,
  ROOM_MAX_BLOCKED_USERS,
} from '../constants/room';
import { sharedPersistStorage } from '../platform/persistStorage';
import type { RoomFilters, RoomMember } from '../types/api/room.type';
import type { RoomFilterState } from '../types/client/room.type';

export { DEFAULT_ROOM_FILTERS } from '../constants/room';

export function memberMatchesFilter(member: RoomMember, filters: RoomFilters): boolean {
  if (filters.showAll) return true;
  const anyGender = filters.female || filters.male || filters.flexible;
  if (!anyGender) return true;
  if (filters.female && member.gender === 'female') return true;
  if (filters.male && member.gender === 'male') return true;
  if (filters.flexible && member.gender !== 'female' && member.gender !== 'male') return true;
  return false;
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
            : {
                blockedUserIds: [...state.blockedUserIds, userId].slice(
                  -ROOM_MAX_BLOCKED_USERS
                ),
              }
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

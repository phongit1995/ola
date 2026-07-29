import type { BrowseRoomsParams, Room, RoomFilters } from '../api/room.type';

export interface RoomFilterState {
  filters: RoomFilters;
  blockedUserIds: string[];
  setFilters: (filters: RoomFilters) => void;
  blockUser: (userId: string) => void;
  unblockUser: (userId: string) => void;
  isBlocked: (userId: string) => boolean;
}

export interface RoomListState {
  rooms: Room[];
  total: number;
  loading: boolean;
  error: string | null;
  loaded: boolean;
  fetchRooms: (
    params?: BrowseRoomsParams,
    options?: { silent?: boolean }
  ) => Promise<void>;
  reset: () => void;
}

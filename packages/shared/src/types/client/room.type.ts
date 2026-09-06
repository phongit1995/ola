import type { BrowseRoomsParams, Room, RoomFilters } from '../api/room.type';

export interface RoomFilterState {
  filters: RoomFilters;
  blockedUserIds: string[];
  blockedOwnerId: string | null;
  pendingBlockUploads: Record<string, string[]>;
  migratedBlockOwnerIds: string[];
  setFilters: (filters: RoomFilters) => void;
  blockUser: (userId: string) => Promise<void>;
  unblockUser: (userId: string) => Promise<void>;
  syncBlockedUsers: () => Promise<void>;
  resetBlockedUsers: () => void;
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

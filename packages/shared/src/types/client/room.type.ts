import type {
  BrowseRoomsParams,
  Room,
  RoomBlockedUser,
  RoomFilters,
} from '../api/room.type';

export interface RoomFilterState {
  filters: RoomFilters;
  blockedUserIds: string[];
  blockedUsers: Record<string, RoomBlockedUser>;
  blockedOwnerId: string | null;
  pendingBlockUploads: Record<string, string[]>;
  pendingMigrationUploads: Record<string, string[]>;
  migratedBlockOwnerIds: string[];
  setFilters: (filters: RoomFilters) => void;
  blockUser: (userId: string, detail?: RoomBlockedUser) => Promise<void>;
  unblockUser: (userId: string) => Promise<void>;
  syncBlockedUsers: () => Promise<boolean>;
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

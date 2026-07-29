import type { RoomFilters } from '../types/api/room.type';

export const DEFAULT_ROOM_FILTERS: RoomFilters = {
  showAll: true,
  media: false,
  female: false,
  male: false,
  flexible: false,
};

export const ROOM_MAX_BLOCKED_USERS = 500;
export const ROOM_MESSAGE_PAGE_SIZE = 50;
export const ROOM_JOIN_ACK_TIMEOUT_MS = 10_000;
export const ROOM_MESSAGE_GROUP_GAP_MS = 5 * 60 * 1_000;

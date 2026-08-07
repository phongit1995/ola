import type { RoomListState } from '../../types/client/room.type';

export const initialRoomListState: Pick<
  RoomListState,
  'rooms' | 'total' | 'loading' | 'error' | 'loaded'
> = {
  rooms: [],
  total: 0,
  loading: false,
  error: null,
  loaded: false,
};

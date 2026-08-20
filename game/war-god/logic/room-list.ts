import type { RoomInfo } from '../../src/sdk';

export type RoomListState = 'open' | 'full' | 'playing';

export function roomListState(room: RoomInfo): RoomListState {
  if (room.status === 'playing') return 'playing';
  if (room.full === true || room.players >= 2) return 'full';
  return 'open';
}

export function canJoinListedRoom(room: RoomInfo): boolean {
  return roomListState(room) === 'open';
}

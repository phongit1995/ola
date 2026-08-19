import { describe, expect, it } from 'vitest';
import type { RoomInfo } from '../../src/sdk';
import { canJoinListedRoom, roomListState } from './room-list';

function room(overrides: Partial<RoomInfo> = {}): RoomInfo {
  return {
    id: 'room-1',
    owner: 'owner',
    bet: 0,
    locked: false,
    players: 1,
    ...overrides,
  };
}

describe('War God room list state', () => {
  it('allows joining only an open waiting room', () => {
    expect(roomListState(room())).toBe('open');
    expect(canJoinListedRoom(room())).toBe(true);
  });

  it('keeps a full waiting room distinct from a playing room', () => {
    const full = room({ players: 2, full: true });
    const playing = room({ players: 2, full: true, status: 'playing' });

    expect(roomListState(full)).toBe('full');
    expect(roomListState(playing)).toBe('playing');
    expect(canJoinListedRoom(full)).toBe(false);
    expect(canJoinListedRoom(playing)).toBe(false);
  });

  it('never joins a playing room even if its player count is stale', () => {
    const playing = room({ players: 1, full: false, status: 'playing' });

    expect(roomListState(playing)).toBe('playing');
    expect(canJoinListedRoom(playing)).toBe(false);
  });
});

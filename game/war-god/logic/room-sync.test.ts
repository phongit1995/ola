import { describe, expect, it } from 'vitest';
import { shouldResetRoomFromSync } from './room-sync';

describe('shouldResetRoomFromSync', () => {
  it('clears stale waiting-room membership', () => {
    expect(shouldResetRoomFromSync('room-1', false, undefined)).toBe(true);
    expect(shouldResetRoomFromSync('room-1', false, 'room-2')).toBe(true);
  });

  it('keeps confirmed membership and active-match state', () => {
    expect(shouldResetRoomFromSync('room-1', false, 'room-1')).toBe(false);
    expect(shouldResetRoomFromSync('room-1', true, undefined)).toBe(false);
    expect(shouldResetRoomFromSync('', false, undefined)).toBe(false);
  });
});

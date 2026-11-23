import { describe, expect, it } from 'vitest';
import { canCloseSeat, formatBetInput, formatKen, parseBetInput, roomCreationError, roomSeatSlots } from './room';

describe('room betting helpers', () => {
  it('keeps the default wager at zero Ken', () => {
    expect(formatBetInput('')).toBe('0');
    expect(parseBetInput('0')).toBe(0);
    expect(roomCreationError(0, '', 0, 0)).toBeNull();
  });

  it('formats and parses a Vietnamese Ken amount', () => {
    expect(formatBetInput('1000000')).toBe('1.000.000');
    expect(parseBetInput('1.000.000')).toBe(1_000_000);
    expect(formatKen(9_957_000)).toBe('9.957.000');
  });

  it('rejects wagers above the balance or server maximum', () => {
    expect(roomCreationError(501, '', 500, 1_000)).toBe('Bạn không đủ Ken để tạo bàn');
    expect(roomCreationError(1_001, '', 2_000, 1_000)).toBe('Số Ken cược không hợp lệ');
  });
});

describe('room seat slots', () => {
  const kinds = (memberCount: number, maxPlayers?: number) => roomSeatSlots(memberCount, maxPlayers).map((slot) => slot.kind);

  it('always shows four slots and closes the ones past the room size', () => {
    expect(kinds(1, 4)).toEqual(['member', 'open', 'open', 'open']);
    expect(kinds(2, 3)).toEqual(['member', 'member', 'open', 'closed']);
    expect(kinds(2, 2)).toEqual(['member', 'member', 'closed', 'closed']);
    expect(kinds(1)).toEqual(['member', 'open', 'open', 'open']);
  });

  it('never hides a seated player behind a closed slot', () => {
    expect(kinds(3, 2)).toEqual(['member', 'member', 'member', 'closed']);
  });

  it('only closes seats that are empty and above the minimum', () => {
    expect(canCloseSeat(1, 4)).toBe(true);
    expect(canCloseSeat(3, 3)).toBe(false);
    expect(canCloseSeat(1, 2)).toBe(false);
  });
});

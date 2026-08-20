import { describe, expect, it } from 'vitest';
import { formatBetInput, formatKen, parseBetInput, roomCreationError } from './room';

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

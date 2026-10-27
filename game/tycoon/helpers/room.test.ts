import { describe, expect, it } from 'vitest';
import {
  BET_INVALID_TEXT,
  BET_OVER_BALANCE_TEXT,
  PASSWORD_REQUIRED_TEXT,
  PASSWORD_TOO_LONG_TEXT,
  createRoomError,
  formatBetInput,
  pageCount,
  parseBetInput,
  roomAction,
  roomBetLabel,
  type CreateRoomInput,
  type TycoonRoom,
} from './room';

const room = (patch: Partial<TycoonRoom>): TycoonRoom => ({ id: 'r', owner: 'a', bet: 0, locked: false, players: 1, maxPlayers: 4, status: 'waiting', ...patch });
const input = (patch: Partial<CreateRoomInput>): CreateRoomInput => ({ maxPlayers: 4, bet: 0, password: '', allowSpectators: false, ...patch });

describe('roomAction', () => {
  it('maps waiting and playing rooms to the last column', () => {
    expect(roomAction(room({ players: 2 }))).toBe('join');
    expect(roomAction(room({ players: 4 }))).toBe('full');
    expect(roomAction(room({ players: 1, full: true }))).toBe('full');
    expect(roomAction(room({ status: 'playing', allowSpectators: true }))).toBe('watch');
    expect(roomAction(room({ status: 'playing' }))).toBe('playing');
  });
});

describe('bet input', () => {
  it('keeps digits with thousand dots and treats empty as zero', () => {
    expect(formatBetInput('1000')).toBe('1.000');
    expect(formatBetInput('00250')).toBe('250');
    expect(formatBetInput('1.2a3')).toBe('123');
    expect(formatBetInput('')).toBe('');
    expect(parseBetInput('12.500')).toBe(12_500);
    expect(parseBetInput('')).toBe(0);
  });

  it('labels free tables', () => {
    expect(roomBetLabel(0)).toBe('Giao lưu');
    expect(roomBetLabel(1_000)).toBe('1.000 KEN');
  });
});

describe('createRoomError', () => {
  it('checks bet before password and stops at the first error', () => {
    expect(createRoomError(input({ bet: 200_000 }), true, 500_000, 100_000)).toEqual({ field: 'bet', text: BET_INVALID_TEXT });
    expect(createRoomError(input({ bet: 600 }), true, 500, null)).toEqual({ field: 'bet', text: BET_OVER_BALANCE_TEXT });
    expect(createRoomError(input({ bet: 500 }), true, 500, null)).toEqual({ field: 'password', text: PASSWORD_REQUIRED_TEXT });
    expect(createRoomError(input({ password: 'x'.repeat(65) }), true, 0, null)).toEqual({ field: 'password', text: PASSWORD_TOO_LONG_TEXT });
    expect(createRoomError(input({}), false, 0, null)).toBeNull();
  });
});

describe('pageCount', () => {
  it('always has one page', () => {
    expect(pageCount(0)).toBe(1);
    expect(pageCount(9)).toBe(1);
    expect(pageCount(10)).toBe(2);
  });
});

import { describe, expect, it } from 'vitest';
import type { MatchHistoryEntry } from '../../src/sdk';
import {
  formatPlayedAt,
  formatSignedKen,
  historyKenDelta,
  historyPlace,
  historyPlayerCount,
  historyTablemates,
  leaderboardGames,
  periodCaption,
} from './history';

const base: MatchHistoryEntry = {
  id: 'm1',
  playedAt: 0,
  opponentId: 'b',
  opponentName: 'ban_b',
  bet: 0,
  outcome: 'lose',
  kenDelta: 0,
};

describe('historyPlace', () => {
  it('labels places by table size', () => {
    expect(historyPlace({ ...base, outcome: 'win', place: 1, playerCount: 4 })).toEqual({ place: 1, label: 'Nhất', tone: 'gold' });
    expect(historyPlace({ ...base, place: 2, playerCount: 4 })).toEqual({ place: 2, label: 'Nhì', tone: 'silver' });
    expect(historyPlace({ ...base, place: 3, playerCount: 4 })).toEqual({ place: 3, label: 'Ba', tone: 'bronze' });
    expect(historyPlace({ ...base, place: 3, playerCount: 3 })).toEqual({ place: 3, label: 'Bét', tone: 'last' });
    expect(historyPlace({ ...base, place: 2, playerCount: 2 })).toEqual({ place: 2, label: 'Bét', tone: 'last' });
  });

  it('falls back to the outcome when the server sent no place', () => {
    expect(historyPlace({ ...base, outcome: 'win' })).toEqual({ place: 1, label: 'Nhất', tone: 'gold' });
    expect(historyPlace({ ...base, outcome: 'lose', playerCount: 4 })).toEqual({ place: null, label: 'Thua', tone: 'last' });
    expect(historyPlace({ ...base, outcome: 'draw' })).toEqual({ place: null, label: 'Hòa', tone: 'plain' });
  });
});

describe('historyTablemates', () => {
  it('lists everyone except me in the order the server ranked them', () => {
    const entry: MatchHistoryEntry = {
      ...base,
      playerCount: 3,
      players: [
        { userId: 'b', username: 'ban_b', place: 1 },
        { userId: 'me', username: 'toi', place: 2 },
        { userId: 'c', username: 'ban_c', place: 3 },
      ],
    };
    expect(historyTablemates(entry, 'me').map((p) => p.userId)).toEqual(['b', 'c']);
    expect(historyPlayerCount(entry)).toBe(3);
  });

  it('uses the single opponent from an older server', () => {
    expect(historyTablemates({ ...base, outcome: 'lose' }, 'me')).toEqual([
      { userId: 'b', username: 'ban_b', vipType: undefined, place: 1 },
    ]);
    expect(historyPlayerCount(base)).toBe(2);
  });
});

describe('ken formatting', () => {
  it('signs deltas with a real minus sign', () => {
    expect(formatSignedKen(28_500)).toBe('+28.500');
    expect(formatSignedKen(-10_000)).toBe('−10.000');
    expect(formatSignedKen(0)).toBe('0');
  });

  it('derives a missing delta from the outcome', () => {
    expect(historyKenDelta({ ...base, bet: 5_000, kenDelta: Number.NaN })).toBe(-5_000);
    expect(historyKenDelta({ ...base, outcome: 'win', bet: 5_000, kenDelta: 9_500 })).toBe(9_500);
  });
});

describe('formatPlayedAt', () => {
  const now = new Date(2026, 9, 31, 20, 0).getTime();

  it('names today and yesterday', () => {
    expect(formatPlayedAt(new Date(2026, 9, 31, 14, 5).getTime(), now)).toBe('14:05 · Hôm nay');
    expect(formatPlayedAt(new Date(2026, 9, 30, 23, 59).getTime(), now)).toBe('23:59 · Hôm qua');
  });

  it('shows the date for older matches and the year when it differs', () => {
    expect(formatPlayedAt(new Date(2026, 9, 28, 9, 0).getTime(), now)).toBe('09:00 · 28/10');
    expect(formatPlayedAt(new Date(2025, 11, 31, 9, 0).getTime(), now)).toBe('09:00 · 31/12/2025');
  });
});

describe('leaderboard helpers', () => {
  it('counts games from wins and losses', () => {
    expect(leaderboardGames({ rank: 1, userId: 'a', username: 'a', ken: 0, wins: 5, losses: 7 })).toBe(12);
    expect(leaderboardGames({ rank: 1, userId: 'a', username: 'a', ken: 0 })).toBe(0);
  });

  it('captions each period from its GMT+7 start', () => {
    expect(periodCaption('day', 0)).toBe('Tính từ 0h hôm nay');
    expect(periodCaption('week', Date.UTC(2026, 9, 25, 17))).toBe('Tính từ thứ Hai 26/10');
    expect(periodCaption('month', Date.UTC(2026, 8, 30, 17))).toBe('Tính từ 01/10');
    expect(periodCaption('month', 0)).toBe('');
  });
});

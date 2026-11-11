import { describe, expect, it } from 'vitest';
import { LEADERBOARD_TABS, leaderboardFromServer, leaderboardMatchesTab, pinnedMe, tabConfig, type LeaderboardResult, type LeaderboardRow } from './leaderboard';

const row = (rank: number, userId: string): LeaderboardRow => ({ rank, userId, username: userId, vipType: null, level: 1, wins: 1, matches: 1 });

describe('leaderboard helpers', () => {
  it('has three tabs with win tabs before level', () => {
    expect(LEADERBOARD_TABS.map((tab) => tab.id)).toEqual(['day', 'week', 'level']);
    expect(tabConfig('level').stats).toEqual(['Cấp', 'EXP']);
  });

  it('does not pin when the user is already in the list', () => {
    const result: LeaderboardResult = { tab: 'day', items: [row(1, 'a'), row(2, 'me')], me: row(2, 'me') };
    expect(pinnedMe(result, 'me')).toBeUndefined();
  });

  it('pins the server row when the user is outside the list', () => {
    const me = row(128, 'me');
    expect(pinnedMe({ tab: 'level', items: [row(1, 'a')], me }, 'me')).toBe(me);
  });

  it('returns null when the user is outside the list and the server has no row', () => {
    expect(pinnedMe({ tab: 'week', items: [row(1, 'a')], me: null }, 'me')).toBeNull();
  });

  it('does not pin without a user id', () => {
    expect(pinnedMe({ tab: 'day', items: [], me: null }, undefined)).toBeUndefined();
  });
});

describe('leaderboardFromServer', () => {
  it('maps the level board with exp and the server me row', () => {
    const result = leaderboardFromServer(
      'level',
      {
        period: 'week',
        board: 'level',
        from: 0,
        to: 0,
        items: [{ rank: 1, userId: 'a', username: 'a', ken: 0, level: 4, exp: 900 }],
        me: { rank: 37, userId: 'me', username: 'me', ken: 0, level: 2, exp: 120 },
      },
      'me',
    );
    expect(result.items[0]).toMatchObject({ exp: 900, level: 4 });
    expect(result.items[0].wins).toBeUndefined();
    expect(result.me).toMatchObject({ rank: 37, exp: 120 });
  });

  it('counts matches on the wins board and finds me in the list', () => {
    const result = leaderboardFromServer('day', { period: 'day', board: 'wins', from: 0, to: 0, items: [{ rank: 1, userId: 'me', username: 'me', ken: 0, wins: 2, losses: 3 }] }, 'me');
    expect(result.items[0]).toMatchObject({ wins: 2, matches: 5 });
    expect(result.me?.rank).toBe(1);
  });

  it('only accepts responses for the requested board', () => {
    const wins = { period: 'week' as const, from: 0, to: 0, items: [] };
    expect(leaderboardMatchesTab('week', wins)).toBe(true);
    expect(leaderboardMatchesTab('level', wins)).toBe(false);
    expect(leaderboardMatchesTab('level', { ...wins, board: 'level' })).toBe(true);
    expect(leaderboardMatchesTab('week', { ...wins, board: 'level' })).toBe(false);
  });
});

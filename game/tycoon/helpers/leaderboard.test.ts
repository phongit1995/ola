import { describe, expect, it } from 'vitest';
import { LEADERBOARD_TABS, pinnedMe, tabConfig, type LeaderboardResult, type LeaderboardRow } from './leaderboard';

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

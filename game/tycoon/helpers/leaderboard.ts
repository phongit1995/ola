import type { LeaderboardData, LeaderboardEntry } from '../../src/sdk';

export type LeaderboardTab = 'day' | 'week' | 'level';
export type LeaderboardStatus = 'idle' | 'loading' | 'ready' | 'error';

export interface LeaderboardRow {
  rank: number;
  userId: string;
  username: string;
  vipType: string | null;
  level: number;
  wins?: number;
  matches?: number;
  exp?: number;
}

export interface LeaderboardResult {
  tab: LeaderboardTab;
  items: LeaderboardRow[];
  me: LeaderboardRow | null;
}

export interface LeaderboardTabConfig {
  id: LeaderboardTab;
  label: string;
  hint: string;
  stats: [string, string];
  empty: string;
}

export const LEADERBOARD_LIMIT = 100;
export const LEADERBOARD_CACHE_MS = 60_000;
export const LEADERBOARD_ERROR_TEXT = 'Không tải được bảng xếp hạng';

export const LEADERBOARD_TABS: LeaderboardTabConfig[] = [
  { id: 'day', label: 'Hôm nay', hint: 'Thắng = về hạng 1', stats: ['Thắng', 'Trận'], empty: 'Chưa có ai thắng hôm nay' },
  { id: 'week', label: 'Tuần này', hint: 'Thắng = về hạng 1 · từ thứ Hai', stats: ['Thắng', 'Trận'], empty: 'Chưa có ai thắng tuần này' },
  { id: 'level', label: 'Cấp độ', hint: 'Cấp theo EXP tích lũy của Cờ Tỷ Phú', stats: ['Cấp', 'EXP'], empty: 'Chưa có ai lên cấp' },
];

export function tabConfig(tab: LeaderboardTab): LeaderboardTabConfig {
  return LEADERBOARD_TABS.find((item) => item.id === tab) ?? LEADERBOARD_TABS[0];
}

export function lvLabel(level: number): string {
  return `Lv ${level}`;
}

export function pinnedMe(result: LeaderboardResult, userId: string | undefined): LeaderboardRow | null | undefined {
  if (!userId || result.items.some((row) => row.userId === userId)) return undefined;
  return result.me;
}

export function leaderboardFromServer(tab: LeaderboardTab, data: LeaderboardData, meId: string | undefined): LeaderboardResult {
  const toRow = (item: LeaderboardEntry): LeaderboardRow => ({
    rank: item.rank,
    userId: item.userId,
    username: item.username,
    vipType: item.vipType ?? null,
    level: item.level ?? 1,
    ...(tab === 'level' ? { exp: item.exp ?? 0 } : { wins: item.wins ?? 0, matches: item.matches ?? (item.wins ?? 0) + (item.losses ?? 0) }),
  });
  const rows = (data.items ?? []).slice(0, LEADERBOARD_LIMIT).map(toRow);
  const me = data.me ? toRow(data.me) : (rows.find((row) => row.userId === meId) ?? null);
  return { tab, items: rows, me };
}

export function leaderboardMatchesTab(tab: LeaderboardTab, data: LeaderboardData): boolean {
  if (tab === 'level') return data.board === 'level';
  return data.period === tab && (data.board ?? 'wins') === 'wins';
}

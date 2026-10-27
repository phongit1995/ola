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

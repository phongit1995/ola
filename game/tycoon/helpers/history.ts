import { END_REASONS, MAX_ROUNDS, STATION_RENT, TIME_LIMIT_MS, WIN_GROUPS, type EndReason } from '../logic/constants';
import type { BotLevel, GameState } from '../logic/types';
import { botName, type BotSetupItem } from './bot';
import { formatKen } from './format';
import { placeLabel } from './player';
import type { LobbyProfile } from './profile';

export type HistorySource = 'online' | 'bot';
export type HistoryExitReason = 'bankrupt' | 'forfeit' | 'timeout' | 'disconnect';
export type HistoryStatus = 'loading' | 'ready' | 'error' | 'offline';

export interface HistoryPlayer {
  userId: string;
  username: string;
  vipType: string | null;
  place: number;
  kenDelta: number;
  exitReason: HistoryExitReason | null;
  bot?: boolean;
  level?: BotLevel;
}

export interface HistoryEntry {
  id: string;
  playedAt: number;
  source: HistorySource;
  place: number;
  playerCount: number;
  endReason: EndReason | null;
  exitReason: HistoryExitReason | null;
  bet: number;
  kenDelta: number;
  players: HistoryPlayer[];
}

export interface HistorySummary {
  played: number;
  firstPlaces: number;
  ken: number;
}

export const HISTORY_LIMIT = 100;
export const BOT_HISTORY_LIMIT = 50;
export const HISTORY_ONLINE_ERROR = 'Không tải được ván online';
export const HISTORY_OFFLINE = 'Đang offline — chỉ hiện ván với máy';

const STORAGE_PREFIX = 'ola:tycoon:bot-history:v1:';
const AIRPORTS = STATION_RENT.length - 1;
const EXIT_REASONS: HistoryExitReason[] = ['bankrupt', 'forfeit', 'timeout', 'disconnect'];
const BOT_LEVELS: BotLevel[] = ['easy', 'normal', 'hard'];

const END_TEXT: Record<EndReason, string> = {
  groups: `Thắng ngay · ${WIN_GROUPS} nhóm màu`,
  line: 'Thắng ngay · một cạnh bàn',
  airports: `Thắng ngay · ${AIRPORTS} sân bay`,
  last: 'Còn 1 người',
  rounds: `Hết ${MAX_ROUNDS} vòng`,
  time: `Hết ${TIME_LIMIT_MS / 60000} phút`,
};

export function exitLabel(reason: HistoryExitReason | null): string | null {
  if (!reason) return null;
  return reason === 'bankrupt' ? 'Phá sản' : 'Bỏ cuộc';
}

export function historyTitle(entry: HistoryEntry): string {
  return exitLabel(entry.exitReason) ?? placeLabel(entry.place, entry.playerCount);
}

export function historyReason(entry: HistoryEntry): string {
  const people = `${entry.playerCount} người`;
  return entry.endReason ? `${END_TEXT[entry.endReason]} · ${people}` : people;
}

export function formatKenDelta(value: number, bet: number): string {
  if (bet <= 0) return '—';
  if (value === 0) return '0';
  return `${value > 0 ? '+' : '−'}${formatKen(Math.abs(value))}`;
}

export function kenTone(value: number, bet: number): 'plus' | 'minus' | 'none' {
  if (bet <= 0 || value === 0) return 'none';
  return value > 0 ? 'plus' : 'minus';
}

export function entryKen(entry: HistoryEntry): { text: string; tone: 'plus' | 'minus' | 'none' | 'free' } {
  if (entry.source === 'online' && entry.bet <= 0) return { text: 'Giao lưu', tone: 'free' };
  return { text: formatKenDelta(entry.kenDelta, entry.bet), tone: kenTone(entry.kenDelta, entry.bet) };
}

export function summarize(entries: readonly HistoryEntry[]): HistorySummary {
  return entries.reduce<HistorySummary>(
    (sum, entry) => ({
      played: sum.played + 1,
      firstPlaces: sum.firstPlaces + (entry.place === 1 ? 1 : 0),
      ken: sum.ken + (entry.source === 'online' ? entry.kenDelta : 0),
    }),
    { played: 0, firstPlaces: 0, ken: 0 },
  );
}

export function formatSummaryKen(value: number): string {
  if (value === 0) return '0';
  return `${value > 0 ? '+' : '−'}${formatKen(Math.abs(value))}`;
}

export function mergeHistory(...groups: ReadonlyArray<readonly HistoryEntry[]>): HistoryEntry[] {
  const byId = new Map<string, HistoryEntry>();
  groups.flat().forEach((entry) => {
    if (!byId.has(entry.id)) byId.set(entry.id, entry);
  });
  return [...byId.values()].sort((a, b) => b.playedAt - a.playedAt || b.id.localeCompare(a.id)).slice(0, HISTORY_LIMIT);
}

function isExit(value: unknown): value is HistoryExitReason | null {
  return value === null || EXIT_REASONS.includes(value as HistoryExitReason);
}

function isPlayer(value: unknown): value is HistoryPlayer {
  if (value == null || typeof value !== 'object') return false;
  const player = value as Partial<HistoryPlayer>;
  return (
    typeof player.userId === 'string' &&
    typeof player.username === 'string' &&
    player.username.length > 0 &&
    player.username.length <= 80 &&
    (player.vipType === null || typeof player.vipType === 'string') &&
    Number.isInteger(player.place) &&
    typeof player.kenDelta === 'number' &&
    isExit(player.exitReason) &&
    (player.level === undefined || BOT_LEVELS.includes(player.level))
  );
}

function isBotEntry(value: unknown): value is HistoryEntry {
  if (value == null || typeof value !== 'object') return false;
  const entry = value as Partial<HistoryEntry>;
  return (
    typeof entry.id === 'string' &&
    entry.id.startsWith('bot-') &&
    typeof entry.playedAt === 'number' &&
    Number.isFinite(entry.playedAt) &&
    entry.source === 'bot' &&
    Number.isInteger(entry.place) &&
    Number.isInteger(entry.playerCount) &&
    (entry.endReason === null || END_REASONS.includes(entry.endReason as EndReason)) &&
    isExit(entry.exitReason) &&
    entry.bet === 0 &&
    entry.kenDelta === 0 &&
    Array.isArray(entry.players) &&
    entry.players.length === entry.playerCount &&
    entry.players.every(isPlayer)
  );
}

export function readBotHistory(userId: string): HistoryEntry[] {
  if (!userId) return [];
  try {
    const parsed: unknown = JSON.parse(window.localStorage.getItem(STORAGE_PREFIX + userId) ?? '[]');
    if (!Array.isArray(parsed)) return [];
    return parsed.filter(isBotEntry).slice(0, BOT_HISTORY_LIMIT);
  } catch {
    return [];
  }
}

export function saveBotHistory(userId: string, entry: HistoryEntry): void {
  if (!userId) return;
  try {
    const entries = mergeHistory([entry], readBotHistory(userId)).slice(0, BOT_HISTORY_LIMIT);
    window.localStorage.setItem(STORAGE_PREFIX + userId, JSON.stringify(entries));
  } catch {
    return;
  }
}

export function botHistoryEntry(
  state: GameState,
  ranked: readonly number[],
  you: number,
  me: Pick<LobbyProfile, 'id' | 'username' | 'vipType'>,
  bots: readonly BotSetupItem[],
  playedAt: number,
): HistoryEntry {
  const exit = (seat: number): HistoryExitReason | null =>
    state.players[seat].quit ? 'forfeit' : state.players[seat].bankrupt ? 'bankrupt' : null;
  const players = ranked.map((seat, index): HistoryPlayer => {
    const base = { place: index + 1, kenDelta: 0, exitReason: exit(seat) };
    if (seat === you) return { ...base, userId: me.id, username: me.username, vipType: me.vipType };
    const botIndex = seat > you ? seat - 1 : seat;
    const bot = bots[botIndex];
    return {
      ...base,
      userId: `bot-${bot?.id ?? seat}`,
      username: botName(botIndex),
      vipType: bot ? String(bot.vip) : null,
      bot: true,
      level: bot?.level,
    };
  });
  const mine = players.find((player) => player.userId === me.id) ?? players[players.length - 1];
  return {
    id: `bot-${playedAt}`,
    playedAt,
    source: 'bot',
    place: mine.place,
    playerCount: players.length,
    endReason: state.endReason,
    exitReason: mine.exitReason,
    bet: 0,
    kenDelta: 0,
    players,
  };
}

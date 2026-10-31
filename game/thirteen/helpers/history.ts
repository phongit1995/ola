import type { LeaderboardEntry, LeaderboardPeriod, MatchHistoryEntry, MatchHistoryPlayer } from '../../src/sdk';
import { formatKen } from './room';
import { medalTone, placeLabel } from './seats';

const GMT7_OFFSET_MS = 7 * 60 * 60 * 1000;
const WEEKDAYS = ['Chủ nhật', 'thứ Hai', 'thứ Ba', 'thứ Tư', 'thứ Năm', 'thứ Sáu', 'thứ Bảy'];

export interface HistoryPlace {
  place: number | null;
  label: string;
  tone: string;
}

export function historyPlayerCount(entry: MatchHistoryEntry): number {
  return Math.max(2, entry.playerCount ?? entry.players?.length ?? 2);
}

export function historyKenDelta(entry: MatchHistoryEntry): number {
  if (Number.isFinite(entry.kenDelta)) return entry.kenDelta;
  return entry.outcome === 'lose' ? -entry.bet : 0;
}

export function historyPlace(entry: MatchHistoryEntry): HistoryPlace {
  const total = historyPlayerCount(entry);
  const place = entry.place && entry.place > 0 ? entry.place : entry.outcome === 'win' ? 1 : null;
  if (place == null) {
    return entry.outcome === 'draw'
      ? { place: null, label: 'Hòa', tone: 'plain' }
      : { place: null, label: 'Thua', tone: 'last' };
  }
  return { place, label: placeLabel(place, total), tone: medalTone(place, total) };
}

export function historyTablemates(entry: MatchHistoryEntry, selfId: string): MatchHistoryPlayer[] {
  if (entry.players?.length) return entry.players.filter((player) => player.userId !== selfId);
  if (!entry.opponentId) return [];
  return [
    {
      userId: entry.opponentId,
      username: entry.opponentName,
      vipType: entry.opponentVipType,
      place: entry.outcome === 'lose' ? 1 : entry.outcome === 'win' ? 2 : undefined,
    },
  ];
}

export function formatSignedKen(delta: number): string {
  if (delta === 0) return '0';
  return `${delta < 0 ? '−' : '+'}${formatKen(Math.abs(delta))}`;
}

function sameLocalDay(a: Date, b: Date): boolean {
  return a.getFullYear() === b.getFullYear() && a.getMonth() === b.getMonth() && a.getDate() === b.getDate();
}

const pad2 = (value: number): string => String(value).padStart(2, '0');

export function formatPlayedAt(playedAt: number, now: number): string {
  const played = new Date(playedAt);
  const today = new Date(now);
  const yesterday = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 1);
  const time = `${pad2(played.getHours())}:${pad2(played.getMinutes())}`;
  if (sameLocalDay(played, today)) return `${time} · Hôm nay`;
  if (sameLocalDay(played, yesterday)) return `${time} · Hôm qua`;
  const date = `${pad2(played.getDate())}/${pad2(played.getMonth() + 1)}`;
  return `${time} · ${played.getFullYear() === today.getFullYear() ? date : `${date}/${played.getFullYear()}`}`;
}

export function leaderboardGames(entry: LeaderboardEntry): number {
  return Math.max(0, (entry.wins ?? 0) + (entry.losses ?? 0));
}

export function periodCaption(period: LeaderboardPeriod, from: number): string {
  if (period === 'day') return 'Tính từ 0h hôm nay';
  if (!from) return '';
  const start = new Date(from + GMT7_OFFSET_MS);
  const date = `${pad2(start.getUTCDate())}/${pad2(start.getUTCMonth() + 1)}`;
  if (period === 'week') return `Tính từ ${WEEKDAYS[start.getUTCDay()]} ${date}`;
  return `Tính từ ${date}`;
}

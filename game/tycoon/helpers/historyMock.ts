import type { EndReason } from '../logic/constants';
import type { HistoryEntry, HistoryExitReason, HistoryPlayer } from './history';
import { MOCK_PROFILE } from './profile';

const LATENCY_MS = 600;
const FEE_PERCENT = 5;

type Seat = [username: string, vipType: string | null, exitReason?: HistoryExitReason];

function at(daysAgo: number, hour: number, minute: number): number {
  const date = new Date();
  date.setDate(date.getDate() - daysAgo);
  date.setHours(hour, minute, 0, 0);
  return date.getTime();
}

function match(id: string, playedAt: number, bet: number, endReason: EndReason, seats: Seat[]): HistoryEntry {
  const pot = bet * seats.length;
  const winnerDelta = bet > 0 ? pot - Math.round((pot * FEE_PERCENT) / 100) - bet : 0;
  const players: HistoryPlayer[] = seats.map(([username, vipType, exitReason], index) => ({
    userId: username === MOCK_PROFILE.username ? MOCK_PROFILE.id : `u-${username}`,
    username,
    vipType,
    place: index + 1,
    kenDelta: index === 0 ? winnerDelta : -bet,
    exitReason: exitReason ?? null,
  }));
  const me = players.find((player) => player.userId === MOCK_PROFILE.id) ?? players[0];
  return {
    id,
    playedAt,
    source: 'online',
    place: me.place,
    playerCount: players.length,
    endReason,
    exitReason: me.exitReason,
    bet,
    kenDelta: me.kenDelta,
    players,
  };
}

function build(): HistoryEntry[] {
  const me = (exit?: HistoryExitReason): Seat => [MOCK_PROFILE.username, MOCK_PROFILE.vipType, exit];
  return [
    match('m-1432', at(0, 14, 32), 500, 'groups', [me(), ['linh', '7'], ['khoa', '12'], ['trang', '5', 'bankrupt']]),
    match('m-1245', at(0, 12, 45), 500, 'rounds', [['nam', '18'], me(), ['ha', null], ['tuan', '9']]),
    match('m-2018', at(1, 20, 18), 200, 'last', [['vy', '2'], ['long', '15', 'bankrupt'], ['quan', '4', 'bankrupt'], me('bankrupt')]),
    match('m-0905', at(2, 9, 5), 0, 'time', [['mai', '11'], ['an', null], me('forfeit')]),
  ];
}

export function mockFetchHistory(): Promise<HistoryEntry[]> {
  return new Promise((resolve) => window.setTimeout(() => resolve(build()), LATENCY_MS));
}

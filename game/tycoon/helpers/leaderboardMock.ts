import { levelFromExp } from '../../src/sdk/progression';
import { LEADERBOARD_LIMIT, type LeaderboardResult, type LeaderboardRow, type LeaderboardTab } from './leaderboard';
import { MOCK_PROFILE } from './profile';

const LATENCY_MS = 550;

const NAMES = ['linh', 'khoa', 'trang', 'nam', 'ha', 'tuan', 'vy', 'long', 'baongoc', 'quan', 'mai', 'phucthinh_rat_dai_ten', 'an', 'duc', 'thao', 'hieu', 'lan', 'son', 'kim', 'tam', 'yen', 'viet', 'hoa', 'dat'];
const VIPS = ['7', '12', '5', '18', null, '9', '2', '15', '21', '4', '11', '8', null, '14', '6', '19', '1', '10', '16', '13', '20', null, '17', '22'];

const DAY: Array<[string, number, number]> = [
  ['linh', 6, 9],
  ['khoa', 5, 8],
  ['trang', 5, 10],
  [MOCK_PROFILE.username, 4, 7],
  ['nam', 3, 6],
  ['ha', 3, 8],
  ['tuan', 2, 5],
  ['vy', 1, 4],
];

const LEVEL_TOP = [28_650, 24_150, 21_450, 18_250, 16_100, 12_450];
const ME_LEVEL_RANK = 128;
const ME_EXP = 6_950;

function player(index: number): Pick<LeaderboardRow, 'userId' | 'username' | 'vipType'> {
  const name = NAMES[index % NAMES.length];
  const round = Math.floor(index / NAMES.length);
  const username = round ? `${name}${round + 1}` : name;
  return { userId: `u-${username}`, username, vipType: VIPS[index % VIPS.length] };
}

function me(): Pick<LeaderboardRow, 'userId' | 'username' | 'vipType'> {
  return { userId: MOCK_PROFILE.id, username: MOCK_PROFILE.username, vipType: MOCK_PROFILE.vipType };
}

function expAt(rank: number): number {
  if (rank <= LEVEL_TOP.length) return LEVEL_TOP[rank - 1];
  return Math.round(12_000 - (rank - LEVEL_TOP.length) * 50);
}

function dayBoard(): LeaderboardRow[] {
  let other = 0;
  return DAY.map(([name, wins, matches], index) => {
    const who = name === MOCK_PROFILE.username ? me() : player(other++);
    return { ...who, rank: index + 1, wins, matches, level: levelFromExp(expAt(index + 4)) };
  });
}

function weekBoard(): LeaderboardRow[] {
  return Array.from({ length: 24 }, (_, index) => {
    const rank = index + 1;
    const who = rank === 7 ? me() : player(index);
    const wins = Math.max(1, 31 - rank - Math.floor(rank / 3));
    return { ...who, rank, wins, matches: wins + 6 + (rank % 5), level: levelFromExp(expAt(rank + 2)) };
  });
}

function levelBoard(): LeaderboardRow[] {
  return Array.from({ length: LEADERBOARD_LIMIT }, (_, index) => {
    const rank = index + 1;
    const exp = expAt(rank);
    return { ...player(index), rank, exp, level: levelFromExp(exp) };
  });
}

function build(tab: LeaderboardTab): LeaderboardResult {
  if (tab === 'level') {
    return { tab, items: levelBoard(), me: { ...me(), rank: ME_LEVEL_RANK, exp: ME_EXP, level: levelFromExp(ME_EXP) } };
  }
  const items = tab === 'day' ? dayBoard() : weekBoard();
  return { tab, items, me: items.find((row) => row.userId === MOCK_PROFILE.id) ?? null };
}

export function mockFetchLeaderboard(tab: LeaderboardTab): Promise<LeaderboardResult> {
  return new Promise((resolve) => window.setTimeout(() => resolve(build(tab)), LATENCY_MS));
}

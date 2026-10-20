import { describe, expect, it } from 'vitest';
import { BOARD, tilesOfGroup } from './board';
import { botMove } from './bot';
import { activeSeats, applyMove, isOver, moveOnTimeout, newGame, ownsGroup, worth } from './engine';
import type { EndReason } from './constants';
import type { GameState } from './types';

const GROUPS = [...new Set(BOARD.filter((t) => t.kind === 'street').map((t) => t.group as string))];

interface Outcome {
  end: EndReason;
  takeovers: number;
  monopoly: boolean;
  maxRent: number;
  margin: number;
}

function play(seed: number, players: number): Outcome {
  let s: GameState = newGame(seed, players);
  let takeovers = 0;
  let maxRent = 0;
  let monopoly = false;
  for (let guard = 0; !isOver(s) && guard < 20000; guard++) {
    const seat = s.turn;
    s = applyMove(s, seat, botMove(s, seat) ?? moveOnTimeout(s, seat)!);
    for (const st of s.steps) {
      if (st.kind === 'takeover') takeovers++;
      if (st.kind === 'pay' && st.reason === 'rent') maxRent = Math.max(maxRent, st.amount ?? 0);
    }
    if (!monopoly) monopoly = GROUPS.some((g) => tilesOfGroup(g).length > 0 && activeSeats(s).some((seatIdx) => ownsGroup(s, seatIdx, g)));
  }
  const worths = s.players.map((_, i) => worth(s, i)).sort((a, b) => b - a);
  return { end: s.endReason ?? 'last', takeovers, monopoly, maxRent, margin: (worths[0] - worths[1]) / Math.max(1, worths[0]) };
}

function run(players: number, games: number) {
  const out = Array.from({ length: games }, (_, i) => play(1000003 * (i + 1) + players * 7919 + 32, players));
  const rate = (f: (o: Outcome) => boolean) => out.filter(f).length / games;
  const median = (xs: number[]) => [...xs].sort((a, b) => a - b)[Math.floor(xs.length / 2)];
  return {
    decided: rate((o) => o.end !== 'rounds'),
    instantWin: rate((o) => o.end === 'groups' || o.end === 'line'),
    takeoverGames: rate((o) => o.takeovers > 0),
    monopoly: rate((o) => o.monopoly),
    maxRent: median(out.map((o) => o.maxRent)),
    margin: median(out.map((o) => o.margin)),
  };
}

// Dải chấp nhận lấy từ mô phỏng 1.000 ván/cấu hình (docs/09-economy.md §5); lệch khỏi dải = luật hoặc bảng giá đã mất cân bằng.
describe('tycoon economy (bot vs bot, mua lại ×2, thắng ngay, 30 vòng)', () => {
  it('2 người: phần lớn ván phân thắng bại trước 30 vòng', () => {
    const r = run(2, 300);
    expect(r.monopoly).toBeGreaterThan(0.85);
    expect(r.decided).toBeGreaterThan(0.6);
    expect(r.takeoverGames).toBeGreaterThan(0.3);
  });

  it('4 người: đa số ván kết thúc bằng thắng ngay, hiếm khi phải chơi hết 30 vòng', () => {
    const r = run(4, 300);
    expect(r.instantWin).toBeGreaterThan(0.7);
    expect(r.decided).toBeGreaterThan(0.8);
    expect(r.takeoverGames).toBeGreaterThan(0.7);
    expect(r.maxRent).toBeGreaterThanOrEqual(300);
    expect(r.margin).toBeGreaterThan(0.25);
  });
});

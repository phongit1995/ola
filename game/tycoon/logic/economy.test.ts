import { describe, expect, it } from 'vitest';
import { BOARD, tilesOfGroup } from './board';
import { botMove } from './bot';
import { activeSeats, applyMove, isOver, moveOnTimeout, newGame, ownsGroup, worth } from './engine';
import type { GameState } from './types';

const GROUPS = [...new Set(BOARD.filter((t) => t.kind === 'street').map((t) => t.group as string))];

interface Outcome {
  bankrupts: number;
  endedEarly: boolean;
  monopoly: boolean;
  maxRent: number;
  margin: number;
}

function play(seed: number, players: number): Outcome {
  let s: GameState = newGame(seed, players);
  let bankrupts = 0;
  let maxRent = 0;
  let monopoly = false;
  for (let guard = 0; !isOver(s) && guard < 20000; guard++) {
    const seat = s.turn;
    s = applyMove(s, seat, botMove(s, seat) ?? moveOnTimeout(s, seat)!);
    for (const st of s.steps) {
      if (st.kind === 'bankrupt') bankrupts++;
      if (st.kind === 'pay' && st.reason === 'rent') maxRent = Math.max(maxRent, st.amount ?? 0);
    }
    if (!monopoly) monopoly = GROUPS.some((g) => tilesOfGroup(g).length > 0 && activeSeats(s).some((seatIdx) => ownsGroup(s, seatIdx, g)));
  }
  const worths = s.players.map((_, i) => worth(s, i)).sort((a, b) => b - a);
  return { bankrupts, endedEarly: activeSeats(s).length <= 1, monopoly, maxRent, margin: (worths[0] - worths[1]) / Math.max(1, worths[0]) };
}

function run(players: number, games: number) {
  const out = Array.from({ length: games }, (_, i) => play(1000003 * (i + 1) + players * 7919 + 32, players));
  const rate = (f: (o: Outcome) => boolean) => out.filter(f).length / games;
  const median = (xs: number[]) => [...xs].sort((a, b) => a - b)[Math.floor(xs.length / 2)];
  return {
    anyBankrupt: rate((o) => o.bankrupts > 0),
    endedEarly: rate((o) => o.endedEarly),
    monopoly: rate((o) => o.monopoly),
    maxRent: median(out.map((o) => o.maxRent)),
    margin: median(out.map((o) => o.margin)),
  };
}

// Dải chấp nhận lấy từ mô phỏng 3.000 ván/cấu hình (docs/09-economy.md §5); lệch khỏi dải = bảng giá đã mất cân bằng.
describe('tycoon economy (bot vs bot, 20 vòng)', () => {
  it('2 người: hay có người phá sản, gần như ván nào cũng gom được nhóm', () => {
    const r = run(2, 300);
    expect(r.monopoly).toBeGreaterThan(0.8);
    expect(r.anyBankrupt).toBeGreaterThan(0.12);
    expect(r.anyBankrupt).toBeLessThan(0.4);
  });

  it('4 người: phá sản là mối đe doạ thật nhưng đa số ván vẫn chơi đủ vòng', () => {
    const r = run(4, 300);
    expect(r.monopoly).toBeGreaterThan(0.65);
    expect(r.anyBankrupt).toBeGreaterThan(0.28);
    expect(r.anyBankrupt).toBeLessThan(0.55);
    expect(r.endedEarly).toBeLessThan(0.2);
    expect(r.maxRent).toBeGreaterThanOrEqual(200);
    expect(r.margin).toBeGreaterThan(0.15);
  });
});

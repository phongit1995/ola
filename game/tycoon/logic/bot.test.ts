import { describe, expect, it } from 'vitest';
import { BOARD } from './board';
import { botMove, botRng } from './bot';
import { applyMove, isOver, moveOnTimeout, newGame, rankings } from './engine';
import type { BotLevel, GameState } from './types';

const HEAVY = Number(process.env.TYCOON_BOT_GAMES ?? 0);
const TIMEOUT = HEAVY ? 1_800_000 : 120_000;
const DUELS: { high: BotLevel; low: BotLevel; games: number; min: number; full: number }[] = [
  { high: 'hard', low: 'normal', games: 100, min: 0.55, full: 0.55 },
  { high: 'normal', low: 'easy', games: 400, min: 0.7, full: 0.7 },
  { high: 'hard', low: 'easy', games: 100, min: 0.8, full: 0.8 },
];

interface Result {
  winner: number;
  end: string;
  moves: number;
}

function play(seed: number, levels: readonly BotLevel[]): Result {
  let s: GameState = newGame(seed, levels.length);
  const counts = levels.map(() => 0);
  let moves = 0;
  for (; !isOver(s) && moves < 20000; moves++) {
    const seat = s.turn;
    const move = botMove(s, seat, levels[seat], botRng(seed, seat, counts[seat]++)) ?? moveOnTimeout(s, seat);
    if (!move) throw new Error(`no move for seat ${seat} in phase ${s.phase}`);
    s = applyMove(s, seat, move);
  }
  return { winner: rankings(s)[0], end: s.endReason ?? 'last', moves };
}

function duel(high: BotLevel, low: BotLevel, games: number, salt: number) {
  let wins = 0;
  const ends = new Set<string>();
  for (let i = 0; i < games; i++) {
    const seat = i % 2;
    const r = play(104729 * (i + 1) + salt, seat === 0 ? [high, low] : [low, high]);
    expect(r.moves).toBeLessThan(20000);
    ends.add(r.end);
    if (r.winner === seat) wins++;
  }
  return { rate: wins / games, ends };
}

describe('bot levels', () => {
  it('never touches the game rng, decks or state', () => {
    let s = newGame(42, 2);
    for (let i = 0; i < 400 && !isOver(s); i++) {
      const seat = s.turn;
      for (const level of ['easy', 'normal', 'hard'] as const) {
        const before = structuredClone(s);
        botMove(s, seat, level, botRng(42, seat, i));
        expect(s).toEqual(before);
      }
      s = applyMove(s, seat, botMove(s, seat, 'hard', botRng(42, seat, i)) ?? moveOnTimeout(s, seat)!);
    }
  }, TIMEOUT);

  it('is deterministic for a fixed seed', () => {
    const levels: BotLevel[] = ['easy', 'hard', 'normal'];
    expect(play(77, levels)).toEqual(play(77, levels));
  }, TIMEOUT);

  it('normal level keeps the original decisions without rng', () => {
    const s = newGame(9, 2);
    expect(botMove(s, 0)).toEqual(botMove(s, 0, 'normal', () => 0.99));
  });

  it('easy never flies into a rival hotel while a safe tile exists', () => {
    const base = newGame(3, 2);
    const s: GameState = {
      ...base,
      phase: 'travel',
      players: base.players.map((p, i) => (i === 0 ? { ...p, pos: 24, travel: true } : p)),
      tiles: base.tiles.map((t, idx) => (BOARD[idx].kind === 'street' ? { owner: 1, houses: 3 } : t)),
    };
    for (let m = 0; m < 50; m++) {
      const move = botMove(s, 0, 'easy', botRng(1, 0, m));
      expect(move?.type).toBe('TRAVEL');
      expect(BOARD[move!.tile!].kind).not.toBe('street');
    }
  });

  it.each(DUELS)('$high beats $low 1v1', ({ high, low, games, min, full }) => {
    const { rate, ends } = duel(high, low, HEAVY || games, high.length * 31 + low.length);
    console.info(`[tycoon bot] ${high}-${low}: ${(rate * 100).toFixed(1)}% of ${HEAVY || games} (${[...ends].join(', ')})`);
    expect(rate).toBeGreaterThanOrEqual(HEAVY ? full : min);
  }, TIMEOUT);

  it('4 players mixed levels all finish, every level wins in the full run', () => {
    const games = HEAVY ? 200 : 12;
    const levels: BotLevel[] = ['easy', 'normal', 'hard', 'hard'];
    const wins = new Map<BotLevel, number>();
    for (let i = 0; i < games; i++) {
      const shift = i % 4;
      const seats = levels.map((_, k) => levels[(k + shift) % 4]);
      const r = play(7907 * (i + 1) + 5, seats);
      wins.set(seats[r.winner], (wins.get(seats[r.winner]) ?? 0) + 1);
    }
    expect([...wins.values()].reduce((sum, n) => sum + n, 0)).toBe(games);
    expect(wins.get('hard') ?? 0).toBeGreaterThan(0);
    if (HEAVY) {
      expect(wins.get('easy') ?? 0).toBeGreaterThan(0);
      expect(wins.get('normal') ?? 0).toBeGreaterThan(0);
    }
  }, TIMEOUT);
});

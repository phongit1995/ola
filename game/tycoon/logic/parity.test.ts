import { describe, expect, it } from 'vitest';
import parity from '../../../server/internal/game/games/tycoon/testdata/parity.json';
import { applyMove, newGame, quitPlayer } from './engine';
import { RuleError, type GameState, type Move } from './types';

interface FixtureTurn {
  seat: number;
  move?: Move;
  quit?: boolean;
  error?: string;
  steps?: unknown[];
  state?: Record<string, unknown>;
}

interface FixtureGame {
  name?: string;
  seed: number;
  players: number;
  initial?: Record<string, unknown> & { rng: string };
  turns: FixtureTurn[];
  final: Record<string, unknown>;
}

function canon(value: unknown): unknown {
  if (typeof value === 'bigint') return value.toString();
  if (Array.isArray(value)) return value.map(canon);
  if (value && typeof value === 'object') {
    const out: Record<string, unknown> = {};
    for (const key of Object.keys(value).sort()) {
      const item = (value as Record<string, unknown>)[key];
      if (item !== undefined) out[key] = canon(item);
    }
    return out;
  }
  return value;
}

function comparable(state: unknown): unknown {
  const copy = canon(state) as Record<string, unknown>;
  delete copy.startedAt;
  return copy;
}

function replay(game: FixtureGame): GameState {
  let state = game.initial ? ({ ...game.initial, rng: BigInt(game.initial.rng) } as unknown as GameState) : newGame(game.seed, game.players);
  for (const [i, turn] of game.turns.entries()) {
    let next: GameState;
    if (turn.quit) next = quitPlayer(state, turn.seat);
    else {
      try {
        next = applyMove(state, turn.seat, turn.move as Move);
      } catch (error) {
        expect(error instanceof RuleError ? error.code : String(error), `turn ${i}`).toBe(turn.error);
        continue;
      }
      expect(turn.error, `turn ${i}: go rejected, ts accepted`).toBeUndefined();
    }
    expect(canon(next.steps), `turn ${i} steps`).toEqual(canon(turn.steps ?? []));
    if (turn.state) expect(comparable(next), `turn ${i} state`).toEqual(comparable(turn.state));
    state = next;
  }
  return state;
}

describe('server/client Tycoon parity', () => {
  for (const game of parity.games as unknown as FixtureGame[]) {
    it(game.name ?? `seed ${game.seed}`, () => {
      const state = replay(game);
      expect(comparable(state)).toEqual(comparable(game.final));
    });
  }
});

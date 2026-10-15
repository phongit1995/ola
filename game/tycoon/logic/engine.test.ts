import { describe, expect, it } from 'vitest';
import { BOARD } from './board';
import { botMove } from './bot';
import { GO_SALARY, JAIL_FINE, JAIL_TILE, MAX_ROUNDS, START_CASH } from './constants';
import { applyMove, computeRent, isOver, moveOnTimeout, newGame, quitPlayer, rankings } from './engine';
import type { GameState, Move } from './types';

function play(s: GameState, seat: number, mv: Move): GameState {
  return applyMove(s, seat, mv);
}

function withPhase(s: GameState, phase: GameState['phase']): GameState {
  return { ...s, phase };
}

function findSeed(wantDouble: boolean): number {
  for (let seed = 1; seed < 5000; seed++) {
    const s = newGame(seed, 2);
    const next = applyMove(withPhase(s, 'roll'), 0, { type: 'ROLL' });
    const step = next.steps.find((st) => st.kind === 'roll');
    if (step && Boolean(step.double) === wantDouble) return seed;
  }
  throw new Error('no seed');
}

describe('tycoon engine', () => {
  it('sets up a new game', () => {
    const s = newGame(7, 3);
    expect(s.players).toHaveLength(3);
    expect(s.players[0].cash).toBe(START_CASH);
    expect(s.phase).toBe('roll');
    expect(s.chanceDeck).toHaveLength(12);
    expect(s.tiles.every((t) => t.owner === -1)).toBe(true);
  });

  it('rolls, moves and offers purchase or resolves the tile', () => {
    const s = play(newGame(3, 2), 0, { type: 'ROLL' });
    const sum = s.dice[0] + s.dice[1];
    expect(s.players[0].pos).toBe(sum % 40);
    expect(s.steps.map((st) => st.kind)).toEqual(expect.arrayContaining(['roll', 'move', 'land']));
    const kind = BOARD[s.players[0].pos].kind;
    if (kind === 'street' || kind === 'station' || kind === 'utility') expect(s.phase).toBe('decide');
    if (kind === 'chance' || kind === 'chest') expect(s.phase).toBe('card');
  });

  it('end turn advances and counts rounds', () => {
    let s = withPhase(newGame(1, 3), 'manage');
    s = play(s, 0, { type: 'END_TURN' });
    expect(s.turn).toBe(1);
    expect(s.phase).toBe('roll');
    s = play(withPhase(s, 'manage'), 1, { type: 'END_TURN' });
    s = play(withPhase(s, 'manage'), 2, { type: 'END_TURN' });
    expect(s.turn).toBe(0);
    expect(s.round).toBe(2);
    expect(s.steps.some((st) => st.kind === 'round')).toBe(true);
  });

  it('keeps the turn after doubles and jails on the third double', () => {
    const s = withPhase(newGame(1, 2), 'manage');
    s.players[0].doubles = 1;
    const next = play(s, 0, { type: 'END_TURN' });
    expect(next.turn).toBe(0);
    expect(next.phase).toBe('roll');

    const seed = findSeed(true);
    const game = newGame(seed, 2);
    game.players[0].doubles = 2;
    const jailed = play(game, 0, { type: 'ROLL' });
    expect(jailed.players[0].inJail).toBe(true);
    expect(jailed.players[0].pos).toBe(JAIL_TILE);
    expect(jailed.steps.some((st) => st.kind === 'jail-in')).toBe(true);
  });

  it('computes rent with group bonus, houses, stations and utilities', () => {
    const s = newGame(1, 4);
    s.tiles[21].owner = 0;
    expect(computeRent(s, 21, 0, 7)).toBe(18);
    s.tiles[23].owner = 0;
    s.tiles[24].owner = 0;
    expect(computeRent(s, 21, 0, 7)).toBe(36);
    s.tiles[21].houses = 5;
    expect(computeRent(s, 21, 0, 7)).toBe(1050);
    s.tiles[5].owner = 1;
    s.tiles[15].owner = 1;
    expect(computeRent(s, 5, 1, 7)).toBe(50);
    s.tiles[12].owner = 2;
    expect(computeRent(s, 12, 2, 9)).toBe(36);
    s.tiles[28].owner = 2;
    expect(computeRent(s, 12, 2, 9)).toBe(90);
  });

  it('pays salary when passing or landing on go', () => {
    const seed = findSeed(false);
    const s = newGame(seed, 2);
    s.players[0].pos = 38;
    const next = play(s, 0, { type: 'ROLL' });
    expect(next.players[0].cash).toBeGreaterThanOrEqual(START_CASH + GO_SALARY - 400);
    expect(next.steps.some((st) => st.kind === 'pay' && st.reason === 'salary')).toBe(true);
  });

  it('enforces even building and selling', () => {
    let s = withPhase(newGame(1, 2), 'manage');
    for (const idx of [21, 23, 24]) s.tiles[idx].owner = 0;
    s = play(s, 0, { type: 'BUILD', tile: 21 });
    expect(() => play(s, 0, { type: 'BUILD', tile: 21 })).toThrow('build_uneven');
    s = play(s, 0, { type: 'BUILD', tile: 23 });
    s = play(s, 0, { type: 'BUILD', tile: 24 });
    s = play(s, 0, { type: 'BUILD', tile: 21 });
    expect(s.tiles[21].houses).toBe(2);
    expect(s.players[0].cash).toBe(START_CASH - 4 * 150);
    expect(() => play(s, 0, { type: 'SELL_HOUSE', tile: 23 })).toThrow('sell_uneven');
    s = play(s, 0, { type: 'SELL_HOUSE', tile: 21 });
    expect(s.players[0].cash).toBe(START_CASH - 4 * 150 + 75);
    s.tiles[1].owner = 0;
    expect(() => play(s, 0, { type: 'BUILD', tile: 1 })).toThrow('not_group_owner');
    expect(() => play(s, 0, { type: 'BUILD', tile: 5 })).toThrow('not_street');
  });

  it('enters debt, settles by selling houses, or goes bankrupt', () => {
    const s = withPhase(newGame(1, 2), 'card');
    s.card = { deck: 'chance', id: 'ch02' };
    s.tiles[39].owner = 1;
    s.tiles[39].houses = 5;
    s.tiles[37].owner = 1;
    s.tiles[37].houses = 4;
    for (const idx of [21, 23, 24]) {
      s.tiles[idx].owner = 0;
      s.tiles[idx].houses = 4;
    }
    s.players[0].cash = 1200;
    s.players[0].pos = 7;
    const indebted = play(s, 0, { type: 'CARD_ACK' });
    expect(indebted.phase).toBe('debt');
    expect(indebted.debt?.amount).toBe(2000);
    expect(() => play(indebted, 0, { type: 'PAY_DEBT' })).toThrow('no_cash');
    const settled = play(indebted, 0, { type: 'SETTLE_DEBT' });
    expect(settled.phase).toBe('manage');
    expect(settled.players[1].cash).toBe(START_CASH + 2000);
    expect(settled.players[0].cash).toBe(25);

    const poor = withPhase(newGame(1, 3), 'card');
    poor.card = { deck: 'chance', id: 'ch02' };
    poor.tiles[39].owner = 1;
    poor.tiles[39].houses = 5;
    poor.tiles[37].owner = 1;
    poor.tiles[37].houses = 4;
    poor.tiles[5].owner = 0;
    poor.players[0].cash = 100;
    poor.players[0].pos = 7;
    const broke = play(poor, 0, { type: 'CARD_ACK' });
    expect(broke.players[0].bankrupt).toBe(true);
    expect(broke.tiles[5].owner).toBe(1);
    expect(broke.players[1].cash).toBe(START_CASH + 100);
    expect(broke.turn).toBe(1);
    expect(broke.finished).toBe(false);
    expect(rankings(broke).at(-1)).toBe(0);
  });

  it('handles birthday debt out of turn', () => {
    const s = withPhase(newGame(1, 3), 'card');
    s.card = { deck: 'chest', id: 'cm07' };
    s.players[1].cash = 5;
    for (const idx of [21, 23, 24]) {
      s.tiles[idx].owner = 1;
      s.tiles[idx].houses = 1;
    }
    const indebted = play(s, 0, { type: 'CARD_ACK' });
    expect(indebted.players[2].cash).toBe(START_CASH - 10);
    expect(indebted.phase).toBe('debt');
    expect(indebted.turn).toBe(1);
    expect(() => play(indebted, 0, { type: 'END_TURN' })).toThrow('not_your_turn');
    const sold = play(indebted, 1, { type: 'SELL_HOUSE', tile: 21 });
    const paid = play(sold, 1, { type: 'PAY_DEBT' });
    expect(paid.turn).toBe(0);
    expect(paid.phase).toBe('manage');
    expect(paid.players[0].cash).toBe(START_CASH + 20);
  });

  it('runs the jail flow', () => {
    const s = withPhase(newGame(1, 2), 'jail');
    s.players[0].inJail = true;
    s.players[0].pos = JAIL_TILE;
    const paid = play(s, 0, { type: 'JAIL_PAY' });
    expect(paid.players[0].inJail).toBe(false);
    expect(paid.players[0].cash).toBe(START_CASH - JAIL_FINE);
    expect(paid.phase).toBe('roll');

    const withCard = withPhase(newGame(1, 2), 'jail');
    withCard.players[0].inJail = true;
    withCard.players[0].jailCards = 1;
    const freed = play(withCard, 0, { type: 'JAIL_CARD' });
    expect(freed.players[0].jailCards).toBe(0);
    expect(freed.phase).toBe('roll');

    const seed = findSeed(false);
    const third = withPhase(newGame(seed, 2), 'jail');
    third.players[0].inJail = true;
    third.players[0].pos = JAIL_TILE;
    third.players[0].jailTurns = 2;
    const forced = play(third, 0, { type: 'JAIL_ROLL' });
    expect(forced.players[0].inJail).toBe(false);
    expect(forced.players[0].cash).toBeLessThanOrEqual(START_CASH - JAIL_FINE);
    expect(forced.players[0].pos).not.toBe(JAIL_TILE);
  });

  it('applies move cards, repair and jail cards', () => {
    const s = withPhase(newGame(1, 2), 'card');
    s.players[0].pos = 36;
    s.card = { deck: 'chance', id: 'ch01' };
    const atGo = play(s, 0, { type: 'CARD_ACK' });
    expect(atGo.players[0].pos).toBe(0);
    expect(atGo.players[0].cash).toBe(START_CASH + GO_SALARY);

    const repair = withPhase(newGame(1, 2), 'card');
    repair.card = { deck: 'chance', id: 'ch10' };
    for (const idx of [21, 23, 24]) {
      repair.tiles[idx].owner = 0;
      repair.tiles[idx].houses = 2;
    }
    repair.tiles[21].houses = 5;
    const repaired = play(repair, 0, { type: 'CARD_ACK' });
    expect(repaired.players[0].cash).toBe(START_CASH - (100 + 50 + 50));

    const jail = withPhase(newGame(1, 2), 'card');
    jail.card = { deck: 'chance', id: 'ch08' };
    const before = jail.chanceDeck.length;
    const keep = play(jail, 0, { type: 'CARD_ACK' });
    expect(keep.players[0].jailCards).toBe(1);
    expect(keep.chanceDeck).toHaveLength(before - 1);
  });

  it('finishes by round cap ranking on worth', () => {
    const s = withPhase(newGame(1, 2), 'manage');
    s.round = MAX_ROUNDS;
    s.turn = 1;
    s.players[1].cash = 3000;
    const done = play(s, 1, { type: 'END_TURN' });
    expect(done.finished).toBe(true);
    expect(rankings(done)[0]).toBe(1);
  });

  it('turns a quitter into a bank bankruptcy', () => {
    const s = withPhase(newGame(1, 3), 'decide');
    s.turn = 1;
    s.tiles[21].owner = 1;
    s.tiles[21].houses = 2;
    const left = quitPlayer(s, 1);
    expect(left.players[1].bankrupt).toBe(true);
    expect(left.tiles[21].owner).toBe(-1);
    expect(left.turn).toBe(2);
    const alone = quitPlayer(left, 2);
    expect(isOver(alone)).toBe(true);
    expect(rankings(alone)[0]).toBe(0);
  });

  it('plays a full game with bots to completion', () => {
    for (let seed = 1; seed <= 20; seed++) {
      let s = newGame(seed, 4);
      let guard = 0;
      while (!s.finished && guard++ < 5000) {
        const mv = botMove(s, s.turn) ?? moveOnTimeout(s, s.turn);
        if (!mv) throw new Error(`seed ${seed}: no move in ${s.phase}`);
        s = applyMove(s, s.turn, mv);
        expect(s.players.every((p) => p.cash >= 0)).toBe(true);
      }
      expect(s.finished).toBe(true);
      expect(rankings(s)).toHaveLength(4);
    }
  });
});

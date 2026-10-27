import { describe, expect, it } from 'vitest';
import { BOARD, CARDS } from './board';
import { botMove } from './bot';
import { BOARD_SIZE, FESTIVAL_MULTIPLIER, GO_SALARY, JAIL_FINE, JAIL_TILE, MAX_HOUSES, MAX_ROUNDS, START_CASH, TAKEOVER_MULTIPLIER } from './constants';
import { applyMove, computeRent, endByTime, isNewTurn, isOver, moveOnTimeout, newGame, quitPlayer, rankings, takeoverPrice, taxAmount, worth } from './engine';
import { canSell } from './rules-hint';
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
    expect(s.players[0].pos).toBe(sum % BOARD_SIZE);
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

  it('lays out 32 tiles with corners every 8 and 16 two-city groups', () => {
    expect(BOARD).toHaveLength(BOARD_SIZE);
    expect([0, 8, 16, 24].map((idx) => BOARD[idx].kind)).toEqual(['go', 'jail', 'festival', 'travel']);
    expect(BOARD.filter((t) => t.kind === 'chance')).toHaveLength(4);
    expect(BOARD.filter((t) => t.kind === 'tax').map((t) => t.idx)).toEqual([12]);
    expect(BOARD.filter((t) => t.kind === 'station').map((t) => t.idx)).toEqual([6, 10, 22, 26]);
    const streets = BOARD.filter((t) => t.kind === 'street');
    expect(streets).toHaveLength(16);
    for (const tile of streets) {
      expect(tile.rent).toHaveLength(MAX_HOUSES + 1);
      expect(streets.filter((t) => t.group === tile.group)).toHaveLength(2);
    }
    const prices = streets.map((t) => t.price ?? 0);
    expect([...prices].sort((a, b) => a - b)).toEqual(prices);
  });

  it('computes rent with group bonus, levels, airports and the festival', () => {
    const s = newGame(1, 4);
    s.tiles[17].owner = 0;
    expect(computeRent(s, 17, 0)).toBe(22);
    s.tiles[19].owner = 0;
    expect(computeRent(s, 17, 0)).toBe(44);
    s.tiles[17].houses = 1;
    expect(computeRent(s, 17, 0)).toBe(130);
    s.tiles[17].houses = 3;
    expect(computeRent(s, 17, 0)).toBe(1000);
    s.tiles[6].owner = 1;
    s.tiles[10].owner = 1;
    expect(computeRent(s, 6, 1)).toBe(50);
    s.festival = 17;
    expect(computeRent(s, 17, 0)).toBe(1000 * FESTIVAL_MULTIPLIER);
    s.tiles[19].houses = 0;
    s.tiles[17].houses = 0;
    expect(computeRent(s, 17, 0)).toBe(22 * 2 * FESTIVAL_MULTIPLIER);
  });

  it('pays salary when passing or landing on go', () => {
    const seed = findSeed(false);
    const s = newGame(seed, 2);
    s.players[0].pos = BOARD_SIZE - 2;
    const next = play(s, 0, { type: 'ROLL' });
    expect(next.players[0].cash).toBeGreaterThanOrEqual(START_CASH + GO_SALARY - 400);
    expect(next.steps.some((st) => st.kind === 'pay' && st.reason === 'salary')).toBe(true);
  });

  it('enforces even building and selling', () => {
    let s = withPhase(newGame(1, 2), 'manage');
    for (const idx of [17, 19]) s.tiles[idx].owner = 0;
    s = play(s, 0, { type: 'BUILD', tile: 17 });
    expect(() => play(s, 0, { type: 'BUILD', tile: 17 })).toThrow('build_uneven');
    s = play(s, 0, { type: 'BUILD', tile: 19 });
    s = play(s, 0, { type: 'BUILD', tile: 17 });
    expect(s.tiles[17].houses).toBe(2);
    expect(s.players[0].cash).toBe(START_CASH - 3 * 150);
    expect(() => play(s, 0, { type: 'SELL_HOUSE', tile: 19 })).toThrow('sell_uneven');
    s = play(s, 0, { type: 'SELL_HOUSE', tile: 17 });
    expect(s.players[0].cash).toBe(START_CASH - 3 * 150 + 75);
    s = play(s, 0, { type: 'BUILD', tile: 17 });
    s = play(s, 0, { type: 'BUILD', tile: 19 });
    s = play(s, 0, { type: 'BUILD', tile: 17 });
    s = play(s, 0, { type: 'BUILD', tile: 19 });
    expect(s.tiles[17].houses).toBe(MAX_HOUSES);
    expect(() => play(s, 0, { type: 'BUILD', tile: 17 })).toThrow('max_houses');
    s.tiles[1].owner = 0;
    expect(() => play(s, 0, { type: 'BUILD', tile: 1 })).toThrow('not_group_owner');
    expect(() => play(s, 0, { type: 'BUILD', tile: 4 })).toThrow('not_street');
  });

  it('sells evenly only against own cities when a rival holds part of the group', () => {
    const s = withPhase(newGame(1, 2), 'debt');
    s.tiles[1] = { owner: 1, houses: 2 };
    s.tiles[3] = { owner: 0, houses: 3 };
    s.players[0].cash = 0;
    s.debt = { creditor: 1, amount: 50, by: 0, returnTo: 0, reason: 'rent' };
    const paid = play(s, 0, { type: 'SETTLE_DEBT' });
    expect(paid.players[0].bankrupt).toBe(false);
    expect(paid.players[1].cash).toBe(START_CASH + 50);
    expect(paid.tiles[3].houses).toBe(1);
    expect(canSell(paid, 0, 3)).toEqual({ ok: true });
    expect(play(paid, 0, { type: 'SELL_HOUSE', tile: 3 }).tiles[3].houses).toBe(0);
  });

  it('enters debt, settles by selling houses, or goes bankrupt', () => {
    const s = withPhase(newGame(1, 2), 'card');
    s.card = { deck: 'chance', id: 'ch02' };
    for (const idx of [30, 31]) {
      s.tiles[idx].owner = 1;
      s.tiles[idx].houses = 3;
    }
    for (const idx of [17, 19]) {
      s.tiles[idx].owner = 0;
      s.tiles[idx].houses = 3;
    }
    s.players[0].cash = 1210;
    s.players[0].pos = 29;
    const indebted = play(s, 0, { type: 'CARD_ACK' });
    expect(indebted.phase).toBe('debt');
    expect(indebted.debt?.amount).toBe(1500);
    expect(() => play(indebted, 0, { type: 'PAY_DEBT' })).toThrow('no_cash');
    const settled = play(indebted, 0, { type: 'SETTLE_DEBT' });
    expect(settled.phase).toBe('manage');
    expect(settled.players[1].cash).toBe(START_CASH + 1500);
    expect(settled.players[0].cash).toBe(10);

    const poor = withPhase(newGame(1, 3), 'card');
    poor.card = { deck: 'chance', id: 'ch02' };
    for (const idx of [30, 31]) {
      poor.tiles[idx].owner = 1;
      poor.tiles[idx].houses = 3;
    }
    poor.tiles[6].owner = 0;
    poor.players[0].cash = 100;
    poor.players[0].pos = 29;
    const broke = play(poor, 0, { type: 'CARD_ACK' });
    expect(broke.players[0].bankrupt).toBe(true);
    expect(broke.tiles[6].owner).toBe(1);
    expect(broke.players[1].cash).toBe(START_CASH + 100);
    expect(broke.turn).toBe(1);
    expect(broke.finished).toBe(false);
    expect(rankings(broke).at(-1)).toBe(0);
  });

  it('handles birthday debt out of turn', () => {
    const s = withPhase(newGame(1, 3), 'card');
    s.card = { deck: 'chest', id: 'cm07' };
    s.players[1].cash = 5;
    for (const idx of [17, 19]) {
      s.tiles[idx].owner = 1;
      s.tiles[idx].houses = 1;
    }
    const indebted = play(s, 0, { type: 'CARD_ACK' });
    expect(indebted.players[2].cash).toBe(START_CASH - 10);
    expect(indebted.phase).toBe('debt');
    expect(indebted.turn).toBe(1);
    expect(() => play(indebted, 0, { type: 'END_TURN' })).toThrow('not_your_turn');
    const sold = play(indebted, 1, { type: 'SELL_HOUSE', tile: 17 });
    const paid = play(sold, 1, { type: 'PAY_DEBT' });
    expect(paid.turn).toBe(0);
    expect(paid.phase).toBe('manage');
    expect(paid.players[0].cash).toBe(START_CASH + 20);
  });

  it('returns the turn to the card drawer after queued birthday debts', () => {
    const s = withPhase(newGame(1, 4), 'card');
    s.card = { deck: 'chest', id: 'cm07' };
    s.players[0].doubles = 1;
    s.players[1].cash = 0;
    s.players[2].cash = 0;
    for (const idx of [1, 3]) {
      s.tiles[idx].owner = 1;
      s.tiles[idx].houses = 1;
    }
    for (const idx of [5, 7]) {
      s.tiles[idx].owner = 2;
      s.tiles[idx].houses = 1;
    }
    const first = play(s, 0, { type: 'CARD_ACK' });
    expect(first.turn).toBe(1);
    expect(first.pendingDebts.map((d) => d.returnTo)).toEqual([0]);
    const second = play(first, 1, { type: 'SETTLE_DEBT' });
    expect(second.turn).toBe(2);
    expect(second.phase).toBe('debt');
    const back = play(second, 2, { type: 'SETTLE_DEBT' });
    expect(back.turn).toBe(0);
    expect(back.phase).toBe('manage');
    expect(play(back, 0, { type: 'END_TURN' }).phase).toBe('roll');
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
    withCard.players[0].jailCards = [{ deck: 'chance', id: 'ch08' }];
    const freed = play(withCard, 0, { type: 'JAIL_CARD' });
    expect(freed.players[0].jailCards).toEqual([]);
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
    s.players[0].pos = 29;
    s.card = { deck: 'chance', id: 'ch01' };
    const atGo = play(s, 0, { type: 'CARD_ACK' });
    expect(atGo.players[0].pos).toBe(0);
    expect(atGo.players[0].cash).toBe(START_CASH + GO_SALARY);

    const repair = withPhase(newGame(1, 2), 'card');
    repair.card = { deck: 'chance', id: 'ch10' };
    for (const idx of [17, 19]) {
      repair.tiles[idx].owner = 0;
      repair.tiles[idx].houses = 2;
    }
    repair.tiles[17].houses = 3;
    const repaired = play(repair, 0, { type: 'CARD_ACK' });
    expect(repaired.players[0].cash).toBe(START_CASH - 25 * 5);

    const jail = withPhase(newGame(1, 2), 'card');
    jail.card = { deck: 'chance', id: 'ch08' };
    const before = jail.chanceDeck.length;
    const keep = play(jail, 0, { type: 'CARD_ACK' });
    expect(keep.players[0].jailCards).toEqual([{ deck: 'chance', id: 'ch08' }]);
    expect(keep.chanceDeck).toHaveLength(before - 1);
  });

  it('returns a used or forfeited jail card to the bottom of its own deck', () => {
    const s = withPhase(newGame(1, 2), 'card');
    s.card = { deck: 'chest', id: 'cm05' };
    const kept = play(s, 0, { type: 'CARD_ACK' });
    expect(kept.players[0].jailCards).toEqual([{ deck: 'chest', id: 'cm05' }]);
    expect(kept.chestDeck).toHaveLength(s.chestDeck.length - 1);

    const jailed = withPhase(kept, 'jail');
    jailed.players[0].inJail = true;
    jailed.players[0].pos = JAIL_TILE;
    const freed = play(jailed, 0, { type: 'JAIL_CARD' });
    const chest = CARDS.filter((c) => c.deck === 'chest');
    expect(freed.players[0].jailCards).toEqual([]);
    expect(freed.chestDeck).toHaveLength(s.chestDeck.length);
    expect(chest[freed.chestDeck[freed.chestDeck.length - 1]].id).toBe('cm05');
    expect(freed.chanceDeck).toEqual(s.chanceDeck);

    const quit = quitPlayer(withPhase(kept, 'manage'), 0);
    expect(quit.players[0].jailCards).toEqual([]);
    expect(quit.chestDeck).toHaveLength(s.chestDeck.length);
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
    s.tiles[17].owner = 1;
    s.tiles[17].houses = 2;
    const left = quitPlayer(s, 1);
    expect(left.players[1].bankrupt).toBe(true);
    expect(left.tiles[17].owner).toBe(-1);
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

describe('tycoon takeover and instant win', () => {
  function own(s: GameState, seat: number, tiles: number[], houses = 0): GameState {
    tiles.forEach((idx) => (s.tiles[idx] = { owner: seat, houses }));
    return s;
  }

  it('takes over a city for twice land + upgrades, paying the old owner', () => {
    const s = own(newGame(3, 2), 1, [1], 1);
    s.players[0].pos = 1;
    const next = play(withPhase(s, 'takeover'), 0, { type: 'TAKEOVER' });
    const price = takeoverPrice(s, 1);
    expect(price).toBe(TAKEOVER_MULTIPLIER * (60 + 50));
    expect(next.tiles[1]).toEqual({ owner: 0, houses: 1 });
    expect(next.players[0].cash).toBe(START_CASH - price);
    expect(next.players[1].cash).toBe(START_CASH + price);
    expect(next.phase).toBe('manage');
    expect(next.steps.some((st) => st.kind === 'takeover' && st.target === 1)).toBe(true);
  });

  it('cannot take over a hotel, and declining or timing out skips', () => {
    const s = own(newGame(3, 2), 1, [1], MAX_HOUSES);
    s.players[0].pos = 1;
    expect(() => play(withPhase(s, 'takeover'), 0, { type: 'TAKEOVER' })).toThrow('takeover_hotel');
    expect(moveOnTimeout(withPhase(s, 'takeover'), 0)).toEqual({ type: 'DECLINE' });
    expect(play(withPhase(s, 'takeover'), 0, { type: 'DECLINE' }).phase).toBe('manage');
  });

  it('offers a takeover after paying rent on a rival city', () => {
    for (let seed = 1; seed < 500; seed++) {
      const probe = applyMove(newGame(seed, 2), 0, { type: 'ROLL' });
      const pos = probe.players[0].pos;
      if (BOARD[pos].kind !== 'street' || probe.steps.some((st) => st.kind === 'roll' && st.double)) continue;
      const next = applyMove(own(newGame(seed, 2), 1, [pos]), 0, { type: 'ROLL' });
      expect(next.phase).toBe('takeover');
      expect(next.steps.some((st) => st.kind === 'pay' && st.reason === 'rent')).toBe(true);
      return;
    }
    throw new Error('no seed');
  });

  it('wins instantly with three full colour groups', () => {
    const s = own(newGame(5, 3), 0, [1, 3, 9, 11, 17]);
    s.players[0].pos = 19;
    const next = play(withPhase(s, 'decide'), 0, { type: 'BUY' });
    expect(next.finished).toBe(true);
    expect(next.endReason).toBe('groups');
    expect(next.winner).toBe(0);
    expect(rankings(next)[0]).toBe(0);
  });

  it('wins instantly with every city on one side of the board', () => {
    const s = own(newGame(5, 3), 2, [1, 3, 5]);
    s.players[2].pos = 7;
    s.turn = 2;
    const next = play(withPhase(s, 'decide'), 2, { type: 'BUY' });
    expect(next.endReason).toBe('line');
    expect(rankings(next)[0]).toBe(2);
  });

  it('wins instantly with all four airports', () => {
    const s = own(newGame(5, 3), 1, [6, 10, 22]);
    s.players[1].pos = 26;
    s.turn = 1;
    const next = play(withPhase(s, 'decide'), 1, { type: 'BUY' });
    expect(next.endReason).toBe('airports');
    expect(rankings(next)[0]).toBe(1);
  });

  it('bot buys to block a rival from an instant win even when short of its buffer', () => {
    const s = own(newGame(5, 2), 1, [6, 10, 22]);
    s.players[0].pos = 26;
    s.players[0].cash = 210;
    expect(botMove(withPhase(s, 'decide'), 0)).toEqual({ type: 'BUY' });
    s.tiles[22].owner = -1;
    expect(botMove(withPhase(s, 'decide'), 0)).toEqual({ type: 'DECLINE' });
  });

  it('ends on the time limit and ranks by worth', () => {
    const s = own(newGame(5, 3), 1, [30, 31], 2);
    const next = endByTime(s);
    expect(next.finished).toBe(true);
    expect(next.endReason).toBe('time');
    expect(rankings(next)[0]).toBe(1);
  });

  it('only counts a new turn when play passes to another seat', () => {
    const jail = withPhase(newGame(1, 2), 'jail');
    jail.players[0].inJail = true;
    jail.players[0].pos = JAIL_TILE;
    expect(isNewTurn(jail, play(jail, 0, { type: 'JAIL_PAY' }))).toBe(false);

    const doubled = withPhase(newGame(1, 2), 'manage');
    doubled.players[0].doubles = 1;
    expect(isNewTurn(doubled, play(doubled, 0, { type: 'END_TURN' }))).toBe(false);

    const done = withPhase(newGame(1, 2), 'manage');
    expect(isNewTurn(done, play(done, 0, { type: 'END_TURN' }))).toBe(true);

    const birthday = withPhase(newGame(1, 2), 'card');
    birthday.card = { deck: 'chest', id: 'cm07' };
    birthday.players[1].cash = 0;
    birthday.tiles[1] = { owner: 1, houses: 1 };
    const owed = play(birthday, 0, { type: 'CARD_ACK' });
    expect(owed.phase).toBe('debt');
    expect(isNewTurn(birthday, owed)).toBe(false);
  });
});

describe('tycoon festival, travel and tax', () => {
  function landOn(s: GameState, seat: number, target: number): GameState {
    const probe = play({ ...s, turn: seat, phase: 'roll' }, seat, { type: 'ROLL' });
    const sum = probe.dice[0] + probe.dice[1];
    const start: GameState = { ...s, turn: seat, phase: 'roll', players: s.players.map((p, i) => (i === seat ? { ...p, pos: (target - sum + BOARD_SIZE) % BOARD_SIZE } : p)) };
    return play(start, seat, { type: 'ROLL' });
  }

  it('lets the lander host the festival on one of their cities and doubles its rent', () => {
    const s = newGame(11, 2);
    s.tiles[30].owner = 0;
    const at = landOn(s, 0, 16);
    expect(at.phase).toBe('festival');
    expect(() => play(at, 0, { type: 'FESTIVAL', tile: 31 })).toThrow('not_owner');
    const hosted = play(at, 0, { type: 'FESTIVAL', tile: 30 });
    expect(hosted.festival).toBe(30);
    expect(hosted.phase).toBe('manage');
    expect(computeRent(hosted, 30, 0)).toBe((BOARD[30].rent?.[0] ?? 0) * FESTIVAL_MULTIPLIER);
    expect(moveOnTimeout(at, 0)).toEqual({ type: 'FESTIVAL', tile: 30 });
    expect(play(at, 0, { type: 'DECLINE' }).festival).toBe(-1);
  });

  it('skips the festival when the lander owns no city', () => {
    const at = landOn(newGame(11, 2), 0, 16);
    expect(at.phase).not.toBe('festival');
  });

  it('flies a traveller to any tile next turn, paying salary when passing go', () => {
    const at = landOn(newGame(13, 2), 0, 24);
    expect(at.players[0].travel).toBe(true);
    expect(at.players[0].doubles).toBe(0);
    expect(at.steps.some((st) => st.kind === 'travel')).toBe(true);
    const ready: GameState = { ...at, phase: 'travel' };
    expect(() => play(ready, 0, { type: 'TRAVEL', tile: 24 })).toThrow('invalid_tile');
    const cash = ready.players[0].cash;
    const flown = play(ready, 0, { type: 'TRAVEL', tile: 3 });
    expect(flown.players[0].pos).toBe(3);
    expect(flown.players[0].travel).toBe(false);
    expect(flown.players[0].cash).toBe(cash + GO_SALARY);
    expect(flown.phase).toBe('decide');
    expect(moveOnTimeout(ready, 0)).toEqual({ type: 'ROLL' });
    expect(play(ready, 0, { type: 'ROLL' }).players[0].travel).toBe(false);
  });

  it('starts the traveller in the travel phase after the others move', () => {
    let s = landOn(newGame(13, 2), 0, 24);
    s = play({ ...s, phase: 'manage' }, 0, { type: 'END_TURN' });
    expect(s.turn).toBe(1);
    s = play({ ...s, phase: 'manage' }, 1, { type: 'END_TURN' });
    expect(s.turn).toBe(0);
    expect(s.phase).toBe('travel');
  });

  it('taxes ten percent of total worth', () => {
    const s = newGame(17, 2);
    s.tiles[31].owner = 0;
    s.tiles[30].owner = 0;
    s.tiles[31].houses = 2;
    expect(taxAmount(s, 0)).toBe(Math.round(worth(s, 0) * 0.1));
    const at = landOn(s, 0, 12);
    const tax = at.steps.find((st) => st.kind === 'pay' && st.reason === 'tax');
    const paid = tax?.amount ?? 0;
    expect(paid).toBeGreaterThan(0);
    expect(paid).toBe(Math.round((worth(at, 0) + paid) * 0.1));
  });

  it('bot hosts the festival on its best city and flies to an instant win', () => {
    const s = newGame(19, 2);
    s.tiles[1].owner = 0;
    s.tiles[31].owner = 0;
    expect(botMove(withPhase(s, 'festival'), 0)).toEqual({ type: 'FESTIVAL', tile: 31 });
    s.tiles[6].owner = 0;
    s.tiles[10].owner = 0;
    s.tiles[22].owner = 0;
    s.players[0].pos = 24;
    expect(botMove(withPhase(s, 'travel'), 0)).toEqual({ type: 'TRAVEL', tile: 26 });
  });
});

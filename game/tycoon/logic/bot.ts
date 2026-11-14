import { BOARD, isProperty, tilesOfGroup } from './board';
import { BOARD_SIZE, JAIL_FINE, JAIL_TILE, MAX_HOUSES, WIN_GROUPS, type Phase } from './constants';
import {
  activeSeats,
  applyMove,
  canBuildError,
  computeRent,
  festivalPick,
  instantWin,
  isOver,
  levelCost,
  moveOnTimeout,
  ownedCount,
  ownsGroup,
  rankings,
  SIDE_STREETS,
  STREET_GROUPS,
  takeoverPrice,
  taxAmount,
  worth,
} from './engine';
import type { BotLevel, GameState, Move } from './types';

const CASH_BUFFER = 120;
const EASY_BUY_CHANCE = 0.6;
const EASY_BUY_BUFFER = 60;
const EASY_BUILD_CHANCE = 0.5;
const EASY_TRAVEL_TOP = 5;
const HARD_BUY_MAX_PRICE = 280;
const HARD_THREAT_RESERVE = 0.5;
const HARD_CONTEST_RESERVE = 0.75;
const HARD_JAIL_FREE_AHEAD = 0.25;
const HARD_TAKEOVER_COMPLETE = { price: 240, left: 300 };
const HARD_TAKEOVER_CHEAP = { price: 160, left: 500 };
const SIM_PHASES = new Set<Phase>(['takeover', 'travel', 'jail', 'festival']);
const SIM_GAMES = 100;
const SIM_ROLLOUTS = 200;
const SIM_TURNS = 20;
const SIM_MAX_MOVES = 4000;
const SIM_PROPERTY_WEIGHT = 0.7;
const SIM_WIN_SCORE = 10000;
const SIM_TRAVEL_TOP = 5;
const SIM_FESTIVAL_TOP = 3;
const SIM_TAKEOVER_TARGETS = 2;
const SIM_TAKEOVER_LEFT = 300;
const DICE = [0, 0, 1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1].map((n) => n / 36);
const STATIONS = tilesOfGroup('station');
const PROPERTIES = BOARD.filter((t) => isProperty(t.kind)).map((t) => t.idx);

export type BotRng = () => number;

export function botRng(seed: number, seat: number, moves: number): BotRng {
  let a = (Math.imul(seed | 0, 0x9e3779b1) ^ Math.imul(seat + 1, 0x85ebca6b) ^ Math.imul(moves + 1, 0xc2b2ae35)) >>> 0;
  return () => {
    a = (a + 0x6d2b79f5) | 0;
    let t = Math.imul(a ^ (a >>> 15), 1 | a);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

function pick<T>(items: readonly T[], rng: BotRng): T {
  return items[Math.min(items.length - 1, Math.floor(rng() * items.length))];
}

function withOwner(s: GameState, idx: number, owner: number): GameState {
  return { ...s, tiles: s.tiles.map((t, i) => (i === idx ? { ...t, owner } : t)) };
}

function winsWith(s: GameState, seat: number, idx: number): boolean {
  return instantWin(withOwner(s, idx, seat), seat) !== null;
}

function rivalsOf(s: GameState, seat: number): number[] {
  return activeSeats(s).filter((r) => r !== seat);
}

function travelScore(s: GameState, seat: number, idx: number): number {
  const tile = BOARD[idx];
  const t = s.tiles[idx];
  const p = s.players[seat];
  switch (tile.kind) {
    case 'street':
    case 'station': {
      if (t.owner === seat) return 50;
      if (t.owner >= 0) return -computeRent(s, idx, t.owner);
      if (p.cash < (tile.price ?? 0)) return 0;
      if (winsWith(s, seat, idx)) return 1000;
      if (activeSeats(s).some((rival) => rival !== seat && winsWith(s, rival, idx))) return 900;
      const group = tile.group ?? '';
      if (ownedCount(s, seat, group) === tilesOfGroup(group).length - 1) return 300;
      return 100 + (tile.price ?? 0) / 10;
    }
    case 'festival':
      return festivalPick(s, seat) >= 0 ? 80 : 40;
    case 'tax':
      return -taxAmount(s, seat);
    default:
      return 40;
  }
}

function travelRanking(s: GameState, seat: number): { idx: number; score: number }[] {
  const pos = s.players[seat].pos;
  return BOARD.map((_, idx) => idx)
    .filter((idx) => idx !== pos)
    .map((idx) => ({ idx, score: travelScore(s, seat, idx) }));
}

function normalMove(s: GameState, seat: number): Move | null {
  const p = s.players[seat];
  switch (s.phase) {
    case 'roll':
      return { type: 'ROLL' };
    case 'jail':
      if (p.jailCards.length > 0) return { type: 'JAIL_CARD' };
      if (p.cash >= JAIL_FINE + 400 && p.jailTurns < 2) return { type: 'JAIL_PAY' };
      return { type: 'JAIL_ROLL' };
    case 'decide': {
      const tile = BOARD[p.pos];
      const price = tile.price ?? 0;
      const group = tile.group ?? '';
      const nearlyFull = group ? ownedCount(s, seat, group) === tilesOfGroup(group).length - 1 : false;
      const blocks = activeSeats(s).some((rival) => rival !== seat && winsWith(s, rival, p.pos));
      const buffer = nearlyFull || blocks ? 0 : CASH_BUFFER;
      return p.cash - price >= buffer ? { type: 'BUY' } : { type: 'DECLINE' };
    }
    case 'takeover': {
      const group = BOARD[p.pos].group ?? '';
      const owner = s.tiles[p.pos].owner;
      const left = p.cash - takeoverPrice(s, p.pos);
      const completes = tilesOfGroup(group).every((idx) => idx === p.pos || s.tiles[idx].owner === seat);
      const breaks = ownsGroup(s, owner, group);
      if (left >= 0 && winsWith(s, seat, p.pos)) return { type: 'TAKEOVER' };
      return (completes && left >= CASH_BUFFER) || (breaks && left >= CASH_BUFFER * 3) ? { type: 'TAKEOVER' } : { type: 'DECLINE' };
    }
    case 'festival': {
      const tile = festivalPick(s, seat);
      return tile >= 0 && tile !== s.festival ? { type: 'FESTIVAL', tile } : { type: 'DECLINE' };
    }
    case 'travel': {
      let best = -1;
      let bestScore = -Infinity;
      BOARD.forEach((_, idx) => {
        if (idx === p.pos) return;
        const score = travelScore(s, seat, idx);
        if (score > bestScore) [best, bestScore] = [idx, score];
      });
      return { type: 'TRAVEL', tile: best };
    }
    case 'card':
      return { type: 'CARD_ACK' };
    case 'manage': {
      let best = -1;
      s.tiles.forEach((t, idx) => {
        if (t.owner !== seat || canBuildError(s, seat, idx)) return;
        if (p.cash - levelCost(idx, t.houses + 1) < CASH_BUFFER * 2) return;
        if (best < 0 || (BOARD[idx].rent?.[t.houses + 1] ?? 0) > (BOARD[best].rent?.[s.tiles[best].houses + 1] ?? 0)) best = idx;
      });
      if (best >= 0) return { type: 'BUILD', tile: best };
      return { type: 'END_TURN' };
    }
    case 'debt':
      return { type: 'SETTLE_DEBT' };
  }
}

function easyMove(s: GameState, seat: number, rng: BotRng): Move | null {
  const p = s.players[seat];
  switch (s.phase) {
    case 'jail':
      if (p.cash >= JAIL_FINE) return { type: 'JAIL_PAY' };
      if (p.jailCards.length > 0) return { type: 'JAIL_CARD' };
      return { type: 'JAIL_ROLL' };
    case 'decide': {
      const price = BOARD[p.pos].price ?? 0;
      if (p.cash >= price && winsWith(s, seat, p.pos)) return { type: 'BUY' };
      return p.cash - price >= EASY_BUY_BUFFER && rng() < EASY_BUY_CHANCE ? { type: 'BUY' } : { type: 'DECLINE' };
    }
    case 'takeover':
      return p.cash >= takeoverPrice(s, p.pos) && winsWith(s, seat, p.pos) ? { type: 'TAKEOVER' } : { type: 'DECLINE' };
    case 'festival': {
      const own = s.tiles.map((_, idx) => idx).filter((idx) => s.tiles[idx].owner === seat && BOARD[idx].kind === 'street');
      return own.length > 0 ? { type: 'FESTIVAL', tile: pick(own, rng) } : { type: 'DECLINE' };
    }
    case 'travel': {
      const ranked = travelRanking(s, seat).sort((a, b) => b.score - a.score);
      const safe = ranked.filter((r) => r.score >= 0);
      const pool = (safe.length > 0 ? safe : ranked).slice(0, EASY_TRAVEL_TOP);
      return { type: 'TRAVEL', tile: pick(pool, rng).idx };
    }
    case 'manage': {
      if (s.steps.some((st) => st.kind === 'build' && st.by === seat)) return { type: 'END_TURN' };
      const options = s.tiles
        .map((_, idx) => idx)
        .filter((idx) => !canBuildError(s, seat, idx) && p.cash - levelCost(idx, s.tiles[idx].houses + 1) >= CASH_BUFFER * 2);
      if (options.length === 0 || rng() >= EASY_BUILD_CHANCE) return { type: 'END_TURN' };
      return { type: 'BUILD', tile: pick(options, rng) };
    }
    default:
      return normalMove(s, seat);
  }
}

function landChance(s: GameState, idx: number, seats: readonly number[]): number {
  let chance = 0;
  for (const seat of seats) chance += DICE[(idx - s.players[seat].pos + BOARD_SIZE) % BOARD_SIZE] ?? 0;
  return chance;
}

function costAt(s: GameState, seat: number, idx: number): number {
  const t = s.tiles[idx];
  if (BOARD[idx].kind === 'tax') return taxAmount(s, seat);
  if (t.owner < 0 || t.owner === seat || s.players[t.owner].bankrupt || s.players[t.owner].quit) return 0;
  return computeRent(s, idx, t.owner);
}

function expectedRent(s: GameState, seat: number, from: number): number {
  let total = 0;
  for (let k = 2; k <= 12; k++) total += DICE[k] * costAt(s, seat, (from + k) % BOARD_SIZE);
  return total;
}

function reserveFor(s: GameState, seat: number, from: number): number {
  return CASH_BUFFER + expectedRent(s, seat, from);
}

function shortfall(s: GameState, seat: number, members: readonly number[]): number {
  let miss = 0;
  for (const idx of members) {
    const t = s.tiles[idx];
    if (t.owner === seat) continue;
    if (t.owner >= 0 && !s.players[t.owner].bankrupt && (BOARD[idx].kind !== 'street' || t.houses >= MAX_HOUSES)) return Infinity;
    miss++;
  }
  return miss;
}

function missingToWin(s: GameState, seat: number): number {
  const groups = STREET_GROUPS.map((g) => shortfall(s, seat, tilesOfGroup(g))).sort((a, b) => a - b);
  const byGroups = groups.slice(0, WIN_GROUPS).reduce((sum, n) => sum + n, 0);
  const byLine = Math.min(...SIDE_STREETS.map((side) => shortfall(s, seat, side)));
  return Math.min(byGroups, byLine, shortfall(s, seat, STATIONS));
}

function threatens(s: GameState, rival: number, idx: number): boolean {
  return missingToWin(withOwner(s, idx, rival), rival) <= 1;
}

function lateGame(s: GameState, seat: number): boolean {
  const owned = PROPERTIES.filter((idx) => s.tiles[idx].owner >= 0).length;
  const rivalHouses = s.tiles.some((t) => t.owner >= 0 && t.owner !== seat && t.houses > 0);
  return rivalHouses || owned * 2 >= PROPERTIES.length;
}

function takeoverAffordable(s: GameState, seat: number, idx: number, left: number): boolean {
  const t = s.tiles[idx];
  if (BOARD[idx].kind !== 'street' || t.owner < 0 || t.owner === seat || t.houses >= MAX_HOUSES || s.players[t.owner].bankrupt) return false;
  return s.players[seat].cash - computeRent(s, idx, t.owner) - takeoverPrice(s, idx) >= left;
}

function travelValues(s: GameState, seat: number): { idx: number; value: number }[] {
  return travelRanking(s, seat).map(({ idx, score }) => ({ idx, value: score - expectedRent(s, seat, idx) }));
}

function hardRule(s: GameState, seat: number): Move | null {
  const p = s.players[seat];
  const rivals = rivalsOf(s, seat);
  switch (s.phase) {
    case 'jail': {
      const freeAhead = DICE.reduce((sum, chance, k) => {
        const idx = (JAIL_TILE + k) % BOARD_SIZE;
        return isProperty(BOARD[idx].kind) && s.tiles[idx].owner < 0 ? sum + chance : sum;
      }, 0);
      const wantOut = !lateGame(s, seat) || (expectedRent(s, seat, JAIL_TILE) < JAIL_FINE && freeAhead >= HARD_JAIL_FREE_AHEAD);
      if (!wantOut) return { type: 'JAIL_ROLL' };
      if (p.jailCards.length > 0) return { type: 'JAIL_CARD' };
      if (p.cash - JAIL_FINE >= reserveFor(s, seat, JAIL_TILE)) return { type: 'JAIL_PAY' };
      return { type: 'JAIL_ROLL' };
    }
    case 'decide': {
      const tile = BOARD[p.pos];
      const price = tile.price ?? 0;
      if (p.cash < price) return { type: 'DECLINE' };
      if (winsWith(s, seat, p.pos) || rivals.some((r) => winsWith(s, r, p.pos))) return { type: 'BUY' };
      const group = tile.group ?? '';
      if (group && ownedCount(s, seat, group) === tilesOfGroup(group).length - 1) return { type: 'BUY' };
      if (price > HARD_BUY_MAX_PRICE) return { type: 'DECLINE' };
      const reserve = reserveFor(s, seat, p.pos);
      const threat = rivals.some((r) => threatens(s, r, p.pos));
      const contested = group !== 'station' && ownedCount(s, seat, group) === 0 && rivals.some((r) => ownedCount(s, r, group) > 0);
      const buffer = threat ? reserve * HARD_THREAT_RESERVE : contested ? reserve * HARD_CONTEST_RESERVE : reserve;
      return p.cash - price >= buffer ? { type: 'BUY' } : { type: 'DECLINE' };
    }
    case 'takeover': {
      const tile = BOARD[p.pos];
      const price = tile.price ?? 0;
      const left = p.cash - takeoverPrice(s, p.pos);
      if (left < 0) return { type: 'DECLINE' };
      if (winsWith(s, seat, p.pos)) return { type: 'TAKEOVER' };
      const completes = tilesOfGroup(tile.group ?? '').every((idx) => idx === p.pos || s.tiles[idx].owner === seat);
      if (completes && price <= HARD_TAKEOVER_COMPLETE.price && left >= HARD_TAKEOVER_COMPLETE.left) return { type: 'TAKEOVER' };
      return price <= HARD_TAKEOVER_CHEAP.price && left >= HARD_TAKEOVER_CHEAP.left ? { type: 'TAKEOVER' } : { type: 'DECLINE' };
    }
    case 'festival': {
      let best = -1;
      let bestScore = -Infinity;
      s.tiles.forEach((t, idx) => {
        if (t.owner !== seat || BOARD[idx].kind !== 'street') return;
        const base = computeRent({ ...s, festival: -1 }, idx, seat);
        const score = landChance(s, idx, rivals) * base + base / 1000;
        if (score > bestScore) [best, bestScore] = [idx, score];
      });
      return best >= 0 && best !== s.festival ? { type: 'FESTIVAL', tile: best } : { type: 'DECLINE' };
    }
    case 'travel': {
      let best = -1;
      let bestScore = -Infinity;
      for (const { idx, value } of travelValues(s, seat)) if (value > bestScore) [best, bestScore] = [idx, value];
      return { type: 'TRAVEL', tile: best };
    }
    case 'manage': {
      const reserve = reserveFor(s, seat, p.pos);
      const base = rivals.length / BOARD_SIZE;
      let best = -1;
      let bestScore = 0;
      s.tiles.forEach((t, idx) => {
        if (t.owner !== seat || canBuildError(s, seat, idx)) return;
        if (p.cash - levelCost(idx, t.houses + 1) < reserve - CASH_BUFFER / 2) return;
        const built = { ...s, tiles: s.tiles.map((x, i) => (i === idx ? { ...x, houses: x.houses + 1 } : x)) };
        const score = (landChance(s, idx, rivals) + base) * (computeRent(built, idx, seat) - computeRent(s, idx, seat));
        if (score > bestScore) [best, bestScore] = [idx, score];
      });
      return best >= 0 ? { type: 'BUILD', tile: best } : { type: 'END_TURN' };
    }
    default:
      return normalMove(s, seat);
  }
}

function hardOptions(s: GameState, seat: number, rule: Move): Move[] {
  const p = s.players[seat];
  switch (s.phase) {
    case 'takeover':
      return p.cash >= takeoverPrice(s, p.pos) ? [{ type: 'TAKEOVER' }, { type: 'DECLINE' }] : [rule];
    case 'jail': {
      const out: Move[] = [{ type: 'JAIL_ROLL' }];
      if (p.cash >= JAIL_FINE) out.push({ type: 'JAIL_PAY' });
      if (p.jailCards.length > 0) out.push({ type: 'JAIL_CARD' });
      return out;
    }
    case 'festival': {
      const rivals = rivalsOf(s, seat);
      const own = s.tiles
        .map((t, idx) => ({ t, idx }))
        .filter(({ t, idx }) => t.owner === seat && BOARD[idx].kind === 'street')
        .map(({ idx }) => ({ idx, value: landChance(s, idx, rivals) * computeRent({ ...s, festival: -1 }, idx, seat) }))
        .sort((a, b) => b.value - a.value)
        .slice(0, SIM_FESTIVAL_TOP)
        .map(({ idx }): Move => ({ type: 'FESTIVAL', tile: idx }));
      return own.length > 0 ? own : [rule];
    }
    case 'travel': {
      const ranked = travelValues(s, seat).sort((a, b) => b.value - a.value);
      const top = ranked.slice(0, SIM_TRAVEL_TOP).map(({ idx }) => idx);
      const targets = ranked
        .filter(({ idx }) => !top.includes(idx) && takeoverAffordable(s, seat, idx, SIM_TAKEOVER_LEFT))
        .sort((a, b) => (BOARD[a.idx].price ?? 0) - (BOARD[b.idx].price ?? 0))
        .slice(0, SIM_TAKEOVER_TARGETS)
        .map(({ idx }) => idx);
      return [...top, ...targets].map((idx): Move => ({ type: 'TRAVEL', tile: idx }));
    }
    default:
      return [rule];
  }
}

function shuffled(items: readonly number[], rng: BotRng): number[] {
  const out = [...items];
  for (let i = out.length - 1; i > 0; i--) {
    const j = Math.floor(rng() * (i + 1));
    [out[i], out[j]] = [out[j], out[i]];
  }
  return out;
}

function weightedWorth(s: GameState, seat: number): number {
  const p = s.players[seat];
  if (!p || p.bankrupt) return 0;
  return p.cash + SIM_PROPERTY_WEIGHT * (worth(s, seat) - p.cash);
}

function evaluate(s: GameState, seat: number): number {
  const rivals = rivalsOf(s, seat).map((r) => weightedWorth(s, r));
  const diff = weightedWorth(s, seat) - (rivals.length > 0 ? Math.max(...rivals) : 0);
  if (!isOver(s)) return diff;
  return (rankings(s)[0] === seat ? SIM_WIN_SCORE : -SIM_WIN_SCORE) + diff;
}

function rollout(start: GameState, seat: number): number {
  let x = start;
  let turns = SIM_TURNS;
  for (let guard = 0; guard < SIM_MAX_MOVES && turns > 0 && !isOver(x); guard++) {
    const mover = x.turn;
    const move = (mover === seat ? hardRule(x, mover) : normalMove(x, mover)) ?? moveOnTimeout(x, mover);
    if (!move) break;
    let next: GameState;
    try {
      next = applyMove(x, mover, move);
    } catch {
      const fallback = moveOnTimeout(x, mover);
      if (!fallback) break;
      try {
        next = applyMove(x, mover, fallback);
      } catch {
        break;
      }
    }
    if (next.turn !== x.turn) turns--;
    x = next;
  }
  return evaluate(x, seat);
}

function simulate(s: GameState, seat: number, moves: readonly Move[], rng: BotRng): Move {
  const totals = moves.map(() => 0);
  const games = Math.min(SIM_GAMES, Math.floor(SIM_ROLLOUTS / moves.length));
  for (let i = 0; i < games; i++) {
    const hidden: GameState = {
      ...s,
      rng: (BigInt(Math.floor(rng() * 2 ** 32)) << 32n) | BigInt(Math.floor(rng() * 2 ** 32)),
      chanceDeck: shuffled(s.chanceDeck, rng),
      chestDeck: shuffled(s.chestDeck, rng),
    };
    moves.forEach((move, k) => {
      totals[k] += rollout(applyMove(hidden, seat, move), seat);
    });
  }
  let best = 0;
  totals.forEach((total, k) => {
    if (total > totals[best]) best = k;
  });
  return moves[best];
}

function hardMove(s: GameState, seat: number, rng: BotRng): Move | null {
  const rule = hardRule(s, seat);
  if (!rule || !SIM_PHASES.has(s.phase)) return rule;
  const options = hardOptions(s, seat, rule);
  return options.length > 1 ? simulate(s, seat, options, rng) : options[0];
}

export function botMove(s: GameState, seat: number, level: BotLevel = 'normal', rng: BotRng = botRng(s.moveCount, seat, 0)): Move | null {
  if (s.finished || s.turn !== seat) return null;
  if (level === 'easy') return easyMove(s, seat, rng);
  if (level === 'hard') return hardMove(s, seat, rng);
  return normalMove(s, seat);
}

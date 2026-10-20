import { BOARD, CARDS, tilesOfGroup, type CardData } from './board';
import {
  BIRTHDAY_GIFT,
  BOARD_SIZE,
  FESTIVAL_MULTIPLIER,
  GO_SALARY,
  JAIL_FINE,
  JAIL_MAX_TURNS,
  JAIL_TILE,
  MAX_DOUBLES,
  MAX_HOUSES,
  MAX_ROUNDS,
  SIDE_TILES,
  START_CASH,
  STATION_RENT,
  TAKEOVER_MULTIPLIER,
  TAX_RATE,
  WIN_GROUPS,
  type EndReason,
  type PayReason,
} from './constants';
import { RuleError, type CardRef, type Debt, type GameState, type Move, type Step } from './types';

const MASK = (1n << 64n) - 1n;

function rngNext(state: GameState): bigint {
  state.rng = (state.rng + 0x9e3779b97f4a7c15n) & MASK;
  let v = state.rng;
  v ^= v >> 30n;
  v = (v * 0xbf58476d1ce4e5b9n) & MASK;
  v ^= v >> 27n;
  v = (v * 0x94d049bb133111ebn) & MASK;
  v ^= v >> 31n;
  return v;
}

function rngInt(state: GameState, n: number): number {
  return Number(rngNext(state) % BigInt(n));
}

function shuffle(state: GameState, deck: number[]): void {
  for (let i = deck.length - 1; i > 0; i--) {
    const j = rngInt(state, i + 1);
    [deck[i], deck[j]] = [deck[j], deck[i]];
  }
}

const CHANCE = CARDS.filter((c) => c.deck === 'chance');
const CHEST = CARDS.filter((c) => c.deck === 'chest');

function deckCards(deck: 'chance' | 'chest'): CardData[] {
  return deck === 'chance' ? CHANCE : CHEST;
}

export function newGame(seed: number, playerCount: number): GameState {
  const count = Math.min(4, Math.max(2, playerCount));
  const state: GameState = {
    players: Array.from({ length: count }, () => ({ cash: START_CASH, pos: 0, inJail: false, jailTurns: 0, jailCards: 0, bankrupt: false, doubles: 0, quit: false, travel: false })),
    tiles: Array.from({ length: BOARD_SIZE }, () => ({ owner: -1, houses: 0 })),
    turn: 0,
    phase: 'roll',
    dice: [0, 0],
    debt: null,
    pendingDebts: [],
    card: null,
    festival: -1,
    chanceDeck: CHANCE.map((_, i) => i),
    chestDeck: CHEST.map((_, i) => i),
    rng: BigInt(Math.floor(seed)) & MASK,
    round: 1,
    bankruptOrder: [],
    finished: false,
    winner: -1,
    endReason: null,
    moveCount: 0,
    steps: [],
  };
  shuffle(state, state.chanceDeck);
  shuffle(state, state.chestDeck);
  return state;
}

export function cloneState(s: GameState): GameState {
  return {
    ...s,
    players: s.players.map((p) => ({ ...p })),
    tiles: s.tiles.map((t) => ({ ...t })),
    dice: [s.dice[0], s.dice[1]],
    debt: s.debt ? { ...s.debt } : null,
    pendingDebts: s.pendingDebts.map((d) => ({ ...d })),
    card: s.card ? { ...s.card } : null,
    chanceDeck: [...s.chanceDeck],
    chestDeck: [...s.chestDeck],
    bankruptOrder: [...s.bankruptOrder],
    steps: [],
  };
}

export function isActive(s: GameState, seat: number): boolean {
  const p = s.players[seat];
  return !!p && !p.bankrupt && !p.quit;
}

export function activeSeats(s: GameState): number[] {
  return s.players.map((_, i) => i).filter((i) => isActive(s, i));
}

function nextActive(s: GameState, from: number): number {
  const n = s.players.length;
  for (let i = 1; i <= n; i++) {
    const j = (from + i) % n;
    if (isActive(s, j)) return j;
  }
  return -1;
}

function push(s: GameState, step: Step): void {
  s.steps.push(step);
}

export function ownsGroup(s: GameState, seat: number, group: string): boolean {
  const tiles = tilesOfGroup(group);
  return tiles.length > 0 && tiles.every((idx) => s.tiles[idx].owner === seat);
}

export function ownedCount(s: GameState, seat: number, group: string): number {
  return tilesOfGroup(group).filter((idx) => s.tiles[idx].owner === seat).length;
}

export function houseValue(s: GameState, seat: number): number {
  return s.tiles.reduce((sum, t, idx) => (t.owner === seat && t.houses > 0 ? sum + t.houses * (BOARD[idx].houseCost ?? 0) : sum), 0);
}

export function worth(s: GameState, seat: number): number {
  const p = s.players[seat];
  if (!p || p.bankrupt) return 0;
  return s.tiles.reduce((sum, t, idx) => (t.owner === seat ? sum + (BOARD[idx].price ?? 0) + t.houses * (BOARD[idx].houseCost ?? 0) : sum), p.cash);
}

export function liquidationValue(s: GameState, seat: number): number {
  return Math.floor(houseValue(s, seat) / 2);
}

export function computeRent(s: GameState, idx: number, owner: number): number {
  const tile = BOARD[idx];
  switch (tile.kind) {
    case 'street': {
      const houses = s.tiles[idx].houses;
      const rent = tile.rent?.[houses] ?? 0;
      const base = houses === 0 && tile.group && ownsGroup(s, owner, tile.group) ? rent * 2 : rent;
      return s.festival === idx ? base * FESTIVAL_MULTIPLIER : base;
    }
    case 'station':
      return STATION_RENT[ownedCount(s, owner, 'station')] ?? 0;
    default:
      return 0;
  }
}

export function canBuildError(s: GameState, seat: number, idx: number): string | null {
  const tile = BOARD[idx];
  const t = s.tiles[idx];
  if (tile.kind !== 'street' || !tile.group) return 'not_street';
  if (t.owner !== seat) return 'not_owner';
  if (!ownsGroup(s, seat, tile.group)) return 'not_group_owner';
  if (t.houses >= MAX_HOUSES) return 'max_houses';
  if (s.players[seat].cash < (tile.houseCost ?? 0)) return 'no_cash';
  for (const g of tilesOfGroup(tile.group)) if (t.houses > s.tiles[g].houses) return 'build_uneven';
  return null;
}

export function canSellError(s: GameState, seat: number, idx: number): string | null {
  const tile = BOARD[idx];
  const t = s.tiles[idx];
  if (tile.kind !== 'street' || !tile.group) return 'not_street';
  if (t.owner !== seat) return 'not_owner';
  if (t.houses <= 0) return 'no_houses';
  for (const g of tilesOfGroup(tile.group)) if (t.houses < s.tiles[g].houses) return 'sell_uneven';
  return null;
}

export function taxAmount(s: GameState, seat: number): number {
  return Math.round(worth(s, seat) * TAX_RATE);
}

export function festivalPick(s: GameState, seat: number): number {
  let best = -1;
  s.tiles.forEach((t, idx) => {
    if (t.owner !== seat || BOARD[idx].kind !== 'street') return;
    if (best < 0 || computeRent(s, idx, seat) > computeRent(s, best, seat)) best = idx;
  });
  return best;
}

export function takeoverPrice(s: GameState, idx: number): number {
  return TAKEOVER_MULTIPLIER * ((BOARD[idx].price ?? 0) + s.tiles[idx].houses * (BOARD[idx].houseCost ?? 0));
}

export function canTakeoverError(s: GameState, seat: number, idx: number): string | null {
  const t = s.tiles[idx];
  if (BOARD[idx].kind !== 'street') return 'not_street';
  if (t.owner < 0 || t.owner === seat || !isActive(s, t.owner)) return 'not_takeover';
  if (t.houses >= MAX_HOUSES) return 'takeover_hotel';
  if (s.players[seat].cash < takeoverPrice(s, idx)) return 'no_cash';
  return null;
}

const STREET_GROUPS = [...new Set(BOARD.filter((t) => t.kind === 'street').map((t) => t.group as string))];

const SIDE_STREETS = [0, 1, 2, 3].map((side) =>
  BOARD.filter((t, idx) => t.kind === 'street' && Math.floor(idx / SIDE_TILES) === side).map((t) => t.idx),
);

export function instantWin(s: GameState, seat: number): EndReason | null {
  if (STREET_GROUPS.filter((g) => ownsGroup(s, seat, g)).length >= WIN_GROUPS) return 'groups';
  if (SIDE_STREETS.some((tiles) => tiles.length > 0 && tiles.every((idx) => s.tiles[idx].owner === seat))) return 'line';
  if (ownsGroup(s, seat, 'station')) return 'airports';
  return null;
}

function checkInstantWin(s: GameState, seat: number): boolean {
  if (s.finished || !isActive(s, seat)) return false;
  const reason = instantWin(s, seat);
  if (!reason) return false;
  s.winner = seat;
  finish(s, reason);
  return true;
}

function rollDice(s: GameState): [number, number] {
  const a = rngInt(s, 6) + 1;
  const b = rngInt(s, 6) + 1;
  s.dice = [a, b];
  return [a, b];
}

function paySalary(s: GameState, seat: number): void {
  s.players[seat].cash += GO_SALARY;
  push(s, { kind: 'pay', by: -1, target: seat, amount: GO_SALARY, reason: 'salary' });
}

function leaveJail(s: GameState, seat: number, how: string): void {
  const p = s.players[seat];
  p.inJail = false;
  p.jailTurns = 0;
  push(s, { kind: 'jail-out', by: seat, how });
}

function sendToJail(s: GameState, seat: number, how: string): void {
  const p = s.players[seat];
  const from = p.pos;
  p.pos = JAIL_TILE;
  p.inJail = true;
  p.jailTurns = 0;
  p.doubles = 0;
  p.travel = false;
  push(s, { kind: 'teleport', by: seat, from, to: JAIL_TILE });
  push(s, { kind: 'jail-in', by: seat, how });
}

function pay(s: GameState, from: number, to: number, amount: number, reason: PayReason, after?: 'move'): boolean {
  if (amount <= 0) return true;
  const p = s.players[from];
  if (p.cash >= amount) {
    p.cash -= amount;
    if (to >= 0 && isActive(s, to)) s.players[to].cash += amount;
    push(s, { kind: 'pay', by: from, target: to, amount, reason });
    return true;
  }
  if (p.cash + liquidationValue(s, from) < amount) {
    bankrupt(s, from, to);
    return false;
  }
  enterDebt(s, { creditor: to, amount, by: from, returnTo: s.turn, after, reason });
  return false;
}

function enterDebt(s: GameState, d: Debt): void {
  if (s.phase === 'debt' && s.debt) {
    s.pendingDebts.push({ ...d, returnTo: s.debt.returnTo });
    return;
  }
  s.debt = d;
  s.phase = 'debt';
  s.turn = d.by;
  push(s, { kind: 'debt', by: d.by, creditor: d.creditor, amount: d.amount, reason: d.reason });
}

function resolveDebt(s: GameState): void {
  const d = s.debt!;
  s.debt = null;
  while (s.pendingDebts.length > 0) {
    const next = s.pendingDebts.shift()!;
    if (!isActive(s, next.by)) continue;
    s.debt = next;
    s.phase = 'debt';
    s.turn = next.by;
    push(s, { kind: 'debt', by: next.by, creditor: next.creditor, amount: next.amount, reason: next.reason });
    return;
  }
  if (!isActive(s, d.returnTo)) {
    s.turn = d.returnTo;
    advanceTurn(s);
    return;
  }
  s.turn = d.returnTo;
  s.phase = 'manage';
}

function settleDebt(s: GameState, seat: number): void {
  const d = s.debt!;
  s.players[seat].cash -= d.amount;
  if (d.creditor >= 0 && isActive(s, d.creditor)) s.players[d.creditor].cash += d.amount;
  push(s, { kind: 'pay', by: seat, target: d.creditor, amount: d.amount, reason: d.reason });
  resolveDebt(s);
  if (d.after === 'move' && s.turn === seat && s.phase === 'manage') {
    leaveJail(s, seat, 'forced');
    movePlayer(s, seat, s.dice[0] + s.dice[1]);
  }
}

function autoSellForDebt(s: GameState, seat: number): void {
  const amount = s.debt!.amount;
  while (s.players[seat].cash < amount) {
    let best = -1;
    s.tiles.forEach((t, idx) => {
      if (t.owner !== seat || t.houses === 0 || canSellError(s, seat, idx)) return;
      if (best < 0 || t.houses > s.tiles[best].houses || (t.houses === s.tiles[best].houses && (BOARD[idx].houseCost ?? 0) > (BOARD[best].houseCost ?? 0))) best = idx;
    });
    if (best < 0) return;
    sellHouse(s, seat, best);
  }
}

function build(s: GameState, seat: number, idx: number): void {
  const cost = BOARD[idx].houseCost ?? 0;
  s.players[seat].cash -= cost;
  s.tiles[idx].houses++;
  push(s, { kind: 'pay', by: seat, target: -1, amount: cost, reason: 'build', tile: idx });
  push(s, { kind: 'build', by: seat, tile: idx, houses: s.tiles[idx].houses });
}

function sellHouse(s: GameState, seat: number, idx: number): void {
  const refund = Math.floor((BOARD[idx].houseCost ?? 0) / 2);
  s.players[seat].cash += refund;
  s.tiles[idx].houses--;
  push(s, { kind: 'sell', by: seat, tile: idx, houses: s.tiles[idx].houses });
  push(s, { kind: 'pay', by: -1, target: seat, amount: refund, reason: 'sell', tile: idx });
}

function drawCard(s: GameState, seat: number, deck: 'chance' | 'chest'): void {
  const pile = deck === 'chance' ? s.chanceDeck : s.chestDeck;
  if (pile.length === 0) return;
  const id = pile.shift()!;
  pile.push(id);
  const card = deckCards(deck)[id];
  s.card = { deck, id: card.id };
  s.phase = 'card';
  push(s, { kind: 'card', by: seat, deck, card: card.id });
}

function cardByRef(ref: CardRef): CardData | undefined {
  return deckCards(ref.deck).find((c) => c.id === ref.id);
}

function removeFromDeck(s: GameState, deck: 'chance' | 'chest', cardId: string): void {
  const cards = deckCards(deck);
  const pile = deck === 'chance' ? s.chanceDeck : s.chestDeck;
  const at = pile.findIndex((id) => cards[id].id === cardId);
  if (at >= 0) pile.splice(at, 1);
}

function nearestTile(from: number, kind: string): number {
  for (let step = 1; step <= BOARD_SIZE; step++) {
    const idx = (from + step) % BOARD_SIZE;
    if (BOARD[idx].kind === kind) return idx;
  }
  return from;
}

function applyCard(s: GameState, seat: number, card: CardData | undefined): void {
  if (!card) return;
  const p = s.players[seat];
  switch (card.effect) {
    case 'moveTo':
      teleport(s, seat, card.tile ?? 0, true, 1);
      return;
    case 'moveToNearest': {
      const to = nearestTile(p.pos, card.kind ?? 'station');
      teleport(s, seat, to, true, card.amount ?? 2);
      return;
    }
    case 'cash': {
      const amount = card.amount ?? 0;
      if (amount >= 0) {
        p.cash += amount;
        push(s, { kind: 'pay', by: -1, target: seat, amount, reason: 'card' });
      } else {
        pay(s, seat, -1, -amount, 'card');
      }
      return;
    }
    case 'jailCard':
      p.jailCards++;
      removeFromDeck(s, card.deck, card.id);
      return;
    case 'goToJail':
      sendToJail(s, seat, 'card');
      return;
    case 'repair': {
      const levels = s.tiles.reduce((sum, t) => (t.owner === seat ? sum + t.houses : sum), 0);
      pay(s, seat, -1, levels * (card.amount ?? 0), 'repair');
      return;
    }
    case 'collectEach':
      for (const other of activeSeats(s)) {
        if (other !== seat) pay(s, other, seat, card.amount ?? BIRTHDAY_GIFT, 'birthday');
      }
      return;
  }
}

function land(s: GameState, seat: number, rentMul: number): void {
  const p = s.players[seat];
  const tile = BOARD[p.pos];
  push(s, { kind: 'land', by: seat, tile: p.pos });
  s.phase = 'manage';
  switch (tile.kind) {
    case 'street':
    case 'station': {
      const owner = s.tiles[p.pos].owner;
      if (owner < 0) {
        s.phase = 'decide';
        return;
      }
      if (owner === seat || !isActive(s, owner)) return;
      let rent = computeRent(s, p.pos, owner);
      if (tile.kind === 'station' && rentMul > 1) rent *= rentMul;
      if (pay(s, seat, owner, rent, 'rent') && !canTakeoverError(s, seat, p.pos)) s.phase = 'takeover';
      return;
    }
    case 'tax':
      pay(s, seat, -1, taxAmount(s, seat), 'tax');
      return;
    case 'chance':
      drawCard(s, seat, 'chance');
      return;
    case 'chest':
      drawCard(s, seat, 'chest');
      return;
    case 'festival':
      if (festivalPick(s, seat) >= 0) s.phase = 'festival';
      return;
    case 'travel':
      p.travel = true;
      p.doubles = 0;
      push(s, { kind: 'travel', by: seat, tile: p.pos });
      return;
  }
}

function movePlayer(s: GameState, seat: number, steps: number): void {
  const p = s.players[seat];
  const from = p.pos;
  const to = (from + steps) % BOARD_SIZE;
  const passedGo = to < from;
  p.pos = to;
  push(s, { kind: 'move', by: seat, from, to, passedGo });
  if (passedGo) paySalary(s, seat);
  land(s, seat, 1);
}

function teleport(s: GameState, seat: number, to: number, passGo: boolean, rentMul: number): void {
  const p = s.players[seat];
  const from = p.pos;
  const passed = passGo && to < from;
  p.pos = to;
  push(s, { kind: 'teleport', by: seat, from, to, passedGo: passed });
  if (passed) paySalary(s, seat);
  land(s, seat, rentMul);
}

function rollAndMove(s: GameState, seat: number): void {
  const [a, b] = rollDice(s);
  const double = a === b;
  push(s, { kind: 'roll', by: seat, dice: [a, b], double });
  const p = s.players[seat];
  if (double) {
    p.doubles++;
    if (p.doubles >= MAX_DOUBLES) {
      p.doubles = 0;
      sendToJail(s, seat, 'dice3');
      s.phase = 'manage';
      return;
    }
  } else {
    p.doubles = 0;
  }
  movePlayer(s, seat, a + b);
}

function jailRoll(s: GameState, seat: number): void {
  const [a, b] = rollDice(s);
  const double = a === b;
  push(s, { kind: 'roll', by: seat, dice: [a, b], double });
  const p = s.players[seat];
  p.doubles = 0;
  if (double) {
    leaveJail(s, seat, 'double');
    movePlayer(s, seat, a + b);
    return;
  }
  p.jailTurns++;
  if (p.jailTurns < JAIL_MAX_TURNS) {
    s.phase = 'manage';
    return;
  }
  if (pay(s, seat, -1, JAIL_FINE, 'fine', 'move')) {
    leaveJail(s, seat, 'forced');
    movePlayer(s, seat, a + b);
  }
}

export function bankrupt(s: GameState, seat: number, creditor: number): void {
  const p = s.players[seat];
  const tiles: number[] = [];
  s.tiles.forEach((t, idx) => {
    if (t.owner !== seat) return;
    if (t.houses > 0) {
      p.cash += Math.floor((t.houses * (BOARD[idx].houseCost ?? 0)) / 2);
      t.houses = 0;
    }
    tiles.push(idx);
  });
  const toCreditor = creditor >= 0 && creditor !== seat && isActive(s, creditor);
  for (const idx of tiles) s.tiles[idx].owner = toCreditor ? creditor : -1;
  if (!toCreditor && tiles.includes(s.festival)) s.festival = -1;
  if (toCreditor) s.players[creditor].cash += p.cash;
  p.cash = 0;
  p.bankrupt = true;
  p.inJail = false;
  p.doubles = 0;
  s.bankruptOrder.push(seat);
  push(s, { kind: 'bankrupt', by: seat, creditor: toCreditor ? creditor : -1, tiles });
  s.pendingDebts = s.pendingDebts.filter((d) => d.by !== seat);
  s.card = null;
  if (activeSeats(s).length <= 1) {
    finish(s, 'last');
    return;
  }
  if (toCreditor && checkInstantWin(s, creditor)) return;
  if (s.phase === 'debt' && s.debt && s.debt.by === seat) {
    resolveDebt(s);
    return;
  }
  if (s.turn === seat) advanceTurn(s);
}

function advanceTurn(s: GameState): void {
  const from = s.turn;
  const next = nextActive(s, from);
  if (next < 0) {
    finish(s, 'last');
    return;
  }
  s.card = null;
  if (next <= from) {
    s.round++;
    push(s, { kind: 'round', by: -1, round: s.round });
    if (s.round > MAX_ROUNDS) {
      finish(s, 'rounds');
      return;
    }
  }
  s.turn = next;
  const p = s.players[next];
  p.doubles = 0;
  s.phase = p.inJail ? 'jail' : p.travel ? 'travel' : 'roll';
}

function finish(s: GameState, reason: EndReason): void {
  if (s.finished) return;
  s.finished = true;
  s.endReason = reason;
  const ranked = rankings(s);
  push(s, { kind: 'finish', by: -1, rankings: ranked, worth: ranked.map((seat) => worth(s, seat)), end: reason });
}

export function rankings(s: GameState): number[] {
  const active = activeSeats(s).sort((a, b) => Number(b === s.winner) - Number(a === s.winner) || worth(s, b) - worth(s, a) || a - b);
  return [...active, ...[...s.bankruptOrder].reverse()];
}

export function endByTime(input: GameState): GameState {
  const s = cloneState(input);
  finish(s, 'time');
  return s;
}

export function applyMove(input: GameState, seat: number, mv: Move): GameState {
  const s = cloneState(input);
  if (s.finished) throw new RuleError('finished');
  if (!isActive(s, seat)) throw new RuleError('not_active');
  if (s.turn !== seat) throw new RuleError('not_your_turn');
  const p = s.players[seat];
  const needPhase = (...phases: string[]) => {
    if (!phases.includes(s.phase)) throw new RuleError('wrong_phase');
  };
  const needTile = (): number => {
    if (mv.tile == null || mv.tile < 0 || mv.tile >= BOARD_SIZE) throw new RuleError('invalid_tile');
    return mv.tile;
  };
  switch (mv.type) {
    case 'ROLL':
      needPhase('roll', 'travel');
      p.travel = false;
      rollAndMove(s, seat);
      break;
    case 'JAIL_ROLL':
      needPhase('jail');
      jailRoll(s, seat);
      break;
    case 'JAIL_PAY':
      needPhase('jail');
      if (p.cash < JAIL_FINE) throw new RuleError('no_cash');
      p.cash -= JAIL_FINE;
      push(s, { kind: 'pay', by: seat, target: -1, amount: JAIL_FINE, reason: 'fine' });
      leaveJail(s, seat, 'pay');
      s.phase = 'roll';
      break;
    case 'JAIL_CARD':
      needPhase('jail');
      if (p.jailCards <= 0) throw new RuleError('no_jail_card');
      p.jailCards--;
      leaveJail(s, seat, 'card');
      s.phase = 'roll';
      break;
    case 'BUY': {
      needPhase('decide');
      const tile = BOARD[p.pos];
      const price = tile.price ?? 0;
      if (p.cash < price) throw new RuleError('no_cash');
      p.cash -= price;
      s.tiles[p.pos].owner = seat;
      push(s, { kind: 'pay', by: seat, target: -1, amount: price, reason: 'buy', tile: p.pos });
      push(s, { kind: 'buy', by: seat, tile: p.pos });
      s.phase = 'manage';
      checkInstantWin(s, seat);
      break;
    }
    case 'TAKEOVER': {
      needPhase('takeover');
      const idx = p.pos;
      const err = canTakeoverError(s, seat, idx);
      if (err) throw new RuleError(err);
      const owner = s.tiles[idx].owner;
      const price = takeoverPrice(s, idx);
      p.cash -= price;
      s.players[owner].cash += price;
      s.tiles[idx].owner = seat;
      push(s, { kind: 'pay', by: seat, target: owner, amount: price, reason: 'takeover', tile: idx });
      push(s, { kind: 'takeover', by: seat, tile: idx, target: owner, houses: s.tiles[idx].houses });
      s.phase = 'manage';
      checkInstantWin(s, seat);
      break;
    }
    case 'FESTIVAL': {
      needPhase('festival');
      const idx = needTile();
      if (BOARD[idx].kind !== 'street') throw new RuleError('not_street');
      if (s.tiles[idx].owner !== seat) throw new RuleError('not_owner');
      s.festival = idx;
      push(s, { kind: 'festival', by: seat, tile: idx });
      s.phase = 'manage';
      break;
    }
    case 'TRAVEL': {
      needPhase('travel');
      const idx = needTile();
      if (idx === p.pos) throw new RuleError('invalid_tile');
      p.travel = false;
      teleport(s, seat, idx, true, 1);
      break;
    }
    case 'DECLINE':
      needPhase('decide', 'takeover', 'festival');
      s.phase = 'manage';
      break;
    case 'CARD_ACK': {
      needPhase('card');
      if (!s.card) throw new RuleError('wrong_phase');
      const card = s.card;
      s.card = null;
      s.phase = 'manage';
      applyCard(s, seat, cardByRef(card));
      break;
    }
    case 'BUILD': {
      needPhase('manage');
      const idx = needTile();
      const err = canBuildError(s, seat, idx);
      if (err) throw new RuleError(err);
      build(s, seat, idx);
      break;
    }
    case 'SELL_HOUSE': {
      needPhase('manage', 'debt');
      const idx = needTile();
      const err = canSellError(s, seat, idx);
      if (err) throw new RuleError(err);
      sellHouse(s, seat, idx);
      break;
    }
    case 'PAY_DEBT':
      needPhase('debt');
      if (!s.debt) throw new RuleError('wrong_phase');
      if (p.cash < s.debt.amount) throw new RuleError('no_cash');
      settleDebt(s, seat);
      break;
    case 'SETTLE_DEBT': {
      needPhase('debt');
      if (!s.debt) throw new RuleError('wrong_phase');
      autoSellForDebt(s, seat);
      if (p.cash >= s.debt.amount) settleDebt(s, seat);
      else bankrupt(s, seat, s.debt.creditor);
      break;
    }
    case 'DECLARE_BANKRUPT':
      needPhase('debt');
      if (!s.debt) throw new RuleError('wrong_phase');
      bankrupt(s, seat, s.debt.creditor);
      break;
    case 'END_TURN':
      needPhase('manage');
      if (p.doubles > 0 && !p.inJail) s.phase = 'roll';
      else {
        p.doubles = 0;
        advanceTurn(s);
      }
      break;
    default:
      throw new RuleError('unknown_move');
  }
  s.moveCount++;
  return s;
}

export function moveOnTimeout(s: GameState, seat: number): Move | null {
  if (s.finished || !isActive(s, seat) || s.turn !== seat) return null;
  switch (s.phase) {
    case 'roll':
    case 'travel':
      return { type: 'ROLL' };
    case 'jail':
      return { type: 'JAIL_ROLL' };
    case 'festival':
      return { type: 'FESTIVAL', tile: festivalPick(s, seat) };
    case 'decide':
    case 'takeover':
      return { type: 'DECLINE' };
    case 'card':
      return { type: 'CARD_ACK' };
    case 'manage':
      return { type: 'END_TURN' };
    case 'debt':
      return { type: 'SETTLE_DEBT' };
  }
}

export function quitPlayer(input: GameState, seat: number): GameState {
  const s = cloneState(input);
  if (!isActive(s, seat)) return s;
  s.players[seat].quit = true;
  bankrupt(s, seat, -1);
  return s;
}

export function isOver(s: GameState): boolean {
  return s.finished || activeSeats(s).length <= 1;
}

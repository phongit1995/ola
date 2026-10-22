import { BOARD, tilesOfGroup } from './board';
import { JAIL_FINE } from './constants';
import { activeSeats, canBuildError, computeRent, festivalPick, instantWin, ownedCount, ownsGroup, takeoverPrice, taxAmount } from './engine';
import type { GameState, Move } from './types';

const CASH_BUFFER = 120;

function winsWith(s: GameState, seat: number, idx: number): boolean {
  const tiles = s.tiles.map((t, i) => (i === idx ? { ...t, owner: seat } : t));
  return instantWin({ ...s, tiles }, seat) !== null;
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

export function botMove(s: GameState, seat: number): Move | null {
  if (s.finished || s.turn !== seat) return null;
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
        if (p.cash - (BOARD[idx].houseCost ?? 0) < CASH_BUFFER * 2) return;
        if (best < 0 || (BOARD[idx].rent?.[t.houses + 1] ?? 0) > (BOARD[best].rent?.[s.tiles[best].houses + 1] ?? 0)) best = idx;
      });
      if (best >= 0) return { type: 'BUILD', tile: best };
      return { type: 'END_TURN' };
    }
    case 'debt':
      return { type: 'SETTLE_DEBT' };
  }
}

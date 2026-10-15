import { BOARD, tilesOfGroup } from './board';
import { JAIL_FINE } from './constants';
import { canBuildError, ownedCount } from './engine';
import type { GameState, Move } from './types';

const CASH_BUFFER = 120;

export function botMove(s: GameState, seat: number): Move | null {
  if (s.finished || s.turn !== seat) return null;
  const p = s.players[seat];
  switch (s.phase) {
    case 'roll':
      return { type: 'ROLL' };
    case 'jail':
      if (p.jailCards > 0) return { type: 'JAIL_CARD' };
      if (p.cash >= JAIL_FINE + 400 && p.jailTurns < 2) return { type: 'JAIL_PAY' };
      return { type: 'JAIL_ROLL' };
    case 'decide': {
      const tile = BOARD[p.pos];
      const price = tile.price ?? 0;
      const group = tile.group ?? '';
      const nearlyFull = group ? ownedCount(s, seat, group) === tilesOfGroup(group).length - 1 : false;
      const buffer = nearlyFull ? 0 : CASH_BUFFER;
      return p.cash - price >= buffer ? { type: 'BUY' } : { type: 'DECLINE' };
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

import { cloneState } from './engine';
import type { GameState, TycoonView } from './types';

export function viewFor(state: GameState, seat: number): TycoonView {
  const copy = cloneState(state);
  return {
    players: copy.players,
    tiles: copy.tiles,
    turn: copy.turn,
    phase: copy.phase,
    dice: copy.dice,
    debt: copy.debt,
    pendingDebts: copy.pendingDebts,
    card: copy.card,
    festival: copy.festival,
    round: copy.round,
    bankruptOrder: copy.bankruptOrder,
    finished: copy.finished,
    winner: copy.winner,
    endReason: copy.endReason,
    moveCount: copy.moveCount,
    steps: [...state.steps],
    you: seat >= 0 && seat < state.players.length ? seat : -1,
    chanceLeft: state.chanceDeck.length,
    chestLeft: state.chestDeck.length,
  };
}

import type { ServerMove } from '../../logic/server-types';

interface TurnSelectionState {
  inGame: boolean;
  myTurn: boolean;
  busy: boolean;
  over: boolean;
  roomPregame: boolean;
  mode: 'bot' | 'pvp';
}

interface VisibleRememberedSelections {
  mine: number | null;
  foe: number | null;
}

export function confirmedSwapDestination(move: ServerMove | undefined): number | null {
  return move?.type === 'swap' ? move.b : null;
}

export function rememberedSelectionsForTurn(
  mine: number | null,
  foe: number | null,
  state: TurnSelectionState,
): VisibleRememberedSelections {
  if (!state.inGame || state.busy || state.over || state.roomPregame) {
    return { mine: null, foe: null };
  }
  if (state.myTurn) return { mine, foe: null };
  return { mine: null, foe: state.mode === 'pvp' ? foe : null };
}

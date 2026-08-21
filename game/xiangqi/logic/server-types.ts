import { BOARD_CELLS } from './constants.gen';
import type { StepKind } from './constants.gen';

export interface ServerStep {
  kind: StepKind;
  from: number;
  to: number;
  piece?: number;
  captured?: number;
  reason?: string;
}

export interface ServerState {
  board: number[];
  moveCount: number;
  halfmoveClock: number;
  history: string[];
  historyChecks: boolean[];
  lastFrom: number;
  lastTo: number;
  check: boolean;
  steps?: ServerStep[];
}

export interface ServerMove {
  from: number;
  to: number;
}

function numberOr(value: unknown, fallback: number): number {
  return typeof value === 'number' && Number.isFinite(value) ? value : fallback;
}

export function decodeServerState(raw: unknown): ServerState {
  const state = raw as Partial<ServerState> | null | undefined;
  if (!state || !Array.isArray(state.board) || state.board.length !== BOARD_CELLS) {
    throw new RangeError('invalid xiangqi state payload');
  }
  const board = state.board.map((cell) => {
    if (!Number.isInteger(cell) || (cell as number) < 0 || (cell as number) > 14) {
      throw new RangeError('invalid xiangqi board cell');
    }
    return cell as number;
  });
  const steps = Array.isArray(state.steps)
    ? state.steps
        .filter((step): step is ServerStep => !!step && typeof (step as ServerStep).kind === 'string')
        .map((step) => ({
          kind: step.kind,
          from: numberOr(step.from, -1),
          to: numberOr(step.to, -1),
          piece: numberOr(step.piece, 0),
          captured: numberOr(step.captured, 0),
          reason: typeof step.reason === 'string' ? step.reason : undefined,
        }))
    : [];
  return {
    board,
    moveCount: numberOr(state.moveCount, 0),
    halfmoveClock: numberOr(state.halfmoveClock, 0),
    history: Array.isArray(state.history) ? state.history.filter((key): key is string => typeof key === 'string') : [],
    historyChecks: Array.isArray(state.historyChecks) ? state.historyChecks.map(Boolean) : [],
    lastFrom: numberOr(state.lastFrom, -1),
    lastTo: numberOr(state.lastTo, -1),
    check: Boolean(state.check),
    steps,
  };
}

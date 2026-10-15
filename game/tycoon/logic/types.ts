import type { MoveType, PayReason, Phase, StepKind } from './constants';

export interface PlayerState {
  cash: number;
  pos: number;
  inJail: boolean;
  jailTurns: number;
  jailCards: number;
  bankrupt: boolean;
  doubles: number;
  quit: boolean;
}

export interface TileState {
  owner: number;
  houses: number;
}

export interface Debt {
  creditor: number;
  amount: number;
  by: number;
  returnTo: number;
  after?: 'move';
  reason: PayReason;
}

export interface CardRef {
  deck: 'chance' | 'chest';
  id: string;
}

export interface Step {
  kind: StepKind;
  by: number;
  dice?: [number, number];
  double?: boolean;
  from?: number;
  to?: number;
  passedGo?: boolean;
  tile?: number;
  amount?: number;
  reason?: PayReason;
  target?: number;
  deck?: 'chance' | 'chest';
  card?: string;
  how?: string;
  houses?: number;
  creditor?: number;
  tiles?: number[];
  round?: number;
  rankings?: number[];
  worth?: number[];
}

export interface GameState {
  players: PlayerState[];
  tiles: TileState[];
  turn: number;
  phase: Phase;
  dice: [number, number];
  debt: Debt | null;
  pendingDebts: Debt[];
  card: CardRef | null;
  chanceDeck: number[];
  chestDeck: number[];
  rng: bigint;
  round: number;
  bankruptOrder: number[];
  finished: boolean;
  moveCount: number;
  steps: Step[];
}

export interface Move {
  type: MoveType;
  tile?: number;
}

export class RuleError extends Error {
  constructor(public readonly code: string) {
    super(code);
  }
}

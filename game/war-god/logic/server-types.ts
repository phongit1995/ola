import type { Board, LightningArc, TileType } from './core';

export const TILE_ORDER: TileType[] = [
  'sword',
  'peach',
  'heart',
  'water',
  'shield',
  'lightning',
  'fireSword',
  'greaterHeart',
];

export interface ServerFighter {
  hp: number;
  mp: number;
  armor: number;
  fury: number;
}

export interface StepSwap {
  kind: 'swap';
  a: number;
  b: number;
}

export interface StepMatch {
  kind: 'match';
  cells: number[];
  exploded?: number[];
  lightningArcs?: LightningArc[];
  counts: Partial<Record<TileType, number>>;
  maxRun: number;
  bonusTurns?: number;
  effects: {
    damage: number;
    heal: number;
    mana: number;
    armor: number;
    armorDamage?: number;
    fury?: number;
    furied?: boolean;
    reflect?: number;
  };
}

export interface StepGravity {
  kind: 'gravity';
  falls?: Array<{ from: number; to: number }>;
  spawns?: Array<{ index: number; type: number; fromRow: number }>;
}

export interface StepShuffle {
  kind: 'shuffle';
  board: number[];
}

export interface StepUlt {
  kind: 'ult';
  damage: number;
}

export type Step = StepSwap | StepMatch | StepGravity | StepShuffle | StepUlt;

export interface ServerState {
  board: number[];
  fighters: ServerFighter[];
  rng: string;
  moveCount: number;
  extraTurn: boolean;
  extraTurns?: number;
  extraTurnOwner?: number;
  steps: Step[];
}

export type ServerMove = { type: 'swap'; a: number; b: number } | { type: 'ult' };

export function decodeTile(n: number): TileType {
  return TILE_ORDER[n] ?? 'sword';
}

export function decodeBoard(ints: number[]): Board {
  return ints.map(decodeTile);
}

export const GAME_ID = 'tycoon';
export const TURN_SECONDS = 30;
export const BOARD_SIZE = 32;
export const SIDE_TILES = BOARD_SIZE / 4;
export const START_CASH = 1500;
export const GO_SALARY = 160;
export const JAIL_FINE = 50;
export const JAIL_TILE = 8;
export const GO_TO_JAIL_TILE = 24;
export const MAX_HOUSES = 3;
export const LEVEL_NAMES = ['Đất trống', 'Nhà', 'Biệt thự', 'Khách sạn'] as const;
export const MAX_ROUNDS = 20;
export const MAX_DOUBLES = 3;
export const JAIL_MAX_TURNS = 3;
export const BIRTHDAY_GIFT = 10;
export const STATION_RENT = [0, 25, 50, 100, 200] as const;
export const UTILITY_MULTIPLIER = [0, 4, 10] as const;

export const PHASES = ['roll', 'jail', 'decide', 'card', 'manage', 'debt'] as const;
export type Phase = (typeof PHASES)[number];

export const MOVE_TYPES = [
  'ROLL',
  'JAIL_PAY',
  'JAIL_CARD',
  'JAIL_ROLL',
  'BUY',
  'DECLINE',
  'CARD_ACK',
  'BUILD',
  'SELL_HOUSE',
  'PAY_DEBT',
  'SETTLE_DEBT',
  'DECLARE_BANKRUPT',
  'END_TURN',
] as const;
export type MoveType = (typeof MOVE_TYPES)[number];

export const STEP_KINDS = [
  'roll',
  'move',
  'teleport',
  'land',
  'pay',
  'buy',
  'card',
  'jail-in',
  'jail-out',
  'build',
  'sell',
  'debt',
  'bankrupt',
  'round',
  'finish',
] as const;
export type StepKind = (typeof STEP_KINDS)[number];

export const TILE_KINDS = ['go', 'street', 'station', 'utility', 'chance', 'chest', 'tax', 'jail', 'parking', 'gotojail'] as const;
export type TileKind = (typeof TILE_KINDS)[number];

export const GROUPS = ['brown', 'sky', 'pink', 'orange', 'red', 'yellow', 'green', 'blue', 'station', 'utility'] as const;
export type Group = (typeof GROUPS)[number];

export const PAY_REASONS = ['rent', 'tax', 'card', 'fine', 'repair', 'birthday', 'buy', 'build', 'sell', 'salary'] as const;
export type PayReason = (typeof PAY_REASONS)[number];

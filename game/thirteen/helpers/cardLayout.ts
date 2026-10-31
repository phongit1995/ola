export const CARD_ASPECT = 184 / 127;

const FULL_HAND = 13;
const HAND_GUTTER = 10;
const HAND_CARD_MIN = 44;
const HAND_CARD_MAX = 76;
const HAND_VISIBLE_FRACTION = 0.42;
const HAND_MAX_STEP_FRACTION = 0.62;
export const HAND_SELECTED_LIFT = 0.24;
const HAND_ARC_DEG = 4;
const HAND_ARC_DROP = 0.06;

const TRICK_CARD = 52;
const TRICK_CARD_COMPACT = 46;
const TRICK_COMPACT_WIDTH = 160;
const TRICK_MAX_STEP = 34;

export interface CardRowLayout {
  cardWidth: number;
  cardHeight: number;
  lefts: number[];
}

function rowLefts(count: number, available: number, cardWidth: number, maxStep: number, offset: number): number[] {
  const step = count > 1 ? Math.max(0, Math.min(maxStep, (available - cardWidth) / (count - 1))) : 0;
  const total = cardWidth + step * Math.max(0, count - 1);
  const start = offset + (available - total) / 2;
  return Array.from({ length: count }, (_, index) => start + index * step);
}

export function handLayout(count: number, width: number): CardRowLayout {
  const available = Math.max(0, width - HAND_GUTTER * 2);
  const fitted = available / (1 + (FULL_HAND - 1) * HAND_VISIBLE_FRACTION);
  const cardWidth = Math.round(Math.min(HAND_CARD_MAX, Math.max(HAND_CARD_MIN, fitted)));
  return {
    cardWidth,
    cardHeight: Math.round(cardWidth * CARD_ASPECT),
    lefts: rowLefts(count, available, cardWidth, cardWidth * HAND_MAX_STEP_FRACTION, HAND_GUTTER),
  };
}

export interface HandArc {
  angle: number;
  drop: number;
}

export function handArcDrop(cardHeight: number): number {
  return Math.round(cardHeight * HAND_ARC_DROP);
}

export function handArc(index: number, count: number, cardHeight: number): HandArc {
  const spread = count > 1 ? (index - (count - 1) / 2) / ((FULL_HAND - 1) / 2) : 0;
  return {
    angle: Math.round(spread * HAND_ARC_DEG * 10) / 10,
    drop: Math.round(spread * spread * handArcDrop(cardHeight)),
  };
}

export function trickLayout(count: number, width: number): CardRowLayout {
  const cardWidth = width < TRICK_COMPACT_WIDTH ? TRICK_CARD_COMPACT : TRICK_CARD;
  return {
    cardWidth,
    cardHeight: Math.round(cardWidth * CARD_ASPECT),
    lefts: rowLefts(count, width, cardWidth, TRICK_MAX_STEP, 0),
  };
}

export function trickRotation(index: number, count: number): number {
  return ((index - (count - 1) / 2) / Math.max(count - 1, 1)) * 8;
}

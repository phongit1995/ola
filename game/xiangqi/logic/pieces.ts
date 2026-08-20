import { SIDE_RED, pieceKind, pieceSide } from './board';

const KIND_LABELS: Record<number, string> = {
  1: 'Tướng',
  2: 'Sĩ',
  3: 'Tượng',
  4: 'Mã',
  5: 'Xe',
  6: 'Pháo',
  7: 'Tốt',
};

const RED_GLYPHS: Record<number, string> = {
  1: '帥',
  2: '仕',
  3: '相',
  4: '傌',
  5: '俥',
  6: '炮',
  7: '兵',
};

const BLACK_GLYPHS: Record<number, string> = {
  1: '將',
  2: '士',
  3: '象',
  4: '馬',
  5: '車',
  6: '砲',
  7: '卒',
};

export function pieceLabel(piece: number): string {
  return KIND_LABELS[pieceKind(piece)] ?? '';
}

export function pieceGlyph(piece: number): string {
  const kind = pieceKind(piece);
  return (pieceSide(piece) === SIDE_RED ? RED_GLYPHS[kind] : BLACK_GLYPHS[kind]) ?? '';
}

export function sideLabel(side: number): string {
  return side === SIDE_RED ? 'Đỏ' : 'Đen';
}

export function pieceFullLabel(piece: number): string {
  return `${pieceLabel(piece)} ${sideLabel(pieceSide(piece)).toLowerCase()}`;
}

import boardJson from './board.json';
import cardsJson from './cards.json';
import type { Group, TileKind } from './constants';

export interface TileData {
  idx: number;
  name: string;
  kind: TileKind;
  group?: Group;
  price?: number;
  rent?: number[];
  houseCost?: number;
  tax?: number;
}

export interface CardData {
  id: string;
  deck: 'chance' | 'chest';
  text: string;
  effect: string;
  tile?: number;
  kind?: string;
  amount?: number;
}

export const BOARD: TileData[] = boardJson as TileData[];
export const CARDS: CardData[] = cardsJson as CardData[];

export const GROUP_LABEL: Record<Group, string> = {
  brown: 'Bắc Trung Bộ',
  sky: 'Tây Nguyên',
  pink: 'Miền Tây',
  orange: 'Nam Trung Bộ',
  red: 'Di sản miền Trung',
  yellow: 'Duyên hải Bắc Bộ',
  green: 'Thành phố biển',
  blue: 'Đô thị đặc biệt',
  station: 'Bến',
  utility: 'Tiện ích',
};

const groupTiles = new Map<string, number[]>();
for (const tile of BOARD) {
  if (!tile.group) continue;
  groupTiles.set(tile.group, [...(groupTiles.get(tile.group) ?? []), tile.idx]);
}

export function tilesOfGroup(group: string): number[] {
  return groupTiles.get(group) ?? [];
}

export function cardById(id: string): CardData | undefined {
  return CARDS.find((card) => card.id === id);
}

export function isProperty(kind: TileKind): boolean {
  return kind === 'street' || kind === 'station' || kind === 'utility';
}

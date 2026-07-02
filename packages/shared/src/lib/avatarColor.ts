export const AVATAR_PALETTE = [
  '#7cb342', '#5d4037', '#6d4c41', '#4dd0e1', '#ef5350', '#5c6bc0',
  '#26a69a', '#ec407a', '#ffa726', '#7e57c2', '#9ccc65', '#26c6da',
];

export const DEFAULT_AVATAR_COLOR = '#7cb342';

export function colorForName(name: string): string {
  let hash = 0;
  for (let index = 0; index < name.length; index += 1) {
    hash = (hash * 31 + name.charCodeAt(index)) >>> 0;
  }
  return AVATAR_PALETTE[hash % AVATAR_PALETTE.length]!;
}

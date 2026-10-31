import { isBotName } from './practice';

export const NAME_COLORS = [
  '#c62828',
  '#ad1457',
  '#6a1b9a',
  '#283593',
  '#1565c0',
  '#00796b',
  '#2e7d32',
  '#bf360c',
  '#5d4037',
] as const;

export function nameColor(name: string): string {
  let hash = 0;
  for (let index = 0; index < name.length; index += 1) {
    hash = (hash * 31 + name.charCodeAt(index)) >>> 0;
  }
  return NAME_COLORS[hash % NAME_COLORS.length] ?? NAME_COLORS[0];
}

export function atName(name: string): string {
  return name.startsWith('@') || isBotName(name) ? name : `@${name}`;
}

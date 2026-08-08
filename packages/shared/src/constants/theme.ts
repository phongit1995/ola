import type { ThemeId, ThemeOption } from '../types/client/theme.type';

export const THEME_ID = {
  green: 'green',
  pink: 'pink',
  yellow: 'yellow',
  teal: 'teal',
  blue: 'blue',
  graphite: 'graphite',
} as const satisfies Record<string, ThemeId>;

export const DEFAULT_THEME_ID: ThemeId = THEME_ID.green;

export const THEME_OPTIONS: ThemeOption[] = [
  { id: THEME_ID.green, swatch: '#7cb342' },
  { id: THEME_ID.pink, swatch: '#ff0052' },
  { id: THEME_ID.yellow, swatch: '#ffd400' },
  { id: THEME_ID.teal, swatch: '#00c68d' },
  { id: THEME_ID.blue, swatch: '#0055da' },
  { id: THEME_ID.graphite, swatch: '#2c3947' },
];

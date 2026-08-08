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

export const THEME_PALETTE = {
  green: { id: THEME_ID.green, swatch: '#7cb342', ink: '#7cb342' },
  pink: { id: THEME_ID.pink, swatch: '#ff0052', ink: '#ff0052' },
  yellow: { id: THEME_ID.yellow, swatch: '#ffd400', ink: '#8a6d00' },
  teal: { id: THEME_ID.teal, swatch: '#00c68d', ink: '#00c68d' },
  blue: { id: THEME_ID.blue, swatch: '#0055da', ink: '#0055da' },
  graphite: { id: THEME_ID.graphite, swatch: '#2c3947', ink: '#2c3947' },
} as const satisfies Record<ThemeId, ThemeOption>;

export const THEME_OPTIONS: ThemeOption[] = Object.values(THEME_PALETTE);

export function themeOptionOf(id: ThemeId): ThemeOption {
  return THEME_PALETTE[id];
}

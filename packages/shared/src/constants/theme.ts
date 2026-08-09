import type { ThemeColors, ThemeId, ThemeOption } from '../types/client/theme.type';

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

export const THEME_COLORS = {
  green: {
    primary: '#7cb342',
    primaryDark: '#558b2f',
    primaryDarker: '#33691e',
    primaryLight: '#f1f8e9',
    button: '#9ccc65',
    onPrimary: '#ffffff',
    primaryInk: '#7cb342',
  },
  pink: {
    primary: '#ff0052',
    primaryDark: '#b8003b',
    primaryDarker: '#82002a',
    primaryLight: '#fdeaf0',
    button: '#ef4e81',
    onPrimary: '#ffffff',
    primaryInk: '#ff0052',
  },
  yellow: {
    primary: '#ffd400',
    primaryDark: '#b89900',
    primaryDarker: '#826c00',
    primaryLight: '#fdfaea',
    button: '#efd34e',
    onPrimary: '#2c3947',
    primaryInk: '#8a6d00',
  },
  teal: {
    primary: '#00c68d',
    primaryDark: '#008f66',
    primaryDarker: '#006548',
    primaryLight: '#eafdf8',
    button: '#15e1a6',
    onPrimary: '#ffffff',
    primaryInk: '#00c68d',
  },
  blue: {
    primary: '#0055da',
    primaryDark: '#003d9d',
    primaryDarker: '#002b6f',
    primaryLight: '#eaf1fd',
    button: '#2471eb',
    onPrimary: '#ffffff',
    primaryInk: '#0055da',
  },
  graphite: {
    primary: '#2c3947',
    primaryDark: '#1f2934',
    primaryDarker: '#151d26',
    primaryLight: '#f1f3f6',
    button: '#394755',
    onPrimary: '#ffffff',
    primaryInk: '#2c3947',
  },
} as const satisfies Record<ThemeId, ThemeColors>;

export function themeColorsOf(id: ThemeId): ThemeColors {
  return THEME_COLORS[id];
}

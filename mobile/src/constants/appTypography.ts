import type { FontSize } from '@ola/shared/types';
import { vars } from 'nativewind';

export const APP_FONT_SIZE_MULTIPLIERS: Record<FontSize, number> = {
  small: 0.9,
  medium: 1,
  large: 1.15,
};

export function normalizeAppFontSize(fontSize: unknown): FontSize {
  return fontSize === 'small' || fontSize === 'large' ? fontSize : 'medium';
}

const BASE_FONT_SIZES = {
  xs: 10.5,
  sm: 12.25,
  base: 14,
  lg: 15.75,
  xl: 17.5,
  '2xl': 21,
  '3xl': 26.25,
  '4xl': 31.5,
  '5xl': 42,
  '6xl': 52.5,
  '7xl': 63,
  '8xl': 84,
  '9xl': 112,
} as const;

const BASE_LINE_HEIGHTS = {
  xs: 14,
  sm: 17.5,
  base: 21,
  lg: 24.5,
  xl: 24.5,
  '2xl': 28,
  '3xl': 31.5,
  '4xl': 35,
  '5xl': 42,
  '6xl': 52.5,
  '7xl': 63,
  '8xl': 84,
  '9xl': 112,
} as const;

function createFontVariables(fontSize: FontSize) {
  const multiplier = APP_FONT_SIZE_MULTIPLIERS[fontSize];
  const values: Record<string, number> = {};

  for (const [name, value] of Object.entries(BASE_FONT_SIZES)) {
    values[`--ola-font-${name}`] = value * multiplier;
  }
  for (const [name, value] of Object.entries(BASE_LINE_HEIGHTS)) {
    values[`--ola-leading-${name}`] = value * multiplier;
  }
  for (let value = 9; value <= 13; value += 1) {
    values[`--ola-font-${value}`] = value * multiplier;
  }

  return vars(values);
}

const FONT_VARIABLES: Record<FontSize, ReturnType<typeof vars>> = {
  small: createFontVariables('small'),
  medium: createFontVariables('medium'),
  large: createFontVariables('large'),
};

export function appFontSizeMultiplier(fontSize: unknown): number {
  return APP_FONT_SIZE_MULTIPLIERS[normalizeAppFontSize(fontSize)];
}

export function appFontVariables(fontSize: unknown): ReturnType<typeof vars> {
  return FONT_VARIABLES[normalizeAppFontSize(fontSize)];
}

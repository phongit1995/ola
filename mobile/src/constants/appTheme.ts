import { vars } from 'nativewind';
import { THEME_COLORS, THEME_ID } from '@ola/shared/constants';
import type { ThemeColors, ThemeId } from '@ola/shared/types';

function createThemeVariables(colors: ThemeColors) {
  return vars({
    '--ola-color-primary': colors.primary,
    '--ola-color-primary-dark': colors.primaryDark,
    '--ola-color-primary-darker': colors.primaryDarker,
    '--ola-color-primary-light': colors.primaryLight,
    '--ola-color-button': colors.button,
  });
}

const THEME_VARIABLES = Object.fromEntries(
  Object.values(THEME_ID).map((id) => [id, createThemeVariables(THEME_COLORS[id])])
) as Record<ThemeId, ReturnType<typeof vars>>;

export function appThemeVariables(theme: ThemeId): ReturnType<typeof vars> {
  return THEME_VARIABLES[theme];
}

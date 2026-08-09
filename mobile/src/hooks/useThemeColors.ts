import { themeColorsOf } from '@ola/shared/constants';
import { useThemeStore } from '@ola/shared/stores/themeStore';
import type { ThemeColors } from '@ola/shared/types';

export function useThemeColors(): ThemeColors {
  const theme = useThemeStore((state) => state.theme);
  return themeColorsOf(theme);
}

import { createContext, useContext, useMemo, type ReactNode } from 'react';
import { useWindowDimensions, View } from 'react-native';
import type { FontSize } from '@ola/shared/types';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import { useThemeStore } from '@ola/shared/stores/themeStore';
import { appThemeVariables } from '@constants/appTheme';
import {
  appFontSizeMultiplier,
  appFontVariables,
  normalizeAppFontSize,
} from '@constants/appTypography';

interface AppTypography {
  fontSize: FontSize;
  multiplier: number;
  systemFontScale: number;
}

const AppTypographyContext = createContext<AppTypography>({
  fontSize: 'medium',
  multiplier: 1,
  systemFontScale: 1,
});

export function AppFontProvider({ children }: { children: ReactNode }) {
  const savedFontSize = useSettingsStore((state) => state.settings.fontSize);
  const theme = useThemeStore((state) => state.theme);
  const fontSize = normalizeAppFontSize(savedFontSize);
  const { fontScale: systemFontScale } = useWindowDimensions();
  const multiplier = appFontSizeMultiplier(fontSize);
  const value = useMemo(
    () => ({ fontSize, multiplier, systemFontScale }),
    [fontSize, multiplier, systemFontScale]
  );

  return (
    <AppTypographyContext.Provider value={value}>
      <View
        className="flex-1"
        style={[appFontVariables(fontSize), appThemeVariables(theme)]}
      >
        {children}
      </View>
    </AppTypographyContext.Provider>
  );
}

export function useAppTypography(): AppTypography {
  return useContext(AppTypographyContext);
}

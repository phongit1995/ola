export type ThemeId = 'green' | 'pink' | 'yellow' | 'teal' | 'blue' | 'graphite';

export interface ThemeOption {
  id: ThemeId;
  swatch: string;
  ink: string;
}

export interface ThemeColors {
  primary: string;
  primaryDark: string;
  primaryDarker: string;
  primaryLight: string;
  button: string;
  onPrimary: string;
  primaryInk: string;
}

export interface ThemeState {
  theme: ThemeId;
  setTheme: (theme: ThemeId) => void;
}

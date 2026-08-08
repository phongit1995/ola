export type ThemeId = 'green' | 'pink' | 'yellow' | 'teal' | 'blue' | 'graphite';

export interface ThemeOption {
  id: ThemeId;
  swatch: string;
  ink: string;
}

export interface ThemeState {
  theme: ThemeId;
  setTheme: (theme: ThemeId) => void;
}

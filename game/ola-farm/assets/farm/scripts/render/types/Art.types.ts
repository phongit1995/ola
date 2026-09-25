import type { BitmapFont } from 'cc';

export interface ArtFonts {
  plot: BitmapFont;
  wallet: BitmapFont;
}

export type ArtLoadProgress =
  | { phase: 'data' | 'town' | 'town-ui' | 'plot-ui' | 'island-ui' | 'ready' }
  | { phase: 'ported'; done: number; total: number };

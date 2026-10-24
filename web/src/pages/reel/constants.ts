import type { ReelFontKey } from '@constants';

export const REEL_FONT_FACE: Record<ReelFontKey, { family: string; weight: number }> = {
  sans: { family: 'var(--font-sans)', weight: 600 },
  serif: { family: 'var(--font-reader-serif)', weight: 600 },
  bold: { family: 'var(--font-game)', weight: 800 },
};

export const REEL_PLAIN_SHADOW = '0 1px 3px rgba(0, 0, 0, 0.45)';

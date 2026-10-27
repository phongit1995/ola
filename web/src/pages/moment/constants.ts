import type { CSSProperties } from 'react';
import type { MomentFontKey } from '@constants';

export const MOMENT_FONT_FACE: Record<MomentFontKey, { family: string; weight: number; boldWeight: number }> = {
  sans: { family: 'var(--font-sans)', weight: 600, boldWeight: 800 },
  serif: { family: 'var(--font-reader-serif)', weight: 600, boldWeight: 700 },
  mono: { family: "'Courier New', ui-monospace, monospace", weight: 400, boldWeight: 700 },
  hand: { family: "'Dancing Script', cursive", weight: 400, boldWeight: 700 },
  round: { family: 'var(--font-game)', weight: 400, boldWeight: 800 },
  art: { family: 'Lobster, cursive', weight: 400, boldWeight: 400 },
};

export const MOMENT_PLAIN_SHADOW = '0 1px 3px rgba(0, 0, 0, 0.45)';

export const MOMENT_FIT_STYLE: CSSProperties = {
  width: 'min(100cqw, calc(100cqh * 9 / 16))',
  aspectRatio: '9 / 16',
};

export const MOMENT_TURN_PERSPECTIVE_PX = 1200;

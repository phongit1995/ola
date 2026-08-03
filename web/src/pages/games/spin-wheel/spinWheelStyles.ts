import type { CSSProperties } from 'react';
import type { SegmentTheme } from '@ola/shared/types';

export const TEXT_SHADOW: CSSProperties = {
  textShadow: '0 2px 4px rgba(0,0,0,0.45)',
};

export const TITLE_STYLE: CSSProperties = {
  color: '#ffffff',
  WebkitTextStroke: '3px #6b4a1c',
  paintOrder: 'stroke fill',
  textShadow: '0 3px 4px rgba(0,0,0,0.35)',
  letterSpacing: '0.02em',
};

export const SPIN_TEXT_STYLE: CSSProperties = {
  color: '#fffdf0',
  WebkitTextStroke: '4px #4f6e16',
  paintOrder: 'stroke fill',
  textShadow: '0 5px 0 #9a6b16, 0 6px 6px rgba(0,0,0,0.3)',
  letterSpacing: '0.08em',
};

export const CHIP_TEXT_STYLE: CSSProperties = {
  color: '#fffdf0',
  WebkitTextStroke: '1.5px #5a3a12',
  paintOrder: 'stroke fill',
  textShadow: '0 2px 0 #7a4e18, 0 3px 4px rgba(0,0,0,0.35)',
  letterSpacing: '0.03em',
};

export const HISTORY_TITLE_STYLE: CSSProperties = {
  color: '#fff5f8',
  WebkitTextStroke: '4px #f04f7d',
  paintOrder: 'stroke fill',
  textShadow:
    '0 -1px 0 rgba(255,255,255,0.6), 0 4px 0 #b8194d, 0 5px 6px rgba(0,0,0,0.28)',
  letterSpacing: '0.02em',
};

export const HISTORY_LABEL_STYLE: CSSProperties = {
  color: '#ffffff',
  WebkitTextStroke: '2px #f04b7b',
  paintOrder: 'stroke fill',
  textShadow: '0 2px 0 #c72a58, 0 3px 3px rgba(0,0,0,0.22)',
  letterSpacing: '0.02em',
};

export const HISTORY_TAB_INACTIVE_STYLE: CSSProperties = {
  color: '#ffffff',
  WebkitTextStroke: '1.5px #f3a3bd',
  paintOrder: 'stroke fill',
  textShadow: '0 1px 1px rgba(196,74,120,0.35)',
  letterSpacing: '0.02em',
};

export const GIFT_TITLE_STYLE: CSSProperties = {
  color: '#ffffff',
  WebkitTextStroke: '3px #1f3ba0',
  paintOrder: 'stroke fill',
  textShadow: '0 3px 0 #1a2f80, 0 4px 6px rgba(0,0,0,0.35)',
  letterSpacing: '0.04em',
};

export const GIFT_SUBTITLE_STYLE: CSSProperties = {
  color: '#ffd75e',
  textShadow: '0 2px 3px rgba(0,0,0,0.4)',
  letterSpacing: '0.12em',
};

export const GIFT_AMOUNT_STYLE: CSSProperties = {
  color: '#ffd75e',
  WebkitTextStroke: '2px #1f3ba0',
  paintOrder: 'stroke fill',
  textShadow: '0 2px 0 #1a2f80, 0 3px 4px rgba(0,0,0,0.3)',
  letterSpacing: '0.02em',
};

export function segmentLabelStyle(theme: SegmentTheme): CSSProperties {
  return {
    color: '#fff7e8',
    WebkitTextStroke: `2px ${theme.stroke}`,
    paintOrder: 'stroke fill',
    textShadow: `0 2px 0 ${theme.shadow}, 0 3px 3px rgba(0,0,0,0.3)`,
  };
}

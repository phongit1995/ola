import type { CSSProperties } from 'react';
import type { SegmentTheme } from './spinWheel.constants';

export const TEXT_SHADOW: CSSProperties = { textShadow: '0 2px 4px rgba(0,0,0,0.45)' };

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

export function segmentLabelStyle(theme: SegmentTheme): CSSProperties {
  return {
    color: '#fff7e8',
    WebkitTextStroke: `2px ${theme.stroke}`,
    paintOrder: 'stroke fill',
    textShadow: `0 2px 0 ${theme.shadow}, 0 3px 3px rgba(0,0,0,0.3)`,
  };
}

import type { TextStyle } from 'react-native';
import type { SegmentTheme } from '@ola/shared/lib';

export const TEXT_SHADOW: TextStyle = {
  textShadowColor: 'rgba(0,0,0,0.45)',
  textShadowOffset: { width: 0, height: 2 },
  textShadowRadius: 4,
};

export const TITLE_STYLE: TextStyle = {
  color: '#ffffff',
  textShadowColor: '#6b4a1c',
  textShadowOffset: { width: 0, height: 3 },
  textShadowRadius: 4,
  letterSpacing: 0.5,
};

export const SPIN_TEXT_STYLE: TextStyle = {
  color: '#fffdf0',
  textShadowColor: '#4f6e16',
  textShadowOffset: { width: 0, height: 4 },
  textShadowRadius: 2,
  letterSpacing: 2.4,
};

export const CHIP_TEXT_STYLE: TextStyle = {
  color: '#fffdf0',
  textShadowColor: '#5a3a12',
  textShadowOffset: { width: 0, height: 2 },
  textShadowRadius: 2,
  letterSpacing: 0.5,
};

export const HISTORY_TITLE_STYLE: TextStyle = {
  color: '#fff5f8',
  textShadowColor: '#b8194d',
  textShadowOffset: { width: 0, height: 3 },
  textShadowRadius: 3,
  letterSpacing: 0.4,
};

export const HISTORY_LABEL_STYLE: TextStyle = {
  color: '#ffffff',
  textShadowColor: '#c72a58',
  textShadowOffset: { width: 0, height: 2 },
  textShadowRadius: 2,
  letterSpacing: 0.3,
};

export const HISTORY_TAB_INACTIVE_STYLE: TextStyle = {
  color: '#ffffff',
  textShadowColor: 'rgba(196,74,120,0.5)',
  textShadowOffset: { width: 0, height: 1 },
  textShadowRadius: 1,
  letterSpacing: 0.3,
};

export function segmentLabelTextStyle(theme: SegmentTheme): TextStyle {
  return {
    color: '#fff7e8',
    textShadowColor: theme.shadow,
    textShadowOffset: { width: 0, height: 2 },
    textShadowRadius: 1,
  };
}

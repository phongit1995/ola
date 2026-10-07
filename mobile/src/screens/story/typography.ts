import { useCallback } from 'react';
import { useAppTypography } from '@components/AppFontProvider';

const DEFAULT_LEADING = 1.4;

export type StoryTextSize = (fontSize: number, lineHeight?: number) => {
  fontSize: number;
  lineHeight: number;
};

export function useStoryTextSize(): StoryTextSize {
  const { multiplier } = useAppTypography();
  return useCallback(
    (fontSize: number, lineHeight = fontSize * DEFAULT_LEADING) => ({
      fontSize: fontSize * multiplier,
      lineHeight: lineHeight * multiplier,
    }),
    [multiplier]
  );
}

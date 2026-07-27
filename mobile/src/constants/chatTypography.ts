export const CHAT_MAX_FONT_SIZE_MULTIPLIER = 1.3;

export function cappedFontScale(fontScale: number, maxFontSizeMultiplier: number): number {
  return maxFontSizeMultiplier >= 1
    ? Math.min(fontScale, maxFontSizeMultiplier)
    : fontScale;
}

import type { StoryReaderPrefs } from '../types/client/story.type';

export const STORY_PAGE_SIZE = 10;

export const STORY_TOP_LIMIT = 10;

export const STORY_NEW_CHAPTER_MS = 3 * 24 * 60 * 60 * 1000;

export const STORY_RECENT_LIMIT = 20;

export const STORY_FONT_SIZE = { min: 14, max: 30, step: 2 } as const;

export const STORY_LINE_HEIGHTS = [1.4, 1.6, 1.8, 2] as const;

export const STORY_READER_DEFAULTS: StoryReaderPrefs = {
  theme: 'light',
  font: 'serif',
  fontSize: 18,
  lineHeight: 1.8,
};

export function storyChapterKey(storyId: string, position: number): string {
  return `${storyId}:${position}`;
}

export function splitStoryParagraphs(content: string): string[] {
  return content
    .split(/\n\s*\n/)
    .map((paragraph) => paragraph.trim())
    .filter((paragraph) => paragraph.length > 0);
}

export function foldVietnamese(text: string): string {
  return text
    .normalize('NFD')
    .replace(/\p{M}/gu, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .toLowerCase()
    .trim();
}

export function formatCompactCount(value: number, locale: string): string {
  const format = (scaled: number, suffix: string) =>
    `${scaled.toLocaleString(locale, { maximumFractionDigits: 1 })}${suffix}`;
  if (value >= 1_000_000) return format(value / 1_000_000, 'M');
  if (value >= 1_000) return format(value / 1_000, 'K');
  return value.toLocaleString(locale);
}

export function clampStoryFontSize(size: number): number {
  return Math.min(STORY_FONT_SIZE.max, Math.max(STORY_FONT_SIZE.min, size));
}

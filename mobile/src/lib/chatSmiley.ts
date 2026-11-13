import { Image } from 'react-native';
import type { ImageSourcePropType } from 'react-native';
import { buildSmileyMap, buildSmileyPanel, buildSmileyRegex, isEmojiToken } from '@ola/shared/lib';
import { SMILEY_IMAGES } from './smileyImages';
import { emojiImageForToken } from './emoji';

export { SMILEY_IMAGES };

const aspectRatioCache = new Map<ImageSourcePropType, number>();

export function imageAspectRatio(src: ImageSourcePropType): number {
  const cached = aspectRatioCache.get(src);
  if (cached != null) return cached;
  const { width = 0, height = 0 } = Image.resolveAssetSource(src) ?? {};
  const aspect = height > 0 ? width / height : 1;
  aspectRatioCache.set(src, aspect);
  return aspect;
}

export function imageSizeForHeight(
  src: ImageSourcePropType,
  height: number
): { width: number; height: number } {
  return { width: height * imageAspectRatio(src), height };
}

export const SMILEY_PANEL: Array<{ image: ImageSourcePropType; code: string }> =
  buildSmileyPanel(SMILEY_IMAGES);

const SMILEY_MAP: Record<string, ImageSourcePropType> = buildSmileyMap(SMILEY_IMAGES);

export function smileyImageForCode(code: string): ImageSourcePropType | null {
  return SMILEY_MAP[code] ?? emojiImageForToken(code);
}

const SMILEY_REGEX = buildSmileyRegex(Object.keys(SMILEY_MAP));

export type SmileyVariant = 'smiley' | 'emoji';

export function smileyVariantForCode(code: string): SmileyVariant {
  return isEmojiToken(code) ? 'emoji' : 'smiley';
}

export function smileyImageHeight(fontSize: number, variant: SmileyVariant): number {
  return fontSize * (variant === 'smiley' ? 1.25 : 1.15);
}

export type SmileySegment =
  | { kind: 'text'; value: string }
  | { kind: 'image'; src: ImageSourcePropType; code: string; variant: SmileyVariant };

const smileyCache = new Map<string, SmileySegment[]>();
const SMILEY_CACHE_LIMIT = 600;

function computeSplitSmileys(text: string): SmileySegment[] {
  const segments: SmileySegment[] = [];
  let lastIndex = 0;
  SMILEY_REGEX.lastIndex = 0;
  let match = SMILEY_REGEX.exec(text);
  while (match != null) {
    const code = match[0];
    const smileySrc = SMILEY_MAP[code];
    const src = smileySrc ?? emojiImageForToken(code);
    if (src != null) {
      if (match.index > lastIndex) {
        segments.push({ kind: 'text', value: text.slice(lastIndex, match.index) });
      }
      segments.push({ kind: 'image', src, code, variant: smileyVariantForCode(code) });
      lastIndex = match.index + code.length;
    }
    match = SMILEY_REGEX.exec(text);
  }
  if (lastIndex < text.length) {
    segments.push({ kind: 'text', value: text.slice(lastIndex) });
  }
  return segments;
}

export function splitSmileys(text: string): SmileySegment[] {
  const cached = smileyCache.get(text);
  if (cached != null) return cached;
  const segments = computeSplitSmileys(text);
  if (smileyCache.size >= SMILEY_CACHE_LIMIT) smileyCache.clear();
  smileyCache.set(text, segments);
  return segments;
}

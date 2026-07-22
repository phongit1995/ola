import { Image } from 'react-native';
import type { ImageSourcePropType } from 'react-native';
import { SMILEY_IMAGES } from './smileyImages';
import { emojiImageForToken, isEmojiToken } from './emoji';

export { SMILEY_IMAGES };

const aspectRatioCache = new Map<ImageSourcePropType, number>();

export function imageAspectRatio(src: ImageSourcePropType): number {
  const cached = aspectRatioCache.get(src);
  if (cached != null) return cached;
  const resolved = Image.resolveAssetSource(src);
  const aspect = resolved != null && resolved.height > 0 ? resolved.width / resolved.height : 1;
  aspectRatioCache.set(src, aspect);
  return aspect;
}

export function imageSizeForHeight(
  src: ImageSourcePropType,
  height: number
): { width: number; height: number } {
  return { width: height * imageAspectRatio(src), height };
}

export const SMILEY_ALIASES: string[][] = [
  [':-)', ':)'],
  [':-P', ':-p', ':p', ':P'],
  ['>:D<'],
  [':-))', ':))'],
  [':">'],
  ['B-)', 'b-)', 'B)', 'b)'],
  [':-X', ':-x', ':X', ':x'],
  [':-*', ':*'],
  [':-|', ':|'],
  [':-D', ':-d', ':D', ':d'],
  [';-)', ';)'],
  ['|-)', '|)'],
  ['(:|'],
  [':-/'],
  [':-<', ':<'],
  [':-&', ':&'],
  [':-(', ':('],
  [':-B', ':-b', ':B', ':b'],
  [':-O', ':-o', ':O', ':o'],
  [':-h', ':-H', ':h', ':H'],
  [':-S', ':-s', ':S', ':s'],
  [':-?', ':?'],
  [':-((', ':(('],
  ['=(('],
  ['=;'],
  [':-W', ':-w', ':W', ':w'],
  ['X-(', 'x-(', 'X(', 'x('],
  ['>:)'],
  [';))'],
  ['>:P'],
  ['/:)'],
  ['<3'],
  ['(*)'],
  ['@;-', '@};-'],
  ['(y)', '(Y)'],
  ['(n)', '(N)'],
  ['^_^'],
  [':v'],
  [':3'],
  ['=))'],
  ['@@'],
  ['@)'],
  [':’('],
  ['O:)', 'o:)', '0:)'],
  ['>:O', '>:o', '>:0'],
];

export const SMILEY_PANEL: Array<{ image: ImageSourcePropType; code: string }> = SMILEY_IMAGES.map(
  (image, index) => ({ image, code: SMILEY_ALIASES[index]?.[0] ?? '' })
);

const SMILEY_MAP: Record<string, ImageSourcePropType> = (() => {
  const map: Record<string, ImageSourcePropType> = {};
  SMILEY_IMAGES.forEach((image, index) => {
    for (const code of SMILEY_ALIASES[index] ?? []) {
      map[code] = image;
    }
  });
  return map;
})();

export function smileyImageForCode(code: string): ImageSourcePropType | null {
  return SMILEY_MAP[code] ?? emojiImageForToken(code);
}

function escapeRegExp(value: string): string {
  return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

const SMILEY_PATTERN = Object.keys(SMILEY_MAP)
  .sort((a, b) => b.length - a.length)
  .map(escapeRegExp)
  .join('|');

const SMILEY_REGEX = new RegExp(`\\[e:\\d{1,2}\\]|${SMILEY_PATTERN}`, 'g');

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

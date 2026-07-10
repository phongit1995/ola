import type { ImageSourcePropType } from 'react-native';
import { SMILEY_IMAGES } from './smileyImages';
import { emojiImageForToken } from './emoji';

export { SMILEY_IMAGES };

const SMILEY_ALIASES: string[][] = [
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

export type SmileySegment =
  | { kind: 'text'; value: string }
  | { kind: 'image'; src: ImageSourcePropType; code: string };

export function splitSmileys(text: string): SmileySegment[] {
  const segments: SmileySegment[] = [];
  let lastIndex = 0;
  SMILEY_REGEX.lastIndex = 0;
  let match = SMILEY_REGEX.exec(text);
  while (match != null) {
    const code = match[0];
    const src = SMILEY_MAP[code] ?? emojiImageForToken(code);
    if (src != null) {
      if (match.index > lastIndex) {
        segments.push({ kind: 'text', value: text.slice(lastIndex, match.index) });
      }
      segments.push({ kind: 'image', src, code });
      lastIndex = match.index + code.length;
    }
    match = SMILEY_REGEX.exec(text);
  }
  if (lastIndex < text.length) {
    segments.push({ kind: 'text', value: text.slice(lastIndex) });
  }
  return segments;
}

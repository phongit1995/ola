import { Image } from 'react-native';
import type { ImageSourcePropType } from 'react-native';
import NativeOlaRichText from '../components/specs/NativeOlaRichText';
import { EMOJI_IMAGES } from './emojiImages';
import { SMILEY_ALIASES, SMILEY_IMAGES } from './chatSmiley';

export const richTextNativeAvailable = NativeOlaRichText != null;

function resolvedEntry(src: ImageSourcePropType): { uri: string; aspect: number } {
  const resolved = Image.resolveAssetSource(src);
  const aspect =
    resolved != null && resolved.height > 0 ? resolved.width / resolved.height : 1;
  return { uri: resolved?.uri ?? '', aspect };
}

let configured = false;

export function configureRichTextNative(): void {
  if (configured || NativeOlaRichText == null) return;
  configured = true;
  NativeOlaRichText.configure({
    smileyFactor: 1.25,
    emojiFactor: 1.15,
    emoji: EMOJI_IMAGES.map(resolvedEntry),
    smileys: SMILEY_IMAGES.map((src, index) => ({
      ...resolvedEntry(src),
      codes: SMILEY_ALIASES[index] ?? [],
    })),
  });
}

const measureCache = new Map<string, { width: number; height: number }>();
const MEASURE_CACHE_LIMIT = 500;

export function measureRichText(
  content: string,
  maxWidth: number,
  fontSize: number,
  maxLines: number
): { width: number; height: number } | null {
  if (NativeOlaRichText == null) return null;
  configureRichTextNative();
  const roundedMaxWidth = Math.floor(maxWidth);
  const key = `${fontSize}|${maxLines}|${roundedMaxWidth}|${content}`;
  const cached = measureCache.get(key);
  if (cached != null) return cached;
  const measured = NativeOlaRichText.measure(content, roundedMaxWidth, fontSize, maxLines);
  if (measured.length < 2) return null;
  const size = { width: Math.ceil(measured[0]!), height: Math.ceil(measured[1]!) };
  if (measureCache.size >= MEASURE_CACHE_LIMIT) {
    const oldest = measureCache.keys().next().value;
    if (oldest != null) measureCache.delete(oldest);
  }
  measureCache.set(key, size);
  return size;
}

import type { ReactNode } from 'react';
import { Image, Linking, Platform, Text } from 'react-native';
import type { ImageSourcePropType } from 'react-native';
import { splitSmileys } from './chatSmiley';

const MENTION_SOURCE = '@[A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9]';
const HASHTAG_SOURCE = '#[A-Za-z0-9_.]+';
const URL_SOURCE = 'https?:\\/\\/[^\\s]+|www\\.[^\\s]+';

const POST_TOKEN_PATTERN = new RegExp(
  `(${MENTION_SOURCE}|${HASHTAG_SOURCE}|${URL_SOURCE})`,
  'g'
);

const MENTION_TOKEN_PATTERN = new RegExp(`^(?:${MENTION_SOURCE})$`);
const HASHTAG_TOKEN_PATTERN = new RegExp(`^(?:${HASHTAG_SOURCE})$`);
const URL_TOKEN_PATTERN = new RegExp(`^(?:${URL_SOURCE})$`);
const URL_TRAILING_PUNCTUATION = /[.,;:!?)\]}'"]+$/;

interface RichTextOptions {
  own: boolean;
  onMention: (nick: string) => void;
}

export function smileyBaselineShift(size: number): number {
  return Platform.OS === 'ios' ? Math.round(size * 0.15) : 0;
}

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

export function SmileyText({ text, size }: { text: string; size: number }) {
  return (
    <>
      {splitSmileys(text).map((segment, index) =>
        segment.kind === 'image' ? (
          <Image
            key={index}
            source={segment.src}
            style={{
              ...imageSizeForHeight(segment.src, size),
              transform: [{ translateY: smileyBaselineShift(size) }],
            }}
            resizeMode="contain"
          />
        ) : (
          <Text key={index}>{segment.value}</Text>
        )
      )}
    </>
  );
}

function renderUrlToken(part: string, key: number, color: string): ReactNode {
  const trailingMatch = part.match(URL_TRAILING_PUNCTUATION);
  const trailing = trailingMatch == null ? '' : trailingMatch[0];
  const url = trailing === '' ? part : part.slice(0, part.length - trailing.length);
  const href = url.startsWith('www.') ? `https://${url}` : url;
  return (
    <Text key={key}>
      <Text
        onPress={() => void Linking.openURL(href).catch(() => undefined)}
        style={{ color, textDecorationLine: 'underline' }}
      >
        {url}
      </Text>
      {trailing}
    </Text>
  );
}

export function renderRichText(content: string, { own, onMention }: RichTextOptions): ReactNode[] {
  const accentColor = own ? '#ffffff' : '#33691e';
  return content.split(POST_TOKEN_PATTERN).map((part, index) => {
    if (MENTION_TOKEN_PATTERN.test(part)) {
      return (
        <Text
          key={index}
          onPress={() => onMention(part.slice(1))}
          style={{ color: accentColor, fontWeight: '600' }}
        >
          {part}
        </Text>
      );
    }
    if (HASHTAG_TOKEN_PATTERN.test(part)) {
      return (
        <Text key={index} style={{ color: accentColor }}>
          {part}
        </Text>
      );
    }
    if (URL_TOKEN_PATTERN.test(part)) {
      return renderUrlToken(part, index, accentColor);
    }
    return <SmileyText key={index} text={part} size={18} />;
  });
}

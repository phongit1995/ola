import type { ReactNode } from 'react';
import { Image, Linking, Platform, Text } from 'react-native';
import { imageSizeForHeight, smileyImageHeight, splitSmileys } from './chatSmiley';

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
  fontSize?: number;
  accentColor?: string;
  onMention: (nick: string) => void;
}

export function smileyBaselineShift(size: number): number {
  return Platform.OS === 'ios' ? Math.round(size * 0.15) : 0;
}

export function SmileyText({ text, fontSize }: { text: string; fontSize: number }) {
  return (
    <>
      {splitSmileys(text).map((segment, index) => {
        if (segment.kind === 'text') {
          return <Text key={index}>{segment.value}</Text>;
        }
        const height = smileyImageHeight(fontSize, segment.variant);
        return (
          <Image
            key={index}
            source={segment.src}
            style={{
              ...imageSizeForHeight(segment.src, height),
              transform: [{ translateY: smileyBaselineShift(height) }],
            }}
            resizeMode="contain"
          />
        );
      })}
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

export function renderRichText(
  content: string,
  { fontSize = 16, accentColor = '#33691e', onMention }: RichTextOptions
): ReactNode[] {
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
    return <SmileyText key={index} text={part} fontSize={fontSize} />;
  });
}

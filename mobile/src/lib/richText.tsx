import type { ReactNode } from 'react';
import { Image, Text } from 'react-native';
import { splitSmileys } from './chatSmiley';

const POST_TOKEN_PATTERN = /(@[A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9]|#[A-Za-z0-9_.]+)/g;

interface RichTextOptions {
  own: boolean;
  onMention: (nick: string) => void;
}

export function SmileyText({ text, size }: { text: string; size: number }) {
  return (
    <>
      {splitSmileys(text).map((segment, index) =>
        segment.kind === 'image' ? (
          <Image
            key={index}
            source={segment.src}
            style={{ width: size, height: size }}
            resizeMode="contain"
          />
        ) : (
          <Text key={index}>{segment.value}</Text>
        )
      )}
    </>
  );
}

export function renderRichText(content: string, { own, onMention }: RichTextOptions): ReactNode[] {
  const mentionColor = own ? '#ffffff' : '#33691e';
  return content.split(POST_TOKEN_PATTERN).map((part, index) => {
    if (part.startsWith('@')) {
      return (
        <Text
          key={index}
          onPress={() => onMention(part.slice(1))}
          style={{ color: mentionColor, fontWeight: '600' }}
        >
          {part}
        </Text>
      );
    }
    if (part.startsWith('#')) {
      return (
        <Text key={index} style={{ color: mentionColor }}>
          {part}
        </Text>
      );
    }
    return <SmileyText key={index} text={part} size={18} />;
  });
}

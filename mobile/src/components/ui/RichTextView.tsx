import { memo } from 'react';
import { Linking, Text } from 'react-native';
import { splitSmileys } from '@lib/chatSmiley';
import { renderRichText } from '@lib/richText';
import { measureRichText, richTextNativeAvailable } from '@lib/richTextNativeConfig';
import OlaRichTextViewNative from '../specs/OlaRichTextViewNativeComponent';

let nativeRichTextEnabled = true;

export function setNativeRichTextEnabled(enabled: boolean): void {
  nativeRichTextEnabled = enabled;
}

interface RichTextViewProps {
  content: string;
  own: boolean;
  color: string;
  maxWidth: number;
  fontSize?: number;
  maxLines?: number;
  onMention: (nick: string) => void;
}

function hasInlineImages(content: string): boolean {
  return splitSmileys(content).some((segment) => segment.kind === 'image');
}

function RichTextViewComponent({
  content,
  own,
  color,
  maxWidth,
  fontSize = 16,
  maxLines = 0,
  onMention,
}: RichTextViewProps) {
  const accentColor = own ? '#ffffff' : '#33691e';
  const useNative =
    richTextNativeAvailable && nativeRichTextEnabled && hasInlineImages(content);
  const size = useNative ? measureRichText(content, maxWidth, fontSize, maxLines) : null;

  if (size == null) {
    return (
      <Text
        className="text-base"
        style={{ color, fontSize }}
        numberOfLines={maxLines > 0 ? maxLines : undefined}
      >
        {renderRichText(content, { own, fontSize, onMention })}
      </Text>
    );
  }

  return (
    <OlaRichTextViewNative
      content={content}
      fontSize={fontSize}
      textColor={color}
      accentColor={accentColor}
      maxLines={maxLines}
      style={{ width: size.width, height: size.height }}
      onMentionPress={(event) => onMention(event.nativeEvent.nick)}
      onUrlPress={(event) => {
        void Linking.openURL(event.nativeEvent.url).catch(() => undefined);
      }}
    />
  );
}

export const RichTextView = memo(
  RichTextViewComponent,
  (prev, next) =>
    prev.content === next.content &&
    prev.own === next.own &&
    prev.color === next.color &&
    prev.maxWidth === next.maxWidth &&
    prev.fontSize === next.fontSize &&
    prev.maxLines === next.maxLines
);

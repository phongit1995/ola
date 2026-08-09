import { memo } from 'react';
import { Linking, Text } from 'react-native';
import { splitSmileys } from '@lib/chatSmiley';
import { renderRichText } from '@lib/richText';
import { measureRichText, richTextNativeAvailable } from '@lib/richTextNativeConfig';
import { cappedFontScale, CHAT_MAX_FONT_SIZE_MULTIPLIER } from '@constants';
import { useAppTypography } from '@components/AppFontProvider';
import { useThemeColors } from '@hooks/useThemeColors';
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
  const { multiplier, systemFontScale } = useAppTypography();
  const accentColor = useThemeColors().primaryDarker;
  const useNative =
    richTextNativeAvailable && nativeRichTextEnabled && hasInlineImages(content);
  const appFontSize = fontSize * multiplier;
  const effectiveFontScale = cappedFontScale(
    systemFontScale,
    CHAT_MAX_FONT_SIZE_MULTIPLIER
  );
  const nativeFontSize = appFontSize * effectiveFontScale;
  const size = useNative ? measureRichText(content, maxWidth, nativeFontSize, maxLines) : null;

  if (size == null) {
    return (
      <Text
        className="text-base"
        style={{ color, fontSize: appFontSize }}
        maxFontSizeMultiplier={CHAT_MAX_FONT_SIZE_MULTIPLIER}
        numberOfLines={maxLines > 0 ? maxLines : undefined}
      >
        {renderRichText(content, { own, fontSize: nativeFontSize, accentColor, onMention })}
      </Text>
    );
  }

  return (
    <OlaRichTextViewNative
      content={content}
      fontSize={nativeFontSize}
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

import { Text, type TextProps } from 'react-native';
import { CHAT_MAX_FONT_SIZE_MULTIPLIER } from '@constants';

export function ChatText({
  maxFontSizeMultiplier = CHAT_MAX_FONT_SIZE_MULTIPLIER,
  ...props
}: TextProps) {
  return <Text maxFontSizeMultiplier={maxFontSizeMultiplier} {...props} />;
}

import { Image, type StyleProp, type ImageStyle } from 'react-native';

const chatBotAvatar = require('@assets/icons/chat/ic_chat_bot_ola.png');

interface BotAvatarProps {
  size?: number;
  radius?: number;
  style?: StyleProp<ImageStyle>;
}

export function BotAvatar({ size = 32, radius, style }: BotAvatarProps) {
  return (
    <Image
      source={chatBotAvatar}
      style={[
        { width: size, height: size, borderRadius: radius ?? size / 2 },
        style,
      ]}
      resizeMode="cover"
    />
  );
}

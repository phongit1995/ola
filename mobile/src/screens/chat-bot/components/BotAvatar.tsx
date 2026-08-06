import {
  Image,
  Text,
  View,
  type ImageStyle,
  type StyleProp,
  type ViewStyle,
} from 'react-native';
import { CHAT_BOT_TYPE } from '@ola/shared/constants';
import type { ChatBotType } from '@ola/shared/types';

const chatBotAvatar = require('@assets/icons/chat/ic_chat_bot_ola.png');
const FORTUNE_AVATAR_BG = '#4527a0';

interface BotAvatarProps {
  bot?: ChatBotType;
  size?: number;
  radius?: number;
  style?: StyleProp<ImageStyle>;
}

export function BotAvatar({
  bot = CHAT_BOT_TYPE.olala,
  size = 32,
  radius,
  style,
}: BotAvatarProps) {
  if (bot === CHAT_BOT_TYPE.olavi) {
    return (
      <View
        style={[
          {
            width: size,
            height: size,
            borderRadius: radius ?? size / 2,
            backgroundColor: FORTUNE_AVATAR_BG,
            alignItems: 'center',
            justifyContent: 'center',
          },
          style as StyleProp<ViewStyle>,
        ]}
      >
        <Text style={{ fontSize: Math.round(size * 0.5) }}>🔮</Text>
      </View>
    );
  }

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

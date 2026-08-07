import {
  Image,
  type ImageStyle,
  type StyleProp,
} from 'react-native';
import { CHAT_BOT_TYPE } from '@ola/shared/constants';
import type { ChatBotType } from '@ola/shared/types';

const chatBotAvatar = require('@assets/icons/chat/ic_chat_bot_ola.png');
const fortuneBotAvatar = require('@assets/icons/chat/ic_chat_bot_olavi.png');

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
  const avatar =
    bot === CHAT_BOT_TYPE.olavi ? fortuneBotAvatar : chatBotAvatar;

  return (
    <Image
      source={avatar}
      style={[
        { width: size, height: size, borderRadius: radius ?? size / 2 },
        style,
      ]}
      resizeMode="cover"
    />
  );
}

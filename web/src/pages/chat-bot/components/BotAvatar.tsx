import { cn } from '@lib';
import { CHAT_BOT_TYPE } from '@ola/shared/constants';
import type { ChatBotType } from '@ola/shared/types';
import chatBotAvatar from '@/assets/icons/chat/ic_chat_bot_ola.png';
import fortuneBotAvatar from '@/assets/icons/chat/ic_chat_bot_olavi.png';

interface BotAvatarProps {
  name: string;
  bot?: ChatBotType;
  className?: string;
}

export function BotAvatar({
  name,
  bot = CHAT_BOT_TYPE.olala,
  className,
}: BotAvatarProps) {
  const avatar =
    bot === CHAT_BOT_TYPE.olavi ? fortuneBotAvatar : chatBotAvatar;

  return (
    <img
      src={avatar}
      alt={name}
      className={cn(
        'shrink-0 rounded-full object-cover',
        className ?? 'h-8 w-8'
      )}
    />
  );
}

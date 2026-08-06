import { cn } from '@lib';
import { CHAT_BOT_TYPE } from '@ola/shared/constants';
import type { ChatBotType } from '@ola/shared/types';
import chatBotAvatar from '@/assets/icons/chat/ic_chat_bot_ola.png';

const FORTUNE_AVATAR_BG = '#4527a0';

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
  if (bot === CHAT_BOT_TYPE.olavi) {
    return (
      <span
        role="img"
        aria-label={name}
        className={cn(
          'flex shrink-0 items-center justify-center rounded-full text-base',
          className ?? 'h-8 w-8'
        )}
        style={{ backgroundColor: FORTUNE_AVATAR_BG }}
      >
        🔮
      </span>
    );
  }

  return (
    <img
      src={chatBotAvatar}
      alt={name}
      className={cn(
        'shrink-0 rounded-full object-cover',
        className ?? 'h-8 w-8'
      )}
    />
  );
}

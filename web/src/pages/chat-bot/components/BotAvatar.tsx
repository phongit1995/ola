import { cn } from '@lib';
import chatBotAvatar from '@/assets/icons/chat/ic_chat_bot_ola.png';

interface BotAvatarProps {
  name: string;
  className?: string;
}

export function BotAvatar({ name, className }: BotAvatarProps) {
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

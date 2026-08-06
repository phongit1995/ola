import type { ChatBotType } from '@app-types';
import { BotAvatar } from './BotAvatar';

export function BotTypingRow({ bot, name }: { bot: ChatBotType; name: string }) {
  return (
    <div className="mt-1 flex items-end gap-1">
      <span className="shrink-0 self-start">
        <BotAvatar bot={bot} name={name} />
      </span>
      <div className="flex items-center gap-1 rounded-2xl rounded-tl-sm bg-white px-3 py-3 shadow-sm">
        <span className="h-1.5 w-1.5 animate-bounce rounded-full bg-black/40" />
        <span className="h-1.5 w-1.5 animate-bounce rounded-full bg-black/40 [animation-delay:150ms]" />
        <span className="h-1.5 w-1.5 animate-bounce rounded-full bg-black/40 [animation-delay:300ms]" />
      </div>
    </div>
  );
}

import { useTranslation } from 'react-i18next';
import { CHAT_BOT_I18N } from '@ola/shared/constants';
import type { ChatBotType } from '@ola/shared/types';
import { BotAvatar } from './BotAvatar';

export function ChatBotEmptyState({
  bot,
  botName,
}: {
  bot: ChatBotType;
  botName: string;
}) {
  const { t } = useTranslation();
  const texts = CHAT_BOT_I18N[bot];

  return (
    <div className="flex flex-1 flex-col items-center justify-center px-8 text-center">
      <BotAvatar bot={bot} name={botName} className="h-16 w-16 shadow-sm" />
      <p className="mt-3 text-sm text-black/54">{t(texts.emptyTitle)}</p>
      {texts.emptyHint != null && (
        <p className="mt-1 text-xs text-black/38">{t(texts.emptyHint)}</p>
      )}
    </div>
  );
}

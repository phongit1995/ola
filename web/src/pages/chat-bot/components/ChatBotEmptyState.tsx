import { useTranslation } from 'react-i18next';
import { BotAvatar } from './BotAvatar';

export function ChatBotEmptyState({ botName }: { botName: string }) {
  const { t } = useTranslation();

  return (
    <div className="flex flex-1 flex-col items-center justify-center px-8 text-center">
      <BotAvatar name={botName} className="h-16 w-16 shadow-sm" />
      <p className="mt-3 text-sm text-black/54">{t('chat.chatBotEmptyTitle')}</p>
    </div>
  );
}

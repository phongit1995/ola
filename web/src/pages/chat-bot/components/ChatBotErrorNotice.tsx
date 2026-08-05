import { useTranslation } from 'react-i18next';
import type { ChatBotErrorCode } from '@app-types';
import { ERROR_KEYS } from '../constants';

interface ChatBotErrorNoticeProps {
  code: ChatBotErrorCode;
  onRetry: () => void;
}

export function ChatBotErrorNotice({ code, onRetry }: ChatBotErrorNoticeProps) {
  const { t } = useTranslation();

  return (
    <div className="mt-2 flex flex-col items-center gap-2">
      <span className="rounded-full bg-black/45 px-3 py-1 text-[11px] text-white">
        {t(ERROR_KEYS[code])}
      </span>
      <button
        type="button"
        onClick={onRetry}
        className="rounded-full bg-white px-4 py-1.5 text-xs font-bold text-ola-primary shadow-sm active:scale-95"
      >
        {t('chat.chatBotRetry')}
      </button>
    </div>
  );
}

import { useTranslation } from 'react-i18next';
import type { RefObject } from 'react';
import { SmileyInput, type SmileyInputHandle } from '@components';
import sendIcon from '@/assets/icons/chat/ic_action_send_white.png';

interface ChatBotComposerProps {
  inputRef: RefObject<SmileyInputHandle | null>;
  value: string;
  onChange: (value: string) => void;
  streaming: boolean;
  onSend: () => void;
  onStop: () => void;
}

export function ChatBotComposer({
  inputRef,
  value,
  onChange,
  streaming,
  onSend,
  onStop,
}: ChatBotComposerProps) {
  const { t } = useTranslation();

  return (
    <div className="relative flex min-h-12 shrink-0 items-end gap-1 border-t border-black/12 bg-white px-2 py-1.5">
      <div className="min-w-0 flex-1">
        <SmileyInput
          ref={inputRef}
          value={value}
          onChange={onChange}
          onEnter={onSend}
          placeholder={t('chat.chatBotPlaceholder')}
          disabled={streaming}
          multiline
        />
      </div>
      <button
        type="button"
        onClick={streaming ? onStop : onSend}
        disabled={!streaming && value.trim() === ''}
        aria-label={streaming ? t('chat.chatBotStop') : t('chat.send')}
        className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-ola-primary transition-opacity disabled:opacity-40"
      >
        {streaming ? (
          <span className="h-3.5 w-3.5 rounded-[2px] bg-white" />
        ) : (
          <img
            src={sendIcon}
            alt=""
            className="h-5 w-5 object-contain brightness-0 invert"
          />
        )}
      </button>
    </div>
  );
}

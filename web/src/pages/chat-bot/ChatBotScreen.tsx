import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, FullScreenOverlay, ScreenHeader } from '@components';
import { colorForName } from '@lib';
import deleteIcon from '@/assets/icons/chat/ic_menu_delete.png';
import { useAuthStore } from '@/store/authStore';
import { useChatBotConversation } from './useChatBotConversation';
import { BotAvatar } from './components/BotAvatar';
import { ChatBotComposer } from './components/ChatBotComposer';
import { ChatBotMessageList } from './components/ChatBotMessageList';
import { ChatBotSuggestions } from './components/ChatBotSuggestions';

interface ChatBotScreenProps {
  onClose: () => void;
}

export function ChatBotScreen({ onClose }: ChatBotScreenProps) {
  const { t } = useTranslation();
  const me = useAuthStore((s) => s.user);
  const [clearOpen, setClearOpen] = useState(false);
  const conversation = useChatBotConversation();

  const botName = t('chat.chatBot');
  const meName = me?.username ?? '';
  const meAvatar = me?.avatar;
  const showSuggestions =
    conversation.visible.length === 0 && !conversation.waiting;

  const viewer = useMemo(
    () => ({ name: meName, color: colorForName(meName), avatar: meAvatar }),
    [meName, meAvatar]
  );

  return (
    <FullScreenOverlay position="absolute">
      <ScreenHeader
        title={botName}
        subtitle={
          conversation.streaming ? t('chat.chatBotThinking') : undefined
        }
        onBack={onClose}
        left={<BotAvatar name={botName} />}
      >
        <button
          type="button"
          aria-label={t('chat.chatBotClear')}
          onClick={() => setClearOpen(true)}
          disabled={conversation.messages.length === 0}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15 disabled:opacity-40"
        >
          <img
            src={deleteIcon}
            alt=""
            className="h-5 w-5 object-contain brightness-0 invert"
          />
        </button>
      </ScreenHeader>

      <ChatBotMessageList
        scrollRef={conversation.scrollRef}
        onScroll={conversation.handleScroll}
        messages={conversation.visible}
        botName={botName}
        viewer={viewer}
        waiting={conversation.waiting}
        error={conversation.error}
        onRetry={conversation.retry}
      />

      {showSuggestions && (
        <ChatBotSuggestions
          keys={conversation.suggestions}
          onPick={conversation.ask}
        />
      )}

      <ChatBotComposer
        inputRef={conversation.composerRef}
        value={conversation.draft}
        onChange={conversation.setDraft}
        streaming={conversation.streaming}
        onSend={conversation.send}
        onStop={conversation.stop}
      />

      <ConfirmDialog
        open={clearOpen}
        danger
        title={t('chat.chatBotClear')}
        message={t('chat.chatBotClearConfirm')}
        confirmLabel={t('dialog.delete')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => {
          setClearOpen(false);
          conversation.clearHistory();
        }}
        onCancel={() => setClearOpen(false)}
      />
    </FullScreenOverlay>
  );
}

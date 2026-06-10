import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, ListOptionDialog, type ListOption } from '@components';
import type { ChatMessage } from '../types';
import { Avatar } from './Avatar';

interface ChatConversationViewProps {
  name: string;
  color: string;
  seedMessage?: string;
  onClose: () => void;
}

const AUTO_REPLIES = [
  'Ừ đúng rồi 😄',
  'Hihi, nghe hay đấy!',
  'Để mình xem nhé',
  'Ok bạn 👍',
  'Lát nữa mình rảnh nha',
];

let messageCounterSeed = 0;
function nextMessageId() {
  messageCounterSeed += 1;
  return `m${messageCounterSeed}`;
}

export function ChatConversationView({
  name,
  color,
  seedMessage,
  onClose,
}: ChatConversationViewProps) {
  const { t } = useTranslation();
  const [messages, setMessages] = useState<ChatMessage[]>(() =>
    seedMessage != null
      ? [{ id: nextMessageId(), text: seedMessage, direction: 'in' }]
      : []
  );
  const [draft, setDraft] = useState('');
  const [menuOpen, setMenuOpen] = useState(false);
  const [blockOpen, setBlockOpen] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    scrollRef.current?.scrollTo({ top: scrollRef.current.scrollHeight });
  }, [messages]);

  function appendBotReply() {
    const reply = AUTO_REPLIES[Math.floor(Math.random() * AUTO_REPLIES.length)];
    setMessages((current) => [
      ...current,
      { id: nextMessageId(), text: reply, direction: 'in' },
    ]);
  }

  function sendText(text: string) {
    const trimmed = text.trim();
    if (trimmed === '') return;
    setMessages((current) => [
      ...current,
      { id: nextMessageId(), text: trimmed, direction: 'out' },
    ]);
    setDraft('');
    window.setTimeout(appendBotReply, 800);
  }

  const isTyping = draft.trim() !== '';

  const menuOptions: ListOption[] = [
    { key: 'make-friend', label: t('chat.menuMakeFriend'), onSelect: () => {} },
    { key: 'view-me', label: t('chat.menuViewMe'), onSelect: () => {} },
    { key: 'block', label: t('chat.menuBlock'), danger: true, onSelect: () => setBlockOpen(true) },
    { key: 'chat-group', label: t('chat.menuChatGroup'), onSelect: () => {} },
  ];

  return (
    <div className="fixed inset-0 z-40 flex flex-col bg-[#eceff1]">
      <header className="flex h-12 shrink-0 items-center gap-2 bg-ola-primary px-2 text-white shadow-[0_1px_0_rgba(0,0,0,.12)]">
        <button
          type="button"
          aria-label={t('chat.back')}
          onClick={onClose}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <svg viewBox="0 0 24 24" className="h-6 w-6" fill="currentColor" aria-hidden="true">
            <path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />
          </svg>
        </button>
        <Avatar name={name} color={color} size={32} />
        <span className="flex-1 truncate text-base font-medium">{name}</span>
        <button
          type="button"
          aria-label="Menu"
          onClick={() => setMenuOpen(true)}
          className="flex h-9 w-9 items-center justify-center rounded-full text-xl hover:bg-white/15"
        >
          ⋮
        </button>
      </header>

      <div ref={scrollRef} className="flex flex-1 flex-col gap-2 overflow-y-auto p-3">
        {messages.map((message) => (
          <div
            key={message.id}
            className={`max-w-[80%] rounded-lg px-3 py-2 text-base text-black/87 ${
              message.direction === 'out'
                ? 'self-end bg-[#dcedc8]'
                : 'self-start bg-white shadow-sm'
            }`}
          >
            {message.text}
          </div>
        ))}
      </div>

      <form
        onSubmit={(event) => {
          event.preventDefault();
          sendText(draft);
        }}
        className="flex items-end gap-1 border-t border-black/12 bg-white px-2 py-1.5"
      >
        <input
          value={draft}
          onChange={(event) => setDraft(event.target.value)}
          placeholder={t('chat.messageInputPlaceholder', { name })}
          className="min-h-9 flex-1 bg-transparent px-2 text-base text-black/87 outline-none placeholder:text-black/38"
        />
        {isTyping ? (
          <button
            type="submit"
            className="min-w-12 px-2 text-base font-medium text-ola-primary"
          >
            {t('chat.send')}
          </button>
        ) : (
          <button
            type="button"
            aria-label={t('chat.like')}
            onClick={() => sendText('👍')}
            className="flex h-9 w-9 items-center justify-center text-2xl"
          >
            👍
          </button>
        )}
      </form>

      <ListOptionDialog
        open={menuOpen}
        title={name}
        options={menuOptions}
        onClose={() => setMenuOpen(false)}
      />
      <ConfirmDialog
        open={blockOpen}
        danger
        title={t('chat.blockTitle')}
        message={t('chat.blockMessage', { name })}
        confirmLabel={t('chat.block')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => {
          setBlockOpen(false);
          onClose();
        }}
        onCancel={() => setBlockOpen(false)}
      />
    </div>
  );
}

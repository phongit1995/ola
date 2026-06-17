import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Avatar,
  ConfirmDialog,
  FullScreenOverlay,
  ListOptionDialog,
  ScreenHeader,
  type ListOption,
} from '@components';
import moreIcon from '@/assets/icons/chat/ic_more_white.png';
import likeIcon from '@/assets/icons/chat/smiley_35.png';
import sentIcon from '@/assets/icons/chat/ic_message_sent.png';
import resendIcon from '@/assets/icons/chat/btn_resend_d.png';
import type { ChatMessage } from '../types';
import { AttachmentBar, type AttachTab } from './AttachmentBar';
import { ChatMessageBubble, StrangerCardBubble } from './ChatMessageBubble';

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

function clock() {
  const now = new Date();
  return `${String(now.getHours()).padStart(2, '0')}:${String(now.getMinutes()).padStart(2, '0')}`;
}

function randomReply() {
  return AUTO_REPLIES[Math.floor(Math.random() * AUTO_REPLIES.length)]!;
}

export function ChatConversationView({ name, color, seedMessage, onClose }: ChatConversationViewProps) {
  const { t } = useTranslation();
  const [messages, setMessages] = useState<ChatMessage[]>(() => {
    const card: ChatMessage = {
      id: nextMessageId(),
      direction: 'in',
      kind: 'stranger',
      time: clock(),
      stranger: {
        name,
        color,
        age: 24,
        joinYear: 2014,
        fans: 128,
        status: 'Xin chào, rất vui được làm quen 🌸',
        vip: false,
        verified: false,
      },
    };
    if (seedMessage == null) return [card];
    return [card, { id: nextMessageId(), kind: 'text', text: seedMessage, direction: 'in', time: clock() }];
  });
  const [draft, setDraft] = useState('');
  const [botTyping, setBotTyping] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);
  const [blockOpen, setBlockOpen] = useState(false);
  const [openTab, setOpenTab] = useState<AttachTab | null>(null);
  const scrollRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    scrollRef.current?.scrollTo({ top: scrollRef.current.scrollHeight });
  }, [messages, botTyping, openTab]);

  function scheduleBotReply() {
    window.setTimeout(() => setBotTyping(true), 900);
    window.setTimeout(() => {
      setBotTyping(false);
      setMessages((current) => [
        ...current.map((m) => (m.direction === 'out' ? { ...m, status: 'seen' as const } : m)),
        { id: nextMessageId(), kind: 'text', text: randomReply(), direction: 'in', time: clock() },
      ]);
    }, 2000);
  }

  function pushOut(partial: Partial<ChatMessage> & Pick<ChatMessage, 'kind'>) {
    const id = nextMessageId();
    setMessages((current) => [
      ...current,
      { id, direction: 'out', time: clock(), status: 'sending', ...partial },
    ]);
    window.setTimeout(
      () => setMessages((c) => c.map((m) => (m.id === id ? { ...m, status: 'sent' } : m))),
      500
    );
    scheduleBotReply();
  }

  function sendText(text: string) {
    const trimmed = text.trim();
    if (trimmed === '') return;
    pushOut({ kind: 'text', text: trimmed });
    setDraft('');
  }

  function dismissStranger() {
    setMessages((current) => current.filter((m) => m.kind !== 'stranger'));
  }

  const isTyping = draft.trim() !== '';

  const menuOptions: ListOption[] = [
    { key: 'make-friend', label: t('chat.menuMakeFriend'), onSelect: () => {} },
    { key: 'view-me', label: t('chat.menuViewMe'), onSelect: () => {} },
    { key: 'block', label: t('chat.menuBlock'), danger: true, onSelect: () => setBlockOpen(true) },
    { key: 'chat-group', label: t('chat.menuChatGroup'), onSelect: () => {} },
  ];

  return (
    <FullScreenOverlay>
      <ScreenHeader
        title={name}
        subtitle={botTyping ? t('chat.typing', { name }) : t('chat.statusActive')}
        onBack={onClose}
        left={<Avatar name={name} color={color} size={32} />}
      >
        <button
          type="button"
          aria-label={t('common.menu')}
          onClick={() => setMenuOpen(true)}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <img src={moreIcon} alt="" className="h-5 w-5 object-contain" />
        </button>
      </ScreenHeader>

      <div ref={scrollRef} className="flex flex-1 flex-col gap-0.5 overflow-y-auto bg-[#ECE5DD] px-2 py-3">
        <div className="mx-auto mb-2 rounded-full bg-black/20 px-3 py-1 text-xs text-white">
          {t('chat.today')}
        </div>

        {messages.map((message, index) => {
          if (message.kind === 'stranger') {
            return (
              <StrangerCardBubble
                key={message.id}
                message={message}
                onClose={dismissStranger}
                onBlock={() => setBlockOpen(true)}
                onAddFriend={dismissStranger}
              />
            );
          }

          const prev = messages[index - 1];
          const boundary = prev == null || prev.kind === 'stranger';
          const isOut = message.direction === 'out';
          const showTime = boundary || prev.direction !== message.direction || prev.time !== message.time;
          const showAvatar = !isOut && (boundary || prev.direction !== 'in');

          return (
            <div key={message.id} className="flex flex-col">
              {showTime && (
                <span className="my-1 self-center text-xs text-black/26">{message.time}</span>
              )}
              <div className={`flex items-end gap-1 ${isOut ? 'flex-row-reverse' : ''}`}>
                {!isOut &&
                  (showAvatar ? (
                    <Avatar name={name} color={color} size={32} />
                  ) : (
                    <span className="w-8 shrink-0" />
                  ))}
                <ChatMessageBubble message={message} />
                {isOut && <SendStatus message={message} peerName={name} peerColor={color} />}
              </div>
            </div>
          );
        })}

        {botTyping && (
          <div className="mt-1 flex items-end gap-1">
            <Avatar name={name} color={color} size={32} />
            <div className="flex items-center gap-1 rounded-2xl rounded-tl-sm bg-white px-3 py-3 shadow-sm">
              <span className="h-1.5 w-1.5 animate-bounce rounded-full bg-black/40" />
              <span className="h-1.5 w-1.5 animate-bounce rounded-full bg-black/40 [animation-delay:150ms]" />
              <span className="h-1.5 w-1.5 animate-bounce rounded-full bg-black/40 [animation-delay:300ms]" />
            </div>
          </div>
        )}
      </div>

      <form
        onSubmit={(event) => {
          event.preventDefault();
          sendText(draft);
        }}
        className="flex shrink-0 items-end gap-1 border-t border-black/12 bg-white px-2 py-1.5"
      >
        <input
          value={draft}
          onChange={(event) => setDraft(event.target.value)}
          onFocus={() => setOpenTab(null)}
          placeholder={t('chat.messageInputPlaceholder', { name })}
          className="min-h-9 flex-1 bg-transparent px-2 text-base text-black/87 outline-none placeholder:text-black/38"
        />
        {isTyping ? (
          <button type="submit" className="min-w-12 px-2 text-base font-medium text-ola-primary">
            {t('chat.send')}
          </button>
        ) : (
          <button
            type="button"
            aria-label={t('chat.like')}
            onClick={() => pushOut({ kind: 'sticker', sticker: '👍' })}
            className="flex h-9 w-9 items-center justify-center"
          >
            <img src={likeIcon} alt="" className="h-7 w-7 object-contain" />
          </button>
        )}
      </form>

      <AttachmentBar
        openTab={openTab}
        onToggleTab={(tab) => setOpenTab((current) => (current === tab ? null : tab))}
        onPickEmoji={(emoji) => setDraft((current) => current + emoji)}
        onSend={(payload) => {
          pushOut(payload);
          setOpenTab(null);
        }}
      />

      <ListOptionDialog open={menuOpen} title={name} options={menuOptions} onClose={() => setMenuOpen(false)} />
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
    </FullScreenOverlay>
  );
}

function SendStatus({
  message,
  peerName,
  peerColor,
}: {
  message: ChatMessage;
  peerName: string;
  peerColor: string;
}) {
  const { t } = useTranslation();

  if (message.status === 'sending') {
    return (
      <span className="h-4 w-4 shrink-0 animate-spin rounded-full border-2 border-black/20 border-t-transparent" />
    );
  }
  if (message.status === 'failed') {
    return (
      <span className="flex shrink-0 items-center gap-1 text-xs text-ola-error">
        <img src={resendIcon} alt={t('chat.resend')} className="h-5 w-5 object-contain" />
      </span>
    );
  }
  if (message.status === 'seen') {
    return <Avatar name={peerName} color={peerColor} size={14} />;
  }
  return <img src={sentIcon} alt="" className="h-3.5 w-3.5 shrink-0 object-contain opacity-60" />;
}

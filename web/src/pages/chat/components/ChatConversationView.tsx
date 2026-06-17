import { useEffect, useLayoutEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Avatar,
  ConfirmDialog,
  FullScreenOverlay,
  ListOptionDialog,
  ScreenHeader,
  type ListOption,
} from '@components';
import { toast } from '@lib';
import moreIcon from '@/assets/icons/chat/ic_more_white.png';
import likeIcon from '@/assets/icons/chat/smiley_35.png';
import sentIcon from '@/assets/icons/chat/ic_message_sent.png';
import resendIcon from '@/assets/icons/chat/btn_resend_d.png';
import { useChatStore } from '@/store/chatStore';
import { useAuthStore } from '@/store/authStore';
import type { ChatMessage } from '../types';
import { toBubble } from '../chatView';
import { AttachmentBar, type AttachTab } from './AttachmentBar';
import { ChatMessageBubble } from './ChatMessageBubble';

interface ChatConversationViewProps {
  name: string;
  color: string;
  avatar?: string;
  online?: boolean;
  onClose: () => void;
}

export function ChatConversationView({
  name,
  color,
  avatar,
  online,
  onClose,
}: ChatConversationViewProps) {
  const { t } = useTranslation();

  const myId = useAuthStore((s) => s.user?.id ?? '');
  const messages = useChatStore((s) => s.messages);
  const typingUsers = useChatStore((s) => s.typingUsers);
  const hasMore = useChatStore((s) => s.hasMore);
  const loadingMore = useChatStore((s) => s.loadingMore);
  const sendText = useChatStore((s) => s.sendText);
  const notifyTyping = useChatStore((s) => s.notifyTyping);
  const loadMoreMessages = useChatStore((s) => s.loadMoreMessages);

  const [draft, setDraft] = useState('');
  const [menuOpen, setMenuOpen] = useState(false);
  const [blockOpen, setBlockOpen] = useState(false);
  const [openTab, setOpenTab] = useState<AttachTab | null>(null);
  const scrollRef = useRef<HTMLDivElement>(null);
  const lastBubbleIdRef = useRef<string | null>(null);
  const prependAnchorRef = useRef<number | null>(null);

  const peerTyping = typingUsers.length > 0;

  const bubbles = useMemo<ChatMessage[]>(
    () => messages.map((message) => toBubble(message, myId)),
    [messages, myId]
  );

  useLayoutEffect(() => {
    const element = scrollRef.current;
    if (element == null) return;
    const lastId = bubbles[bubbles.length - 1]?.id ?? null;
    if (prependAnchorRef.current != null) {
      element.scrollTop = element.scrollHeight - prependAnchorRef.current;
      prependAnchorRef.current = null;
    } else if (lastId !== lastBubbleIdRef.current) {
      element.scrollTo({ top: element.scrollHeight });
    }
    lastBubbleIdRef.current = lastId;
  }, [bubbles]);

  useEffect(() => {
    scrollRef.current?.scrollTo({ top: scrollRef.current.scrollHeight });
  }, [peerTyping, openTab]);

  function handleScroll() {
    const element = scrollRef.current;
    if (element == null || element.scrollTop > 0 || !hasMore || loadingMore) return;
    prependAnchorRef.current = element.scrollHeight;
    void loadMoreMessages();
  }

  function send(text: string) {
    const trimmed = text.trim();
    if (trimmed === '') return;
    void sendText(trimmed);
    setDraft('');
  }

  function handleDraftChange(value: string) {
    setDraft(value);
    notifyTyping();
  }

  const isTyping = draft.trim() !== '';

  const menuOptions: ListOption[] = [
    { key: 'make-friend', label: t('chat.menuMakeFriend'), onSelect: () => toast.info(t('chat.comingSoon')) },
    { key: 'view-me', label: t('chat.menuViewMe'), onSelect: () => toast.info(t('chat.comingSoon')) },
    { key: 'block', label: t('chat.menuBlock'), danger: true, onSelect: () => setBlockOpen(true) },
    { key: 'chat-group', label: t('chat.menuChatGroup'), onSelect: () => toast.info(t('chat.comingSoon')) },
  ];

  return (
    <FullScreenOverlay>
      <ScreenHeader
        title={name}
        subtitle={peerTyping ? t('chat.typing', { name }) : online ? t('chat.statusActive') : ''}
        onBack={onClose}
        left={<Avatar name={name} color={color} src={avatar} size={32} />}
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

      <div
        ref={scrollRef}
        onScroll={handleScroll}
        className="flex flex-1 flex-col gap-0.5 overflow-y-auto bg-[#ECE5DD] px-2 py-3"
      >
        {bubbles.map((message, index) => {
          const prev = bubbles[index - 1];
          const boundary = prev == null;
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
                    <Avatar name={name} color={color} src={avatar} size={32} />
                  ) : (
                    <span className="w-8 shrink-0" />
                  ))}
                <ChatMessageBubble message={message} />
                {isOut && <SendStatus message={message} />}
              </div>
            </div>
          );
        })}

        {peerTyping && (
          <div className="mt-1 flex items-end gap-1">
            <Avatar name={name} color={color} src={avatar} size={32} />
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
          send(draft);
        }}
        className="flex shrink-0 items-end gap-1 border-t border-black/12 bg-white px-2 py-1.5"
      >
        <input
          value={draft}
          onChange={(event) => handleDraftChange(event.target.value)}
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
            onClick={() => send('👍')}
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
        onSend={() => toast.info(t('chat.comingSoon'))}
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
          toast.info(t('chat.comingSoon'));
        }}
        onCancel={() => setBlockOpen(false)}
      />
    </FullScreenOverlay>
  );
}

function SendStatus({ message }: { message: ChatMessage }) {
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
  return <img src={sentIcon} alt="" className="h-3.5 w-3.5 shrink-0 object-contain opacity-60" />;
}

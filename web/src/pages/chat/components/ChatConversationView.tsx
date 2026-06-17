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
import type { RelationshipStatus } from '@app-types';
import type { ChatMessage } from '../types';
import { reactionChips, toBubble } from '../chatView';
import { useLongPress } from '../useLongPress';
import { AttachmentBar, type AttachTab } from './AttachmentBar';
import { ChatMessageBubble } from './ChatMessageBubble';
import { MessageActionSheet } from './MessageActionSheet';

interface ChatConversationViewProps {
  name: string;
  color: string;
  avatar?: string;
  online?: boolean;
  blockStatus?: RelationshipStatus | null;
  onClose: () => void;
}

export function ChatConversationView({
  name,
  color,
  avatar,
  online,
  blockStatus,
  onClose,
}: ChatConversationViewProps) {
  const { t } = useTranslation();
  const blockedByMe = blockStatus === 'blocked_by_me';
  const blockedByThem = blockStatus === 'blocked_by_them';
  const blocked = blockedByMe || blockedByThem;

  const myId = useAuthStore((s) => s.user?.id ?? '');
  const messages = useChatStore((s) => s.messages);
  const typingUsers = useChatStore((s) => s.typingUsers);
  const hasMore = useChatStore((s) => s.hasMore);
  const loadingMore = useChatStore((s) => s.loadingMore);
  const sendText = useChatStore((s) => s.sendText);
  const sendImage = useChatStore((s) => s.sendImage);
  const reactToMessage = useChatStore((s) => s.reactToMessage);
  const deleteMessage = useChatStore((s) => s.deleteMessage);
  const editMessage = useChatStore((s) => s.editMessage);
  const notifyTyping = useChatStore((s) => s.notifyTyping);
  const loadMoreMessages = useChatStore((s) => s.loadMoreMessages);
  const conversationSeen = useChatStore((s) => {
    const conversation = s.conversations.find((item) => item.id === s.currentConversationId);
    return conversation != null && conversation.isLastMessageFromMe && conversation.seen;
  });

  const [draft, setDraft] = useState('');
  const [menuOpen, setMenuOpen] = useState(false);
  const [blockOpen, setBlockOpen] = useState(false);
  const [openTab, setOpenTab] = useState<AttachTab | null>(null);
  const [actionTarget, setActionTarget] = useState<ChatMessage | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<ChatMessage | null>(null);
  const [editing, setEditing] = useState<{ id: string } | null>(null);
  const scrollRef = useRef<HTMLDivElement>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const lastBubbleIdRef = useRef<string | null>(null);
  const prependAnchorRef = useRef<number | null>(null);

  const peerTyping = typingUsers.length > 0;

  const bubbles = useMemo<ChatMessage[]>(
    () => messages.map((message) => toBubble(message, myId)),
    [messages, myId]
  );

  const lastOwnId = useMemo(() => {
    for (let index = bubbles.length - 1; index >= 0; index -= 1) {
      if (bubbles[index]!.direction === 'out') return bubbles[index]!.id;
    }
    return null;
  }, [bubbles]);

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

  function submitComposer() {
    const trimmed = draft.trim();
    if (trimmed === '') return;
    if (editing != null) {
      void editMessage(editing.id, trimmed);
      setEditing(null);
    } else {
      void sendText(trimmed);
    }
    setDraft('');
  }

  function handleDraftChange(value: string) {
    setDraft(value);
    if (editing == null) notifyTyping();
  }

  function startEdit(message: ChatMessage) {
    setEditing({ id: message.id });
    setDraft(message.text ?? '');
    setOpenTab(null);
  }

  function cancelEdit() {
    setEditing(null);
    setDraft('');
  }

  function handleFileChange(event: React.ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (file != null) {
      void sendImage(file);
      setOpenTab(null);
    }
  }

  const isTyping = draft.trim() !== '';

  const menuOptions: ListOption[] = [
    { key: 'make-friend', label: t('chat.menuMakeFriend'), onSelect: () => toast.info(t('chat.comingSoon')) },
    { key: 'view-me', label: t('chat.menuViewMe'), onSelect: () => toast.info(t('chat.comingSoon')) },
    { key: 'block', label: t('chat.menuBlock'), danger: true, onSelect: () => setBlockOpen(true) },
    { key: 'chat-group', label: t('chat.menuChatGroup'), onSelect: () => toast.info(t('chat.comingSoon')) },
  ];

  return (
    <FullScreenOverlay z={50}>
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
        {bubbles.map((message, index) => (
          <MessageRow
            key={message.id}
            message={message}
            prev={bubbles[index - 1]}
            name={name}
            color={color}
            avatar={avatar}
            isLastOwn={message.id === lastOwnId}
            seen={conversationSeen}
            onOpenActions={setActionTarget}
          />
        ))}

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

      {blocked ? (
        <div className="shrink-0 border-t border-black/12 bg-white px-4 py-3 text-center text-sm text-black/54">
          {blockedByMe ? t('chat.blockedByMe') : t('chat.blockedByThem')}
        </div>
      ) : (
       <>
      {editing != null && (
        <div className="flex items-center gap-2 border-t border-black/12 bg-ola-primary-light px-3 py-1.5 text-sm text-black/70">
          <span className="flex-1">{t('chat.editingHint')}</span>
          <button
            type="button"
            onClick={cancelEdit}
            aria-label={t('dialog.cancel')}
            className="px-2 text-base text-black/54"
          >
            ✕
          </button>
        </div>
      )}

      <form
        onSubmit={(event) => {
          event.preventDefault();
          submitComposer();
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
            {editing != null ? t('chat.actionSave') : t('chat.send')}
          </button>
        ) : (
          <button
            type="button"
            aria-label={t('chat.like')}
            onClick={() => void sendText('👍')}
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
        onPickImage={() => fileInputRef.current?.click()}
        onSend={() => toast.info(t('chat.comingSoon'))}
      />

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        className="hidden"
        onChange={handleFileChange}
      />
       </>
      )}

      {actionTarget != null && (
        <MessageActionSheet
          message={actionTarget}
          isOwn={actionTarget.direction === 'out'}
          onReact={(type) => void reactToMessage(actionTarget.id, type)}
          onEdit={() => startEdit(actionTarget)}
          onDelete={() => setDeleteTarget(actionTarget)}
          onClose={() => setActionTarget(null)}
        />
      )}

      <ListOptionDialog open={menuOpen} title={name} options={menuOptions} onClose={() => setMenuOpen(false)} />
      <ConfirmDialog
        open={deleteTarget != null}
        danger
        title={t('chat.deleteTitle')}
        message={t('chat.deleteConfirm')}
        confirmLabel={t('dialog.delete')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => {
          if (deleteTarget != null) void deleteMessage(deleteTarget.id);
          setDeleteTarget(null);
        }}
        onCancel={() => setDeleteTarget(null)}
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
          toast.info(t('chat.comingSoon'));
        }}
        onCancel={() => setBlockOpen(false)}
      />
    </FullScreenOverlay>
  );
}

interface MessageRowProps {
  message: ChatMessage;
  prev?: ChatMessage;
  name: string;
  color: string;
  avatar?: string;
  isLastOwn: boolean;
  seen: boolean;
  onOpenActions: (message: ChatMessage) => void;
}

function MessageRow({ message, prev, name, color, avatar, isLastOwn, seen, onOpenActions }: MessageRowProps) {
  const isOut = message.direction === 'out';
  const boundary = prev == null;
  const showTime = boundary || prev.direction !== message.direction || prev.time !== message.time;
  const showAvatar = !isOut && (boundary || prev.direction !== 'in');
  const canAct = message.status !== 'sending' && message.status !== 'failed';
  const chips = reactionChips(message.reactions);

  const longPress = useLongPress(() => {
    if (canAct) onOpenActions(message);
  });

  return (
    <div className="flex flex-col">
      {showTime && <span className="my-1 self-center text-xs text-black/26">{message.time}</span>}
      <div className={`flex items-end gap-1 ${isOut ? 'flex-row-reverse' : ''}`}>
        {!isOut &&
          (showAvatar ? (
            <Avatar name={name} color={color} src={avatar} size={32} />
          ) : (
            <span className="w-8 shrink-0" />
          ))}
        <div className="flex max-w-[78%] flex-col">
          <div {...longPress} className="touch-pan-y select-none">
            <ChatMessageBubble message={message} />
          </div>
          {chips.length > 0 && (
            <div className={`mt-0.5 flex flex-wrap gap-1 ${isOut ? 'justify-end' : ''}`}>
              {chips.map((chip) => (
                <span
                  key={chip.type}
                  className="flex items-center gap-0.5 rounded-full bg-white px-1.5 py-0.5 text-xs shadow-sm"
                >
                  <span>{chip.emoji}</span>
                  <span className="text-black/54">{chip.count}</span>
                </span>
              ))}
            </div>
          )}
        </div>
        {isOut && (
          <SendStatus
            message={message}
            isLastOwn={isLastOwn}
            seen={seen}
            name={name}
            color={color}
            avatar={avatar}
          />
        )}
      </div>
    </div>
  );
}

function SendStatus({
  message,
  isLastOwn,
  seen,
  name,
  color,
  avatar,
}: {
  message: ChatMessage;
  isLastOwn: boolean;
  seen: boolean;
  name: string;
  color: string;
  avatar?: string;
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
  if (!isLastOwn) return null;
  if (seen) return <Avatar name={name} color={color} src={avatar} size={14} />;
  return <img src={sentIcon} alt="" className="h-3.5 w-3.5 shrink-0 object-contain opacity-60" />;
}

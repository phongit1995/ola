import { Fragment, useEffect, useLayoutEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActionButton,
  AttachmentBar,
  type AttachTab,
  Avatar,
  ConfirmDialog,
  FullScreenOverlay,
  ListOptionDialog,
  DateSeparator,
  MessageActionSheet,
  type MessageSheetAction,
  ScreenHeader,
  SmileyInput,
  Spinner,
  type SmileyInputHandle,
  type ListOption,
} from '@components';
import { colorForName, compressImageForUpload, hidePeerCard, isPeerCardHidden, isSameDay, kulToken, toast } from '@lib';
import moreIcon from '@/assets/icons/chat/ic_more_white.png';
import likeIcon from '@/assets/icons/chat/smiley_35.png';
import { useChatStore } from '@/store/chat/chatStore';
import { useAuthStore } from '@/store/authStore';
import type { RelationshipStatus } from '@app-types';
import type { ChatMessage } from '../types';
import { toBubble } from '../chatView';
import { formatLastActive } from '../friends';
import { useLongPress } from '@hooks';
import { MessageRow } from './MessageRow';
import { TransferKenDialog } from './TransferKenDialog';
import { TradingVipDialog } from './TradingVipDialog';
import { VoicePreviewBar } from './VoicePreviewBar';
import { PeerProfileCard } from './PeerProfileCard';
import { UserProfileView } from '../../profile/UserProfileView';
import { useMediaViewerStore } from '@/store/mediaViewerStore';

interface ChatConversationViewProps {
  name: string;
  username?: string;
  title?: string;
  color: string;
  avatar?: string;
  online?: boolean;
  lastActiveAt?: string;
  blockStatus?: RelationshipStatus | null;
  onClose: () => void;
}

export function ChatConversationView({
  name,
  username,
  title,
  color,
  avatar,
  online,
  lastActiveAt,
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
  const loadingMessages = useChatStore((s) => s.loadingMessages);
  const sendText = useChatStore((s) => s.sendText);
  const sendImage = useChatStore((s) => s.sendImage);
  const sendAudio = useChatStore((s) => s.sendAudio);
  const resendMessage = useChatStore((s) => s.resendMessage);
  const reactToMessage = useChatStore((s) => s.reactToMessage);
  const deleteMessage = useChatStore((s) => s.deleteMessage);
  const editMessage = useChatStore((s) => s.editMessage);
  const blockPeer = useChatStore((s) => s.blockPeer);
  const unblockPeer = useChatStore((s) => s.unblockPeer);
  const friendAction = useChatStore((s) => s.friendAction);
  const peerProfile = useChatStore((s) => s.peerProfile);
  const peerCardRoll = useChatStore((s) => s.peerCardRoll);
  const notifyTyping = useChatStore((s) => s.notifyTyping);
  const loadMoreMessages = useChatStore((s) => s.loadMoreMessages);
  const currentConversationId = useChatStore((s) => s.currentConversationId);
  const conversationSeen = useChatStore((s) => {
    const conversation = s.conversations.find((item) => item.id === s.currentConversationId);
    return conversation != null && conversation.isLastMessageFromMe && conversation.seen;
  });

  const [draft, setDraft] = useState('');
  const [menuOpen, setMenuOpen] = useState(false);
  const [blockOpen, setBlockOpen] = useState(false);
  const [openTab, setOpenTab] = useState<AttachTab | null>(null);
  const [transferKenOpen, setTransferKenOpen] = useState(false);
  const [tradingVipOpen, setTradingVipOpen] = useState(false);
  const [pendingAudio, setPendingAudio] = useState<{ blob: Blob; duration: number } | null>(null);
  const [actionTarget, setActionTarget] = useState<{
    message: ChatMessage;
    anchor: DOMRect | null;
  } | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<ChatMessage | null>(null);
  const [editing, setEditing] = useState<{ id: string } | null>(null);
  const openViewer = useMediaViewerStore((s) => s.openViewer);
  const [profileTarget, setProfileTarget] = useState<{ username: string; color: string } | null>(
    null
  );
  const [now, setNow] = useState<number | null>(null);
  const scrollRef = useRef<HTMLDivElement>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const composerRef = useRef<SmileyInputHandle>(null);
  const lastBubbleIdRef = useRef<string | null>(null);
  const prependAnchorRef = useRef<number | null>(null);
  const stickToBottomRef = useRef(true);
  const suppressLikeClick = useRef(false);
  const likeLongPress = useLongPress(() => {
    suppressLikeClick.current = true;
    void sendText('(Y)');
  });

  const peerTyping = typingUsers.length > 0;

  useEffect(() => {
    const tick = () => setNow(Date.now());
    const initial = setTimeout(tick, 0);
    const interval = setInterval(tick, 60_000);
    return () => {
      clearTimeout(initial);
      clearInterval(interval);
    };
  }, []);

  const lastActiveText =
    now != null && !online && !peerTyping ? formatLastActive(t, lastActiveAt, now) : undefined;

  const peerId = peerProfile?.id ?? '';
  const [cardHiddenFor, setCardHiddenFor] = useState(() =>
    peerId !== '' && isPeerCardHidden(peerId) ? peerId : ''
  );
  const [trackedPeerId, setTrackedPeerId] = useState(peerId);
  if (trackedPeerId !== peerId) {
    setTrackedPeerId(peerId);
    setCardHiddenFor(peerId !== '' && isPeerCardHidden(peerId) ? peerId : '');
  }
  const peerCardHidden = peerId !== '' && cardHiddenFor === peerId;

  const sizeAllowsCard = (!hasMore && messages.length < 10) || peerCardRoll;

  const showPeerCard =
    !blocked &&
    peerProfile != null &&
    !peerCardHidden &&
    sizeAllowsCard &&
    (blockStatus === 'none' ||
      blockStatus === 'pending_outgoing' ||
      blockStatus === 'pending_incoming');

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

  const [activeConversationId, setActiveConversationId] = useState(currentConversationId);
  if (activeConversationId !== currentConversationId) {
    setActiveConversationId(currentConversationId);
    setPendingAudio(null);
    setOpenTab(null);
    setEditing(null);
    setDraft('');
  }

  useEffect(() => {
    stickToBottomRef.current = true;
    lastBubbleIdRef.current = null;
  }, [currentConversationId]);

  useLayoutEffect(() => {
    const element = scrollRef.current;
    if (element == null) return;
    const lastId = bubbles[bubbles.length - 1]?.id ?? null;
    if (prependAnchorRef.current != null) {
      element.scrollTop = element.scrollHeight - prependAnchorRef.current;
      prependAnchorRef.current = null;
    } else if (lastId !== lastBubbleIdRef.current && stickToBottomRef.current) {
      element.scrollTop = element.scrollHeight;
    }
    lastBubbleIdRef.current = lastId;
  }, [bubbles]);

  useEffect(() => {
    const element = scrollRef.current;
    if (element == null) return;
    function scrollToBottomIfPinned() {
      const target = scrollRef.current;
      if (target != null && stickToBottomRef.current) target.scrollTop = target.scrollHeight;
    }
    element.addEventListener('load', scrollToBottomIfPinned, true);
    return () => element.removeEventListener('load', scrollToBottomIfPinned, true);
  }, []);

  useEffect(() => {
    if (stickToBottomRef.current) {
      scrollRef.current?.scrollTo({ top: scrollRef.current.scrollHeight });
    }
  }, [peerTyping, openTab, showPeerCard]);

  function handleScroll() {
    const element = scrollRef.current;
    if (element == null) return;
    const distanceFromBottom = element.scrollHeight - element.scrollTop - element.clientHeight;
    stickToBottomRef.current = distanceFromBottom < 80;
    if (element.scrollTop <= 0 && hasMore && !loadingMore) {
      prependAnchorRef.current = element.scrollHeight;
      void loadMoreMessages();
    }
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

  function messageSheetActions(message: ChatMessage): MessageSheetAction[] {
    const isOwn = message.direction === 'out';
    const actions: MessageSheetAction[] = [];
    if (isOwn && message.kind === 'text') {
      actions.push({ key: 'edit', label: t('chat.actionEdit'), onSelect: () => startEdit(message) });
    }
    if (isOwn) {
      actions.push({
        key: 'delete',
        label: t('chat.actionDelete'),
        destructive: true,
        onSelect: () => setDeleteTarget(message),
      });
    }
    return actions;
  }

  function cancelEdit() {
    setEditing(null);
    setDraft('');
  }

  async function handleFileChange(event: React.ChangeEvent<HTMLInputElement>) {
    const files = Array.from(event.target.files ?? []);
    event.target.value = '';
    if (files.length === 0) return;
    setOpenTab(null);
    for (const file of files) {
      try {
        const prepared = await compressImageForUpload(file);
        await sendImage(prepared);
      } catch {
        toast.error(t('chat.imageError'));
      }
    }
  }

  const isTyping = draft.trim() !== '';

  const canViewProfile = username != null && username !== '';

  function openPeerProfile() {
    if (username != null && username !== '') setProfileTarget({ username, color });
  }

  function openMentionProfile(nick: string) {
    if (nick !== '') setProfileTarget({ username: nick, color: colorForName(nick) });
  }

  function showPeerAvatar() {
    const url = peerProfile?.avatar ?? avatar ?? '';
    if (url !== '') openViewer([url]);
  }

  function handleHidePeerCard() {
    if (peerId === '') return;
    hidePeerCard(peerId);
    setCardHiddenFor(peerId);
  }

  async function handleBlock() {
    setBlockOpen(false);
    const ok = await blockPeer();
    toast[ok ? 'success' : 'error'](ok ? t('chat.blockDone', { name }) : t('chat.actionError'));
  }

  async function handleUnblock() {
    const ok = await unblockPeer();
    toast[ok ? 'success' : 'error'](ok ? t('chat.unblockDone', { name }) : t('chat.actionError'));
  }

  async function handleFriendAction() {
    if (blocked) {
      toast.info(t('chat.makeFriendBlocked'));
      return;
    }
    const result = await friendAction();
    if (result === 'error') {
      toast.error(t('chat.actionError'));
      return;
    }
    if (result === 'request') toast.success(t('chat.friendRequestSent'));
    else if (result === 'cancel') toast.success(t('chat.requestCancelled'));
    else if (result === 'accept') toast.success(t('chat.friendAccepted'));
    else if (result === 'unfriend') toast.success(t('chat.unfriendDone'));
  }

  const friendLabel =
    blockStatus === 'pending_outgoing'
      ? t('chat.cancelRequest')
      : blockStatus === 'pending_incoming'
        ? t('chat.acceptRequest')
        : blockStatus === 'friend'
          ? t('chat.unfriend')
          : t('chat.menuMakeFriend');

  const menuOptions: ListOption[] = [
    { key: 'make-friend', label: friendLabel, onSelect: () => void handleFriendAction() },
    {
      key: 'view-me',
      label: t('chat.menuViewMe'),
      onSelect: () => (canViewProfile ? openPeerProfile() : toast.info(t('chat.comingSoon'))),
    },
    blockedByMe
      ? { key: 'unblock', label: t('chat.menuUnblock'), onSelect: () => void handleUnblock() }
      : { key: 'block', label: t('chat.menuBlock'), danger: true, onSelect: () => setBlockOpen(true) },
    { key: 'chat-group', label: t('chat.menuChatGroup'), onSelect: () => toast.info(t('chat.comingSoon')) },
  ];

  return (
    <FullScreenOverlay z={50}>
      <ScreenHeader
        title={title ?? name}
        subtitle={
          peerTyping
            ? t('chat.typing', { name })
            : online
              ? t('chat.statusActive')
              : lastActiveText ?? ''
        }
        onBack={onClose}
        left={<Avatar name={name} color={color} src={avatar} size={32} />}
        onTitlePress={canViewProfile ? openPeerProfile : undefined}
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
        className="flex flex-1 flex-col gap-0.5 overflow-x-hidden overflow-y-auto bg-[#ECE5DD] px-2 py-3"
      >
        {loadingMessages && messages.length === 0 ? (
          <div className="flex flex-1 items-center justify-center">
            <Spinner size={32} />
          </div>
        ) : (
          <>
            {loadingMore && (
              <div className="flex shrink-0 justify-center py-2">
                <Spinner size={20} tone="muted" />
              </div>
            )}
            {bubbles.map((message, index) => {
              const prev = bubbles[index - 1];
              const showDate =
                !!message.createdAt && !isSameDay(prev?.createdAt ?? '', message.createdAt);
              return (
                <Fragment key={message.id}>
                  {showDate && <DateSeparator iso={message.createdAt ?? ''} />}
                  <MessageRow
                    message={message}
                    prev={prev}
                    next={bubbles[index + 1]}
                    name={name}
                    color={color}
                    avatar={avatar}
                    isLastOwn={message.id === lastOwnId}
                    seen={conversationSeen}
                    onOpenActions={(message, anchor) => setActionTarget({ message, anchor })}
                    onOpenProfile={canViewProfile ? openPeerProfile : undefined}
                    onMention={openMentionProfile}
                    onOpenImage={(img) => openViewer([img])}
                    onResend={resendMessage}
                  />
                </Fragment>
              );
            })}

            {showPeerCard && peerProfile != null && (
              <PeerProfileCard
                profile={peerProfile}
                name={name}
                color={color}
                avatar={avatar}
                onHide={handleHidePeerCard}
                onBlock={() => setBlockOpen(true)}
                friendLabel={friendLabel}
                onFriendAction={() => void handleFriendAction()}
                onShowAvatar={showPeerAvatar}
              />
            )}

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
          </>
        )}
      </div>

      {blocked ? (
        <div className="flex shrink-0 items-center justify-center gap-3 border-t border-black/12 bg-white px-4 py-3 text-center text-sm text-black/54">
          <span>{blockedByMe ? t('chat.blockedByMe') : t('chat.blockedByThem')}</span>
          {blockedByMe && (
            <ActionButton variant="outline" onClick={() => void handleUnblock()}>
              {t('chat.unblock')}
            </ActionButton>
          )}
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

      {pendingAudio != null && (
        <VoicePreviewBar
          blob={pendingAudio.blob}
          duration={pendingAudio.duration}
          onSend={() => {
            void sendAudio(pendingAudio.blob, pendingAudio.duration);
            setPendingAudio(null);
          }}
          onDiscard={() => setPendingAudio(null)}
        />
      )}

      <form
        onSubmit={(event) => {
          event.preventDefault();
          submitComposer();
        }}
        className="flex shrink-0 items-end gap-1 border-t border-black/12 bg-white px-2 py-1.5"
      >
        <SmileyInput
          ref={composerRef}
          value={draft}
          onChange={handleDraftChange}
          onEnter={submitComposer}
          onFocus={() => setOpenTab(null)}
          placeholder={t('chat.messageInputPlaceholder', { name })}
          multiline
          className="max-h-32 min-h-9 flex-1 overflow-y-auto bg-transparent px-2 py-1.5 text-base text-black/87"
        />
        {isTyping ? (
          <button
            type="submit"
            className="h-9 shrink-0 rounded-full bg-ola-primary px-4 text-sm font-semibold text-white shadow-sm transition active:scale-95"
          >
            {editing != null ? t('chat.actionSave') : t('chat.send')}
          </button>
        ) : (
          <button
            type="button"
            aria-label={t('chat.like')}
            {...likeLongPress}
            onPointerDown={(event) => {
              suppressLikeClick.current = false;
              likeLongPress.onPointerDown(event);
            }}
            onClick={() => {
              if (suppressLikeClick.current) {
                suppressLikeClick.current = false;
                return;
              }
              void sendText('(y)');
            }}
            className="flex h-9 w-9 select-none items-center justify-center"
          >
            <img src={likeIcon} alt="" className="h-7 w-7 object-contain" />
          </button>
        )}
      </form>

      <AttachmentBar
        openTab={openTab}
        onToggleTab={(tab) => setOpenTab((current) => (current === tab ? null : tab))}
        onPickEmoji={(emoji) => composerRef.current?.insertCode(emoji, true)}
        onBackspace={() => composerRef.current?.backspace()}
        onPickImage={() => fileInputRef.current?.click()}
        onSendKul={(index) => {
          void sendText(kulToken(index));
          setOpenTab(null);
        }}
        onSend={(payload) => {
          if (payload.kind === 'ken') {
            setOpenTab(null);
            if (peerId === '') {
              toast.error(t('chat.actionError'));
              return;
            }
            setTransferKenOpen(true);
            return;
          }
          if (payload.kind === 'vip') {
            setOpenTab(null);
            if (peerId === '') {
              toast.error(t('chat.actionError'));
              return;
            }
            setTradingVipOpen(true);
            return;
          }
          toast.info(t('chat.comingSoon'));
        }}
        onRecorded={(blob, duration) => {
          setPendingAudio({ blob, duration });
          setOpenTab(null);
        }}
      />

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        multiple
        className="hidden"
        onChange={handleFileChange}
      />
       </>
      )}

      {actionTarget != null && (
        <MessageActionSheet
          actions={messageSheetActions(actionTarget.message)}
          anchor={actionTarget.anchor}
          showReactions={actionTarget.message.direction !== 'out'}
          onReact={(type) => void reactToMessage(actionTarget.message.id, type)}
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
        onConfirm={() => void handleBlock()}
        onCancel={() => setBlockOpen(false)}
      />

      {transferKenOpen && peerId !== '' && (
        <TransferKenDialog
          open
          onClose={() => setTransferKenOpen(false)}
          receiver={{
            id: peerId,
            name,
            username,
            avatar: peerProfile?.avatar ?? avatar,
            color,
          }}
        />
      )}

      {tradingVipOpen && (
        <TradingVipDialog
          open
          onClose={() => setTradingVipOpen(false)}
          receiver={{ id: peerId, name, username, avatar: peerProfile?.avatar ?? avatar, color }}
        />
      )}

      {profileTarget != null && (
        <UserProfileView
          key={profileTarget.username}
          username={profileTarget.username}
          color={profileTarget.color}
          onClose={() => setProfileTarget(null)}
          onOpenFriend={(friend) => setProfileTarget({ username: friend.name, color: friend.color })}
        />
      )}

    </FullScreenOverlay>
  );
}

import { Fragment, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActionButton,
  AttachmentBar,
  type AttachPanelTab,
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
import { MESSAGE_TYPE } from '@constants';
import {
  BUBBLE_WALLPAPER,
  chatFriendActionLabel,
  colorForName,
  compressImageForUpload,
  formatLastActive,
  ImageTooLargeError,
  isSameDay,
  kulToken,
  parseMessageMetadata,
  SmileyText,
  toast,
} from '@lib';
import moreIcon from '@/assets/icons/chat/ic_more_white.png';
import likeIcon from '@/assets/icons/chat/smiley_35.png';
import replyActionIcon from '@/assets/icons/me/ic_action_reply_gray.png';
import editActionIcon from '@/assets/icons/me/ic_action_edit.png';
import copyActionIcon from '@/assets/icons/chat/ic_menu_copy.svg';
import deleteActionIcon from '@/assets/icons/chat/ic_menu_delete.png';
import { useChatStore } from '@/store/chat/chatStore';
import { useAuthStore } from '@/store/authStore';
import type { RelationshipStatus } from '@app-types';
import type { ChatMessage } from '../interface';
import { chatMessageAbilities, chatQuoteExcerpt, toBubble } from '../chatView';
import { usePeerCard } from '../usePeerCard';
import { useLongPress, useOutsideClick, useStickyScroll } from '@hooks';
import { ChatReactionBalloons } from './ChatReactionBalloons';
import { MessageRow } from './MessageRow';
import { TransferKenDialog } from './TransferKenDialog';
import { TradingVipDialog } from './TradingVipDialog';
import { TransferVipDaysDialog } from './TransferVipDaysDialog';
import { VoicePreviewBar } from '@components/chat/voice/VoicePreviewBar';
import {
  VoiceRecorderControl,
  type VoiceRecorderControlHandle,
} from '@components/chat/voice/VoiceRecorderControl';
import { ChatCallButtons } from '@/pages/call/ChatCallButtons';
import { PeerProfileCard } from './PeerProfileCard';
import { UserProfileView } from '../../profile/UserProfileView';
import { useMediaViewerStore } from '@/store/mediaViewerStore';
import { RELATIONSHIP_STATUS } from '@ola/shared/constants';

const HIGHLIGHT_DURATION_MS = 1500;

interface PendingImage {
  id: string;
  file: File;
  url: string;
}

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
  const { t, i18n } = useTranslation();
  const blockedByMe = blockStatus === RELATIONSHIP_STATUS.blockedByMe;
  const blockedByThem = blockStatus === RELATIONSHIP_STATUS.blockedByThem;
  const blocked = blockedByMe || blockedByThem;
  const canCall = blockStatus === RELATIONSHIP_STATUS.friend;

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
  const replyTarget = useChatStore((s) => s.replyTarget);
  const setReplyTarget = useChatStore((s) => s.setReplyTarget);
  const clearReplyTarget = useChatStore((s) => s.clearReplyTarget);
  const blockPeer = useChatStore((s) => s.blockPeer);
  const unblockPeer = useChatStore((s) => s.unblockPeer);
  const friendAction = useChatStore((s) => s.friendAction);
  const peerProfile = useChatStore((s) => s.peerProfile);
  const peerCardRoll = useChatStore((s) => s.peerCardRoll);
  const notifyTyping = useChatStore((s) => s.notifyTyping);
  const loadMoreMessages = useChatStore((s) => s.loadMoreMessages);
  const currentConversationId = useChatStore((s) => s.currentConversationId);
  const draftRecipientId = useChatStore((s) => s.draftRecipient?.id ?? '');
  const conversationSeen = useChatStore((s) => {
    const conversation = s.conversations.find(
      (item) => item.id === s.currentConversationId
    );
    if (conversation == null) return false;
    if (!conversation.isLastMessageFromMe) return true;
    return conversation.seen;
  });

  const [draft, setDraft] = useState('');
  const [menuOpen, setMenuOpen] = useState(false);
  const [blockOpen, setBlockOpen] = useState(false);
  const [openTab, setOpenTab] = useState<AttachPanelTab | null>(null);
  const [transferKenOpen, setTransferKenOpen] = useState(false);
  const [tradingVipOpen, setTradingVipOpen] = useState(false);
  const [transferVipDaysOpen, setTransferVipDaysOpen] = useState(false);
  const [pendingAudio, setPendingAudio] = useState<{
    blob: Blob;
    duration: number;
    waveform: number[];
  } | null>(null);
  const [voiceRecording, setVoiceRecording] = useState(false);
  const [pendingImage, setPendingImage] = useState<PendingImage | null>(null);
  const [actionTarget, setActionTarget] = useState<{
    message: ChatMessage;
    anchor: DOMRect | null;
  } | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<ChatMessage | null>(null);
  const [editing, setEditing] = useState<{ id: string } | null>(null);
  const [highlightedId, setHighlightedId] = useState<string | null>(null);
  const highlightTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const openViewer = useMediaViewerStore((s) => s.openViewer);
  const [profileTarget, setProfileTarget] = useState<{
    username: string;
    color: string;
  } | null>(null);
  const [now, setNow] = useState<number | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const composerAreaRef = useRef<HTMLDivElement>(null);
  const composerRef = useRef<SmileyInputHandle>(null);
  const voiceRecorderRef = useRef<VoiceRecorderControlHandle>(null);
  const suppressLikeClick = useRef(false);
  const imageIdRef = useRef(0);
  const pendingImageRef = useRef(pendingImage);
  const likeLongPress = useLongPress(() => {
    suppressLikeClick.current = true;
    void sendText('(Y)');
  });

  useOutsideClick(composerAreaRef, openTab != null, () => setOpenTab(null));

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

  useEffect(() => {
    pendingImageRef.current = pendingImage;
  }, [pendingImage]);
  useEffect(
    () => () => {
      if (pendingImageRef.current != null)
        URL.revokeObjectURL(pendingImageRef.current.url);
    },
    []
  );

  const lastActiveTime =
    now != null && !online && !peerTyping
      ? formatLastActive(i18n.language, lastActiveAt, now)
      : undefined;
  const lastActiveText =
    lastActiveTime == null
      ? undefined
      : t('chat.statusLastActive', { time: lastActiveTime });

  const peerId = peerProfile?.id ?? '';

  const bubbles = useMemo<ChatMessage[]>(
    () => messages.map((message) => toBubble(message, myId)),
    [messages, myId]
  );

  const { scrollRef, handleScroll, pin, unpin, scrollToBottomIfPinned } =
    useStickyScroll({
      count: bubbles.length,
      lastId: bubbles[bubbles.length - 1]?.id ?? null,
      hasMore,
      loadingMore,
      onLoadMore: loadMoreMessages,
      loadMoreAtTop: 0,
    });

  const {
    anchorId: peerCardAnchorId,
    visible: peerCardVisible,
    hide: hidePeerCardNow,
  } = usePeerCard({
    peerId,
    hasProfile: peerProfile != null,
    blocked,
    blockStatus,
    hasMore,
    messageCount: messages.length,
    messagesReady: !loadingMessages,
    peerCardRoll,
    lastMessageId: bubbles.at(-1)?.id,
  });

  const lastOwnId = useMemo(() => {
    for (let index = bubbles.length - 1; index >= 0; index -= 1) {
      if (bubbles[index]!.direction === 'out') return bubbles[index]!.id;
    }
    return null;
  }, [bubbles]);

  const [activeConversationId, setActiveConversationId] = useState(
    currentConversationId
  );
  if (activeConversationId !== currentConversationId) {
    setActiveConversationId(currentConversationId);
    setPendingAudio(null);
    setVoiceRecording(false);
    setOpenTab(null);
    setEditing(null);
    setHighlightedId(null);
    setDraft('');
  }

  useEffect(() => {
    return () => {
      if (highlightTimerRef.current != null)
        clearTimeout(highlightTimerRef.current);
    };
  }, []);

  useEffect(() => {
    if (replyTarget != null) composerRef.current?.focus();
  }, [replyTarget]);

  useEffect(() => {
    pin();
  }, [currentConversationId, pin]);

  useEffect(() => {
    scrollToBottomIfPinned();
  }, [peerTyping, openTab, peerCardVisible, scrollToBottomIfPinned]);

  function submitComposer() {
    if (pendingImage != null) {
      void sendPendingImage();
      return;
    }
    const trimmed = draft.trim();
    if (trimmed === '') return;
    if (editing != null) {
      void editMessage(editing.id, trimmed);
      setEditing(null);
    } else {
      void sendText(trimmed);
    }
    setDraft('');
    composerRef.current?.reset();
  }

  function sendPendingAudio() {
    if (pendingAudio == null) return;
    const audio = pendingAudio;
    const sourceConversationId = useChatStore.getState().currentConversationId;
    setPendingAudio(null);
    void sendAudio(audio.blob, audio.duration, audio.waveform).catch(() => {
      if (
        useChatStore.getState().currentConversationId === sourceConversationId
      ) {
        setPendingAudio((current) => current ?? audio);
      }
    });
  }

  function handleDraftChange(value: string) {
    setDraft(value);
    if (editing == null) notifyTyping();
  }

  function startEdit(message: ChatMessage) {
    setEditing({ id: message.id });
    setDraft(message.text ?? '');
    setOpenTab(null);
    clearReplyTarget();
  }

  function startReply(message: ChatMessage) {
    const target = messages.find((item) => item.id === message.id);
    if (target == null) return;
    setEditing(null);
    setReplyTarget(target);
  }

  function scrollToMessage(id: string) {
    const element = scrollRef.current?.querySelector(
      `[data-message-id="${CSS.escape(id)}"]`
    );
    if (element == null) {
      toast.error(t('chat.replyNotFound'));
      return;
    }
    unpin();
    element.scrollIntoView({ behavior: 'smooth', block: 'center' });
    setHighlightedId(id);
    if (highlightTimerRef.current != null)
      clearTimeout(highlightTimerRef.current);
    highlightTimerRef.current = setTimeout(
      () => setHighlightedId(null),
      HIGHLIGHT_DURATION_MS
    );
  }

  async function copyMessage(text: string) {
    try {
      await navigator.clipboard.writeText(text);
      toast.success(t('chat.copied'));
    } catch {
      toast.error(t('common.error'));
    }
  }

  function messageSheetActions(message: ChatMessage): MessageSheetAction[] {
    const abilities = chatMessageAbilities(message, blocked);
    const actions: MessageSheetAction[] = [];
    if (abilities.canReply) {
      actions.push({
        key: 'reply',
        label: t('chat.actionReply'),
        icon: replyActionIcon,
        onSelect: () => startReply(message),
      });
    }
    if (abilities.canCopy) {
      actions.push({
        key: 'copy',
        label: t('chat.actionCopy'),
        icon: copyActionIcon,
        onSelect: () => void copyMessage(message.text ?? ''),
      });
    }
    if (abilities.canEdit) {
      actions.push({
        key: 'edit',
        label: t('chat.actionEdit'),
        icon: editActionIcon,
        onSelect: () => startEdit(message),
      });
    }
    if (abilities.canDelete) {
      actions.push({
        key: 'delete',
        label: t('chat.actionDelete'),
        icon: deleteActionIcon,
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

  async function addImageFile(files: File[]) {
    const file = files[0];
    if (file == null) return;
    setOpenTab(null);
    setEditing(null);
    setDraft('');
    composerRef.current?.reset();
    try {
      const prepared = await compressImageForUpload(file);
      const url = URL.createObjectURL(prepared);
      imageIdRef.current += 1;
      const id = String(imageIdRef.current);
      setPendingImage((current) => {
        if (current != null) URL.revokeObjectURL(current.url);
        return { id, file: prepared, url };
      });
    } catch (error) {
      toast.error(
        error instanceof ImageTooLargeError
          ? t('chat.imageTooLarge')
          : t('chat.imageError')
      );
    }
  }

  function clearPendingImage() {
    setPendingImage((current) => {
      if (current != null) URL.revokeObjectURL(current.url);
      return null;
    });
  }

  async function sendPendingImage() {
    const image = pendingImage;
    if (image == null) return;
    setPendingImage(null);
    setOpenTab(null);
    await sendImage(image.file);
    URL.revokeObjectURL(image.url);
  }

  async function handleFileChange(event: React.ChangeEvent<HTMLInputElement>) {
    const files = Array.from(event.target.files ?? []);
    event.target.value = '';
    await addImageFile(files);
  }

  const isTyping = draft.trim() !== '';

  const canViewProfile = username != null && username !== '';

  function openPeerProfile() {
    if (username != null && username !== '')
      setProfileTarget({ username, color });
  }

  function openMentionProfile(nick: string) {
    if (nick !== '')
      setProfileTarget({ username: nick, color: colorForName(nick) });
  }

  function showPeerAvatar() {
    const url = peerProfile?.avatar ?? avatar ?? '';
    if (url !== '') openViewer([url]);
  }

  async function handleBlock() {
    setBlockOpen(false);
    const ok = await blockPeer();
    toast[ok ? 'success' : 'error'](
      ok ? t('chat.blockDone', { name }) : t('chat.actionError')
    );
  }

  async function handleUnblock() {
    const ok = await unblockPeer();
    toast[ok ? 'success' : 'error'](
      ok ? t('chat.unblockDone', { name }) : t('chat.actionError')
    );
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

  const friendLabel = chatFriendActionLabel(t, blockStatus);

  const menuOptions: ListOption[] = [
    {
      key: 'make-friend',
      label: friendLabel,
      onSelect: () => void handleFriendAction(),
    },
    {
      key: 'view-me',
      label: t('chat.menuViewMe'),
      onSelect: () =>
        canViewProfile ? openPeerProfile() : toast.info(t('chat.comingSoon')),
    },
    blockedByMe
      ? {
          key: 'unblock',
          label: t('chat.menuUnblock'),
          onSelect: () => void handleUnblock(),
        }
      : {
          key: 'block',
          label: t('chat.menuBlock'),
          danger: true,
          onSelect: () => setBlockOpen(true),
        },
    {
      key: 'chat-group',
      label: t('chat.menuChatGroup'),
      onSelect: () => toast.info(t('chat.comingSoon')),
    },
  ];

  const peerCardEl =
    peerCardVisible && peerProfile != null ? (
      <PeerProfileCard
        profile={peerProfile}
        name={name}
        color={color}
        avatar={avatar}
        onHide={hidePeerCardNow}
        onBlock={() => setBlockOpen(true)}
        friendLabel={friendLabel}
        onFriendAction={() => void handleFriendAction()}
        onShowAvatar={showPeerAvatar}
      />
    ) : null;

  return (
    <FullScreenOverlay z={50}>
      <ChatReactionBalloons />
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
        {canCall && <ChatCallButtons />}
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
        className={`flex flex-1 flex-col gap-0.5 overflow-x-hidden overflow-y-auto px-2 py-3 ${BUBBLE_WALLPAPER}`}
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
            {peerCardAnchorId === '' && peerCardEl}
            {bubbles.map((message, index) => {
              const prev = bubbles[index - 1];
              const showDate =
                !!message.createdAt &&
                !isSameDay(prev?.createdAt ?? '', message.createdAt);
              return (
                <Fragment key={message.key}>
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
                    highlighted={message.id === highlightedId}
                    onOpenActions={(message, anchor) =>
                      setActionTarget({ message, anchor })
                    }
                    onOpenProfile={canViewProfile ? openPeerProfile : undefined}
                    onMention={openMentionProfile}
                    onQuoteClick={scrollToMessage}
                    onOpenImage={(img) => openViewer([img])}
                    onResend={resendMessage}
                  />
                  {message.id === peerCardAnchorId && peerCardEl}
                </Fragment>
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
          </>
        )}
      </div>

      {blocked ? (
        <div className="flex shrink-0 items-center justify-center gap-3 border-t border-black/12 bg-white px-4 py-3 text-center text-sm text-black/54">
          <span>
            {blockedByMe ? t('chat.blockedByMe') : t('chat.blockedByThem')}
          </span>
          {blockedByMe && (
            <ActionButton
              variant="outline"
              onClick={() => void handleUnblock()}
            >
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

          {editing == null && replyTarget != null && (
            <div className="flex shrink-0 items-center gap-2 border-t border-black/12 bg-black/3 px-3 py-1.5">
              <span className="h-8 w-0.5 shrink-0 rounded bg-ola-primary" />
              {replyTarget.type === MESSAGE_TYPE.image &&
                (parseMessageMetadata(replyTarget.metadata).url ?? '') !==
                  '' && (
                  <img
                    src={parseMessageMetadata(replyTarget.metadata).url}
                    alt=""
                    className="h-8 w-8 shrink-0 rounded object-cover"
                  />
                )}
              <span className="min-w-0 flex-1">
                <span className="block truncate text-xs font-semibold text-ola-primary">
                  {t('chat.replyingTo', { name: replyTarget.senderName ?? '' })}
                </span>
                <span className="block truncate text-xs text-black/54">
                  <SmileyText
                    text={chatQuoteExcerpt(t, {
                      type: replyTarget.type,
                      excerpt: replyTarget.content,
                    })}
                  />
                </span>
              </span>
              <button
                type="button"
                aria-label={t('dialog.cancel')}
                onClick={clearReplyTarget}
                className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full text-lg text-black/54 hover:bg-black/5"
              >
                ×
              </button>
            </div>
          )}

          <div ref={composerAreaRef} className="shrink-0">
            <form
              onSubmit={(event) => {
                event.preventDefault();
                submitComposer();
              }}
              className="relative flex min-h-12 shrink-0 items-end gap-1 border-t border-black/12 bg-white px-2 py-1.5"
            >
              {pendingAudio != null ? (
                <VoicePreviewBar
                  blob={pendingAudio.blob}
                  duration={pendingAudio.duration}
                  waveform={pendingAudio.waveform}
                  onSend={sendPendingAudio}
                  onDiscard={() => setPendingAudio(null)}
                />
              ) : pendingImage != null ? (
                <div className="flex min-h-9 flex-1 items-center py-1">
                  <div className="relative shrink-0">
                    <img
                      src={pendingImage.url}
                      alt=""
                      className="h-11 w-11 rounded-lg object-cover"
                    />
                    <button
                      type="button"
                      aria-label={t('dialog.cancel')}
                      onClick={clearPendingImage}
                      className="absolute -top-1.5 -right-1.5 flex h-5 w-5 items-center justify-center rounded-full bg-black/60 text-xs leading-none text-white"
                    >
                      ×
                    </button>
                  </div>
                </div>
              ) : (
                <SmileyInput
                  ref={composerRef}
                  value={draft}
                  onChange={handleDraftChange}
                  onEnter={submitComposer}
                  onFocus={() => setOpenTab(null)}
                  onImagePaste={(files) => void addImageFile(files)}
                  placeholder={t('chat.messageInputPlaceholder', { name })}
                  multiline
                  className="max-h-32 min-h-9 flex-1 overflow-y-auto bg-transparent px-2 py-1.5 text-base text-black/87"
                />
              )}
              {pendingAudio == null && (
                <VoiceRecorderControl
                  ref={voiceRecorderRef}
                  key={currentConversationId ?? draftRecipientId}
                  onRecorded={({ blob, duration, waveform }) => {
                    setPendingAudio({ blob, duration, waveform });
                    setVoiceRecording(false);
                    setOpenTab(null);
                  }}
                  onRecordingChange={(recording) => {
                    setVoiceRecording(recording);
                    if (recording) setOpenTab(null);
                  }}
                />
              )}
              {pendingAudio == null &&
                !voiceRecording &&
                (isTyping || pendingImage != null ? (
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
                    <img
                      src={likeIcon}
                      alt=""
                      className="h-7 w-7 object-contain"
                    />
                  </button>
                ))}
            </form>

            {!voiceRecording && pendingAudio == null && (
              <AttachmentBar
                tabs={['smiley', 'camera', 'photo', 'voice', 'more']}
                groupSmileyTabs
                openTab={openTab}
                onToggleTab={(tab) => {
                  setOpenTab((current) => (current === tab ? null : tab));
                }}
                onStartVoice={() => {
                  setOpenTab(null);
                  voiceRecorderRef.current?.start();
                }}
                voiceDisabled={pendingImage != null}
                onPickEmoji={(emoji) =>
                  composerRef.current?.insertCode(emoji, true, false)
                }
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
                  if (payload.kind === 'vipDays') {
                    setOpenTab(null);
                    if (peerId === '') {
                      toast.error(t('chat.actionError'));
                      return;
                    }
                    setTransferVipDaysOpen(true);
                    return;
                  }
                  toast.info(t('chat.comingSoon'));
                }}
              />
            )}

            <input
              ref={fileInputRef}
              type="file"
              accept="image/*"
              className="hidden"
              onChange={handleFileChange}
            />
          </div>
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

      <ListOptionDialog
        open={menuOpen}
        title={name}
        options={menuOptions}
        onClose={() => setMenuOpen(false)}
      />
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
          receiver={{
            id: peerId,
            name,
            username,
            avatar: peerProfile?.avatar ?? avatar,
            color,
          }}
        />
      )}

      {transferVipDaysOpen && (
        <TransferVipDaysDialog
          open
          onClose={() => setTransferVipDaysOpen(false)}
          receiver={{
            id: peerId,
            name,
            username,
            avatar: peerProfile?.avatar ?? avatar,
            color,
          }}
        />
      )}

      {profileTarget != null && (
        <UserProfileView
          key={profileTarget.username}
          username={profileTarget.username}
          color={profileTarget.color}
          onClose={() => setProfileTarget(null)}
          onOpenFriend={(friend) =>
            setProfileTarget({ username: friend.name, color: friend.color })
          }
        />
      )}
    </FullScreenOverlay>
  );
}

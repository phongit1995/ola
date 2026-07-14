import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Keyboard,
  NativeScrollEvent,
  NativeSyntheticEvent,
  Pressable,
  Text,
  useWindowDimensions,
  View,
} from 'react-native';
import { KeyboardView } from '../../components/KeyboardView';
import { FlashList, type FlashListRef } from '@shopify/flash-list';
import { launchCamera, launchImageLibrary, type Asset } from 'react-native-image-picker';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { currentUserId } from '@ola/shared/stores/chat/chatHelpers';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { colorForName, createDateFormatter, createTimeFormatter, isSameDay } from '@ola/shared/lib';
import type { Message, ReactionType } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';
import { Avatar } from '../../components/Avatar';
import { ConfirmDialog } from '../../components/ConfirmDialog';
import { useMediaViewerStore } from '../../store/mediaViewerStore';
import Clipboard from '@react-native-clipboard/clipboard';
import { kulImageForText, kulToken } from '../../lib/kul';
import { ChatInputBar, type ChatInputBarHandle } from './ChatInputBar';
import { RichTextView } from '../../components/RichTextView';
import { useBottomBarInset } from '../../hooks/useBottomBarInset';
import { useFocusPresence } from '../../hooks/usePresence';
import { ListOptionDialog, type ListOption } from '../../components/ListOptionDialog';
import { RoomReactionsDialog } from '../room/RoomReactionsDialog';
import { ChatBubble, ChatMessageRow } from './ChatMessageRow';
import { AttachmentBar, type AttachTab } from './AttachmentBar';
import { VoicePreviewBar } from './VoicePreviewBar';
import type { VoiceRecording } from '../../hooks/useVoiceRecorder';
import { TransferKenDialog } from '../ken/TransferKenDialog';
import { TradingVipDialog } from './TradingVipDialog';
import { TransferVipDaysDialog } from './TransferVipDaysDialog';
import { formatLastActive } from './contacts';
import { PeerProfileCard } from './PeerProfileCard';
import { usePeerCard } from './usePeerCard';
import { MessageActionSheet, type AnchorRect, type MessageSheetAction } from '../room/MessageActionSheet';

const backIcon = require('../../assets/icons/ic_back.png');
const moreIcon = require('../../assets/icons/chat/ic_more_white.png');
const deleteActionIcon = require('../../assets/icons/chat/ic_menu_delete.png');
const editActionIcon = require('../../assets/icons/chat/ic_action_edit.png');
const copyActionIcon = require('../../assets/icons/chat/ic_menu_copy.png');
const replyActionIcon = require('../../assets/icons/me/ic_action_reply_gray.png');

const CHAT_BG = '#ECE5DD';
const DIVIDER = 'rgba(0,0,0,0.12)';
const MAX_UPLOAD_BYTES = 2 * 1024 * 1024;

type Props = NativeStackScreenProps<RootStackParamList, 'ChatDetail'>;

export function ChatDetailScreen({ navigation, route }: Props) {
  const { conversationId } = route.params;
  const { t, i18n } = useTranslation();
  const insets = useSafeAreaInsets();
  const bottomBarInset = useBottomBarInset();
  const { width: windowWidth } = useWindowDimensions();

  const conversations = useChatStore((s) => s.conversations);
  const messages = useChatStore((s) => s.messages);
  const loadingMessages = useChatStore((s) => s.loadingMessages);
  const hasMore = useChatStore((s) => s.hasMore);
  const typingUsers = useChatStore((s) => s.typingUsers);
  const openConversation = useChatStore((s) => s.openConversation);
  const closeConversation = useChatStore((s) => s.closeConversation);
  const loadMoreMessages = useChatStore((s) => s.loadMoreMessages);
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
  const peerRelationship = useChatStore((s) => s.peerRelationship);
  const peerCardRoll = useChatStore((s) => s.peerCardRoll);
  const notifyTyping = useChatStore((s) => s.notifyTyping);
  const push = useToastStore((s) => s.push);
  const openViewer = useMediaViewerStore((s) => s.openViewer);

  const [openTab, setOpenTab] = useState<AttachTab | null>(null);
  const [transferKenOpen, setTransferKenOpen] = useState(false);
  const [transferVipDaysOpen, setTransferVipDaysOpen] = useState(false);
  const [tradingVipOpen, setTradingVipOpen] = useState(false);
  const [pendingAudio, setPendingAudio] = useState<VoiceRecording | null>(null);
  const [editing, setEditing] = useState<string | null>(null);
  const [menuOpen, setMenuOpen] = useState(false);
  const [blockOpen, setBlockOpen] = useState(false);
  const [deleteTarget, setDeleteTarget] = useState<Message | null>(null);
  const [actionTarget, setActionTarget] = useState<{
    message: Message;
    anchor: AnchorRect;
    fromMe: boolean;
    firstInGroup: boolean;
    lastInGroup: boolean;
  } | null>(null);
  const [reactionsTargetId, setReactionsTargetId] = useState<string | null>(null);
  const listRef = useRef<FlashListRef<Message>>(null);
  const stickToBottomRef = useRef(true);
  const sheetOpenRef = useRef(false);
  const composerRef = useRef<ChatInputBarHandle>(null);

  useEffect(() => {
    if (conversationId != null) void openConversation(conversationId);
    return () => closeConversation();
  }, [conversationId, openConversation, closeConversation]);

  const currentConversationId = useChatStore((s) => s.currentConversationId);
  const draftRecipient = useChatStore((s) => s.draftRecipient);
  const activeConversationId = conversationId ?? currentConversationId ?? null;
  const conversation = conversations.find((item) => item.id === activeConversationId);
  const title =
    conversation?.otherUser?.fullName ??
    conversation?.otherUser?.username ??
    conversation?.name ??
    draftRecipient?.name ??
    peerProfile?.fullName ??
    peerProfile?.username ??
    '';
  const peerAvatar = conversation?.otherUser?.avatar ?? draftRecipient?.avatar ?? peerProfile?.avatar;
  const myId = currentUserId();
  const timeFormatter = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const dateFormatter = useMemo(() => createDateFormatter(i18n.language), [i18n.language]);

  const peerId = peerProfile?.id ?? '';
  const livePresence = useFocusPresence(peerId !== '' ? peerId : null);
  const peerOnline =
    (livePresence?.isOnline ?? peerProfile?.isOnline ?? conversation?.otherUser?.isOnline) === true;
  const peerLastActiveAt =
    livePresence?.lastActiveAt ?? peerProfile?.lastActiveAt ?? conversation?.otherUser?.lastActiveAt;
  const [now, setNow] = useState(() => Date.now());

  useEffect(() => {
    const interval = setInterval(() => setNow(Date.now()), 60_000);
    return () => clearInterval(interval);
  }, []);

  const subtitle =
    typingUsers.length > 0
      ? t('chat.typing', { name: typingUsers[0]?.username ?? '' })
      : peerOnline
        ? t('chat.statusActive')
        : formatLastActive(t, peerLastActiveAt, now) ?? '';

  const conversationSeen =
    conversation == null ? false : !conversation.isLastMessageFromMe ? true : conversation.seen;

  const blockStatus = peerRelationship?.status ?? null;
  const blockedByMe = blockStatus === 'blocked_by_me';
  const blockedByThem = blockStatus === 'blocked_by_them';
  const blocked = blockedByMe || blockedByThem;

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
    lastMessageId: messages[messages.length - 1]?.id,
  });

  const lastOwnId = useMemo(() => {
    for (let i = messages.length - 1; i >= 0; i -= 1) {
      if (messages[i]!.senderId === myId) return messages[i]!.id;
    }
    return null;
  }, [messages, myId]);

  const forceScrollRef = useRef(false);

  const repinOnResize = useCallback(() => {
    if (stickToBottomRef.current && !sheetOpenRef.current) {
      requestAnimationFrame(() => listRef.current?.scrollToEnd({ animated: false }));
    }
  }, []);

  const scrollOnContentChange = useCallback(() => {
    if (!forceScrollRef.current) return;
    forceScrollRef.current = false;
    requestAnimationFrame(() => listRef.current?.scrollToEnd({ animated: false }));
  }, []);

  const closeAttachTab = useCallback(() => setOpenTab(null), []);

  function handleScroll(event: NativeSyntheticEvent<NativeScrollEvent>) {
    const { contentOffset, contentSize, layoutMeasurement } = event.nativeEvent;
    stickToBottomRef.current = contentSize.height - contentOffset.y - layoutMeasurement.height < 80;
    if (contentOffset.y < 80 && hasMore) void loadMoreMessages();
  }

  async function send(text: string) {
    const trimmed = text.trim();
    if (trimmed === '') return;
    if (editing != null) {
      const id = editing;
      setEditing(null);
      await editMessage(id, trimmed);
      return;
    }
    forceScrollRef.current = !stickToBottomRef.current;
    stickToBottomRef.current = true;
    await sendText(trimmed);
  }

  const openPeerProfile = () => {
    const peer = conversation?.otherUser;
    const identifier = peer?.id ?? peer?.username;
    if (identifier != null && identifier !== '') {
      navigation.navigate(ROOT_ROUTES.ProfileView, { userId: identifier });
    }
  };

  function showPeerAvatar() {
    const url = peerProfile?.avatar ?? peerAvatar ?? '';
    if (url !== '') openViewer([url]);
  }

  function startEdit(message: Message) {
    const content = message.content ?? '';
    setEditing(message.id);
    composerRef.current?.setText(content);
    setOpenTab(null);
    requestAnimationFrame(() => composerRef.current?.focus());
  }

  function cancelEdit() {
    setEditing(null);
    composerRef.current?.clear();
  }

  async function sendPickedAssets(assets: Asset[]) {
    for (const asset of assets) {
      if (asset.uri == null) continue;
      if ((asset.fileSize ?? 0) > MAX_UPLOAD_BYTES) {
        push('error', t('chat.imageTooLarge'));
        continue;
      }
      try {
        await sendImage({ uri: asset.uri, name: asset.fileName ?? 'photo.jpg', type: asset.type ?? 'image/jpeg' });
      } catch {
        push('error', t('chat.imageError'));
      }
    }
  }

  async function pickAndSendImages() {
    const result = await launchImageLibrary({
      mediaType: 'photo',
      selectionLimit: 0,
      maxWidth: 1920,
      maxHeight: 1920,
      quality: 0.9,
    });
    if (result.didCancel) return;
    setOpenTab(null);
    await sendPickedAssets(result.assets ?? []);
  }

  async function captureAndSendPhoto() {
    const result = await launchCamera({
      mediaType: 'photo',
      maxWidth: 1920,
      maxHeight: 1920,
      quality: 0.9,
      saveToPhotos: false,
    });
    if (result.didCancel) return;
    if (result.errorCode != null) {
      push('error', t('chat.imageError'));
      return;
    }
    setOpenTab(null);
    await sendPickedAssets(result.assets ?? []);
  }

  async function handleFriendAction() {
    if (blocked) {
      push('info', t('chat.makeFriendBlocked'));
      return;
    }
    const result = await friendAction();
    if (result === 'error') {
      push('error', t('chat.actionError'));
      return;
    }
    if (result === 'request') push('success', t('chat.friendRequestSent'));
    else if (result === 'cancel') push('success', t('chat.requestCancelled'));
    else if (result === 'accept') push('success', t('chat.friendAccepted'));
    else if (result === 'unfriend') push('success', t('chat.unfriendDone'));
  }

  async function handleBlock() {
    setBlockOpen(false);
    const ok = await blockPeer();
    push(ok ? 'success' : 'error', ok ? t('chat.blockDone', { name: title }) : t('chat.actionError'));
  }

  async function handleUnblock() {
    const ok = await unblockPeer();
    push(ok ? 'success' : 'error', ok ? t('chat.unblockDone', { name: title }) : t('chat.actionError'));
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
    { key: 'view-me', label: t('chat.menuViewMe'), onSelect: openPeerProfile },
    blockedByMe
      ? { key: 'unblock', label: t('chat.menuUnblock'), onSelect: () => void handleUnblock() }
      : { key: 'block', label: t('chat.menuBlock'), danger: true, onSelect: () => setBlockOpen(true) },
    { key: 'chat-group', label: t('chat.menuChatGroup'), onSelect: () => push('info', t('chat.comingSoon')) },
  ];

  const myName = useAuthStore((s) => s.user?.username) ?? '';
  const reactionsTarget =
    reactionsTargetId != null
      ? messages.find((item) => item.id === reactionsTargetId)
      : undefined;
  const reactionsForDialog =
    reactionsTarget?.reactions != null
      ? Object.fromEntries(
          Object.entries(reactionsTarget.reactions).map(([type, userIds]) => [
            type,
            userIds.map((userId) => ({
              userId,
              username: userId === myId ? myName : title,
            })),
          ])
        )
      : undefined;

  function scrollToMessage(id: string) {
    const index = messages.findIndex((m) => m.id === id);
    if (index < 0) {
      push('error', t('chat.replyNotFound'));
      return;
    }
    listRef.current?.scrollToIndex({ index, animated: true, viewPosition: 0.5 });
  }

  function startReply(message: Message) {
    setEditing(null);
    setReplyTarget(message);
    requestAnimationFrame(() => composerRef.current?.focus());
  }

  function copyMessage(content: string) {
    Clipboard.setString(content);
    push('success', t('chat.copied'));
  }

  function isCopyableText(message: Message): boolean {
    return (
      message.type === 'text' &&
      message.content.trim() !== '' &&
      kulImageForText(message.content) == null
    );
  }

  function replyExcerpt(message: Message): string {
    if (message.type === 'image') return t('chat.replyImage');
    if (message.type === 'audio') return t('chat.replyAudio');
    return kulImageForText(message.content) != null ? t('chat.replySticker') : message.content;
  }

  function sheetActions(message: Message): MessageSheetAction[] {
    const isOwn = message.senderId === myId;
    const actions: MessageSheetAction[] = [];
    if (!isOwn) {
      actions.push({
        key: 'reply',
        label: t('chat.actionReply'),
        icon: replyActionIcon,
        onSelect: () => startReply(message),
      });
    }
    if (isCopyableText(message)) {
      actions.push({
        key: 'copy',
        label: t('chat.actionCopy'),
        icon: copyActionIcon,
        iconTint: '#595959',
        onSelect: () => copyMessage(message.content),
      });
    }
    if (isOwn && message.type === 'text') {
      actions.push({
        key: 'edit',
        label: t('chat.actionEdit'),
        icon: editActionIcon,
        iconTint: '#b5b5b5',
        onSelect: () => startEdit(message),
      });
    }
    if (isOwn) {
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

  return (
    <KeyboardView
      className="flex-1"
      style={{ backgroundColor: CHAT_BG }}
    >
      <View className="bg-ola-primary px-2 pb-2" style={{ paddingTop: insets.top + 8 }}>
        <View className="h-9 flex-row items-center gap-2">
          <Pressable
            className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
            onPress={() => navigation.goBack()}
          >
            <Image source={backIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
          </Pressable>
          <Pressable onPress={showPeerAvatar}>
            <Avatar name={title} uri={peerAvatar} size={32} />
          </Pressable>
          <Pressable className="flex-1 flex-row items-center gap-2" onPress={openPeerProfile}>
            <View className="flex-1">
              <Text className="text-sm font-bold text-white" numberOfLines={1}>
                {title}
              </Text>
              {subtitle !== '' && (
                <Text className="text-xs text-white/70" numberOfLines={1}>
                  {subtitle}
                </Text>
              )}
            </View>
          </Pressable>
          <Pressable className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15" onPress={() => setMenuOpen(true)}>
            <Image source={moreIcon} style={{ width: 20, height: 20, tintColor: '#fff' }} resizeMode="contain" />
          </Pressable>
        </View>
      </View>

      <View
        className="flex-1"
        onStartShouldSetResponderCapture={() => {
          if (openTab != null) setOpenTab(null);
          return false;
        }}
      >
      {loadingMessages ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : (
        <FlashList
          ref={listRef}
          data={messages}
          keyExtractor={(item) => item.clientMsgId ?? item.id}
          maintainVisibleContentPosition={{
            startRenderingFromBottom: true,
            autoscrollToBottomThreshold: 0.2,
          }}
          onScroll={handleScroll}
          scrollEventThrottle={16}
          contentContainerStyle={{ paddingVertical: 12 }}
          onContentSizeChange={scrollOnContentChange}
          onLayout={repinOnResize}
          ListHeaderComponent={
            peerCardVisible && peerCardAnchorId === '' && peerProfile != null ? (
              <PeerProfileCard
                profile={peerProfile}
                name={title}
                avatar={peerAvatar}
                friendLabel={friendLabel}
                onHide={hidePeerCardNow}
                onBlock={() => setBlockOpen(true)}
                onFriendAction={() => void handleFriendAction()}
                onShowAvatar={showPeerAvatar}
              />
            ) : null
          }
          ListFooterComponent={
            typingUsers.length > 0 ? (
              <View className="mt-1 flex-row items-end gap-1 px-3">
                <Avatar name={title} uri={peerAvatar} size={32} />
                <View
                  className="flex-row items-center gap-1 rounded-2xl rounded-tl-sm bg-white px-3 py-3"
                  style={{ shadowColor: '#000', shadowOpacity: 0.08, shadowRadius: 2, shadowOffset: { width: 0, height: 1 }, elevation: 1 }}
                >
                  <View className="h-1.5 w-1.5 rounded-full" style={{ backgroundColor: 'rgba(0,0,0,0.25)' }} />
                  <View className="h-1.5 w-1.5 rounded-full" style={{ backgroundColor: 'rgba(0,0,0,0.4)' }} />
                  <View className="h-1.5 w-1.5 rounded-full" style={{ backgroundColor: 'rgba(0,0,0,0.55)' }} />
                </View>
              </View>
            ) : null
          }
          renderItem={({ item, index }) => {
            const prev = messages[index - 1];
            const next = messages[index + 1];
            const fromMe = item.senderId === myId;
            const firstInGroup = prev == null || prev.senderId !== item.senderId;
            const lastInGroup = next == null || next.senderId !== item.senderId;
            const showTime =
              lastInGroup || timeFormatter(next!.createdAt) !== timeFormatter(item.createdAt);
            const showDate =
              item.createdAt != null &&
              (prev == null || !isSameDay(prev.createdAt, item.createdAt));
            return (
              <>
                {showDate && (
                  <View className="items-center py-1">
                    <Text
                      className="overflow-hidden rounded-full px-3 py-0.5 text-xs text-white"
                      style={{ backgroundColor: 'rgba(0,0,0,0.35)' }}
                    >
                      {dateFormatter(item.createdAt)}
                    </Text>
                  </View>
                )}
                <ChatMessageRow
                  message={item}
                  fromMe={fromMe}
                  firstInGroup={firstInGroup}
                  lastInGroup={lastInGroup}
                  showTime={showTime}
                  isLastOwn={item.id === lastOwnId}
                  seen={conversationSeen}
                  peerName={title}
                  peerAvatar={peerAvatar}
                  timeLabel={timeFormatter(item.createdAt)}
                  onLongPress={(anchor) => {
                    sheetOpenRef.current = true;
                    setActionTarget({ message: item, anchor, fromMe, firstInGroup, lastInGroup });
                  }}
                  onResend={(id) => void resendMessage(id)}
                  onOpenImage={(url) => openViewer([url])}
                  onMention={(nick) => navigation.navigate(ROOT_ROUTES.ProfileView, { userId: nick })}
                  onShowReactions={setReactionsTargetId}
                  onQuoteClick={scrollToMessage}
                />
                {peerCardVisible && item.id === peerCardAnchorId && peerProfile != null && (
                  <PeerProfileCard
                    profile={peerProfile}
                    name={title}
                    avatar={peerAvatar}
                    friendLabel={friendLabel}
                    onHide={hidePeerCardNow}
                    onBlock={() => setBlockOpen(true)}
                    onFriendAction={() => void handleFriendAction()}
                    onShowAvatar={showPeerAvatar}
                  />
                )}
              </>
            );
          }}
        />
      )}
      </View>

      {blocked ? (
        <View
          className="flex-row items-center justify-center gap-3 bg-white px-4 py-3"
          style={{ borderTopWidth: 1, borderTopColor: DIVIDER }}
        >
          <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {blockedByMe ? t('chat.blockedByMe') : t('chat.blockedByThem')}
          </Text>
          {blockedByMe && (
            <Pressable
              onPress={() => void handleUnblock()}
              className="rounded px-3 py-1.5"
              style={{ borderWidth: 1, borderColor: '#7cb342' }}
            >
              <Text className="text-sm font-medium" style={{ color: '#7cb342' }}>{t('chat.unblock')}</Text>
            </Pressable>
          )}
        </View>
      ) : (
      <>
      {editing != null && (
        <View
          className="flex-row items-center gap-2 px-3 py-1.5"
          style={{ borderTopWidth: 1, borderTopColor: DIVIDER, backgroundColor: '#f1f8e9' }}
        >
          <Text className="flex-1 text-sm" style={{ color: 'rgba(0,0,0,0.7)' }}>{t('chat.editingHint')}</Text>
          <Pressable onPress={cancelEdit} className="px-2">
            <Text className="text-base" style={{ color: 'rgba(0,0,0,0.54)' }}>✕</Text>
          </Pressable>
        </View>
      )}
      {editing == null && replyTarget != null && (
        <View
          className="flex-row items-center gap-2 bg-black/5 px-3 py-1.5"
          style={{ borderTopWidth: 1, borderTopColor: DIVIDER }}
        >
          <View className="h-8 w-0.5 rounded bg-ola-primary" />
          <View className="min-w-0 flex-1">
            <Text numberOfLines={1} className="text-xs font-semibold text-ola-primary">
              {t('chat.replyingTo', { name: replyTarget.senderName ?? title })}
            </Text>
            <RichTextView
              content={replyExcerpt(replyTarget)}
              own={false}
              color="rgba(0,0,0,0.54)"
              maxWidth={windowWidth - 70}
              fontSize={12}
              maxLines={1}
              onMention={() => undefined}
            />
          </View>
          <Pressable
            onPress={clearReplyTarget}
            className="h-7 w-7 items-center justify-center rounded-full"
          >
            <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.54)' }}>×</Text>
          </Pressable>
        </View>
      )}
      {pendingAudio != null && (
        <VoicePreviewBar
          uri={pendingAudio.file.uri}
          duration={pendingAudio.duration}
          onSend={() => {
            const audio = pendingAudio;
            setPendingAudio(null);
            setOpenTab(null);
            void sendAudio(audio.file, audio.duration).catch(() =>
              push('error', t('chat.actionError'))
            );
          }}
          onDiscard={() => setPendingAudio(null)}
        />
      )}
      <ChatInputBar
        ref={composerRef}
        hidden={pendingAudio != null}
        refocusOnSend={openTab == null}
        editing={editing != null}
        placeholder={t('chat.messageInputPlaceholder', { name: title })}
        onSend={(text) => void send(text)}
        onTyping={notifyTyping}
        onFocusInput={closeAttachTab}
      />

      <AttachmentBar
        openTab={openTab}
        bottomInset={bottomBarInset}
        onToggleTab={(tab) => {
          if (openTab !== tab) Keyboard.dismiss();
          setOpenTab(openTab === tab ? null : tab);
        }}
        onPickEmoji={(code) => composerRef.current?.insertCode(code, true)}
        onBackspace={() => composerRef.current?.backspace()}
        onSendKul={(index) => {
          void send(kulToken(index));
          setOpenTab(null);
        }}
        onPickImage={() => void pickAndSendImages()}
        onPickCamera={() => void captureAndSendPhoto()}
        onRecorded={(recording) => {
          setOpenTab(null);
          setPendingAudio(recording);
        }}
        onTransferKen={() => {
          setOpenTab(null);
          if (peerId === '') {
            push('error', t('chat.actionError'));
            return;
          }
          setTransferKenOpen(true);
        }}
        onTradingVip={() => {
          setOpenTab(null);
          if (peerId === '') {
            push('error', t('chat.actionError'));
            return;
          }
          setTradingVipOpen(true);
        }}
        onSendVipDays={() => {
          setOpenTab(null);
          if (peerId === '') {
            push('error', t('chat.actionError'));
            return;
          }
          setTransferVipDaysOpen(true);
        }}
      />
      </>
      )}

      {transferKenOpen && peerId !== '' && (
        <TransferKenDialog
          visible
          onClose={() => setTransferKenOpen(false)}
          receiver={{
            id: peerId,
            name: title,
            username: conversation?.otherUser?.username,
            avatar: peerProfile?.avatar ?? peerAvatar,
            color: colorForName(conversation?.otherUser?.username ?? title),
          }}
        />
      )}

      {transferVipDaysOpen && peerId !== '' && (
        <TransferVipDaysDialog
          visible
          onClose={() => setTransferVipDaysOpen(false)}
          receiver={{
            id: peerId,
            name: title,
            username: conversation?.otherUser?.username,
            avatar: peerProfile?.avatar ?? peerAvatar,
          }}
        />
      )}

      {tradingVipOpen && peerId !== '' && (
        <TradingVipDialog
          visible
          onClose={() => setTradingVipOpen(false)}
          receiver={{
            id: peerId,
            name: title,
            username: conversation?.otherUser?.username,
            avatar: peerProfile?.avatar ?? peerAvatar,
          }}
        />
      )}

      <MessageActionSheet
        visible={actionTarget != null}
        anchor={actionTarget?.anchor ?? null}
        preview={
          actionTarget != null ? (
            <ChatBubble
              message={actionTarget.message}
              fromMe={actionTarget.fromMe}
              firstInGroup={actionTarget.firstInGroup}
              lastInGroup={actionTarget.lastInGroup}
              onOpenImage={() => undefined}
              onMention={() => undefined}
            />
          ) : null
        }
        actions={actionTarget != null ? sheetActions(actionTarget.message) : []}
        showReactions={actionTarget != null && actionTarget.message.senderId !== myId}
        onReact={(type: ReactionType) => {
          if (actionTarget != null) void reactToMessage(actionTarget.message.id, type);
        }}
        onClose={() => {
          sheetOpenRef.current = false;
          setActionTarget(null);
        }}
      />

      <RoomReactionsDialog
        visible={reactionsTargetId != null}
        reactions={reactionsForDialog}
        onClose={() => setReactionsTargetId(null)}
      />

      <ListOptionDialog
        visible={menuOpen}
        title={title}
        options={menuOptions}
        onClose={() => setMenuOpen(false)}
      />

      <ConfirmDialog
        visible={deleteTarget != null}
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
        visible={blockOpen}
        danger
        title={t('chat.blockTitle')}
        message={t('chat.blockMessage', { name: title })}
        confirmLabel={t('chat.block')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => void handleBlock()}
        onCancel={() => setBlockOpen(false)}
      />
    </KeyboardView>
  );
}

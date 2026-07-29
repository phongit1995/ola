import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Keyboard,
  NativeScrollEvent,
  NativeSyntheticEvent,
  Platform,
  Pressable,
  ScrollView,
  Text,
  View,
} from 'react-native';
import { ChatKeyboardArea } from '@components/ChatKeyboardArea';
import { FlashList } from '@shopify/flash-list';
import { useStickyBottomList } from '@hooks/useStickyBottomList';
import { launchCamera, launchImageLibrary, type Asset } from 'react-native-image-picker';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import {
  colorForName,
  isSameDay,
  parseMessageMetadata,
  type NativeUploadFile,
} from '@ola/shared/lib';
import type { Message, ReactionType } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { useMediaViewerStore } from '@store/mediaViewerStore';
import Clipboard from '@react-native-clipboard/clipboard';
import { kulToken } from '@lib/kul';
import { pastedImageFile } from '@lib/imagePicker';
import { compressImageForUpload, ImageTooLargeError } from '@lib/compressImage';
import {
  deleteTemporaryVoiceFile,
  deleteTemporaryVoiceFileAfterUiUpdate,
} from '@lib/temporaryVoiceFile';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { RoomReactionsDialog } from '@screens/room/components/RoomReactionsDialog';
import { MessageActionSheet, type AnchorRect, type MessageSheetAction } from '@screens/room/components/MessageActionSheet';
import { TransferKenDialog } from '@screens/ken/components/TransferKenDialog';
import type { VoiceRecording } from '@hooks/useVoiceRecorder';
import { DIVIDER } from '@constants';
import { useChatDetail } from './useChatDetail';
import { usePeerCard } from './usePeerCard';
import { chatMessageAbilities } from './chatMessageView';
import { CHAT_BG } from './constants';
import { ChatInputBar, type ChatInputBarHandle } from './components/ChatInputBar';
import { ChatBubble, ChatMessageRow } from './components/ChatMessageRow';
import { ChatReactionBalloons } from './components/ChatReactionBalloons';
import { AttachmentBar, type AttachPanelTab } from './components/AttachmentBar';
import { VoicePreviewBar } from '@components/chat/voice/VoicePreviewBar';
import {
  VoiceRecorderControl,
  type VoiceRecorderControlHandle,
} from '@components/chat/voice/VoiceRecorderControl';
import { TradingVipDialog } from './components/TradingVipDialog';
import { TransferVipDaysDialog } from './components/TransferVipDaysDialog';
import { PeerProfileCard } from './components/PeerProfileCard';
import { ChatHeader } from './components/ChatHeader';
import { TypingIndicator } from './components/TypingIndicator';
import { ReplyPreviewBar } from './components/ReplyPreviewBar';
import { EditingNotice } from './components/EditingNotice';
import { useBottomBarInset } from '@hooks/useBottomBarInset';

const deleteActionIcon = require('@assets/icons/chat/ic_menu_delete.png');
const editActionIcon = require('@assets/icons/chat/ic_action_edit.png');
const copyActionIcon = require('@assets/icons/chat/ic_menu_copy.png');
const replyActionIcon = require('@assets/icons/me/ic_action_reply_gray.png');

type Props = NativeStackScreenProps<RootStackParamList, 'ChatDetail'>;

interface PendingImage {
  id: string;
  uri: string;
  file: NativeUploadFile;
}

export function ChatDetailScreen({ navigation, route }: Props) {
  const { conversationId } = route.params;
  const { t } = useTranslation();
  const bottomBarInset = useBottomBarInset();
  const push = useToastStore((s) => s.push);
  const openViewer = useMediaViewerStore((s) => s.openViewer);
  const myName = useAuthStore((s) => s.user?.username) ?? '';

  const {
    conversation,
    title,
    peerAvatar,
    myId,
    peerId,
    peerProfile,
    peerCardRoll,
    messages,
    loadingMessages,
    hasMore,
    typingUsers,
    replyTarget,
    timeFormatter,
    dateFormatter,
    subtitle,
    conversationSeen,
    blocked,
    blockedByMe,
    blockStatus,
    friendLabel,
    lastOwnId,
    loadMoreMessages,
    sendText,
    sendImage,
    sendAudio,
    resendMessage,
    reactToMessage,
    deleteMessage,
    editMessage,
    setReplyTarget,
    clearReplyTarget,
    notifyTyping,
    handleFriendAction,
    handleBlock,
    handleUnblock,
  } = useChatDetail(conversationId);

  const [openTab, setOpenTab] = useState<AttachPanelTab | null>(null);
  const [transferKenOpen, setTransferKenOpen] = useState(false);
  const [transferVipDaysOpen, setTransferVipDaysOpen] = useState(false);
  const [tradingVipOpen, setTradingVipOpen] = useState(false);
  const [pendingAudio, setPendingAudio] = useState<VoiceRecording | null>(null);
  const pendingAudioRef = useRef<VoiceRecording | null>(null);
  const pendingAudioCleanupQueueRef = useRef<VoiceRecording[]>([]);
  const [voiceRecording, setVoiceRecording] = useState(false);
  const [pendingImages, setPendingImages] = useState<PendingImage[]>([]);
  const [editing, setEditing] = useState<string | null>(null);
  const [highlightedId, setHighlightedId] = useState<string | null>(null);
  const highlightTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const imageIdRef = useRef(0);
  const [menuOpen, setMenuOpen] = useState(false);
  const [blockOpen, setBlockOpen] = useState(false);
  const [deleteTarget, setDeleteTarget] = useState<Message | null>(null);
  const pendingDeleteTargetRef = useRef<Message | null>(null);
  const [actionTarget, setActionTarget] = useState<{
    message: Message;
    anchor: AnchorRect;
    fromMe: boolean;
    firstInGroup: boolean;
    lastInGroup: boolean;
  } | null>(null);
  const [reactionsTargetId, setReactionsTargetId] = useState<string | null>(null);
  const {
    listRef,
    suspendRef,
    onListLayout,
    onContentSizeChange,
    onScroll,
    onScrollBeginDrag,
    onScrollEndDrag,
    onMomentumScrollBegin,
    onMomentumScrollEnd,
    pinOnNextContent,
    unstick,
    isUserInteracting,
  } = useStickyBottomList<Message>();
  const composerRef = useRef<ChatInputBarHandle>(null);
  const voiceRecorderRef = useRef<VoiceRecorderControlHandle>(null);
  const currentConversationId = useChatStore((s) => s.currentConversationId);
  const loadingMore = useChatStore((s) => s.loadingMore);
  const [activeConversationId, setActiveConversationId] = useState(currentConversationId);
  if (activeConversationId !== currentConversationId) {
    if (pendingAudioRef.current != null) {
      pendingAudioCleanupQueueRef.current.push(pendingAudioRef.current);
      pendingAudioRef.current = null;
    }
    setActiveConversationId(currentConversationId);
    setPendingAudio(null);
    setVoiceRecording(false);
    setOpenTab(null);
    setEditing(null);
    setHighlightedId(null);
  }

  useEffect(() => {
    const abandoned = pendingAudioCleanupQueueRef.current;
    pendingAudioCleanupQueueRef.current = [];
    for (const audio of abandoned) {
      void deleteTemporaryVoiceFile(audio.file.uri);
    }
  }, [currentConversationId]);

  useEffect(
    () => () => {
      const owned = [
        ...(pendingAudioRef.current != null ? [pendingAudioRef.current] : []),
        ...pendingAudioCleanupQueueRef.current,
      ];
      pendingAudioRef.current = null;
      pendingAudioCleanupQueueRef.current = [];
      for (const audio of owned) {
        void deleteTemporaryVoiceFile(audio.file.uri);
      }
    },
    []
  );

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

  const closeAttachTab = useCallback(() => setOpenTab(null), []);

  function handleScroll(event: NativeSyntheticEvent<NativeScrollEvent>) {
    onScroll(event);
    if (isUserInteracting() && event.nativeEvent.contentOffset.y < 80 && hasMore) {
      void loadMoreMessages();
    }
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
    pinOnNextContent();
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

  async function compressAndSend(file: NativeUploadFile) {
    try {
      const prepared = await compressImageForUpload(file);
      await sendImage(prepared);
    } catch (err) {
      push('error', err instanceof ImageTooLargeError ? t('chat.imageTooLarge') : t('chat.imageError'));
    }
  }

  function queuePickedAssets(assets: Asset[]) {
    if (assets.length === 0) return;
    if (editing != null) cancelEdit();
    setPendingImages((current) => {
      const next = [...current];
      for (const asset of assets) {
        if (asset.uri == null) continue;
        imageIdRef.current += 1;
        next.push({
          id: String(imageIdRef.current),
          uri: asset.uri,
          file: {
            uri: asset.uri,
            name: asset.fileName ?? 'photo.jpg',
            type: asset.type ?? 'image/jpeg',
          },
        });
      }
      return next;
    });
  }

  function queuePastedImage(uri: string) {
    if (editing != null) cancelEdit();
    imageIdRef.current += 1;
    const id = String(imageIdRef.current);
    setPendingImages((current) => [...current, { id, uri, file: pastedImageFile(uri) }]);
  }

  function removePendingImage(id: string) {
    setPendingImages((current) => current.filter((image) => image.id !== id));
  }

  function clearPendingImages() {
    setPendingImages([]);
  }

  function showPendingAudio(recording: VoiceRecording) {
    pendingAudioRef.current = recording;
    setPendingAudio(recording);
  }

  function discardPendingAudio() {
    const audio = pendingAudioRef.current;
    pendingAudioRef.current = null;
    setPendingAudio(null);
    if (audio != null) {
      deleteTemporaryVoiceFileAfterUiUpdate(audio.file.uri);
    }
  }

  async function resendWithAudioCleanup(messageId: string) {
    const target = messages.find((message) => message.id === messageId);
    const previewUri =
      target?.type === 'audio'
        ? (parseMessageMetadata(target.metadata).url ?? '')
        : '';
    const sent = await resendMessage(messageId);
    if (sent && previewUri !== '') {
      deleteTemporaryVoiceFileAfterUiUpdate(previewUri);
    }
  }

  async function sendPendingImages() {
    const images = pendingImages;
    if (images.length === 0) return;
    setPendingImages([]);
    setOpenTab(null);
    pinOnNextContent();
    for (const image of images) {
      await compressAndSend(image.file);
    }
  }

  async function pickImages() {
    const keyboardWasVisible = Keyboard.isVisible();
    const result = await launchImageLibrary({
      mediaType: 'photo',
      selectionLimit: 0,
      maxWidth: 1920,
      maxHeight: 1920,
      quality: 0.9,
    });
    if (keyboardWasVisible) requestAnimationFrame(() => composerRef.current?.focus());
    if (result.didCancel) return;
    queuePickedAssets(result.assets ?? []);
  }

  async function capturePhoto() {
    const keyboardWasVisible = Keyboard.isVisible();
    const result = await launchCamera({
      mediaType: 'photo',
      maxWidth: 1920,
      maxHeight: 1920,
      quality: 0.9,
      saveToPhotos: false,
    });
    if (keyboardWasVisible) requestAnimationFrame(() => composerRef.current?.focus());
    if (result.didCancel) return;
    if (result.errorCode != null) {
      push('error', t('chat.imageError'));
      return;
    }
    queuePickedAssets(result.assets ?? []);
  }

  const menuOptions: ListOption[] = [
    { key: 'make-friend', label: friendLabel, onSelect: () => void handleFriendAction() },
    { key: 'view-me', label: t('chat.menuViewMe'), onSelect: openPeerProfile },
    blockedByMe
      ? { key: 'unblock', label: t('chat.menuUnblock'), onSelect: () => void handleUnblock() }
      : { key: 'block', label: t('chat.menuBlock'), danger: true, onSelect: () => setBlockOpen(true) },
    { key: 'chat-group', label: t('chat.menuChatGroup'), onSelect: () => push('info', t('chat.comingSoon')) },
  ];

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
    unstick();
    listRef.current?.scrollToIndex({ index, animated: true, viewPosition: 0.5 });
    setHighlightedId(id);
    if (highlightTimerRef.current != null) clearTimeout(highlightTimerRef.current);
    highlightTimerRef.current = setTimeout(() => setHighlightedId(null), 1500);
  }

  useEffect(
    () => () => {
      if (highlightTimerRef.current != null) clearTimeout(highlightTimerRef.current);
    },
    []
  );

  function startReply(message: Message) {
    setEditing(null);
    setReplyTarget(message);
    requestAnimationFrame(() => composerRef.current?.focus());
  }

  function copyMessage(content: string) {
    Clipboard.setString(content);
    push('success', t('chat.copied'));
  }

  const openPendingDeleteDialog = useCallback(() => {
    const target = pendingDeleteTargetRef.current;
    pendingDeleteTargetRef.current = null;
    if (target != null) setDeleteTarget(target);
  }, []);

  function sheetActions(message: Message): MessageSheetAction[] {
    const abilities = chatMessageAbilities(message, myId, blocked);
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
        iconTint: '#595959',
        onSelect: () => copyMessage(message.content),
      });
    }
    if (abilities.canEdit) {
      actions.push({
        key: 'edit',
        label: t('chat.actionEdit'),
        icon: editActionIcon,
        iconTint: '#b5b5b5',
        onSelect: () => startEdit(message),
      });
    }
    if (abilities.canDelete) {
      actions.push({
        key: 'delete',
        label: t('chat.actionDelete'),
        icon: deleteActionIcon,
        destructive: true,
        onSelect: () => {
          pendingDeleteTargetRef.current = message;
        },
      });
    }
    return actions;
  }

  const transferReceiver = {
    id: peerId,
    name: title,
    username: conversation?.otherUser?.username,
    avatar: peerProfile?.avatar ?? peerAvatar,
  };

  const renderPeerCard = () => (
    <PeerProfileCard
      profile={peerProfile!}
      name={title}
      avatar={peerAvatar}
      friendLabel={friendLabel}
      onHide={hidePeerCardNow}
      onBlock={() => setBlockOpen(true)}
      onFriendAction={() => void handleFriendAction()}
      onShowAvatar={showPeerAvatar}
    />
  );

  return (
    <View className="flex-1" style={{ backgroundColor: CHAT_BG }}>
      <ChatHeader
        title={title}
        subtitle={subtitle}
        avatar={peerAvatar}
        onBack={() => navigation.goBack()}
        onOpenProfile={openPeerProfile}
        onMore={() => setMenuOpen(true)}
      />

      <ChatKeyboardArea>
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
          drawDistance={1500}
          maintainVisibleContentPosition={{
            startRenderingFromBottom: true,
          }}
          onScroll={handleScroll}
          onScrollBeginDrag={onScrollBeginDrag}
          onScrollEndDrag={onScrollEndDrag}
          onMomentumScrollBegin={onMomentumScrollBegin}
          onMomentumScrollEnd={onMomentumScrollEnd}
          scrollEventThrottle={16}
          contentContainerStyle={{ paddingVertical: 12 }}
          onContentSizeChange={onContentSizeChange}
          onLayout={onListLayout}
          ListHeaderComponent={
            <>
              {loadingMore && (
                <View className="items-center py-2">
                  <ActivityIndicator size="small" color="#7cb342" />
                </View>
              )}
              {peerCardVisible && peerCardAnchorId === '' && peerProfile != null
                ? renderPeerCard()
                : null}
            </>
          }
          ListFooterComponent={
            typingUsers.length > 0 ? <TypingIndicator name={title} avatar={peerAvatar} /> : null
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
                  highlighted={item.id === highlightedId}
                  peerName={title}
                  peerAvatar={peerAvatar}
                  timeLabel={timeFormatter(item.createdAt)}
                  onLongPress={(anchor) => {
                    suspendRef.current = true;
                    setActionTarget({ message: item, anchor, fromMe, firstInGroup, lastInGroup });
                  }}
                  onResend={(id) => void resendWithAudioCleanup(id)}
                  onOpenImage={(url) => openViewer([url])}
                  onMention={(nick) => navigation.navigate(ROOT_ROUTES.ProfileView, { userId: nick })}
                  onShowReactions={setReactionsTargetId}
                  onQuoteClick={scrollToMessage}
                  onOpenProfile={openPeerProfile}
                />
                {peerCardVisible && item.id === peerCardAnchorId && peerProfile != null &&
                  renderPeerCard()}
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
          <Text className="text-center text-sm text-ola-ink-soft">
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
      {editing != null && <EditingNotice onCancel={cancelEdit} />}
      {editing == null && replyTarget != null && (
        <ReplyPreviewBar replyTarget={replyTarget} fallbackName={title} onClear={clearReplyTarget} />
      )}
      {pendingAudio != null && (
        <VoicePreviewBar
          uri={pendingAudio.file.uri}
          duration={pendingAudio.duration}
          waveform={pendingAudio.waveform}
          bottomInset={bottomBarInset}
          onSend={() => {
            const audio = pendingAudio;
            const sourceConversationId =
              useChatStore.getState().currentConversationId;
            pendingAudioRef.current = null;
            setPendingAudio(null);
            setOpenTab(null);
            void sendAudio(audio.file, audio.duration, audio.waveform)
              .then(sent => {
                if (sent) {
                  deleteTemporaryVoiceFileAfterUiUpdate(audio.file.uri);
                  return;
                }
                const retryable = useChatStore
                  .getState()
                  .messages.some(
                    message =>
                      message.type === 'audio' &&
                      message.status === 'failed' &&
                      parseMessageMetadata(message.metadata).url ===
                        audio.file.uri,
                  );
                if (!retryable) {
                  void deleteTemporaryVoiceFile(audio.file.uri);
                }
              })
              .catch(() => {
                if (
                  useChatStore.getState().currentConversationId ===
                  sourceConversationId
                ) {
                  showPendingAudio(audio);
                } else {
                  void deleteTemporaryVoiceFile(audio.file.uri);
                }
              });
          }}
          onDiscard={discardPendingAudio}
        />
      )}
      {pendingAudio == null && (
        <VoiceRecorderControl
          ref={voiceRecorderRef}
          key={currentConversationId ?? conversationId ?? 'draft'}
          bottomInset={bottomBarInset}
          onRecorded={recording => {
            showPendingAudio(recording);
            setVoiceRecording(false);
            setOpenTab(null);
          }}
          onRecordingChange={recording => {
            setVoiceRecording(recording);
            if (recording) setOpenTab(null);
          }}
        />
      )}
      {pendingImages.length > 0 && (
        <View
          className="flex-row items-end gap-1 bg-white px-2 py-1.5"
          style={{ borderTopWidth: 1, borderTopColor: DIVIDER }}
        >
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            className="min-h-9 flex-1"
            contentContainerClassName="items-center gap-2 px-1 py-1"
          >
            {pendingImages.map((image) => (
              <View key={image.id} className="relative">
                <Image
                  source={{ uri: image.uri }}
                  style={{ width: 44, height: 44, borderRadius: 8 }}
                  resizeMode="cover"
                />
                <Pressable
                  onPress={() => removePendingImage(image.id)}
                  className="absolute h-5 w-5 items-center justify-center rounded-full"
                  style={{ top: -6, right: -6, backgroundColor: 'rgba(0,0,0,0.6)' }}
                >
                  <Text className="text-xs leading-none text-white">×</Text>
                </Pressable>
              </View>
            ))}
            <Pressable
              onPress={clearPendingImages}
              className="ml-1 h-9 items-center justify-center rounded-full px-3"
              style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
            >
              <Text className="text-sm font-medium text-ola-ink-soft">{t('dialog.cancel')}</Text>
            </Pressable>
          </ScrollView>
          <Pressable
            onPress={() => void sendPendingImages()}
            className="h-9 items-center justify-center rounded-full bg-ola-primary px-4 active:opacity-90"
          >
            <Text className="text-sm font-semibold text-white">{t('chat.send')}</Text>
          </Pressable>
        </View>
      )}
      <ChatInputBar
        ref={composerRef}
        hidden={pendingAudio != null || pendingImages.length > 0 || voiceRecording}
        refocusOnSend={openTab == null}
        editing={editing != null}
        placeholder={t('chat.messageInputPlaceholder', { name: title })}
        onSend={(text) => void send(text)}
        onTyping={notifyTyping}
        onFocusInput={closeAttachTab}
        onPasteImage={queuePastedImage}
      />

      {!voiceRecording && pendingAudio == null && (
        <AttachmentBar
          openTab={openTab}
          bottomInset={bottomBarInset}
          onToggleTab={(tab) => {
            if (openTab !== tab) Keyboard.dismiss();
            setOpenTab(openTab === tab ? null : tab);
          }}
          onStartVoice={() => {
            Keyboard.dismiss();
            setOpenTab(null);
            voiceRecorderRef.current?.start();
          }}
          voiceDisabled={pendingImages.length > 0}
          onPickEmoji={(code) => composerRef.current?.insertCode(code, true)}
          onBackspace={() => composerRef.current?.backspace()}
          onSendKul={(index) => {
            void send(kulToken(index));
            setOpenTab(null);
          }}
          onPickImage={() => void pickImages()}
          onPickCamera={() => void capturePhoto()}
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
      )}
      </>
      )}
      </ChatKeyboardArea>

      <ChatReactionBalloons />

      {transferKenOpen && peerId !== '' && (
        <TransferKenDialog
          visible
          onClose={() => setTransferKenOpen(false)}
          receiver={{
            ...transferReceiver,
            color: colorForName(conversation?.otherUser?.username ?? title),
          }}
        />
      )}

      {transferVipDaysOpen && peerId !== '' && (
        <TransferVipDaysDialog
          visible
          onClose={() => setTransferVipDaysOpen(false)}
          receiver={transferReceiver}
        />
      )}

      {tradingVipOpen && peerId !== '' && (
        <TradingVipDialog
          visible
          onClose={() => setTradingVipOpen(false)}
          receiver={transferReceiver}
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
          suspendRef.current = false;
          setActionTarget(null);
          if (Platform.OS !== 'ios') requestAnimationFrame(openPendingDeleteDialog);
        }}
        onDismiss={openPendingDeleteDialog}
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
        onConfirm={() => {
          setBlockOpen(false);
          void handleBlock();
        }}
        onCancel={() => setBlockOpen(false)}
      />
    </View>
  );
}

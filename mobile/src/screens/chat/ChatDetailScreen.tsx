import { useCallback, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Keyboard,
  NativeScrollEvent,
  NativeSyntheticEvent,
  Pressable,
  Text,
  View,
} from 'react-native';
import { KeyboardShift } from '@components/KeyboardShift';
import { FlashList } from '@shopify/flash-list';
import { useStickyBottomList } from '@hooks/useStickyBottomList';
import { launchCamera, launchImageLibrary, type Asset } from 'react-native-image-picker';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { colorForName, isSameDay } from '@ola/shared/lib';
import type { NativeUploadFile } from '@ola/shared/lib';
import type { Message, ReactionType } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { useMediaViewerStore } from '@store/mediaViewerStore';
import Clipboard from '@react-native-clipboard/clipboard';
import { kulToken } from '@lib/kul';
import { pastedImageFile } from '@lib/imagePicker';
import { compressImageForUpload, ImageTooLargeError } from '@lib/compressImage';
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
import { AttachmentBar, type AttachTab } from './components/AttachmentBar';
import { VoicePreviewBar } from './components/VoicePreviewBar';
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
  } = useStickyBottomList<Message>();
  const composerRef = useRef<ChatInputBarHandle>(null);

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
    if (event.nativeEvent.contentOffset.y < 80 && hasMore) void loadMoreMessages();
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

  async function sendPickedAssets(assets: Asset[]) {
    for (const asset of assets) {
      if (asset.uri == null) continue;
      await compressAndSend({
        uri: asset.uri,
        name: asset.fileName ?? 'photo.jpg',
        type: asset.type ?? 'image/jpeg',
      });
    }
  }

  async function pickAndSendImages() {
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
    await sendPickedAssets(result.assets ?? []);
  }

  async function captureAndSendPhoto() {
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
    await sendPickedAssets(result.assets ?? []);
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
        onSelect: () => setDeleteTarget(message),
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

      <KeyboardShift>
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
            peerCardVisible && peerCardAnchorId === '' && peerProfile != null
              ? renderPeerCard()
              : null
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
                  peerName={title}
                  peerAvatar={peerAvatar}
                  timeLabel={timeFormatter(item.createdAt)}
                  onLongPress={(anchor) => {
                    suspendRef.current = true;
                    setActionTarget({ message: item, anchor, fromMe, firstInGroup, lastInGroup });
                  }}
                  onResend={(id) => void resendMessage(id)}
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
        onPasteImage={(uri) => void compressAndSend(pastedImageFile(uri))}
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
      </KeyboardShift>

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
        onConfirm={() => {
          setBlockOpen(false);
          void handleBlock();
        }}
        onCancel={() => setBlockOpen(false)}
      />
    </View>
  );
}

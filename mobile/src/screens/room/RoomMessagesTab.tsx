import { useCallback, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Image,
  NativeSyntheticEvent,
  Pressable,
  ScrollView,
  Text,
  TextInput,
  NativeScrollEvent,
  View,
} from 'react-native';
import Clipboard from '@react-native-clipboard/clipboard';
import { launchImageLibrary } from 'react-native-image-picker';
import { FlashList, type FlashListRef } from '@shopify/flash-list';
import type { ReactionType, RoomMessage } from '@ola/shared/types';
import type { NativeUploadFile } from '@ola/shared/lib';
import { createTimeFormatter } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { useRoomFilterStore } from '@ola/shared/stores/roomFilterStore';
import { kulImageForText, kulToken } from '../../lib/kul';
import { SmileyText } from '../../lib/richText';
import {
  ComposerDraftOverlay,
  composerSingleLineHeight,
  useComposerScrollSync,
} from '../../components/SmileyDraftOverlay';
import { useSmileyDraft } from '../../hooks/useSmileyDraft';
import { ConfirmDialog } from '../../components/ConfirmDialog';
import { buildRoomFeed, type RoomFeedItem } from './messageGroups';
import { RoomMessageGroup } from './RoomMessageGroup';
import { RoomReactionNotice } from './RoomReactionNotice';
import { SmileyKulPanel } from './SmileyKulPanel';
import { MessageActionSheet, type AnchorRect, type MessageSheetAction } from './MessageActionSheet';
import { RoomReactionsDialog } from './RoomReactionsDialog';
import type { RoomChatStatus } from '@ola/shared/stores/roomChatStore';

const likeIcon = require('../../assets/icons/chat/smiley/smiley_35.png');
const smileyIcon = require('../../assets/icons/chat/ic_smiley.png');
const smileyIconActive = require('../../assets/icons/chat/ic_smiley_selected.png');
const photoIcon = require('../../assets/icons/chat/ic_local.png');
const replyActionIcon = require('../../assets/icons/me/ic_action_reply_gray.png');
const deleteActionIcon = require('../../assets/icons/chat/ic_menu_delete.png');

interface PendingImage {
  id: string;
  uri: string;
  file: NativeUploadFile;
}

interface RoomMessagesTabProps {
  currentUserId: string;
  language: string;
  messages: RoomMessage[];
  status: RoomChatStatus;
  hasMore: boolean;
  loadingMore: boolean;
  replyTarget: RoomMessage | null;
  onSend: (content: string) => Promise<void>;
  onSendImage: (file: NativeUploadFile) => Promise<void>;
  onResendImage: (messageId: string) => void;
  onLoadMore: () => void;
  onOpenProfile?: (nick: string, color: string) => void;
  onOpenUser?: (userId: string) => void;
  onSetReplyTarget: (message: RoomMessage) => void;
  onClearReplyTarget: () => void;
  onReact: (messageId: string, type: ReactionType) => void;
  onDeleteMessage: (messageId: string) => Promise<void>;
}

export function RoomMessagesTab({
  currentUserId,
  language,
  messages,
  status,
  hasMore,
  loadingMore,
  replyTarget,
  onSend,
  onSendImage,
  onResendImage,
  onLoadMore,
  onOpenProfile,
  onOpenUser,
  onSetReplyTarget,
  onClearReplyTarget,
  onReact,
  onDeleteMessage,
}: RoomMessagesTabProps) {
  const { t } = useTranslation();
  const pushToast = useToastStore((s) => s.push);
  const blockedUserIds = useRoomFilterStore((s) => s.blockedUserIds);
  const blockUser = useRoomFilterStore((s) => s.blockUser);
  const {
    draft,
    inputValue,
    codes,
    setDraft,
    applyDraft,
    handleChangeText,
    insertAtCursor,
    backspaceAtCursor,
    selection,
    handleSelectionChange,
  } = useSmileyDraft();
  const { scrollY: inputScrollY, handleScroll: handleInputScroll } = useComposerScrollSync(draft);
  const [panelOpen, setPanelOpen] = useState(false);
  const [pendingImages, setPendingImages] = useState<PendingImage[]>([]);
  const [actionTarget, setActionTarget] = useState<{ message: RoomMessage; anchor: AnchorRect } | null>(
    null
  );
  const [deleteTarget, setDeleteTarget] = useState<RoomMessage | null>(null);
  const [blockTarget, setBlockTarget] = useState<RoomMessage | null>(null);
  const [reactionsTargetId, setReactionsTargetId] = useState<string | null>(null);
  const [highlightedId, setHighlightedId] = useState<string | null>(null);
  const listRef = useRef<FlashListRef<RoomFeedItem>>(null);
  const stickToBottomRef = useRef(true);
  const sheetOpenRef = useRef(false);
  const highlightTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const inputRef = useRef<TextInput>(null);
  const imageIdRef = useRef(0);

  const canSend = status === 'joined';
  const timeFormatter = useMemo(() => createTimeFormatter(language), [language]);
  const feed = useMemo(() => {
    const blocked = new Set(blockedUserIds);
    const visible =
      blocked.size === 0 ? messages : messages.filter((item) => !blocked.has(item.senderId));
    return buildRoomFeed(visible, currentUserId);
  }, [messages, currentUserId, blockedUserIds]);
  const messageById = useMemo(() => new Map(messages.map((item) => [item.id, item])), [messages]);

  const scrollToEnd = useCallback(() => {
    if (stickToBottomRef.current && !sheetOpenRef.current) {
      requestAnimationFrame(() => listRef.current?.scrollToEnd({ animated: false }));
    }
  }, []);

  async function sendText(text: string) {
    const trimmed = text.trim();
    if (trimmed === '' || !canSend) return;
    stickToBottomRef.current = true;
    applyDraft('');
    setPanelOpen(false);
    try {
      await onSend(trimmed);
    } catch {
      applyDraft(trimmed);
      pushToast('error', t('room.sendError'));
    }
  }

  const insertMention = useCallback((name: string) => {
    setDraft((current) => {
      const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
      const alreadyTagged = new RegExp(`@${escaped}(?![\\p{L}\\p{N}_])`, 'iu');
      if (alreadyTagged.test(current)) return current;
      const prefix = current === '' || current.endsWith(' ') ? current : `${current} `;
      return `${prefix}@${name} `;
    });
  }, [setDraft]);

  const scrollToMessage = useCallback(
    (id: string) => {
      const index = feed.findIndex(
        (item) => item.kind === 'group' && item.messages.some((message) => message.id === id)
      );
      if (index < 0) {
        pushToast('error', t('room.replyNotFound'));
        return;
      }
      stickToBottomRef.current = false;
      listRef.current?.scrollToIndex({ index, animated: true, viewPosition: 0.5 });
      setHighlightedId(id);
      if (highlightTimerRef.current != null) clearTimeout(highlightTimerRef.current);
      highlightTimerRef.current = setTimeout(() => setHighlightedId(null), 1500);
    },
    [feed, pushToast, t]
  );

  function isCopyableText(message: RoomMessage): boolean {
    return (
      message.type !== 'image' &&
      kulImageForText(message.content) == null &&
      message.content.trim() !== ''
    );
  }

  function copyMessage(content: string) {
    Clipboard.setString(content);
    pushToast('success', t('room.copied'));
  }

  function sheetActions(message: RoomMessage): MessageSheetAction[] {
    const actions: MessageSheetAction[] = [];
    const copyAction: MessageSheetAction = {
      key: 'copy',
      label: t('room.actionCopy'),
      onSelect: () => copyMessage(message.content),
    };
    if (message.senderId !== currentUserId) {
      actions.push({
        key: 'reply',
        label: t('room.actionReply'),
        icon: replyActionIcon,
        onSelect: () => onSetReplyTarget(message),
      });
      if (isCopyableText(message)) actions.push(copyAction);
      actions.push({
        key: 'block',
        label: t('room.actionBlock'),
        destructive: true,
        onSelect: () => setBlockTarget(message),
      });
    } else {
      if (isCopyableText(message)) actions.push(copyAction);
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

  async function pickImages() {
    if (!canSend) return;
    setPanelOpen(false);
    const result = await launchImageLibrary({ mediaType: 'photo', selectionLimit: 0 });
    if (result.didCancel) return;
    const assets = result.assets ?? [];
    if (assets.length === 0) {
      if (result.errorCode != null) pushToast('error', t('room.sendError'));
      return;
    }
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

  function removePendingImage(id: string) {
    setPendingImages((current) => current.filter((image) => image.id !== id));
  }

  function clearPendingImages() {
    setPendingImages([]);
  }

  async function sendPendingImages() {
    const images = pendingImages;
    if (images.length === 0 || !canSend) return;
    stickToBottomRef.current = true;
    setPendingImages([]);
    setPanelOpen(false);
    for (const image of images) {
      try {
        await onSendImage(image.file);
      } catch {
        pushToast('error', t('room.sendError'));
      }
    }
  }

  function handleScroll(event: NativeSyntheticEvent<NativeScrollEvent>) {
    const { contentOffset, contentSize, layoutMeasurement } = event.nativeEvent;
    const distanceFromBottom = contentSize.height - contentOffset.y - layoutMeasurement.height;
    stickToBottomRef.current = distanceFromBottom < 80;
    if (contentOffset.y < 80 && hasMore && !loadingMore) onLoadMore();
  }

  function replyExcerpt(message: RoomMessage): string {
    if (message.type === 'image') return t('room.replyImage');
    return kulImageForText(message.content) != null ? t('room.replySticker') : message.content;
  }

  const isTyping = draft.trim() !== '';

  return (
    <View className="flex-1">
      <RoomReactionNotice />
      {status !== 'joined' && (
        <View className="bg-black/5 py-1.5">
          <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {status === 'connecting' ? t('room.connecting') : t('room.joinError')}
          </Text>
        </View>
      )}

      <FlashList
        ref={listRef}
        data={feed}
        keyExtractor={(item) => item.key}
        onScroll={handleScroll}
        scrollEventThrottle={16}
        contentContainerClassName="p-3"
        onContentSizeChange={scrollToEnd}
        onLayout={scrollToEnd}
        ListHeaderComponent={
          loadingMore ? (
            <Text className="py-1 text-center text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
              {t('common.loading')}
            </Text>
          ) : null
        }
        renderItem={({ item }) =>
          item.kind === 'date' ? (
            <View className="items-center py-2">
              <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
                {timeFormatter(item.createdAt)}
              </Text>
            </View>
          ) : (
            <View className="pb-2">
              <RoomMessageGroup
                group={item}
                highlightedId={highlightedId}
                onOpenProfile={onOpenProfile}
                onOpenUser={onOpenUser}
                onQuickMention={insertMention}
                onLongPressMessage={(id, anchor) => {
                  const message = messageById.get(id);
                  if (message != null) {
                    sheetOpenRef.current = true;
                    setActionTarget({ message, anchor });
                  }
                }}
                onQuoteClick={scrollToMessage}
                onShowReactions={setReactionsTargetId}
                onResendImage={onResendImage}
              />
            </View>
          )
        }
      />

      {replyTarget != null && (
        <View
          className="flex-row items-center gap-2 bg-black/5 px-3 py-1.5"
          style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
        >
          <View className="h-8 w-0.5 rounded bg-ola-primary" />
          <View className="min-w-0 flex-1">
            <Text numberOfLines={1} className="text-xs font-semibold text-ola-primary">
              {t('room.replyingTo', { name: replyTarget.senderName ?? '' })}
            </Text>
            <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
              <SmileyText text={replyExcerpt(replyTarget)} fontSize={12} />
            </Text>
          </View>
          <Pressable
            onPress={onClearReplyTarget}
            className="h-7 w-7 items-center justify-center rounded-full"
          >
            <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.54)' }}>
              ×
            </Text>
          </Pressable>
        </View>
      )}

      <View
        className="flex-row items-center gap-1 bg-white px-2 py-2"
        style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
      >
        <Pressable
          onPress={() => setPanelOpen((current) => !current)}
          className="h-9 w-9 items-center justify-center"
          style={{ opacity: panelOpen ? 1 : 0.6 }}
        >
          <Image
            source={panelOpen ? smileyIconActive : smileyIcon}
            style={{ width: 24, height: 24 }}
            resizeMode="contain"
          />
        </Pressable>
        <Pressable
          onPress={() => void pickImages()}
          disabled={!canSend}
          className="h-9 w-9 items-center justify-center"
          style={{ opacity: 0.6 }}
        >
          <Image source={photoIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
        </Pressable>
        {pendingImages.length > 0 ? (
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
              <Text className="text-sm font-medium" style={{ color: 'rgba(0,0,0,0.54)' }}>
                {t('dialog.cancel')}
              </Text>
            </Pressable>
          </ScrollView>
        ) : (
          <View
            className="max-h-28 min-h-9 flex-1 justify-center rounded-2xl"
            style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
          >
            <TextInput
              ref={inputRef}
              className="px-3 py-2 text-base"
              style={[
                { color: 'rgba(0,0,0,0.87)', textAlignVertical: 'center', maxHeight: 112 },
                draft === '' ? { height: composerSingleLineHeight(8) } : null,
              ]}
              selectionColor="#7cb342"
              cursorColor="#7cb342"
              placeholder={t('room.chatInputHint')}
              placeholderTextColor="rgba(0,0,0,0.38)"
              multiline
              editable={canSend}
              value={inputValue}
              selection={selection}
              onSelectionChange={handleSelectionChange}
              onChangeText={handleChangeText}
              onScroll={handleInputScroll}
              onFocus={() => setPanelOpen(false)}
            />
            {inputValue !== '' && (
              <ComposerDraftOverlay
                display={inputValue}
                codes={codes}
                scrollY={inputScrollY}
                inputRef={inputRef}
              />
            )}
          </View>
        )}
        {pendingImages.length > 0 ? (
          <Pressable
            onPress={() => void sendPendingImages()}
            disabled={!canSend}
            className="h-9 items-center justify-center rounded-full bg-ola-primary px-4 active:opacity-90"
          >
            <Text className="text-sm font-semibold text-white">{t('chat.send')}</Text>
          </Pressable>
        ) : isTyping ? (
          <Pressable
            onPress={() => {
              void sendText(draft);
              requestAnimationFrame(() => inputRef.current?.focus());
            }}
            disabled={!canSend}
            className="h-9 items-center justify-center rounded-full bg-ola-primary px-4 active:opacity-90"
          >
            <Text className="text-sm font-semibold text-white">{t('chat.send')}</Text>
          </Pressable>
        ) : (
          <Pressable
            onPress={() => void sendText('(y)')}
            onLongPress={() => void sendText('(Y)')}
            disabled={!canSend}
            className="h-9 w-9 items-center justify-center"
          >
            <Image source={likeIcon} style={{ width: 28, height: 28 }} resizeMode="contain" />
          </Pressable>
        )}
      </View>

      {panelOpen && canSend && (
        <SmileyKulPanel
          onPickEmoji={insertAtCursor}
          onBackspace={backspaceAtCursor}
          onSendKul={(index) => {
            void sendText(kulToken(index));
            setPanelOpen(false);
          }}
        />
      )}

      <MessageActionSheet
        visible={actionTarget != null}
        anchor={actionTarget?.anchor ?? null}
        actions={actionTarget != null ? sheetActions(actionTarget.message) : []}
        showReactions={actionTarget != null && actionTarget.message.senderId !== currentUserId}
        onReact={(type) => {
          if (actionTarget != null) onReact(actionTarget.message.id, type);
        }}
        onClose={() => {
          sheetOpenRef.current = false;
          setActionTarget(null);
        }}
      />

      <RoomReactionsDialog
        visible={reactionsTargetId != null}
        reactions={
          reactionsTargetId != null ? messageById.get(reactionsTargetId)?.reactions : undefined
        }
        onClose={() => setReactionsTargetId(null)}
      />

      <ConfirmDialog
        visible={deleteTarget != null}
        danger
        title={t('chat.deleteTitle')}
        message={t('chat.deleteConfirm')}
        confirmLabel={t('dialog.delete')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => {
          const target = deleteTarget;
          setDeleteTarget(null);
          if (target != null) {
            onDeleteMessage(target.id).catch(() => pushToast('error', t('common.error')));
          }
        }}
        onCancel={() => setDeleteTarget(null)}
      />

      <ConfirmDialog
        visible={blockTarget != null}
        danger
        title={t('room.blockTitle')}
        message={t('room.blockConfirm', { name: blockTarget?.senderName ?? '' })}
        confirmLabel={t('room.actionBlock')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => {
          const target = blockTarget;
          setBlockTarget(null);
          if (target != null) {
            blockUser(target.senderId);
            pushToast('success', t('room.blockSuccess'));
          }
        }}
        onCancel={() => setBlockTarget(null)}
      />
    </View>
  );
}

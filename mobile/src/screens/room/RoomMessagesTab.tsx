import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  NativeSyntheticEvent,
  Pressable,
  Text,
  NativeScrollEvent,
  useWindowDimensions,
  View,
} from 'react-native';
import Clipboard from '@react-native-clipboard/clipboard';
import { FlashList, type FlashListRef } from '@shopify/flash-list';
import type { ReactionType, RoomMessage } from '@ola/shared/types';
import type { NativeUploadFile } from '@ola/shared/lib';
import { createTimeFormatter } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { useRoomFilterStore } from '@ola/shared/stores/roomFilterStore';
import { kulImageForText } from '../../lib/kul';
import { RichTextView } from '../../components/RichTextView';
import { ConfirmDialog } from '../../components/ConfirmDialog';
import { buildRoomFeed, type GroupedMessage, type RoomFeedItem } from './messageGroups';
import { RoomBubbleBody, RoomMessageGroup } from './RoomMessageGroup';
import { RoomComposerBar, type RoomComposerHandle } from './RoomComposerBar';
import { RoomReactionNotice } from './RoomReactionNotice';
import { RoomReactionBalloons } from './RoomReactionBalloons';
import { MessageActionSheet, type AnchorRect, type MessageSheetAction } from './MessageActionSheet';
import { RoomReactionsDialog } from './RoomReactionsDialog';
import type { RoomChatStatus } from '@ola/shared/stores/roomChatStore';

const replyActionIcon = require('../../assets/icons/me/ic_action_reply_gray.png');
const deleteActionIcon = require('../../assets/icons/chat/ic_menu_delete.png');

interface RoomMessagesTabProps {
  currentUserId: string;
  bottomInset?: number;
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
  bottomInset = 0,
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
  const { width: windowWidth } = useWindowDimensions();
  const pushToast = useToastStore((s) => s.push);
  const blockedUserIds = useRoomFilterStore((s) => s.blockedUserIds);
  const blockUser = useRoomFilterStore((s) => s.blockUser);
  const [actionTarget, setActionTarget] = useState<{
    message: RoomMessage;
    anchor: AnchorRect;
    grouped: GroupedMessage;
    isOwn: boolean;
  } | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<RoomMessage | null>(null);
  const [blockTarget, setBlockTarget] = useState<RoomMessage | null>(null);
  const [reactionsTargetId, setReactionsTargetId] = useState<string | null>(null);
  const [highlightedId, setHighlightedId] = useState<string | null>(null);
  const listRef = useRef<FlashListRef<RoomFeedItem>>(null);
  const stickToBottomRef = useRef(true);
  const sheetOpenRef = useRef(false);
  const highlightTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const composerRef = useRef<RoomComposerHandle>(null);

  const canSend = status === 'joined';
  const timeFormatter = useMemo(() => createTimeFormatter(language), [language]);
  const feed = useMemo(() => {
    const blocked = new Set(blockedUserIds);
    const visible =
      blocked.size === 0 ? messages : messages.filter((item) => !blocked.has(item.senderId));
    return buildRoomFeed(visible, currentUserId);
  }, [messages, currentUserId, blockedUserIds]);
  const messageById = useMemo(() => new Map(messages.map((item) => [item.id, item])), [messages]);

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

  const pinToBottom = useCallback(() => {
    forceScrollRef.current = !stickToBottomRef.current;
    stickToBottomRef.current = true;
  }, []);

  useEffect(() => {
    if (replyTarget != null) composerRef.current?.focus();
  }, [replyTarget]);

  const insertMention = useCallback((name: string) => {
    composerRef.current?.insertMention(name);
  }, []);

  const handleLongPressMessage = useCallback(
    (id: string, anchor: AnchorRect, grouped: GroupedMessage, isOwn: boolean) => {
      const message = messageById.get(id);
      if (message != null) {
        sheetOpenRef.current = true;
        setActionTarget({ message, anchor, grouped, isOwn });
      }
    },
    [messageById]
  );

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

  return (
    <View className="flex-1">
      <RoomReactionNotice />
      <RoomReactionBalloons />
      {status !== 'joined' && (
        <View className="bg-black/5 py-1.5">
          <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {status === 'connecting' ? t('room.connecting') : t('room.joinError')}
          </Text>
        </View>
      )}

      <View
        className="flex-1"
        onStartShouldSetResponderCapture={() => {
          composerRef.current?.closePanel();
          return false;
        }}
      >
      <FlashList
        ref={listRef}
        data={feed}
        keyExtractor={(item) => item.key}
        getItemType={(item) => item.kind}
        maintainVisibleContentPosition={{
          startRenderingFromBottom: true,
          autoscrollToBottomThreshold: 0.2,
        }}
        onScroll={handleScroll}
        scrollEventThrottle={16}
        contentContainerClassName="p-3"
        onContentSizeChange={scrollOnContentChange}
        onLayout={repinOnResize}
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
                onLongPressMessage={handleLongPressMessage}
                onQuoteClick={scrollToMessage}
                onShowReactions={setReactionsTargetId}
                onResendImage={onResendImage}
              />
            </View>
          )
        }
      />
      </View>

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
            onPress={onClearReplyTarget}
            className="h-7 w-7 items-center justify-center rounded-full"
          >
            <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.54)' }}>
              ×
            </Text>
          </Pressable>
        </View>
      )}

      <RoomComposerBar
        ref={composerRef}
        bottomInset={bottomInset}
        disabled={!canSend}
        onBeforeSend={pinToBottom}
        onSendText={onSend}
        onSendImage={onSendImage}
      />

      <MessageActionSheet
        visible={actionTarget != null}
        anchor={actionTarget?.anchor ?? null}
        preview={
          actionTarget != null ? (
            <View style={{ alignSelf: actionTarget.isOwn ? 'flex-end' : 'flex-start' }}>
              <RoomBubbleBody
                message={actionTarget.grouped}
                isOwn={actionTarget.isOwn}
                position={actionTarget.grouped.position}
                onMention={() => undefined}
              />
            </View>
          ) : null
        }
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

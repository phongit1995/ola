import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  AppState,
  NativeSyntheticEvent,
  Platform,
  Pressable,
  NativeScrollEvent,
  useWindowDimensions,
  View,
} from 'react-native';
import Clipboard from '@react-native-clipboard/clipboard';
import { FlashList } from '@shopify/flash-list';
import { useStickyBottomList } from '@hooks/useStickyBottomList';
import type { ReactionType, RoomMessage } from '@ola/shared/types';
import type { NativeUploadFile } from '@ola/shared/types';
import { createDateSeparatorFormatter } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { useRoomFilterStore } from '@ola/shared/stores/room/roomFilterStore';
import { ChatText as Text } from '@components/ui/ChatText';
import { RichTextView } from '@components/ui/RichTextView';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import {
  buildRoomFeed,
  type GroupedMessage,
  type RoomFeedItem,
} from '../messageGroups';
import { replyExcerpt, roomMessageAbilities } from '../roomMessageView';
import { RoomBubbleBody, RoomMessageGroup } from './RoomMessageGroup';
import { RoomComposerBar, type RoomComposerHandle } from './RoomComposerBar';
import { RoomReactionNotice } from './RoomReactionNotice';
import { RoomReactionBalloons } from './RoomReactionBalloons';
import {
  MessageActionSheet,
  type AnchorRect,
  type MessageSheetAction,
} from './MessageActionSheet';
import { RoomReactionsDialog } from './RoomReactionsDialog';
import type { RoomAudioSendResult, RoomChatStatus } from '@ola/shared/types';

const replyActionIcon = require('@assets/icons/me/ic_action_reply_gray.png');
const deleteActionIcon = require('@assets/icons/chat/ic_menu_delete.png');

interface RoomMessagesTabProps {
  currentUserId: string;
  language: string;
  messages: RoomMessage[];
  status: RoomChatStatus;
  active: boolean;
  hasMore: boolean;
  loadingMore: boolean;
  replyTarget: RoomMessage | null;
  onSend: (content: string) => Promise<void>;
  onSendImage: (file: NativeUploadFile) => Promise<void>;
  onSendAudio: (
    file: NativeUploadFile,
    duration: number,
    waveform: number[],
  ) => Promise<RoomAudioSendResult>;
  onResendImage: (messageId: string) => void;
  onResendAudio: (messageId: string) => void;
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
  active,
  hasMore,
  loadingMore,
  replyTarget,
  onSend,
  onSendImage,
  onSendAudio,
  onResendImage,
  onResendAudio,
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
  const pushToast = useToastStore(s => s.push);
  const blockedUserIds = useRoomFilterStore(s => s.blockedUserIds);
  const blockUser = useRoomFilterStore(s => s.blockUser);
  const [actionTarget, setActionTarget] = useState<{
    message: RoomMessage;
    anchor: AnchorRect;
    grouped: GroupedMessage;
    isOwn: boolean;
  } | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<RoomMessage | null>(null);
  const [blockTarget, setBlockTarget] = useState<RoomMessage | null>(null);
  const [reactionsTargetId, setReactionsTargetId] = useState<string | null>(
    null,
  );
  const [highlightedId, setHighlightedId] = useState<string | null>(null);
  const pendingSheetDialogRef = useRef<{
    kind: 'delete' | 'block';
    target: RoomMessage;
  } | null>(null);
  const pendingBlockCommitRef = useRef<RoomMessage | null>(null);
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
    requestScrollToBottom,
    unstick,
    isUserInteracting,
    isStuckToBottom,
  } = useStickyBottomList<RoomFeedItem>();
  const highlightTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const composerRef = useRef<RoomComposerHandle>(null);
  const wasStuckBeforeBackgroundRef = useRef(true);
  const [foregroundEpoch, setForegroundEpoch] = useState(0);

  const canSend = status === 'joined';
  const dateFormatter = useMemo(
    () => createDateSeparatorFormatter(language),
    [language],
  );
  const feed = useMemo(() => {
    const blocked = new Set(blockedUserIds);
    const visible =
      blocked.size === 0
        ? messages
        : messages.filter(item => !blocked.has(item.senderId));
    return buildRoomFeed(visible, currentUserId);
  }, [messages, currentUserId, blockedUserIds]);
  const messageById = useMemo(
    () => new Map(messages.map(item => [item.id, item])),
    [messages],
  );

  const [rendered, setRendered] = useState(active);
  useEffect(() => {
    if (active && !rendered) setRendered(true);
  }, [active, rendered]);

  useEffect(() => {
    if (active && rendered) requestScrollToBottom();
  }, [active, rendered, requestScrollToBottom]);

  useEffect(() => {
    const subscription = AppState.addEventListener('change', nextState => {
      if (nextState !== 'active') {
        wasStuckBeforeBackgroundRef.current = isStuckToBottom();
        return;
      }
      if (!active || !rendered) return;
      setForegroundEpoch(value => value + 1);
      listRef.current?.recomputeViewableItems();
      if (wasStuckBeforeBackgroundRef.current) requestScrollToBottom();
    });
    return () => subscription.remove();
  }, [active, isStuckToBottom, listRef, rendered, requestScrollToBottom]);

  useEffect(() => {
    if (replyTarget != null) composerRef.current?.focus();
  }, [replyTarget]);

  const insertMention = useCallback((name: string) => {
    composerRef.current?.insertMention(name);
  }, []);

  const openPendingSheetDialog = useCallback(() => {
    const pending = pendingSheetDialogRef.current;
    pendingSheetDialogRef.current = null;
    if (pending?.kind === 'delete') setDeleteTarget(pending.target);
    if (pending?.kind === 'block') setBlockTarget(pending.target);
  }, []);

  const commitPendingBlock = useCallback(() => {
    const target = pendingBlockCommitRef.current;
    pendingBlockCommitRef.current = null;
    if (target == null) return;
    blockUser(target.senderId);
    pushToast('success', t('room.blockSuccess'));
  }, [blockUser, pushToast, t]);

  const handleLongPressMessage = useCallback(
    (
      id: string,
      anchor: AnchorRect,
      grouped: GroupedMessage,
      isOwn: boolean,
    ) => {
      const message = messageById.get(id);
      if (message != null) {
        suspendRef.current = true;
        setActionTarget({ message, anchor, grouped, isOwn });
      }
    },
    [messageById, suspendRef],
  );

  const scrollToMessage = useCallback(
    (id: string) => {
      const index = feed.findIndex(
        item =>
          item.kind === 'group' &&
          item.messages.some(message => message.id === id),
      );
      if (index < 0) {
        pushToast('error', t('room.replyNotFound'));
        return;
      }
      unstick();
      listRef.current?.scrollToIndex({
        index,
        animated: true,
        viewPosition: 0.5,
      });
      setHighlightedId(id);
      if (highlightTimerRef.current != null)
        clearTimeout(highlightTimerRef.current);
      highlightTimerRef.current = setTimeout(
        () => setHighlightedId(null),
        1500,
      );
    },
    [feed, pushToast, t, listRef, unstick],
  );

  function copyMessage(content: string) {
    Clipboard.setString(content);
    pushToast('success', t('room.copied'));
  }

  function sheetActions(message: RoomMessage): MessageSheetAction[] {
    const { isOwn, canCopy } = roomMessageAbilities(message, currentUserId);
    const actions: MessageSheetAction[] = [];
    const copyAction: MessageSheetAction = {
      key: 'copy',
      label: t('room.actionCopy'),
      onSelect: () => copyMessage(message.content),
    };
    if (!isOwn) {
      actions.push({
        key: 'reply',
        label: t('room.actionReply'),
        icon: replyActionIcon,
        onSelect: () => onSetReplyTarget(message),
      });
      if (canCopy) actions.push(copyAction);
      actions.push({
        key: 'block',
        label: t('room.actionBlock'),
        destructive: true,
        onSelect: () => {
          pendingSheetDialogRef.current = { kind: 'block', target: message };
        },
      });
    } else {
      if (canCopy) actions.push(copyAction);
      actions.push({
        key: 'delete',
        label: t('chat.actionDelete'),
        icon: deleteActionIcon,
        destructive: true,
        onSelect: () => {
          pendingSheetDialogRef.current = { kind: 'delete', target: message };
        },
      });
    }
    return actions;
  }

  function handleScroll(event: NativeSyntheticEvent<NativeScrollEvent>) {
    onScroll(event);
    if (
      isUserInteracting() &&
      event.nativeEvent.contentOffset.y < 80 &&
      hasMore &&
      !loadingMore
    ) {
      unstick();
      onLoadMore();
    }
  }

  const renderItem = useCallback(
    ({ item }: { item: RoomFeedItem }) =>
      item.kind === 'date' ? (
        <View className="items-center py-1">
          <Text
            className="rounded-full px-3 py-0.5 text-xs text-white"
            style={{ backgroundColor: 'rgba(0,0,0,0.35)' }}
          >
            {dateFormatter(item.createdAt)}
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
            onResendAudio={onResendAudio}
          />
        </View>
      ),
    [
      dateFormatter,
      highlightedId,
      onOpenProfile,
      onOpenUser,
      insertMention,
      handleLongPressMessage,
      scrollToMessage,
      setReactionsTargetId,
      onResendImage,
      onResendAudio,
    ],
  );

  return (
    <View className="flex-1">
      <RoomReactionNotice />
      <RoomReactionBalloons />
      {status !== 'joined' && (
        <View className="bg-black/5 py-1.5">
          <Text className="text-center text-sm text-ola-ink-soft">
            {status === 'connecting'
              ? t('room.connecting')
              : t('room.joinError')}
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
        {rendered && (
          <FlashList
            ref={listRef}
            data={feed}
            extraData={foregroundEpoch}
            keyExtractor={item => item.key}
            getItemType={item => item.kind}
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
            contentContainerClassName="p-3"
            onContentSizeChange={onContentSizeChange}
            onLayout={onListLayout}
            ListHeaderComponent={
              loadingMore ? (
                <Text
                  className="py-1 text-center text-xs"
                  style={{ color: 'rgba(0,0,0,0.4)' }}
                >
                  {t('common.loading')}
                </Text>
              ) : null
            }
            renderItem={renderItem}
          />
        )}
      </View>

      {replyTarget != null && (
        <View
          className="flex-row items-center gap-2 bg-black/5 px-3 py-1.5"
          style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
        >
          <View className="h-8 w-0.5 rounded bg-ola-primary" />
          <View className="min-w-0 flex-1">
            <Text
              numberOfLines={1}
              className="text-xs font-semibold text-ola-primary"
            >
              {t('room.replyingTo', { name: replyTarget.senderName ?? '' })}
            </Text>
            <RichTextView
              content={replyExcerpt(t, replyTarget)}
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
            <Text className="text-lg text-ola-ink-soft">×</Text>
          </Pressable>
        </View>
      )}

      <RoomComposerBar
        ref={composerRef}
        disabled={!canSend}
        onBeforeSend={pinOnNextContent}
        onSendText={onSend}
        onSendImage={onSendImage}
        onSendAudio={onSendAudio}
      />

      <MessageActionSheet
        visible={actionTarget != null}
        anchor={actionTarget?.anchor ?? null}
        preview={
          actionTarget != null ? (
            <View
              style={{
                alignSelf: actionTarget.isOwn ? 'flex-end' : 'flex-start',
              }}
            >
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
        showReactions={
          actionTarget != null &&
          actionTarget.message.senderId !== currentUserId
        }
        onReact={type => {
          if (actionTarget != null) onReact(actionTarget.message.id, type);
        }}
        onClose={() => {
          suspendRef.current = false;
          setActionTarget(null);
          if (Platform.OS !== 'ios')
            requestAnimationFrame(openPendingSheetDialog);
        }}
        onDismiss={openPendingSheetDialog}
      />

      <RoomReactionsDialog
        visible={reactionsTargetId != null}
        reactions={
          reactionsTargetId != null
            ? messageById.get(reactionsTargetId)?.reactions
            : undefined
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
            onDeleteMessage(target.id).catch(() =>
              pushToast('error', t('common.error')),
            );
          }
        }}
        onCancel={() => setDeleteTarget(null)}
      />

      <ConfirmDialog
        visible={blockTarget != null}
        danger
        title={t('room.blockTitle')}
        message={t('room.blockConfirm', {
          name: blockTarget?.senderName ?? '',
        })}
        confirmLabel={t('room.actionBlock')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => {
          const target = blockTarget;
          setBlockTarget(null);
          if (target != null) {
            pendingBlockCommitRef.current = target;
            if (Platform.OS !== 'ios')
              requestAnimationFrame(commitPendingBlock);
          }
        }}
        onCancel={() => {
          pendingBlockCommitRef.current = null;
          setBlockTarget(null);
        }}
        onDismiss={commitPendingBlock}
      />
    </View>
  );
}

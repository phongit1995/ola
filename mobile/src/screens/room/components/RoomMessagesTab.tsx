import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  AppState,
  NativeSyntheticEvent,
  Pressable,
  NativeScrollEvent,
  useWindowDimensions,
  View,
} from 'react-native';
import Clipboard from '@react-native-clipboard/clipboard';
import { FlashList } from '@shopify/flash-list';
import { useStickyBottomList } from '@hooks/useStickyBottomList';
import { useTabSwipeGesture } from '@hooks/useTabSwipeGesture';
import type {
  GroupedMessage,
  NativeUploadFile,
  ReactionType,
  RoomAudioSendResult,
  RoomChatStatus,
  RoomFeedItem,
  RoomMessage,
} from '@ola/shared/types';
import {
  buildRoomFeed,
  createDateSeparatorFormatter,
  filterVisibleRoomMessages,
} from '@ola/shared/lib';
import { REPORT_TARGET_TYPE, ROOM_CHAT_STATUS } from '@ola/shared/constants';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import {
  RoomBlockLimitError,
  useRoomFilterStore,
} from '@ola/shared/stores/room/roomFilterStore';
import { useRoomChatStore } from '@ola/shared/stores/room/roomChatStore';
import { ChatWallpaper } from '@components/ChatWallpaper';
import { CHAT_BG } from '@screens/chat/constants';
import { ChatText as Text } from '@components/ui/ChatText';
import { RichTextView } from '@components/ui/RichTextView';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ReportDialog } from '@components/ui/ReportDialog';
import { SelectTextDialog } from '@components/chat/SelectTextDialog';
import { replyExcerpt, roomMessageAbilities } from '../utils';
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
import { useTimedHighlight } from '@ola/shared/stores/useTimedHighlight';
import { useAfterDismiss } from '@hooks/useAfterDismiss';

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
  onSwipeRight?: () => void;
}

const LOAD_OLDER_VIEWPORTS = 1.5;
const LOAD_OLDER_MIN_DISTANCE = 600;

function feedItemKey(item: RoomFeedItem): string {
  if (item.kind !== 'group') return item.key;
  return item.messages[item.messages.length - 1]?.key ?? item.key;
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
  onSwipeRight,
}: RoomMessagesTabProps) {
  const { t } = useTranslation();
  const swipeHandlers = useTabSwipeGesture({ onSwipeRight });
  const { width: windowWidth } = useWindowDimensions();
  const pushToast = useToastStore(s => s.push);
  const setPinnedToBottom = useRoomChatStore(s => s.setPinnedToBottom);
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
  const [reportTarget, setReportTarget] = useState<RoomMessage | null>(null);
  const [selectTextTarget, setSelectTextTarget] = useState<string | null>(null);
  const [reactionsTargetId, setReactionsTargetId] = useState<string | null>(
    null,
  );
  const { highlightedId, highlight } = useTimedHighlight();
  const sheetFollowUp = useAfterDismiss();
  const blockFollowUp = useAfterDismiss();
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
  } = useStickyBottomList<RoomFeedItem>({ onStickChange: setPinnedToBottom });
  const composerRef = useRef<RoomComposerHandle>(null);
  const wasStuckBeforeBackgroundRef = useRef(true);
  const [foregroundEpoch, setForegroundEpoch] = useState(0);

  const canSend = status === ROOM_CHAT_STATUS.joined;
  const dateFormatter = useMemo(
    () => createDateSeparatorFormatter(language),
    [language],
  );
  const feed = useMemo(
    () =>
      buildRoomFeed(
        filterVisibleRoomMessages(messages, blockedUserIds),
        currentUserId,
        { omitLeadingDate: hasMore },
      ),
    [messages, currentUserId, blockedUserIds, hasMore],
  );
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

  const commitBlock = useCallback((target: RoomMessage) => {
    blockUser(target.senderId, {
      userId: target.senderId,
      username: target.senderName ?? '',
      avatar: target.senderAvatar,
    })
      .then(() => pushToast('success', t('room.blockSuccess')))
      .catch((error: unknown) =>
        pushToast(
          'error',
          error instanceof RoomBlockLimitError ? t('room.blockLimit') : t('common.error'),
        ),
      );
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
      highlight(id);
    },
    [feed, pushToast, t, listRef, unstick, highlight],
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
      icon: 'copy',
      onSelect: () => copyMessage(message.content),
    };
    const selectTextAction: MessageSheetAction = {
      key: 'selectText',
      label: t('chat.actionSelectText'),
      icon: 'selectText',
      onSelect: () =>
        sheetFollowUp.schedule(() => setSelectTextTarget(message.content)),
    };
    if (!isOwn) {
      actions.push({
        key: 'reply',
        label: t('room.actionReply'),
        icon: 'reply',
        onSelect: () => onSetReplyTarget(message),
      });
      if (canCopy) actions.push(copyAction, selectTextAction);
      actions.push({
        key: 'report',
        label: t('room.actionReport'),
        icon: 'report',
        onSelect: () => sheetFollowUp.schedule(() => setReportTarget(message)),
      });
      actions.push({
        key: 'block',
        label: t('room.actionBlock'),
        icon: 'block',
        destructive: true,
        onSelect: () => sheetFollowUp.schedule(() => setBlockTarget(message)),
      });
    } else {
      if (canCopy) actions.push(copyAction, selectTextAction);
      actions.push({
        key: 'delete',
        label: t('chat.actionDelete'),
        icon: 'delete',
        destructive: true,
        onSelect: () => sheetFollowUp.schedule(() => setDeleteTarget(message)),
      });
    }
    return actions;
  }

  function handleScroll(event: NativeSyntheticEvent<NativeScrollEvent>) {
    onScroll(event);
    const { contentOffset, layoutMeasurement } = event.nativeEvent;
    const prefetchDistance = Math.max(
      LOAD_OLDER_MIN_DISTANCE,
      layoutMeasurement.height * LOAD_OLDER_VIEWPORTS,
    );
    if (
      isUserInteracting() &&
      contentOffset.y < prefetchDistance &&
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
    <View className="flex-1" style={{ backgroundColor: CHAT_BG }}>
      <ChatWallpaper />
      <RoomReactionNotice />
      <RoomReactionBalloons />
      {status !== ROOM_CHAT_STATUS.joined && (
        <View className="bg-black/5 py-1.5">
          <Text className="text-center text-sm text-ola-ink-soft">
            {status === ROOM_CHAT_STATUS.connecting
              ? t('room.connecting')
              : t('room.joinError')}
          </Text>
        </View>
      )}

      <View className="flex-1" {...swipeHandlers}>
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
              keyExtractor={feedItemKey}
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
              renderItem={renderItem}
            />
          )}
          {loadingMore && (
            <View
              pointerEvents="none"
              className="absolute left-0 right-0 top-2 items-center"
            >
              <Text
                className="rounded-full px-3 py-0.5 text-xs text-white"
                style={{ backgroundColor: 'rgba(0,0,0,0.35)' }}
              >
                {t('common.loading')}
              </Text>
            </View>
          )}
        </View>
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
            <RoomBubbleBody
              message={actionTarget.grouped}
              isOwn={actionTarget.isOwn}
              position={actionTarget.grouped.position}
              onMention={() => undefined}
            />
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
          sheetFollowUp.runAfterClose();
        }}
        onDismiss={sheetFollowUp.onDismiss}
      />

      {reportTarget != null && (
        <ReportDialog
          target={{
            type: REPORT_TARGET_TYPE.roomMessage,
            id: reportTarget.id,
            contextId: reportTarget.roomId,
          }}
          onClose={() => setReportTarget(null)}
        />
      )}

      <SelectTextDialog
        text={selectTextTarget}
        onCopyAll={copyMessage}
        onClose={() => setSelectTextTarget(null)}
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
            blockFollowUp.schedule(() => commitBlock(target));
            blockFollowUp.runAfterClose();
          }
        }}
        onCancel={() => {
          blockFollowUp.cancel();
          setBlockTarget(null);
        }}
        onDismiss={blockFollowUp.onDismiss}
      />
    </View>
  );
}

import { useCallback, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Image,
  NativeSyntheticEvent,
  Pressable,
  Text,
  TextInput,
  NativeScrollEvent,
  View,
} from 'react-native';
import { FlashList, type FlashListRef } from '@shopify/flash-list';
import type { ReactionType, RoomMessage } from '@ola/shared/types';
import { createTimeFormatter } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { kulImageForText, kulToken } from '../../lib/kul';
import { ConfirmDialog } from '../../components/ConfirmDialog';
import { buildRoomFeed, type RoomFeedItem } from './messageGroups';
import { RoomMessageGroup } from './RoomMessageGroup';
import { SmileyKulPanel } from './SmileyKulPanel';
import { MessageActionSheet, type MessageSheetAction } from './MessageActionSheet';
import { RoomReactionsDialog } from './RoomReactionsDialog';
import type { RoomChatStatus } from '@ola/shared/stores/roomChatStore';

const likeIcon = require('../../assets/icons/chat/smiley/smiley_35.png');
const smileyIcon = require('../../assets/icons/chat/ic_smiley.png');
const smileyIconActive = require('../../assets/icons/chat/ic_smiley_selected.png');
const kulIcon = require('../../assets/icons/chat/ic_kul.png');
const kulIconActive = require('../../assets/icons/chat/ic_kul_selected.png');
const replyActionIcon = require('../../assets/icons/me/ic_action_reply_gray.png');
const deleteActionIcon = require('../../assets/icons/chat/ic_menu_delete.png');

interface RoomMessagesTabProps {
  currentUserId: string;
  language: string;
  messages: RoomMessage[];
  status: RoomChatStatus;
  hasMore: boolean;
  loadingMore: boolean;
  replyTarget: RoomMessage | null;
  onSend: (content: string) => Promise<void>;
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
  const [draft, setDraft] = useState('');
  const [openTab, setOpenTab] = useState<'smiley' | 'kul' | null>(null);
  const [actionTarget, setActionTarget] = useState<RoomMessage | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<RoomMessage | null>(null);
  const [reactionsTargetId, setReactionsTargetId] = useState<string | null>(null);
  const [highlightedId, setHighlightedId] = useState<string | null>(null);
  const [pendingSelection, setPendingSelection] = useState<{ start: number; end: number } | null>(
    null
  );
  const listRef = useRef<FlashListRef<RoomFeedItem>>(null);
  const stickToBottomRef = useRef(true);
  const highlightTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const selectionRef = useRef<{ start: number; end: number }>({ start: 0, end: 0 });

  function applyDraft(next: string, caret: number) {
    selectionRef.current = { start: caret, end: caret };
    setDraft(next);
    setPendingSelection({ start: caret, end: caret });
  }

  function insertAtCursor(text: string) {
    const start = Math.max(0, Math.min(selectionRef.current.start, draft.length));
    const end = Math.max(start, Math.min(selectionRef.current.end, draft.length));
    applyDraft(draft.slice(0, start) + text + draft.slice(end), start + text.length);
  }

  function backspaceAtCursor() {
    const start = Math.max(0, Math.min(selectionRef.current.start, draft.length));
    const end = Math.max(start, Math.min(selectionRef.current.end, draft.length));
    if (start === end) {
      if (start === 0) return;
      applyDraft(draft.slice(0, start - 1) + draft.slice(end), start - 1);
    } else {
      applyDraft(draft.slice(0, start) + draft.slice(end), start);
    }
  }

  const canSend = status === 'joined';
  const timeFormatter = useMemo(() => createTimeFormatter(language), [language]);
  const feed = useMemo(() => buildRoomFeed(messages, currentUserId), [messages, currentUserId]);
  const messageById = useMemo(() => new Map(messages.map((item) => [item.id, item])), [messages]);

  const scrollToEnd = useCallback(() => {
    if (stickToBottomRef.current) {
      requestAnimationFrame(() => listRef.current?.scrollToEnd({ animated: false }));
    }
  }, []);

  async function sendText(text: string) {
    const trimmed = text.trim();
    if (trimmed === '' || !canSend) return;
    stickToBottomRef.current = true;
    applyDraft('', 0);
    setOpenTab(null);
    try {
      await onSend(trimmed);
    } catch {
      applyDraft(trimmed, trimmed.length);
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
  }, []);

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

  function sheetActions(message: RoomMessage): MessageSheetAction[] {
    if (message.senderId !== currentUserId) {
      return [
        {
          key: 'reply',
          label: t('room.actionReply'),
          icon: replyActionIcon,
          onSelect: () => onSetReplyTarget(message),
        },
      ];
    }
    return [
      {
        key: 'delete',
        label: t('chat.actionDelete'),
        icon: deleteActionIcon,
        destructive: true,
        onSelect: () => setDeleteTarget(message),
      },
    ];
  }

  function handleScroll(event: NativeSyntheticEvent<NativeScrollEvent>) {
    const { contentOffset, contentSize, layoutMeasurement } = event.nativeEvent;
    const distanceFromBottom = contentSize.height - contentOffset.y - layoutMeasurement.height;
    stickToBottomRef.current = distanceFromBottom < 80;
    if (contentOffset.y < 80 && hasMore && !loadingMore) onLoadMore();
  }

  function replyExcerpt(message: RoomMessage): string {
    return kulImageForText(message.content) != null ? t('room.replySticker') : message.content;
  }

  const isTyping = draft.trim() !== '';

  return (
    <View className="flex-1">
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
                onLongPressMessage={(id) => setActionTarget(messageById.get(id) ?? null)}
                onQuoteClick={scrollToMessage}
                onShowReactions={setReactionsTargetId}
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
              {replyExcerpt(replyTarget)}
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
          onPress={() => setOpenTab((current) => (current === 'smiley' ? null : 'smiley'))}
          className="h-9 w-9 items-center justify-center"
          style={{ opacity: openTab === 'smiley' ? 1 : 0.6 }}
        >
          <Image
            source={openTab === 'smiley' ? smileyIconActive : smileyIcon}
            style={{ width: 24, height: 24 }}
            resizeMode="contain"
          />
        </Pressable>
        <Pressable
          onPress={() => setOpenTab((current) => (current === 'kul' ? null : 'kul'))}
          className="h-9 w-9 items-center justify-center"
          style={{ opacity: openTab === 'kul' ? 1 : 0.6 }}
        >
          <Image
            source={openTab === 'kul' ? kulIconActive : kulIcon}
            style={{ width: 24, height: 24 }}
            resizeMode="contain"
          />
        </Pressable>
        <TextInput
          className="max-h-28 min-h-9 flex-1 rounded-2xl px-3 py-2 text-base"
          style={{
            color: 'rgba(0,0,0,0.87)',
            textAlignVertical: 'center',
            borderWidth: 1,
            borderColor: 'rgba(0,0,0,0.12)',
          }}
          placeholder={t('room.chatInputHint')}
          placeholderTextColor="rgba(0,0,0,0.38)"
          multiline
          editable={canSend}
          value={draft}
          selection={pendingSelection ?? undefined}
          onSelectionChange={(event) => {
            selectionRef.current = event.nativeEvent.selection;
            if (pendingSelection != null) setPendingSelection(null);
          }}
          onChangeText={setDraft}
          onFocus={() => setOpenTab(null)}
        />
        {isTyping ? (
          <Pressable
            onPress={() => void sendText(draft)}
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

      {openTab != null && canSend && (
        <SmileyKulPanel
          tab={openTab}
          onPickEmoji={(code) => insertAtCursor(code)}
          onBackspace={backspaceAtCursor}
          onSendKul={(index) => {
            void sendText(kulToken(index));
          }}
        />
      )}

      <MessageActionSheet
        visible={actionTarget != null}
        actions={actionTarget != null ? sheetActions(actionTarget) : []}
        showReactions={actionTarget != null && actionTarget.senderId !== currentUserId}
        onReact={(type) => {
          if (actionTarget != null) onReact(actionTarget.id, type);
        }}
        onClose={() => setActionTarget(null)}
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
    </View>
  );
}

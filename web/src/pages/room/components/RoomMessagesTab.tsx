import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { ReactionType, RoomMessage } from '@app-types';
import { kulImageForText, SmileyText, toast } from '@lib';
import { useStickyScroll } from '@hooks';
import {
  ConfirmDialog,
  DateSeparator,
  MessageActionSheet,
  type MessageSheetAction,
} from '@components';
import replyActionIcon from '@/assets/icons/me/ic_action_reply_gray.png';
import copyActionIcon from '@/assets/icons/chat/ic_menu_copy.svg';
import deleteActionIcon from '@/assets/icons/chat/ic_menu_delete.png';
import blockActionIcon from '@/assets/icons/chat/ic_menu_block.svg';
import { buildRoomFeed } from '../messageGroups';
import { RoomMessageGroup } from './RoomMessageGroup';
import { RoomComposerBar, type RoomComposerHandle } from './RoomComposerBar';
import { RoomReactionsDialog } from './RoomReactionsDialog';
import { RoomReactionNotice } from './RoomReactionNotice';
import type { RoomChatStatus } from '@/store/roomChatStore';
import { useRoomFilterStore } from '../roomFilterStore';

interface RoomMessagesTabProps {
  currentUserId: string;
  messages: RoomMessage[];
  status: RoomChatStatus;
  active: boolean;
  visible: boolean;
  hasMore: boolean;
  loadingMore: boolean;
  replyTarget: RoomMessage | null;
  onSend: (content: string) => Promise<void>;
  onSendImage: (file: File) => Promise<void>;
  onResendImage: (id: string) => void;
  onLoadMore: () => void;
  onOpenProfile?: (nick: string, color: string) => void;
  onSetReplyTarget: (message: RoomMessage) => void;
  onClearReplyTarget: () => void;
  onReact: (messageId: string, type: ReactionType) => void;
  onDeleteMessage: (messageId: string) => Promise<void>;
}

export function RoomMessagesTab({
  currentUserId,
  messages,
  status,
  active,
  visible,
  hasMore,
  loadingMore,
  replyTarget,
  onSend,
  onSendImage,
  onResendImage,
  onLoadMore,
  onOpenProfile,
  onSetReplyTarget,
  onClearReplyTarget,
  onReact,
  onDeleteMessage,
}: RoomMessagesTabProps) {
  const { t } = useTranslation();
  const blockedUserIds = useRoomFilterStore((s) => s.blockedUserIds);
  const blockUser = useRoomFilterStore((s) => s.blockUser);

  const [actionTarget, setActionTarget] = useState<{
    message: RoomMessage;
    anchor: DOMRect | null;
  } | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<RoomMessage | null>(null);
  const [blockTarget, setBlockTarget] = useState<RoomMessage | null>(null);
  const [reactionsTargetId, setReactionsTargetId] = useState<string | null>(null);
  const [highlightedId, setHighlightedId] = useState<string | null>(null);
  const composerRef = useRef<RoomComposerHandle>(null);
  const highlightTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  const messageById = useMemo(() => new Map(messages.map((item) => [item.id, item])), [messages]);
  const { scrollRef, handleScroll, pin, unpin, scrollToBottomIfPinned } = useStickyScroll({
    count: messages.length,
    lastId: messages[messages.length - 1]?.id ?? null,
    hasMore,
    loadingMore,
    onLoadMore,
    enabled: active && visible,
    loadMoreAtTop: 80,
  });

  useEffect(() => {
    return () => {
      if (highlightTimerRef.current != null) clearTimeout(highlightTimerRef.current);
    };
  }, []);

  useEffect(() => {
    scrollToBottomIfPinned();
  }, [active, visible, scrollToBottomIfPinned]);

  const quickMention = useCallback((name: string) => composerRef.current?.insertMention(name), []);

  useEffect(() => {
    if (replyTarget != null) composerRef.current?.focus();
  }, [replyTarget]);

  const handleLongPressMessage = useCallback(
    (id: string, anchor: DOMRect | null) => {
      const message = messageById.get(id);
      if (message != null) setActionTarget({ message, anchor });
    },
    [messageById]
  );

  const showReactions = useCallback((id: string) => setReactionsTargetId(id), []);

  const scrollToMessage = useCallback(
    (id: string) => {
      const element = scrollRef.current?.querySelector(`[data-message-id="${CSS.escape(id)}"]`);
      if (element == null) {
        toast.error(t('room.replyNotFound'));
        return;
      }
      unpin();
      element.scrollIntoView({ behavior: 'smooth', block: 'center' });
      setHighlightedId(id);
      if (highlightTimerRef.current != null) clearTimeout(highlightTimerRef.current);
      highlightTimerRef.current = setTimeout(() => setHighlightedId(null), 1500);
    },
    [t, unpin, scrollRef]
  );

  async function copyMessage(content: string) {
    try {
      await navigator.clipboard.writeText(content);
      toast.success(t('room.copied'));
    } catch {
      toast.error(t('common.error'));
    }
  }

  function isCopyableText(message: RoomMessage): boolean {
    return (
      message.type !== 'image' &&
      kulImageForText(message.content) == null &&
      message.content.trim() !== ''
    );
  }

  function sheetActions(message: RoomMessage): MessageSheetAction[] {
    const actions: MessageSheetAction[] = [];
    const copyAction: MessageSheetAction = {
      key: 'copy',
      label: t('room.actionCopy'),
      icon: copyActionIcon,
      onSelect: () => void copyMessage(message.content),
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
        icon: blockActionIcon,
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

  function replyExcerpt(message: RoomMessage): string {
    if (message.type === 'image') return t('room.replyImage');
    return kulImageForText(message.content) != null ? t('room.replySticker') : message.content;
  }

  const feed = useMemo(() => {
    const blocked = new Set(blockedUserIds);
    const visible =
      blocked.size === 0 ? messages : messages.filter((item) => !blocked.has(item.senderId));
    return buildRoomFeed(visible, currentUserId);
  }, [messages, currentUserId, blockedUserIds]);

  return (
    <div className={`relative flex flex-1 flex-col overflow-hidden ${active ? '' : 'hidden'}`}>
      <RoomReactionNotice />
      {status !== 'joined' && (
        <div className="bg-black/5 py-1.5 text-center text-sm text-black/54">
          {status === 'connecting' ? t('room.connecting') : t('room.joinError')}
        </div>
      )}

      <div
        ref={scrollRef}
        onScroll={handleScroll}
        className="flex flex-1 flex-col gap-2 overflow-y-auto p-3"
      >
        {loadingMore && (
          <div className="shrink-0 py-1 text-center text-xs text-black/40">{t('common.loading')}</div>
        )}
        {feed.map((item) =>
          item.kind === 'date' ? (
            <DateSeparator key={item.key} iso={item.createdAt} />
          ) : (
            <RoomMessageGroup
              key={item.key}
              group={item}
              highlightedId={highlightedId}
              onOpenProfile={onOpenProfile}
              onQuickMention={quickMention}
              onLongPressMessage={handleLongPressMessage}
              onQuoteClick={scrollToMessage}
              onShowReactions={showReactions}
              onResendImage={onResendImage}
            />
          )
        )}
      </div>

      {replyTarget != null && (
        <div className="flex shrink-0 items-center gap-2 border-t border-black/12 bg-black/3 px-3 py-1.5">
          <span className="h-8 w-0.5 shrink-0 rounded bg-ola-primary" />
          {replyTarget.type === 'image' && replyTarget.imageUrl != null && replyTarget.imageUrl !== '' && (
            <img src={replyTarget.imageUrl} alt="" className="h-8 w-8 shrink-0 rounded object-cover" />
          )}
          <span className="min-w-0 flex-1">
            <span className="block truncate text-xs font-semibold text-ola-primary">
              {t('room.replyingTo', { name: replyTarget.senderName ?? '' })}
            </span>
            <span className="block truncate text-xs text-black/54">
              <SmileyText text={replyExcerpt(replyTarget)} />
            </span>
          </span>
          <button
            type="button"
            aria-label={t('dialog.cancel')}
            onClick={onClearReplyTarget}
            className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full text-lg text-black/54 hover:bg-black/5"
          >
            ×
          </button>
        </div>
      )}

      <RoomComposerBar
        ref={composerRef}
        disabled={status !== 'joined'}
        onBeforeSend={pin}
        onSendText={onSend}
        onSendImage={onSendImage}
      />

      {actionTarget != null && (
        <MessageActionSheet
          actions={sheetActions(actionTarget.message)}
          anchor={actionTarget.anchor}
          showReactions={actionTarget.message.senderId !== currentUserId}
          onReact={(type) => onReact(actionTarget.message.id, type)}
          onClose={() => setActionTarget(null)}
        />
      )}

      <RoomReactionsDialog
        open={reactionsTargetId != null}
        reactions={
          reactionsTargetId != null ? messageById.get(reactionsTargetId)?.reactions : undefined
        }
        onClose={() => setReactionsTargetId(null)}
      />

      <ConfirmDialog
        open={deleteTarget != null}
        danger
        title={t('chat.deleteTitle')}
        message={t('chat.deleteConfirm')}
        confirmLabel={t('dialog.delete')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => {
          const target = deleteTarget;
          setDeleteTarget(null);
          if (target != null) {
            onDeleteMessage(target.id).catch(() => toast.error(t('common.error')));
          }
        }}
        onCancel={() => setDeleteTarget(null)}
      />

      <ConfirmDialog
        open={blockTarget != null}
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
            toast.success(t('room.blockSuccess'));
          }
        }}
        onCancel={() => setBlockTarget(null)}
      />
    </div>
  );
}

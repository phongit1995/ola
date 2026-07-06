import { useCallback, useEffect, useLayoutEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { ReactionType, RoomMessage } from '@app-types';
import { compressImageForUpload, ImageTooLargeError, kulImageForText, kulToken, toast } from '@lib';
import { useLongPress } from '@hooks';
import {
  ConfirmDialog,
  DateSeparator,
  MessageActionSheet,
  type MessageSheetAction,
  SmileyGroupPanel,
  SmileyInput,
  type SmileyInputHandle,
} from '@components';
import likeIcon from '@/assets/icons/chat/smiley_35.png';
import replyActionIcon from '@/assets/icons/me/ic_action_reply_gray.png';
import copyActionIcon from '@/assets/icons/chat/ic_menu_copy.svg';
import deleteActionIcon from '@/assets/icons/chat/ic_menu_delete.png';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import smileyIconActive from '@/assets/icons/chat/ic_smiley_selected.png';
import photoIcon from '@/assets/icons/chat/ic_local.png';
import { buildRoomFeed } from '../messageGroups';
import { RoomMessageGroup } from './RoomMessageGroup';
import { RoomReactionsDialog } from './RoomReactionsDialog';
import { RoomReactionNotice } from './RoomReactionNotice';
import { useAttachPanel } from './useAttachPanel';
import type { RoomChatStatus } from '@/store/roomChatStore';

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
  onLoadMore,
  onOpenProfile,
  onSetReplyTarget,
  onClearReplyTarget,
  onReact,
  onDeleteMessage,
}: RoomMessagesTabProps) {
  const { t } = useTranslation();

  const [draft, setDraft] = useState('');
  const { open: attachOpen, areaRef: composerAreaRef, toggle: toggleAttachPanel, close: closeAttachPanel } =
    useAttachPanel();
  const [actionTarget, setActionTarget] = useState<{
    message: RoomMessage;
    anchor: DOMRect | null;
  } | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<RoomMessage | null>(null);
  const [reactionsTargetId, setReactionsTargetId] = useState<string | null>(null);
  const [highlightedId, setHighlightedId] = useState<string | null>(null);
  const [pendingImages, setPendingImages] = useState<{ id: string; file: File; url: string }[]>([]);
  const [sendingImages, setSendingImages] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const composerRef = useRef<SmileyInputHandle>(null);
  const draftRef = useRef(draft);
  const stickToBottomRef = useRef(true);
  const pendingPrependRef = useRef(false);
  const prevScrollHeightRef = useRef(0);
  const suppressLikeClick = useRef(false);
  const highlightTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const imageIdRef = useRef(0);
  const pendingImagesRef = useRef(pendingImages);
  useEffect(() => {
    pendingImagesRef.current = pendingImages;
  }, [pendingImages]);
  useEffect(
    () => () => {
      pendingImagesRef.current.forEach((image) => URL.revokeObjectURL(image.url));
    },
    []
  );
  const likeLongPress = useLongPress(() => {
    suppressLikeClick.current = true;
    void sendText('(Y)');
  });

  const messageById = useMemo(() => new Map(messages.map((item) => [item.id, item])), [messages]);

  useEffect(() => {
    return () => {
      if (highlightTimerRef.current != null) clearTimeout(highlightTimerRef.current);
    };
  }, []);

  useEffect(() => {
    draftRef.current = draft;
  }, [draft]);

  useLayoutEffect(() => {
    const element = scrollRef.current;
    if (element == null || !pendingPrependRef.current) return;
    element.scrollTop = element.scrollHeight - prevScrollHeightRef.current;
    pendingPrependRef.current = false;
  }, [messages]);

  useEffect(() => {
    if (!active || !visible) return;
    if (pendingPrependRef.current) return;
    if (stickToBottomRef.current) {
      scrollRef.current?.scrollTo({ top: scrollRef.current.scrollHeight });
    }
  }, [messages, active, visible]);

  function handleScroll() {
    const element = scrollRef.current;
    if (element == null) return;
    const distanceFromBottom = element.scrollHeight - element.scrollTop - element.clientHeight;
    stickToBottomRef.current = distanceFromBottom < 80;
    if (element.scrollTop < 80 && hasMore && !loadingMore) {
      prevScrollHeightRef.current = element.scrollHeight;
      pendingPrependRef.current = true;
      onLoadMore();
    }
  }

  async function sendText(text: string) {
    const trimmed = text.trim();
    if (trimmed === '' || status !== 'joined') return;
    stickToBottomRef.current = true;
    setDraft('');
    composerRef.current?.reset();
    closeAttachPanel();
    try {
      await onSend(trimmed);
    } catch {
      setDraft(trimmed);
      toast.error(t('room.sendError'));
    }
  }

  async function handleFileChange(event: React.ChangeEvent<HTMLInputElement>) {
    const files = Array.from(event.target.files ?? []);
    event.target.value = '';
    if (files.length === 0 || status !== 'joined') return;
    closeAttachPanel();
    for (const file of files) {
      try {
        const prepared = await compressImageForUpload(file);
        const url = URL.createObjectURL(prepared);
        imageIdRef.current += 1;
        const id = String(imageIdRef.current);
        setPendingImages((current) => [...current, { id, file: prepared, url }]);
      } catch (error) {
        toast.error(error instanceof ImageTooLargeError ? t('chat.imageTooLarge') : t('room.sendError'));
      }
    }
  }

  function removePendingImage(id: string) {
    setPendingImages((current) => {
      const target = current.find((image) => image.id === id);
      if (target != null) URL.revokeObjectURL(target.url);
      return current.filter((image) => image.id !== id);
    });
  }

  function clearPendingImages() {
    setPendingImages((current) => {
      current.forEach((image) => URL.revokeObjectURL(image.url));
      return [];
    });
  }

  async function sendPendingImages() {
    const images = pendingImages;
    if (images.length === 0) return;
    setSendingImages(true);
    stickToBottomRef.current = true;
    for (const image of images) {
      try {
        await onSendImage(image.file);
      } catch {
        toast.error(t('room.sendError'));
      }
      URL.revokeObjectURL(image.url);
    }
    setPendingImages([]);
    setSendingImages(false);
  }

  async function handleSend() {
    if (!canSend || sendingImages) return;
    if (pendingImages.length > 0) {
      await sendPendingImages();
      return;
    }
    if (draft.trim() !== '') void sendText(draft);
  }

  const insertMention = useCallback((name: string) => {
    const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const alreadyTagged = new RegExp(`@${escaped}(?![\\p{L}\\p{N}_])`, 'iu');
    if (!alreadyTagged.test(draftRef.current)) composerRef.current?.insertText(`@${name} `);
    composerRef.current?.focus();
  }, []);

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
      stickToBottomRef.current = false;
      element.scrollIntoView({ behavior: 'smooth', block: 'center' });
      setHighlightedId(id);
      if (highlightTimerRef.current != null) clearTimeout(highlightTimerRef.current);
      highlightTimerRef.current = setTimeout(() => setHighlightedId(null), 1500);
    },
    [t]
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
        onSelect: () => {
          onSetReplyTarget(message);
          composerRef.current?.focus();
        },
      });
      if (isCopyableText(message)) actions.push(copyAction);
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

  const canSend = status === 'joined';
  const isTyping = draft.trim() !== '';
  const feed = useMemo(() => buildRoomFeed(messages, currentUserId), [messages, currentUserId]);

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
              onQuickMention={insertMention}
              onLongPressMessage={handleLongPressMessage}
              onQuoteClick={scrollToMessage}
              onShowReactions={showReactions}
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
              {replyExcerpt(replyTarget)}
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

      <div ref={composerAreaRef} className="shrink-0">
      <div className="flex shrink-0 items-center gap-1 border-t border-black/12 bg-white px-2 py-2">
        <button
          type="button"
          aria-label={t('chat.attachTabSmiley')}
          onClick={toggleAttachPanel}
          className={`flex h-9 w-9 shrink-0 select-none items-center justify-center ${attachOpen ? 'opacity-100' : 'opacity-60'}`}
        >
          <img src={attachOpen ? smileyIconActive : smileyIcon} alt="" className="h-6 w-6 object-contain" />
        </button>
        <button
          type="button"
          aria-label={t('chat.attachPickImage')}
          onClick={() => fileInputRef.current?.click()}
          disabled={!canSend}
          className="flex h-9 w-9 shrink-0 select-none items-center justify-center opacity-60 disabled:opacity-40"
        >
          <img src={photoIcon} alt="" className="h-6 w-6 object-contain" />
        </button>
        {pendingImages.length > 0 ? (
          <div className="flex min-h-9 flex-1 items-center gap-2 overflow-x-auto py-1">
            {pendingImages.map((image) => (
              <div key={image.id} className="relative shrink-0">
                <img src={image.url} alt="" className="h-11 w-11 rounded-lg object-cover" />
                <button
                  type="button"
                  aria-label={t('dialog.cancel')}
                  onClick={() => removePendingImage(image.id)}
                  disabled={sendingImages}
                  className="absolute -top-1.5 -right-1.5 flex h-5 w-5 items-center justify-center rounded-full bg-black/60 text-xs leading-none text-white disabled:opacity-40"
                >
                  ×
                </button>
              </div>
            ))}
            <button
              type="button"
              onClick={clearPendingImages}
              disabled={sendingImages}
              className="ml-1 h-9 shrink-0 rounded-full border border-black/12 px-3 text-sm font-medium text-black/54 hover:bg-black/5 disabled:opacity-40"
            >
              {t('dialog.cancel')}
            </button>
          </div>
        ) : (
          <SmileyInput
            ref={composerRef}
            value={draft}
            onChange={setDraft}
            onEnter={() => void handleSend()}
            onFocus={() => closeAttachPanel()}
            disabled={!canSend}
            placeholder={t('room.chatInputHint')}
            multiline
            className={`max-h-28 min-h-9 flex-1 overflow-y-auto rounded-2xl border border-black/12 px-3 py-2 text-base text-black/87 focus:border-ola-primary ${
              canSend ? '' : 'opacity-50'
            }`}
          />
        )}
        {isTyping || pendingImages.length > 0 ? (
          <button
            type="button"
            onPointerDown={(event) => event.preventDefault()}
            onClick={() => void handleSend()}
            disabled={!canSend || sendingImages}
            className="h-9 shrink-0 rounded-full bg-ola-primary px-4 text-sm font-semibold text-white shadow-sm transition active:scale-95 disabled:opacity-40"
          >
            {t('chat.send')}
          </button>
        ) : (
          <button
            type="button"
            aria-label={t('chat.like')}
            disabled={!canSend}
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
            className="flex h-9 w-9 shrink-0 select-none items-center justify-center disabled:opacity-40"
          >
            <img src={likeIcon} alt="" className="h-7 w-7 object-contain" />
          </button>
        )}
      </div>

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        multiple
        className="hidden"
        onChange={handleFileChange}
      />

      {canSend && (
        <div className={`h-52 shrink-0 border-t border-black/12 bg-white ${attachOpen ? '' : 'hidden'}`}>
          <SmileyGroupPanel
            onPick={(code) => composerRef.current?.insertCode(code, true, false)}
            onSendKul={(index) => {
              void sendText(kulToken(index));
              closeAttachPanel();
            }}
          />
        </div>
      )}
      </div>

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
    </div>
  );
}

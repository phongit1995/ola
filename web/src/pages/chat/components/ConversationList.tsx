import { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog } from '@components';
import type { Conversation } from '@app-types';
import { Avatar } from '@components';
import { SmileyText } from '@lib';
import sentIcon from '@/assets/icons/chat/ic_message_sent.png';
import kulIcon from '@/assets/icons/chat/ic_kul.png';
import { EmptyMessages } from './EmptyMessages';
import { toConversationView, type ConversationView } from '../chatView';

interface ConversationListProps {
  conversations: Conversation[];
  onSelect: (id: string) => void;
  onDelete: (id: string) => void;
}

const SWIPE_TRIGGER = 56;
const SWIPE_MAX = 88;

export function ConversationList({
  conversations,
  onSelect,
  onDelete,
}: ConversationListProps) {
  const { t } = useTranslation();
  const [pendingDelete, setPendingDelete] = useState<ConversationView | null>(null);
  const [deleteArchived, setDeleteArchived] = useState(false);

  function requestDelete(conversation: ConversationView) {
    setDeleteArchived(false);
    setPendingDelete(conversation);
  }

  function confirmDelete() {
    if (pendingDelete != null) onDelete(pendingDelete.id);
    setPendingDelete(null);
  }

  if (conversations.length === 0) return <EmptyMessages />;

  return (
    <>
      <ul>
        {conversations.map((conversation) => (
          <ConversationRow
            key={conversation.id}
            view={toConversationView(conversation)}
            onSelect={onSelect}
            onRequestDelete={requestDelete}
          />
        ))}
      </ul>
      <ConfirmDialog
        open={pendingDelete != null}
        danger
        title={t('dialog.deleteConvTitle')}
        message={t('dialog.deleteConvMessage', { name: pendingDelete?.name ?? '' })}
        confirmLabel={t('dialog.delete')}
        cancelLabel={t('dialog.cancel')}
        checkboxLabel={t('dialog.deleteArchived')}
        checked={deleteArchived}
        onCheckedChange={setDeleteArchived}
        onConfirm={confirmDelete}
        onCancel={() => setPendingDelete(null)}
      />
    </>
  );
}

interface ConversationRowProps {
  view: ConversationView;
  onSelect: (id: string) => void;
  onRequestDelete: (view: ConversationView) => void;
}

function ConversationRow({ view, onSelect, onRequestDelete }: ConversationRowProps) {
  const { t } = useTranslation();
  const unread = view.unread > 0;
  const hasPreview = view.preview !== '' || view.previewIsSticker;
  const previewPrefix = !hasPreview
    ? ''
    : view.fromMe
      ? `${t('chat.youPrefix')}: `
      : view.isGroup && view.senderName
        ? `${view.senderName}: `
        : '';
  const [offset, setOffset] = useState(0);
  const startX = useRef<number | null>(null);
  const swiped = useRef(false);

  function handlePointerDown(event: React.PointerEvent) {
    startX.current = event.clientX;
    swiped.current = false;
  }

  function handlePointerMove(event: React.PointerEvent) {
    if (startX.current == null) return;
    const delta = event.clientX - startX.current;
    if (Math.abs(delta) > 6) swiped.current = true;
    setOffset(Math.min(0, Math.max(delta, -SWIPE_MAX)));
  }

  function handlePointerUp() {
    if (startX.current == null) return;
    const trigger = offset <= -SWIPE_TRIGGER;
    startX.current = null;
    setOffset(0);
    if (trigger) onRequestDelete(view);
  }

  function handleSelect() {
    if (swiped.current) {
      swiped.current = false;
      return;
    }
    onSelect(view.id);
  }

  return (
    <li className="relative overflow-hidden after:absolute after:right-4 after:bottom-0 after:left-4 after:h-px after:bg-black/12">
      {offset < 0 && (
        <span className="absolute inset-y-0 right-0 flex w-[88px] items-center justify-center bg-[#dd4b39] text-sm font-medium text-white">
          {t('dialog.delete')}
        </span>
      )}
      <div
        onPointerDown={handlePointerDown}
        onPointerMove={handlePointerMove}
        onPointerUp={handlePointerUp}
        onPointerCancel={handlePointerUp}
        style={{ transform: `translateX(${offset}px)` }}
        className={`relative flex min-h-[72px] touch-pan-y items-center gap-4 px-4 ${
          unread ? 'bg-ola-primary-light' : 'bg-white/80'
        } ${offset === 0 ? 'transition-transform' : ''}`}
      >
        <button
          type="button"
          onClick={handleSelect}
          className="flex min-w-0 flex-1 items-center gap-4 text-left"
        >
          <Avatar name={view.name} color={view.color} src={view.avatar} />
          <span className="min-w-0 flex-1">
            <span className="flex items-center justify-between gap-2">
              <span className={`truncate text-base text-black/87 ${unread ? 'font-bold' : ''}`}>
                {view.title}
              </span>
              <span
                className={`shrink-0 text-xs whitespace-nowrap ${
                  unread ? 'font-bold text-black/87' : 'text-black/54'
                }`}
              >
                {view.time}
              </span>
            </span>
            <span className="mt-0.5 flex items-center gap-1">
              <span className="min-w-0 flex-1 truncate text-sm text-black/87">
                {previewPrefix}
                {view.previewIsSticker ? (
                  <span className="inline-flex items-center gap-1 align-middle">
                    <img src={kulIcon} alt="" className="h-4 w-4 object-contain" />
                    {t('chat.stickerPreview')}
                  </span>
                ) : (
                  <SmileyText text={view.preview} />
                )}
              </span>
              {view.fromMe &&
                hasPreview &&
                (view.seen ? (
                  <Avatar name={view.name} color={view.color} src={view.avatar} size={16} />
                ) : (
                  <img src={sentIcon} alt="" className="h-3.5 w-3.5 shrink-0 object-contain opacity-60" />
                ))}
            </span>
          </span>
        </button>
        {unread && (
          <span className="flex h-5 min-w-5 shrink-0 items-center justify-center rounded-full bg-ola-accent px-1.5 text-xs font-bold text-white ring-2 ring-white">
            {view.unread}
          </span>
        )}
      </div>
    </li>
  );
}

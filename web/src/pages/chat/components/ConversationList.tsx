import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog } from '@components';
import type { Conversation } from '@app-types';
import { Avatar } from '@components';
import { EmptyMessages } from './EmptyMessages';
import { toConversationView, type ConversationView } from '../chatView';

interface ConversationListProps {
  conversations: Conversation[];
  onSelect: (id: string) => void;
  onDelete: (id: string) => void;
}

export function ConversationList({
  conversations,
  onSelect,
  onDelete,
}: ConversationListProps) {
  const { t } = useTranslation();
  const [pendingDelete, setPendingDelete] = useState<ConversationView | null>(null);
  const [deleteArchived, setDeleteArchived] = useState(false);

  function openDelete(conversation: ConversationView) {
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
        {conversations.map((conversation) => {
          const view = toConversationView(conversation);
          const unread = view.unread > 0;
          return (
            <li
              key={view.id}
              className={`group flex items-center gap-4 border-b border-black/12 px-4 py-3 ${
                unread ? 'bg-ola-primary-light' : 'bg-white/80'
              }`}
            >
              <button
                type="button"
                onClick={() => onSelect(view.id)}
                className="flex min-h-12 min-w-0 flex-1 items-center gap-4 text-left"
              >
                <Avatar name={view.name} color={view.color} src={view.avatar} />
                <span className="min-w-0 flex-1">
                  <span className="flex items-center justify-between gap-2">
                    <span
                      className={`truncate text-base text-black/87 ${unread ? 'font-bold' : ''}`}
                    >
                      {view.name}
                    </span>
                    <span
                      className={`shrink-0 text-xs whitespace-nowrap ${
                        unread ? 'font-bold text-black/87' : 'text-black/54'
                      }`}
                    >
                      {view.time}
                    </span>
                  </span>
                  <span className="mt-0.5 flex items-center gap-2">
                    <span className="min-w-0 flex-1 truncate text-sm text-black/87">
                      {view.preview}
                    </span>
                    {unread && (
                      <span className="flex h-4 min-w-4 items-center justify-center rounded-full bg-ola-accent px-1.5 text-xs font-bold text-white">
                        {view.unread}
                      </span>
                    )}
                  </span>
                </span>
              </button>
              <button
                type="button"
                aria-label={t('dialog.deleteAria', { name: view.name })}
                onClick={() => openDelete(view)}
                className="shrink-0 rounded-full p-2 text-gray-400 opacity-0 transition hover:bg-gray-100 hover:text-[#dd4b39] focus:opacity-100 group-hover:opacity-100"
              >
                <svg viewBox="0 0 24 24" className="h-5 w-5" aria-hidden="true">
                  <path
                    fill="currentColor"
                    d="M6 7h12l-1 13H7L6 7zm3-3h6l1 2H8l1-2zM5 5h14v2H5V5z"
                  />
                </svg>
              </button>
            </li>
          );
        })}
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

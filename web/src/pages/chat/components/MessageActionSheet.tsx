import { createPortal } from 'react-dom';
import { useTranslation } from 'react-i18next';
import { portalRoot } from '@lib';
import type { ReactionType } from '@app-types';
import type { ChatMessage } from '../types';
import { REACTION_EMOJI, REACTION_ORDER } from '../chatView';

interface MessageActionSheetProps {
  message: ChatMessage;
  isOwn: boolean;
  onReact: (type: ReactionType) => void;
  onEdit: () => void;
  onDelete: () => void;
  onClose: () => void;
}

export function MessageActionSheet({
  message,
  isOwn,
  onReact,
  onEdit,
  onDelete,
  onClose,
}: MessageActionSheetProps) {
  const { t } = useTranslation();
  const canEdit = isOwn && message.kind === 'text';

  return createPortal(
    <div className="fixed inset-0 z-[120] flex flex-col justify-end" onClick={onClose}>
      <div className="absolute inset-0 bg-black/40" />
      <div
        className="relative mx-auto w-full max-w-md rounded-t-2xl bg-white pb-[env(safe-area-inset-bottom)]"
        onClick={(event) => event.stopPropagation()}
      >
        <div className="flex items-center justify-around px-2 py-3">
          {REACTION_ORDER.map((type) => (
            <button
              key={type}
              type="button"
              onClick={() => {
                onReact(type);
                onClose();
              }}
              className="flex h-11 w-11 items-center justify-center rounded-full text-2xl transition hover:bg-black/5 active:scale-90"
            >
              {REACTION_EMOJI[type]}
            </button>
          ))}
        </div>

        <div className="border-t border-black/8">
          {canEdit && (
            <button
              type="button"
              onClick={() => {
                onEdit();
                onClose();
              }}
              className="flex w-full items-center px-5 py-3 text-left text-base text-black/87"
            >
              {t('chat.actionEdit')}
            </button>
          )}
          {isOwn && (
            <button
              type="button"
              onClick={() => {
                onDelete();
                onClose();
              }}
              className="flex w-full items-center px-5 py-3 text-left text-base text-ola-error"
            >
              {t('chat.actionDelete')}
            </button>
          )}
          <button
            type="button"
            onClick={onClose}
            className="flex w-full items-center justify-center px-5 py-3 text-base font-medium text-black/54"
          >
            {t('dialog.cancel')}
          </button>
        </div>
      </div>
    </div>,
    portalRoot()
  );
}

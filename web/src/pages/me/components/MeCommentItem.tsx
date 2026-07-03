import { memo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, Avatar } from '@components';
import { colorForName, renderRichText } from '@lib';
import type { PostComment } from '@app-types';

interface MeCommentItemProps {
  comment: PostComment;
  time: string;
  canDelete: boolean;
  onDelete: (id: string) => void;
  onOpenProfile?: (nick: string, color: string) => void;
}

function MeCommentItemComponent({
  comment,
  time,
  canDelete,
  onDelete,
  onOpenProfile,
}: MeCommentItemProps) {
  const { t } = useTranslation();
  const [confirmOpen, setConfirmOpen] = useState(false);
  const name = comment.author?.username ?? '';
  const color = colorForName(name);

  return (
    <>
      <div className="mx-2 mb-2 flex items-start gap-3 rounded-lg bg-white px-4 py-3 shadow-[0_1px_2px_rgba(0,0,0,0.12)]">
      <button type="button" onClick={() => onOpenProfile?.(name, color)} className="shrink-0">
        <Avatar name={name} src={comment.author?.avatar} color={color} size={40} />
      </button>
      <div className="min-w-0 flex-1">
        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={() => onOpenProfile?.(name, color)}
            className="truncate text-sm font-medium text-black/87 hover:underline"
          >
            {name}
          </button>
          <span className="shrink-0 text-xs text-black/40">{time}</span>
        </div>
        <p className="mt-1 text-sm leading-relaxed whitespace-pre-wrap break-words text-black/87">
          {renderRichText(comment.content, (nick) => onOpenProfile?.(nick, colorForName(nick)))}
        </p>
      </div>
      {canDelete && (
        <button
          type="button"
          aria-label={t('me.deleteComment')}
          onClick={() => setConfirmOpen(true)}
          className="shrink-0 px-1 text-xs text-black/40 hover:text-ola-error"
        >
          {t('common.clear')}
        </button>
      )}
      </div>
      <ConfirmDialog
        open={confirmOpen}
        danger
        title={t('me.deleteComment')}
        message={t('me.deleteCommentConfirm')}
        confirmLabel={t('dialog.yes')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => {
          onDelete(comment.id);
          setConfirmOpen(false);
        }}
        onCancel={() => setConfirmOpen(false)}
      />
    </>
  );
}

export const MeCommentItem = memo(MeCommentItemComponent);

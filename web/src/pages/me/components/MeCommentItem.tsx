import { memo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, Avatar } from '@components';
import { colorForName, renderRichText } from '@lib';
import replyIcon from '@/assets/icons/me/ic_action_reply_gray.png';
import type { PostComment } from '@app-types';

interface MeCommentItemProps {
  comment: PostComment;
  time: string;
  canDelete: boolean;
  onDelete: (id: string) => void;
  onReply?: (comment: PostComment) => void;
  onOpenProfile?: (nick: string, color: string) => void;
}

function HeartIcon({ filled }: { filled: boolean }) {
  return (
    <svg
      viewBox="0 0 24 24"
      className="h-[15px] w-[15px]"
      fill={filled ? 'currentColor' : 'none'}
      stroke="currentColor"
      strokeWidth={2}
      strokeLinejoin="round"
      aria-hidden="true"
    >
      <path d="M12 20.3 4.55 12.6a4.6 4.6 0 0 1 6.5-6.5l.95.95.95-.95a4.6 4.6 0 0 1 6.5 6.5L12 20.3Z" />
    </svg>
  );
}

function TrashIcon() {
  return (
    <svg viewBox="0 0 24 24" className="h-4 w-4" fill="currentColor" aria-hidden="true">
      <path d="M9 3h6l1 2h4v2H4V5h4l1-2ZM6 9h12l-1 11a1 1 0 0 1-1 1H8a1 1 0 0 1-1-1L6 9Z" />
    </svg>
  );
}

function MeCommentItemComponent({
  comment,
  time,
  canDelete,
  onDelete,
  onReply,
  onOpenProfile,
}: MeCommentItemProps) {
  const { t } = useTranslation();
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [liked, setLiked] = useState(false);
  const [likeCount, setLikeCount] = useState(0);
  const name = comment.author?.username ?? '';
  const color = colorForName(name);

  function toggleLike() {
    const next = !liked;
    setLiked(next);
    setLikeCount((count) => count + (next ? 1 : -1));
  }

  return (
    <>
      <div className="mx-2 mb-2 rounded-xl bg-white px-3 py-2.5 shadow-[0_1px_2px_rgba(0,0,0,0.10)]">
        <div className="flex items-start gap-2.5">
          <button type="button" onClick={() => onOpenProfile?.(name, color)} className="shrink-0">
            <Avatar name={name} src={comment.author?.avatar} color={color} size={36} />
          </button>
          <div className="min-w-0 flex-1">
            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={() => onOpenProfile?.(name, color)}
                className="truncate text-sm font-semibold text-black/87 hover:underline"
              >
                {name}
              </button>
              <span className="shrink-0 text-xs text-black/40">{time}</span>
              {canDelete && (
                <button
                  type="button"
                  aria-label={t('me.deleteComment')}
                  onClick={() => setConfirmOpen(true)}
                  className="ml-auto shrink-0 text-black/25 transition-colors hover:text-ola-error"
                >
                  <TrashIcon />
                </button>
              )}
            </div>
            <p className="mt-0.5 text-sm leading-relaxed whitespace-pre-wrap break-words text-black/87">
              {renderRichText(comment.content, (nick) => onOpenProfile?.(nick, colorForName(nick)))}
            </p>
            <div className="mt-1.5 flex items-center gap-4">
              {onReply != null && (
                <button
                  type="button"
                  onClick={() => onReply(comment)}
                  className="flex items-center gap-1 text-xs font-medium text-black/45 transition-colors hover:text-ola-primary"
                >
                  <img src={replyIcon} alt="" className="h-3.5 w-3.5 object-contain" />
                  {t('me.reply')}
                </button>
              )}
              <button
                type="button"
                onClick={toggleLike}
                aria-pressed={liked}
                aria-label={t('me.like')}
                className={`ml-auto flex items-center gap-1 text-xs font-medium transition-colors ${
                  liked ? 'text-ola-error' : 'text-black/45 hover:text-ola-error'
                }`}
              >
                <HeartIcon filled={liked} />
                {likeCount > 0 && <span className="tabular-nums">{likeCount}</span>}
              </button>
            </div>
          </div>
        </div>
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

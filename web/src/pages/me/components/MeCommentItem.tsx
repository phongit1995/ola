import { memo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, Avatar, ReportDialog } from '@components';
import { colorForName, renderRichText } from '@lib';
import replyIcon from '@/assets/icons/me/ic_action_reply_gray.png';
import likeIcon from '@/assets/icons/me/ic_like_gray.png';
import likeIconActive from '@/assets/icons/me/ic_like_selected.png';
import type { PostAuthor, PostComment } from '@app-types';
import { MeLikersDialog } from './MeLikersDialog';

function CommentLikerStack({ likers }: { likers: PostAuthor[] }) {
  if (likers.length === 0) return null;
  return (
    <span className="flex -space-x-1.5">
      {likers.slice(0, 3).map((liker) => (
        <span
          key={liker.id}
          className="inline-flex overflow-hidden rounded-full ring-2 ring-white"
        >
          <Avatar
            name={liker.fullName != null && liker.fullName !== '' ? liker.fullName : liker.username}
            src={liker.avatar}
            color={colorForName(liker.username)}
            size={18}
          />
        </span>
      ))}
    </span>
  );
}

interface MeCommentItemProps {
  comment: PostComment;
  time: string;
  canDelete: boolean;
  canReport?: boolean;
  onDelete: (id: string) => void;
  onReply?: (comment: PostComment) => void;
  onToggleLike: (id: string) => void;
  onOpenProfile?: (nick: string, color: string) => void;
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
  canReport = false,
  onDelete,
  onReply,
  onToggleLike,
  onOpenProfile,
}: MeCommentItemProps) {
  const { t } = useTranslation();
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [reportOpen, setReportOpen] = useState(false);
  const [likersOpen, setLikersOpen] = useState(false);
  const liked = comment.liked;
  const likers = comment.topLikers ?? [];
  const name = comment.author?.username ?? '';
  const color = colorForName(name);

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
                  <img src={replyIcon} alt="" className="h-5 w-5 object-contain" />
                  {t('me.reply')}
                </button>
              )}
              {canReport && (
                <button
                  type="button"
                  onClick={() => setReportOpen(true)}
                  className="text-xs font-medium text-black/45 transition-colors hover:text-ola-error"
                >
                  {t('report.action')}
                </button>
              )}
              <div className="ml-auto flex items-center gap-1.5">
                {comment.likeCount > 0 && (
                  <button
                    type="button"
                    onClick={() => setLikersOpen(true)}
                    className="flex items-center gap-1"
                  >
                    <CommentLikerStack likers={likers} />
                    <span className="text-xs font-medium tabular-nums text-black/55">
                      {comment.likeCount}
                    </span>
                  </button>
                )}
                <button
                  type="button"
                  onClick={() => onToggleLike(comment.id)}
                  aria-pressed={liked}
                  aria-label={liked ? t('me.liked') : t('me.like')}
                  className="flex items-center"
                >
                  <img
                    src={liked ? likeIconActive : likeIcon}
                    alt=""
                    className="h-6 w-6 object-contain"
                  />
                </button>
              </div>
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
      {likersOpen && (
        <MeLikersDialog
          postId={comment.postId}
          commentId={comment.id}
          onClose={() => setLikersOpen(false)}
          onOpenProfile={onOpenProfile}
        />
      )}
      {reportOpen && (
        <ReportDialog
          target={{ type: 'comment', id: comment.id }}
          onClose={() => setReportOpen(false)}
        />
      )}
    </>
  );
}

export const MeCommentItem = memo(MeCommentItemComponent);

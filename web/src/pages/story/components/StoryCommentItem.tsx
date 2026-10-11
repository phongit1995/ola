import { memo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, ConfirmDialog, UserName, VipBadge } from '@components';
import { activeVipTypeId, colorForName, renderRichText } from '@lib';
import replyIcon from '@/assets/icons/me/ic_action_reply_gray.png';
import likeIcon from '@/assets/icons/me/ic_like_gray.png';
import likeIconActive from '@/assets/icons/me/ic_like_selected.png';
import type { StoryComment } from '@app-types';
import type { ReaderPalette } from '../interface';

const ignoreMention = () => undefined;

interface StoryCommentItemProps {
  comment: StoryComment;
  time: string;
  palette: ReaderPalette;
  onReply: (comment: StoryComment) => void;
  onToggleLike: (commentId: string) => void;
  onDelete: (commentId: string) => void;
}

function StoryCommentItemComponent({
  comment,
  time,
  palette,
  onReply,
  onToggleLike,
  onDelete,
}: StoryCommentItemProps) {
  const { t } = useTranslation();
  const [confirmOpen, setConfirmOpen] = useState(false);
  const { author, replyTo } = comment;
  const username = author?.username ?? '';
  const name = author?.fullName || username;
  const vipTypeId = activeVipTypeId(author?.vipUsed, author?.vipEndTime);

  return (
    <li
      className="flex gap-2.5 px-4 py-3"
      style={{ borderTop: `1px solid ${palette.border}` }}
    >
      <Avatar
        name={name}
        src={author?.avatar}
        color={colorForName(username || name)}
        size={36}
      />
      <div className="min-w-0 flex-1">
        <div className="flex min-w-0 items-center gap-1">
          {vipTypeId != null && (
            <VipBadge typeId={vipTypeId} className="h-4 w-4" />
          )}
          <UserName name={name} className="truncate text-sm font-semibold" />
          <span
            className="ml-1 shrink-0 text-xs"
            style={{ color: palette.muted }}
          >
            {time}
          </span>
        </div>
        {replyTo && (
          <p
            className="mt-1 line-clamp-2 border-l-2 border-ola-primary pl-2 text-xs leading-5"
            style={{ color: palette.muted }}
          >
            <span className="font-semibold">{replyTo.authorName}</span>
            {`: ${replyTo.excerpt}`}
          </p>
        )}
        <p className="mt-0.5 text-sm leading-relaxed break-words whitespace-pre-wrap">
          {renderRichText(comment.content, ignoreMention)}
        </p>
        <div
          className="mt-1.5 flex items-center gap-4 text-xs font-medium"
          style={{ color: palette.muted }}
        >
          <button
            type="button"
            aria-pressed={comment.liked}
            aria-label={t('story.commentLike')}
            onClick={() => onToggleLike(comment.id)}
            className="flex items-center gap-1"
          >
            <img
              src={comment.liked ? likeIconActive : likeIcon}
              alt=""
              className="h-5 w-5 object-contain"
            />
            {comment.likeCount > 0 && (
              <span className="tabular-nums">{comment.likeCount}</span>
            )}
          </button>
          <button
            type="button"
            onClick={() => onReply(comment)}
            className="flex items-center gap-1 hover:text-ola-primary-ink"
          >
            <img src={replyIcon} alt="" className="h-5 w-5 object-contain" />
            {t('story.commentReply')}
          </button>
          {comment.mine && (
            <button
              type="button"
              onClick={() => setConfirmOpen(true)}
              className="hover:text-ola-error"
            >
              {t('story.commentDelete')}
            </button>
          )}
        </div>
      </div>
      <ConfirmDialog
        open={confirmOpen}
        danger
        title={t('story.commentDelete')}
        message={t('story.commentDeleteConfirm')}
        confirmLabel={t('dialog.yes')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => {
          setConfirmOpen(false);
          onDelete(comment.id);
        }}
        onCancel={() => setConfirmOpen(false)}
      />
    </li>
  );
}

export const StoryCommentItem = memo(StoryCommentItemComponent);

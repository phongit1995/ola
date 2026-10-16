import { memo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Avatar,
  ConfirmDialog,
  ListOptionDialog,
  ReportDialog,
  UserName,
  VipBadge,
  type ListOption,
} from '@components';
import {
  activeVipTypeId,
  colorForName,
  renderRichText,
  storyCommentAuthorName,
} from '@lib';
import moreIcon from '@/assets/icons/me/ic_more.png';
import replyIcon from '@/assets/icons/me/ic_action_reply_gray.png';
import likeIcon from '@/assets/icons/me/ic_like_gray.png';
import likeIconActive from '@/assets/icons/me/ic_like_selected.png';
import type { StoryComment } from '@app-types';
import type { ReaderPalette } from '../types';
import { StoryCover } from './StoryCover';
import { StoryIcon } from './StoryIcons';

const ignoreMention = () => undefined;

interface StoryCommentItemProps {
  comment: StoryComment;
  time: string;
  palette: ReaderPalette;
  onReply: (comment: StoryComment) => void;
  onToggleLike: (commentId: string) => void;
  onDelete: (comment: StoryComment) => void;
  onOpenStory?: (storyId: string) => void;
}

function StoryCommentItemComponent({
  comment,
  time,
  palette,
  onReply,
  onToggleLike,
  onDelete,
  onOpenStory,
}: StoryCommentItemProps) {
  const { t } = useTranslation();
  const [menuOpen, setMenuOpen] = useState(false);
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [reportOpen, setReportOpen] = useState(false);
  const { author, replyTo, story } = comment;
  const name = storyCommentAuthorName(comment);
  const vipTypeId = activeVipTypeId(author?.vipUsed, author?.vipEndTime);
  const menuOptions: ListOption[] = comment.mine
    ? [
        {
          key: 'delete',
          label: t('story.commentDeleteOption'),
          danger: true,
          onSelect: () => setConfirmOpen(true),
        },
      ]
    : [
        {
          key: 'report',
          label: t('report.comment'),
          onSelect: () => setReportOpen(true),
        },
      ];

  return (
    <li
      className="flex gap-2.5 py-3 pr-2 pl-4"
      style={{ borderTop: `1px solid ${palette.border}` }}
    >
      <Avatar
        name={name}
        src={author?.avatar}
        color={colorForName(name)}
        size={36}
      />
      <div className="min-w-0 flex-1">
        <div className="flex min-w-0 items-center gap-1">
          {vipTypeId != null && (
            <VipBadge typeId={vipTypeId} className="h-4 w-4" />
          )}
          <UserName
            name={name}
            fullName={author?.fullName}
            className="min-w-0 truncate text-sm font-semibold"
            fullNameClassName="font-normal opacity-60"
          />
          <span
            className="ml-1 shrink-0 text-xs"
            style={{ color: palette.muted }}
          >
            {time}
          </span>
          <button
            type="button"
            aria-label={t('story.commentMenu')}
            onClick={() => setMenuOpen(true)}
            className="-my-1.5 ml-auto shrink-0 rounded-full p-2 hover:bg-black/5"
          >
            <img src={moreIcon} alt="" className="h-4 w-4 object-contain" />
          </button>
        </div>
        {replyTo && (
          <p
            className="mt-1 mr-2 line-clamp-2 border-l-2 border-ola-primary pl-2 text-xs leading-5"
            style={{ color: palette.muted }}
          >
            <span className="font-semibold">{replyTo.authorName}</span>
            {`: ${replyTo.excerpt}`}
          </p>
        )}
        <p className="mt-0.5 mr-2 text-sm leading-relaxed wrap-break-word whitespace-pre-wrap">
          {renderRichText(comment.content, ignoreMention)}
        </p>
        {onOpenStory && story && (
          <button
            type="button"
            onClick={() => onOpenStory(story.id)}
            className="mt-2 flex max-w-full items-center gap-2 rounded-lg py-1.5 pr-2 pl-1.5 text-left transition-[filter] duration-150 hover:brightness-95 active:brightness-90 motion-reduce:transition-none"
            style={{ backgroundColor: palette.panel }}
          >
            <StoryCover
              title={story.title}
              coverUrl={story.coverUrl}
              size="xs"
              className="w-6 shrink-0 rounded-sm"
            />
            <span className="min-w-0 truncate text-xs font-medium">
              {story.title}
            </span>
            <span className="flex shrink-0" style={{ color: palette.muted }}>
              <StoryIcon name="chevronRight" className="h-4 w-4" />
            </span>
          </button>
        )}
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
        </div>
      </div>
      <ListOptionDialog
        open={menuOpen}
        title={t('story.commentMenu')}
        options={menuOptions}
        onClose={() => setMenuOpen(false)}
      />
      {reportOpen && (
        <ReportDialog
          target={{ type: 'comment', id: comment.id }}
          onClose={() => setReportOpen(false)}
        />
      )}
      <ConfirmDialog
        open={confirmOpen}
        danger
        title={t('story.commentDelete')}
        message={t('story.commentDeleteConfirm')}
        confirmLabel={t('dialog.yes')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => {
          setConfirmOpen(false);
          onDelete(comment);
        }}
        onCancel={() => setConfirmOpen(false)}
      />
    </li>
  );
}

export const StoryCommentItem = memo(StoryCommentItemComponent);

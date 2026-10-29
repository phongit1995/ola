import { useTranslation } from 'react-i18next';
import { SmileyText } from '@lib';
import type { MomentMyComment } from '@app-types';
import { MomentCheckIcon, MomentCommentIcon } from './MomentIcons';

interface MomentCommentBarProps {
  myComment?: MomentMyComment;
  onComment: () => void;
}

export function MomentCommentBar({ myComment, onComment }: MomentCommentBarProps) {
  const { t } = useTranslation();

  if (myComment != null) {
    const label =
      myComment.content === ''
        ? t('moment.commented')
        : `${t('moment.commented')}: ${myComment.content}`;
    return (
      <p
        title={label}
        aria-label={label}
        className="flex h-11 w-full min-w-0 items-center gap-1.5 rounded-full border border-white/20 bg-black/30 px-3.5 text-sm text-white/90 backdrop-blur-md"
      >
        <MomentCheckIcon className="h-[18px] w-[18px] shrink-0" />
        <span className="min-w-0 truncate">
          {myComment.content === '' ? t('moment.commented') : <SmileyText text={myComment.content} />}
        </span>
      </p>
    );
  }

  return (
    <button
      type="button"
      onClick={onComment}
      className="pointer-events-auto flex h-11 w-full min-w-0 items-center gap-1.5 rounded-full border border-white/40 bg-white/15 px-3.5 text-left text-sm text-white/90 shadow-[0_1px_8px_rgba(0,0,0,0.12)] backdrop-blur-md transition-colors hover:bg-white/25 active:bg-white/30"
    >
      <MomentCommentIcon className="h-[18px] w-[18px] shrink-0" />
      <span className="min-w-0 truncate">{t('moment.commentPlaceholder')}</span>
    </button>
  );
}

import { useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, UserListDialog, UserName } from '@components';
import { colorForName, createTimeAgoFormatter, SmileyText } from '@lib';
import { MomentService } from '@services';
import { useMomentUserPages } from '@ola/shared/stores/moment/useMomentUserPages';
import { MomentListMoreButton } from './MomentListMoreButton';

interface MomentCommentsDialogProps {
  open: boolean;
  momentId: string;
  total: number;
  onClose: () => void;
}

export function MomentCommentsDialog({
  open,
  momentId,
  total,
  onClose,
}: MomentCommentsDialogProps) {
  const { t, i18n } = useTranslation();
  const formatTime = useMemo(
    () => createTimeAgoFormatter(i18n.language),
    [i18n.language]
  );
  const { list, nextOffset, loadingMore, loadMore } = useMomentUserPages({
    open,
    momentId,
    load: MomentService.visibleComments,
    failedMessage: t('moment.commentsFailed'),
  });
  const items = list?.items ?? [];

  return (
    <UserListDialog
      open={open}
      title={t('moment.commentCount', { count: total })}
      onClose={onClose}
      loading={list == null}
      isEmpty={items.length === 0}
      empty={t('moment.commentsEmpty')}
    >
      {items.map(({ id, user, content, createdAt }) => (
        <li key={id} className="flex gap-3 py-2">
          <span className="shrink-0">
            <Avatar
              name={user.username}
              color={colorForName(user.username)}
              src={user.avatar ?? undefined}
              size={40}
            />
          </span>
          <div className="min-w-0 flex-1">
            <div className="flex min-w-0 items-baseline gap-2">
              <UserName
                name={user.username}
                fullName={user.fullName}
                className="min-w-0 truncate text-sm font-semibold text-black/87"
                fullNameClassName="font-normal text-black/54"
              />
              <span className="shrink-0 text-xs text-black/38">
                {formatTime(createdAt)}
              </span>
            </div>
            <p className="mt-0.5 text-sm break-words whitespace-pre-wrap text-black/87">
              <SmileyText text={content} />
            </p>
          </div>
        </li>
      ))}
      {nextOffset != null && (
        <MomentListMoreButton loading={loadingMore} onClick={loadMore} />
      )}
    </UserListDialog>
  );
}

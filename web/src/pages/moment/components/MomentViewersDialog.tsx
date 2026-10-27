import { useTranslation } from 'react-i18next';
import { UserListDialog, UserRow } from '@components';
import { colorForName } from '@lib';
import { MomentService } from '@services';
import { useMomentUserPages } from '@ola/shared/stores/moment/useMomentUserPages';
import { MomentListMoreButton } from './MomentListMoreButton';

interface MomentViewersDialogProps {
  open: boolean;
  momentId: string;
  onClose: () => void;
}

export function MomentViewersDialog({ open, momentId, onClose }: MomentViewersDialogProps) {
  const { t } = useTranslation();
  const { list, nextOffset, loadingMore, loadMore } = useMomentUserPages({
    open,
    momentId,
    load: MomentService.visibleViewers,
    failedMessage: t('moment.viewersFailed'),
  });
  const items = list?.items ?? [];

  return (
    <UserListDialog
      open={open}
      title={list ? t('moment.viewerCount', { count: list.total }) : t('moment.viewers')}
      onClose={onClose}
      loading={list == null}
      isEmpty={items.length === 0}
      empty={t('moment.viewersEmpty')}
    >
      {items.map(({ user }) => (
        <li key={user.id}>
          <UserRow
            name={user.username}
            fullName={user.fullName}
            avatar={user.avatar ?? undefined}
            color={colorForName(user.username)}
            layout="inline"
          />
        </li>
      ))}
      {nextOffset != null && (
        <MomentListMoreButton loading={loadingMore} onClick={loadMore} />
      )}
    </UserListDialog>
  );
}

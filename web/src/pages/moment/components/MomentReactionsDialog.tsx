import { useTranslation } from 'react-i18next';
import { UserListDialog, UserRow } from '@components';
import { colorForName } from '@lib';
import { MomentService } from '@services';
import { useMomentUserPages } from '@ola/shared/stores/moment/useMomentUserPages';
import { MomentListMoreButton } from './MomentListMoreButton';
import { MomentReactionCounts } from './MomentReactionChips';

interface MomentReactionsDialogProps {
  open: boolean;
  momentId: string;
  total: number;
  onClose: () => void;
}

export function MomentReactionsDialog({
  open,
  momentId,
  total,
  onClose,
}: MomentReactionsDialogProps) {
  const { t } = useTranslation();
  const { list, nextOffset, loadingMore, loadMore } = useMomentUserPages({
    open,
    momentId,
    load: MomentService.visibleReactors,
    failedMessage: t('moment.reactionsFailed'),
  });
  const items = list?.items ?? [];

  return (
    <UserListDialog
      open={open}
      title={t('moment.reactionTotal', { count: total })}
      onClose={onClose}
      loading={list == null}
      isEmpty={items.length === 0}
      empty={t('moment.reactionsEmpty')}
    >
      {items.map(({ user, reactions }) => (
        <li key={user.id}>
          <UserRow
            name={user.username}
            fullName={user.fullName}
            avatar={user.avatar ?? undefined}
            color={colorForName(user.username)}
            layout="inline"
            trailing={<MomentReactionCounts reactions={reactions} />}
          />
        </li>
      ))}
      {nextOffset != null && (
        <MomentListMoreButton loading={loadingMore} onClick={loadMore} />
      )}
    </UserListDialog>
  );
}

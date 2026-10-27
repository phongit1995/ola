import { useTranslation } from 'react-i18next';
import { Text } from 'react-native';
import { MomentService } from '@ola/shared/services';
import { useMomentUserPages } from '@ola/shared/stores/moment/useMomentUserPages';
import { UserListDialog } from '@components/ui/UserListDialog';
import { MomentListMoreButton } from './MomentListMoreButton';
import { MomentReactionCounts } from './MomentReactionChips';
import { MomentUserRow } from './MomentUserRow';

const LIST_MAX_HEIGHT = 360;

interface MomentReactionsDialogProps {
  visible: boolean;
  momentId: string;
  total: number;
  onClose: () => void;
}

export function MomentReactionsDialog({
  visible,
  momentId,
  total,
  onClose,
}: MomentReactionsDialogProps) {
  const { t } = useTranslation();
  const { list, nextOffset, loadingMore, loadMore } = useMomentUserPages({
    open: visible,
    momentId,
    load: MomentService.visibleReactors,
    failedMessage: t('moment.reactionsFailed'),
  });
  const items = list?.items ?? [];

  return (
    <UserListDialog
      visible={visible}
      title={t('moment.reactionTotal', { count: total })}
      onClose={onClose}
      loading={list == null}
      isEmpty={items.length === 0}
      empty={
        <Text className="py-2 text-center text-base text-ola-ink-soft">
          {t('moment.reactionsEmpty')}
        </Text>
      }
      divided={false}
      listMaxHeight={LIST_MAX_HEIGHT}
    >
      {[
        ...items.map(({ user, reactions }) => (
          <MomentUserRow
            key={user.id}
            user={user}
            trailing={<MomentReactionCounts reactions={reactions} />}
          />
        )),
        ...(nextOffset != null
          ? [
              <MomentListMoreButton
                key="more"
                loading={loadingMore}
                onPress={loadMore}
              />,
            ]
          : []),
      ]}
    </UserListDialog>
  );
}

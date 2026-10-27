import { useTranslation } from 'react-i18next';
import { Text } from 'react-native';
import { MomentService } from '@ola/shared/services';
import { useMomentUserPages } from '@ola/shared/stores/moment/useMomentUserPages';
import { UserListDialog } from '@components/ui/UserListDialog';
import { MomentListMoreButton } from './MomentListMoreButton';
import { MomentUserRow } from './MomentUserRow';

const LIST_MAX_HEIGHT = 360;

interface MomentViewersDialogProps {
  visible: boolean;
  momentId: string;
  onClose: () => void;
}

export function MomentViewersDialog({ visible, momentId, onClose }: MomentViewersDialogProps) {
  const { t } = useTranslation();
  const { list, nextOffset, loadingMore, loadMore } = useMomentUserPages({
    open: visible,
    momentId,
    load: MomentService.visibleViewers,
    failedMessage: t('moment.viewersFailed'),
  });
  const items = list?.items ?? [];

  return (
    <UserListDialog
      visible={visible}
      title={list ? t('moment.viewerCount', { count: list.total }) : t('moment.viewers')}
      onClose={onClose}
      loading={list == null}
      isEmpty={items.length === 0}
      empty={
        <Text className="py-2 text-center text-base text-ola-ink-soft">
          {t('moment.viewersEmpty')}
        </Text>
      }
      divided={false}
      listMaxHeight={LIST_MAX_HEIGHT}
    >
      {[
        ...items.map(({ user }) => <MomentUserRow key={user.id} user={user} />),
        ...(nextOffset != null
          ? [<MomentListMoreButton key="more" loading={loadingMore} onPress={loadMore} />]
          : []),
      ]}
    </UserListDialog>
  );
}

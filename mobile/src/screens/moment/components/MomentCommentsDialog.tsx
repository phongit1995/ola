import { useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { Text, View } from 'react-native';
import { colorForName, createTimeAgoFormatter } from '@ola/shared/lib';
import { MomentService } from '@ola/shared/services';
import { useMomentUserPages } from '@ola/shared/stores/moment/useMomentUserPages';
import { Avatar } from '@components/ui/Avatar';
import { UserListDialog } from '@components/ui/UserListDialog';
import { SmileyText } from '@lib/richText';
import { MomentListMoreButton } from './MomentListMoreButton';

const LIST_MAX_HEIGHT = 420;
const COMMENT_FONT_SIZE = 14;

interface MomentCommentsDialogProps {
  visible: boolean;
  momentId: string;
  total: number;
  onClose: () => void;
}

export function MomentCommentsDialog({
  visible,
  momentId,
  total,
  onClose,
}: MomentCommentsDialogProps) {
  const { t, i18n } = useTranslation();
  const formatTime = useMemo(() => createTimeAgoFormatter(i18n.language), [i18n.language]);
  const { list, nextOffset, loadingMore, loadMore } = useMomentUserPages({
    open: visible,
    momentId,
    load: MomentService.visibleComments,
    failedMessage: t('moment.commentsFailed'),
  });
  const items = list?.items ?? [];

  return (
    <UserListDialog
      visible={visible}
      title={t('moment.commentCount', { count: total })}
      onClose={onClose}
      loading={list == null}
      isEmpty={items.length === 0}
      empty={
        <Text className="py-2 text-center text-base text-ola-ink-soft">
          {t('moment.commentsEmpty')}
        </Text>
      }
      divided={false}
      listMaxHeight={LIST_MAX_HEIGHT}
    >
      {[
        ...items.map(({ id, user, content, createdAt }) => (
          <View key={id} className="flex-row gap-3 py-2">
            <Avatar
              name={user.username}
              uri={user.avatar ?? undefined}
              color={colorForName(user.username)}
              size={40}
            />
            <View className="min-w-0 flex-1">
              <View className="flex-row items-baseline gap-2">
                <Text numberOfLines={1} className="min-w-0 flex-shrink text-sm font-semibold text-ola-ink">
                  {user.username}
                </Text>
                <Text className="text-xs text-ola-ink-soft">{formatTime(createdAt)}</Text>
              </View>
              <Text className="mt-0.5 text-ola-ink" style={{ fontSize: COMMENT_FONT_SIZE }}>
                <SmileyText text={content} fontSize={COMMENT_FONT_SIZE} />
              </Text>
            </View>
          </View>
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

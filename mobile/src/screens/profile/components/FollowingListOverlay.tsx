import { useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  FlatList,
  Pressable,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { UserService } from '@ola/shared/services';
import type { FollowUser } from '@ola/shared/types';
import { useThemeColors } from '@hooks/useThemeColors';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { OlaModal } from '@components/ui/OlaModal';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { FOLLOW_PAGE_SIZE } from '../constants';
import { UserName } from '@components/ui/UserName';
import { useOffsetPage } from '@ola/shared/stores/useOffsetPage';

type FollowListKind = 'following' | 'followers';

interface FollowingListOverlayProps {
  userId: string;
  kind: FollowListKind;
  onSelect: (friend: FollowUser) => void;
  onClose: () => void;
  title?: string;
}

export function FollowingListOverlay(props: FollowingListOverlayProps) {
  return (
    <OlaModal
      visible
      transparent
      animationType="slide"
      onRequestClose={props.onClose}
    >
      <FollowingListBody {...props} />
    </OlaModal>
  );
}

function FollowingListBody({
  userId,
  kind,
  onSelect,
  onClose,
  title,
}: FollowingListOverlayProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const insets = useSafeAreaInsets();

  const loadPage = useCallback(
    async (offset: number) => {
      const params = { limit: FOLLOW_PAGE_SIZE, offset };
      const result =
        kind === 'followers'
          ? await UserService.followers(userId, params)
          : await UserService.following(userId, params);
      return { items: result.users, total: result.total };
    },
    [userId, kind],
  );
  const { items: rows, loading, loadingMore, loadMore } = useOffsetPage(loadPage);

  return (
    <View className="flex-1 bg-white">
      <ScreenHeader
        title={title ?? t('profile.following')}
        centerTitle
        onBack={onClose}
      />
      {loading ? (
        <ActivityIndicator className="py-16" color={colors.primary} size="large" />
      ) : (
        <FlatList
          data={rows}
          keyExtractor={item => item.id}
          contentContainerStyle={{ paddingBottom: insets.bottom }}
          onEndReached={() => void loadMore()}
          onEndReachedThreshold={0.4}
          ListFooterComponent={
            loadingMore ? (
              <ActivityIndicator className="py-3" color={colors.primary} />
            ) : undefined
          }
          renderItem={({ item }) => (
            <Pressable
              onPress={() => onSelect(item)}
              className="flex-row items-center gap-3 px-4 py-2 active:bg-black/5"
              style={{
                borderBottomWidth: 1,
                borderBottomColor: 'rgba(0,0,0,0.08)',
              }}
            >
              <AvatarWithFrame
                name={item.username}
                uri={item.avatar ?? undefined}
                size={40}
                frameId={item.avatarFrameId}
              />
              <UserName
                name={`@${item.username}`}
                fullName={item.fullName}
                className="min-w-0 flex-1 text-base text-ola-ink"
              />
            </Pressable>
          )}
        />
      )}
    </View>
  );
}

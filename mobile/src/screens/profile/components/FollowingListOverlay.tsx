import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  FlatList,
  Pressable,
  Text,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { UserService } from '@ola/shared/services';
import type { FollowUser } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { OlaModal } from '@components/ui/OlaModal';
import { ScreenHeader } from '@components/ui/ScreenHeader';

const FOLLOW_PAGE_SIZE = 10;

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
  const insets = useSafeAreaInsets();
  const [rows, setRows] = useState<FollowUser[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);

  const loadPage = useCallback(
    (offset: number) =>
      kind === 'followers'
        ? UserService.followers(userId, { limit: FOLLOW_PAGE_SIZE, offset })
        : UserService.following(userId, { limit: FOLLOW_PAGE_SIZE, offset }),
    [userId, kind],
  );

  useEffect(() => {
    let active = true;
    (async () => {
      const result = await loadPage(0).catch(() => null);
      if (!active) return;
      if (result != null) {
        setRows(result.users);
        setTotal(result.total);
      }
      setLoading(false);
    })();
    return () => {
      active = false;
    };
  }, [loadPage]);

  const hasMore = rows.length < total;

  const loadMore = useCallback(async () => {
    if (loading || loadingMore || !hasMore) return;
    setLoadingMore(true);
    const result = await loadPage(rows.length).catch(() => null);
    if (result != null) {
      setRows(current => [...current, ...result.users]);
      setTotal(result.total);
    }
    setLoadingMore(false);
  }, [loadPage, loading, loadingMore, hasMore, rows.length]);

  return (
    <View className="flex-1 bg-white">
      <ScreenHeader
        title={title ?? t('profile.following')}
        centerTitle
        onBack={onClose}
      />
      {loading ? (
        <ActivityIndicator className="py-16" color="#7cb342" size="large" />
      ) : (
        <FlatList
          data={rows}
          keyExtractor={item => item.id}
          contentContainerStyle={{ paddingBottom: insets.bottom }}
          onEndReached={() => void loadMore()}
          onEndReachedThreshold={0.4}
          ListFooterComponent={
            loadingMore ? (
              <ActivityIndicator className="py-3" color="#7cb342" />
            ) : null
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
              <Avatar
                name={item.username}
                uri={item.avatar ?? undefined}
                size={40}
                rounded={false}
              />
              <Text
                numberOfLines={1}
                className="min-w-0 flex-1 text-base text-ola-ink"
              >
                @{item.username}
                {item.fullName != null && item.fullName !== '' && (
                  <Text className="text-ola-ink-soft">
                    {' '}
                    · {item.fullName}
                  </Text>
                )}
              </Text>
            </Pressable>
          )}
        />
      )}
    </View>
  );
}

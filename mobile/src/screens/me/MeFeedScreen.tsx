import { useEffect, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, RefreshControl, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useMeFeedStore } from '@ola/shared/stores/meFeedStore';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { AuthService, SocketService } from '@ola/shared/services';
import { createTimeFormatter, formatDateDMY, isSameDay } from '@ola/shared/lib';
import type { Post } from '@ola/shared/types';
import { Alert } from 'react-native';
import { Avatar } from '../../components/Avatar';

function PostCard({
  post,
  timeLabel,
  onToggleLike,
}: {
  post: Post;
  timeLabel: string;
  onToggleLike: () => void;
}) {
  const authorName = post.author?.fullName ?? post.author?.username ?? '';
  const liked = post.myReaction === 'like';
  return (
    <View className="mb-2 bg-white px-4 py-3">
      <View className="flex-row items-center gap-3">
        <Avatar name={authorName} uri={post.author?.avatar} size={40} />
        <View className="flex-1">
          <Text className="text-base font-semibold text-neutral-900" numberOfLines={1}>
            {authorName}
          </Text>
          <Text className="text-xs text-neutral-400">{timeLabel}</Text>
        </View>
        {post.isPinned && <Text className="text-xs">📌</Text>}
      </View>
      {post.content != null && post.content !== '' && (
        <Text className="mt-2 text-base text-neutral-900">{post.content}</Text>
      )}
      {post.images.length > 0 && (
        <View className="mt-2 flex-row flex-wrap gap-1">
          {post.images.slice(0, 4).map((image) => (
            <Image
              key={image.url}
              source={{ uri: image.url }}
              className={post.images.length === 1 ? 'h-64 w-full rounded-lg' : 'h-36 w-[48%] rounded-lg'}
              resizeMode="cover"
            />
          ))}
        </View>
      )}
      {post.checkIn != null && (
        <Text className="mt-1 text-xs text-neutral-500">📍 {post.checkIn.name}</Text>
      )}
      <View className="mt-2 flex-row items-center gap-6 border-t border-neutral-100 pt-2">
        <Pressable className="flex-row items-center gap-1" onPress={onToggleLike}>
          <Text className="text-base">{liked ? '❤️' : '🤍'}</Text>
          <Text className="text-sm text-neutral-500">{post.likeCount}</Text>
        </Pressable>
        <View className="flex-row items-center gap-1">
          <Text className="text-base">💬</Text>
          <Text className="text-sm text-neutral-500">{post.commentCount}</Text>
        </View>
      </View>
    </View>
  );
}

export function MeFeedScreen() {
  const { t, i18n } = useTranslation();
  const posts = useMeFeedStore((s) => s.posts);
  const loading = useMeFeedStore((s) => s.loading);
  const loadingMore = useMeFeedStore((s) => s.loadingMore);
  const refreshing = useMeFeedStore((s) => s.refreshing);
  const error = useMeFeedStore((s) => s.error);
  const loadFeed = useMeFeedStore((s) => s.loadFeed);
  const refreshFeed = useMeFeedStore((s) => s.refreshFeed);
  const loadMore = useMeFeedStore((s) => s.loadMore);
  const toggleReaction = useMeFeedStore((s) => s.toggleReaction);

  useEffect(() => {
    void loadFeed();
  }, [loadFeed]);

  const timeFormatter = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  function timeLabelOf(post: Post): string {
    const now = new Date().toISOString();
    return isSameDay(post.createdAt, now)
      ? timeFormatter(post.createdAt)
      : formatDateDMY(post.createdAt);
  }

  return (
    <View className="flex-1 bg-neutral-100">
      <View className="h-12 flex-row items-center border-b border-neutral-200 bg-ola-primary px-4">
        <Text className="flex-1 text-lg font-semibold text-white">{t('home.tabMe')}</Text>
        <Pressable
          className="px-2 py-1"
          onPress={() =>
            Alert.alert(t('home.logout'), '', [
              { text: t('common.cancel'), style: 'cancel' },
              {
                text: t('home.logout'),
                style: 'destructive',
                onPress: () => {
                  void AuthService.logout().finally(() => {
                    SocketService.disconnect();
                    useAuthStore.getState().clearUser();
                  });
                },
              },
            ])
          }
        >
          <Text className="text-sm text-white">{t('home.logout')}</Text>
        </Pressable>
      </View>
      {loading && posts.length === 0 ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : error && posts.length === 0 ? (
        <View className="flex-1 items-center justify-center px-8">
          <Text className="text-center text-sm text-neutral-500">{t('common.error')}</Text>
        </View>
      ) : (
        <FlashList
          data={posts}
          keyExtractor={(item) => item.id}
          refreshControl={
            <RefreshControl refreshing={refreshing} onRefresh={() => void refreshFeed()} />
          }
          onEndReached={() => void loadMore()}
          onEndReachedThreshold={0.4}
          ListFooterComponent={
            loadingMore ? <ActivityIndicator className="my-4" color="#7cb342" /> : null
          }
          renderItem={({ item }) => (
            <PostCard
              post={item}
              timeLabel={timeLabelOf(item)}
              onToggleLike={() => void toggleReaction(item.id, 'like')}
            />
          )}
        />
      )}
    </View>
  );
}

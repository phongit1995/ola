import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { colorForName } from '@ola/shared/lib';
import type { FollowUser } from '@ola/shared/types';
import { CARD_SHADOW } from '../constants';

interface FollowingPreviewCardProps {
  users: FollowUser[];
  onViewAll: () => void;
  onOpenFriend: (friend: FollowUser) => void;
}

export function FollowingPreviewCard({ users, onViewAll, onOpenFriend }: FollowingPreviewCardProps) {
  const { t } = useTranslation();

  if (users.length === 0) return null;

  return (
    <View className="mb-2 bg-white pb-1" style={CARD_SHADOW}>
      <Pressable
        onPress={onViewAll}
        className="flex-row items-center justify-between px-4 py-2 active:bg-black/5"
      >
        <Text className="text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
          {t('profile.following')}
        </Text>
        <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.38)' }}>
          {t('profile.viewAll')} ›
        </Text>
      </Pressable>
      <View className="flex-row gap-1 px-2">
        {users.slice(0, 5).map(friend => (
          <Pressable
            key={friend.id}
            onPress={() => onOpenFriend(friend)}
            className="flex-1 overflow-hidden"
            style={{ aspectRatio: 1 }}
          >
            {friend.avatar != null && friend.avatar !== '' ? (
              <Image
                source={{ uri: friend.avatar }}
                style={{ width: '100%', height: '100%' }}
                resizeMode="cover"
              />
            ) : (
              <View
                className="h-full w-full items-center justify-center"
                style={{ backgroundColor: colorForName(friend.username) }}
              >
                <Text className="text-2xl font-medium text-white">
                  {friend.username.charAt(0).toUpperCase()}
                </Text>
              </View>
            )}
            <View className="absolute inset-x-0 bottom-0">
              <View className="absolute inset-0">
                <View style={{ flex: 1, backgroundColor: 'rgba(0,0,0,0.2)' }} />
                <View style={{ flex: 1, backgroundColor: 'rgba(0,0,0,0.55)' }} />
              </View>
              <Text
                numberOfLines={1}
                className="px-1 py-1 text-center text-xs text-white"
              >
                @{friend.username}
              </Text>
            </View>
          </Pressable>
        ))}
        {users.length < 5 &&
          Array.from({ length: 5 - Math.min(users.length, 5) }).map(
            (_, index) => <View key={`spacer-${index}`} className="flex-1" />,
          )}
      </View>
    </View>
  );
}

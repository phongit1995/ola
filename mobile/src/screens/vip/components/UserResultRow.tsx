import { Pressable, Text, View } from 'react-native';
import type { UserSearchResult } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';

export function UserResultRow({ user, onPress }: { user: UserSearchResult; onPress?: () => void }) {
  return (
    <Pressable className="flex-row items-center gap-3 py-2 active:bg-black/5" onPress={onPress}>
      <View className="relative">
        <Avatar name={user.fullName || user.username} uri={user.avatar ?? undefined} size={40} />
        {user.isOnline && (
          <View
            className="absolute bottom-0 right-0 h-3 w-3 rounded-full bg-ola-primary"
            style={{ borderWidth: 2, borderColor: '#fff' }}
          />
        )}
      </View>
      <View className="min-w-0 flex-1">
        <Text numberOfLines={1} className="text-base" style={{ color: TEXT_PRIMARY }}>
          {user.fullName || user.username}
        </Text>
        <Text numberOfLines={1} className="text-xs" style={{ color: TEXT_SECONDARY }}>
          @{user.username}
        </Text>
      </View>
    </Pressable>
  );
}

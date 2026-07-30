import type { ReactNode } from 'react';
import { Pressable, Text, View } from 'react-native';
import { Avatar } from '@components/ui/Avatar';
import { TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import type { UserIdentity } from './types';

interface UserIdentityRowProps {
  user: UserIdentity;
  onPress?: () => void;
  trailing?: ReactNode;
}

function UserIdentityContent({ user }: { user: UserIdentity }) {
  return (
    <>
      <View className="relative">
        <Avatar
          name={user.name}
          uri={user.avatar ?? undefined}
          size={40}
        />
        {user.online === true && (
          <View
            className="absolute bottom-0 right-0 h-3 w-3 rounded-full bg-ola-primary"
            style={{ borderWidth: 2, borderColor: '#fff' }}
          />
        )}
      </View>
      <View className="min-w-0 flex-1">
        <Text
          numberOfLines={1}
          className="text-base"
          style={{ color: TEXT_PRIMARY }}
        >
          {user.name}
        </Text>
        {user.username != null && (
          <Text
            numberOfLines={1}
            className="text-xs"
            style={{ color: TEXT_SECONDARY }}
          >
            @{user.username}
          </Text>
        )}
      </View>
    </>
  );
}

export function UserIdentityRow({
  user,
  onPress,
  trailing,
}: UserIdentityRowProps) {
  if (trailing != null) {
    return (
      <View className="flex-row items-center gap-3 py-2">
        <Pressable
          className="min-w-0 flex-1 flex-row items-center gap-3"
          onPress={onPress}
          disabled={onPress == null}
        >
          <UserIdentityContent user={user} />
        </Pressable>
        {trailing}
      </View>
    );
  }

  if (onPress == null) {
    return (
      <View className="flex-row items-center gap-3 py-2">
        <UserIdentityContent user={user} />
      </View>
    );
  }

  return (
    <Pressable
      className="flex-row items-center gap-3 py-2 active:bg-black/5"
      onPress={onPress}
    >
      <UserIdentityContent user={user} />
    </Pressable>
  );
}

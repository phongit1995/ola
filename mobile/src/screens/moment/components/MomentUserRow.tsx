import type { ReactNode } from 'react';
import { Text, View } from 'react-native';
import { colorForName } from '@ola/shared/lib';
import type { MomentAuthor } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';

interface MomentUserRowProps {
  user: MomentAuthor;
  trailing?: ReactNode;
}

export function MomentUserRow({ user, trailing }: MomentUserRowProps) {
  return (
    <View className="flex-row items-center gap-3 py-2">
      <Avatar
        name={user.username}
        uri={user.avatar ?? undefined}
        color={colorForName(user.username)}
        size={40}
      />
      <View className="min-w-0 flex-1">
        <Text numberOfLines={1} className="text-base text-ola-ink">
          {user.username}
        </Text>
        {user.fullName ? (
          <Text numberOfLines={1} className="text-sm text-ola-ink-soft">
            {user.fullName}
          </Text>
        ) : null}
      </View>
      {trailing}
    </View>
  );
}

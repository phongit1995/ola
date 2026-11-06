import { Image, Pressable, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { colorForName, formatOlaTimeAgo, megaphoneSenderName } from '@ola/shared/lib';
import type { Megaphone } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { UserName } from '@components/ui/UserName';

const AVATAR_SIZE = 40;
const MORE_ICON_SIZE = 20;
const moreIcon = require('@assets/icons/chat/ic_more.png');

interface MegaphoneHistoryItemProps {
  megaphone: Megaphone;
  isMine: boolean;
  nowMs: number;
  onOpenProfile: (megaphone: Megaphone) => void;
  onMore: (megaphone: Megaphone) => void;
}

export function MegaphoneHistoryItem({ megaphone, isMine, nowMs, onOpenProfile, onMore }: MegaphoneHistoryItemProps) {
  const { t, i18n } = useTranslation();
  const name = megaphoneSenderName(megaphone);

  return (
    <View className="flex-row items-start gap-3 bg-white px-4 py-3">
      <Pressable
        accessibilityLabel={t('megaphone.viewProfile')}
        onPress={() => onOpenProfile(megaphone)}
        className="active:opacity-70"
      >
        <Avatar name={name} uri={megaphone.sender.avatar} color={colorForName(name)} size={AVATAR_SIZE} />
      </Pressable>
      <View className="min-w-0 flex-1">
        <View className="flex-row items-center gap-1">
          <Pressable onPress={() => onOpenProfile(megaphone)} className="min-w-0 shrink active:opacity-70">
            <UserName
              name={`@${megaphone.sender.username}`}
              fullName={megaphone.sender.fullName}
              className="text-sm font-semibold text-ola-megaphone-name"
              fullNameClassName="font-normal text-ola-ink-soft"
            />
          </Pressable>
          <Text className="ml-auto text-xs text-ola-ink-faint">
            {formatOlaTimeAgo(megaphone.showAt, i18n.language, nowMs)}
          </Text>
        </View>
        <Text className="mt-0.5 text-base text-ola-ink">{megaphone.content}</Text>
      </View>
      {!isMine && (
        <Pressable
          accessibilityLabel={t('common.menu')}
          onPress={() => onMore(megaphone)}
          hitSlop={8}
          className="h-8 w-8 items-center justify-center rounded-full active:bg-black/5"
          style={{ marginRight: -8 }}
        >
          <Image source={moreIcon} style={{ width: MORE_ICON_SIZE, height: MORE_ICON_SIZE, opacity: 0.6 }} resizeMode="contain" />
        </Pressable>
      )}
    </View>
  );
}

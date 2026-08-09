import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { useThemeColors } from '@hooks/useThemeColors';
import { activeVipTypeId, daysSince, monthsSince, yearsSince } from '@ola/shared/lib';
import type { PublicProfile } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { CachedImageBackground } from '@components/ui/CachedImage';
import { VipAvatar } from '@components/ui/VipAvatar';
import { DIVIDER } from '@constants';
import { GENDER } from '@ola/shared/constants';

const checkedIcon = require('@assets/icons/profile/ic_checked.png');
const maleIcon = require('@assets/icons/profile/ic_indicate_male.png');
const femaleIcon = require('@assets/icons/profile/ic_indicate_female.png');

interface PeerProfileCardProps {
  profile: PublicProfile;
  name: string;
  avatar?: string;
  onHide: () => void;
  onBlock: () => void;
  friendLabel: string;
  onFriendAction: () => void;
  onShowAvatar?: () => void;
}

export function PeerProfileCard({
  profile,
  name,
  avatar,
  onHide,
  onBlock,
  friendLabel,
  onFriendAction,
  onShowAvatar,
}: PeerProfileCardProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const vipTypeId = activeVipTypeId(profile.vipUsed, profile.vipEndTime);
  const cover = profile.coverPhoto ?? '';
  const years = yearsSince(profile.createdAt);
  const months = monthsSince(profile.createdAt);
  const days = daysSince(profile.createdAt);
  const joinedText =
    years >= 1
      ? t('chat.joinedOlaYears', { n: years })
      : months >= 1
        ? t('chat.joinedOlaMonths', { n: months })
        : days >= 1
          ? t('chat.joinedOlaDays', { n: days })
          : t('chat.joinedOlaToday');
  const genderIcon = profile.gender === GENDER.female ? femaleIcon : maleIcon;
  const avatarUrl = profile.avatar ?? avatar ?? '';

  const avatarEl = <Avatar name={name} uri={avatarUrl !== '' ? avatarUrl : undefined} size={56} rounded={false} />;

  return (
    <View className="mt-2 bg-white" style={{ borderTopWidth: 1, borderBottomWidth: 1, borderColor: DIVIDER }}>
      <CachedImageBackground
        uri={cover !== '' ? cover : undefined}
        style={{ backgroundColor: colors.primaryLight }}
      >
        <View
          className="flex-row items-end gap-2 p-2"
          style={{ minHeight: 128, backgroundColor: 'rgba(255,255,255,0.6)' }}
        >
          {avatarUrl !== '' && onShowAvatar != null ? (
            <Pressable onPress={onShowAvatar}>{avatarEl}</Pressable>
          ) : (
            avatarEl
          )}
          <View className="min-w-0 flex-1">
            <View className="flex-row items-center gap-1">
              <VipAvatar typeId={vipTypeId} size={24} />
              <Text numberOfLines={1} className="min-w-0 shrink text-base text-ola-ink">
                {name}
                {profile.fullName != null && profile.fullName !== '' && (
                  <Text className="text-ola-ink-soft"> · {profile.fullName}</Text>
                )}
              </Text>
              {profile.verified && (
                <Image source={checkedIcon} style={{ width: 12, height: 12 }} resizeMode="contain" />
              )}
            </View>
            <View className="mt-1 flex-row items-center gap-1">
              <Image source={genderIcon} style={{ width: 14, height: 14 }} resizeMode="contain" />
              <Text numberOfLines={1} className="text-xs text-ola-ink-soft">
                {joinedText}
              </Text>
            </View>
            <Text numberOfLines={1} className="mt-1 text-xs text-ola-ink-soft">
              {t('chat.fanCount', { n: profile.followerCount })}
            </Text>
            <Text numberOfLines={1} className="mt-1 text-xs text-ola-ink-soft">
              {t('chat.antiCount', { n: profile.antiCount ?? 0 })}
            </Text>
            {profile.bio != null && profile.bio !== '' && (
              <Text numberOfLines={3} className="mt-2 text-sm text-ola-ink">
                {profile.bio}
              </Text>
            )}
          </View>
        </View>
      </CachedImageBackground>

      <View className="flex-row items-center gap-4 p-2">
        <Pressable
          onPress={onHide}
          className="rounded-sm bg-white px-3 py-1"
          style={{ borderWidth: 1, borderColor: DIVIDER }}
        >
          <Text className="text-sm uppercase text-ola-ink-soft">{t('chat.hide')}</Text>
        </Pressable>
        <Pressable
          onPress={onBlock}
          className="rounded-sm bg-white px-3 py-1"
          style={{ borderWidth: 1, borderColor: DIVIDER }}
        >
          <Text className="text-sm uppercase text-ola-ink-soft">{t('chat.block')}</Text>
        </Pressable>
        <View className="flex-1" />
        <Pressable
          onPress={onFriendAction}
          className="rounded-sm px-3 py-1"
          style={{ borderWidth: 1, borderColor: colors.primaryDark, backgroundColor: colors.primary }}
        >
          <Text className="text-sm text-white">{friendLabel}</Text>
        </Pressable>
      </View>
    </View>
  );
}

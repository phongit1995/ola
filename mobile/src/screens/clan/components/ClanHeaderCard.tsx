import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Pressable,
  Text,
  View,
  useWindowDimensions,
  type ImageSourcePropType,
} from 'react-native';
import { formatDateSlashDMY } from '@ola/shared/lib';
import type { Clan } from '@ola/shared/types';
import { DIVIDER } from '@constants';
import { CachedImage } from '@components/ui/CachedImage';
import { useThemeColors } from '@hooks/useThemeColors';
import { CLAN_ROLE_ICONS, clanPolicyLabel } from '@lib/clanHelpers';

const manageIcon = require('@assets/icons/clan/ic_manage_clan.png');
const followIcon = require('@assets/icons/clan/ic_follow_black_disable.png');
const followingIcon = require('@assets/icons/clan/ic_state_following.png');
const postMeIcon = require('@assets/icons/clan/ic_post_me_gray.png');
const policyIcon = require('@assets/icons/clan/ic_profile_note.png');
const cameraIcon = require('@assets/icons/me/ic_action_edit.png');

interface ClanHeaderCardProps {
  clan: Clan;
  isOwner: boolean;
  imageUploading: boolean;
  onChangeImage: (field: 'avatar' | 'cover') => void;
  onJoin: () => void;
  onLeave: () => void;
  onOpenManage: () => void;
  onOpenMembers: () => void;
  onOpenProfile: (nick: string) => void;
  onCompose: () => void;
}

function InfoRow({
  icon,
  text,
  onPress,
}: {
  icon: ImageSourcePropType;
  text: string;
  onPress?: () => void;
}) {
  const body = (
    <>
      <Image source={icon} style={{ width: 17, height: 15 }} resizeMode="contain" />
      <Text numberOfLines={1} className="text-xs text-ola-ink-soft">
        {text}
      </Text>
    </>
  );
  if (onPress == null) {
    return <View className="ml-4 mt-2 flex-row items-center gap-1.5">{body}</View>;
  }
  return (
    <Pressable onPress={onPress} className="ml-4 mt-2 flex-row items-center gap-1.5">
      {body}
    </Pressable>
  );
}

function ActionItem({
  icon,
  label,
  active,
  disabled,
  onPress,
}: {
  icon: ImageSourcePropType;
  label: string;
  active?: boolean;
  disabled?: boolean;
  onPress: () => void;
}) {
  const colors = useThemeColors();
  return (
    <Pressable
      onPress={onPress}
      disabled={disabled}
      className="flex-1 items-center gap-1 py-1"
      style={{ opacity: disabled ? 0.5 : 1 }}
    >
      <Image source={icon} style={{ height: 20, width: 24 }} resizeMode="contain" />
      <Text className="text-xs" style={{ color: active ? colors.primary : 'rgba(0,0,0,0.26)' }}>
        {label}
      </Text>
    </Pressable>
  );
}

export function ClanHeaderCard({
  clan,
  isOwner,
  imageUploading,
  onChangeImage,
  onJoin,
  onLeave,
  onOpenManage,
  onOpenMembers,
  onOpenProfile,
  onCompose,
}: ClanHeaderCardProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const { width } = useWindowDimensions();
  const coverHeight = Math.round(width / 2);

  return (
    <View
      className="mb-2 bg-white pb-4"
      style={{
        shadowColor: '#000',
        shadowOpacity: 0.16,
        shadowRadius: 3,
        shadowOffset: { width: 0, height: 1 },
        elevation: 2,
      }}
    >
      <View style={{ position: 'relative' }}>
        <View style={{ width: '100%', height: coverHeight, backgroundColor: colors.primaryDarker }}>
          {clan.cover != null && clan.cover !== '' && (
            <CachedImage
              uri={clan.cover}
              style={{ width: '100%', height: '100%' }}
              resizeMode="cover"
            />
          )}
        </View>
        {isOwner && (
          <Pressable
            onPress={() => onChangeImage('cover')}
            className="rounded p-1.5"
            style={{
              position: 'absolute',
              right: 4,
              bottom: 4,
              backgroundColor: 'rgba(0,0,0,0.38)',
            }}
          >
            {imageUploading ? (
              <ActivityIndicator size="small" color="#ffffff" />
            ) : (
              <Image source={cameraIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
            )}
          </Pressable>
        )}
        <View
          className="bg-white p-1 pb-1.5"
          style={{
            position: 'absolute',
            bottom: 8,
            left: 8,
            shadowColor: '#000',
            shadowOpacity: 0.24,
            shadowRadius: 3,
            shadowOffset: { width: 0, height: 1 },
            elevation: 3,
          }}
        >
          <View style={{ width: 96, height: 96, backgroundColor: '#eceff1' }}>
            {clan.avatar != null && clan.avatar !== '' && (
              <CachedImage
                uri={clan.avatar}
                style={{ width: '100%', height: '100%' }}
                resizeMode="cover"
              />
            )}
            {isOwner && (
              <Pressable
                onPress={() => onChangeImage('avatar')}
                className="rounded p-1"
                style={{
                  position: 'absolute',
                  right: 2,
                  bottom: 2,
                  backgroundColor: 'rgba(0,0,0,0.38)',
                }}
              >
                <Image
                  source={cameraIcon}
                  style={{ width: 14, height: 14 }}
                  resizeMode="contain"
                />
              </Pressable>
            )}
          </View>
        </View>
      </View>

      <Text className="py-2 text-center text-2xl text-ola-ink-soft">
        #{clan.handle}
      </Text>
      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />

      <View className="flex-row px-2 py-2">
        {!isOwner &&
          (clan.isMember ? (
            <ActionItem
              icon={followingIcon}
              label={t('clan.following')}
              active
              onPress={onLeave}
            />
          ) : (
            <ActionItem
              icon={followIcon}
              label={t('clan.follow')}
              disabled={clan.policy === 3 || clan.isBanned}
              onPress={onJoin}
            />
          ))}
        {isOwner && (
          <ActionItem icon={manageIcon} label={t('clan.manage')} onPress={onOpenManage} />
        )}
        <ActionItem icon={postMeIcon} label={t('clan.writeMe')} onPress={onCompose} />
      </View>
      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />

      <Pressable onPress={onOpenMembers} className="my-4 items-center">
        <Text>
          <Text className="text-xl font-bold" style={{ color: '#000' }}>
            {clan.memberCount.toLocaleString()}
          </Text>
          <Text className="text-xs text-ola-ink-soft">
            {'  '}
            {t('clan.members')}
          </Text>
        </Text>
      </Pressable>

      <Text className="ml-4 text-xs text-ola-ink-soft">
        {t('clan.createdAt', { date: formatDateSlashDMY(clan.createdAt) })}
      </Text>
      {clan.owner != null && (
        <InfoRow
          icon={CLAN_ROLE_ICONS.owner}
          text={`@${clan.owner.username}`}
          onPress={() => onOpenProfile(clan.owner!.username)}
        />
      )}
      {clan.deputy != null && (
        <InfoRow
          icon={CLAN_ROLE_ICONS.deputy}
          text={`@${clan.deputy.username}`}
          onPress={() => onOpenProfile(clan.deputy!.username)}
        />
      )}
      {clan.ambassador != null && (
        <InfoRow
          icon={CLAN_ROLE_ICONS.ambassador}
          text={`@${clan.ambassador.username}`}
          onPress={() => onOpenProfile(clan.ambassador!.username)}
        />
      )}
      <InfoRow
        icon={policyIcon}
        text={
          clanPolicyLabel(clan.policy) +
          (clan.memberPublicPost ? ` · ${t('clan.memberPublicPost')}` : '')
        }
      />
    </View>
  );
}

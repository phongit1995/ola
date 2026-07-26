import { useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { activeVipTypeId, colorForName, createDateFormatter } from '@ola/shared/lib';
import type { PublicProfile } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { CachedImageBackground } from '@components/ui/CachedImage';
import { VipAvatar } from '@components/ui/VipAvatar';
import { DIVIDER } from '@constants';
import { CARD_SHADOW, DEFAULT_COVER_COLOR } from '../constants';
import type { OpenProfileHandler, OpenViewerHandler } from '../types';
import { RelationButtons } from './RelationButtons';

const checkedIcon = require('@assets/icons/profile/ic_checked.png');
const kissIcon = require('@assets/icons/profile/sticker_kiss.png');
const maleIcon = require('@assets/icons/profile/ic_indicate_male.png');
const femaleIcon = require('@assets/icons/profile/ic_indicate_female.png');
const marriageIcon = require('@assets/icons/profile/ic_profile_marriage.png');
const birthdayIcon = require('@assets/icons/profile/ic_profile_birthday.png');
const vipStoreIcon = require('@assets/icons/me/icon_vip.webp');
const cameraIcon = require('@assets/icons/profile/ic_action_camera.png');

interface ProfileCardProps {
  profile: PublicProfile;
  nick: string;
  isSelf: boolean;
  language: string;
  following: boolean;
  fans: number;
  kisses: number;
  uploadingCover: boolean;
  uploadingAvatar: boolean;
  onChangeCover: () => void;
  onKiss: () => void;
  onOpenFollowers: () => void;
  onOpenVipStore: () => void;
  onFriendAction: () => void;
  onToggleFollow: () => void;
  onUnblock: () => void;
  onUpdateInfo: () => void;
  onPostMe: () => void;
  onMore: () => void;
  openViewer: OpenViewerHandler;
  onOpenProfile: OpenProfileHandler;
}

function InfoRow({
  icon,
  text,
  note,
}: {
  icon: number;
  text: React.ReactNode;
  note?: boolean;
}) {
  if (text == null || text === '') return null;
  return (
    <View className="ml-4 mt-2 flex-row items-center gap-1">
      <Image
        source={icon}
        style={{ width: 14, height: 14 }}
        resizeMode="contain"
      />
      <Text
        className="text-xs"
        style={
          note
            ? { color: '#33691e', fontStyle: 'italic' }
            : { color: 'rgba(0,0,0,0.54)' }
        }
      >
        {text}
      </Text>
    </View>
  );
}

export function ProfileCard({
  profile,
  nick,
  isSelf,
  language,
  following,
  fans,
  kisses,
  uploadingCover,
  uploadingAvatar,
  onChangeCover,
  onKiss,
  onOpenFollowers,
  onOpenVipStore,
  onFriendAction,
  onToggleFollow,
  onUnblock,
  onUpdateInfo,
  onPostMe,
  onMore,
  openViewer,
  onOpenProfile,
}: ProfileCardProps) {
  const { t } = useTranslation();
  const formatDate = useMemo(() => createDateFormatter(language), [language]);

  const gender = profile.gender === 'female' ? 'female' : 'male';
  const vipTypeId = activeVipTypeId(profile.vipUsed, profile.vipEndTime);
  const joinDate = `${t('profile.joinedOla')} ${formatDate(profile.createdAt)}`;
  const birthday =
    profile.dateOfBirth != null && profile.dateOfBirth !== ''
      ? formatDate(profile.dateOfBirth)
      : '';

  const openSpouse = () =>
    onOpenProfile(
      profile.spouse!.username,
      colorForName(profile.spouse!.username),
    );

  return (
    <View className="mb-2 bg-white" style={CARD_SHADOW}>
      <View style={{ paddingBottom: 48 }}>
        <CachedImageBackground
          uri={profile.coverPhoto}
          style={{
            width: '100%',
            aspectRatio: 16 / 9,
            backgroundColor: DEFAULT_COVER_COLOR,
          }}
        >
          {profile.coverPhoto != null && (
            <Pressable
              className="absolute inset-0"
              onPress={() => openViewer([profile.coverPhoto!])}
            />
          )}
          {isSelf && (
            <Pressable
              onPress={onChangeCover}
              disabled={uploadingCover}
              className="absolute bottom-2 right-2 h-8 w-8 items-center justify-center rounded-full"
              style={{
                backgroundColor: 'rgba(0,0,0,0.4)',
                opacity: uploadingCover ? 0.6 : 1,
              }}
            >
              <Image
                source={cameraIcon}
                style={{ width: 20, height: 20, tintColor: '#fff' }}
                resizeMode="contain"
              />
            </Pressable>
          )}
          {uploadingCover && (
            <View
              className="absolute inset-0 items-center justify-center"
              style={{ backgroundColor: 'rgba(0,0,0,0.3)' }}
            >
              <Text className="text-sm text-white">{t('common.loading')}</Text>
            </View>
          )}
        </CachedImageBackground>
        <View
          className="absolute bottom-0 left-0 right-0 items-center"
          pointerEvents="box-none"
        >
          <View
            className="flex-row gap-1 bg-white"
            style={{
              padding: 1,
              paddingBottom: 2,
              shadowColor: '#000',
              shadowOpacity: 0.3,
              shadowRadius: 3,
              shadowOffset: { width: 0, height: 1 },
              elevation: 3,
            }}
          >
            {profile.avatar != null && profile.avatar !== '' ? (
              <Pressable onPress={() => openViewer([profile.avatar!])}>
                <Avatar name={nick} uri={profile.avatar} size={96} rounded={false} />
                {uploadingAvatar && (
                  <View
                    className="absolute inset-0 items-center justify-center"
                    style={{ backgroundColor: 'rgba(0,0,0,0.3)' }}
                  >
                    <Text className="text-sm text-white">{t('common.loading')}</Text>
                  </View>
                )}
              </Pressable>
            ) : (
              <View>
                <Avatar name={nick} size={96} rounded={false} />
                {uploadingAvatar && (
                  <View
                    className="absolute inset-0 items-center justify-center"
                    style={{ backgroundColor: 'rgba(0,0,0,0.3)' }}
                  >
                    <Text className="text-sm text-white">{t('common.loading')}</Text>
                  </View>
                )}
              </View>
            )}
            {profile.spouse != null && (
              <Pressable onPress={openSpouse}>
                <Avatar
                  name={profile.spouse.username}
                  uri={profile.spouse.avatar ?? undefined}
                  size={96}
                  rounded={false}
                />
              </Pressable>
            )}
          </View>
        </View>
      </View>

      <View className="flex-row items-center justify-center gap-1 p-2">
        <Text
          numberOfLines={1}
          className="min-w-0 shrink text-lg text-ola-ink"
        >
          @{profile.username}
          {profile.fullName != null && profile.fullName !== '' && (
            <Text className="text-ola-ink-soft"> · {profile.fullName}</Text>
          )}
        </Text>
        {profile.verified && (
          <Image
            source={checkedIcon}
            style={{ width: 20, height: 20 }}
            resizeMode="contain"
          />
        )}
      </View>

      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />

      <RelationButtons
        profile={profile}
        isSelf={isSelf}
        following={following}
        onFriendAction={onFriendAction}
        onToggleFollow={onToggleFollow}
        onUnblock={onUnblock}
        onUpdateInfo={onUpdateInfo}
        onPostMe={onPostMe}
        onMore={onMore}
      />

      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />

      <Pressable
        onPress={onOpenFollowers}
        disabled={fans === 0}
        className="mt-4 flex-row items-center justify-center gap-1 rounded-lg py-1 active:bg-black/5"
      >
        <Text className="text-xl font-bold" style={{ color: '#000' }}>
          {fans}
        </Text>
        <Text className="text-xs text-ola-ink-soft">
          {t('profile.peopleCare')}
        </Text>
      </Pressable>

      <Pressable onPress={onKiss} disabled={isSelf} className="mt-2 items-center gap-1">
        <Image
          source={kissIcon}
          style={{ height: 64, width: 64 }}
          resizeMode="contain"
        />
        <Text className="text-sm" style={{ color: '#000' }}>
          {kisses > 0
            ? t('profile.kissCount', { count: kisses })
            : t('profile.notKissed')}
        </Text>
      </Pressable>

      {profile.bio != null && profile.bio !== '' && (
        <Text
          numberOfLines={5}
          className="mt-3 px-4 text-center text-xs text-ola-ink-soft"
        >
          {profile.bio}
        </Text>
      )}

      {vipTypeId != null && (
        <View className="ml-4 mt-3 flex-row items-center gap-1">
          <VipAvatar typeId={vipTypeId} size={24} />
          <Text className="text-xs font-bold" style={{ color: '#ff4081' }}>
            {t('profile.vipAccount')}
          </Text>
        </View>
      )}

      <View className="pb-4">
        <InfoRow
          icon={gender === 'female' ? femaleIcon : maleIcon}
          text={
            gender === 'female' ? t('profile.genderFemale') : t('profile.genderMale')
          }
        />
        <InfoRow
          icon={marriageIcon}
          text={
            profile.spouse != null ? (
              <>
                {t('marriage.marryWithLabel')}{' '}
                <Text style={{ color: '#33691e' }} onPress={openSpouse}>
                  @{profile.spouse.username}
                </Text>
              </>
            ) : (
              t('profile.marriageSingle')
            )
          }
        />
        <InfoRow icon={birthdayIcon} text={birthday} />
        <View className="ml-4 mt-2">
          <Text className="text-xs text-ola-ink-soft">
            {joinDate}
          </Text>
        </View>
        {profile.canViewVipStore && (
          <Pressable
            onPress={onOpenVipStore}
            className="ml-4 mt-2 flex-row items-center gap-1 active:opacity-70"
          >
            <Image
              source={vipStoreIcon}
              style={{ width: 16, height: 16 }}
              resizeMode="contain"
            />
            <Text className="text-xs" style={{ color: '#33691e' }}>
              {t('profile.viewVipStore')}
            </Text>
          </Pressable>
        )}
      </View>
    </View>
  );
}

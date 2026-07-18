import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { profileFriendLabel } from '@ola/shared/lib';
import { RELATIONSHIP_STATUS } from '@ola/shared/constants';
import type { PublicProfile } from '@ola/shared/types';

const addFriendIcon = require('@assets/icons/profile/ic_add_friend_black_disable.png');
const friendsActiveIcon = require('@assets/icons/profile/ic_state_friends.png');
const followIcon = require('@assets/icons/profile/ic_follow_black_disable.png');
const followingActiveIcon = require('@assets/icons/profile/ic_state_following.png');
const postMeIcon = require('@assets/icons/profile/ic_post_me_gray.png');
const moreIcon = require('@assets/icons/profile/ic_more_horizon_black_disable.png');
const editIcon = require('@assets/icons/profile/ic_edit_profile_gray.png');

interface RelationButtonsProps {
  profile: PublicProfile;
  isSelf: boolean;
  following: boolean;
  onFriendAction: () => void;
  onToggleFollow: () => void;
  onUnblock: () => void;
  onUpdateInfo: () => void;
  onPostMe: () => void;
  onMore: () => void;
}

function RelationButton({
  icon,
  label,
  active,
  onPress,
}: {
  icon: number;
  label: string;
  active?: boolean;
  onPress: () => void;
}) {
  return (
    <Pressable onPress={onPress} className="flex-1 items-center gap-1 py-1">
      <Image
        source={icon}
        style={{ width: 20, height: 20 }}
        resizeMode="contain"
      />
      <Text
        numberOfLines={2}
        className="text-center text-xs leading-tight"
        style={{ color: active ? '#7cb342' : 'rgba(0,0,0,0.26)' }}
      >
        {label}
      </Text>
    </Pressable>
  );
}

export function RelationButtons({
  profile,
  isSelf,
  following,
  onFriendAction,
  onToggleFollow,
  onUnblock,
  onUpdateInfo,
  onPostMe,
  onMore,
}: RelationButtonsProps) {
  const { t } = useTranslation();
  const friendStatus = profile.relationship?.status;
  const isFriend = friendStatus === RELATIONSHIP_STATUS.friend;
  const blockedByMe = friendStatus === RELATIONSHIP_STATUS.blockedByMe;

  if (blockedByMe && !isSelf) {
    return (
      <View className="px-2 py-2">
        <Pressable
          onPress={onUnblock}
          className="items-center rounded py-3 active:opacity-90"
          style={{ backgroundColor: '#e34545' }}
        >
          <Text className="text-sm font-medium text-white">
            {t('profile.unblock')}
          </Text>
        </Pressable>
      </View>
    );
  }

  return (
    <View className="flex-row px-2 py-2">
      {isSelf ? (
        <RelationButton
          icon={editIcon}
          label={t('profile.updateInfo')}
          onPress={onUpdateInfo}
        />
      ) : (
        <>
          <RelationButton
            icon={isFriend ? friendsActiveIcon : addFriendIcon}
            label={profileFriendLabel(t, friendStatus)}
            active={isFriend || friendStatus === RELATIONSHIP_STATUS.pendingOutgoing}
            onPress={onFriendAction}
          />
          <RelationButton
            icon={following ? followingActiveIcon : followIcon}
            label={following ? t('profile.following') : t('profile.follow')}
            active={following}
            onPress={onToggleFollow}
          />
        </>
      )}
      <RelationButton
        icon={postMeIcon}
        label={t('profile.postMe')}
        onPress={onPostMe}
      />
      <RelationButton
        icon={moreIcon}
        label={t('profile.more')}
        onPress={onMore}
      />
    </View>
  );
}

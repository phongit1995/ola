import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, ScrollView, Text, View } from 'react-native';
import Clipboard from '@react-native-clipboard/clipboard';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { colorForName } from '@ola/shared/lib';
import { RELATIONSHIP_STATUS } from '@ola/shared/constants';
import type { FollowUser } from '@ola/shared/types';
import { useThemeColors } from '@hooks/useThemeColors';
import { MediaViewerModal } from '@components/ui/MediaViewer';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { ReportDialog } from '@components/ui/ReportDialog';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import type { ProfileViewerState } from './interface';
import { useProfileActions } from './useProfileActions';
import { MeComposerModal } from '@screens/me/components/MeComposerModal';
import { ProfileCard } from './components/ProfileCard';
import { FollowingPreviewCard } from './components/FollowingPreviewCard';
import { ProfilePostList } from './components/ProfilePostList';
import { FollowingListOverlay } from './components/FollowingListOverlay';
import { PeerVipStoreDialog } from './components/PeerVipStoreDialog';

const composeIcon = require('@assets/icons/chat/ic_action_compose_message.png');

interface UserProfileScreenProps {
  username: string;
  language: string;
  onClose: () => void;
  onOpenProfile: (nick: string, color: string) => void;
  onMessage?: (userId: string) => void;
  onEditProfile?: () => void;
}

export function UserProfileScreen({
  username,
  language,
  onClose,
  onOpenProfile,
  onMessage,
  onEditProfile,
}: UserProfileScreenProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const insets = useSafeAreaInsets();
  const push = useToastStore(s => s.push);

  const {
    profile,
    loading,
    notFound,
    posts,
    setPosts,
    postsLoading,
    followingUsers,
    following,
    fans,
    kisses,
    uploadingCover,
    uploadingAvatar,
    isSelf,
    toggleFollow,
    kiss,
    reloadPosts,
    friendAction,
    blockAction,
    changeCover,
    changeAvatar,
  } = useProfileActions(username);

  const [menuOpen, setMenuOpen] = useState(false);
  const [reportOpen, setReportOpen] = useState(false);
  const [followingOpen, setFollowingOpen] = useState(false);
  const [followersOpen, setFollowersOpen] = useState(false);
  const [vipStoreOpen, setVipStoreOpen] = useState(false);
  const [composerOpen, setComposerOpen] = useState(false);
  const [viewer, setViewer] = useState<ProfileViewerState | null>(null);

  const openViewer = (images: string[], index = 0) =>
    setViewer({ images, index });
  const comingSoon = () => push('info', t('profile.comingSoon'));

  const nick =
    profile?.fullName != null && profile.fullName !== ''
      ? profile.fullName
      : profile?.username ?? username;
  const blockedByMe =
    profile?.relationship?.status === RELATIONSHIP_STATUS.blockedByMe;

  const openFriend = (friend: FollowUser) =>
    onOpenProfile(friend.username, colorForName(friend.username));

  const profileMenuOptions: ListOption[] = isSelf
    ? [
        {
          key: 'avatar',
          label: t('profile.changeAvatar'),
          onSelect: () => void changeAvatar(),
        },
        {
          key: 'cover',
          label: t('profile.changeCover'),
          onSelect: () => void changeCover(),
        },
        {
          key: 'privacy',
          label: t('profile.changePrivacy'),
          onSelect: comingSoon,
        },
      ]
    : [
        {
          key: 'block',
          label: blockedByMe ? t('profile.unblock') : t('profile.block'),
          danger: true,
          onSelect: blockAction,
        },
        {
          key: 'copy',
          label: t('profile.copyNick'),
          onSelect: () => Clipboard.setString(nick),
        },
        {
          key: 'report',
          label: t('profile.report'),
          onSelect: () => setReportOpen(true),
        },
      ];

  return (
    <View className="flex-1 bg-[#f3f3f3]">
      <ScreenHeader title={profile != null ? nick : ''} onBack={onClose} />

      {loading ? (
        <ActivityIndicator className="py-16" color={colors.primary} size="large" />
      ) : notFound || profile == null ? (
        <Text
          className="py-16 text-center text-sm text-ola-ink-soft"
        >
          {t('profile.notFound')}
        </Text>
      ) : (
        <ScrollView className="flex-1">
          <ProfileCard
            profile={profile}
            nick={nick}
            isSelf={isSelf}
            language={language}
            following={following}
            fans={fans}
            kisses={kisses}
            uploadingCover={uploadingCover}
            uploadingAvatar={uploadingAvatar}
            onChangeCover={() => void changeCover()}
            onKiss={kiss}
            onOpenFollowers={() => setFollowersOpen(true)}
            onOpenVipStore={() => setVipStoreOpen(true)}
            onFriendAction={friendAction}
            onToggleFollow={toggleFollow}
            onUnblock={blockAction}
            onUpdateInfo={onEditProfile ?? comingSoon}
            onPostMe={() => setComposerOpen(true)}
            onMore={() => setMenuOpen(true)}
            openViewer={openViewer}
            onOpenProfile={onOpenProfile}
          />

          <FollowingPreviewCard
            users={followingUsers}
            onViewAll={() => setFollowingOpen(true)}
            onOpenFriend={openFriend}
          />

          <ProfilePostList
            posts={posts}
            setPosts={setPosts}
            postsLoading={postsLoading}
            language={language}
            onOpenProfile={onOpenProfile}
            openViewer={openViewer}
            reloadPosts={reloadPosts}
          />
          <View style={{ height: 24 }} />
        </ScrollView>
      )}

      {profile != null && !isSelf && onMessage != null && (
        <Pressable
          onPress={() => onMessage(profile.id)}
          className="absolute h-14 w-14 items-center justify-center rounded-full bg-ola-primary"
          style={{
            right: 16,
            bottom: 16 + insets.bottom,
            elevation: 4,
            shadowColor: '#000',
            shadowOpacity: 0.3,
            shadowRadius: 4,
            shadowOffset: { width: 0, height: 2 },
          }}
        >
          <Image
            source={composeIcon}
            style={{ width: 28, height: 28, tintColor: '#fff' }}
            resizeMode="contain"
          />
        </Pressable>
      )}

      {composerOpen && (
        <MeComposerModal
          visible
          onClose={() => setComposerOpen(false)}
          onSaved={() => {
            if (isSelf) void reloadPosts();
          }}
        />
      )}

      <ListOptionDialog
        visible={menuOpen}
        title={nick}
        options={profileMenuOptions}
        onClose={() => setMenuOpen(false)}
      />

      {followingOpen && profile != null && (
        <FollowingListOverlay
          userId={profile.id}
          kind="following"
          onClose={() => setFollowingOpen(false)}
          onSelect={friend => {
            setFollowingOpen(false);
            openFriend(friend);
          }}
        />
      )}

      <MediaViewerModal
        images={viewer?.images ?? []}
        index={viewer?.index ?? 0}
        onClose={() => setViewer(null)}
      />

      {reportOpen && profile != null && (
        <ReportDialog
          target={{ type: 'account', id: profile.id }}
          onClose={() => setReportOpen(false)}
        />
      )}

      {vipStoreOpen && profile != null && (
        <PeerVipStoreDialog
          userId={profile.id}
          name={profile.username}
          onClose={() => setVipStoreOpen(false)}
        />
      )}

      {followersOpen && profile != null && (
        <FollowingListOverlay
          title={t('profile.peopleCare')}
          userId={profile.id}
          kind="followers"
          onClose={() => setFollowersOpen(false)}
          onSelect={friend => {
            setFollowersOpen(false);
            openFriend(friend);
          }}
        />
      )}
    </View>
  );
}

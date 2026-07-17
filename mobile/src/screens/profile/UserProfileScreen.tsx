import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  ImageBackground,
  Pressable,
  ScrollView,
  Text,
  View,
} from 'react-native';
import Clipboard from '@react-native-clipboard/clipboard';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import {
  MeService,
  UserService,
  RelationshipService,
} from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { usePostListActions } from '@ola/shared/stores/usePostListActions';
import {
  activeVipTypeId,
  colorForName,
  createDateFormatter,
  createTimeFormatter,
  postTimeLabel,
  profileFriendLabel,
  toApiError,
} from '@ola/shared/lib';
import type { FollowUser, Post, PublicProfile } from '@ola/shared/types';
import { EDIT_WINDOW_MS, MIN_IMAGE_SOURCE } from '@ola/shared/constants';
import { useMeLocalStore } from '@store/meLocalStore';
import { pickSingleImage } from '@lib/imagePicker';
import { MediaViewerModal } from '@components/ui/MediaViewer';
import { Avatar } from '@components/ui/Avatar';
import { VipAvatar } from '@components/ui/VipAvatar';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { MePostCard } from '@screens/me/MePostCard';
import { MeCommentSheet } from '@screens/me/MeCommentSheet';
import { MeLikersDialog } from '@screens/me/MeLikersDialog';
import {
  ListOptionDialog,
  type ListOption,
} from '@components/ui/ListOptionDialog';
import { ReportDialog } from '@components/ui/ReportDialog';
import { MeQuickCommentBar } from '@screens/me/MeQuickCommentBar';
import { MeComposerModal } from '@screens/me/MeComposerModal';
import { FollowingListOverlay } from './FollowingListOverlay';
import { PeerVipStoreDialog } from './PeerVipStoreDialog';
import { OlaModal } from '@components/ui/OlaModal';
import { ScreenHeader } from '@components/ui/ScreenHeader';

const checkedIcon = require('@assets/icons/profile/ic_checked.png');
const kissIcon = require('@assets/icons/profile/sticker_kiss.png');
const maleIcon = require('@assets/icons/profile/ic_indicate_male.png');
const femaleIcon = require('@assets/icons/profile/ic_indicate_female.png');
const marriageIcon = require('@assets/icons/profile/ic_profile_marriage.png');
const birthdayIcon = require('@assets/icons/profile/ic_profile_birthday.png');
const vipStoreIcon = require('@assets/icons/me/icon_vip.webp');
const addFriendIcon = require('@assets/icons/profile/ic_add_friend_black_disable.png');
const friendsActiveIcon = require('@assets/icons/profile/ic_state_friends.png');
const followIcon = require('@assets/icons/profile/ic_follow_black_disable.png');
const followingActiveIcon = require('@assets/icons/profile/ic_state_following.png');
const postMeIcon = require('@assets/icons/profile/ic_post_me_gray.png');
const moreIcon = require('@assets/icons/profile/ic_more_horizon_black_disable.png');
const editIcon = require('@assets/icons/profile/ic_edit_profile_gray.png');
const composeIcon = require('@assets/icons/chat/ic_action_compose_message.png');
const cameraIcon = require('@assets/icons/profile/ic_action_camera.png');

const DEFAULT_COVER_COLOR = '#33691e';

const CARD_SHADOW = {
  shadowColor: '#000',
  shadowOpacity: 0.18,
  shadowRadius: 2,
  shadowOffset: { width: 0, height: 1 },
  elevation: 2,
} as const;

interface UserProfileScreenProps {
  username: string;
  language: string;
  onClose: () => void;
  onOpenProfile: (nick: string, color: string) => void;
  onMessage?: (userId: string) => void;
  onEditProfile?: () => void;
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

export function UserProfileScreen(props: UserProfileScreenProps) {
  return (
    <OlaModal
      visible
      transparent
      animationType="slide"
      onRequestClose={props.onClose}
    >
      <UserProfileBody {...props} />
    </OlaModal>
  );
}

function UserProfileBody({
  username,
  language,
  onClose,
  onOpenProfile,
  onMessage,
  onEditProfile,
}: UserProfileScreenProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const push = useToastStore(s => s.push);
  const meId = useAuthStore(s => s.user?.id) ?? '';
  const refreshUser = useAuthStore(s => s.refreshUser);
  const hiddenPostIds = useMeLocalStore(s => s.hiddenPostIds);
  const hidePost = useMeLocalStore(s => s.hidePost);
  const blockAuthor = useMeLocalStore(s => s.blockAuthor);

  const [profile, setProfile] = useState<PublicProfile | null>(null);
  const [loading, setLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);
  const [posts, setPosts] = useState<Post[]>([]);
  const [postsLoading, setPostsLoading] = useState(true);
  const [followingUsers, setFollowingUsers] = useState<FollowUser[]>([]);
  const [following, setFollowing] = useState(false);
  const [fans, setFans] = useState(0);
  const [kisses, setKisses] = useState(0);
  const [commentPostId, setCommentPostId] = useState<string | null>(null);
  const [commentFocusInput, setCommentFocusInput] = useState(false);
  const [likersPostId, setLikersPostId] = useState<string | null>(null);
  const [menuOpen, setMenuOpen] = useState(false);
  const [reportOpen, setReportOpen] = useState(false);
  const [followingOpen, setFollowingOpen] = useState(false);
  const [followersOpen, setFollowersOpen] = useState(false);
  const [menuPostId, setMenuPostId] = useState<string | null>(null);
  const [quickCommentPostId, setQuickCommentPostId] = useState<string | null>(
    null,
  );
  const [quickSubmitting, setQuickSubmitting] = useState(false);
  const [deletePostId, setDeletePostId] = useState<string | null>(null);
  const [editingPost, setEditingPost] = useState<Post | null>(null);
  const [uploadingCover, setUploadingCover] = useState(false);
  const [uploadingAvatar, setUploadingAvatar] = useState(false);
  const [viewer, setViewer] = useState<{
    images: string[];
    index: number;
  } | null>(null);
  const [busy, setBusy] = useState(false);
  const [vipStoreOpen, setVipStoreOpen] = useState(false);

  const openViewer = (images: string[], index = 0) =>
    setViewer({ images, index });

  const formatDate = useMemo(() => createDateFormatter(language), [language]);
  const formatTime = useMemo(() => createTimeFormatter(language), [language]);
  const comingSoon = () => push('info', t('profile.comingSoon'));

  useEffect(() => {
    let active = true;
    setLoading(true);
    (async () => {
      try {
        const data = await UserService.publicProfile(username);
        if (!active) return;
        setProfile(data);
        setFollowing(data.relationship?.isFollowing ?? false);
        setFans(data.followerCount);
        setKisses(data.kisses);
        setNotFound(false);
        setLoading(false);
        if (data.id !== useAuthStore.getState().user?.id) {
          useMeLocalStore.getState().recordViewedProfile({
            id: data.id,
            username: data.username,
            fullName: data.fullName,
            avatar: data.avatar,
            vipTypeId: activeVipTypeId(data.vipUsed, data.vipEndTime),
          });
        }
        const canView = data.canViewInterested !== false;
        const [postsResult, followingResult] = await Promise.all([
          MeService.byUser(data.id, { limit: 30 }).catch(() => null),
          canView
            ? UserService.following(data.id, { limit: 12 }).catch(() => null)
            : Promise.resolve(null),
        ]);
        if (!active) return;
        setPosts(postsResult?.items ?? []);
        setFollowingUsers(followingResult?.users ?? []);
        setPostsLoading(false);
      } catch {
        if (!active) return;
        setNotFound(true);
        setLoading(false);
        setPostsLoading(false);
      }
    })();
    return () => {
      active = false;
    };
  }, [username]);

  const isSelf = profile != null && profile.id === meId;

  const visiblePosts = useMemo(() => {
    if (hiddenPostIds.length === 0) return posts;
    const hidden = new Set(hiddenPostIds);
    return posts.filter(p => !hidden.has(p.id));
  }, [posts, hiddenPostIds]);

  function toggleFollow() {
    if (profile == null || isSelf) return;
    const was = following;
    setFollowing(!was);
    setFans(n => Math.max(0, n + (was ? -1 : 1)));
    const call = was
      ? UserService.unfollow(profile.id)
      : UserService.follow(profile.id);
    call
      .then(res => {
        setFollowing(res.following);
        setFans(res.followerCount);
      })
      .catch(() => {
        setFollowing(was);
        setFans(n => Math.max(0, n + (was ? 1 : -1)));
        push('error', t('profile.actionError'));
      });
  }

  function kiss() {
    if (profile == null || isSelf) return;
    setKisses(k => k + 1);
    UserService.kiss(profile.id)
      .then(res => setKisses(res.kisses))
      .catch(() => {
        setKisses(k => Math.max(0, k - 1));
        push('error', t('profile.actionError'));
      });
  }

  const reload = useCallback(async () => {
    try {
      const data = await UserService.publicProfile(username);
      setProfile(data);
      setFollowing(data.relationship?.isFollowing ?? false);
      setFans(data.followerCount);
    } catch {
      /* ignore */
    }
  }, [username]);

  const reloadPosts = useCallback(async () => {
    if (profile == null) return;
    const result = await MeService.byUser(profile.id, { limit: 30 }).catch(
      () => null,
    );
    if (result != null) setPosts(result.items);
  }, [profile]);

  function runAndReload(op: Promise<unknown>) {
    setBusy(true);
    op.then(() => reload())
      .catch(() => push('error', t('profile.actionError')))
      .finally(() => setBusy(false));
  }

  function friendAction() {
    if (profile == null || busy) return;
    const status = profile.relationship?.status;
    const requestId = profile.relationship?.requestId;
    if (status === 'none' || status == null)
      runAndReload(RelationshipService.sendRequest(profile.id));
    else if (status === 'pending_outgoing' && requestId)
      runAndReload(RelationshipService.cancel(requestId));
    else if (status === 'pending_incoming' && requestId)
      runAndReload(RelationshipService.respond(requestId, 'accept'));
    else if (status === 'friend' && requestId)
      runAndReload(RelationshipService.unfriend(requestId));
  }

  function blockAction() {
    if (profile == null || busy) return;
    const status = profile.relationship?.status;
    const requestId = profile.relationship?.requestId;
    if (status === 'blocked_by_me' && requestId)
      runAndReload(RelationshipService.unblock(requestId));
    else runAndReload(RelationshipService.block(profile.id));
  }

  async function changeCover() {
    if (uploadingCover) return;
    const picked = await pickSingleImage();
    if (picked == null) return;
    setUploadingCover(true);
    try {
      const { url } = await UserService.uploadAvatar(picked.file);
      await UserService.updateMe({ coverPhoto: url });
      setProfile(p => (p != null ? { ...p, coverPhoto: url } : p));
      await refreshUser();
      push('success', t('profileEdit.coverUpdated'));
    } catch {
      push('error', t('profileEdit.coverError'));
    } finally {
      setUploadingCover(false);
    }
  }

  async function changeAvatar() {
    if (uploadingAvatar) return;
    const picked = await pickSingleImage();
    if (picked == null) return;
    if (
      picked.width > 0 &&
      picked.height > 0 &&
      Math.min(picked.width, picked.height) < MIN_IMAGE_SOURCE
    ) {
      push('error', t('avatar.tooSmall'));
      return;
    }
    setUploadingAvatar(true);
    try {
      const { url } = await UserService.uploadAvatar(picked.file);
      await UserService.updateMe({ avatar: url });
      setProfile(p => (p != null ? { ...p, avatar: url } : p));
      await refreshUser();
      push('success', t('profileEdit.avatarUpdated'));
    } catch {
      push('error', t('profileEdit.avatarError'));
    } finally {
      setUploadingAvatar(false);
    }
  }

  const { toggleReaction, adjustCommentCount, deletePost, togglePin } = usePostListActions({
    posts,
    setPosts,
    reloadAfterPin: reloadPosts,
  });

  function requestEdit(post: Post) {
    const createdAtMs =
      post.createdAt != null ? new Date(post.createdAt).getTime() : 0;
    if (Date.now() - createdAtMs > EDIT_WINDOW_MS) {
      push('info', t('me.editExpired'));
      return;
    }
    setEditingPost(post);
  }

  function togglePinAction(post: Post) {
    void togglePin(post.id, !post.isPinned);
  }

  function buildPostMenuOptions(post: Post): ListOption[] {
    const mine = meId !== '' && post.author?.id === meId;
    if (mine) {
      return [
        {
          key: 'edit',
          label: t('me.menuEdit'),
          onSelect: () => requestEdit(post),
        },
        {
          key: 'pin',
          label: post.isPinned ? t('me.menuUnpin') : t('me.menuPin'),
          onSelect: () => togglePinAction(post),
        },
        {
          key: 'delete',
          label: t('me.menuDelete'),
          danger: true,
          onSelect: () => setDeletePostId(post.id),
        },
      ];
    }
    return [
      {
        key: 'hide',
        label: t('me.menuHide'),
        onSelect: () => {
          hidePost(post.id);
          push('success', t('me.hideSuccess'));
        },
      },
      {
        key: 'save',
        label: t('me.menuSave'),
        onSelect: () => push('success', t('me.saveSuccess')),
      },
      {
        key: 'share',
        label: t('me.menuShare'),
        onSelect: () => push('success', t('me.shareSuccess')),
      },
      {
        key: 'block',
        label: t('me.menuBlock'),
        danger: true,
        onSelect: () => {
          const authorId = post.author?.id;
          if (authorId == null || authorId === '') return;
          blockAuthor(authorId);
          push('success', t('me.blockSuccess'));
        },
      },
    ];
  }

  async function submitQuickComment(text: string): Promise<boolean> {
    const id = quickCommentPostId;
    const content = text.trim();
    if (id == null || content === '') return false;
    setQuickSubmitting(true);
    try {
      await MeService.addComment(id, { content });
      adjustCommentCount(id, 1);
      push('success', t('me.commentSent'));
      setQuickCommentPostId(null);
      return true;
    } catch (err) {
      push(
        'error',
        toApiError(err).status === 403
          ? t('me.commentErrFriendsOnly')
          : t('me.commentSendError'),
      );
      return false;
    } finally {
      setQuickSubmitting(false);
    }
  }

  const commentPost =
    commentPostId != null
      ? posts.find(p => p.id === commentPostId) ?? null
      : null;
  const menuPost =
    menuPostId != null ? posts.find(p => p.id === menuPostId) ?? null : null;
  const quickPost =
    quickCommentPostId != null
      ? posts.find(p => p.id === quickCommentPostId) ?? null
      : null;

  const nick =
    profile?.fullName != null && profile.fullName !== ''
      ? profile.fullName
      : profile?.username ?? username;
  const friendStatus = profile?.relationship?.status;
  const isFriend = friendStatus === 'friend';
  const blockedByMe = friendStatus === 'blocked_by_me';
  const friendLabel = profileFriendLabel(t, friendStatus);

  const gender = profile?.gender === 'female' ? 'female' : 'male';
  const vipTypeId =
    profile != null
      ? activeVipTypeId(profile.vipUsed, profile.vipEndTime)
      : null;
  const joinDate =
    profile != null
      ? `${t('profile.joinedOla')} ${formatDate(profile.createdAt)}`
      : '';
  const birthday =
    profile?.dateOfBirth != null && profile.dateOfBirth !== ''
      ? formatDate(profile.dateOfBirth)
      : '';

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
      <ScreenHeader title={nick} onBack={onClose} />

      {loading ? (
        <ActivityIndicator className="py-16" color="#7cb342" size="large" />
      ) : notFound || profile == null ? (
        <Text
          className="py-16 text-center text-sm"
          style={{ color: 'rgba(0,0,0,0.54)' }}
        >
          {t('profile.notFound')}
        </Text>
      ) : (
        <ScrollView className="flex-1">
          <View className="mb-2 bg-white" style={CARD_SHADOW}>
            <View style={{ paddingBottom: 48 }}>
              <ImageBackground
                source={
                  profile.coverPhoto != null
                    ? { uri: profile.coverPhoto }
                    : undefined
                }
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
                    onPress={() => void changeCover()}
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
                    <Text className="text-sm text-white">
                      {t('common.loading')}
                    </Text>
                  </View>
                )}
              </ImageBackground>
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
                      <Avatar
                        name={nick}
                        uri={profile.avatar}
                        size={96}
                        rounded={false}
                      />
                    </Pressable>
                  ) : (
                    <Avatar name={nick} size={96} rounded={false} />
                  )}
                  {profile.spouse != null && (
                    <Pressable
                      onPress={() =>
                        onOpenProfile(
                          profile.spouse!.username,
                          colorForName(profile.spouse!.username),
                        )
                      }
                    >
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
                className="min-w-0 shrink text-lg"
                style={{ color: 'rgba(0,0,0,0.87)' }}
              >
                @{profile.username}
                {profile.fullName != null && profile.fullName !== '' && (
                  <Text style={{ color: 'rgba(0,0,0,0.54)' }}>
                    {' '}
                    · {profile.fullName}
                  </Text>
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

            <View
              className="mx-4"
              style={{ height: 1, backgroundColor: 'rgba(0,0,0,0.12)' }}
            />

            {blockedByMe && !isSelf ? (
              <View className="px-2 py-2">
                <Pressable
                  onPress={blockAction}
                  className="items-center rounded py-3 active:opacity-90"
                  style={{ backgroundColor: '#e34545' }}
                >
                  <Text className="text-sm font-medium text-white">
                    {t('profile.unblock')}
                  </Text>
                </Pressable>
              </View>
            ) : (
              <View className="flex-row px-2 py-2">
                {isSelf ? (
                  <RelationButton
                    icon={editIcon}
                    label={t('profile.updateInfo')}
                    onPress={onEditProfile ?? comingSoon}
                  />
                ) : (
                  <>
                    <RelationButton
                      icon={isFriend ? friendsActiveIcon : addFriendIcon}
                      label={friendLabel}
                      active={isFriend || friendStatus === 'pending_outgoing'}
                      onPress={friendAction}
                    />
                    <RelationButton
                      icon={following ? followingActiveIcon : followIcon}
                      label={
                        following ? t('profile.following') : t('profile.follow')
                      }
                      active={following}
                      onPress={toggleFollow}
                    />
                  </>
                )}
                <RelationButton
                  icon={postMeIcon}
                  label={t('profile.postMe')}
                  onPress={comingSoon}
                />
                <RelationButton
                  icon={moreIcon}
                  label={t('profile.more')}
                  onPress={() => setMenuOpen(true)}
                />
              </View>
            )}

            <View
              className="mx-4"
              style={{ height: 1, backgroundColor: 'rgba(0,0,0,0.12)' }}
            />

            <Pressable
              onPress={() => setFollowersOpen(true)}
              disabled={fans === 0}
              className="mt-4 flex-row items-center justify-center gap-1 rounded-lg py-1 active:bg-black/5"
            >
              <Text className="text-xl font-bold" style={{ color: '#000' }}>
                {fans}
              </Text>
              <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
                {t('profile.peopleCare')}
              </Text>
            </Pressable>

            <Pressable
              onPress={kiss}
              disabled={isSelf}
              className="mt-2 items-center gap-1"
            >
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
                className="mt-3 px-4 text-center text-xs"
                style={{ color: 'rgba(0,0,0,0.54)' }}
              >
                {profile.bio}
              </Text>
            )}

            {vipTypeId != null && (
              <View className="ml-4 mt-3 flex-row items-center gap-1">
                <VipAvatar typeId={vipTypeId} size={24} />
                <Text
                  className="text-xs font-bold"
                  style={{ color: '#ff4081' }}
                >
                  {t('profile.vipAccount')}
                </Text>
              </View>
            )}

            <View className="pb-4">
              <InfoRow
                icon={gender === 'female' ? femaleIcon : maleIcon}
                text={
                  gender === 'female'
                    ? t('profile.genderFemale')
                    : t('profile.genderMale')
                }
              />
              <InfoRow
                icon={marriageIcon}
                text={
                  profile.spouse != null ? (
                    <>
                      {t('marriage.marryWithLabel')}{' '}
                      <Text
                        style={{ color: '#33691e' }}
                        onPress={() =>
                          onOpenProfile(
                            profile.spouse!.username,
                            colorForName(profile.spouse!.username),
                          )
                        }
                      >
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
                <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
                  {joinDate}
                </Text>
              </View>
              {profile.canViewVipStore && (
                <Pressable
                  onPress={() => setVipStoreOpen(true)}
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

          {followingUsers.length > 0 && (
            <View className="mb-2 bg-white pb-1" style={CARD_SHADOW}>
              <Pressable
                onPress={() => setFollowingOpen(true)}
                className="flex-row items-center justify-between px-4 py-2 active:bg-black/5"
              >
                <Text
                  className="text-base"
                  style={{ color: 'rgba(0,0,0,0.87)' }}
                >
                  {t('profile.following')}
                </Text>
                <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.38)' }}>
                  {t('profile.viewAll')} ›
                </Text>
              </Pressable>
              <View className="flex-row gap-1 px-2">
                {followingUsers.slice(0, 5).map(friend => (
                  <Pressable
                    key={friend.id}
                    onPress={() => openFriend(friend)}
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
                        style={{
                          backgroundColor: colorForName(friend.username),
                        }}
                      >
                        <Text className="text-2xl font-medium text-white">
                          {friend.username.charAt(0).toUpperCase()}
                        </Text>
                      </View>
                    )}
                    <View className="absolute inset-x-0 bottom-0">
                      <View className="absolute inset-0">
                        <View
                          style={{
                            flex: 1,
                            backgroundColor: 'rgba(0,0,0,0.2)',
                          }}
                        />
                        <View
                          style={{
                            flex: 1,
                            backgroundColor: 'rgba(0,0,0,0.55)',
                          }}
                        />
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
                {followingUsers.length < 5 &&
                  Array.from({
                    length: 5 - Math.min(followingUsers.length, 5),
                  }).map((_, index) => (
                    <View key={`spacer-${index}`} className="flex-1" />
                  ))}
              </View>
            </View>
          )}

          <Text
            className="mx-4 mb-1 mt-2 text-base font-medium"
            style={{ color: 'rgba(0,0,0,0.87)' }}
          >
            {t('profile.mePosts')}
          </Text>
          {postsLoading && visiblePosts.length === 0 ? (
            <ActivityIndicator className="py-6" color="#7cb342" />
          ) : (
            visiblePosts.map(post => (
              <MePostCard
                key={post.id}
                post={post}
                timeLabel={postTimeLabel(post.createdAt, formatTime)}
                onToggleLike={id => void toggleReaction(id, 'like')}
                onToggleDislike={id => void toggleReaction(id, 'dislike')}
                onOpenProfile={onOpenProfile}
                onOpenComments={(id, focusInput) => {
                  setCommentFocusInput(focusInput === true);
                  setCommentPostId(id);
                }}
                onQuickComment={id => setQuickCommentPostId(id)}
                onOpenMenu={id => setMenuPostId(id)}
                onOpenLikers={id => setLikersPostId(id)}
                onOpenPhotos={(photos, index) => openViewer(photos, index)}
              />
            ))
          )}
          <View style={{ height: 24 }} />
        </ScrollView>
      )}

      {commentPost != null && (
        <MeCommentSheet
          post={commentPost}
          language={language}
          autoFocusInput={commentFocusInput}
          onClose={() => setCommentPostId(null)}
          onToggleLike={id => void toggleReaction(id, 'like')}
          onToggleDislike={id => void toggleReaction(id, 'dislike')}
          onOpenProfile={onOpenProfile}
          onOpenLikers={id => setLikersPostId(id)}
          onCommentDelta={adjustCommentCount}
        />
      )}

      {likersPostId != null && (
        <MeLikersDialog
          postId={likersPostId}
          onClose={() => setLikersPostId(null)}
          onOpenProfile={onOpenProfile}
        />
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
            style={{ width: 24, height: 24, tintColor: '#fff' }}
            resizeMode="contain"
          />
        </Pressable>
      )}

      <ListOptionDialog
        visible={menuOpen}
        title={nick}
        options={profileMenuOptions}
        onClose={() => setMenuOpen(false)}
      />

      <ListOptionDialog
        visible={menuPost != null}
        title={t('me.postMenu')}
        options={menuPost != null ? buildPostMenuOptions(menuPost) : []}
        onClose={() => setMenuPostId(null)}
      />

      {quickCommentPostId != null && (
        <MeQuickCommentBar
          contextLabel={
            quickPost == null
              ? undefined
              : quickPost.content != null && quickPost.content !== ''
              ? quickPost.content
              : quickPost.author?.username
          }
          submitting={quickSubmitting}
          onSubmit={submitQuickComment}
          onClose={() => setQuickCommentPostId(null)}
        />
      )}

      <ConfirmDialog
        visible={deletePostId != null}
        danger
        title={t('me.deleteConfirmTitle')}
        message={t('me.deleteConfirmText')}
        confirmLabel={t('me.deleteConfirmOk')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => {
          const id = deletePostId;
          setDeletePostId(null);
          if (id == null) return;
          void deletePost(id);
        }}
        onCancel={() => setDeletePostId(null)}
      />

      {editingPost != null && (
        <MeComposerModal
          visible
          editPost={editingPost}
          onSaved={() => void reloadPosts()}
          onClose={() => setEditingPost(null)}
        />
      )}

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

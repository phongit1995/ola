import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  ImageBackground,
  Modal,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { MeService, UserService, RelationshipService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { applyPostReaction } from '@ola/shared/stores/postHelpers';
import {
  activeVipTypeId,
  colorForName,
  createDateFormatter,
  createTimeFormatter,
  formatDateDMY,
  isSameDay,
} from '@ola/shared/lib';
import type { Post, PublicProfile } from '@ola/shared/types';
import { Avatar } from '../../components/Avatar';
import { VipAvatar } from '../../components/VipAvatar';
import { MePostCard } from '../me/MePostCard';
import { MeCommentSheet } from '../me/MeCommentSheet';
import { MeLikersDialog } from '../me/MeLikersDialog';
import type { MessageSheetAction } from '../room/MessageActionSheet';

const checkedIcon = require('../../assets/icons/profile/ic_checked.png');
const kissIcon = require('../../assets/icons/profile/sticker_kiss.png');
const maleIcon = require('../../assets/icons/profile/ic_indicate_male.png');
const femaleIcon = require('../../assets/icons/profile/ic_indicate_female.png');
const marriageIcon = require('../../assets/icons/profile/ic_profile_marriage.png');
const birthdayIcon = require('../../assets/icons/profile/ic_profile_birthday.png');
const noteIcon = require('../../assets/icons/profile/ic_profile_note.png');
const addFriendIcon = require('../../assets/icons/profile/ic_add_friend_black_disable.png');
const friendsActiveIcon = require('../../assets/icons/profile/ic_state_friends.png');
const followIcon = require('../../assets/icons/profile/ic_follow_black_disable.png');
const followingActiveIcon = require('../../assets/icons/profile/ic_state_following.png');
const postMeIcon = require('../../assets/icons/profile/ic_post_me_gray.png');
const moreIcon = require('../../assets/icons/profile/ic_more_horizon_black_disable.png');
const editIcon = require('../../assets/icons/profile/ic_edit_profile_gray.png');
const composeIcon = require('../../assets/icons/chat/ic_action_compose_message.png');

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
      <Image source={icon} style={{ width: 20, height: 20 }} resizeMode="contain" />
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

function InfoRow({ icon, text }: { icon: number; text: string }) {
  if (text === '') return null;
  return (
    <View className="ml-4 mt-2 flex-row items-center gap-1">
      <Image source={icon} style={{ width: 14, height: 14 }} resizeMode="contain" />
      <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>{text}</Text>
    </View>
  );
}

export function UserProfileScreen({ username, language, onClose, onOpenProfile, onMessage, onEditProfile }: UserProfileScreenProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const push = useToastStore((s) => s.push);
  const meId = useAuthStore((s) => s.user?.id) ?? '';

  const [profile, setProfile] = useState<PublicProfile | null>(null);
  const [loading, setLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);
  const [posts, setPosts] = useState<Post[]>([]);
  const [postsLoading, setPostsLoading] = useState(true);
  const [following, setFollowing] = useState(false);
  const [fans, setFans] = useState(0);
  const [kisses, setKisses] = useState(0);
  const [commentPostId, setCommentPostId] = useState<string | null>(null);
  const [likersPostId, setLikersPostId] = useState<string | null>(null);
  const [menuOpen, setMenuOpen] = useState(false);
  const [busy, setBusy] = useState(false);

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
        const result = await MeService.byUser(data.id, { limit: 30 }).catch(() => null);
        if (!active) return;
        setPosts(result?.items ?? []);
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

  function toggleFollow() {
    if (profile == null || isSelf) return;
    const was = following;
    setFollowing(!was);
    setFans((n) => Math.max(0, n + (was ? -1 : 1)));
    const call = was ? UserService.unfollow(profile.id) : UserService.follow(profile.id);
    call
      .then((res) => {
        setFollowing(res.following);
        setFans(res.followerCount);
      })
      .catch(() => {
        setFollowing(was);
        setFans((n) => Math.max(0, n + (was ? 1 : -1)));
        push('error', t('profile.actionError'));
      });
  }

  function kiss() {
    if (profile == null || isSelf) return;
    setKisses((k) => k + 1);
    UserService.kiss(profile.id)
      .then((res) => setKisses(res.kisses))
      .catch(() => {
        setKisses((k) => Math.max(0, k - 1));
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
    if (status === 'none' || status == null) runAndReload(RelationshipService.sendRequest(profile.id));
    else if (status === 'pending_outgoing' && requestId) runAndReload(RelationshipService.cancel(requestId));
    else if (status === 'pending_incoming' && requestId) runAndReload(RelationshipService.respond(requestId, 'accept'));
    else if (status === 'friend' && requestId) runAndReload(RelationshipService.unfriend(requestId));
  }

  function blockAction() {
    if (profile == null || busy) return;
    const status = profile.relationship?.status;
    const requestId = profile.relationship?.requestId;
    if (status === 'blocked_by_me' && requestId) runAndReload(RelationshipService.unblock(requestId));
    else runAndReload(RelationshipService.block(profile.id));
  }

  const toggleReaction = useCallback(
    async (id: string, type: 'like' | 'dislike') => {
      const current = posts.find((p) => p.id === id);
      if (current == null) return;
      const active = current.myReaction === type;
      setPosts((prev) => prev.map((p) => (p.id === id ? applyPostReaction(p, active ? null : type) : p)));
      try {
        const updated = active ? await MeService.removeReaction(id) : await MeService.react(id, type);
        setPosts((prev) => prev.map((p) => (p.id === id ? updated : p)));
      } catch {
        setPosts((prev) => prev.map((p) => (p.id === id ? current : p)));
      }
    },
    [posts]
  );

  const adjustCommentCount = useCallback((id: string, delta: number) => {
    setPosts((prev) =>
      prev.map((p) => (p.id === id ? { ...p, commentCount: Math.max(0, p.commentCount + delta) } : p))
    );
  }, []);

  const commentPost = commentPostId != null ? posts.find((p) => p.id === commentPostId) ?? null : null;

  function timeLabelOf(post: Post): string {
    return isSameDay(post.createdAt, new Date().toISOString())
      ? formatTime(post.createdAt)
      : formatDateDMY(post.createdAt);
  }

  const nick = profile?.username ?? username;
  const friendStatus = profile?.relationship?.status;
  const isFriend = friendStatus === 'friend';
  const friendLabel = isFriend
    ? t('profile.alreadyFriend')
    : friendStatus === 'pending_outgoing'
      ? t('profile.requestSent')
      : friendStatus === 'pending_incoming'
        ? t('profile.acceptFriend')
        : t('profile.makeFriend');

  const gender = profile?.gender === 'female' ? 'female' : 'male';
  const vipTypeId = profile != null ? activeVipTypeId(profile.vipUsed, profile.vipEndTime) : null;
  const joinDate = profile != null ? `${t('profile.joinedOla')} ${formatDate(profile.createdAt)}` : '';
  const birthday = profile?.dateOfBirth != null && profile.dateOfBirth !== '' ? formatDate(profile.dateOfBirth) : '';
  const marriageText = profile?.spouse != null
    ? `${t('marriage.marryWithLabel')} @${profile.spouse.username}`
    : t('profile.marriageSingle');

  const menuActions: MessageSheetAction[] = isSelf
    ? [
        { key: 'avatar', label: t('profile.changeAvatar'), onSelect: comingSoon },
        { key: 'cover', label: t('profile.changeCover'), onSelect: comingSoon },
        { key: 'privacy', label: t('profile.changePrivacy'), onSelect: comingSoon },
      ]
    : [
        {
          key: 'block',
          label: profile?.relationship?.status === 'blocked_by_me' ? t('profile.unblock') : t('profile.block'),
          destructive: true,
          onSelect: blockAction,
        },
        { key: 'copy', label: t('profile.copyNick'), onSelect: comingSoon },
        { key: 'report', label: t('profile.report'), onSelect: comingSoon },
      ];

  return (
    <Modal visible transparent animationType="slide" onRequestClose={onClose}>
      <View className="flex-1 bg-[#f3f3f3]">
        <View className="flex-row items-center bg-ola-primary px-1" style={{ paddingTop: insets.top }}>
          <Pressable onPress={onClose} className="h-12 w-10 items-center justify-center">
            <Text className="text-2xl leading-none text-white">‹</Text>
          </Pressable>
          <Text numberOfLines={1} className="flex-1 text-sm font-bold text-white">{nick}</Text>
          <View className="w-10" />
        </View>

        {loading ? (
          <ActivityIndicator className="py-16" color="#7cb342" size="large" />
        ) : notFound || profile == null ? (
          <Text className="py-16 text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('profile.notFound')}
          </Text>
        ) : (
          <ScrollView className="flex-1">
            <View className="mb-2 bg-white">
              <ImageBackground
                source={profile.coverPhoto != null ? { uri: profile.coverPhoto } : undefined}
                style={{ width: '100%', aspectRatio: 16 / 9, backgroundColor: colorForName(nick) }}
              >
                <View className="absolute -bottom-12 left-1/2 flex-row gap-1 bg-white p-px" style={{ transform: [{ translateX: -49 }] }}>
                  <Avatar name={nick} uri={profile.avatar ?? undefined} size={96} />
                  {profile.spouse != null && (
                    <Pressable onPress={() => onOpenProfile(profile.spouse!.username, colorForName(profile.spouse!.username))}>
                      <Avatar name={profile.spouse.username} uri={profile.spouse.avatar ?? undefined} size={96} />
                    </Pressable>
                  )}
                </View>
              </ImageBackground>

              <View className="mt-14 flex-row items-center justify-center gap-1 p-2">
                <Text numberOfLines={1} className="text-lg" style={{ color: 'rgba(0,0,0,0.87)' }}>
                  @{profile.username}
                  {profile.fullName != null && profile.fullName !== '' && (
                    <Text style={{ color: 'rgba(0,0,0,0.54)' }}> {profile.fullName}</Text>
                  )}
                </Text>
                {profile.verified && <Image source={checkedIcon} style={{ width: 18, height: 18 }} resizeMode="contain" />}
              </View>

              <View className="mx-4" style={{ height: 1, backgroundColor: 'rgba(0,0,0,0.12)' }} />

              <View className="flex-row px-2 py-2">
                {isSelf ? (
                  <RelationButton icon={editIcon} label={t('profile.updateInfo')} onPress={onEditProfile ?? comingSoon} />
                ) : (
                  <>
                    <RelationButton icon={isFriend ? friendsActiveIcon : addFriendIcon} label={friendLabel} active={isFriend || friendStatus === 'pending_outgoing'} onPress={friendAction} />
                    <RelationButton icon={following ? followingActiveIcon : followIcon} label={following ? t('profile.following') : t('profile.follow')} active={following} onPress={toggleFollow} />
                  </>
                )}
                <RelationButton icon={postMeIcon} label={t('profile.postMe')} onPress={comingSoon} />
                <RelationButton icon={moreIcon} label={t('profile.more')} onPress={() => setMenuOpen(true)} />
              </View>

              <View className="mx-4" style={{ height: 1, backgroundColor: 'rgba(0,0,0,0.12)' }} />

              <View className="mt-4 flex-row items-center justify-center gap-1">
                <Text className="text-xl font-bold" style={{ color: '#000' }}>{fans}</Text>
                <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>{t('profile.peopleCare')}</Text>
              </View>

              <Pressable onPress={kiss} disabled={isSelf} className="mt-2 items-center gap-1">
                <Image source={kissIcon} style={{ height: 64, width: 64 }} resizeMode="contain" />
                <Text className="text-sm" style={{ color: '#000' }}>
                  {kisses > 0 ? t('profile.kissCount', { count: kisses }) : t('profile.notKissed')}
                </Text>
              </Pressable>

              {profile.bio != null && profile.bio !== '' && (
                <Text numberOfLines={5} className="mt-3 px-4 text-center text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
                  {profile.bio}
                </Text>
              )}

              {vipTypeId != null && (
                <View className="ml-4 mt-3 flex-row items-center gap-1">
                  <VipAvatar typeId={vipTypeId} size={22} />
                  <Text className="text-xs font-bold" style={{ color: '#ff4081' }}>{t('profile.vipAccount')}</Text>
                </View>
              )}

              <View className="pb-4">
                <InfoRow icon={gender === 'female' ? femaleIcon : maleIcon} text={gender === 'female' ? t('profile.genderFemale') : t('profile.genderMale')} />
                <InfoRow icon={marriageIcon} text={marriageText} />
                <InfoRow icon={birthdayIcon} text={birthday} />
                <View className="ml-4 mt-2"><Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>{joinDate}</Text></View>
                <InfoRow icon={noteIcon} text={t('profile.viewNote')} />
              </View>
            </View>

            <Text className="mx-4 mb-1 mt-2 text-base font-medium" style={{ color: 'rgba(0,0,0,0.87)' }}>
              {t('profile.mePosts')}
            </Text>
            {postsLoading && posts.length === 0 ? (
              <ActivityIndicator className="py-6" color="#7cb342" />
            ) : (
              posts.map((post) => (
                <MePostCard
                  key={post.id}
                  post={post}
                  timeLabel={timeLabelOf(post)}
                  onToggleLike={(id) => void toggleReaction(id, 'like')}
                  onToggleDislike={(id) => void toggleReaction(id, 'dislike')}
                  onOpenProfile={onOpenProfile}
                  onOpenComments={(id) => setCommentPostId(id)}
                  onOpenMenu={comingSoon}
                  onOpenLikers={(id) => setLikersPostId(id)}
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
            onClose={() => setCommentPostId(null)}
            onToggleLike={(id) => void toggleReaction(id, 'like')}
            onToggleDislike={(id) => void toggleReaction(id, 'dislike')}
            onOpenProfile={onOpenProfile}
            onOpenLikers={(id) => setLikersPostId(id)}
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
            style={{ right: 16, bottom: 16, elevation: 4, shadowColor: '#000', shadowOpacity: 0.3, shadowRadius: 4, shadowOffset: { width: 0, height: 2 } }}
          >
            <Image source={composeIcon} style={{ width: 24, height: 24, tintColor: '#fff' }} resizeMode="contain" />
          </Pressable>
        )}

        {menuOpen && (
          <View style={StyleSheet.absoluteFill}>
            <Pressable style={[StyleSheet.absoluteFill, { backgroundColor: 'rgba(0,0,0,0.4)' }]} onPress={() => setMenuOpen(false)} />
            <View
              className="absolute bottom-0 left-0 right-0 rounded-t-2xl bg-white"
              style={{ paddingBottom: Math.max(insets.bottom, 8) }}
            >
              {menuActions.map((action) => (
                <Pressable
                  key={action.key}
                  onPress={() => {
                    setMenuOpen(false);
                    action.onSelect();
                  }}
                  className="flex-row items-center gap-3 px-5 py-3 active:bg-neutral-100"
                >
                  <Text className="text-base" style={{ color: action.destructive ? '#e34545' : 'rgba(0,0,0,0.87)' }}>
                    {action.label}
                  </Text>
                </Pressable>
              ))}
              <Pressable onPress={() => setMenuOpen(false)} className="items-center px-5 py-3 active:bg-neutral-100">
                <Text className="text-base font-medium" style={{ color: 'rgba(0,0,0,0.54)' }}>{t('dialog.cancel')}</Text>
              </Pressable>
            </View>
          </View>
        )}
      </View>
    </Modal>
  );
}

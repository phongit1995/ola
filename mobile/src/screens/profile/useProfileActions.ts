import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { MeService, RelationshipService, UserService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { useMeLocalStore } from '@store/meLocalStore';
import { activeVipTypeId } from '@ola/shared/lib';
import { MIN_IMAGE_SOURCE, RELATIONSHIP_STATUS } from '@ola/shared/constants';
import type { FollowUser, Post, PublicProfile } from '@ola/shared/types';
import { pickSingleImage } from '@lib/imagePicker';
import { FOLLOWING_PREVIEW_LIMIT, POSTS_PAGE_SIZE } from './constants';

export function useProfileActions(username: string) {
  const { t } = useTranslation();
  const push = useToastStore(s => s.push);
  const meId = useAuthStore(s => s.user?.id) ?? '';
  const refreshUser = useAuthStore(s => s.refreshUser);

  const [profile, setProfile] = useState<PublicProfile | null>(null);
  const [loading, setLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);
  const [posts, setPosts] = useState<Post[]>([]);
  const [postsLoading, setPostsLoading] = useState(true);
  const [followingUsers, setFollowingUsers] = useState<FollowUser[]>([]);
  const [following, setFollowing] = useState(false);
  const [fans, setFans] = useState(0);
  const [kisses, setKisses] = useState(0);
  const [busy, setBusy] = useState(false);
  const [uploadingCover, setUploadingCover] = useState(false);
  const [uploadingAvatar, setUploadingAvatar] = useState(false);

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
          MeService.byUser(data.id, { limit: POSTS_PAGE_SIZE }).catch(() => null),
          canView
            ? UserService.following(data.id, { limit: FOLLOWING_PREVIEW_LIMIT }).catch(() => null)
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
    const result = await MeService.byUser(profile.id, { limit: POSTS_PAGE_SIZE }).catch(
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
    if (status === RELATIONSHIP_STATUS.none || status == null)
      runAndReload(RelationshipService.sendRequest(profile.id));
    else if (status === RELATIONSHIP_STATUS.pendingOutgoing && requestId)
      runAndReload(RelationshipService.cancel(requestId));
    else if (status === RELATIONSHIP_STATUS.pendingIncoming && requestId)
      runAndReload(RelationshipService.respond(requestId, 'accept'));
    else if (status === RELATIONSHIP_STATUS.friend && requestId)
      runAndReload(RelationshipService.unfriend(requestId));
  }

  function blockAction() {
    if (profile == null || busy) return;
    const status = profile.relationship?.status;
    const requestId = profile.relationship?.requestId;
    if (status === RELATIONSHIP_STATUS.blockedByMe && requestId)
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

  return {
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
    isSelf,
    toggleFollow,
    kiss,
    reloadPosts,
    friendAction,
    blockAction,
    changeCover,
    changeAvatar,
  };
}

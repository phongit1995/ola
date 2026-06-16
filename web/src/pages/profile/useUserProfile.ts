import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { MeService, RelationshipService, UserService } from '@services';
import { colorForName, createDateFormatter, createTimeFormatter, toast } from '@lib';
import type { FollowUser, Post, PublicProfile, RelationshipInfo } from '@app-types';
import { toMePost } from '../me/mappers';
import type { ProfileActions, UserProfile } from './types';

const DEFAULT_COVER_COLOR = '#33691e';
const NO_RELATIONSHIP: RelationshipInfo = { status: 'none', isFollowing: false, followsMe: false };

function formatBirthday(iso: string): string {
  const [, month, day] = iso.split('-');
  if (!day || !month) return iso;
  return `${day}/${month}`;
}

export function useUserProfile(username: string, seedColor: string) {
  const { t, i18n } = useTranslation();
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [loading, setLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);
  const [userId, setUserId] = useState('');
  const [relationship, setRelationship] = useState<RelationshipInfo>(NO_RELATIONSHIP);
  const [busy, setBusy] = useState(false);

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const formatDate = useMemo(() => createDateFormatter(i18n.language), [i18n.language]);

  const mapProfile = useCallback(
    (data: PublicProfile, posts: Post[], following: FollowUser[]): UserProfile => {
      const nick = data.fullName && data.fullName !== '' ? data.fullName : data.username;
      return {
        nick,
        color: seedColor !== '' ? seedColor : colorForName(data.username),
        coverColor: DEFAULT_COVER_COLOR,
        verified: data.verified,
        vip: Boolean(data.vipUsed),
        fans: data.followerCount,
        kisses: data.kisses,
        bio: data.bio ?? '',
        gender: data.gender,
        marriage: t(data.marriage === 'married' ? 'profile.marriageMarried' : 'profile.marriageSingle'),
        birthday: data.dateOfBirth ? formatBirthday(data.dateOfBirth) : '',
        joinDate: `${t('profile.joinedOla')} ${formatDate(data.createdAt)}`,
        media: [],
        following: following.map((u) => ({ name: u.username, color: colorForName(u.username) })),
        posts: posts.map((post) => toMePost(post, formatTime)),
        isSelf: data.relationship?.status === 'self',
      };
    },
    [seedColor, t, formatTime, formatDate]
  );

  const load = useCallback(async () => {
    const data = await UserService.publicProfile(username);
    const [postsResult, followingResult] = await Promise.all([
      MeService.byUser(data.id, { limit: 30 }).catch(() => null),
      UserService.following(data.id, { limit: 12 }).catch(() => null),
    ]);
    setUserId(data.id);
    setRelationship(data.relationship ?? NO_RELATIONSHIP);
    setProfile(mapProfile(data, postsResult?.items ?? [], followingResult?.users ?? []));
    setNotFound(false);
  }, [username, mapProfile]);

  useEffect(() => {
    let active = true;
    // eslint-disable-next-line react-hooks/set-state-in-effect -- fetch bất đồng bộ: setState chạy sau await, không gây cascading render
    load()
      .catch(() => {
        if (active) {
          setProfile(null);
          setNotFound(true);
        }
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [load]);

  const kiss = useCallback(() => {
    if (userId === '') return;
    setProfile((p) => (p ? { ...p, kisses: p.kisses + 1 } : p));
    UserService.kiss(userId)
      .then((r) => setProfile((p) => (p ? { ...p, kisses: r.kisses } : p)))
      .catch(() => {
        setProfile((p) => (p ? { ...p, kisses: Math.max(0, p.kisses - 1) } : p));
        toast.error(t('profile.actionError'));
      });
  }, [userId, t]);

  const toggleFollow = useCallback(() => {
    if (userId === '') return;
    const wasFollowing = relationship.isFollowing;
    setRelationship((r) => ({ ...r, isFollowing: !wasFollowing }));
    setProfile((p) => (p ? { ...p, fans: Math.max(0, p.fans + (wasFollowing ? -1 : 1)) } : p));
    const call = wasFollowing ? UserService.unfollow(userId) : UserService.follow(userId);
    call
      .then((res) => {
        setRelationship((r) => ({ ...r, isFollowing: res.following }));
        setProfile((p) => (p ? { ...p, fans: res.followerCount } : p));
      })
      .catch(() => {
        setRelationship((r) => ({ ...r, isFollowing: wasFollowing }));
        setProfile((p) => (p ? { ...p, fans: Math.max(0, p.fans + (wasFollowing ? 1 : -1)) } : p));
        toast.error(t('profile.actionError'));
      });
  }, [userId, relationship.isFollowing, t]);

  const runAndReload = useCallback(
    (op: Promise<unknown>) => {
      setBusy(true);
      op
        .then(() => load())
        .catch(() => toast.error(t('profile.actionError')))
        .finally(() => setBusy(false));
    },
    [load, t]
  );

  const friendAction = useCallback(() => {
    if (userId === '' || busy) return;
    const { status, requestId } = relationship;
    if (status === 'none') runAndReload(RelationshipService.sendRequest(userId));
    else if (status === 'pending_outgoing' && requestId) runAndReload(RelationshipService.cancel(requestId));
    else if (status === 'pending_incoming' && requestId)
      runAndReload(RelationshipService.respond(requestId, 'accept'));
    else if (status === 'friend' && requestId) runAndReload(RelationshipService.unfriend(requestId));
  }, [userId, busy, relationship, runAndReload]);

  const blockAction = useCallback(() => {
    if (userId === '' || busy) return;
    const { status, requestId } = relationship;
    if (status === 'blocked_by_me' && requestId) runAndReload(RelationshipService.unblock(requestId));
    else runAndReload(RelationshipService.block(userId));
  }, [userId, busy, relationship, runAndReload]);

  const actions: ProfileActions = useMemo(
    () => ({ kiss, toggleFollow, friendAction, blockAction }),
    [kiss, toggleFollow, friendAction, blockAction]
  );

  return { profile, loading, notFound, userId, relationship, busy, actions };
}

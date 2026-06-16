import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { MeService, UserService } from '@services';
import { createDateFormatter, createTimeFormatter } from '@lib';
import type { RelationshipInfo } from '@app-types';
import { mapFollowing, mapPosts, mapPublicProfile, type ProfileMapDeps } from './mappers';
import { useProfileActions } from './useProfileActions';
import type { ProfileController, ProfileSecondary, UserProfile } from './types';

const NO_RELATIONSHIP: RelationshipInfo = { status: 'none', isFollowing: false, followsMe: false };
const EMPTY_SECONDARY: ProfileSecondary = { media: [], following: [], posts: [], loading: false };

export function useUserProfile(username: string, seedColor: string): ProfileController {
  const { t, i18n } = useTranslation();
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [loading, setLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);
  const [userId, setUserId] = useState('');
  const [relationship, setRelationship] = useState<RelationshipInfo>(NO_RELATIONSHIP);
  const [secondary, setSecondary] = useState<ProfileSecondary>(EMPTY_SECONDARY);

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const formatDate = useMemo(() => createDateFormatter(i18n.language), [i18n.language]);

  const mapDeps = useMemo<ProfileMapDeps>(
    () => ({
      seedColor,
      marriedLabel: t('profile.marriageMarried'),
      singleLabel: t('profile.marriageSingle'),
      joinedLabel: t('profile.joinedOla'),
      formatDate,
    }),
    [seedColor, t, formatDate]
  );

  const loadProfile = useCallback(async () => {
    const data = await UserService.publicProfile(username);
    setUserId(data.id);
    setRelationship(data.relationship ?? NO_RELATIONSHIP);
    setProfile(mapPublicProfile(data, mapDeps));
    setNotFound(false);
    return data.id;
  }, [username, mapDeps]);

  const loadSecondary = useCallback(
    async (id: string) => {
      setSecondary((s) => ({ ...s, loading: true }));
      const [postsResult, followingResult] = await Promise.all([
        MeService.byUser(id, { limit: 30 }).catch(() => null),
        UserService.following(id, { limit: 12 }).catch(() => null),
      ]);
      setSecondary({
        media: [],
        following: mapFollowing(followingResult?.users ?? []),
        posts: mapPosts(postsResult?.items ?? [], formatTime),
        loading: false,
      });
    },
    [formatTime]
  );

  const reload = useCallback(async () => {
    await loadProfile();
  }, [loadProfile]);

  useEffect(() => {
    let active = true;
    // eslint-disable-next-line react-hooks/set-state-in-effect -- fetch bất đồng bộ: setState chạy sau await, không gây cascading render
    loadProfile()
      .then((id) => {
        if (!active) return;
        setLoading(false);
        void loadSecondary(id).catch(() => undefined);
      })
      .catch(() => {
        if (!active) return;
        setProfile(null);
        setNotFound(true);
        setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [loadProfile, loadSecondary]);

  const { actions, busy } = useProfileActions({ userId, relationship, setRelationship, setProfile, reload });

  return { profile, loading, notFound, relationship, busy, actions, secondary };
}

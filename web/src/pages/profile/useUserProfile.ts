import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { MeService, UserService } from '@services';
import { createDateFormatter, createTimeFormatter, toast } from '@lib';
import type { PostReaction, RelationshipInfo } from '@app-types';
import { applyMeReaction, toMePost } from '../me/mappers';
import type { MePost } from '../me/types';
import type { ComposedPost } from '../me/components/MeComposerDialog';
import { composedToImages, composedToPayload } from '../me/composer';
import { mapFollowing, mapPosts, mapPublicProfile, type ProfileMapDeps } from './mappers';
import { useProfileActions } from './useProfileActions';
import type { ProfileController, ProfilePostActions, ProfileSecondary, UserProfile } from './types';
import { EMPTY_SECONDARY, NO_RELATIONSHIP } from './constants';

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
      marriedWith: (nick: string) => t('marriage.marryWith', { nick }),
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

  const postsRef = useRef(secondary.posts);
  useEffect(() => {
    postsRef.current = secondary.posts;
  }, [secondary.posts]);

  const setPost = useCallback((id: string, next: (post: MePost) => MePost) => {
    setSecondary((s) => ({ ...s, posts: s.posts.map((p) => (p.id === id ? next(p) : p)) }));
  }, []);

  const toggleReaction = useCallback(
    async (id: string, type: PostReaction) => {
      const current = postsRef.current.find((p) => p.id === id);
      if (current == null) return;
      const wasActive = type === 'like' ? current.liked : current.disliked;
      setPost(id, (p) => applyMeReaction(p, type));
      try {
        const updated = wasActive
          ? await MeService.removeReaction(id)
          : await MeService.react(id, type);
        const mapped = toMePost(updated, formatTime);
        setPost(id, (p) => ({ ...mapped, color: p.color }));
      } catch {
        setPost(id, () => current);
        toast.error(t('me.reactionError'));
      }
    },
    [setPost, formatTime, t]
  );

  const adjustCommentCount = useCallback(
    (id: string, delta: number) => {
      setPost(id, (p) => ({ ...p, comments: Math.max(0, p.comments + delta) }));
    },
    [setPost]
  );

  const editPost = useCallback(
    async (id: string, draft: ComposedPost): Promise<boolean> => {
      try {
        const images = await composedToImages(draft, 'existingFirst');
        const updated = await MeService.update(id, { ...composedToPayload(draft), images });
        const mapped = toMePost(updated, formatTime);
        setPost(id, (p) => ({ ...mapped, color: p.color }));
        toast.success(t('me.editSuccess'));
        return true;
      } catch {
        toast.error(t('me.editError'));
        return false;
      }
    },
    [setPost, formatTime, t]
  );

  const deletePost = useCallback(
    async (id: string) => {
      try {
        await MeService.remove(id);
        setSecondary((s) => ({ ...s, posts: s.posts.filter((p) => p.id !== id) }));
        toast.success(t('me.deleteSuccess'));
      } catch {
        toast.error(t('me.deleteError'));
      }
    },
    [t]
  );

  const togglePin = useCallback(
    async (id: string, pinned: boolean) => {
      try {
        if (pinned) await MeService.pin(id);
        else await MeService.unpin(id);
        await loadSecondary(userId);
        toast.success(t(pinned ? 'me.pinSuccess' : 'me.unpinSuccess'));
      } catch {
        toast.error(t('me.pinError'));
      }
    },
    [loadSecondary, userId, t]
  );

  const postActions: ProfilePostActions = {
    toggleReaction,
    adjustCommentCount,
    editPost,
    deletePost,
    togglePin,
  };

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

  return { profile, loading, notFound, relationship, busy, actions, secondary, postActions };
}

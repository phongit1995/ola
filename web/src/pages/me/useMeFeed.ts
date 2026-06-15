import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useMeFeedStore } from '@/store/meFeedStore';
import { createTimeFormatter, toMePost } from './mappers';
import { TAB_FILTER } from './constants';
import type { ComposedPost } from './components/MeComposerDialog';
import type { MeTab } from './types';

export function useMeFeed() {
  const { i18n } = useTranslation();
  const [tab, setTab] = useState<MeTab>('feed');

  const rawPosts = useMeFeedStore((state) => state.posts);
  const loading = useMeFeedStore((state) => state.loading);
  const loadFeed = useMeFeedStore((state) => state.loadFeed);
  const toggleReaction = useMeFeedStore((state) => state.toggleReaction);
  const createPost = useMeFeedStore((state) => state.createPost);

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const isFollower = tab === 'follower';

  useEffect(() => {
    if (isFollower) return;
    loadFeed(TAB_FILTER[tab]);
  }, [tab, isFollower, loadFeed]);

  const posts = useMemo(
    () => (isFollower ? [] : rawPosts.map((post) => toMePost(post, formatTime))),
    [isFollower, rawPosts, formatTime]
  );

  const addPost = useCallback(
    async (draft: ComposedPost) => {
      const created = await createPost(
        {
          content: draft.content,
          checkIn: draft.checkIn ? { name: draft.checkIn } : undefined,
          sticker: draft.sticker ?? undefined,
          visibility: draft.visibility,
        },
        draft.files
      );
      if (created != null) setTab('feed');
    },
    [createPost]
  );

  return {
    tab,
    setTab,
    posts,
    loading: !isFollower && loading,
    isFollower,
    toggleReaction,
    addPost,
  };
}

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
  const error = useMeFeedStore((state) => state.error);
  const loadFeed = useMeFeedStore((state) => state.loadFeed);
  const toggleReaction = useMeFeedStore((state) => state.toggleReaction);
  const createPost = useMeFeedStore((state) => state.createPost);
  const adjustCommentCount = useMeFeedStore((state) => state.adjustCommentCount);

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  useEffect(() => {
    loadFeed(TAB_FILTER[tab]);
  }, [tab, loadFeed]);

  const posts = useMemo(
    () => rawPosts.map((post) => toMePost(post, formatTime)),
    [rawPosts, formatTime]
  );

  const addPost = useCallback(
    async (draft: ComposedPost): Promise<boolean> => {
      const created = await createPost(
        {
          content: draft.content,
          checkIn: draft.checkIn
            ? {
                name: draft.checkIn.name,
                address: draft.checkIn.address,
                lat: draft.checkIn.lat,
                lng: draft.checkIn.lng,
                action: draft.checkIn.action,
                actionIcon: draft.checkIn.actionIcon,
              }
            : undefined,
          sticker: draft.sticker ?? undefined,
          visibility: draft.visibility,
        },
        draft.files,
        draft.imageUrls
      );
      if (created == null) return false;
      setTab('feed');
      return true;
    },
    [createPost]
  );

  return {
    tab,
    setTab,
    posts,
    loading,
    error,
    toggleReaction,
    addPost,
    adjustCommentCount,
  };
}

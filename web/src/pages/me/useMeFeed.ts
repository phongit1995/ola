import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useMeFeedStore } from '@/store/meFeedStore';
import { useMeLocalStore } from '@/store/meLocalStore';
import { createTimeFormatter } from '@lib';
import { toMePost } from './mappers';
import { TAB_FILTER } from './constants';
import type { ComposedPost } from './components/MeComposerDialog';
import type { MeTab } from './types';

export function useMeFeed() {
  const { i18n } = useTranslation();
  const [tab, setTab] = useState<MeTab>('feed');

  const rawPosts = useMeFeedStore((state) => state.posts);
  const loading = useMeFeedStore((state) => state.loading);
  const loadingMore = useMeFeedStore((state) => state.loadingMore);
  const error = useMeFeedStore((state) => state.error);
  const hasMore = useMeFeedStore((state) => state.nextCursor != null);
  const loadFeed = useMeFeedStore((state) => state.loadFeed);
  const refreshFeed = useMeFeedStore((state) => state.refreshFeed);
  const loadMoreFeed = useMeFeedStore((state) => state.loadMore);
  const toggleReaction = useMeFeedStore((state) => state.toggleReaction);
  const createPost = useMeFeedStore((state) => state.createPost);
  const updatePost = useMeFeedStore((state) => state.updatePost);
  const removePost = useMeFeedStore((state) => state.removePost);
  const togglePin = useMeFeedStore((state) => state.togglePin);
  const adjustCommentCount = useMeFeedStore((state) => state.adjustCommentCount);

  const hiddenPostIds = useMeLocalStore((state) => state.hiddenPostIds);
  const blockedAuthorIds = useMeLocalStore((state) => state.blockedAuthorIds);
  const hidePost = useMeLocalStore((state) => state.hidePost);
  const blockAuthor = useMeLocalStore((state) => state.blockAuthor);

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  useEffect(() => {
    loadFeed(TAB_FILTER[tab]);
  }, [tab, loadFeed]);

  const loadMore = useCallback(() => loadMoreFeed(TAB_FILTER[tab]), [loadMoreFeed, tab]);
  const refresh = useCallback(() => refreshFeed(TAB_FILTER[tab]), [refreshFeed, tab]);

  const posts = useMemo(
    () =>
      rawPosts
        .map((post) => toMePost(post, formatTime))
        .filter(
          (post) =>
            !hiddenPostIds.includes(post.id) && !blockedAuthorIds.includes(post.authorId)
        ),
    [rawPosts, formatTime, hiddenPostIds, blockedAuthorIds]
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

  const editPost = useCallback(
    async (id: string, draft: ComposedPost): Promise<boolean> => {
      const updated = await updatePost(
        id,
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
      return updated != null;
    },
    [updatePost]
  );

  const deletePost = useCallback((id: string) => removePost(id), [removePost]);

  return {
    tab,
    setTab,
    posts,
    loading,
    loadingMore,
    hasMore,
    error,
    loadMore,
    refresh,
    toggleReaction,
    addPost,
    editPost,
    deletePost,
    togglePin,
    hidePost,
    blockAuthor,
    adjustCommentCount,
  };
}

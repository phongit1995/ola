import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useMeFeedStore } from './meFeedStore';
import { useMeLocalStore } from '@/store/meLocalStore';
import {
  compressImagesForUpload,
  createTimeFormatter,
  filterVisiblePosts,
  imageUploadErrorText,
  toast,
} from '@lib';
import { toMePost } from './mappers';
import { composedToPayload } from './composer';
import { TAB_FILTER } from './constants';
import type { ComposedPost } from './components/MeComposerDialog';
import type { MeTab } from './types';

export function useMeFeed() {
  const { i18n } = useTranslation();
  const [tab, setTab] = useState<MeTab>('community');

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
  const prependPost = useMeFeedStore((state) => state.prependPost);
  const updatePost = useMeFeedStore((state) => state.updatePost);
  const removePost = useMeFeedStore((state) => state.removePost);
  const togglePin = useMeFeedStore((state) => state.togglePin);
  const adjustCommentCount = useMeFeedStore(
    (state) => state.adjustCommentCount
  );

  const hiddenPostIds = useMeLocalStore((state) => state.hiddenPostIds);
  const blockedAuthorIds = useMeLocalStore((state) => state.blockedAuthorIds);
  const hidePost = useMeLocalStore((state) => state.hidePost);
  const blockAuthor = useMeLocalStore((state) => state.blockAuthor);

  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );

  useEffect(() => {
    loadFeed(TAB_FILTER[tab]);
  }, [tab, loadFeed]);

  const loadMore = useCallback(
    () => loadMoreFeed(TAB_FILTER[tab]),
    [loadMoreFeed, tab]
  );
  const refresh = useCallback(
    () => refreshFeed(TAB_FILTER[tab]),
    [refreshFeed, tab]
  );

  const posts = useMemo(
    () =>
      filterVisiblePosts(rawPosts, hiddenPostIds, blockedAuthorIds).map(
        (post) => toMePost(post, formatTime)
      ),
    [rawPosts, formatTime, hiddenPostIds, blockedAuthorIds]
  );

  const addPost = useCallback(
    async (draft: ComposedPost): Promise<boolean> => {
      let files: File[];
      try {
        files = await compressImagesForUpload(draft.files);
      } catch (error) {
        toast.error(imageUploadErrorText(i18n.t, error, i18n.t('me.postError')));
        return false;
      }
      const created = await createPost(
        composedToPayload(draft),
        files,
        draft.imageUrls
      );
      if (created == null) return false;
      prependPost(created);
      return true;
    },
    [createPost, prependPost, i18n]
  );

  const editPost = useCallback(
    async (id: string, draft: ComposedPost): Promise<boolean> => {
      let files: File[];
      try {
        files = await compressImagesForUpload(draft.files);
      } catch (error) {
        toast.error(imageUploadErrorText(i18n.t, error, i18n.t('me.editError')));
        return false;
      }
      const updated = await updatePost(
        id,
        composedToPayload(draft),
        files,
        draft.imageUrls
      );
      return updated != null;
    },
    [updatePost, i18n]
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

import { create } from 'zustand';
import { ME_FEED_PAGE_SIZE } from '../constants/feed';
import { toast } from '../lib/toast';
import { MeService } from '../services/me.service';
import type { Post } from '../types/api/me.type';
import type { MeFeedState } from '../types/client/feed.type';
import i18n from 'i18next';
import { applyPostReaction, reconcileTopLikers } from './postHelpers';
import { selfLiker } from './selfLiker';
import {
  currentMeFeedRequestId,
  nextMeFeedRequestId,
} from './feedRequest.state';

function replacePost(posts: Post[], updated: Post): Post[] {
  return posts.map((post) => (post.id === updated.id ? updated : post));
}

function applyPin(posts: Post[], updated: Post): Post[] {
  if (!updated.isPinned) {
    return posts.map((post) => (post.id === updated.id ? updated : post));
  }
  const authorId = updated.author?.id;
  const others = posts
    .filter((post) => post.id !== updated.id)
    .map((post) =>
      authorId != null && post.author?.id === authorId ? { ...post, isPinned: false } : post
    );
  return [updated, ...others];
}

export const useMeFeedStore = create<MeFeedState>((set, get) => ({
  posts: [],
  loading: true,
  loadingMore: false,
  error: false,
  nextCursor: null,
  reacting: new Set(),
  refreshing: false,
  loadFeed: async (filter) => {
    const requestId = nextMeFeedRequestId();
    set({ loading: true, error: false });
    try {
      const result = await MeService.feed({ filter, limit: ME_FEED_PAGE_SIZE });
      if (requestId !== currentMeFeedRequestId()) return;
      set({ posts: result.items, nextCursor: result.nextCursor, loading: false });
    } catch (error) {
      if (requestId !== currentMeFeedRequestId()) return;
      console.error('load me feed failed', error);
      set({ posts: [], nextCursor: null, loading: false, error: true });
    }
  },
  refreshFeed: async (filter) => {
    const requestId = nextMeFeedRequestId();
    set({ refreshing: true, error: false });
    try {
      const result = await MeService.feed({ filter, limit: ME_FEED_PAGE_SIZE });
      if (requestId !== currentMeFeedRequestId()) return;
      set({ posts: result.items, nextCursor: result.nextCursor, refreshing: false });
    } catch (error) {
      if (requestId !== currentMeFeedRequestId()) return;
      console.error('refresh me feed failed', error);
      set({ refreshing: false });
    }
  },
  loadMore: async (filter) => {
    const { nextCursor, loading, loadingMore } = get();
    if (nextCursor == null || loading || loadingMore) return;
    const requestId = currentMeFeedRequestId();
    set({ loadingMore: true });
    try {
      const result = await MeService.feed({
        filter,
        limit: ME_FEED_PAGE_SIZE,
        cursor: nextCursor,
      });
      if (requestId !== currentMeFeedRequestId()) return;
      set((state) => ({
        posts: [...state.posts, ...result.items],
        nextCursor: result.nextCursor,
        loadingMore: false,
      }));
    } catch (error) {
      if (requestId !== currentMeFeedRequestId()) return;
      console.error('load more me feed failed', error);
      set({ loadingMore: false });
    }
  },
  toggleReaction: async (id, type) => {
    const post = get().posts.find((item) => item.id === id);
    if (post == null || get().reacting.has(id)) return;

    const active = post.myReaction === type;
    const self = selfLiker();
    const optimistic = applyPostReaction(post, active ? null : type, self);
    set((state) => ({
      posts: replacePost(state.posts, optimistic),
      reacting: new Set(state.reacting).add(id),
    }));

    try {
      const updated = active
        ? await MeService.removeReaction(id)
        : await MeService.react(id, type);
      set((state) => ({
        posts: state.posts.map((item) =>
          item.id === id ? reconcileTopLikers(updated, item) : item
        ),
      }));
    } catch (error) {
      console.error('toggle reaction failed', error);
      set((state) => ({
        posts: state.posts.map((item) =>
          item.id === id ? applyPostReaction(item, post.myReaction, self) : item
        ),
      }));
      toast.error(i18n.t('me.reactionError'));
    } finally {
      set((state) => {
        const reacting = new Set(state.reacting);
        reacting.delete(id);
        return { reacting };
      });
    }
  },
  createPost: async (payload, files, imageUrls) => {
    try {
      const uploaded = files.length > 0 ? (await MeService.uploadImages(files)).images : [];
      const urlImages = imageUrls.map((url) => ({ url }));
      const images = [...uploaded, ...urlImages];
      const created = await MeService.create({ ...payload, images });
      toast.success(i18n.t('me.postSent'));
      return created;
    } catch (error) {
      console.error('create post failed', error);
      toast.error(i18n.t('me.postError'));
      return null;
    }
  },
  prependPost: (post) => {
    set((state) => ({ posts: [post, ...state.posts] }));
  },
  updatePost: async (id, payload, files, imageUrls, existing) => {
    try {
      const uploaded = files.length > 0 ? (await MeService.uploadImages(files)).images : [];
      const existingImages = existing ?? get().posts.find((post) => post.id === id)?.images ?? [];
      const urlImages = imageUrls.map(
        (url) => existingImages.find((image) => image.url === url) ?? { url }
      );
      const images = [...urlImages, ...uploaded];
      const updated = await MeService.update(id, {
        ...payload,
        sticker: payload.sticker ?? '',
        clearCheckIn: payload.checkIn == null,
        images,
      });
      set((state) => ({ posts: replacePost(state.posts, updated) }));
      toast.success(i18n.t('me.editSuccess'));
      return updated;
    } catch (error) {
      console.error('update post failed', error);
      toast.error(i18n.t('me.editError'));
      return null;
    }
  },
  removePost: async (id) => {
    try {
      await MeService.remove(id);
      set((state) => ({ posts: state.posts.filter((post) => post.id !== id) }));
      toast.success(i18n.t('me.deleteSuccess'));
      return true;
    } catch (error) {
      console.error('delete post failed', error);
      toast.error(i18n.t('me.deleteError'));
      return false;
    }
  },
  togglePin: async (id, pinned) => {
    try {
      const updated = pinned ? await MeService.pin(id) : await MeService.unpin(id);
      set((state) => ({ posts: applyPin(state.posts, updated) }));
      toast.success(i18n.t(pinned ? 'me.pinSuccess' : 'me.unpinSuccess'));
    } catch (error) {
      console.error('toggle pin failed', error);
      toast.error(i18n.t('me.pinError'));
    }
  },
  adjustCommentCount: (id, delta) => {
    set((state) => ({
      posts: state.posts.map((post) =>
        post.id === id
          ? { ...post, commentCount: Math.max(0, post.commentCount + delta) }
          : post
      ),
    }));
  },
  syncPost: (post) => {
    set((state) => ({
      posts: state.posts.map((item) => (item.id === post.id ? reconcileTopLikers(post, item) : item)),
    }));
  },
}));

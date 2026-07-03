import { create } from 'zustand';
import { MeService } from '../services';
import { toast, type UploadFile } from '../lib';
import type { CreatePostRequest, MeFeedFilter, Post, PostReaction } from '../types';
import i18n from 'i18next';
import { applyPostReaction } from './postHelpers';

interface MeFeedState {
  posts: Post[];
  loading: boolean;
  loadingMore: boolean;
  error: boolean;
  nextCursor: string | null;
  reacting: Set<string>;
  refreshing: boolean;
  loadFeed: (filter?: MeFeedFilter) => Promise<void>;
  refreshFeed: (filter?: MeFeedFilter) => Promise<void>;
  loadMore: (filter?: MeFeedFilter) => Promise<void>;
  toggleReaction: (id: string, type: PostReaction) => Promise<void>;
  createPost: (payload: CreatePostRequest, files: UploadFile[], imageUrls: string[]) => Promise<Post | null>;
  prependPost: (post: Post) => void;
  updatePost: (id: string, payload: CreatePostRequest, files: UploadFile[], imageUrls: string[]) => Promise<Post | null>;
  removePost: (id: string) => Promise<boolean>;
  togglePin: (id: string, pinned: boolean) => Promise<void>;
  adjustCommentCount: (id: string, delta: number) => void;
}

const FEED_PAGE_SIZE = 30;

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

let feedRequestId = 0;

export const useMeFeedStore = create<MeFeedState>((set, get) => ({
  posts: [],
  loading: true,
  loadingMore: false,
  error: false,
  nextCursor: null,
  reacting: new Set(),
  refreshing: false,
  loadFeed: async (filter) => {
    const requestId = ++feedRequestId;
    set({ loading: true, error: false });
    try {
      const result = await MeService.feed({ filter, limit: FEED_PAGE_SIZE });
      if (requestId !== feedRequestId) return;
      set({ posts: result.items, nextCursor: result.nextCursor, loading: false });
    } catch (error) {
      if (requestId !== feedRequestId) return;
      console.error('load me feed failed', error);
      set({ posts: [], nextCursor: null, loading: false, error: true });
    }
  },
  refreshFeed: async (filter) => {
    const requestId = ++feedRequestId;
    set({ refreshing: true, error: false });
    try {
      const result = await MeService.feed({ filter, limit: FEED_PAGE_SIZE });
      if (requestId !== feedRequestId) return;
      set({ posts: result.items, nextCursor: result.nextCursor, refreshing: false });
    } catch (error) {
      if (requestId !== feedRequestId) return;
      console.error('refresh me feed failed', error);
      set({ refreshing: false });
    }
  },
  loadMore: async (filter) => {
    const { nextCursor, loading, loadingMore } = get();
    if (nextCursor == null || loading || loadingMore) return;
    const requestId = feedRequestId;
    set({ loadingMore: true });
    try {
      const result = await MeService.feed({ filter, limit: FEED_PAGE_SIZE, cursor: nextCursor });
      if (requestId !== feedRequestId) return;
      set((state) => ({
        posts: [...state.posts, ...result.items],
        nextCursor: result.nextCursor,
        loadingMore: false,
      }));
    } catch (error) {
      if (requestId !== feedRequestId) return;
      console.error('load more me feed failed', error);
      set({ loadingMore: false });
    }
  },
  toggleReaction: async (id, type) => {
    const post = get().posts.find((item) => item.id === id);
    if (post == null || get().reacting.has(id)) return;

    const active = post.myReaction === type;
    const optimistic = applyPostReaction(post, active ? null : type);
    set((state) => ({
      posts: replacePost(state.posts, optimistic),
      reacting: new Set(state.reacting).add(id),
    }));

    try {
      const updated = active
        ? await MeService.removeReaction(id)
        : await MeService.react(id, type);
      set((state) => ({ posts: replacePost(state.posts, updated) }));
    } catch (error) {
      console.error('toggle reaction failed', error);
      set((state) => ({
        posts: state.posts.map((item) =>
          item.id === id ? applyPostReaction(item, post.myReaction) : item
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
  updatePost: async (id, payload, files, imageUrls) => {
    try {
      const uploaded = files.length > 0 ? (await MeService.uploadImages(files)).images : [];
      const urlImages = imageUrls.map((url) => ({ url }));
      const images = [...urlImages, ...uploaded];
      const updated = await MeService.update(id, { ...payload, images });
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
}));

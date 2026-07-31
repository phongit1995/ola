import { create } from 'zustand';
import i18n from 'i18next';
import { CLAN_FEED_PAGE_SIZE } from '../constants/feed';
import { clanErrorText } from '../lib/clanHelpers';
import { toast } from '../lib/toast';
import { ClanService } from '../services/clan.service';
import { MeService } from '../services/me.service';
import type { Post, UploadedImage } from '../types/api/me.type';
import type { ClanFeedState } from '../types/client/clan.type';
import { applyPostReaction, reconcileTopLikers } from './postHelpers';
import { registerOnLogout } from './authStore';
import { selfLiker } from './selfLiker';
import {
  currentClanFeedRequestId,
  nextClanFeedRequestId,
} from './feedRequest.state';

function replacePost(posts: Post[], updated: Post): Post[] {
  return posts.map((post) => (post.id === updated.id ? updated : post));
}

function errorMessage(error: unknown): string {
  if (error != null && typeof error === 'object' && 'message' in error) {
    return String((error as { message: unknown }).message);
  }
  return 'unknown error';
}

export const useClanFeedStore = create<ClanFeedState>((set, get) => ({
  clanId: null,
  pinned: null,
  posts: [],
  loading: true,
  loadingMore: false,
  error: null,
  nextCursor: null,
  reacting: new Set(),
  load: async (clanId) => {
    const requestId = nextClanFeedRequestId();
    set({ clanId, loading: true, error: null, pinned: null, posts: [], nextCursor: null });
    try {
      const result = await ClanService.posts(clanId, { limit: CLAN_FEED_PAGE_SIZE });
      if (requestId !== currentClanFeedRequestId()) return;
      set({
        pinned: result.pinned ?? null,
        posts: result.items,
        nextCursor: result.nextCursor ?? null,
        loading: false,
      });
    } catch (error) {
      if (requestId !== currentClanFeedRequestId()) return;
      set({ loading: false, error: errorMessage(error) });
    }
  },
  refresh: async (clanId) => {
    const requestId = nextClanFeedRequestId();
    try {
      const result = await ClanService.posts(clanId, { limit: CLAN_FEED_PAGE_SIZE });
      if (requestId !== currentClanFeedRequestId()) return;
      set({
        clanId,
        pinned: result.pinned ?? null,
        posts: result.items,
        nextCursor: result.nextCursor ?? null,
        loading: false,
        error: null,
      });
    } catch (error) {
      if (requestId !== currentClanFeedRequestId()) return;
      throw error;
    }
  },
  loadMore: async () => {
    const { clanId, nextCursor, loading, loadingMore } = get();
    if (clanId == null || nextCursor == null || loading || loadingMore) return;
    const requestId = currentClanFeedRequestId();
    set({ loadingMore: true });
    try {
      const result = await ClanService.posts(clanId, {
        limit: CLAN_FEED_PAGE_SIZE,
        cursor: nextCursor,
      });
      if (requestId !== currentClanFeedRequestId()) return;
      set((state) => ({
        posts: [...state.posts, ...result.items],
        nextCursor: result.nextCursor ?? null,
        loadingMore: false,
      }));
    } catch (error) {
      if (requestId !== currentClanFeedRequestId()) return;
      console.error('load more clan feed failed', error);
      set({ loadingMore: false });
    }
  },
  toggleReaction: async (id, type) => {
    const state = get();
    const post = state.posts.find((item) => item.id === id) ?? (state.pinned?.id === id ? state.pinned : null);
    if (post == null || state.reacting.has(id)) return;

    const active = post.myReaction === type;
    const self = selfLiker();
    const optimistic = applyPostReaction(post, active ? null : type, self);
    set((prev) => ({
      posts: replacePost(prev.posts, optimistic),
      pinned: prev.pinned != null && prev.pinned.id === id ? optimistic : prev.pinned,
      reacting: new Set(prev.reacting).add(id),
    }));

    try {
      const updated = active
        ? await MeService.removeReaction(id)
        : await MeService.react(id, type);
      set((prev) => ({
        posts: prev.posts.map((item) => (item.id === id ? reconcileTopLikers(updated, item) : item)),
        pinned:
          prev.pinned != null && prev.pinned.id === id
            ? reconcileTopLikers(updated, prev.pinned)
            : prev.pinned,
      }));
    } catch (error) {
      console.error('toggle clan reaction failed', error);
      set((prev) => ({
        posts: prev.posts.map((item) =>
          item.id === id ? applyPostReaction(item, post.myReaction, self) : item
        ),
        pinned:
          prev.pinned != null && prev.pinned.id === id
            ? applyPostReaction(prev.pinned, post.myReaction, self)
            : prev.pinned,
      }));
      toast.error(i18n.t('me.reactionError'));
    } finally {
      set((prev) => {
        const reacting = new Set(prev.reacting);
        reacting.delete(id);
        return { reacting };
      });
    }
  },
  createPost: async (clanId, payload, files, imageUrls) => {
    let uploaded: UploadedImage[] = [];
    try {
      uploaded = files.length > 0 ? (await MeService.uploadImages(files)).images : [];
      const urlImages = imageUrls.map((url) => ({ url }));
      const images = [...uploaded, ...urlImages];
      const created = await ClanService.createPost(clanId, { ...payload, images });
      set((state) => ({ posts: [created, ...state.posts] }));
      toast.success(i18n.t('me.postSent'));
      return created;
    } catch (error) {
      console.error('create clan post failed', error);
      await MeService.cleanupRejectedImages(error, uploaded);
      toast.error(clanErrorText(error));
      return null;
    }
  },
  removePost: (id) => {
    set((state) => ({
      posts: state.posts.filter((post) => post.id !== id),
      pinned: state.pinned?.id === id ? null : state.pinned,
    }));
  },
  removePostsByAuthor: (authorId) => {
    set((state) => ({
      posts: state.posts.filter((post) => post.author?.id !== authorId),
      pinned: state.pinned?.author?.id === authorId ? null : state.pinned,
    }));
  },
  syncPost: (post) => {
    set((state) => ({
      posts: state.posts.map((item) => (item.id === post.id ? post : item)),
      pinned: state.pinned != null && state.pinned.id === post.id ? post : state.pinned,
    }));
  },
  setPinned: (post) => {
    set((state) => ({
      pinned: post,
      posts: post != null ? state.posts.filter((item) => item.id !== post.id) : state.posts,
    }));
  },
  adjustCommentCount: (id, delta) => {
    const bump = (post: Post): Post =>
      post.id === id ? { ...post, commentCount: Math.max(0, post.commentCount + delta) } : post;
    set((state) => ({
      posts: state.posts.map(bump),
      pinned: state.pinned != null ? bump(state.pinned) : null,
    }));
  },
  reset: () => {
    nextClanFeedRequestId();
    set({
      clanId: null,
      pinned: null,
      posts: [],
      loading: true,
      loadingMore: false,
      error: null,
      nextCursor: null,
      reacting: new Set(),
    });
  },
}));

registerOnLogout(() => useClanFeedStore.getState().reset());

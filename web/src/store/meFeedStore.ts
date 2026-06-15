import { create } from 'zustand';
import { MeService } from '@services';
import { toast } from '@lib';
import type { CreatePostRequest, MeFeedFilter, Post, PostReaction } from '@app-types';
import i18n from '@/i18n';

interface MeFeedState {
  posts: Post[];
  loading: boolean;
  error: boolean;
  reacting: Set<string>;
  loadFeed: (filter?: MeFeedFilter) => Promise<void>;
  toggleReaction: (id: string, type: PostReaction) => Promise<void>;
  createPost: (payload: CreatePostRequest, files: File[], imageUrls: string[]) => Promise<Post | null>;
  adjustCommentCount: (id: string, delta: number) => void;
}

function replacePost(posts: Post[], updated: Post): Post[] {
  return posts.map((post) => (post.id === updated.id ? updated : post));
}

function applyReaction(post: Post, next: PostReaction | null): Post {
  let likeCount = post.likeCount;
  let dislikeCount = post.dislikeCount;
  if (post.myReaction === 'like') likeCount -= 1;
  if (post.myReaction === 'dislike') dislikeCount -= 1;
  if (next === 'like') likeCount += 1;
  if (next === 'dislike') dislikeCount += 1;
  return { ...post, likeCount, dislikeCount, myReaction: next };
}

let feedRequestId = 0;

export const useMeFeedStore = create<MeFeedState>((set, get) => ({
  posts: [],
  loading: true,
  error: false,
  reacting: new Set(),
  loadFeed: async (filter) => {
    const requestId = ++feedRequestId;
    set({ loading: true, error: false });
    try {
      const result = await MeService.feed({ filter, limit: 30 });
      if (requestId !== feedRequestId) return;
      set({ posts: result.items, loading: false });
    } catch (error) {
      if (requestId !== feedRequestId) return;
      console.error('load me feed failed', error);
      set({ posts: [], loading: false, error: true });
    }
  },
  toggleReaction: async (id, type) => {
    const post = get().posts.find((item) => item.id === id);
    if (post == null || get().reacting.has(id)) return;

    const active = post.myReaction === type;
    const optimistic = applyReaction(post, active ? null : type);
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
      set((state) => ({ posts: replacePost(state.posts, post) }));
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
      set((state) => ({ posts: [created, ...state.posts] }));
      toast.success(i18n.t('me.postSent'));
      return created;
    } catch (error) {
      console.error('create post failed', error);
      toast.error(i18n.t('me.postError'));
      return null;
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

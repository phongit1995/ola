import { create } from 'zustand';
import { MeService } from '@services';
import type { CreatePostRequest, MeFeedFilter, Post, PostReaction } from '@app-types';

interface MeFeedState {
  posts: Post[];
  loading: boolean;
  loadFeed: (filter?: MeFeedFilter) => Promise<void>;
  toggleReaction: (id: string, type: PostReaction) => Promise<void>;
  createPost: (payload: CreatePostRequest, files: File[]) => Promise<Post | null>;
}

function replacePost(posts: Post[], updated: Post): Post[] {
  return posts.map((post) => (post.id === updated.id ? updated : post));
}

export const useMeFeedStore = create<MeFeedState>((set, get) => ({
  posts: [],
  loading: true,
  loadFeed: async (filter) => {
    set({ loading: true });
    try {
      const result = await MeService.feed({ filter, limit: 30 });
      set({ posts: result.items, loading: false });
    } catch (error) {
      console.error('load me feed failed', error);
      set({ posts: [], loading: false });
    }
  },
  toggleReaction: async (id, type) => {
    const post = get().posts.find((item) => item.id === id);
    if (post == null) return;
    const active = post.myReaction === type;
    try {
      const updated = active
        ? await MeService.removeReaction(id)
        : await MeService.react(id, type);
      set((state) => ({ posts: replacePost(state.posts, updated) }));
    } catch (error) {
      console.error('toggle reaction failed', error);
    }
  },
  createPost: async (payload, files) => {
    try {
      let images = payload.images;
      if (files.length > 0) {
        const uploaded = await MeService.uploadImages(files);
        images = uploaded.images;
      }
      const created = await MeService.create({ ...payload, images });
      set((state) => ({ posts: [created, ...state.posts] }));
      return created;
    } catch (error) {
      console.error('create post failed', error);
      return null;
    }
  },
}));

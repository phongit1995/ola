import { create } from 'zustand';
import { STORY_LATEST_COMMENTS_THREAD } from '../../constants/story';
import { StoryService } from '../../services/story.service';
import type { StoryComment, StoryCommentListQuery } from '../../types/api/story.type';
import type { StoryCommentState, StoryCommentThread } from '../../types/client/story.type';
import { useStoryStore } from './storyStore';

const EMPTY_THREAD: StoryCommentThread = {
  items: [],
  nextCursor: null,
  status: 'idle',
  loadingMore: false,
};

interface LikeChange {
  seq: number;
  liked: boolean;
  likeCount: number;
}

let session = 0;
let requestSeq = 0;
let changeSeq = 0;
let requests: Record<string, number> = {};
let pendingSent: Record<string, StoryComment[]> = {};
const pendingLikes = new Set<string>();
const likeChanges = new Map<string, LikeChange>();
const removedIds = new Set<string>();

function fetchComments(threadId: string, query: StoryCommentListQuery = {}) {
  return threadId === STORY_LATEST_COMMENTS_THREAD
    ? StoryService.latestComments(query)
    : StoryService.comments(threadId, query);
}

function withoutComment(items: StoryComment[], commentId: string): StoryComment[] {
  return items
    .filter((item) => item.id !== commentId)
    .map((item) => (item.replyTo?.commentId === commentId ? { ...item, replyTo: undefined } : item));
}

function withSent(items: StoryComment[], sent: StoryComment[] = []): StoryComment[] {
  const known = new Set(items.map((item) => item.id));
  return [...sent.filter((item) => !known.has(item.id)), ...items];
}

function withLocalChanges(items: StoryComment[], since: number): StoryComment[] {
  let result = items;
  removedIds.forEach((commentId) => {
    result = withoutComment(result, commentId);
  });
  return result.map((item) => {
    const like = likeChanges.get(item.id);
    if (!like || (like.seq <= since && !pendingLikes.has(item.id))) return item;
    return { ...item, liked: like.liked, likeCount: like.likeCount };
  });
}

export const useStoryCommentStore = create<StoryCommentState>((set, get) => {
  function thread(threadId: string): StoryCommentThread {
    return get().threads[threadId] ?? EMPTY_THREAD;
  }

  function patchThread(threadId: string, patch: (current: StoryCommentThread) => Partial<StoryCommentThread>) {
    set((state) => {
      const current = state.threads[threadId] ?? EMPTY_THREAD;
      return { threads: { ...state.threads, [threadId]: { ...current, ...patch(current) } } };
    });
  }

  function patchEveryThread(update: (items: StoryComment[]) => StoryComment[]) {
    set((state) => ({
      threads: Object.fromEntries(
        Object.entries(state.threads).map(([threadId, current]) => [threadId, { ...current, items: update(current.items) }])
      ),
    }));
  }

  function setLike(commentId: string, liked: boolean, likeCount: number) {
    likeChanges.set(commentId, { seq: ++changeSeq, liked, likeCount });
    patchEveryThread((items) => items.map((item) => (item.id === commentId ? { ...item, liked, likeCount } : item)));
  }

  function prependSent(threadId: string, comment: StoryComment) {
    pendingSent[threadId]?.push(comment);
    patchThread(threadId, (latest) => ({
      items: [comment, ...latest.items.filter((item) => item.id !== comment.id)],
    }));
  }

  return {
    threads: {},

    load: async (threadId) => {
      const request = ++requestSeq;
      const since = changeSeq;
      requests[threadId] = request;
      pendingSent[threadId] = [];
      patchThread(threadId, () => ({ status: 'loading' }));
      try {
        const page = await fetchComments(threadId);
        if (requests[threadId] !== request) return;
        const sent = pendingSent[threadId];
        delete pendingSent[threadId];
        patchThread(threadId, () => ({
          items: withLocalChanges(withSent(page.items, sent), since),
          nextCursor: page.nextCursor ?? null,
          status: 'ready',
          loadingMore: false,
        }));
      } catch {
        if (requests[threadId] !== request) return;
        delete pendingSent[threadId];
        patchThread(threadId, () => ({ status: 'error' }));
      }
    },

    loadMore: async (threadId) => {
      const current = thread(threadId);
      if (current.loadingMore || current.nextCursor == null || current.status !== 'ready') return;
      const request = requests[threadId];
      const since = changeSeq;
      patchThread(threadId, () => ({ loadingMore: true }));
      try {
        const page = await fetchComments(threadId, { cursor: current.nextCursor });
        if (requests[threadId] !== request) return;
        patchThread(threadId, (latest) => {
          const known = new Set(latest.items.map((item) => item.id));
          const fresh = page.items.filter((item) => !known.has(item.id));
          return {
            items: [...latest.items, ...withLocalChanges(fresh, since)],
            nextCursor: page.nextCursor ?? null,
            loadingMore: false,
          };
        });
      } catch {
        if (requests[threadId] !== request) return;
        patchThread(threadId, () => ({ loadingMore: false }));
      }
    },

    send: async (storyId, content, parentId) => {
      const current = session;
      const result = await StoryService.addComment(storyId, { content, parentId });
      if (current !== session) return result;
      prependSent(storyId, result.comment);
      if (get().threads[STORY_LATEST_COMMENTS_THREAD]) prependSent(STORY_LATEST_COMMENTS_THREAD, result.comment);
      const stories = useStoryStore.getState();
      stories.setCommentCount(storyId, result.commentCount);
      if (result.unlocked) stories.markUnlocked(storyId);
      return result;
    },

    remove: async (storyId, commentId) => {
      const current = session;
      const result = await StoryService.deleteComment(storyId, commentId);
      if (current !== session) return;
      removedIds.add(commentId);
      patchEveryThread((items) => withoutComment(items, commentId));
      useStoryStore.getState().setCommentCount(storyId, result.commentCount);
    },

    toggleLike: async (threadId, commentId) => {
      const comment = thread(threadId).items.find((item) => item.id === commentId);
      if (!comment || pendingLikes.has(commentId)) return;
      const current = session;
      const liked = !comment.liked;
      pendingLikes.add(commentId);
      setLike(commentId, liked, Math.max(0, comment.likeCount + (liked ? 1 : -1)));
      try {
        const result = await StoryService.likeComment(comment.storyId, commentId);
        if (current !== session) return;
        setLike(commentId, result.liked, result.likeCount);
      } catch (error) {
        if (current !== session) return;
        setLike(commentId, comment.liked, comment.likeCount);
        throw error;
      } finally {
        pendingLikes.delete(commentId);
      }
    },

    reset: () => {
      session += 1;
      requests = {};
      pendingSent = {};
      pendingLikes.clear();
      likeChanges.clear();
      removedIds.clear();
      set({ threads: {} });
    },
  };
});

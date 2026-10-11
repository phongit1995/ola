import { create } from 'zustand';
import { StoryService } from '../../services/story.service';
import type { StoryComment } from '../../types/api/story.type';
import type { StoryCommentState, StoryCommentThread } from '../../types/client/story.type';
import { useStoryStore } from './storyStore';

const EMPTY_THREAD: StoryCommentThread = {
  items: [],
  nextCursor: null,
  status: 'idle',
  loadingMore: false,
};

interface PendingChanges {
  sent: StoryComment[];
  removed: Set<string>;
}

let session = 0;
let requestSeq = 0;
let requests: Record<string, number> = {};
let pendingChanges: Record<string, PendingChanges> = {};
const pendingLikes = new Set<string>();

function withoutComment(items: StoryComment[], commentId: string): StoryComment[] {
  return items
    .filter((item) => item.id !== commentId)
    .map((item) => (item.replyTo?.commentId === commentId ? { ...item, replyTo: undefined } : item));
}

function mergePending(items: StoryComment[], changes: PendingChanges | undefined): StoryComment[] {
  if (!changes) return items;
  const known = new Set(items.map((item) => item.id));
  let merged = [...changes.sent.filter((item) => !known.has(item.id)), ...items];
  changes.removed.forEach((commentId) => {
    merged = withoutComment(merged, commentId);
  });
  return merged;
}

export const useStoryCommentStore = create<StoryCommentState>((set, get) => {
  function thread(storyId: string): StoryCommentThread {
    return get().threads[storyId] ?? EMPTY_THREAD;
  }

  function patchThread(storyId: string, patch: (current: StoryCommentThread) => Partial<StoryCommentThread>) {
    set((state) => {
      const current = state.threads[storyId] ?? EMPTY_THREAD;
      return { threads: { ...state.threads, [storyId]: { ...current, ...patch(current) } } };
    });
  }

  function patchComment(storyId: string, commentId: string, patch: Partial<StoryComment>) {
    patchThread(storyId, (current) => ({
      items: current.items.map((item) => (item.id === commentId ? { ...item, ...patch } : item)),
    }));
  }

  return {
    threads: {},

    load: async (storyId) => {
      const request = ++requestSeq;
      requests[storyId] = request;
      pendingChanges[storyId] = { sent: [], removed: new Set() };
      patchThread(storyId, () => ({ status: 'loading' }));
      try {
        const page = await StoryService.comments(storyId);
        if (requests[storyId] !== request) return;
        const changes = pendingChanges[storyId];
        delete pendingChanges[storyId];
        patchThread(storyId, () => ({
          items: mergePending(page.items, changes),
          nextCursor: page.nextCursor ?? null,
          status: 'ready',
          loadingMore: false,
        }));
      } catch {
        if (requests[storyId] !== request) return;
        delete pendingChanges[storyId];
        patchThread(storyId, () => ({ status: 'error' }));
      }
    },

    loadMore: async (storyId) => {
      const current = thread(storyId);
      if (current.loadingMore || current.nextCursor == null || current.status !== 'ready') return;
      const request = requests[storyId];
      patchThread(storyId, () => ({ loadingMore: true }));
      try {
        const page = await StoryService.comments(storyId, { cursor: current.nextCursor });
        if (requests[storyId] !== request) return;
        patchThread(storyId, (latest) => {
          const known = new Set(latest.items.map((item) => item.id));
          return {
            items: [...latest.items, ...page.items.filter((item) => !known.has(item.id))],
            nextCursor: page.nextCursor ?? null,
            loadingMore: false,
          };
        });
      } catch {
        if (requests[storyId] !== request) return;
        patchThread(storyId, () => ({ loadingMore: false }));
      }
    },

    send: async (storyId, content, parentId) => {
      const current = session;
      const result = await StoryService.addComment(storyId, { content, parentId });
      if (current !== session) return result;
      pendingChanges[storyId]?.sent.push(result.comment);
      patchThread(storyId, (latest) => ({
        items: [result.comment, ...latest.items.filter((item) => item.id !== result.comment.id)],
      }));
      const stories = useStoryStore.getState();
      stories.setCommentCount(storyId, result.commentCount);
      if (result.unlocked) stories.markUnlocked(storyId);
      return result;
    },

    remove: async (storyId, commentId) => {
      const current = session;
      const result = await StoryService.deleteComment(storyId, commentId);
      if (current !== session) return;
      pendingChanges[storyId]?.removed.add(commentId);
      patchThread(storyId, (latest) => ({ items: withoutComment(latest.items, commentId) }));
      useStoryStore.getState().setCommentCount(storyId, result.commentCount);
    },

    toggleLike: async (storyId, commentId) => {
      const likeKey = `${storyId}:${commentId}`;
      const comment = thread(storyId).items.find((item) => item.id === commentId);
      if (!comment || pendingLikes.has(likeKey)) return;
      const current = session;
      const liked = !comment.liked;
      pendingLikes.add(likeKey);
      patchComment(storyId, commentId, {
        liked,
        likeCount: Math.max(0, comment.likeCount + (liked ? 1 : -1)),
      });
      try {
        const result = await StoryService.likeComment(storyId, commentId);
        if (current !== session) return;
        patchComment(storyId, commentId, { liked: result.liked, likeCount: result.likeCount });
      } catch (error) {
        if (current !== session) return;
        patchComment(storyId, commentId, { liked: comment.liked, likeCount: comment.likeCount });
        throw error;
      } finally {
        pendingLikes.delete(likeKey);
      }
    },

    reset: () => {
      session += 1;
      requests = {};
      pendingChanges = {};
      pendingLikes.clear();
      set({ threads: {} });
    },
  };
});

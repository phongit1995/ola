import { useCallback, useRef } from 'react';
import i18n from 'i18next';
import { MeService } from '../services';
import { toast } from '../lib';
import type { Post, PostReaction } from '../types';
import { applyPostReaction, reconcileTopLikers } from './postHelpers';
import { selfLiker } from './selfLiker';

type PostsUpdater = (updater: (current: Post[]) => Post[]) => void;

export interface PostListActionsOptions {
  posts: Post[];
  setPosts: PostsUpdater;
  keepOnlyLiked?: boolean;
  reloadAfterPin?: () => Promise<unknown> | void;
}

export interface PostListActions {
  toggleReaction: (id: string, type: PostReaction) => Promise<void>;
  adjustCommentCount: (id: string, delta: number) => void;
  deletePost: (id: string) => Promise<void>;
  togglePin: (id: string, pinned: boolean) => Promise<void>;
}

export function usePostListActions({
  posts,
  setPosts,
  keepOnlyLiked = false,
  reloadAfterPin,
}: PostListActionsOptions): PostListActions {
  const reactingRef = useRef<Set<string>>(new Set());

  const toggleReaction = useCallback(
    async (id: string, type: PostReaction) => {
      const post = posts.find((item) => item.id === id);
      if (post == null || reactingRef.current.has(id)) return;
      const active = post.myReaction === type;
      const self = selfLiker();
      reactingRef.current.add(id);
      setPosts((current) =>
        current.map((item) =>
          item.id === id ? applyPostReaction(item, active ? null : type, self) : item
        )
      );
      try {
        const updated = active
          ? await MeService.removeReaction(id)
          : await MeService.react(id, type);
        setPosts((current) => {
          const next = current.map((item) =>
            item.id === id ? reconcileTopLikers(updated, item) : item
          );
          return keepOnlyLiked && updated.myReaction !== 'like'
            ? next.filter((item) => item.id !== id)
            : next;
        });
      } catch {
        setPosts((current) =>
          current.map((item) =>
            item.id === id ? applyPostReaction(item, post.myReaction, self) : item
          )
        );
        toast.error(i18n.t('me.reactionError'));
      } finally {
        reactingRef.current.delete(id);
      }
    },
    [posts, setPosts, keepOnlyLiked]
  );

  const adjustCommentCount = useCallback(
    (id: string, delta: number) => {
      setPosts((current) =>
        current.map((item) =>
          item.id === id
            ? { ...item, commentCount: Math.max(0, item.commentCount + delta) }
            : item
        )
      );
    },
    [setPosts]
  );

  const deletePost = useCallback(
    async (id: string) => {
      try {
        await MeService.remove(id);
        setPosts((current) => current.filter((item) => item.id !== id));
        toast.success(i18n.t('me.deleteSuccess'));
      } catch {
        toast.error(i18n.t('me.deleteError'));
      }
    },
    [setPosts]
  );

  const togglePin = useCallback(
    async (id: string, pinned: boolean) => {
      try {
        if (pinned) await MeService.pin(id);
        else await MeService.unpin(id);
        await reloadAfterPin?.();
        toast.success(i18n.t(pinned ? 'me.pinSuccess' : 'me.unpinSuccess'));
      } catch {
        toast.error(i18n.t('me.pinError'));
      }
    },
    [reloadAfterPin]
  );

  return { toggleReaction, adjustCommentCount, deletePost, togglePin };
}

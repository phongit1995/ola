import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader, Spinner } from '@components';
import { createTimeFormatter, toast } from '@lib';
import { MeService } from '@services';
import type { Post, PostReaction } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { useMeLocalStore } from '@/store/meLocalStore';
import { MePostCard } from './components/MePostCard';
import { MePostInteractions, type MePostSource } from './MePostInteractions';
import { composedToImages, composedToPayload } from './composer';
import { toMePost } from './mappers';
import type { ComposedPost } from './components/MeComposerDialog';

interface MeLikedPostsViewProps {
  onClose: () => void;
}

export function MeLikedPostsView({ onClose }: MeLikedPostsViewProps) {
  const { t, i18n } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const hiddenPostIds = useMeLocalStore((s) => s.hiddenPostIds);
  const hidePost = useMeLocalStore((s) => s.hidePost);
  const blockAuthor = useMeLocalStore((s) => s.blockAuthor);
  const [posts, setPosts] = useState<Post[]>([]);
  const [loading, setLoading] = useState(true);

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  useEffect(() => {
    let active = true;
    MeService.liked({ limit: 30 })
      .then((result) => {
        if (active) setPosts(result.items);
      })
      .catch(() => {
        if (active) toast.error(t('common.error'));
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [t]);

  const toggleReaction = useCallback(
    async (id: string, type: PostReaction) => {
      const post = posts.find((item) => item.id === id);
      if (post == null) return;
      const isActive = post.myReaction === type;
      try {
        const updated = isActive
          ? await MeService.removeReaction(id)
          : await MeService.react(id, type);
        setPosts((current) => current.map((item) => (item.id === id ? updated : item)));
      } catch {
        toast.error(t('me.reactionError'));
      }
    },
    [posts, t]
  );

  const adjustCommentCount = useCallback((id: string, delta: number) => {
    setPosts((current) =>
      current.map((item) =>
        item.id === id ? { ...item, commentCount: Math.max(0, item.commentCount + delta) } : item
      )
    );
  }, []);

  const editPost = useCallback(
    async (id: string, draft: ComposedPost): Promise<boolean> => {
      try {
        const images = await composedToImages(draft, 'existingFirst');
        const updated = await MeService.update(id, { ...composedToPayload(draft), images });
        setPosts((current) => current.map((item) => (item.id === id ? updated : item)));
        toast.success(t('me.editSuccess'));
        return true;
      } catch {
        toast.error(t('me.editError'));
        return false;
      }
    },
    [t]
  );

  const deletePost = useCallback(
    async (id: string) => {
      try {
        await MeService.remove(id);
        setPosts((current) => current.filter((item) => item.id !== id));
        toast.success(t('me.deleteSuccess'));
      } catch {
        toast.error(t('me.deleteError'));
      }
    },
    [t]
  );

  const mePosts = posts
    .map((post) => toMePost(post, formatTime))
    .filter((post) => !hiddenPostIds.includes(post.id));

  const source: MePostSource = {
    posts: mePosts,
    meId: user?.id ?? null,
    toggleReaction,
    adjustCommentCount,
    hidePost,
    blockAuthor,
    editPost,
    deletePost,
  };

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('me.drawerLikes')} onBack={onClose} />
      <div className="flex-1 overflow-y-auto">
        <MePostInteractions source={source}>
          {(handlers) =>
            loading && posts.length === 0 ? (
              <div className="flex justify-center py-10">
                <Spinner size={28} />
              </div>
            ) : mePosts.length === 0 ? (
              <p className="px-6 py-10 text-center text-sm text-black/45">{t('me.likedEmpty')}</p>
            ) : (
              mePosts.map((post) => (
                <MePostCard
                  key={post.id}
                  post={post}
                  onToggleLike={handlers.onToggleLike}
                  onToggleDislike={handlers.onToggleDislike}
                  onOpenProfile={handlers.onOpenProfile}
                  onOpenComments={handlers.onOpenComments}
                  onQuickComment={handlers.onQuickComment}
                  onOpenMenu={handlers.onOpenMenu}
                  onOpenLikers={handlers.onOpenLikers}
                />
              ))
            )
          }
        </MePostInteractions>
      </div>
    </FullScreenOverlay>
  );
}

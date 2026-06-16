import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { MePostCard } from './MePostCard';
import type { MePost } from '../types';

interface MeFeedListProps {
  posts: MePost[];
  loading: boolean;
  loadingMore: boolean;
  hasMore: boolean;
  error?: boolean;
  emptyText: string;
  onLoadMore: () => void;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile: (author: string, color: string) => void;
  onOpenComments: (id: string, focusInput?: boolean) => void;
  onQuickComment: (id: string) => void;
  onOpenMenu: (id: string) => void;
  onOpenLikers: (id: string) => void;
}

export function MeFeedList({
  posts,
  loading,
  loadingMore,
  hasMore,
  error,
  emptyText,
  onLoadMore,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
  onOpenComments,
  onQuickComment,
  onOpenMenu,
  onOpenLikers,
}: MeFeedListProps) {
  const { t } = useTranslation();
  const sentinelRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const el = sentinelRef.current;
    if (el == null || !hasMore) return;
    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0]?.isIntersecting) onLoadMore();
      },
      { rootMargin: '200px' }
    );
    observer.observe(el);
    return () => observer.disconnect();
  }, [hasMore, onLoadMore, posts.length]);

  if (loading) {
    return (
      <div className="flex h-full items-center justify-center text-sm text-black/54">
        {t('common.loading')}
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex h-full items-center justify-center px-8 text-center text-sm text-ola-error">
        {t('common.error')}
      </div>
    );
  }

  if (posts.length === 0) {
    return (
      <div className="flex h-full items-center justify-center px-8 text-center text-sm text-black/54">
        {emptyText}
      </div>
    );
  }

  return (
    <div className="py-2">
      {posts.map((post) => (
        <MePostCard
          key={post.id}
          post={post}
          onToggleLike={onToggleLike}
          onToggleDislike={onToggleDislike}
          onOpenProfile={onOpenProfile}
          onOpenComments={onOpenComments}
          onQuickComment={onQuickComment}
          onOpenMenu={onOpenMenu}
          onOpenLikers={onOpenLikers}
        />
      ))}
      <div ref={sentinelRef} className="h-1" />
      {loadingMore && (
        <div className="flex items-center justify-center py-3 text-sm text-black/54">
          {t('common.loading')}
        </div>
      )}
    </div>
  );
}

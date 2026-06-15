import { useTranslation } from 'react-i18next';
import { MePostCard } from './MePostCard';
import type { MePost } from '../types';

interface MeFeedListProps {
  posts: MePost[];
  loading: boolean;
  emptyText: string;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile: (author: string, color: string) => void;
}

export function MeFeedList({
  posts,
  loading,
  emptyText,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
}: MeFeedListProps) {
  const { t } = useTranslation();

  if (loading) {
    return (
      <div className="flex h-full items-center justify-center text-sm text-black/54">
        {t('common.loading')}
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
        />
      ))}
    </div>
  );
}

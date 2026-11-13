import { useCallback, useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader, Spinner, UserRow } from '@components';
import { UserService } from '@services';
import { mapFollowing } from '../utils';
import type { ProfileFriend } from '../types';
import { useOffsetPage } from '@ola/shared/stores/useOffsetPage';

const FOLLOW_PAGE_SIZE = 10;

type FollowListKind = 'following' | 'followers';

interface FollowingListOverlayProps {
  userId: string;
  kind: FollowListKind;
  onSelect: (friend: ProfileFriend) => void;
  onClose: () => void;
  title?: string;
}

export function FollowingListOverlay({
  userId,
  kind,
  onSelect,
  onClose,
  title,
}: FollowingListOverlayProps) {
  const { t } = useTranslation();
  const scrollRef = useRef<HTMLDivElement>(null);
  const sentinelRef = useRef<HTMLDivElement>(null);

  const loadPage = useCallback(
    async (offset: number) => {
      const params = { limit: FOLLOW_PAGE_SIZE, offset };
      const result =
        kind === 'followers'
          ? await UserService.followers(userId, params)
          : await UserService.following(userId, params);
      return { items: mapFollowing(result.users), total: result.total };
    },
    [userId, kind]
  );
  const {
    items: rows,
    loading,
    loadingMore,
    hasMore,
    loadMore,
  } = useOffsetPage(loadPage);

  useEffect(() => {
    const el = sentinelRef.current;
    const root = scrollRef.current;
    if (el == null || root == null || !hasMore) return;
    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0]?.isIntersecting) void loadMore();
      },
      { root, rootMargin: '120px' }
    );
    observer.observe(el);
    return () => observer.disconnect();
  }, [hasMore, loadMore, rows.length]);

  return (
    <FullScreenOverlay z={50}>
      <ScreenHeader
        title={title ?? t('profile.following')}
        onBack={onClose}
        align="center"
      />
      <div ref={scrollRef} className="flex-1 overflow-y-auto bg-white">
        {loading && (
          <div className="flex justify-center py-6">
            <Spinner size={24} />
          </div>
        )}
        {!loading &&
          rows.map((friend) => (
            <div key={friend.name} className="border-b border-black/8 px-4">
              <UserRow
                name={`@${friend.name}`}
                fullName={friend.fullName}
                avatar={friend.avatar}
                frameId={friend.avatarFrameId}
                color={friend.color}
                layout="inline"
                onClick={() => onSelect(friend)}
              />
            </div>
          ))}
        <div ref={sentinelRef} className="h-1" />
        {loadingMore && (
          <div className="flex justify-center py-3">
            <Spinner size={22} />
          </div>
        )}
      </div>
    </FullScreenOverlay>
  );
}

import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader, Spinner, UserRow } from '@components';
import { UserService } from '@services';
import { mapFollowing } from '../mappers';
import type { ProfileFriend } from '../types';

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
  const [rows, setRows] = useState<ProfileFriend[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);
  const sentinelRef = useRef<HTMLDivElement>(null);

  const loadPage = useCallback(
    (offset: number) =>
      kind === 'followers'
        ? UserService.followers(userId, { limit: FOLLOW_PAGE_SIZE, offset })
        : UserService.following(userId, { limit: FOLLOW_PAGE_SIZE, offset }),
    [userId, kind]
  );

  useEffect(() => {
    let active = true;
    (async () => {
      const result = await loadPage(0).catch(() => null);
      if (!active) return;
      if (result != null) {
        setRows(mapFollowing(result.users));
        setTotal(result.total);
      }
      setLoading(false);
    })();
    return () => {
      active = false;
    };
  }, [loadPage]);

  const hasMore = rows.length < total;

  const loadMore = useCallback(async () => {
    if (loading || loadingMore || !hasMore) return;
    setLoadingMore(true);
    const result = await loadPage(rows.length).catch(() => null);
    if (result != null) {
      setRows((current) => [...current, ...mapFollowing(result.users)]);
      setTotal(result.total);
    }
    setLoadingMore(false);
  }, [loadPage, loading, loadingMore, hasMore, rows.length]);

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
                color={friend.color}
                layout="inline"
                rounded={false}
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

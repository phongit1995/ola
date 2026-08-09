import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, Spinner, UserName, VipIcon } from '@components';
import {
  activeVipTypeId,
  colorForName,
  createTimeFormatter,
  toast,
} from '@lib';
import { RELATIONSHIP_STATUS } from '@constants';
import { RelationshipService, UserService } from '@services';
import type { RelationshipStatus, VisitorUser } from '@app-types';

const VISITOR_PAGE_SIZE = 40;

interface MeVisitorsListProps {
  className?: string;
  onOpenProfile: (nick: string, color: string) => void;
}

interface VisitorRow {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  vipTypeId: number | null;
  viewedAt: string;
  status: RelationshipStatus | 'none';
}

function toRow(user: VisitorUser): VisitorRow {
  return {
    id: user.id,
    username: user.username,
    fullName: user.fullName,
    avatar: user.avatar,
    vipTypeId: activeVipTypeId(user.vipUsed, user.vipEndTime),
    viewedAt: user.viewedAt,
    status: user.relationship?.status ?? 'none',
  };
}

export function MeVisitorsList({
  className,
  onOpenProfile,
}: MeVisitorsListProps) {
  const { t, i18n } = useTranslation();
  const [rows, setRows] = useState<VisitorRow[]>([]);
  const [nextCursor, setNextCursor] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [error, setError] = useState(false);
  const [requested, setRequested] = useState<Record<string, boolean>>({});
  const scrollRef = useRef<HTMLDivElement>(null);
  const sentinelRef = useRef<HTMLDivElement>(null);
  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const result = await UserService.myVisitors({
          limit: VISITOR_PAGE_SIZE,
        });
        if (!active) return;
        setRows(result.users.map(toRow));
        setNextCursor(result.nextCursor);
      } catch (err) {
        console.error('load visitors failed', err);
        if (active) setError(true);
      } finally {
        if (active) setLoading(false);
      }
    })();
    return () => {
      active = false;
    };
  }, []);

  const hasMore = nextCursor != null;

  const loadMore = useCallback(async () => {
    if (loading || loadingMore || nextCursor == null) return;
    setLoadingMore(true);
    try {
      const result = await UserService.myVisitors({
        limit: VISITOR_PAGE_SIZE,
        cursor: nextCursor,
      });
      setRows((current) => [...current, ...result.users.map(toRow)]);
      setNextCursor(result.nextCursor);
    } catch (err) {
      console.error('load more visitors failed', err);
    } finally {
      setLoadingMore(false);
    }
  }, [nextCursor, loading, loadingMore]);

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

  async function addFriend(row: VisitorRow) {
    try {
      await RelationshipService.sendRequest(row.id);
      setRequested((current) => ({ ...current, [row.id]: true }));
      toast.success(t('me.friendRequestSent'));
    } catch {
      toast.error(t('me.makeFriendError'));
    }
  }

  return (
    <div
      ref={scrollRef}
      className={`overflow-y-auto bg-white ${className ?? ''}`}
    >
      {loading && (
        <div className="flex justify-center py-6">
          <Spinner size={24} />
        </div>
      )}
      {!loading && error && (
        <div className="py-6 text-center text-sm text-ola-error">
          {t('me.visitorsError')}
        </div>
      )}
      {!loading && !error && rows.length === 0 && (
        <div className="py-10 text-center text-sm text-black/54">
          {t('me.followerEmpty')}
        </div>
      )}
      {!loading &&
        !error &&
        rows.map((row) => {
          const title =
            row.fullName != null && row.fullName !== ''
              ? row.fullName
              : row.username;
          const sent =
            row.status === RELATIONSHIP_STATUS.pendingOutgoing ||
            requested[row.id] === true;
          const openProfile = () =>
            onOpenProfile(row.username, colorForName(row.username));
          return (
            <div
              key={row.id}
              className="flex items-start gap-3 border-b border-black/12 px-4 py-3 last:border-b-0"
            >
              <button type="button" onClick={openProfile} className="shrink-0">
                <Avatar
                  name={title}
                  color={colorForName(row.username)}
                  size={72}
                  src={row.avatar}
                  rounded={false}
                />
              </button>
              <div className="flex min-w-0 flex-1 flex-col gap-1.5">
                <button
                  type="button"
                  onClick={openProfile}
                  className="min-w-0 text-left"
                >
                  <span className="flex min-w-0 items-center gap-1">
                    <VipIcon typeId={row.vipTypeId} />
                    <UserName
                      name={`@${row.username}`}
                      fullName={row.fullName}
                      className="min-w-0 truncate text-base font-medium text-black/87"
                    />
                  </span>
                  <span className="block truncate text-xs text-black/45">
                    {formatTime(row.viewedAt)}
                  </span>
                </button>
                {row.status === RELATIONSHIP_STATUS.friend ? (
                  <span className="w-fit rounded bg-black/8 px-3 py-1 text-sm font-medium text-black/45">
                    {t('me.alreadyFriend')}
                  </span>
                ) : sent ? (
                  <span className="w-fit rounded bg-black/8 px-3 py-1 text-sm font-medium text-black/45">
                    {t('me.friendRequestSent')}
                  </span>
                ) : (
                  <button
                    type="button"
                    onClick={() => void addFriend(row)}
                    className="w-fit rounded bg-ola-primary px-3 py-1 text-sm font-medium text-ola-on-primary"
                  >
                    {t('me.makeFriend')}
                  </button>
                )}
              </div>
            </div>
          );
        })}
      <div ref={sentinelRef} className="h-1" />
      {loadingMore && (
        <div className="flex justify-center py-3">
          <Spinner size={22} />
        </div>
      )}
    </div>
  );
}

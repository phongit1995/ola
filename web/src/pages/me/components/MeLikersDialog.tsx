import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, Dialog } from '@components';
import { colorForName, toast } from '@lib';
import { MeService } from '@services';
import type { PostAuthor } from '@app-types';

interface MeLikersDialogProps {
  postId: string;
  onClose: () => void;
  onOpenProfile?: (nick: string, color: string) => void;
}

const PAGE_SIZE = 30;

export function MeLikersDialog({ postId, onClose, onOpenProfile }: MeLikersDialogProps) {
  const { t } = useTranslation();
  const [likers, setLikers] = useState<PostAuthor[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [error, setError] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);
  const sentinelRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const result = await MeService.likers(postId, { limit: PAGE_SIZE, offset: 0 });
        if (!active) return;
        setLikers(result.items);
        setTotal(result.total);
      } catch (err) {
        console.error('load likers failed', err);
        if (active) setError(true);
      } finally {
        if (active) setLoading(false);
      }
    })();
    return () => {
      active = false;
    };
  }, [postId]);

  const hasMore = likers.length < total;

  const loadMore = useCallback(async () => {
    if (loading || loadingMore) return;
    setLoadingMore(true);
    try {
      const result = await MeService.likers(postId, { limit: PAGE_SIZE, offset: likers.length });
      setLikers((current) => [...current, ...result.items]);
      setTotal(result.total);
    } catch (err) {
      console.error('load more likers failed', err);
    } finally {
      setLoadingMore(false);
    }
  }, [postId, likers.length, loading, loadingMore]);

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
  }, [hasMore, loadMore, likers.length]);

  function openProfile(name: string) {
    onOpenProfile?.(name, colorForName(name));
    onClose();
  }

  return (
    <Dialog
      open
      onClose={onClose}
      title={total > 0 ? t('me.likersCount', { count: total }) : t('me.likersTitle')}
    >
      <div ref={scrollRef} className="max-h-80 min-h-15 overflow-y-auto">
        {loading && (
          <div className="py-6 text-center text-sm text-black/54">{t('common.loading')}</div>
        )}
        {!loading && error && (
          <div className="py-6 text-center text-sm text-ola-error">{t('me.likersError')}</div>
        )}
        {!loading && !error && likers.length === 0 && (
          <div className="py-6 text-center text-sm text-black/54">{t('me.likersEmpty')}</div>
        )}
        {!loading &&
          !error &&
          likers.map((user) => (
            <div
              key={user.id}
              className="flex items-center gap-3 border-b border-black/12 px-2 py-3 last:border-b-0"
            >
              <button
                type="button"
                onClick={() => openProfile(user.username)}
                className="flex min-w-0 flex-1 items-center gap-3 text-left"
              >
                <Avatar
                  name={user.username}
                  color={colorForName(user.username)}
                  size={72}
                  src={user.avatar}
                  rounded={false}
                />
                <span className="min-w-0 flex-1 truncate text-base font-medium text-black/87">
                  {user.fullName != null && user.fullName !== '' ? user.fullName : user.username}
                </span>
              </button>
              <button
                type="button"
                onClick={() => toast.info(t('me.makeFriendSoon'))}
                className="shrink-0 rounded bg-ola-primary px-3 py-1.5 text-sm font-medium text-white"
              >
                {t('me.makeFriend')}
              </button>
            </div>
          ))}
        <div ref={sentinelRef} className="h-1" />
        {loadingMore && (
          <div className="py-3 text-center text-sm text-black/54">{t('common.loading')}</div>
        )}
      </div>
    </Dialog>
  );
}

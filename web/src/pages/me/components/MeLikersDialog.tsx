import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, Spinner } from '@components';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { colorForName, toast } from '@lib';
import { RELATIONSHIP_STATUS } from '@constants';
import { MeService, RelationshipService } from '@services';
import type { PostAuthor } from '@app-types';
import { PAGE_SIZE } from '../constants';
import { useOffsetPage } from '@ola/shared/stores/useOffsetPage';

interface MeLikersDialogProps {
  postId: string;
  commentId?: string;
  onClose: () => void;
  onOpenProfile?: (nick: string, color: string) => void;
}

export function MeLikersDialog({
  postId,
  commentId,
  onClose,
  onOpenProfile,
}: MeLikersDialogProps) {
  const { t } = useTranslation();
  const scrollRef = useRef<HTMLDivElement>(null);
  const sentinelRef = useRef<HTMLDivElement>(null);

  const loadPage = useCallback(
    (offset: number) =>
      commentId != null
        ? MeService.commentLikers(postId, commentId, {
            limit: PAGE_SIZE,
            offset,
          })
        : MeService.likers(postId, { limit: PAGE_SIZE, offset }),
    [postId, commentId]
  );

  const {
    items: likers,
    total,
    loading,
    loadingMore,
    error: loadError,
    hasMore,
    loadMore,
  } = useOffsetPage(loadPage, { pageSize: PAGE_SIZE });
  const error = loadError != null;

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

  const [requested, setRequested] = useState<Record<string, boolean>>({});

  function openProfile(name: string) {
    onOpenProfile?.(name, colorForName(name));
    onClose();
  }

  async function addFriend(user: PostAuthor) {
    try {
      await RelationshipService.sendRequest(user.id);
      setRequested((current) => ({ ...current, [user.id]: true }));
      toast.success(t('me.friendRequestSent'));
    } catch {
      toast.error(t('me.makeFriendError'));
    }
  }

  return (
    <Dialog
      open
      onClose={onClose}
      showClose
      title={
        total > 0 ? t('me.likersCount', { count: total }) : t('me.likersTitle')
      }
    >
      <div ref={scrollRef} className="max-h-80 min-h-15 overflow-y-auto">
        {loading && (
          <div className="flex justify-center py-6">
            <Spinner size={24} />
          </div>
        )}
        {!loading && error && (
          <div className="py-6 text-center text-sm text-ola-error">
            {t('me.likersError')}
          </div>
        )}
        {!loading && !error && likers.length === 0 && (
          <div className="py-6 text-center text-sm text-black/54">
            {t('me.likersEmpty')}
          </div>
        )}
        {!loading &&
          !error &&
          likers.map((user) => {
            const isSelf =
              user.isSelf === true ||
              user.relationship?.status === RELATIONSHIP_STATUS.self;
            const isFriend =
              user.isFriend === true ||
              user.relationship?.status === RELATIONSHIP_STATUS.friend;
            const sent =
              requested[user.id] === true ||
              user.relationship?.status === RELATIONSHIP_STATUS.pendingOutgoing;
            return (
              <div
                key={user.id}
                className="flex items-center gap-3 border-b border-black/12 px-2 py-3 last:border-b-0"
              >
                <button
                  type="button"
                  onClick={() => openProfile(user.username)}
                  className="flex min-w-0 flex-1 items-center gap-3 text-left"
                >
                  <AvatarWithFrame
                    name={user.username}
                    color={colorForName(user.username)}
                    size={44}
                    src={user.avatar}
                    frameId={user.avatarFrameId}
                  />
                  <span className="flex min-w-0 flex-1 flex-col">
                    <span className="truncate text-base font-medium text-black/87">
                      {user.fullName != null && user.fullName !== ''
                        ? user.fullName
                        : user.username}
                    </span>
                    {user.fullName != null && user.fullName !== '' && (
                      <span className="truncate text-sm text-black/45">
                        @{user.username}
                      </span>
                    )}
                  </span>
                </button>
                {!isSelf &&
                  (isFriend ? (
                    <span className="shrink-0 rounded bg-black/8 px-3 py-1.5 text-sm font-medium text-black/45">
                      {t('me.alreadyFriend')}
                    </span>
                  ) : sent ? (
                    <span className="shrink-0 rounded bg-black/8 px-3 py-1.5 text-sm font-medium text-black/45">
                      {t('me.friendRequestSent')}
                    </span>
                  ) : (
                    <button
                      type="button"
                      onClick={() => void addFriend(user)}
                      className="shrink-0 rounded bg-ola-primary px-3 py-1.5 text-sm font-medium text-ola-on-primary"
                    >
                      {t('me.makeFriend')}
                    </button>
                  ))}
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
    </Dialog>
  );
}

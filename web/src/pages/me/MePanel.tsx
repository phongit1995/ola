import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { HomeHeader } from '@components/HomeHeader';
import { DEFAULT_AVATAR_COLOR, toast } from '@lib';
import editIcon from '@/assets/icons/me/ic_action_edit.png';
import menuIcon from '@/assets/icons/me/ic_more_white.png';
import { useAuthStore } from '@/store/authStore';
import { useHorizontalSwipe } from '@hooks';
import { PullToRefresh } from '@components';
import { MeTabBar } from './components/MeTabBar';
import { MeFeedList } from './components/MeFeedList';
import { MeLeftDrawer } from './components/MeLeftDrawer';
import { MeRightDrawer } from './components/MeRightDrawer';
import { MeComposerDialog } from './components/MeComposerDialog';
import { MePostInteractions, type MePostSource } from './MePostInteractions';
import { useMeFeed } from './useMeFeed';
import { MeLikedPostsView } from './MeLikedPostsView';
import { MeVisitorsView } from './MeVisitorsView';
import { MeNotificationsView } from './MeNotificationsView';
import { MarriageView } from '../marriage/MarriageView';
import { useMeNotificationStore } from '@ola/shared/stores/meNotificationStore';
import { useClanOverlayStore } from '@/store/clanOverlayStore';
import bellIcon from '@/assets/icons/me/ic_action_notification.png';
import searchIcon from '@/assets/icons/me/ic_action_search.png';

export function MePanel() {
  const { t } = useTranslation();
  const username = useAuthStore((s) => s.user?.username ?? null);
  const meId = useAuthStore((s) => s.user?.id ?? null);
  const avatarUrl = useAuthStore((s) => s.user?.avatar ?? null);
  const coverUrl = useAuthStore((s) => s.user?.coverPhoto ?? null);
  const displayName = username ?? t('home.guest');

  const {
    tab,
    setTab,
    posts,
    loading,
    loadingMore,
    hasMore,
    error,
    loadMore,
    refresh,
    toggleReaction,
    addPost,
    editPost,
    deletePost,
    togglePin,
    hidePost,
    blockAuthor,
    adjustCommentCount,
  } = useMeFeed();

  const [composerOpen, setComposerOpen] = useState(false);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [marriageOpen, setMarriageOpen] = useState(false);
  const [likedOpen, setLikedOpen] = useState(false);
  const [visitorsOpen, setVisitorsOpen] = useState(false);
  const [notifOpen, setNotifOpen] = useState(false);
  const unreadCount = useMeNotificationStore((s) => s.unreadCount);
  const refreshUnread = useMeNotificationStore((s) => s.refreshUnread);

  useEffect(() => {
    void refreshUnread();
  }, [refreshUnread]);

  const swipeHandlers = useHorizontalSwipe({
    onSwipeLeft: () => setSearchOpen(true),
  });

  if (marriageOpen) {
    return <MarriageView onBack={() => setMarriageOpen(false)} />;
  }

  if (likedOpen) {
    return <MeLikedPostsView onClose={() => setLikedOpen(false)} />;
  }

  if (visitorsOpen) {
    return <MeVisitorsView onClose={() => setVisitorsOpen(false)} />;
  }

  if (notifOpen) {
    return <MeNotificationsView onClose={() => setNotifOpen(false)} />;
  }

  const source: MePostSource = {
    posts,
    meId,
    toggleReaction,
    adjustCommentCount,
    hidePost,
    blockAuthor,
    editPost,
    deletePost,
    togglePin,
  };

  const emptyText = t('me.empty');

  return (
    <MePostInteractions source={source}>
      {(handlers) => (
        <>
          <HomeHeader>
            <button
              type="button"
              aria-label={t('me.openMenu')}
              onClick={() => setDrawerOpen(true)}
              className="flex h-12 w-10 shrink-0 items-center justify-center"
            >
              <img src={menuIcon} alt="" className="h-5 w-5 object-contain" />
            </button>
            <MeTabBar active={tab} onChange={setTab} />
            <button
              type="button"
              aria-label={t('me.notifTitle')}
              onClick={() => setNotifOpen(true)}
              className="flex h-12 w-10 shrink-0 items-center justify-center"
            >
              <span className="relative">
                <img
                  src={bellIcon}
                  alt=""
                  className="h-6 w-6 object-contain brightness-0 invert"
                />
                {unreadCount > 0 && (
                  <span className="absolute -top-1 right-0 flex h-4 min-w-4 items-center justify-center rounded-full border-2 border-white bg-ola-accent px-1 text-[10px] font-bold text-white">
                    {unreadCount > 99 ? '99+' : unreadCount}
                  </span>
                )}
              </span>
            </button>
            <button
              type="button"
              aria-label={t('me.openSearch')}
              onClick={() => setSearchOpen(true)}
              className="flex h-12 w-10 shrink-0 items-center justify-center"
            >
              <img
                src={searchIcon}
                alt=""
                className="h-6 w-6 object-contain brightness-0 invert"
              />
            </button>
          </HomeHeader>

          <div
            className="relative min-h-0 flex-1"
            onTouchStart={swipeHandlers.onTouchStart}
            onTouchMove={swipeHandlers.onTouchMove}
            onTouchEnd={swipeHandlers.onTouchEnd}
            onTouchCancel={swipeHandlers.onTouchCancel}
          >
            <PullToRefresh
              onRefresh={refresh}
              className="absolute inset-0 overflow-y-auto bg-[#f3f3f3]"
            >
              <MeFeedList
                posts={posts}
                loading={loading}
                loadingMore={loadingMore}
                hasMore={hasMore}
                error={error}
                emptyText={emptyText}
                onLoadMore={loadMore}
                onToggleLike={handlers.onToggleLike}
                onToggleDislike={handlers.onToggleDislike}
                onOpenProfile={handlers.onOpenProfile}
                onOpenComments={handlers.onOpenComments}
                onQuickComment={handlers.onQuickComment}
                onOpenMenu={handlers.onOpenMenu}
                onOpenLikers={handlers.onOpenLikers}
                onOpenClan={(handle) =>
                  useClanOverlayStore.getState().open({ kind: 'clan', handle })
                }
              />
            </PullToRefresh>

            <button
              type="button"
              aria-label={t('me.composerTitle')}
              onClick={() => setComposerOpen(true)}
              className="absolute right-4 bottom-4 flex h-14 w-14 items-center justify-center rounded-full bg-ola-primary shadow-lg transition hover:brightness-105"
            >
              <img src={editIcon} alt="" className="h-6 w-6 object-contain" />
            </button>

            {drawerOpen && (
              <MeLeftDrawer
                displayName={displayName}
                avatarUrl={avatarUrl ?? undefined}
                coverUrl={coverUrl ?? undefined}
                onClose={() => setDrawerOpen(false)}
                onViewProfile={() =>
                  handlers.onOpenProfile(displayName, DEFAULT_AVATAR_COLOR)
                }
                onSelect={(key) => {
                  if (key === 'personal') {
                    setDrawerOpen(false);
                    handlers.onOpenProfile(displayName, DEFAULT_AVATAR_COLOR);
                  } else if (key === 'marriage') {
                    setDrawerOpen(false);
                    setMarriageOpen(true);
                  } else if (key === 'likes') {
                    setDrawerOpen(false);
                    setLikedOpen(true);
                  } else if (key === 'visitors') {
                    setDrawerOpen(false);
                    setVisitorsOpen(true);
                  } else if (key === 'clan') {
                    setDrawerOpen(false);
                    useClanOverlayStore.getState().open({ kind: 'home' });
                  } else {
                    toast.info(t('me.comingSoon'));
                  }
                }}
              />
            )}

            {searchOpen && (
              <MeRightDrawer
                onClose={() => setSearchOpen(false)}
                onOpenProfile={handlers.onOpenProfile}
              />
            )}
          </div>

          <MeComposerDialog
            open={composerOpen}
            onClose={() => setComposerOpen(false)}
            onPost={addPost}
          />
        </>
      )}
    </MePostInteractions>
  );
}

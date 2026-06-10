import { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { ROUTES } from '@constants';
import { ConfirmDialog, Dialog, DialogButton } from '@components';
import { LanguageSwitcher } from '@components/LanguageSwitcher';
import { HomeHeader } from '@components/HomeHeader';
import editIcon from '@/assets/icons/me/ic_action_edit.png';
import { useAuthStore } from '@/store/authStore';
import { Avatar } from '../chat/components/Avatar';
import { MeTabBar } from './components/MeTabBar';
import { MePostCard } from './components/MePostCard';
import { MeComposerDialog } from './components/MeComposerDialog';
import { ME_POSTS } from './data';
import type { MePost, MeTab } from './types';

let composedPostSeed = 0;

export function MePanel() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const username = useAuthStore((s) => s.username);
  const logout = useAuthStore((s) => s.logout);
  const displayName = username ?? t('home.guest');

  const [tab, setTab] = useState<MeTab>('feed');
  const [posts, setPosts] = useState<MePost[]>(ME_POSTS);
  const [composerOpen, setComposerOpen] = useState(false);
  const [accountOpen, setAccountOpen] = useState(false);
  const [logoutOpen, setLogoutOpen] = useState(false);
  const [showNewBar, setShowNewBar] = useState(false);

  useEffect(() => {
    const timer = window.setTimeout(() => setShowNewBar(true), 4000);
    return () => window.clearTimeout(timer);
  }, []);

  const visiblePosts = useMemo(() => {
    if (tab === 'mentions') return posts.filter((post) => post.mention);
    if (tab === 'media') return posts.filter((post) => post.image != null);
    return posts;
  }, [posts, tab]);

  function toggleLike(id: string) {
    setPosts((current) =>
      current.map((post) =>
        post.id === id
          ? { ...post, liked: !post.liked, likes: post.likes + (post.liked ? -1 : 1) }
          : post
      )
    );
  }

  function toggleDislike(id: string) {
    setPosts((current) =>
      current.map((post) =>
        post.id === id ? { ...post, disliked: !post.disliked } : post
      )
    );
  }

  function addPost(content: string) {
    composedPostSeed += 1;
    setComposerOpen(false);
    setPosts((current) => [
      {
        id: `composed-${composedPostSeed}`,
        author: displayName,
        color: '#7cb342',
        time: t('me.justNow'),
        content,
        image: null,
        comments: 0,
        likes: 0,
        likers: [],
        liked: false,
        disliked: false,
        mention: false,
      },
      ...current,
    ]);
  }

  function confirmLogout() {
    setLogoutOpen(false);
    logout();
    navigate(ROUTES.login);
  }

  return (
    <>
      <HomeHeader>
        <MeTabBar active={tab} onChange={setTab} />
        <button
          type="button"
          aria-label={displayName}
          onClick={() => setAccountOpen(true)}
          className="shrink-0"
        >
          <Avatar name={displayName} color="#33691e" size={32} />
        </button>
      </HomeHeader>

      {showNewBar && (
        <button
          type="button"
          onClick={() => setShowNewBar(false)}
          className="w-full bg-ola-primary-light py-1.5 text-center text-sm font-medium text-ola-primary-dark"
        >
          {t('me.newPosts')}
        </button>
      )}

      <main className="relative flex-1 overflow-y-auto bg-[#f3f3f3]">
        {tab === 'follower' ? (
          <div className="flex h-full items-center justify-center px-8 text-center text-sm text-black/54">
            {t('me.followerEmpty')}
          </div>
        ) : visiblePosts.length === 0 ? (
          <div className="flex h-full items-center justify-center px-8 text-center text-sm text-black/54">
            {t('me.empty')}
          </div>
        ) : (
          <div className="py-2">
            {visiblePosts.map((post) => (
              <MePostCard
                key={post.id}
                post={post}
                onToggleLike={toggleLike}
                onToggleDislike={toggleDislike}
              />
            ))}
          </div>
        )}

        <button
          type="button"
          aria-label={t('me.composerTitle')}
          onClick={() => setComposerOpen(true)}
          className="absolute right-4 bottom-4 flex h-14 w-14 items-center justify-center rounded-full bg-ola-primary shadow-lg transition hover:brightness-105"
        >
          <img src={editIcon} alt="" className="h-6 w-6 object-contain" />
        </button>
      </main>

      <MeComposerDialog
        open={composerOpen}
        onClose={() => setComposerOpen(false)}
        onPost={addPost}
      />

      <Dialog
        open={accountOpen}
        onClose={() => setAccountOpen(false)}
        title={displayName}
        footer={
          <>
            <DialogButton
              variant="danger"
              onClick={() => {
                setAccountOpen(false);
                setLogoutOpen(true);
              }}
            >
              {t('home.logout')}
            </DialogButton>
            <DialogButton variant="default" onClick={() => setAccountOpen(false)}>
              {t('dialog.cancel')}
            </DialogButton>
          </>
        }
      >
        <div className="flex flex-col items-center gap-3 py-2">
          <Avatar name={displayName} color="#7cb342" size={64} />
          <p className="text-base font-medium text-black/87">{displayName}</p>
          <LanguageSwitcher tone="dark" />
        </div>
      </Dialog>

      <ConfirmDialog
        open={logoutOpen}
        showIcon={false}
        danger
        title={t('dialog.logoutTitle')}
        message={t('dialog.logoutMessage')}
        confirmLabel={t('dialog.logoutButton')}
        cancelLabel={t('dialog.no')}
        onConfirm={confirmLogout}
        onCancel={() => setLogoutOpen(false)}
      />
    </>
  );
}

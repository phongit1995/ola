import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { HomeHeader } from '@components/HomeHeader';
import editIcon from '@/assets/icons/me/ic_action_edit.png';
import { useAuthStore } from '@/store/authStore';
import { Avatar } from '../chat/components/Avatar';
import { MeTabBar } from './components/MeTabBar';
import { MeFeedList } from './components/MeFeedList';
import { MeComposerDialog } from './components/MeComposerDialog';
import { MeCommentSheet } from './components/MeCommentSheet';
import { MeAccountDialog } from './components/MeAccountDialog';
import { ProfilePage } from '../profile/ProfilePage';
import { buildProfile } from '../profile/data';
import { useMeFeed } from './useMeFeed';
import type { UserProfile } from '../profile/types';

export function MePanel() {
  const { t } = useTranslation();
  const username = useAuthStore((s) => s.user?.username ?? null);
  const displayName = username ?? t('home.guest');

  const { tab, setTab, posts, loading, error, toggleReaction, addPost, adjustCommentCount } =
    useMeFeed();

  const [composerOpen, setComposerOpen] = useState(false);
  const [accountOpen, setAccountOpen] = useState(false);
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [commentPostId, setCommentPostId] = useState<string | null>(null);

  const commentPost = commentPostId == null ? null : posts.find((p) => p.id === commentPostId);

  function openProfile(nick: string, color: string, isSelf = false) {
    setAccountOpen(false);
    setProfile(buildProfile(nick, color, isSelf));
  }

  const emptyText = t('me.empty');

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

      <div className="relative min-h-0 flex-1">
        <main className="absolute inset-0 overflow-y-auto bg-[#f3f3f3]">
          <MeFeedList
            posts={posts}
            loading={loading}
            error={error}
            emptyText={emptyText}
            onToggleLike={(id) => toggleReaction(id, 'like')}
            onToggleDislike={(id) => toggleReaction(id, 'dislike')}
            onOpenProfile={(author, color) => openProfile(author, color)}
            onOpenComments={setCommentPostId}
          />
        </main>

        <button
          type="button"
          aria-label={t('me.composerTitle')}
          onClick={() => setComposerOpen(true)}
          className="absolute right-4 bottom-4 flex h-14 w-14 items-center justify-center rounded-full bg-ola-primary shadow-lg transition hover:brightness-105"
        >
          <img src={editIcon} alt="" className="h-6 w-6 object-contain" />
        </button>
      </div>

      <MeComposerDialog
        open={composerOpen}
        onClose={() => setComposerOpen(false)}
        onPost={addPost}
      />

      <MeAccountDialog
        open={accountOpen}
        displayName={displayName}
        onClose={() => setAccountOpen(false)}
        onViewProfile={() => openProfile(displayName, '#7cb342', true)}
      />

      {commentPost != null && (
        <MeCommentSheet
          post={commentPost}
          onClose={() => setCommentPostId(null)}
          onToggleLike={(id) => toggleReaction(id, 'like')}
          onToggleDislike={(id) => toggleReaction(id, 'dislike')}
          onOpenProfile={(author, color) => openProfile(author, color)}
          onCommentDelta={adjustCommentCount}
        />
      )}

      {profile != null && (
        <ProfilePage
          profile={profile}
          onClose={() => setProfile(null)}
          onOpenFriend={(friend) => setProfile(buildProfile(friend.name, friend.color))}
        />
      )}
    </>
  );
}

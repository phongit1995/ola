import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { HomeHeader } from '@components/HomeHeader';
import { toast } from '@lib';
import { MeService } from '@services';
import editIcon from '@/assets/icons/me/ic_action_edit.png';
import { useAuthStore } from '@/store/authStore';
import { Avatar } from '@components';
import { MeTabBar } from './components/MeTabBar';
import { MeFeedList } from './components/MeFeedList';
import { MeComposerDialog } from './components/MeComposerDialog';
import { MeCommentSheet } from './components/MeCommentSheet';
import { MeCommentComposer } from './components/MeCommentComposer';
import { MeAccountDialog } from './components/MeAccountDialog';
import { ProfilePage } from '../profile/ProfilePage';
import { buildProfile } from '../profile/data';
import { useMeFeed } from './useMeFeed';
import type { UserProfile } from '../profile/types';

export function MePanel() {
  const { t } = useTranslation();
  const username = useAuthStore((s) => s.user?.username ?? null);
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
    toggleReaction,
    addPost,
    adjustCommentCount,
  } = useMeFeed();

  const [composerOpen, setComposerOpen] = useState(false);
  const [accountOpen, setAccountOpen] = useState(false);
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [commentPostId, setCommentPostId] = useState<string | null>(null);
  const [commentFocusInput, setCommentFocusInput] = useState(false);
  const [quickCommentPostId, setQuickCommentPostId] = useState<string | null>(null);
  const [quickSubmitting, setQuickSubmitting] = useState(false);

  const commentPost = commentPostId == null ? null : posts.find((p) => p.id === commentPostId);
  const quickPost =
    quickCommentPostId == null ? null : posts.find((p) => p.id === quickCommentPostId);

  function openComments(id: string, focusInput = false) {
    setCommentPostId(id);
    setCommentFocusInput(focusInput);
  }

  async function submitComment(postId: string, text: string): Promise<boolean> {
    const content = text.trim();
    if (content === '') return false;
    try {
      await MeService.addComment(postId, { content });
      adjustCommentCount(postId, 1);
      toast.success(t('me.commentSent'));
      return true;
    } catch {
      toast.error(t('me.commentSendError'));
      return false;
    }
  }

  async function submitQuickComment(text: string): Promise<boolean> {
    if (quickCommentPostId == null) return false;
    setQuickSubmitting(true);
    const ok = await submitComment(quickCommentPostId, text);
    setQuickSubmitting(false);
    if (ok) setQuickCommentPostId(null);
    return ok;
  }

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
            loadingMore={loadingMore}
            hasMore={hasMore}
            error={error}
            emptyText={emptyText}
            onLoadMore={loadMore}
            onToggleLike={(id) => toggleReaction(id, 'like')}
            onToggleDislike={(id) => toggleReaction(id, 'dislike')}
            onOpenProfile={(author, color) => openProfile(author, color)}
            onOpenComments={openComments}
            onQuickComment={setQuickCommentPostId}
          />
        </main>

        {quickCommentPostId != null && (
          <>
            <button
              type="button"
              aria-label={t('chat.back')}
              onClick={() => setQuickCommentPostId(null)}
              className="absolute inset-0 z-10 bg-black/20"
            />
            <div className="absolute inset-x-0 bottom-0 z-20">
              {quickPost != null && (
                <div className="flex items-center gap-2 border-t border-black/12 bg-white/95 px-3 py-1.5 text-xs text-black/54">
                  <span className="shrink-0">{t('me.commentingOn')}</span>
                  <span className="min-w-0 flex-1 truncate text-black/87">
                    {quickPost.content !== '' ? quickPost.content : quickPost.author}
                  </span>
                </div>
              )}
              <MeCommentComposer submitting={quickSubmitting} onSubmit={submitQuickComment} autoFocus />
            </div>
          </>
        )}

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
          autoFocusInput={commentFocusInput}
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

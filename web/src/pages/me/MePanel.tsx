import { useCallback, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { HomeHeader } from '@components/HomeHeader';
import { DEFAULT_AVATAR_COLOR, toast } from '@lib';
import { MeService } from '@services';
import editIcon from '@/assets/icons/me/ic_action_edit.png';
import menuIcon from '@/assets/icons/me/ic_more_white.png';
import { useAuthStore } from '@/store/authStore';
import { Avatar, ConfirmDialog, ListOptionDialog, type ListOption } from '@components';
import { MeTabBar } from './components/MeTabBar';
import { MeFeedList } from './components/MeFeedList';
import { MeLeftDrawer } from './components/MeLeftDrawer';
import { MeComposerDialog, type ComposedPost } from './components/MeComposerDialog';
import { MeCommentSheet } from './components/MeCommentSheet';
import { MeCommentComposer } from './components/MeCommentComposer';
import { MeLikersDialog } from './components/MeLikersDialog';
import { MeAccountDialog } from './components/MeAccountDialog';
import { ProfilePage } from '../profile/ProfilePage';
import { buildProfile } from '../profile/data';
import { useMeFeed } from './useMeFeed';
import { EDIT_WINDOW_MS } from './constants';
import type { UserProfile } from '../profile/types';

export function MePanel() {
  const { t } = useTranslation();
  const username = useAuthStore((s) => s.user?.username ?? null);
  const meId = useAuthStore((s) => s.user?.id ?? null);
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
    editPost,
    deletePost,
    hidePost,
    blockAuthor,
    adjustCommentCount,
  } = useMeFeed();

  const [composerOpen, setComposerOpen] = useState(false);
  const [accountOpen, setAccountOpen] = useState(false);
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [commentPostId, setCommentPostId] = useState<string | null>(null);
  const [commentFocusInput, setCommentFocusInput] = useState(false);
  const [quickCommentPostId, setQuickCommentPostId] = useState<string | null>(null);
  const [quickSubmitting, setQuickSubmitting] = useState(false);
  const [menuPostId, setMenuPostId] = useState<string | null>(null);
  const [editPostId, setEditPostId] = useState<string | null>(null);
  const [deletePostId, setDeletePostId] = useState<string | null>(null);
  const [likersPostId, setLikersPostId] = useState<string | null>(null);
  const [drawerOpen, setDrawerOpen] = useState(false);

  const commentPost = commentPostId == null ? null : posts.find((p) => p.id === commentPostId);
  const quickPost =
    quickCommentPostId == null ? null : posts.find((p) => p.id === quickCommentPostId);
  const menuPost = menuPostId == null ? null : posts.find((p) => p.id === menuPostId);
  const isMenuPostMine = menuPost != null && meId != null && menuPost.authorId === meId;
  const hideAndNotify = (id: string | null) => {
    if (id == null) return;
    hidePost(id);
    toast.success(t('me.hideSuccess'));
  };
  const blockAndNotify = (authorId?: string) => {
    if (authorId == null || authorId === '') return;
    blockAuthor(authorId);
    toast.success(t('me.blockSuccess'));
  };
  const requestEdit = (id: string | null) => {
    if (id == null) return;
    const post = posts.find((p) => p.id === id);
    if (post == null) return;
    const createdAtMs = post.createdAt != null ? new Date(post.createdAt).getTime() : 0;
    if (Date.now() - createdAtMs > EDIT_WINDOW_MS) {
      toast.info(t('me.editExpired'));
      return;
    }
    setEditPostId(id);
  };
  const menuOptions: ListOption[] = isMenuPostMine
    ? [
        { key: 'edit', label: t('me.menuEdit'), onSelect: () => requestEdit(menuPostId) },
        {
          key: 'delete',
          label: t('me.menuDelete'),
          danger: true,
          onSelect: () => setDeletePostId(menuPostId),
        },
      ]
    : [
        { key: 'hide', label: t('me.menuHide'), onSelect: () => hideAndNotify(menuPostId) },
        { key: 'save', label: t('me.menuSave'), onSelect: () => toast.success(t('me.saveSuccess')) },
        {
          key: 'share',
          label: t('me.menuShare'),
          onSelect: () => toast.success(t('me.shareSuccess')),
        },
        {
          key: 'block',
          label: t('me.menuBlock'),
          danger: true,
          onSelect: () => blockAndNotify(menuPost?.authorId),
        },
      ];

  const editingPost = editPostId == null ? null : posts.find((p) => p.id === editPostId);
  const editInitial: ComposedPost | undefined =
    editingPost == null
      ? undefined
      : {
          content: editingPost.content,
          files: [],
          imageUrls: editingPost.photos ?? [],
          checkIn: editingPost.checkIn
            ? {
                name: editingPost.checkIn.name,
                address: editingPost.checkIn.address ?? '',
                lat: editingPost.checkIn.lat ?? 0,
                lng: editingPost.checkIn.lng ?? 0,
                action: editingPost.checkIn.action,
                actionIcon: editingPost.checkIn.actionIcon,
              }
            : null,
          sticker: editingPost.image,
          visibility: editingPost.visibility,
        };
  const submitEdit = useCallback(
    (draft: ComposedPost) =>
      editPostId == null ? Promise.resolve(false) : editPost(editPostId, draft),
    [editPostId, editPost]
  );

  const openComments = useCallback((id: string, focusInput = false) => {
    setCommentPostId(id);
    setCommentFocusInput(focusInput);
  }, []);

  const toggleLike = useCallback((id: string) => toggleReaction(id, 'like'), [toggleReaction]);
  const toggleDislike = useCallback((id: string) => toggleReaction(id, 'dislike'), [toggleReaction]);

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

  const openProfile = useCallback((nick: string, color: string, isSelf = false) => {
    setAccountOpen(false);
    setProfile(buildProfile(nick, color, isSelf));
  }, []);

  const emptyText = t('me.empty');

  return (
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
            onToggleLike={toggleLike}
            onToggleDislike={toggleDislike}
            onOpenProfile={openProfile}
            onOpenComments={openComments}
            onQuickComment={setQuickCommentPostId}
            onOpenMenu={setMenuPostId}
            onOpenLikers={setLikersPostId}
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

        {drawerOpen && (
          <MeLeftDrawer
            displayName={displayName}
            onClose={() => setDrawerOpen(false)}
            onSelect={() => toast.info(t('me.comingSoon'))}
          />
        )}
      </div>

      <MeComposerDialog
        open={composerOpen}
        onClose={() => setComposerOpen(false)}
        onPost={addPost}
      />

      <ListOptionDialog
        open={menuPost != null}
        title={t('me.postMenu')}
        options={menuOptions}
        onClose={() => setMenuPostId(null)}
      />

      <MeComposerDialog
        key={editPostId ?? 'edit'}
        open={editingPost != null}
        initial={editInitial}
        title={t('me.editTitle')}
        submitLabel={t('me.saveEdit')}
        onClose={() => setEditPostId(null)}
        onPost={submitEdit}
      />

      <ConfirmDialog
        open={deletePostId != null}
        title={t('me.deleteConfirmTitle')}
        message={t('me.deleteConfirmText')}
        confirmLabel={t('me.deleteConfirmOk')}
        cancelLabel={t('dialog.cancel')}
        danger
        onCancel={() => setDeletePostId(null)}
        onConfirm={() => {
          const id = deletePostId;
          setDeletePostId(null);
          if (id != null) void deletePost(id);
        }}
      />

      <MeAccountDialog
        open={accountOpen}
        displayName={displayName}
        onClose={() => setAccountOpen(false)}
        onViewProfile={() => openProfile(displayName, DEFAULT_AVATAR_COLOR, true)}
      />

      {likersPostId != null && (
        <MeLikersDialog
          postId={likersPostId}
          onClose={() => setLikersPostId(null)}
          onOpenProfile={openProfile}
        />
      )}

      {commentPost != null && (
        <MeCommentSheet
          post={commentPost}
          autoFocusInput={commentFocusInput}
          onClose={() => setCommentPostId(null)}
          onToggleLike={toggleLike}
          onToggleDislike={toggleDislike}
          onOpenProfile={openProfile}
          onOpenLikers={setLikersPostId}
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

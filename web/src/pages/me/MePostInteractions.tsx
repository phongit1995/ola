import { useCallback, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { toast } from '@lib';
import { MeService } from '@services';
import { ConfirmDialog, ListOptionDialog, type ListOption } from '@components';
import type { PostReaction } from '@app-types';
import { MeComposerDialog, type ComposedPost } from './components/MeComposerDialog';
import { MeCommentSheet } from './components/MeCommentSheet';
import { MeCommentComposer } from './components/MeCommentComposer';
import { MeLikersDialog } from './components/MeLikersDialog';
import { UserProfileView } from '../profile/UserProfileView';
import { EDIT_WINDOW_MS } from './constants';
import type { MePost } from './types';

export interface MePostSource {
  posts: MePost[];
  meId: string | null;
  toggleReaction: (id: string, type: PostReaction) => void;
  adjustCommentCount: (id: string, delta: number) => void;
  hidePost: (id: string) => void;
  blockAuthor: (authorId: string) => void;
  editPost?: (id: string, draft: ComposedPost) => Promise<boolean>;
  deletePost?: (id: string) => void;
}

export interface MePostCardHandlers {
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile: (author: string, color: string) => void;
  onOpenComments: (id: string, focusInput?: boolean) => void;
  onQuickComment: (id: string) => void;
  onOpenMenu: (id: string) => void;
  onOpenLikers: (id: string) => void;
}

interface MePostInteractionsProps {
  source: MePostSource;
  children: (handlers: MePostCardHandlers) => ReactNode;
}

export function MePostInteractions({ source, children }: MePostInteractionsProps) {
  const { t } = useTranslation();
  const { posts, meId, toggleReaction, adjustCommentCount, editPost, deletePost } = source;

  const [profileTarget, setProfileTarget] = useState<{ username: string; color: string } | null>(
    null
  );
  const [commentPostId, setCommentPostId] = useState<string | null>(null);
  const [commentFocusInput, setCommentFocusInput] = useState(false);
  const [quickCommentPostId, setQuickCommentPostId] = useState<string | null>(null);
  const [quickSubmitting, setQuickSubmitting] = useState(false);
  const [menuPostId, setMenuPostId] = useState<string | null>(null);
  const [editPostId, setEditPostId] = useState<string | null>(null);
  const [deletePostId, setDeletePostId] = useState<string | null>(null);
  const [likersPostId, setLikersPostId] = useState<string | null>(null);

  const commentPost = commentPostId == null ? null : posts.find((p) => p.id === commentPostId);
  const quickPost =
    quickCommentPostId == null ? null : posts.find((p) => p.id === quickCommentPostId);
  const menuPost = menuPostId == null ? null : posts.find((p) => p.id === menuPostId);
  const isMenuPostMine = menuPost != null && meId != null && menuPost.authorId === meId;
  const canManageOwn = editPost != null && deletePost != null;

  const hideAndNotify = (id: string | null) => {
    if (id == null) return;
    source.hidePost(id);
    toast.success(t('me.hideSuccess'));
  };

  const blockAndNotify = (authorId?: string) => {
    if (authorId == null || authorId === '') return;
    source.blockAuthor(authorId);
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

  const menuOptions: ListOption[] =
    isMenuPostMine && canManageOwn
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
      editPostId == null || editPost == null
        ? Promise.resolve(false)
        : editPost(editPostId, draft),
    [editPostId, editPost]
  );

  const openProfile = useCallback((nick: string, color: string) => {
    setProfileTarget({ username: nick, color });
  }, []);

  const openComments = useCallback((id: string, focusInput = false) => {
    setCommentPostId(id);
    setCommentFocusInput(focusInput);
  }, []);

  const toggleLike = useCallback(
    (id: string) => toggleReaction(id, 'like'),
    [toggleReaction]
  );
  const toggleDislike = useCallback(
    (id: string) => toggleReaction(id, 'dislike'),
    [toggleReaction]
  );

  const submitComment = useCallback(
    async (postId: string, text: string): Promise<boolean> => {
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
    },
    [adjustCommentCount, t]
  );

  async function submitQuickComment(text: string): Promise<boolean> {
    if (quickCommentPostId == null) return false;
    setQuickSubmitting(true);
    const ok = await submitComment(quickCommentPostId, text);
    setQuickSubmitting(false);
    if (ok) setQuickCommentPostId(null);
    return ok;
  }

  const handlers: MePostCardHandlers = {
    onToggleLike: toggleLike,
    onToggleDislike: toggleDislike,
    onOpenProfile: openProfile,
    onOpenComments: openComments,
    onQuickComment: setQuickCommentPostId,
    onOpenMenu: setMenuPostId,
    onOpenLikers: setLikersPostId,
  };

  return (
    <>
      {children(handlers)}

      {quickCommentPostId != null && (
        <>
          <button
            type="button"
            aria-label={t('chat.back')}
            onClick={() => setQuickCommentPostId(null)}
            className="fixed inset-0 z-30 bg-black/20"
          />
          <div className="fixed inset-x-0 bottom-0 z-40">
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

      <ListOptionDialog
        open={menuPost != null}
        title={t('me.postMenu')}
        options={menuOptions}
        onClose={() => setMenuPostId(null)}
      />

      {canManageOwn && (
        <MeComposerDialog
          key={editPostId ?? 'edit'}
          open={editingPost != null}
          initial={editInitial}
          title={t('me.editTitle')}
          submitLabel={t('me.saveEdit')}
          onClose={() => setEditPostId(null)}
          onPost={submitEdit}
        />
      )}

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
          if (id != null) deletePost?.(id);
        }}
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

      {profileTarget != null && (
        <UserProfileView
          key={profileTarget.username}
          username={profileTarget.username}
          color={profileTarget.color}
          onClose={() => setProfileTarget(null)}
          onOpenFriend={(friend) => setProfileTarget({ username: friend.name, color: friend.color })}
        />
      )}
    </>
  );
}

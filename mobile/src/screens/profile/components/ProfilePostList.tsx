import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Text } from 'react-native';
import { MeService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { usePostListActions } from '@ola/shared/stores/usePostListActions';
import { createTimeFormatter, postTimeLabel, toApiError } from '@ola/shared/lib';
import { EDIT_WINDOW_MS } from '@ola/shared/constants';
import type { Post } from '@ola/shared/types';
import { useMeLocalStore } from '@store/meLocalStore';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { MePostCard } from '@screens/me/components/MePostCard';
import { MeCommentSheet } from '@screens/me/components/MeCommentSheet';
import { MeLikersDialog } from '@screens/me/components/MeLikersDialog';
import { MeQuickCommentBar } from '@screens/me/components/MeQuickCommentBar';
import { MeComposerModal } from '@screens/me/components/MeComposerModal';
import type { OpenProfileHandler, OpenViewerHandler } from '../types';

interface ProfilePostListProps {
  posts: Post[];
  setPosts: React.Dispatch<React.SetStateAction<Post[]>>;
  postsLoading: boolean;
  language: string;
  onOpenProfile: OpenProfileHandler;
  openViewer: OpenViewerHandler;
  reloadPosts: () => Promise<void>;
}

export function ProfilePostList({
  posts,
  setPosts,
  postsLoading,
  language,
  onOpenProfile,
  openViewer,
  reloadPosts,
}: ProfilePostListProps) {
  const { t } = useTranslation();
  const push = useToastStore(s => s.push);
  const meId = useAuthStore(s => s.user?.id) ?? '';
  const hiddenPostIds = useMeLocalStore(s => s.hiddenPostIds);
  const hidePost = useMeLocalStore(s => s.hidePost);
  const blockAuthor = useMeLocalStore(s => s.blockAuthor);

  const [commentPostId, setCommentPostId] = useState<string | null>(null);
  const [commentFocusInput, setCommentFocusInput] = useState(false);
  const [likersPostId, setLikersPostId] = useState<string | null>(null);
  const [menuPostId, setMenuPostId] = useState<string | null>(null);
  const [quickCommentPostId, setQuickCommentPostId] = useState<string | null>(null);
  const [quickSubmitting, setQuickSubmitting] = useState(false);
  const [deletePostId, setDeletePostId] = useState<string | null>(null);
  const [editingPost, setEditingPost] = useState<Post | null>(null);

  const formatTime = useMemo(() => createTimeFormatter(language), [language]);

  const visiblePosts = useMemo(() => {
    if (hiddenPostIds.length === 0) return posts;
    const hidden = new Set(hiddenPostIds);
    return posts.filter(p => !hidden.has(p.id));
  }, [posts, hiddenPostIds]);

  const { toggleReaction, adjustCommentCount, deletePost, togglePin } = usePostListActions({
    posts,
    setPosts,
    reloadAfterPin: reloadPosts,
  });

  function requestEdit(post: Post) {
    const createdAtMs =
      post.createdAt != null ? new Date(post.createdAt).getTime() : 0;
    if (Date.now() - createdAtMs > EDIT_WINDOW_MS) {
      push('info', t('me.editExpired'));
      return;
    }
    setEditingPost(post);
  }

  function buildPostMenuOptions(post: Post): ListOption[] {
    const mine = meId !== '' && post.author?.id === meId;
    if (mine) {
      return [
        {
          key: 'edit',
          label: t('me.menuEdit'),
          onSelect: () => requestEdit(post),
        },
        {
          key: 'pin',
          label: post.isPinned ? t('me.menuUnpin') : t('me.menuPin'),
          onSelect: () => void togglePin(post.id, !post.isPinned),
        },
        {
          key: 'delete',
          label: t('me.menuDelete'),
          danger: true,
          onSelect: () => setDeletePostId(post.id),
        },
      ];
    }
    return [
      {
        key: 'hide',
        label: t('me.menuHide'),
        onSelect: () => {
          hidePost(post.id);
          push('success', t('me.hideSuccess'));
        },
      },
      {
        key: 'save',
        label: t('me.menuSave'),
        onSelect: () => push('success', t('me.saveSuccess')),
      },
      {
        key: 'share',
        label: t('me.menuShare'),
        onSelect: () => push('success', t('me.shareSuccess')),
      },
      {
        key: 'block',
        label: t('me.menuBlock'),
        danger: true,
        onSelect: () => {
          const authorId = post.author?.id;
          if (authorId == null || authorId === '') return;
          blockAuthor(authorId);
          push('success', t('me.blockSuccess'));
        },
      },
    ];
  }

  async function submitQuickComment(text: string): Promise<boolean> {
    const id = quickCommentPostId;
    const content = text.trim();
    if (id == null || content === '') return false;
    setQuickSubmitting(true);
    try {
      await MeService.addComment(id, { content });
      adjustCommentCount(id, 1);
      push('success', t('me.commentSent'));
      setQuickCommentPostId(null);
      return true;
    } catch (err) {
      push(
        'error',
        toApiError(err).status === 403
          ? t('me.commentErrFriendsOnly')
          : t('me.commentSendError'),
      );
      return false;
    } finally {
      setQuickSubmitting(false);
    }
  }

  const commentPost =
    commentPostId != null ? posts.find(p => p.id === commentPostId) ?? null : null;
  const menuPost =
    menuPostId != null ? posts.find(p => p.id === menuPostId) ?? null : null;
  const quickPost =
    quickCommentPostId != null
      ? posts.find(p => p.id === quickCommentPostId) ?? null
      : null;

  return (
    <>
      <Text
        className="mx-4 mb-1 mt-2 text-base font-medium text-ola-ink"
      >
        {t('profile.mePosts')}
      </Text>
      {postsLoading && visiblePosts.length === 0 ? (
        <ActivityIndicator className="py-6" color="#7cb342" />
      ) : (
        visiblePosts.map(post => (
          <MePostCard
            key={post.id}
            post={post}
            timeLabel={postTimeLabel(post.createdAt, formatTime)}
            onToggleLike={id => void toggleReaction(id, 'like')}
            onToggleDislike={id => void toggleReaction(id, 'dislike')}
            onOpenProfile={onOpenProfile}
            onOpenComments={(id, focusInput) => {
              setCommentFocusInput(focusInput === true);
              setCommentPostId(id);
            }}
            onQuickComment={id => setQuickCommentPostId(id)}
            onOpenMenu={id => setMenuPostId(id)}
            onOpenLikers={id => setLikersPostId(id)}
            onOpenPhotos={(photos, index) => openViewer(photos, index)}
          />
        ))
      )}

      {commentPost != null && (
        <MeCommentSheet
          post={commentPost}
          language={language}
          autoFocusInput={commentFocusInput}
          onClose={() => setCommentPostId(null)}
          onToggleLike={id => void toggleReaction(id, 'like')}
          onToggleDislike={id => void toggleReaction(id, 'dislike')}
          onOpenProfile={onOpenProfile}
          onOpenLikers={id => setLikersPostId(id)}
          onCommentDelta={adjustCommentCount}
        />
      )}

      {likersPostId != null && (
        <MeLikersDialog
          postId={likersPostId}
          onClose={() => setLikersPostId(null)}
          onOpenProfile={onOpenProfile}
        />
      )}

      <ListOptionDialog
        visible={menuPost != null}
        title={t('me.postMenu')}
        options={menuPost != null ? buildPostMenuOptions(menuPost) : []}
        onClose={() => setMenuPostId(null)}
      />

      {quickCommentPostId != null && (
        <MeQuickCommentBar
          contextLabel={
            quickPost == null
              ? undefined
              : quickPost.content != null && quickPost.content !== ''
              ? quickPost.content
              : quickPost.author?.username
          }
          submitting={quickSubmitting}
          onSubmit={submitQuickComment}
          onClose={() => setQuickCommentPostId(null)}
        />
      )}

      <ConfirmDialog
        visible={deletePostId != null}
        danger
        title={t('me.deleteConfirmTitle')}
        message={t('me.deleteConfirmText')}
        confirmLabel={t('me.deleteConfirmOk')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => {
          const id = deletePostId;
          setDeletePostId(null);
          if (id == null) return;
          void deletePost(id);
        }}
        onCancel={() => setDeletePostId(null)}
      />

      {editingPost != null && (
        <MeComposerModal
          visible
          editPost={editingPost}
          onSaved={() => void reloadPosts()}
          onClose={() => setEditingPost(null)}
        />
      )}
    </>
  );
}

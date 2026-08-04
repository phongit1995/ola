import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Text } from 'react-native';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { usePostListActions } from '@ola/shared/stores/usePostListActions';
import { createTimeFormatter } from '@ola/shared/lib';
import type { Post } from '@ola/shared/types';
import { useMeLocalStore } from '@store/meLocalStore';
import { isPostEditExpired } from '@lib/post';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { ReportDialog } from '@components/ui/ReportDialog';
import { MePostCard } from '@screens/me/components/MePostCard';
import { MeCommentSheet } from '@screens/me/components/MeCommentSheet';
import { MeLikersDialog } from '@screens/me/components/MeLikersDialog';
import { MeQuickCommentBar } from '@screens/me/components/MeQuickCommentBar';
import { MeComposerModal } from '@screens/me/components/MeComposerModal';
import { useQuickComment } from '@screens/me/useQuickComment';
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
  const [deletePostId, setDeletePostId] = useState<string | null>(null);
  const [reportPostId, setReportPostId] = useState<string | null>(null);
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

  const {
    quickCommentPostId,
    setQuickCommentPostId,
    quickSubmitting,
    submitQuickComment,
    quickContextLabel,
  } = useQuickComment(posts, adjustCommentCount);

  function requestEdit(post: Post) {
    if (isPostEditExpired(post.createdAt)) {
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
        key: 'share',
        label: t('me.menuShare'),
        onSelect: () => push('success', t('me.shareSuccess')),
      },
      { key: 'report', label: t('report.post'), onSelect: () => setReportPostId(post.id) },
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

  const commentPost =
    commentPostId != null ? posts.find(p => p.id === commentPostId) ?? null : null;
  const menuPost =
    menuPostId != null ? posts.find(p => p.id === menuPostId) ?? null : null;

  const openProfile: OpenProfileHandler = (nick, color) => {
    setCommentPostId(null);
    setLikersPostId(null);
    onOpenProfile(nick, color);
  };

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
            timeLabel={formatTime(post.createdAt)}
            onToggleLike={id => void toggleReaction(id, 'like')}
            onToggleDislike={id => void toggleReaction(id, 'dislike')}
            onOpenProfile={openProfile}
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
          onOpenProfile={openProfile}
          onCommentDelta={adjustCommentCount}
        />
      )}

      {likersPostId != null && (
        <MeLikersDialog
          postId={likersPostId}
          onClose={() => setLikersPostId(null)}
          onOpenProfile={openProfile}
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
          contextLabel={quickContextLabel}
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

      {reportPostId != null && (
        <ReportDialog
          target={{ type: 'post', id: reportPostId }}
          onClose={() => setReportPostId(null)}
        />
      )}

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

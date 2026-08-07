import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, RefreshControl, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import {
  filterVisiblePosts,
  isPostVisible,
  createTimeFormatter,
} from '@ola/shared/lib';
import type { Post, PostReaction, PostVisibility } from '@ola/shared/types';
import { useClanFeedStore } from '@ola/shared/stores/clan/clanFeedStore';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { useMeLocalStore } from '@store/meLocalStore';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { ReportDialog } from '@components/ui/ReportDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { MediaViewerModal } from '@components/ui/MediaViewer';
import { MePostCard } from '@screens/me/components/MePostCard';
import { MeComposerModal } from '@screens/me/components/MeComposerModal';
import { MeCommentSheet } from '@screens/me/components/MeCommentSheet';
import { MeQuickCommentBar } from '@screens/me/components/MeQuickCommentBar';
import { MeLikersDialog } from '@screens/me/components/MeLikersDialog';
import { useQuickComment } from '@screens/me/useQuickComment';
import { isPostEditExpired } from '@lib/post';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { canPostPublicInClan, clanFeedErrorText, isClanStaff } from '@lib/clanHelpers';
import { useClanScreen } from './useClanScreen';
import { ClanHeaderCard } from './components/ClanHeaderCard';
import { CLAN_ROLE } from '@ola/shared/constants';

interface ClanScreenProps {
  handle?: string;
  id?: string;
  onClose: () => void;
  onOpenManage: (clanId: string) => void;
  onOpenMembers: (clanId: string) => void;
}

export function ClanScreen({ handle, id, onClose, onOpenManage, onOpenMembers }: ClanScreenProps) {
  const { t, i18n } = useTranslation();
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const pushToast = useToastStore((s) => s.push);
  const meId = useAuthStore((s) => s.user?.id ?? null);
  const hiddenPostIds = useMeLocalStore((s) => s.hiddenPostIds);
  const blockedAuthorIds = useMeLocalStore((s) => s.blockedAuthorIds);
  const hidePostLocal = useMeLocalStore((s) => s.hidePost);
  const blockAuthorLocal = useMeLocalStore((s) => s.blockAuthor);

  const {
    clan,
    loadError,
    imageUploading,
    refreshing,
    leaveConfirm,
    setLeaveConfirm,
    staffConfirm,
    setStaffConfirm,
    staffConfirmText,
    onRefresh,
    handleJoin,
    handleLeave,
    togglePinTop,
    runStaffConfirm,
    deleteOwnPost,
    changeImage,
  } = useClanScreen(handle, id);

  const [composerOpen, setComposerOpen] = useState(false);
  const [commentPostId, setCommentPostId] = useState<string | null>(null);
  const [commentFocusInput, setCommentFocusInput] = useState(false);
  const [likersPostId, setLikersPostId] = useState<string | null>(null);
  const [menuPostId, setMenuPostId] = useState<string | null>(null);
  const [reportPostId, setReportPostId] = useState<string | null>(null);
  const [deletePostId, setDeletePostId] = useState<string | null>(null);
  const [editingPost, setEditingPost] = useState<Post | null>(null);
  const [viewer, setViewer] = useState<{ images: string[]; index: number } | null>(null);

  const feedPinned = useClanFeedStore((s) => s.pinned);
  const feedPosts = useClanFeedStore((s) => s.posts);
  const feedLoading = useClanFeedStore((s) => s.loading);
  const feedLoadingMore = useClanFeedStore((s) => s.loadingMore);
  const feedError = useClanFeedStore((s) => s.error);
  const toggleReaction = useClanFeedStore((s) => s.toggleReaction);
  const adjustCommentCount = useClanFeedStore((s) => s.adjustCommentCount);

  const timeFormatter = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  const visiblePosts = useMemo(
    () => filterVisiblePosts(feedPosts, hiddenPostIds, blockedAuthorIds),
    [feedPosts, hiddenPostIds, blockedAuthorIds]
  );

  const visiblePinned = useMemo(
    () =>
      feedPinned != null && isPostVisible(feedPinned, hiddenPostIds, blockedAuthorIds)
        ? feedPinned
        : null,
    [feedPinned, hiddenPostIds, blockedAuthorIds]
  );

  const allPosts = useMemo(
    () => (visiblePinned != null ? [visiblePinned, ...visiblePosts] : visiblePosts),
    [visiblePinned, visiblePosts]
  );

  const {
    quickCommentPostId,
    setQuickCommentPostId,
    quickSubmitting,
    submitQuickComment,
    quickContextLabel,
  } = useQuickComment(allPosts, adjustCommentCount);

  const commentPost =
    commentPostId != null ? allPosts.find((p) => p.id === commentPostId) ?? null : null;
  const menuPost = menuPostId != null ? allPosts.find((p) => p.id === menuPostId) ?? null : null;

  const handleReaction = (postId: string, type: PostReaction) => void toggleReaction(postId, type);
  const openProfile = (nick: string) => {
    setCommentPostId(null);
    setLikersPostId(null);
    navigation.navigate(ROOT_ROUTES.ProfileView, { userId: nick });
  };

  function openComments(postId: string, focusInput?: boolean) {
    setCommentFocusInput(focusInput === true);
    setCommentPostId(postId);
  }

  function requestEdit(post: Post) {
    if (isPostEditExpired(post.createdAt)) {
      pushToast('info', t('me.editExpired'));
      return;
    }
    setEditingPost(post);
  }

  function buildMenuOptions(post: Post): ListOption[] {
    if (clan == null) return [];
    const mine = meId != null && post.author?.id === meId;
    const items: ListOption[] = [];
    if (mine) {
      items.push(
        { key: 'edit', label: t('me.menuEdit'), onSelect: () => requestEdit(post) },
        {
          key: 'delete',
          label: t('me.menuDelete'),
          danger: true,
          onSelect: () => setDeletePostId(post.id),
        }
      );
    } else {
      items.push(
        {
          key: 'hide',
          label: t('me.menuHide'),
          onSelect: () => {
            hidePostLocal(post.id);
            pushToast('success', t('me.hideSuccess'));
          },
        },
        {
          key: 'share',
          label: t('me.menuShare'),
          onSelect: () => pushToast('success', t('me.shareSuccess')),
        },
        { key: 'report', label: t('report.post'), onSelect: () => setReportPostId(post.id) },
        {
          key: 'block',
          label: t('me.menuBlock'),
          danger: true,
          onSelect: () => {
            const authorId = post.author?.id;
            if (authorId == null || authorId === '') return;
            blockAuthorLocal(authorId);
            pushToast('success', t('me.blockSuccess'));
          },
        }
      );
    }
    if (isClanStaff(clan)) {
      items.push({
        key: 'clanPin',
        label: clan.meTopPostId === post.id ? t('clan.unpinPost') : t('clan.pinPost'),
        onSelect: () => void togglePinTop(post),
      });
      if (!mine) {
        items.push(
          {
            key: 'clanDelete',
            label: t('clan.deletePost'),
            danger: true,
            onSelect: () => setStaffConfirm({ type: 'deletePost', post }),
          },
          {
            key: 'clanDeleteByUser',
            label: t('clan.deletePostsByUser'),
            danger: true,
            onSelect: () => setStaffConfirm({ type: 'deleteByUser', post }),
          },
          {
            key: 'clanBan',
            label: t('clan.banUser'),
            danger: true,
            onSelect: () => setStaffConfirm({ type: 'ban', post }),
          }
        );
      }
    }
    return items;
  }

  if (clan == null) {
    return (
      <View className="flex-1 bg-[#f3f3f3]">
        <ScreenHeader title={handle != null ? `#${handle}` : t('clan.title')} onBack={onClose} />
        <View className="flex-1 items-center justify-center px-8">
          {loadError != null ? (
            <Text className="text-center text-sm text-ola-ink-soft">
              {loadError}
            </Text>
          ) : (
            <ActivityIndicator color="#7cb342" size="large" />
          )}
        </View>
      </View>
    );
  }

  const isOwner = clan.myRole === CLAN_ROLE.owner;
  const privacyOptions: PostVisibility[] = canPostPublicInClan(clan)
    ? ['public', 'private']
    : ['private'];

  const header = (
    <View>
      <ClanHeaderCard
        clan={clan}
        isOwner={isOwner}
        imageUploading={imageUploading}
        onChangeImage={(field) => void changeImage(field)}
        onJoin={() => void handleJoin()}
        onLeave={() => setLeaveConfirm(true)}
        onOpenManage={() => onOpenManage(clan.id)}
        onOpenMembers={() => onOpenMembers(clan.id)}
        onOpenProfile={openProfile}
        onCompose={() => setComposerOpen(true)}
      />

      <Text className="px-4 pb-2 pt-1 text-base text-ola-ink">
        {t('clan.postedTitle')}
      </Text>

      {feedLoading && <ActivityIndicator className="py-10" color="#7cb342" size="large" />}
      {!feedLoading && feedError != null && (
        <Text className="px-6 py-10 text-center text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
          {clanFeedErrorText(feedError)}
        </Text>
      )}
      {!feedLoading && feedError == null && allPosts.length === 0 && (
        <Text className="px-6 py-10 text-center text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
          {t('clan.emptyFeed')}
        </Text>
      )}
    </View>
  );

  return (
    <View className="flex-1 bg-[#f3f3f3]">
      <ScreenHeader title={`#${clan.handle}`} onBack={onClose} />
      <FlashList
        data={feedLoading || feedError != null ? [] : allPosts}
        keyExtractor={(item) => item.id}
        ListHeaderComponent={header}
        contentContainerClassName="pb-2"
        refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
        onEndReached={() => void useClanFeedStore.getState().loadMore()}
        onEndReachedThreshold={0.4}
        ListFooterComponent={
          feedLoadingMore ? <ActivityIndicator className="my-3" color="#7cb342" /> : null
        }
        renderItem={({ item, index }) => (
          <View>
            {visiblePinned != null && index === 0 && (
              <View className="bg-[#dcedc8] px-4 py-1">
                <Text className="text-xs font-bold" style={{ color: '#33691e' }}>
                  {t('clan.meTop')}
                </Text>
              </View>
            )}
            <MePostCard
              post={item}
              timeLabel={timeFormatter(item.createdAt)}
              onToggleLike={(postId) => handleReaction(postId, 'like')}
              onToggleDislike={(postId) => handleReaction(postId, 'dislike')}
              onOpenProfile={openProfile}
              onOpenComments={openComments}
              onQuickComment={(postId) => setQuickCommentPostId(postId)}
              onOpenMenu={(postId) => setMenuPostId(postId)}
              onOpenLikers={(postId) => setLikersPostId(postId)}
              onOpenPhotos={(photos, index2) => setViewer({ images: photos, index: index2 })}
            />
          </View>
        )}
      />

      <MeComposerModal
        visible={composerOpen || editingPost != null}
        editPost={editingPost}
        title={t('clan.writeMe')}
        privacyOptions={privacyOptions}
        submitPost={(payload, files, imageUrls) =>
          useClanFeedStore.getState().createPost(clan.id, payload, files, imageUrls)
        }
        onSaved={(post) => {
          if (editingPost != null) useClanFeedStore.getState().syncPost(post);
        }}
        onClose={() => {
          setComposerOpen(false);
          setEditingPost(null);
        }}
      />

      <ListOptionDialog
        visible={menuPost != null}
        title={t('me.postMenu')}
        options={menuPost != null ? buildMenuOptions(menuPost) : []}
        onClose={() => setMenuPostId(null)}
      />

      {reportPostId != null && (
        <ReportDialog
          target={{ type: 'post', id: reportPostId }}
          onClose={() => setReportPostId(null)}
        />
      )}

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
          const postId = deletePostId;
          setDeletePostId(null);
          if (postId != null) void deleteOwnPost(postId);
        }}
        onCancel={() => setDeletePostId(null)}
      />

      <ConfirmDialog
        visible={leaveConfirm}
        danger
        title={t('clan.leave')}
        message={t('clan.leaveConfirm', { name: clan.handle })}
        confirmLabel={t('clan.leave')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => void handleLeave()}
        onCancel={() => setLeaveConfirm(false)}
      />

      <ConfirmDialog
        visible={staffConfirm != null}
        danger
        title={staffConfirm?.type === 'ban' ? t('clan.banUser') : t('clan.deletePost')}
        message={staffConfirmText}
        confirmLabel={t('dialog.accept')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => void runStaffConfirm()}
        onCancel={() => setStaffConfirm(null)}
      />

      {commentPost != null && (
        <MeCommentSheet
          post={commentPost}
          language={i18n.language}
          autoFocusInput={commentFocusInput}
          onClose={() => setCommentPostId(null)}
          onToggleLike={(postId) => handleReaction(postId, 'like')}
          onToggleDislike={(postId) => handleReaction(postId, 'dislike')}
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

      {viewer != null && (
        <MediaViewerModal
          images={viewer.images}
          index={viewer.index}
          onClose={() => setViewer(null)}
        />
      )}
    </View>
  );
}

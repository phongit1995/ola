import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Alert, Image, Pressable, RefreshControl, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { useMeFeedStore } from '@ola/shared/stores/meFeedStore';
import { useMeNotificationStore } from '@ola/shared/stores/meNotificationStore';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { AuthService, SocketService } from '@ola/shared/services';
import { createTimeFormatter, filterVisiblePosts, postTimeLabel } from '@ola/shared/lib';
import type { Post, PostReaction } from '@ola/shared/types';
import { EDIT_WINDOW_MS } from '@ola/shared/constants';
import { useMeLocalStore } from '@store/meLocalStore';
import { useMediaViewerStore } from '@store/mediaViewerStore';
import { useHorizontalSwipe } from '@hooks/useHorizontalSwipe';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { MePostCard } from './components/MePostCard';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { ReportDialog } from '@components/ui/ReportDialog';
import { MeQuickCommentBar } from './components/MeQuickCommentBar';
import { MeComposerModal } from './components/MeComposerModal';
import { MeLeftDrawer } from './components/MeLeftDrawer';
import { MeRightDrawer } from './components/MeRightDrawer';
import { ClanOverlayHost } from '@screens/clan/components/ClanOverlayHost';
import { useClanOverlayStore } from '@store/clanOverlayStore';
import { MeCommentSheet } from './components/MeCommentSheet';
import { MeLikersDialog } from './components/MeLikersDialog';
import { UserProfileScreen } from '@screens/profile/UserProfileScreen';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { MeFeedHeader } from './components/MeFeedHeader';
import { useQuickComment } from './useQuickComment';
import { TAB_FILTER } from './constants';
import type { MeTab } from './types';

const editIcon = require('@assets/icons/me/ic_action_edit.png');


export function MeFeedScreen() {
  const { t, i18n } = useTranslation();
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const pushToast = useToastStore((s) => s.push);

  const posts = useMeFeedStore((s) => s.posts);
  const loading = useMeFeedStore((s) => s.loading);
  const loadingMore = useMeFeedStore((s) => s.loadingMore);
  const refreshing = useMeFeedStore((s) => s.refreshing);
  const error = useMeFeedStore((s) => s.error);
  const loadFeed = useMeFeedStore((s) => s.loadFeed);
  const refreshFeed = useMeFeedStore((s) => s.refreshFeed);
  const loadMore = useMeFeedStore((s) => s.loadMore);
  const toggleReaction = useMeFeedStore((s) => s.toggleReaction);
  const adjustCommentCount = useMeFeedStore((s) => s.adjustCommentCount);
  const removePost = useMeFeedStore((s) => s.removePost);
  const togglePin = useMeFeedStore((s) => s.togglePin);
  const unreadCount = useMeNotificationStore((s) => s.unreadCount);
  const refreshUnread = useMeNotificationStore((s) => s.refreshUnread);
  const meId = useAuthStore((s) => s.user?.id ?? null);
  const hiddenPostIds = useMeLocalStore((s) => s.hiddenPostIds);
  const blockedAuthorIds = useMeLocalStore((s) => s.blockedAuthorIds);
  const hidePost = useMeLocalStore((s) => s.hidePost);
  const blockAuthor = useMeLocalStore((s) => s.blockAuthor);
  const openViewer = useMediaViewerStore((s) => s.openViewer);
  const username = useAuthStore((s) => s.user?.username ?? null);
  const avatarUrl = useAuthStore((s) => s.user?.avatar ?? null);
  const coverUrl = useAuthStore((s) => s.user?.coverPhoto ?? null);
  const displayName = username ?? t('home.guest');

  const [tab, setTab] = useState<MeTab>('community');
  const [composerOpen, setComposerOpen] = useState(false);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [commentPostId, setCommentPostId] = useState<string | null>(null);
  const [commentFocusInput, setCommentFocusInput] = useState(false);
  const [likersPostId, setLikersPostId] = useState<string | null>(null);
  const [profileUsername, setProfileUsername] = useState<string | null>(null);
  const [searchOpen, setSearchOpen] = useState(false);
  const [menuPostId, setMenuPostId] = useState<string | null>(null);
  const [reportPostId, setReportPostId] = useState<string | null>(null);
  const [deletePostId, setDeletePostId] = useState<string | null>(null);
  const [editingPost, setEditingPost] = useState<Post | null>(null);
  const {
    quickCommentPostId,
    setQuickCommentPostId,
    quickSubmitting,
    submitQuickComment,
    quickContextLabel,
  } = useQuickComment(posts, adjustCommentCount);
  const openProfile = (nick: string) => setProfileUsername(nick);
  const commentPost = commentPostId != null ? posts.find((p) => p.id === commentPostId) ?? null : null;
  const menuPost = menuPostId != null ? posts.find((p) => p.id === menuPostId) ?? null : null;

  const visiblePosts = useMemo(
    () => filterVisiblePosts(posts, hiddenPostIds, blockedAuthorIds),
    [posts, hiddenPostIds, blockedAuthorIds]
  );

  useEffect(() => {
    void loadFeed(TAB_FILTER[tab]);
  }, [tab, loadFeed]);

  useEffect(() => {
    void refreshUnread();
  }, [refreshUnread]);

  const timeFormatter = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  function confirmLogout() {
    Alert.alert(t('home.logout'), '', [
      { text: t('common.cancel'), style: 'cancel' },
      {
        text: t('home.logout'),
        style: 'destructive',
        onPress: () => {
          void AuthService.logout().finally(() => {
            SocketService.disconnect();
            useAuthStore.getState().clearUser();
          });
        },
      },
    ]);
  }

  const comingSoon = () => pushToast('info', t('me.comingSoon'));
  const handleReaction = (id: string, type: PostReaction) => void toggleReaction(id, type);
  const swipeHandlers = useHorizontalSwipe({ onSwipeLeft: () => setSearchOpen(true) });

  function openComments(id: string, focusInput?: boolean) {
    setCommentFocusInput(focusInput === true);
    setCommentPostId(id);
  }

  function requestEdit(post: Post) {
    const createdAtMs = post.createdAt != null ? new Date(post.createdAt).getTime() : 0;
    if (Date.now() - createdAtMs > EDIT_WINDOW_MS) {
      pushToast('info', t('me.editExpired'));
      return;
    }
    setEditingPost(post);
  }

  function buildMenuOptions(post: Post): ListOption[] {
    const mine = meId != null && post.author?.id === meId;
    if (mine) {
      return [
        { key: 'edit', label: t('me.menuEdit'), onSelect: () => requestEdit(post) },
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
          pushToast('success', t('me.hideSuccess'));
        },
      },
      { key: 'save', label: t('me.menuSave'), onSelect: () => pushToast('success', t('me.saveSuccess')) },
      { key: 'share', label: t('me.menuShare'), onSelect: () => pushToast('success', t('me.shareSuccess')) },
      { key: 'report', label: t('report.post'), onSelect: () => setReportPostId(post.id) },
      {
        key: 'block',
        label: t('me.menuBlock'),
        danger: true,
        onSelect: () => {
          const authorId = post.author?.id;
          if (authorId == null || authorId === '') return;
          blockAuthor(authorId);
          pushToast('success', t('me.blockSuccess'));
        },
      },
    ];
  }

  return (
    <View className="flex-1 bg-[#f3f3f3]">
      <MeFeedHeader
        tab={tab}
        unreadCount={unreadCount}
        onChangeTab={setTab}
        onOpenDrawer={() => setDrawerOpen(true)}
        onOpenNotif={() => navigation.navigate(ROOT_ROUTES.MeNotifications)}
        onOpenSearch={() => setSearchOpen(true)}
      />

      <View
        className="relative flex-1"
        onTouchStart={swipeHandlers.onTouchStart}
        onTouchMove={swipeHandlers.onTouchMove}
        onTouchEnd={swipeHandlers.onTouchEnd}
        onTouchCancel={swipeHandlers.onTouchCancel}
      >
        {loading && posts.length === 0 ? (
          <View className="flex-1 items-center justify-center">
            <ActivityIndicator color="#7cb342" size="large" />
          </View>
        ) : error && posts.length === 0 ? (
          <View className="flex-1 items-center justify-center px-8">
            <Text className="text-center text-sm" style={{ color: '#e34545' }}>
              {t('common.error')}
            </Text>
          </View>
        ) : visiblePosts.length === 0 ? (
          <View className="flex-1 items-center justify-center px-8">
            <Text className="text-center text-sm text-ola-ink-soft">
              {t('me.empty')}
            </Text>
          </View>
        ) : (
          <FlashList
            data={visiblePosts}
            keyExtractor={(item) => item.id}
            contentContainerClassName="py-2"
            refreshControl={
              <RefreshControl refreshing={refreshing} onRefresh={() => void refreshFeed(TAB_FILTER[tab])} />
            }
            onEndReached={() => void loadMore(TAB_FILTER[tab])}
            onEndReachedThreshold={0.4}
            ListFooterComponent={
              loadingMore ? <ActivityIndicator className="my-3" color="#7cb342" /> : null
            }
            renderItem={({ item }) => (
              <MePostCard
                post={item}
                timeLabel={postTimeLabel(item.createdAt, timeFormatter)}
                onToggleLike={(id) => handleReaction(id, 'like')}
                onToggleDislike={(id) => handleReaction(id, 'dislike')}
                onOpenProfile={openProfile}
                onOpenComments={openComments}
                onQuickComment={(id) => setQuickCommentPostId(id)}
                onOpenMenu={(id) => setMenuPostId(id)}
                onOpenLikers={(id) => setLikersPostId(id)}
                onOpenPhotos={(photos, index) => openViewer(photos, index)}
                onOpenClan={(handle) =>
                  useClanOverlayStore.getState().open({ kind: 'clan', handle })
                }
              />
            )}
          />
        )}

        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('me.composerTitle')}
          onPress={() => setComposerOpen(true)}
          className="absolute h-14 w-14 items-center justify-center rounded-full bg-ola-primary"
          style={{
            right: 16,
            bottom: 16,
            elevation: 4,
            shadowColor: '#000',
            shadowOpacity: 0.3,
            shadowRadius: 4,
            shadowOffset: { width: 0, height: 2 },
          }}
        >
          <Image source={editIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
        </Pressable>

        {drawerOpen && (
          <MeLeftDrawer
            displayName={displayName}
            avatarUrl={avatarUrl ?? undefined}
            coverUrl={coverUrl ?? undefined}
            onClose={() => setDrawerOpen(false)}
            onViewProfile={() => {
              setDrawerOpen(false);
              openProfile(displayName);
            }}
            onSelect={(key) => {
              setDrawerOpen(false);
              if (key === 'personal') openProfile(displayName);
              else if (key === 'marriage') navigation.navigate(ROOT_ROUTES.Marriage);
              else if (key === 'likes') navigation.navigate(ROOT_ROUTES.MeLikedPosts);
              else if (key === 'visitors') navigation.navigate(ROOT_ROUTES.MeVisitors);
              else if (key === 'clan') useClanOverlayStore.getState().open({ kind: 'home' });
              else comingSoon();
            }}
            onLogout={() => {
              setDrawerOpen(false);
              confirmLogout();
            }}
          />
        )}

        {searchOpen && (
          <MeRightDrawer onClose={() => setSearchOpen(false)} onOpenProfile={openProfile} />
        )}
      </View>

      <MeComposerModal
        visible={composerOpen || editingPost != null}
        editPost={editingPost}
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
          const id = deletePostId;
          setDeletePostId(null);
          if (id != null) removePost(id).catch(() => pushToast('error', t('common.error')));
        }}
        onCancel={() => setDeletePostId(null)}
      />

      {commentPost != null && (
        <MeCommentSheet
          post={commentPost}
          language={i18n.language}
          autoFocusInput={commentFocusInput}
          onClose={() => setCommentPostId(null)}
          onToggleLike={(id) => handleReaction(id, 'like')}
          onToggleDislike={(id) => handleReaction(id, 'dislike')}
          onOpenProfile={openProfile}
          onOpenLikers={(id) => setLikersPostId(id)}
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

      <ClanOverlayHost />

      {profileUsername != null && (
        <UserProfileScreen
          key={profileUsername}
          username={profileUsername}
          language={i18n.language}
          onClose={() => setProfileUsername(null)}
          onOpenProfile={openProfile}
          onEditProfile={() => navigation.navigate(ROOT_ROUTES.EditProfile)}
        />
      )}
    </View>
  );
}

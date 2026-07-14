import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Alert, Image, Pressable, RefreshControl, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { FlashList } from '@shopify/flash-list';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { useMeFeedStore } from '@ola/shared/stores/meFeedStore';
import { useMeNotificationStore } from '@ola/shared/stores/meNotificationStore';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { AuthService, MeService, SocketService } from '@ola/shared/services';
import { createTimeFormatter, formatDateDMY, isSameDay, toApiError } from '@ola/shared/lib';
import type { MeFeedFilter, Post, PostReaction } from '@ola/shared/types';
import { useMeLocalStore } from '../../store/meLocalStore';
import { useMediaViewerStore } from '../../store/mediaViewerStore';
import { useHorizontalSwipe } from '../../hooks/useHorizontalSwipe';
import { ConfirmDialog } from '../../components/ConfirmDialog';
import { MePostCard } from './MePostCard';
import { ListOptionDialog, type ListOption } from '../../components/ListOptionDialog';
import { ReportDialog } from '../../components/ReportDialog';
import { MeQuickCommentBar } from './MeQuickCommentBar';
import { MeComposerModal } from './MeComposerModal';
import { MeLeftDrawer } from './MeLeftDrawer';
import { MeRightDrawer } from './MeRightDrawer';
import { MeVisitorsScreen } from './MeVisitorsScreen';
import { MeLikedPostsScreen } from './MeLikedPostsScreen';
import { MarriageScreen } from './marriage/MarriageScreen';
import { MeCommentSheet } from './MeCommentSheet';
import { MeLikersDialog } from './MeLikersDialog';
import { MeNotificationsScreen } from './MeNotificationsScreen';
import { UserProfileScreen } from '../profile/UserProfileScreen';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';

type MeTab = 'community' | 'personal';

const TAB_FILTER: Record<MeTab, MeFeedFilter | undefined> = {
  community: undefined,
  personal: 'following',
};

const menuIcon = require('../../assets/icons/me/ic_more_white.png');
const bellIcon = require('../../assets/icons/me/ic_action_notification.png');
const searchIcon = require('../../assets/icons/me/ic_action_search.png');
const editIcon = require('../../assets/icons/me/ic_action_edit.png');
const tabOla = require('../../assets/icons/me/ic_action_tab_ola.png');
const tabOlaActive = require('../../assets/icons/me/ic_action_tab_ola_selected.png');
const tabFollower = require('../../assets/icons/me/ic_action_tab_follower.png');
const tabFollowerActive = require('../../assets/icons/me/ic_action_tab_follower_selected.png');

const ME_TABS = [
  { key: 'community' as const, labelKey: 'me.tabCommunity' as const, icon: tabOla, iconActive: tabOlaActive },
  { key: 'personal' as const, labelKey: 'me.tabPersonal' as const, icon: tabFollower, iconActive: tabFollowerActive },
];

const EDIT_WINDOW_MS = 60 * 60 * 1000;

export function MeFeedScreen() {
  const { t, i18n } = useTranslation();
  const insets = useSafeAreaInsets();
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
  const [notifOpen, setNotifOpen] = useState(false);
  const [profileUsername, setProfileUsername] = useState<string | null>(null);
  const [searchOpen, setSearchOpen] = useState(false);
  const [visitorsOpen, setVisitorsOpen] = useState(false);
  const [likedOpen, setLikedOpen] = useState(false);
  const [marriageOpen, setMarriageOpen] = useState(false);
  const [menuPostId, setMenuPostId] = useState<string | null>(null);
  const [reportPostId, setReportPostId] = useState<string | null>(null);
  const [quickCommentPostId, setQuickCommentPostId] = useState<string | null>(null);
  const [quickSubmitting, setQuickSubmitting] = useState(false);
  const [deletePostId, setDeletePostId] = useState<string | null>(null);
  const [editingPost, setEditingPost] = useState<Post | null>(null);
  const openProfile = (nick: string) => setProfileUsername(nick);
  const commentPost = commentPostId != null ? posts.find((p) => p.id === commentPostId) ?? null : null;
  const menuPost = menuPostId != null ? posts.find((p) => p.id === menuPostId) ?? null : null;
  const quickPost =
    quickCommentPostId != null ? posts.find((p) => p.id === quickCommentPostId) ?? null : null;

  const visiblePosts = useMemo(() => {
    const hidden = new Set(hiddenPostIds);
    const blocked = new Set(blockedAuthorIds);
    if (hidden.size === 0 && blocked.size === 0) return posts;
    return posts.filter(
      (item) =>
        !hidden.has(item.id) && !(item.author?.id != null && blocked.has(item.author.id))
    );
  }, [posts, hiddenPostIds, blockedAuthorIds]);

  useEffect(() => {
    void loadFeed(TAB_FILTER[tab]);
  }, [tab, loadFeed]);

  useEffect(() => {
    void refreshUnread();
  }, [refreshUnread]);

  const timeFormatter = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  function timeLabelOf(post: Post): string {
    const now = new Date().toISOString();
    return isSameDay(post.createdAt, now)
      ? timeFormatter(post.createdAt)
      : formatDateDMY(post.createdAt);
  }

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

  async function submitQuickComment(text: string): Promise<boolean> {
    const id = quickCommentPostId;
    const content = text.trim();
    if (id == null || content === '') return false;
    setQuickSubmitting(true);
    try {
      await MeService.addComment(id, { content });
      adjustCommentCount(id, 1);
      pushToast('success', t('me.commentSent'));
      setQuickCommentPostId(null);
      return true;
    } catch (err) {
      pushToast(
        'error',
        toApiError(err).status === 403 ? t('me.commentErrFriendsOnly') : t('me.commentSendError')
      );
      return false;
    } finally {
      setQuickSubmitting(false);
    }
  }

  return (
    <View className="flex-1 bg-[#f3f3f3]">
      <View
        className="flex-row items-center bg-ola-primary px-2"
        style={{ paddingTop: insets.top, borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.12)' }}
      >
        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('me.openMenu')}
          onPress={() => setDrawerOpen(true)}
          className="h-12 w-10 items-center justify-center"
        >
          <Image source={menuIcon} style={{ width: 20, height: 20 }} resizeMode="contain" />
        </Pressable>
        <View className="flex-1 flex-row items-center justify-center gap-8">
          {ME_TABS.map((item) => {
            const active = item.key === tab;
            return (
              <Pressable
                key={item.key}
                accessibilityRole="button"
                accessibilityLabel={t(item.labelKey)}
                accessibilityState={{ selected: active }}
                onPress={() => setTab(item.key)}
                className="h-12 w-12 items-center justify-center"
                style={{ opacity: active ? 1 : 0.6 }}
              >
                <Image
                  source={active ? item.iconActive : item.icon}
                  style={{ width: 24, height: 24 }}
                  resizeMode="contain"
                />
              </Pressable>
            );
          })}
        </View>
        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('me.notifTitle')}
          onPress={() => setNotifOpen(true)}
          className="h-12 w-10 items-center justify-center"
        >
          <View>
            <Image source={bellIcon} style={{ width: 24, height: 24, tintColor: '#ffffff' }} resizeMode="contain" />
            {unreadCount > 0 && (
              <View
                className="absolute h-4 min-w-4 items-center justify-center rounded-full bg-ola-accent px-1"
                style={{ top: -4, right: 0, borderWidth: 2, borderColor: '#ffffff' }}
              >
                <Text className="text-[10px] font-bold text-white">
                  {unreadCount > 99 ? '99+' : unreadCount}
                </Text>
              </View>
            )}
          </View>
        </Pressable>
        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('me.openSearch')}
          onPress={() => setSearchOpen(true)}
          className="h-12 w-10 items-center justify-center"
        >
          <Image source={searchIcon} style={{ width: 24, height: 24, tintColor: '#ffffff' }} resizeMode="contain" />
        </Pressable>
      </View>

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
            <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
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
                timeLabel={timeLabelOf(item)}
                onToggleLike={(id) => handleReaction(id, 'like')}
                onToggleDislike={(id) => handleReaction(id, 'dislike')}
                onOpenProfile={openProfile}
                onOpenComments={openComments}
                onQuickComment={(id) => setQuickCommentPostId(id)}
                onOpenMenu={(id) => setMenuPostId(id)}
                onOpenLikers={(id) => setLikersPostId(id)}
                onOpenPhotos={(photos, index) => openViewer(photos, index)}
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
              else if (key === 'marriage') setMarriageOpen(true);
              else if (key === 'likes') setLikedOpen(true);
              else if (key === 'visitors') setVisitorsOpen(true);
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

      {notifOpen && (
        <MeNotificationsScreen
          language={i18n.language}
          onClose={() => setNotifOpen(false)}
          onOpenProfile={openProfile}
        />
      )}

      {visitorsOpen && (
        <MeVisitorsScreen
          language={i18n.language}
          onClose={() => setVisitorsOpen(false)}
          onOpenProfile={openProfile}
        />
      )}

      {likedOpen && (
        <MeLikedPostsScreen
          language={i18n.language}
          onClose={() => setLikedOpen(false)}
          onOpenProfile={openProfile}
        />
      )}

      {marriageOpen && <MarriageScreen onClose={() => setMarriageOpen(false)} />}

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

import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Alert, Image, Pressable, RefreshControl, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { FlashList } from '@shopify/flash-list';
import { useMeFeedStore } from '@ola/shared/stores/meFeedStore';
import { useMeNotificationStore } from '@ola/shared/stores/meNotificationStore';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { AuthService, SocketService } from '@ola/shared/services';
import { createTimeFormatter, formatDateDMY, isSameDay } from '@ola/shared/lib';
import type { MeFeedFilter, Post, PostReaction } from '@ola/shared/types';
import { MePostCard } from './MePostCard';
import { MeComposerModal } from './MeComposerModal';
import { MeLeftDrawer } from './MeLeftDrawer';
import { MeCommentSheet } from './MeCommentSheet';
import { MeLikersDialog } from './MeLikersDialog';
import { MeNotificationsScreen } from './MeNotificationsScreen';

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
  { key: 'community' as const, icon: tabOla, iconActive: tabOlaActive },
  { key: 'personal' as const, icon: tabFollower, iconActive: tabFollowerActive },
];

export function MeFeedScreen() {
  const { t, i18n } = useTranslation();
  const insets = useSafeAreaInsets();
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
  const unreadCount = useMeNotificationStore((s) => s.unreadCount);
  const refreshUnread = useMeNotificationStore((s) => s.refreshUnread);
  const username = useAuthStore((s) => s.user?.username ?? null);
  const avatarUrl = useAuthStore((s) => s.user?.avatar ?? null);
  const coverUrl = useAuthStore((s) => s.user?.coverPhoto ?? null);
  const displayName = username ?? t('home.guest');

  const [tab, setTab] = useState<MeTab>('community');
  const [composerOpen, setComposerOpen] = useState(false);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [commentPostId, setCommentPostId] = useState<string | null>(null);
  const [likersPostId, setLikersPostId] = useState<string | null>(null);
  const [notifOpen, setNotifOpen] = useState(false);
  const commentPost = commentPostId != null ? posts.find((p) => p.id === commentPostId) ?? null : null;

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

  return (
    <View className="flex-1 bg-[#f3f3f3]">
      <View className="flex-row items-center bg-ola-primary px-1" style={{ paddingTop: insets.top }}>
        <Pressable onPress={() => setDrawerOpen(true)} className="h-12 w-10 items-center justify-center">
          <Image source={menuIcon} style={{ width: 20, height: 20 }} resizeMode="contain" />
        </Pressable>
        <View className="flex-1 flex-row items-center justify-center gap-8">
          {ME_TABS.map((item) => {
            const active = item.key === tab;
            return (
              <Pressable
                key={item.key}
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
        <Pressable onPress={() => setNotifOpen(true)} className="h-12 w-10 items-center justify-center">
          <View>
            <Image source={bellIcon} style={{ width: 24, height: 24, tintColor: '#ffffff' }} resizeMode="contain" />
            {unreadCount > 0 && (
              <View
                className="absolute h-4 min-w-4 items-center justify-center rounded-full bg-ola-accent px-1"
                style={{ top: -4, right: -2, borderWidth: 2, borderColor: '#ffffff' }}
              >
                <Text className="text-[10px] font-bold text-white">
                  {unreadCount > 99 ? '99+' : unreadCount}
                </Text>
              </View>
            )}
          </View>
        </Pressable>
        <Pressable onPress={comingSoon} className="h-12 w-10 items-center justify-center">
          <Image source={searchIcon} style={{ width: 24, height: 24, tintColor: '#ffffff' }} resizeMode="contain" />
        </Pressable>
      </View>

      {loading && posts.length === 0 ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : error && posts.length === 0 ? (
        <View className="flex-1 items-center justify-center px-8">
          <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('common.error')}
          </Text>
        </View>
      ) : posts.length === 0 ? (
        <View className="flex-1 items-center justify-center px-8">
          <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('me.empty')}
          </Text>
        </View>
      ) : (
        <FlashList
          data={posts}
          keyExtractor={(item) => item.id}
          contentContainerClassName="py-2"
          refreshControl={
            <RefreshControl refreshing={refreshing} onRefresh={() => void refreshFeed(TAB_FILTER[tab])} />
          }
          onEndReached={() => void loadMore(TAB_FILTER[tab])}
          onEndReachedThreshold={0.4}
          ListFooterComponent={
            loadingMore ? <ActivityIndicator className="my-4" color="#7cb342" /> : null
          }
          renderItem={({ item }) => (
            <MePostCard
              post={item}
              timeLabel={timeLabelOf(item)}
              onToggleLike={(id) => handleReaction(id, 'like')}
              onToggleDislike={(id) => handleReaction(id, 'dislike')}
              onOpenProfile={comingSoon}
              onOpenComments={(id) => setCommentPostId(id)}
              onOpenMenu={comingSoon}
              onOpenLikers={(id) => setLikersPostId(id)}
            />
          )}
        />
      )}

      <Pressable
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

      <MeComposerModal visible={composerOpen} onClose={() => setComposerOpen(false)} />

      {commentPost != null && (
        <MeCommentSheet
          post={commentPost}
          language={i18n.language}
          onClose={() => setCommentPostId(null)}
          onToggleLike={(id) => handleReaction(id, 'like')}
          onToggleDislike={(id) => handleReaction(id, 'dislike')}
          onOpenProfile={comingSoon}
          onOpenLikers={(id) => setLikersPostId(id)}
          onCommentDelta={adjustCommentCount}
        />
      )}

      {likersPostId != null && (
        <MeLikersDialog
          postId={likersPostId}
          onClose={() => setLikersPostId(null)}
          onOpenProfile={comingSoon}
        />
      )}

      {notifOpen && (
        <MeNotificationsScreen language={i18n.language} onClose={() => setNotifOpen(false)} />
      )}

      {drawerOpen && (
        <MeLeftDrawer
          displayName={displayName}
          avatarUrl={avatarUrl ?? undefined}
          coverUrl={coverUrl ?? undefined}
          onClose={() => setDrawerOpen(false)}
          onViewProfile={() => {
            setDrawerOpen(false);
            comingSoon();
          }}
          onSelect={() => {
            setDrawerOpen(false);
            comingSoon();
          }}
          onLogout={() => {
            setDrawerOpen(false);
            confirmLogout();
          }}
        />
      )}
    </View>
  );
}

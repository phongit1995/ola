import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, Text, View } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { FlashList } from '@shopify/flash-list';
import { useMeNotificationStore } from '@ola/shared/stores/meNotificationStore';
import { clearPushNotification, ME_NOTIF_ID } from '@lib/push';
import { useMeFeedStore } from '@ola/shared/stores/feed/meFeedStore';
import { applyPostReaction, reconcileTopLikers } from '@ola/shared/stores/feed/postHelpers';
import { selfLiker } from '@ola/shared/stores/feed/selfLiker';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { MeService } from '@ola/shared/services';
import { ME_NOTIFICATION_LABEL_KEY } from '@ola/shared/constants';
import {
  createTimeFormatter,
  isMomentMediaPurged,
  isMomentNotification,
  momentNotificationOthers,
  momentNotificationReaction,
  momentOpenErrorKey,
} from '@ola/shared/lib';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import type { MeNotification, MeNotificationType, Post } from '@ola/shared/types';
import { REACTION_IMAGE } from '@lib/reactions';
import { SmileyText } from '@lib/richText';
import { useMomentOverlays } from '@screens/moment/useMomentOverlays';
import { useThemeColors } from '@hooks/useThemeColors';
import { Avatar } from '@components/ui/Avatar';
import { InsetListSeparator } from '@components/ui/InsetListSeparator';
import { MeCommentSheet } from './components/MeCommentSheet';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';

const likeIcon = require('@assets/icons/notify/ic_notification_like.png');
const commentIcon = require('@assets/icons/notify/ic_notification_comment.png');
const mentionIcon = require('@assets/icons/notify/ic_notification_mention.png');

const TYPE_ICON: Record<MeNotificationType, number> = {
  like: likeIcon,
  comment: commentIcon,
  reply: commentIcon,
  mention: mentionIcon,
  comment_like: likeIcon,
  moment_comment: commentIcon,
  moment_reaction: likeIcon,
};

const PREVIEW_FONT_SIZE = 14;

export function MeNotificationsScreen() {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const language = i18n.language;
  const push = useToastStore((s) => s.push);
  const items = useMeNotificationStore((s) => s.items);
  const loading = useMeNotificationStore((s) => s.loading);
  const loadingMore = useMeNotificationStore((s) => s.loadingMore);
  const load = useMeNotificationStore((s) => s.load);
  const loadMore = useMeNotificationStore((s) => s.loadMore);
  const markAllRead = useMeNotificationStore((s) => s.markAllRead);
  const fetchMoment = useMomentStore((s) => s.fetchMoment);
  const momentOverlays = useMomentOverlays();

  const [openPost, setOpenPost] = useState<Post | null>(null);
  const [openingId, setOpeningId] = useState<string | null>(null);

  const formatTime = useMemo(() => createTimeFormatter(language), [language]);

  useEffect(() => {
    void load().then(() => markAllRead());
    void clearPushNotification(ME_NOTIF_ID);
  }, [load, markAllRead]);

  async function openMoment(item: MeNotification) {
    setOpeningId(item.id);
    try {
      const moment = await fetchMoment(item.postId);
      if (isMomentMediaPurged(moment)) {
        push('error', t('moment.mediaPurged'));
        return;
      }
      momentOverlays.openDetail(moment);
    } catch (error) {
      push('error', t(momentOpenErrorKey(error)));
    } finally {
      setOpeningId(null);
    }
  }

  async function openNotification(item: MeNotification) {
    if (openingId != null) return;
    if (isMomentNotification(item)) {
      await openMoment(item);
      return;
    }
    setOpeningId(item.id);
    try {
      const post = await MeService.getById(item.postId);
      setOpenPost(post);
    } catch {
      push('error', t('me.commentLoadError'));
    } finally {
      setOpeningId(null);
    }
  }

  async function toggleReaction(id: string, type: 'like' | 'dislike') {
    if (openPost == null) return;
    const active = openPost.myReaction === type;
    const optimistic = applyPostReaction(openPost, active ? null : type, selfLiker());
    setOpenPost(optimistic);
    try {
      const updated = active ? await MeService.removeReaction(id) : await MeService.react(id, type);
      setOpenPost(reconcileTopLikers(updated, optimistic));
      useMeFeedStore.getState().syncPost(updated);
    } catch {
      setOpenPost(openPost);
    }
  }

  function adjustCommentCount(postId: string, delta: number) {
    setOpenPost((prev) =>
      prev == null ? prev : { ...prev, commentCount: Math.max(0, prev.commentCount + delta) }
    );
    useMeFeedStore.getState().adjustCommentCount(postId, delta);
  }

  function openProfile(nick: string) {
    setOpenPost(null);
    navigation.navigate(ROOT_ROUTES.ProfileView, { userId: nick });
  }

  return (
    <View className="flex-1 bg-[#f3f3f3]">
      <ScreenHeader title={t('me.notifTitle')} onBack={() => navigation.goBack()} />

        {loading && items.length === 0 ? (
          <ActivityIndicator className="py-10" color={colors.primary} />
        ) : items.length === 0 ? (
          <Text className="py-16 text-center text-sm text-ola-ink-soft">
            {t('me.notifEmpty')}
          </Text>
        ) : (
          <FlashList
            data={items}
            keyExtractor={(item) => item.id}
            onEndReached={() => void loadMore()}
            onEndReachedThreshold={0.4}
            ItemSeparatorComponent={InsetListSeparator}
            ListFooterComponent={loadingMore ? <ActivityIndicator className="my-4" color={colors.primary} /> : null}
            renderItem={({ item }) => {
              const name = item.actor?.fullName || item.actor?.username || '';
              const reaction = momentNotificationReaction(item);
              const others = momentNotificationOthers(item);
              return (
                <Pressable
                  onPress={() => openNotification(item)}
                  className="flex-row items-start gap-3 bg-white/80 p-4 active:bg-black/5"
                >
                  <Avatar name={name} uri={item.actor?.avatar ?? undefined} size={40} />
                  <View className="min-w-0 flex-1">
                    <Text className="text-sm leading-snug text-ola-ink">
                      <Text className="font-bold">{name}</Text>{' '}
                      {others > 0 && <Text className="font-bold">{t('me.notifOthers', { count: others })} </Text>}
                      {t(ME_NOTIFICATION_LABEL_KEY[item.type])}
                    </Text>
                    {item.type === 'moment_comment' && item.preview != null && item.preview !== '' && (
                      <Text numberOfLines={1} className="mt-0.5 text-sm text-ola-ink-soft">
                        <SmileyText text={item.preview} fontSize={PREVIEW_FONT_SIZE} />
                      </Text>
                    )}
                    {(item.type === 'comment' || item.type === 'comment_like') && item.preview != null && item.preview !== '' && (
                      <Text numberOfLines={1} className="mt-0.5 text-sm text-ola-ink-soft">
                        {item.preview}
                      </Text>
                    )}
                    <View className="mt-1 flex-row items-center gap-1">
                      <Image
                        source={(reaction != null ? REACTION_IMAGE[reaction] : null) ?? TYPE_ICON[item.type]}
                        style={reaction != null ? { width: 20, height: 20 } : { width: 16, height: 16 }}
                        resizeMode="contain"
                      />
                      <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
                        {formatTime(item.createdAt)}
                      </Text>
                    </View>
                  </View>
                  {openingId === item.id && <ActivityIndicator color={colors.primary} />}
                </Pressable>
              );
            }}
          />
        )}

        {openPost != null && (
          <MeCommentSheet
            post={openPost}
            language={language}
            onClose={() => setOpenPost(null)}
            onToggleLike={(id) => toggleReaction(id, 'like')}
            onToggleDislike={(id) => toggleReaction(id, 'dislike')}
            onOpenProfile={openProfile}
            onCommentDelta={adjustCommentCount}
          />
        )}
        {momentOverlays.overlays}
    </View>
  );
}

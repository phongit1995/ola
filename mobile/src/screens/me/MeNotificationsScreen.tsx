import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Modal, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { FlashList } from '@shopify/flash-list';
import { useMeNotificationStore } from '@ola/shared/stores/meNotificationStore';
import { useMeFeedStore } from '@ola/shared/stores/meFeedStore';
import { applyPostReaction } from '@ola/shared/stores/postHelpers';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { MeService } from '@ola/shared/services';
import { createTimeFormatter } from '@ola/shared/lib';
import type { MeNotification, MeNotificationType, Post } from '@ola/shared/types';
import { Avatar } from '../../components/Avatar';
import { MeCommentSheet } from './MeCommentSheet';

const likeIcon = require('../../assets/icons/notify/ic_notification_like.png');
const commentIcon = require('../../assets/icons/notify/ic_notification_comment.png');
const mentionIcon = require('../../assets/icons/notify/ic_notification_mention.png');

const TYPE_ICON: Record<MeNotificationType, number> = {
  like: likeIcon,
  comment: commentIcon,
  mention: mentionIcon,
};

interface MeNotificationsScreenProps {
  language: string;
  onClose: () => void;
}

export function MeNotificationsScreen({ language, onClose }: MeNotificationsScreenProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const push = useToastStore((s) => s.push);
  const items = useMeNotificationStore((s) => s.items);
  const loading = useMeNotificationStore((s) => s.loading);
  const loadingMore = useMeNotificationStore((s) => s.loadingMore);
  const load = useMeNotificationStore((s) => s.load);
  const loadMore = useMeNotificationStore((s) => s.loadMore);
  const markAllRead = useMeNotificationStore((s) => s.markAllRead);
  const toggleFeedReaction = useMeFeedStore((s) => s.toggleReaction);

  const [openPost, setOpenPost] = useState<Post | null>(null);
  const [openingId, setOpeningId] = useState<string | null>(null);

  const formatTime = useMemo(() => createTimeFormatter(language), [language]);

  useEffect(() => {
    void load().then(() => markAllRead());
  }, [load, markAllRead]);

  function labelFor(type: MeNotificationType): string {
    if (type === 'comment') return t('me.notifComment');
    if (type === 'mention') return t('me.notifMention');
    return t('me.notifLike');
  }

  async function openNotification(item: MeNotification) {
    if (openingId != null) return;
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
    const optimistic = applyPostReaction(openPost, active ? null : type);
    setOpenPost(optimistic);
    void toggleFeedReaction(id, type);
    try {
      const updated = active ? await MeService.removeReaction(id) : await MeService.react(id, type);
      setOpenPost(updated);
    } catch {
      setOpenPost(openPost);
    }
  }

  function adjustCommentCount(_postId: string, delta: number) {
    setOpenPost((prev) =>
      prev == null ? prev : { ...prev, commentCount: Math.max(0, prev.commentCount + delta) }
    );
  }

  return (
    <Modal visible transparent animationType="slide" onRequestClose={onClose}>
      <View className="flex-1 bg-[#f3f3f3]">
        <View className="flex-row items-center bg-ola-primary px-1" style={{ paddingTop: insets.top }}>
          <Pressable onPress={onClose} className="h-12 w-10 items-center justify-center">
            <Text className="text-2xl leading-none text-white">×</Text>
          </Pressable>
          <Text className="flex-1 text-sm font-bold text-white">{t('me.notifTitle')}</Text>
          <View className="w-10" />
        </View>

        {loading && items.length === 0 ? (
          <ActivityIndicator className="py-10" color="#7cb342" />
        ) : items.length === 0 ? (
          <Text className="py-16 text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('me.notifEmpty')}
          </Text>
        ) : (
          <FlashList
            data={items}
            keyExtractor={(item) => item.id}
            onEndReached={() => void loadMore()}
            onEndReachedThreshold={0.4}
            ListFooterComponent={loadingMore ? <ActivityIndicator className="my-4" color="#7cb342" /> : null}
            renderItem={({ item }) => {
              const name = item.actor?.fullName || item.actor?.username || '';
              return (
                <Pressable
                  onPress={() => openNotification(item)}
                  className="flex-row items-start gap-3 bg-white/80 p-4 active:bg-black/5"
                  style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.12)' }}
                >
                  <Avatar name={name} uri={item.actor?.avatar ?? undefined} size={48} />
                  <View className="min-w-0 flex-1">
                    <Text className="text-sm leading-snug" style={{ color: 'rgba(0,0,0,0.87)' }}>
                      <Text className="font-bold">{name}</Text> {labelFor(item.type)}
                    </Text>
                    {item.type === 'comment' && item.preview != null && item.preview !== '' && (
                      <Text numberOfLines={1} className="mt-0.5 text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
                        {item.preview}
                      </Text>
                    )}
                    <View className="mt-1 flex-row items-center gap-1">
                      <Image source={TYPE_ICON[item.type]} style={{ width: 16, height: 16 }} resizeMode="contain" />
                      <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
                        {formatTime(item.createdAt)}
                      </Text>
                    </View>
                  </View>
                  {openingId === item.id && <ActivityIndicator color="#7cb342" />}
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
            onOpenProfile={() => push('info', t('me.comingSoon'))}
            onCommentDelta={adjustCommentCount}
          />
        )}
      </View>
    </Modal>
  );
}

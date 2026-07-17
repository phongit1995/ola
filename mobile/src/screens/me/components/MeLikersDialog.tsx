import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, FlatList, Pressable, Text, View } from 'react-native';
import { colorForName } from '@ola/shared/lib';
import { MeService, RelationshipService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { PostAuthor } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { Dialog } from '@components/ui/Dialog';

const PAGE_SIZE = 30;

interface MeLikersDialogProps {
  postId: string;
  commentId?: string;
  onClose: () => void;
  onOpenProfile?: (nick: string, color: string) => void;
}

export function MeLikersDialog({ postId, commentId, onClose, onOpenProfile }: MeLikersDialogProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [likers, setLikers] = useState<PostAuthor[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [reachedEnd, setReachedEnd] = useState(false);
  const [error, setError] = useState(false);
  const [requested, setRequested] = useState<Record<string, boolean>>({});

  const fetchPage = useCallback(
    (offset: number) =>
      commentId != null
        ? MeService.commentLikers(postId, commentId, { limit: PAGE_SIZE, offset })
        : MeService.likers(postId, { limit: PAGE_SIZE, offset }),
    [postId, commentId]
  );

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const result = await fetchPage(0);
        if (!active) return;
        setLikers(result.items);
        setTotal(result.total);
        if (result.items.length < PAGE_SIZE) setReachedEnd(true);
      } catch {
        if (active) setError(true);
      } finally {
        if (active) setLoading(false);
      }
    })();
    return () => {
      active = false;
    };
  }, [fetchPage]);

  const hasMore = !reachedEnd && likers.length < total;

  const loadMore = useCallback(async () => {
    if (loading || loadingMore || !hasMore) return;
    setLoadingMore(true);
    try {
      const result = await fetchPage(likers.length);
      setLikers((current) => [...current, ...result.items]);
      setTotal(result.total);
      if (result.items.length < PAGE_SIZE) setReachedEnd(true);
    } catch {
      return;
    } finally {
      setLoadingMore(false);
    }
  }, [fetchPage, likers.length, loading, loadingMore, hasMore]);

  function openProfile(name: string) {
    onOpenProfile?.(name, colorForName(name));
    onClose();
  }

  async function addFriend(user: PostAuthor) {
    try {
      await RelationshipService.sendRequest(user.id);
      setRequested((current) => ({ ...current, [user.id]: true }));
      push('success', t('me.friendRequestSent'));
    } catch {
      push('error', t('me.makeFriendError'));
    }
  }

  return (
    <Dialog
      visible
      title={total > 0 ? t('me.likersCount', { count: total }) : t('me.likersTitle')}
      onClose={onClose}
      showClose
    >
      {loading ? (
            <ActivityIndicator className="py-6" color="#7cb342" />
          ) : error ? (
            <Text className="py-6 text-center text-sm" style={{ color: '#e53935' }}>
              {t('me.likersError')}
            </Text>
          ) : likers.length === 0 ? (
            <Text className="py-6 text-center text-sm text-ola-ink-soft">
              {t('me.likersEmpty')}
            </Text>
          ) : (
            <FlatList
              data={likers}
              keyExtractor={(item) => item.id}
              style={{ maxHeight: 320 }}
              onEndReached={() => void loadMore()}
              onEndReachedThreshold={0.3}
              ListFooterComponent={loadingMore ? <ActivityIndicator className="py-3" color="#7cb342" /> : null}
              renderItem={({ item, index }) => {
                const isSelf = item.isSelf === true || item.relationship?.status === 'self';
                const isFriend = item.isFriend === true || item.relationship?.status === 'friend';
                const sent =
                  requested[item.id] === true || item.relationship?.status === 'pending_outgoing';
                const title = item.fullName != null && item.fullName !== '' ? item.fullName : item.username;
                return (
                  <View
                    className="flex-row items-center gap-3 px-2 py-3"
                    style={{
                      borderBottomWidth: index === likers.length - 1 ? 0 : 1,
                      borderBottomColor: 'rgba(0,0,0,0.12)',
                    }}
                  >
                    <Pressable
                      onPress={() => openProfile(item.username)}
                      className="min-w-0 flex-1 flex-row items-center gap-3"
                    >
                      <Avatar name={item.username} uri={item.avatar ?? undefined} size={44} rounded={false} />
                      <View className="min-w-0 flex-1">
                        <Text numberOfLines={1} className="text-base font-medium text-ola-ink">
                          {title}
                        </Text>
                        {item.fullName != null && item.fullName !== '' && (
                          <Text numberOfLines={1} className="text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
                            @{item.username}
                          </Text>
                        )}
                      </View>
                    </Pressable>
                    {!isSelf &&
                      (isFriend ? (
                        <View className="rounded px-3 py-1.5" style={{ backgroundColor: 'rgba(0,0,0,0.08)' }}>
                          <Text className="text-sm font-medium" style={{ color: 'rgba(0,0,0,0.45)' }}>{t('me.alreadyFriend')}</Text>
                        </View>
                      ) : sent ? (
                        <View className="rounded px-3 py-1.5" style={{ backgroundColor: 'rgba(0,0,0,0.08)' }}>
                          <Text className="text-sm font-medium" style={{ color: 'rgba(0,0,0,0.45)' }}>{t('me.friendRequestSent')}</Text>
                        </View>
                      ) : (
                        <Pressable onPress={() => void addFriend(item)} className="rounded bg-ola-primary px-3 py-1.5">
                          <Text className="text-sm font-medium text-white">{t('me.makeFriend')}</Text>
                        </Pressable>
                      ))}
                  </View>
                );
              }}
            />
      )}
    </Dialog>
  );
}

import { useCallback, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, FlatList, Pressable, Text, View } from 'react-native';
import { colorForName } from '@ola/shared/lib';
import { MeService, RelationshipService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { PostAuthor } from '@ola/shared/types';
import { useThemeColors } from '@hooks/useThemeColors';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { Dialog } from '@components/ui/Dialog';
import { LIKERS_PAGE_SIZE } from '../constants';
import { RELATIONSHIP_STATUS } from '@ola/shared/constants';
import { useOffsetPage } from '@ola/shared/stores/useOffsetPage';

interface MeLikersDialogProps {
  postId: string;
  commentId?: string;
  onClose: () => void;
  onOpenProfile?: (nick: string, color: string) => void;
}

export function MeLikersDialog({ postId, commentId, onClose, onOpenProfile }: MeLikersDialogProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const push = useToastStore((s) => s.push);
  const [requested, setRequested] = useState<Record<string, boolean>>({});

  const fetchPage = useCallback(
    (offset: number) =>
      commentId != null
        ? MeService.commentLikers(postId, commentId, { limit: LIKERS_PAGE_SIZE, offset })
        : MeService.likers(postId, { limit: LIKERS_PAGE_SIZE, offset }),
    [postId, commentId]
  );

  const {
    items: likers,
    total,
    loading,
    loadingMore,
    error: loadError,
    loadMore,
  } = useOffsetPage(fetchPage, { pageSize: LIKERS_PAGE_SIZE });
  const error = loadError != null;

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
            <ActivityIndicator className="py-6" color={colors.primary} />
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
              ListFooterComponent={loadingMore ? <ActivityIndicator className="py-3" color={colors.primary} /> : undefined}
              renderItem={({ item, index }) => {
                const isSelf = item.isSelf === true || item.relationship?.status === RELATIONSHIP_STATUS.self;
                const isFriend = item.isFriend === true || item.relationship?.status === RELATIONSHIP_STATUS.friend;
                const sent =
                  requested[item.id] === true || item.relationship?.status === RELATIONSHIP_STATUS.pendingOutgoing;
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
                      <AvatarWithFrame
                        name={item.username}
                        uri={item.avatar ?? undefined}
                        size={44}
                        frameId={item.avatarFrameId}
                      />
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

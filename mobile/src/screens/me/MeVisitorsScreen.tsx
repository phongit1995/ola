import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, FlatList, Modal, Pressable, Text, View } from 'react-native';
import { RelationshipService, UserService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { activeVipTypeId, colorForName, createTimeFormatter } from '@ola/shared/lib';
import type { VisitorUser } from '@ola/shared/types';
import { Avatar } from '@components/Avatar';
import { VipBadge } from '@components/VipBadge';
import { ScreenHeader } from '@components/ScreenHeader';

const PAGE_SIZE = 40;

interface MeVisitorsScreenProps {
  language: string;
  onClose: () => void;
  onOpenProfile: (nick: string, color: string) => void;
}

export function MeVisitorsScreen({ language, onClose, onOpenProfile }: MeVisitorsScreenProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [rows, setRows] = useState<VisitorUser[]>([]);
  const [nextCursor, setNextCursor] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [error, setError] = useState(false);
  const [requested, setRequested] = useState<Record<string, boolean>>({});
  const formatTime = useMemo(() => createTimeFormatter(language), [language]);

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const result = await UserService.myVisitors({ limit: PAGE_SIZE });
        if (!active) return;
        setRows(result.users);
        setNextCursor(result.nextCursor);
      } catch {
        if (active) setError(true);
      } finally {
        if (active) setLoading(false);
      }
    })();
    return () => {
      active = false;
    };
  }, []);

  const loadMore = useCallback(async () => {
    if (loading || loadingMore || nextCursor == null) return;
    setLoadingMore(true);
    try {
      const result = await UserService.myVisitors({ limit: PAGE_SIZE, cursor: nextCursor });
      setRows((current) => [...current, ...result.users]);
      setNextCursor(result.nextCursor);
    } catch {
      return;
    } finally {
      setLoadingMore(false);
    }
  }, [nextCursor, loading, loadingMore]);

  async function addFriend(row: VisitorUser) {
    try {
      await RelationshipService.sendRequest(row.id);
      setRequested((current) => ({ ...current, [row.id]: true }));
      push('success', t('me.friendRequestSent'));
    } catch {
      push('error', t('me.makeFriendError'));
    }
  }

  return (
    <Modal visible transparent animationType="slide" onRequestClose={onClose}>
      <View className="flex-1 bg-white">
        <ScreenHeader title={t('me.tabVisitors')} onBack={onClose} />

        {loading ? (
          <ActivityIndicator className="py-6" color="#7cb342" />
        ) : error ? (
          <Text className="py-6 text-center text-sm" style={{ color: '#e34545' }}>{t('me.visitorsError')}</Text>
        ) : rows.length === 0 ? (
          <Text className="py-10 text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>{t('me.followerEmpty')}</Text>
        ) : (
          <FlatList
            data={rows}
            keyExtractor={(item) => item.id}
            onEndReached={() => void loadMore()}
            onEndReachedThreshold={0.4}
            ListFooterComponent={loadingMore ? <ActivityIndicator className="py-3" color="#7cb342" /> : null}
            renderItem={({ item }) => {
              const status = item.relationship?.status ?? 'none';
              const sent = status === 'pending_outgoing' || requested[item.id] === true;
              const openProfile = () => onOpenProfile(item.username, colorForName(item.username));
              return (
                <View
                  className="flex-row items-start gap-3 px-4 py-3"
                  style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.12)' }}
                >
                  <Pressable onPress={openProfile}>
                    <Avatar name={item.username} uri={item.avatar ?? undefined} size={72} rounded={false} />
                  </Pressable>
                  <View className="min-w-0 flex-1 gap-1.5">
                    <Pressable onPress={openProfile}>
                      <View className="flex-row items-center gap-1">
                        <VipBadge typeId={activeVipTypeId(item.vipUsed, item.vipEndTime)} size={16} />
                        <Text numberOfLines={1} className="min-w-0 shrink text-base font-medium" style={{ color: 'rgba(0,0,0,0.87)' }}>
                          @{item.username}
                          {item.fullName != null && item.fullName !== '' && (
                            <Text style={{ color: 'rgba(0,0,0,0.45)' }}> · {item.fullName}</Text>
                          )}
                        </Text>
                      </View>
                      <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
                        {formatTime(item.viewedAt)}
                      </Text>
                    </Pressable>
                    {status === 'friend' ? (
                      <View className="self-start rounded px-3 py-1" style={{ backgroundColor: 'rgba(0,0,0,0.08)' }}>
                        <Text className="text-sm font-medium" style={{ color: 'rgba(0,0,0,0.45)' }}>{t('me.alreadyFriend')}</Text>
                      </View>
                    ) : sent ? (
                      <View className="self-start rounded px-3 py-1" style={{ backgroundColor: 'rgba(0,0,0,0.08)' }}>
                        <Text className="text-sm font-medium" style={{ color: 'rgba(0,0,0,0.45)' }}>{t('me.friendRequestSent')}</Text>
                      </View>
                    ) : (
                      <Pressable onPress={() => void addFriend(item)} className="self-start rounded bg-ola-primary px-3 py-1">
                        <Text className="text-sm font-medium text-white">{t('me.makeFriend')}</Text>
                      </Pressable>
                    )}
                  </View>
                </View>
              );
            }}
          />
        )}
      </View>
    </Modal>
  );
}

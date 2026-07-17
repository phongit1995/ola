import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, RefreshControl, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { colorForName } from '@ola/shared/lib';
import { ClanService } from '@ola/shared/services';
import type { ClanBan } from '@ola/shared/types';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { Avatar } from '@components/ui/Avatar';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { clanErrorText } from '@lib/clanHelpers';

interface ClanBansScreenProps {
  clanId: string;
  onClose: () => void;
}

export function ClanBansScreen({ clanId, onClose }: ClanBansScreenProps) {
  const { t } = useTranslation();
  const pushToast = useToastStore((s) => s.push);
  const [bans, setBans] = useState<ClanBan[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const fetchBans = useCallback(async () => {
    const result = await ClanService.bans(clanId, { limit: 100, offset: 0 });
    setBans(result.items);
  }, [clanId]);

  useEffect(() => {
    fetchBans()
      .catch((error) => pushToast('error', clanErrorText(error)))
      .finally(() => setLoading(false));
  }, [fetchBans, pushToast]);

  const onRefresh = useCallback(() => {
    setRefreshing(true);
    fetchBans()
      .catch((error) => pushToast('error', clanErrorText(error)))
      .finally(() => setRefreshing(false));
  }, [fetchBans, pushToast]);

  async function unban(ban: ClanBan) {
    if (ban.user == null) return;
    try {
      await ClanService.unban(clanId, ban.user.id);
      pushToast('success', t('clan.unbanSuccess'));
      setBans((current) => current.filter((item) => item.user?.id !== ban.user?.id));
    } catch (error) {
      pushToast('error', clanErrorText(error));
    }
  }

  return (
    <View className="flex-1 bg-[#f3f3f3]">
      <ScreenHeader title={t('clan.banList')} onBack={onClose} />
      {loading ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : bans.length === 0 ? (
        <Text className="px-6 py-10 text-center text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
          {t('clan.emptyBans')}
        </Text>
      ) : (
        <FlashList
          data={bans}
          keyExtractor={(item, index) => `${item.user?.id ?? ''}-${index}`}
          contentContainerClassName="p-2"
          refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
          renderItem={({ item, index }) => {
            const username = item.user?.username ?? '';
            const fullName = item.user?.fullName ?? '';
            return (
              <View
                className="flex-row items-center gap-3 bg-white px-4 py-3"
                style={
                  index > 0 ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' } : undefined
                }
              >
                <Avatar
                  name={username}
                  uri={item.user?.avatar !== '' ? item.user?.avatar : undefined}
                  color={colorForName(username)}
                  size={40}
                />
                <Text
                  numberOfLines={1}
                  className="min-w-0 flex-1 text-sm"
                  style={{ color: 'rgba(0,0,0,0.87)' }}
                >
                  {username}
                  {fullName !== '' && fullName !== username && (
                    <Text style={{ color: 'rgba(0,0,0,0.54)' }}> · {fullName}</Text>
                  )}
                </Text>
                <Pressable
                  onPress={() => void unban(item)}
                  className="shrink-0 rounded-sm bg-white px-3 py-1.5 active:bg-black/5"
                  style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
                >
                  <Text className="text-xs" style={{ color: '#4c4c4c' }}>
                    {t('clan.unban')}
                  </Text>
                </Pressable>
              </View>
            );
          }}
        />
      )}
    </View>
  );
}

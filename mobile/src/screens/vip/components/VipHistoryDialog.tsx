import { useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, Text, View } from 'react-native';
import {
  createTimeFormatter,
  formatDateDMY,
  formatKen,
  isVipDayTransferSource,
  vipName,
  VIP_HISTORY_TABS,
  vipHistoryIconTypeId,
  vipHistorySourceKey,
} from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { useThemeColors } from '@hooks/useThemeColors';
import { TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { VipIconImage } from './VipIconImage';
import { useVipHistory } from '@ola/shared/stores/vip/useVipHistory';

interface VipHistoryDialogProps {
  visible: boolean;
  onClose: () => void;
}

export function VipHistoryDialog({ visible, onClose }: VipHistoryDialogProps) {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const myId = useAuthStore((s) => s.user?.id);
  const {
    tab,
    setTab,
    purchases,
    transfers,
    items,
    loading,
    error,
    hasMore,
    loadMore,
  } = useVipHistory(visible);

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  return (
    <Dialog
      visible={visible}
      onClose={onClose}
      title={t('vip.historyDialog.title')}
      footer={<DialogButton onPress={onClose}>{t('vip.historyDialog.close')}</DialogButton>}
    >
      <View className="mb-2 flex-row gap-1.5">
        {VIP_HISTORY_TABS.map((key) => {
          const active = tab === key;
          return (
            <Pressable
              key={key}
              onPress={() => setTab(key)}
              className="rounded-full px-3 py-1"
              style={{ backgroundColor: active ? colors.primary : '#efefef' }}
            >
              <Text
                className="text-xs font-medium"
                style={{ color: active ? '#ffffff' : '#5a5a5a' }}
              >
                {t(key === 'purchases' ? 'vip.historyDialog.tabPurchases' : 'vip.historyDialog.tabTransfers')}
              </Text>
            </Pressable>
          );
        })}
      </View>

      <ScrollView style={{ maxHeight: 360 }}>
        {error ? (
          <Text className="py-6 text-center" style={{ color: '#9a2b20' }}>
            {t('common.error')}
          </Text>
        ) : items.length === 0 && loading ? (
          <View className="items-center justify-center" style={{ height: 120 }}>
            <ActivityIndicator />
          </View>
        ) : items.length === 0 ? (
          <Text className="py-6 text-center" style={{ color: '#8a8a8c' }}>
            {t('vip.historyDialog.empty')}
          </Text>
        ) : tab === 'purchases' ? (
          purchases.map((item) => {
            const iconTypeId = vipHistoryIconTypeId(item.packageName);
            return (
              <View
                key={item.id}
                className="flex-row items-center justify-between gap-3 py-2"
                style={{ borderBottomWidth: 1, borderBottomColor: '#eceaea' }}
              >
                <View className="min-w-0 flex-1 flex-row items-center gap-2">
                  {iconTypeId != null && <VipIconImage typeId={iconTypeId} size={32} rounded />}
                  <View className="min-w-0 flex-1">
                    <Text className="font-medium" style={{ color: TEXT_PRIMARY }} numberOfLines={1}>
                      {iconTypeId != null ? vipName(iconTypeId) : item.packageName}
                    </Text>
                    <Text className="text-xs" style={{ color: TEXT_SECONDARY }} numberOfLines={1}>
                      {t(`vip.historyDialog.source.${vipHistorySourceKey(item.source)}`)}
                      {item.days > 0 && !isVipDayTransferSource(item.source)
                        ? ` ·${t('vip.historyDialog.until', { date: formatDateDMY(item.vipEndTime) })}`
                        : ''}
                    </Text>
                  </View>
                </View>
                <View className="items-end">
                  {item.days > 0 && (
                    <Text className="text-sm font-semibold text-ola-credit">
                      {t('vip.historyDialog.days', { count: item.days })}
                    </Text>
                  )}
                  {item.days < 0 && (
                    <Text className="text-sm font-semibold text-ola-debit">
                      {t('vip.historyDialog.daysLost', { count: -item.days })}
                    </Text>
                  )}
                  <Text className="text-xs" style={{ color: '#9a9a9c' }}>
                    {formatTime(item.createdAt)}
                  </Text>
                  {!isVipDayTransferSource(item.source) && (
                    <Text className="text-xs text-ola-debit">
                      {item.kenPrice > 0
                        ? `-${formatKen(item.kenPrice)} KEN`
                        : t('vip.historyDialog.free')}
                    </Text>
                  )}
                </View>
              </View>
            );
          })
        ) : (
          transfers.map((item) => {
            const sent = item.fromUserId === myId;
            return (
              <View
                key={item.id}
                className="flex-row items-center justify-between gap-3 py-2"
                style={{ borderBottomWidth: 1, borderBottomColor: '#eceaea' }}
              >
                <View className="min-w-0 flex-1 flex-row items-center gap-2">
                  <VipIconImage typeId={item.vipIconId} size={32} rounded />
                  <View className="min-w-0 flex-1">
                    <Text className="font-medium" style={{ color: TEXT_PRIMARY }} numberOfLines={1}>
                      {vipName(item.vipIconId)}
                    </Text>
                    <Text
                      className="text-xs"
                      style={{ color: sent ? '#c0392b' : '#1f8a3b' }}
                      numberOfLines={1}
                    >
                      {sent
                        ? t('vip.historyDialog.sentTo', { name: item.toUsername })
                        : t('vip.historyDialog.receivedFrom', { name: item.fromUsername })}
                    </Text>
                  </View>
                </View>
                <Text className="text-xs" style={{ color: '#9a9a9c' }}>
                  {formatTime(item.createdAt)}
                </Text>
              </View>
            );
          })
        )}

        {hasMore && !error && (
          <Pressable
            onPress={loadMore}
            disabled={loading}
            className="mt-2 items-center rounded py-2 active:opacity-80"
            style={{ borderWidth: 1, borderColor: '#d1cece', backgroundColor: '#f6f6f6' }}
          >
            <Text className="text-sm" style={{ color: '#3a3839' }}>
              {loading ? t('common.loading') : t('vip.historyDialog.loadMore')}
            </Text>
          </Pressable>
        )}
      </ScrollView>
    </Dialog>
  );
}

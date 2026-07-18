import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, Text, View } from 'react-native';
import { createTimeFormatter, formatDateDMY, formatKen, vipName } from '@ola/shared/lib';
import { VipService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import type { VipPurchaseHistoryItem, VipTransferHistoryItem } from '@ola/shared/types';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { VipIconImage } from './VipIconImage';

const PAGE_SIZE = 20;
const TABS = ['purchases', 'transfers'] as const;

type HistoryTab = (typeof TABS)[number];

const SOURCE_KEYS = [
  'package',
  'purchase',
  'icon',
  'gift',
  'email_verify',
  'egg',
  'wheel',
  'admin',
] as const;

type SourceKey = (typeof SOURCE_KEYS)[number];

function sourceKeyOf(source: string): SourceKey | 'other' {
  return (SOURCE_KEYS as readonly string[]).includes(source) ? (source as SourceKey) : 'other';
}

function iconTypeIdOf(packageName: string): number | null {
  const match = /^VIP #(\d+)$/.exec(packageName);
  return match ? Number(match[1]) : null;
}

interface VipHistoryDialogProps {
  visible: boolean;
  onClose: () => void;
}

export function VipHistoryDialog({ visible, onClose }: VipHistoryDialogProps) {
  const { t, i18n } = useTranslation();
  const myId = useAuthStore((s) => s.user?.id);
  const [tab, setTab] = useState<HistoryTab>('purchases');
  const [purchases, setPurchases] = useState<VipPurchaseHistoryItem[]>([]);
  const [transfers, setTransfers] = useState<VipTransferHistoryItem[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(false);

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  const loadPage = useCallback(async (offset: number, target: HistoryTab) => {
    setLoading(true);
    setError(false);
    if (offset === 0) {
      setPurchases([]);
      setTransfers([]);
      setTotal(0);
    }
    try {
      if (target === 'purchases') {
        const result = await VipService.getHistory({ limit: PAGE_SIZE, offset });
        setTotal(result.total);
        setPurchases((prev) => (offset === 0 ? result.items : [...prev, ...result.items]));
      } else {
        const result = await VipService.getTransfers({ limit: PAGE_SIZE, offset });
        setTotal(result.total);
        setTransfers((prev) => (offset === 0 ? result.items : [...prev, ...result.items]));
      }
    } catch {
      setError(true);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    if (!visible) return;
    void loadPage(0, tab);
  }, [visible, tab, loadPage]);

  const items: Array<VipPurchaseHistoryItem | VipTransferHistoryItem> =
    tab === 'purchases' ? purchases : transfers;
  const hasMore = items.length < total;

  return (
    <Dialog
      visible={visible}
      onClose={onClose}
      title={t('vip.historyDialog.title')}
      footer={<DialogButton onPress={onClose}>{t('vip.historyDialog.close')}</DialogButton>}
    >
      <View className="mb-2 flex-row gap-1.5">
        {TABS.map((key) => {
          const active = tab === key;
          return (
            <Pressable
              key={key}
              onPress={() => setTab(key)}
              className="rounded-full px-3 py-1"
              style={{ backgroundColor: active ? '#7cb342' : '#efefef' }}
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
            const iconTypeId = iconTypeIdOf(item.packageName);
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
                      {t(`vip.historyDialog.source.${sourceKeyOf(item.source)}`)}
                      {item.days > 0
                        ? ` · ${t('vip.historyDialog.until', { date: formatDateDMY(item.vipEndTime) })}`
                        : ''}
                    </Text>
                  </View>
                </View>
                <View className="items-end">
                  {item.days > 0 && (
                    <Text className="text-sm font-semibold" style={{ color: '#1f8a3b' }}>
                      {t('vip.historyDialog.days', { count: item.days })}
                    </Text>
                  )}
                  <Text className="text-xs" style={{ color: '#9a9a9c' }}>
                    {formatTime(item.createdAt)}
                  </Text>
                  <Text className="text-xs" style={{ color: '#c0392b' }}>
                    {item.kenPrice > 0
                      ? `-${formatKen(item.kenPrice)} KEN`
                      : t('vip.historyDialog.free')}
                  </Text>
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
            onPress={() => void loadPage(items.length, tab)}
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

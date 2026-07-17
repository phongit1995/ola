import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, ScrollView, Text, View } from 'react-native';
import { createTimeFormatter } from '@ola/shared/lib';
import { EggService } from '@ola/shared/services';
import type { EggDrawHistoryFilter, EggDrawHistoryItem } from '@ola/shared/types';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { VipIconImage } from '@screens/vip/components/VipIconImage';
import { eggAssets } from './eggAssets';

const PAGE_SIZE = 20;
const FILTERS: EggDrawHistoryFilter[] = ['all', 'win', 'miss'];

interface EggHistoryDialogProps {
  onClose: () => void;
}

interface OutcomeView {
  text: string;
  tone: 'win' | 'miss';
  vipTypeId?: number;
  iconSource?: number;
}

function useOutcomeLabel() {
  const { t } = useTranslation();
  return useCallback(
    (item: EggDrawHistoryItem): OutcomeView => {
      if (item.categoryType === 'nothing') {
        return { text: t('eggGame.history.miss'), tone: 'miss' };
      }
      if (item.isSuperLucky) {
        return {
          text: t('eggGame.history.superLucky', { reward: item.rewardLabel ?? '' }),
          tone: 'win',
          vipTypeId: item.vipTypeId,
        };
      }
      if (item.categoryType === 'ken' && item.kenAmount) {
        return {
          text: t('eggGame.history.ken', { ken: item.kenAmount }),
          tone: 'win',
          iconSource: eggAssets.kenCoin,
        };
      }
      if (item.categoryType === 'vip_days' && item.vipDays) {
        return {
          text: t('eggGame.history.vipDays', { days: item.vipDays }),
          tone: 'win',
          iconSource: eggAssets.vipDays,
        };
      }
      return {
        text: item.rewardLabel ?? t('eggGame.history.win'),
        tone: 'win',
        vipTypeId: item.vipTypeId,
      };
    },
    [t]
  );
}

export function EggHistoryDialog({ onClose }: EggHistoryDialogProps) {
  const { t, i18n } = useTranslation();
  const [items, setItems] = useState<EggDrawHistoryItem[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);
  const [filter, setFilter] = useState<EggDrawHistoryFilter>('all');

  const outcomeLabel = useOutcomeLabel();
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  const loadPage = useCallback(async (offset: number, outcome: EggDrawHistoryFilter) => {
    setLoading(true);
    setError(false);
    try {
      const result = await EggService.listDraws(PAGE_SIZE, offset, outcome);
      setTotal(result.total);
      setItems((prev) => (offset === 0 ? result.items : [...prev, ...result.items]));
    } catch {
      setError(true);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    setItems([]);
    setTotal(0);
    void loadPage(0, filter);
  }, [filter, loadPage]);

  const hasMore = items.length < total;

  return (
    <Dialog
      visible
      onClose={onClose}
      title={t('eggGame.history.title')}
      footer={<DialogButton onPress={onClose}>{t('eggGame.history.close')}</DialogButton>}
    >
      <View className="mb-2 flex-row" style={{ gap: 6 }}>
        {FILTERS.map((f) => {
          const active = filter === f;
          return (
            <Pressable
              key={f}
              onPress={() => setFilter(f)}
              className="rounded-full px-3 py-1"
              style={{ backgroundColor: active ? '#5e3c20' : '#efefef' }}
            >
              <Text
                className="text-xs font-medium"
                style={{ color: active ? '#ffffff' : '#5a5a5a' }}
              >
                {t(`eggGame.history.filter.${f}`)}
              </Text>
            </Pressable>
          );
        })}
      </View>
      <ScrollView style={{ maxHeight: 380, minHeight: 120 }}>
        {error ? (
          <Text className="py-6 text-center" style={{ color: '#9a2b20' }}>
            {t('eggGame.error')}
          </Text>
        ) : items.length === 0 && loading ? (
          <View className="items-center justify-center" style={{ height: 120 }}>
            <ActivityIndicator color="#5e3c20" />
          </View>
        ) : items.length === 0 ? (
          <Text className="py-6 text-center" style={{ color: '#8a8a8c' }}>
            {t('eggGame.history.empty')}
          </Text>
        ) : (
          items.map((item, index) => {
            const outcome = outcomeLabel(item);
            return (
              <View
                key={item.id}
                className="flex-row items-center justify-between py-2"
                style={{
                  gap: 12,
                  borderTopWidth: index === 0 ? 0 : 1,
                  borderTopColor: '#eceaea',
                }}
              >
                <View className="flex-row items-center" style={{ gap: 6, flexShrink: 1 }}>
                  {outcome.vipTypeId != null ? (
                    <VipIconImage typeId={outcome.vipTypeId} size={20} rounded />
                  ) : outcome.iconSource != null ? (
                    <Image
                      source={outcome.iconSource}
                      style={{ width: 20, height: 20 }}
                      resizeMode="contain"
                    />
                  ) : null}
                  <Text
                    numberOfLines={1}
                    className={outcome.tone === 'win' ? 'font-semibold' : 'font-medium'}
                    style={{
                      flexShrink: 1,
                      color: outcome.tone === 'win' ? '#1f8a3b' : '#8a8a8c',
                    }}
                  >
                    {outcome.text}
                  </Text>
                </View>
                <View style={{ alignItems: 'flex-end' }}>
                  <Text className="text-xs" style={{ color: '#9a9a9c' }}>
                    {formatTime(item.createdAt)}
                  </Text>
                  <Text className="text-xs" style={{ color: '#c0392b' }}>
                    -{item.kenCost} KEN
                  </Text>
                </View>
              </View>
            );
          })
        )}

        {hasMore && !error && (
          <Pressable
            onPress={() => void loadPage(items.length, filter)}
            disabled={loading}
            className="mt-2 w-full items-center py-1.5"
            style={{
              borderRadius: 3,
              borderWidth: 1,
              borderColor: '#d1cece',
              backgroundColor: '#f6f6f6',
              opacity: loading ? 0.5 : 1,
            }}
          >
            <Text className="text-sm" style={{ color: '#3a3839' }}>
              {loading ? t('eggGame.loading') : t('eggGame.history.loadMore')}
            </Text>
          </Pressable>
        )}
      </ScrollView>
    </Dialog>
  );
}

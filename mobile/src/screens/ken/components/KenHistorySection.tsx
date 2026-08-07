import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, Text, View } from 'react-native';
import { formatKen } from '@ola/shared/lib';
import type { KenTxType } from '@ola/shared/types';
import { DIVIDER, PRIMARY, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import {
  KEN_HISTORY_PAGE,
  useKenHistoryStore,
} from '@ola/shared/stores/ken/kenHistoryStore';
import type { KenHistoryRow, KenHistoryTab } from '@ola/shared/types';

const KEN_TX_META = {
  VIP_PACKAGE: { icon: '👑', labelKey: 'ken.historyScreen.types.VIP_PACKAGE' },
  VIP_ICON: { icon: '👑', labelKey: 'ken.historyScreen.types.VIP_ICON' },
  ADMIN_GRANT: { icon: '➕', labelKey: 'ken.historyScreen.types.ADMIN_GRANT' },
  ADMIN_DEDUCT: { icon: '➖', labelKey: 'ken.historyScreen.types.ADMIN_DEDUCT' },
  REWARD: { icon: '🏆', labelKey: 'ken.historyScreen.types.REWARD' },
  EGG_OPEN: { icon: '🥚', labelKey: 'ken.historyScreen.types.EGG_OPEN' },
  TOPUP: { icon: '💰', labelKey: 'ken.historyScreen.types.TOPUP' },
  REFUND: { icon: '↩️', labelKey: 'ken.historyScreen.types.REFUND' },
  GIFT_SENT: { icon: '🎁', labelKey: 'ken.historyScreen.types.GIFT_SENT' },
  GIFT_RECEIVED: { icon: '🎁', labelKey: 'ken.historyScreen.types.GIFT_RECEIVED' },
  TRANSFER_IN: { icon: '📥', labelKey: 'ken.historyScreen.types.TRANSFER_IN' },
  TRANSFER_OUT: { icon: '📤', labelKey: 'ken.historyScreen.types.TRANSFER_OUT' },
  PEN_SHOOT: { icon: '⚽', labelKey: 'ken.historyScreen.types.PEN_SHOOT' },
  PEN_CATCH: { icon: '🧤', labelKey: 'ken.historyScreen.types.PEN_CATCH' },
  PEN_WIN: { icon: '🏆', labelKey: 'ken.historyScreen.types.PEN_WIN' },
  PEN_REFUND: { icon: '↩️', labelKey: 'ken.historyScreen.types.PEN_REFUND' },
  KEN_CHEST: { icon: '🧰', labelKey: 'ken.historyScreen.types.KEN_CHEST' },
  CLAN_CREATE: { icon: '🛡️', labelKey: 'ken.historyScreen.types.CLAN_CREATE' },
} as const satisfies Record<KenTxType, { icon: string; labelKey: string }>;

const KEN_TX_META_FALLBACK = { icon: '🪙', labelKey: 'ken.historyScreen.types.UNKNOWN' } as const;

const TABS: {
  key: KenHistoryTab;
  labelKey: 'ken.historyScreen.tabAll' | 'ken.historyScreen.tabCredit' | 'ken.historyScreen.tabDebit';
}[] = [
  { key: 'all', labelKey: 'ken.historyScreen.tabAll' },
  { key: 'credit', labelKey: 'ken.historyScreen.tabCredit' },
  { key: 'debit', labelKey: 'ken.historyScreen.tabDebit' },
];

function TransactionRow({ row }: { row: KenHistoryRow }) {
  const { t } = useTranslation();
  const meta = KEN_TX_META[row.type] ?? KEN_TX_META_FALLBACK;
  const credit = row.direction === 'credit';
  const subtitle =
    row.counterpartyName != null && row.counterpartyName !== ''
      ? t(credit ? 'ken.historyScreen.fromUser' : 'ken.historyScreen.toUser', {
          name: row.counterpartyName,
        })
      : row.description;
  return (
    <View className="flex-row items-center gap-3 px-3 py-2.5">
      <View
        className="h-9 w-9 items-center justify-center rounded-full"
        style={{ backgroundColor: 'rgba(0,0,0,0.04)' }}
      >
        <Text className="text-lg">{meta.icon}</Text>
      </View>
      <View className="min-w-0 flex-1">
        <Text numberOfLines={1} className="text-sm" style={{ color: TEXT_PRIMARY }}>
          {t(meta.labelKey)}
        </Text>
        {subtitle != null && subtitle !== '' && (
          <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
            {subtitle}
          </Text>
        )}
      </View>
      <View className="shrink-0 items-end">
        <Text className="text-sm font-semibold" style={{ color: credit ? '#2e7d32' : '#e34545' }}>
          {credit ? '+' : '−'}
          {formatKen(row.amount)}
        </Text>
        <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>{row.timeText}</Text>
      </View>
    </View>
  );
}

export function KenHistorySection() {
  const { t } = useTranslation();
  const [tab, setTab] = useState<KenHistoryTab>('all');
  const section = useKenHistoryStore((s) => s.sections[tab]);
  const load = useKenHistoryStore((s) => s.load);

  useEffect(() => {
    void load(tab, 0);
  }, [tab, load]);

  const pageCount = Math.max(1, Math.ceil(section.total / KEN_HISTORY_PAGE));
  const isEmpty = !section.loading && section.groups.length === 0;

  return (
    <View className="mt-3">
      <Text className="mb-1 px-3 text-xs font-medium" style={{ color: 'rgba(0,0,0,0.45)' }}>
        {t('ken.history')}
      </Text>

      <View
        className="mx-2 flex-row rounded-sm bg-white"
        style={{ gap: 2, padding: 2, borderWidth: 1, borderColor: DIVIDER }}
      >
        {TABS.map((item) => {
          const active = tab === item.key;
          return (
            <Pressable
              key={item.key}
              onPress={() => setTab(item.key)}
              className="flex-1 items-center rounded-sm py-1.5"
              style={{ backgroundColor: active ? 'rgba(124,179,66,0.1)' : 'transparent' }}
            >
              <Text
                className={active ? 'text-sm font-semibold' : 'text-sm'}
                style={{ color: active ? PRIMARY : TEXT_SECONDARY }}
              >
                {t(item.labelKey)}
              </Text>
            </Pressable>
          );
        })}
      </View>

      {section.loading && section.groups.length === 0 ? (
        <ActivityIndicator className="py-8" color={PRIMARY} />
      ) : isEmpty ? (
        <Text className="py-10 text-center text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
          {t('ken.historyScreen.empty')}
        </Text>
      ) : (
        <>
          {section.groups.map((group) => (
            <View key={group.key} className="mt-3">
              <Text className="mb-1 px-3 text-xs font-medium" style={{ color: 'rgba(0,0,0,0.45)' }}>
                {group.dayLabel === 'today'
                  ? t('ken.historyScreen.today')
                  : group.dayLabel === 'yesterday'
                    ? t('ken.historyScreen.yesterday')
                    : group.dateText}
              </Text>
              <View
                className="mx-2 overflow-hidden rounded-sm bg-white"
                style={{ borderWidth: 1, borderColor: DIVIDER }}
              >
                {group.rows.map((row, index) => (
                  <View key={row.id}>
                    {index > 0 && (
                      <View className="mx-3" style={{ height: 1, backgroundColor: DIVIDER }} />
                    )}
                    <TransactionRow row={row} />
                  </View>
                ))}
              </View>
            </View>
          ))}

          {pageCount > 1 && (
            <View className="mt-3 flex-row items-center justify-center gap-3">
              <Pressable
                disabled={section.loading || section.page <= 0}
                onPress={() => void load(tab, section.page - 1)}
                className="h-8 w-8 items-center justify-center rounded-sm bg-white"
                style={{
                  borderWidth: 1,
                  borderColor: DIVIDER,
                  opacity: section.loading || section.page <= 0 ? 0.4 : 1,
                }}
              >
                <Text style={{ color: 'rgba(0,0,0,0.7)' }}>‹</Text>
              </Pressable>
              <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
                {section.page + 1}/{pageCount}
              </Text>
              <Pressable
                disabled={section.loading || section.page >= pageCount - 1}
                onPress={() => void load(tab, section.page + 1)}
                className="h-8 w-8 items-center justify-center rounded-sm bg-white"
                style={{
                  borderWidth: 1,
                  borderColor: DIVIDER,
                  opacity: section.loading || section.page >= pageCount - 1 ? 0.4 : 1,
                }}
              >
                <Text style={{ color: 'rgba(0,0,0,0.7)' }}>›</Text>
              </Pressable>
            </View>
          )}
        </>
      )}
    </View>
  );
}

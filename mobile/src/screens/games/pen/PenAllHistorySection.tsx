import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Text, View } from 'react-native';
import { formatVnd } from '@ola/shared/lib';
import { PEN_HISTORY_PAGE, usePenHistoryStore } from '@ola/shared/stores/penHistoryStore';
import type { PenUserBrief } from '@ola/shared/types';
import { VipBadge } from '@components/VipBadge';
import { penAssets } from './penAssets';
import { toAllHistoryRow } from './penHistory';
import { PenHistoryTable, PenColHeader } from './PenHistoryTable';
import { PEN_COLORS } from './penUi';

const COLS = { shooter: 1.5, keeper: 1.5, bet: 0.95, time: 0.7 };

function PlayerCell({ user, won }: { user?: PenUserBrief; won: boolean }) {
  if (user == null) {
    return <Text style={{ fontSize: 11, color: 'rgba(255,255,255,0.35)' }}>—</Text>;
  }
  return (
    <View style={{ minWidth: 0, flexDirection: 'row', alignItems: 'center', gap: 4 }}>
      <VipBadge typeId={user.vipTypeId} size={20} />
      <Text
        numberOfLines={1}
        style={{
          flexShrink: 1,
          fontSize: 11,
          fontWeight: won ? '700' : '400',
          color: won ? PEN_COLORS.green : 'rgba(255,255,255,0.8)',
        }}
      >
        @{user.username}
      </Text>
      {won && <Text style={{ fontSize: 11, color: PEN_COLORS.yellow }}>🏆</Text>}
    </View>
  );
}

export function PenAllHistorySection() {
  const { t } = useTranslation();
  const state = usePenHistoryStore((s) => s.sections.all);
  const load = usePenHistoryStore((s) => s.load);

  useEffect(() => {
    void load('all', 0);
  }, [load]);

  const pageCount = Math.max(1, Math.ceil(state.total / PEN_HISTORY_PAGE));

  return (
    <PenHistoryTable
      minHeight={340}
      header={
        <>
          <PenColHeader flex={COLS.shooter}>{t('penGame.hist.colShooter')}</PenColHeader>
          <PenColHeader flex={COLS.keeper}>{t('penGame.hist.colCatcher')}</PenColHeader>
          <PenColHeader flex={COLS.bet}>{t('penGame.hist.colBet')}</PenColHeader>
          <PenColHeader flex={COLS.time} align="center">
            {t('penGame.hist.colTime')}
          </PenColHeader>
        </>
      }
      loading={state.loading}
      isEmpty={state.items.length === 0}
      emptyText={t('penGame.hist.emptyAll')}
      page={state.page}
      pageCount={pageCount}
      onPage={(p) => void load('all', p)}
    >
      <View>
        {state.items.map((shot) => {
          const row = toAllHistoryRow(shot);
          return (
            <View
              key={row.id}
              style={{
                flexDirection: 'row',
                alignItems: 'center',
                gap: 4,
                borderBottomWidth: 1,
                borderBottomColor: 'rgba(255,255,255,0.05)',
                paddingHorizontal: 6,
                paddingVertical: 6,
              }}
            >
              <View style={{ flex: COLS.shooter, minWidth: 0 }}>
                <PlayerCell
                  user={row.shooter}
                  won={row.winnerId != null && row.winnerId === row.shooter?.id}
                />
              </View>
              <View style={{ flex: COLS.keeper, minWidth: 0 }}>
                <PlayerCell
                  user={row.keeper}
                  won={row.winnerId != null && row.winnerId === row.keeper?.id}
                />
              </View>
              <View style={{ flex: COLS.bet, flexDirection: 'row', alignItems: 'center', gap: 4 }}>
                <Image
                  source={penAssets.kenIcon}
                  style={{ width: 14, height: 14 }}
                  resizeMode="contain"
                />
                <Text numberOfLines={1} style={{ fontSize: 11, fontWeight: '600', color: PEN_COLORS.gold }}>
                  {formatVnd(row.bet)}
                </Text>
              </View>
              <View style={{ flex: COLS.time, alignItems: 'center' }}>
                <Text style={{ fontSize: 9, color: 'rgba(255,255,255,0.55)' }}>{row.date}</Text>
                <Text style={{ fontSize: 9, color: 'rgba(255,255,255,0.55)' }}>{row.time}</Text>
              </View>
            </View>
          );
        })}
      </View>
    </PenHistoryTable>
  );
}

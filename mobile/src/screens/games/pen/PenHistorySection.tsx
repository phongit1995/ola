import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { formatVnd, toApiError } from '@ola/shared/lib';
import { PenService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { PEN_HISTORY_PAGE, usePenHistoryStore } from '@ola/shared/stores/penHistoryStore';
import type { PenHistorySection as SectionRole } from '@ola/shared/stores/penHistoryStore';
import type { PenSide } from '@ola/shared/types';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { VipBadge } from '@components/ui/VipBadge';
import { penAssets, penHistoryAssets } from './penAssets';
import { PenHistoryTable, PenColHeader } from './PenHistoryTable';
import { toHistoryRow, type PenHistoryOutcome, type PenHistoryRowView } from './penHistory';
import { PEN_COLORS } from './penUi';

const COLS = { opponent: 1.6, bet: 1, time: 0.8, result: 1.7 };

function DirectionLabel({ verb, side }: { verb: 'shoot' | 'catch'; side: PenSide }) {
  const { t } = useTranslation();
  const left = side === 'left';
  const label =
    verb === 'catch'
      ? left
        ? t('penGame.hist.catchLeft')
        : t('penGame.hist.catchRight')
      : left
        ? t('penGame.hist.shootLeft')
        : t('penGame.hist.shootRight');
  return (
    <Text
      style={{
        fontSize: 10,
        fontWeight: '600',
        color: left ? PEN_COLORS.green : PEN_COLORS.blue,
      }}
    >
      {label} {left ? '←' : '→'}
    </Text>
  );
}

function ResultCell({
  outcome,
  amount,
  onCancel,
}: {
  outcome: PenHistoryOutcome;
  amount: number;
  onCancel?: () => void;
}) {
  const { t } = useTranslation();
  if (outcome === 'pending') {
    if (onCancel == null) return null;
    return (
      <View style={{ flexDirection: 'row', justifyContent: 'flex-end' }}>
        <Pressable
          onPress={onCancel}
          style={{
            borderRadius: 6,
            borderWidth: 1,
            borderColor: 'rgba(255,91,91,0.7)',
            backgroundColor: 'rgba(255,91,91,0.15)',
            paddingHorizontal: 10,
            paddingVertical: 4,
          }}
        >
          <Text style={{ fontSize: 11, fontWeight: '700', color: '#ff7a7a' }}>
            {t('penGame.hist.cancel')}
          </Text>
        </Pressable>
      </View>
    );
  }
  if (outcome === 'cancelled') {
    return (
      <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'flex-end', gap: 4 }}>
        <Text style={{ fontSize: 13, color: 'rgba(255,255,255,0.45)' }}>⊘</Text>
        <Text style={{ fontSize: 11, fontWeight: '600', color: 'rgba(255,255,255,0.45)' }}>
          {t('penGame.hist.cancelledTag')}
        </Text>
      </View>
    );
  }
  const win = outcome === 'win';
  return (
    <Text
      numberOfLines={1}
      style={{
        textAlign: 'right',
        fontSize: 11,
        fontWeight: '700',
        color: win ? PEN_COLORS.green : PEN_COLORS.red,
      }}
    >
      {win ? '+' : '-'}
      {formatVnd(Math.abs(amount))} {t('penGame.hist.ken')}
    </Text>
  );
}

function PenHistoryRow({
  row,
  verb,
  onCancel,
}: {
  row: PenHistoryRowView;
  verb: 'shoot' | 'catch';
  onCancel: (id: string) => void;
}) {
  const { t } = useTranslation();
  return (
    <View
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
      <View style={{ flex: COLS.opponent, minWidth: 0, flexDirection: 'row', alignItems: 'center', gap: 6 }}>
        {row.opponent != null ? (
          <>
            <VipBadge typeId={row.opponent.vipTypeId} size={24} />
            <View style={{ flexShrink: 1, minWidth: 0 }}>
              <Text numberOfLines={1} style={{ fontSize: 12, color: 'rgba(255,255,255,0.9)' }}>
                @{row.opponent.username}
              </Text>
              {row.side != null && <DirectionLabel verb={verb} side={row.side} />}
            </View>
          </>
        ) : row.outcome === 'pending' ? (
          <View style={{ flexDirection: 'row', alignItems: 'center', gap: 4 }}>
            <Image
              source={penHistoryAssets.clockYellow}
              style={{ width: 16, height: 16 }}
              resizeMode="contain"
            />
            <Text style={{ fontSize: 11, fontWeight: '600', color: PEN_COLORS.yellow }}>
              {t('penGame.hist.pending')}
            </Text>
          </View>
        ) : (
          <Text style={{ fontSize: 11, color: 'rgba(255,255,255,0.35)' }}>—</Text>
        )}
      </View>

      <View style={{ flex: COLS.bet, flexDirection: 'row', alignItems: 'center', gap: 4 }}>
        <Image source={penAssets.kenIcon} style={{ width: 14, height: 14 }} resizeMode="contain" />
        <Text numberOfLines={1} style={{ fontSize: 11, fontWeight: '600', color: PEN_COLORS.gold }}>
          {formatVnd(row.bet)}
        </Text>
      </View>

      <View style={{ flex: COLS.time, alignItems: 'center' }}>
        <Text style={{ fontSize: 9, color: 'rgba(255,255,255,0.55)' }}>{row.date}</Text>
        <Text style={{ fontSize: 9, color: 'rgba(255,255,255,0.55)' }}>{row.time}</Text>
      </View>

      <View style={{ flex: COLS.result, justifyContent: 'center' }}>
        <ResultCell
          outcome={row.outcome}
          amount={row.amount}
          onCancel={row.outcome === 'pending' ? () => onCancel(row.id) : undefined}
        />
      </View>
    </View>
  );
}

interface PenHistorySectionProps {
  section: SectionRole;
  opponentLabel: string;
  userId?: string;
}

export function PenHistorySection({ section, opponentLabel, userId }: PenHistorySectionProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const state = usePenHistoryStore((s) => s.sections[section]);
  const load = usePenHistoryStore((s) => s.load);
  const user = useAuthStore((s) => s.user);
  const setUser = useAuthStore((s) => s.setUser);
  const [cancelId, setCancelId] = useState<string | null>(null);
  const [cancelling, setCancelling] = useState(false);

  useEffect(() => {
    void load(section, 0);
  }, [load, section]);

  const verb = section === 'shoot' ? 'catch' : 'shoot';
  const pageCount = Math.max(1, Math.ceil(state.total / PEN_HISTORY_PAGE));
  const emptyText = section === 'shoot' ? t('penGame.hist.emptyShot') : t('penGame.hist.emptyCatch');

  const handleCancel = async () => {
    if (cancelId == null || cancelling) return;
    setCancelling(true);
    try {
      const res = await PenService.cancelShot(cancelId);
      if (user) setUser({ ...user, ken: res.kenBalance });
      setCancelId(null);
      push('success', t('penGame.hist.cancelled'));
      void load(section, state.page);
    } catch (e) {
      push('error', toApiError(e).message);
    } finally {
      setCancelling(false);
    }
  };

  return (
    <PenHistoryTable
      minHeight={420}
      header={
        <>
          <PenColHeader flex={COLS.opponent}>{opponentLabel}</PenColHeader>
          <PenColHeader flex={COLS.bet}>{t('penGame.hist.colBet')}</PenColHeader>
          <PenColHeader flex={COLS.time} align="center">
            {t('penGame.hist.colTime')}
          </PenColHeader>
          <PenColHeader flex={COLS.result} align="right">
            {t('penGame.hist.colResult')}
          </PenColHeader>
        </>
      }
      loading={state.loading}
      isEmpty={state.items.length === 0}
      emptyText={emptyText}
      page={state.page}
      pageCount={pageCount}
      onPage={(p) => void load(section, p)}
      footer={
        <ConfirmDialog
          visible={cancelId != null}
          title={t('penGame.hist.cancelTitle')}
          message={t('penGame.hist.cancelMessage')}
          confirmLabel={t('penGame.hist.cancelConfirm')}
          cancelLabel={t('penGame.hist.cancelDismiss')}
          danger
          onConfirm={handleCancel}
          onCancel={() => setCancelId(null)}
        />
      }
    >
      <View>
        {state.items.map((shot) => (
          <PenHistoryRow
            key={shot.id}
            row={toHistoryRow(shot, section, userId)}
            verb={verb}
            onCancel={setCancelId}
          />
        ))}
      </View>
    </PenHistoryTable>
  );
}

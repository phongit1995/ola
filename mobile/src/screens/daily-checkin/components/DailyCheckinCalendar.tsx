import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Text, View } from 'react-native';
import { DAILY_CHECKIN_GRID_COLUMNS } from '@ola/shared/constants';
import { dailyCheckinMonthNumber, dailyCheckinRestInfo, dailyCheckinRestText } from '@ola/shared/lib';
import type { DailyCheckinSlot, DailyCheckinStatus } from '@ola/shared/types';
import { TEXT_PRIMARY, TEXT_SECONDARY, WARNING_INK, WARNING_SOFT } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { CHECKIN_GRID_GAP } from '../constants';
import { DailyCheckinCell } from './DailyCheckinCell';

interface DailyCheckinCalendarProps {
  status: DailyCheckinStatus;
  onSelect: (slot: DailyCheckinSlot) => void;
  showSummary?: boolean;
  showLegend?: boolean;
}

function Legend() {
  const { t } = useTranslation();
  const style = { fontSize: 11, color: TEXT_SECONDARY };
  return (
    <View className="mt-3 flex-row flex-wrap items-center px-1" style={{ columnGap: 12, rowGap: 4 }}>
      <Text style={style}>{t('dailyCheckin.legend.plain')}</Text>
      <Text style={style}>✓ {t('dailyCheckin.legend.done')}</Text>
      <Text style={style}>✕ {t('dailyCheckin.legend.missed')}</Text>
      <Text style={style}>… {t('dailyCheckin.legend.pending')}</Text>
      <Text style={style}>🔒 {t('dailyCheckin.legend.outOfReach')}</Text>
    </View>
  );
}

export function DailyCheckinCalendar({ status, onSelect, showSummary = true, showLegend = false }: DailyCheckinCalendarProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const [width, setWidth] = useState(0);
  const rest = dailyCheckinRestInfo(status);
  const cellSize = width > 0 ? Math.floor((width - CHECKIN_GRID_GAP * (DAILY_CHECKIN_GRID_COLUMNS - 1)) / DAILY_CHECKIN_GRID_COLUMNS) : 0;

  return (
    <View>
      {showSummary && (
        <View className="flex-row items-center justify-between gap-2 px-1 pb-2">
          <Text numberOfLines={1} className="min-w-0 flex-1 text-sm font-bold" style={{ color: TEXT_PRIMARY }}>
            {t('dailyCheckin.summary', { month: dailyCheckinMonthNumber(status), count: status.count, total: status.slotCount })}
          </Text>
          {rest != null && (
            <View
              className="rounded-full px-2 py-0.5"
              style={{ backgroundColor: rest.kind === 'rest' ? colors.primaryLight : WARNING_SOFT }}
            >
              <Text className="text-xs font-semibold" style={{ color: rest.kind === 'rest' ? colors.primaryDark : WARNING_INK }}>
                {dailyCheckinRestText(t, rest)}
              </Text>
            </View>
          )}
        </View>
      )}
      <View
        onLayout={(event) => setWidth(event.nativeEvent.layout.width)}
        className="flex-row flex-wrap"
        style={{ gap: CHECKIN_GRID_GAP, paddingTop: 5 }}
      >
        {cellSize > 0 &&
          status.slots.map((slot) => <DailyCheckinCell key={slot.slot} slot={slot} size={cellSize} onSelect={onSelect} />)}
      </View>
      {showLegend && <Legend />}
    </View>
  );
}

import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Text, View } from 'react-native';
import { DAILY_CHECKIN_GRID_COLUMNS } from '@ola/shared/constants';
import { dailyCheckinMonthNumber } from '@ola/shared/lib';
import type { DailyCheckinSlot, DailyCheckinStatus } from '@ola/shared/types';
import { TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { CHECKIN_GRID_GAP } from '../constants';
import { DAILY_CHECKIN_IMAGES } from '../dailyCheckinAssets';
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
      <View className="flex-row items-center gap-1">
        <Image source={DAILY_CHECKIN_IMAGES.task} style={{ width: 14, height: 14 }} resizeMode="contain" />
        <Text style={style}>{t('dailyCheckin.legend.pending')}</Text>
      </View>
    </View>
  );
}

export function DailyCheckinCalendar({ status, onSelect, showSummary = true, showLegend = false }: DailyCheckinCalendarProps) {
  const { t } = useTranslation();
  const [width, setWidth] = useState(0);
  const cellSize = width > 0 ? Math.floor((width - CHECKIN_GRID_GAP * (DAILY_CHECKIN_GRID_COLUMNS - 1)) / DAILY_CHECKIN_GRID_COLUMNS) : 0;

  return (
    <View>
      {showSummary && (
        <View className="flex-row items-center justify-between gap-2 px-1 pb-2">
          <Text numberOfLines={1} className="min-w-0 flex-1 text-sm font-bold" style={{ color: TEXT_PRIMARY }}>
            {t('dailyCheckin.summary', { month: dailyCheckinMonthNumber(status), count: status.count, total: status.slotCount })}
          </Text>
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

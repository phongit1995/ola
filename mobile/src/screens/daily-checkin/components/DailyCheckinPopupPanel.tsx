import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, View } from 'react-native';
import {
  dailyCheckinMonthNumber,
  dailyCheckinRestInfo,
  dailyCheckinRestText,
  formatDailyCheckinCountdown,
} from '@ola/shared/lib';
import { useDailyCheckinStore } from '@ola/shared/stores/daily-checkin/dailyCheckinStore';
import type { DailyCheckinSlot, DailyCheckinStatus } from '@ola/shared/types';
import { useThemeColors } from '@hooks/useThemeColors';
import { useDailyCheckinCountdown } from '@ola/shared/stores/daily-checkin/useDailyCheckinCountdown';
import { DailyCheckinCalendar } from './DailyCheckinCalendar';
import { DailyCheckinTodayCard } from './DailyCheckinTodayCard';

interface DailyCheckinPopupPanelProps {
  status: DailyCheckinStatus;
  onClose: () => void;
  onSelect: (slot: DailyCheckinSlot) => void;
  onGoTask: () => void;
}

export function DailyCheckinPopupPanel({ status, onClose, onSelect, onGoTask }: DailyCheckinPopupPanelProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const acting = useDailyCheckinStore((s) => s.acting);
  const remainingMs = useDailyCheckinCountdown(status);
  const rest = dailyCheckinRestInfo(status);
  const progress = [
    t('dailyCheckin.progress', { count: status.count, total: status.slotCount }),
    rest != null ? dailyCheckinRestText(t, rest) : null,
  ]
    .filter(Boolean)
    .join(' · ');

  return (
    <View
      className="w-full overflow-hidden bg-white"
      style={{ borderRadius: 16, maxHeight: '100%', shadowColor: '#000', shadowOpacity: 0.3, shadowRadius: 20, shadowOffset: { width: 0, height: 6 }, elevation: 8 }}
    >
      <View className="px-4 py-3" style={{ backgroundColor: colors.primary, paddingRight: 44 }}>
        <Text className="text-lg font-bold" style={{ color: colors.onPrimary }}>
          {t('dailyCheckin.popupTitle', { month: dailyCheckinMonthNumber(status) })}
        </Text>
        <View className="mt-1 flex-row items-center justify-between gap-2">
          <Text numberOfLines={1} className="min-w-0 flex-1 text-xs" style={{ color: colors.onPrimary, opacity: 0.85 }}>
            {progress}
          </Text>
          <View className="rounded-full px-2 py-0.5" style={{ backgroundColor: 'rgba(255,255,255,0.2)' }}>
            <Text className="text-xs font-semibold" style={{ color: colors.onPrimary, fontVariant: ['tabular-nums'] }}>
              {t('dailyCheckin.countdown', { time: formatDailyCheckinCountdown(remainingMs) })}
            </Text>
          </View>
        </View>
        <Pressable
          onPress={onClose}
          accessibilityLabel={t('dialog.close')}
          className="absolute right-2 top-2 h-8 w-8 items-center justify-center rounded-full active:opacity-70"
        >
          <Text className="text-base font-bold" style={{ color: colors.onPrimary }}>
            ✕
          </Text>
        </Pressable>
      </View>
      <ScrollView contentContainerStyle={{ padding: 12 }} bounces={false}>
        <DailyCheckinCalendar status={status} onSelect={onSelect} showSummary={false} />
        <View className="mt-3">
          <DailyCheckinTodayCard
            status={status}
            busy={acting}
            onCheckIn={() => void useDailyCheckinStore.getState().checkIn()}
            onOpen={() => void useDailyCheckinStore.getState().open()}
            onGoTask={onGoTask}
          />
        </View>
      </ScrollView>
    </View>
  );
}

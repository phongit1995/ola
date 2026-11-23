import { useCallback, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, ScrollView, Text, View } from 'react-native';
import { useFocusEffect, useNavigation, type ParamListBase } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { formatDailyCheckinCountdown } from '@ola/shared/lib';
import { useDailyCheckinStore } from '@ola/shared/stores/daily-checkin/dailyCheckinStore';
import type { DailyCheckinSlot } from '@ola/shared/types';
import { Dialog } from '@components/ui/Dialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { TEXT_SECONDARY } from '@constants';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { DailyCheckinCalendar } from './components/DailyCheckinCalendar';
import { DailyCheckinSlotPanel } from './components/DailyCheckinPanels';
import { DailyCheckinTodayCard } from './components/DailyCheckinTodayCard';
import { CHECKIN_SURFACE } from './constants';
import { useDailyCheckinCountdown } from '@ola/shared/stores/daily-checkin/useDailyCheckinCountdown';
import { useDailyCheckinTask } from './useDailyCheckinTask';

const CARD_STYLE = {
  backgroundColor: '#ffffff',
  borderRadius: 12,
  padding: 12,
  shadowColor: '#000',
  shadowOpacity: 0.06,
  shadowRadius: 4,
  shadowOffset: { width: 0, height: 1 },
  elevation: 1,
} as const;

export function DailyCheckinScreen() {
  const { t } = useTranslation();
  const navigation = useNavigation<NativeStackNavigationProp<ParamListBase>>();
  const bottomInset = useBottomBarInset();
  const status = useDailyCheckinStore((s) => s.status);
  const loading = useDailyCheckinStore((s) => s.loading);
  const acting = useDailyCheckinStore((s) => s.acting);
  const remainingMs = useDailyCheckinCountdown(status);
  const goTask = useDailyCheckinTask(navigation.navigate);
  const [selected, setSelected] = useState<DailyCheckinSlot | null>(null);
  const enabled = status?.enabled === true;

  useFocusEffect(
    useCallback(() => {
      void useDailyCheckinStore.getState().load({ force: true });
    }, [])
  );

  const countdown = enabled ? (
    <View className="rounded-full px-2.5 py-1" style={{ backgroundColor: 'rgba(255,255,255,0.2)' }}>
      <Text className="text-xs font-semibold text-white" style={{ fontVariant: ['tabular-nums'] }}>
        {t('dailyCheckin.countdown', { time: formatDailyCheckinCountdown(remainingMs) })}
      </Text>
    </View>
  ) : undefined;

  return (
    <View className="flex-1" style={{ backgroundColor: CHECKIN_SURFACE }}>
      <ScreenHeader title={t('dailyCheckin.title')} onBack={() => navigation.goBack()} right={countdown} />
      {status == null || !enabled ? (
        <View className="flex-1 items-center justify-center">
          {loading ? (
            <ActivityIndicator />
          ) : (
            <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('dailyCheckin.errors.disabled')}
            </Text>
          )}
        </View>
      ) : (
        <ScrollView contentContainerStyle={{ padding: 12, paddingBottom: 12 + bottomInset, gap: 12 }}>
          <View style={CARD_STYLE}>
            <DailyCheckinCalendar status={status} onSelect={setSelected} showLegend />
          </View>
          <View style={[CARD_STYLE, { padding: 16 }]}>
            <DailyCheckinTodayCard
              status={status}
              busy={acting}
              onCheckIn={() => void useDailyCheckinStore.getState().checkIn()}
              onOpen={() => void useDailyCheckinStore.getState().open()}
              onGoTask={() => goTask(status.todayTask?.code)}
            />
          </View>
        </ScrollView>
      )}
      <Dialog visible={selected != null} bare avoidKeyboard={false} onClose={() => setSelected(null)}>
        {selected != null && <DailyCheckinSlotPanel slot={selected} onClose={() => setSelected(null)} />}
      </Dialog>
    </View>
  );
}

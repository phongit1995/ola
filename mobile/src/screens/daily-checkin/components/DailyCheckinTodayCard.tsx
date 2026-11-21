import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, Text, View } from 'react-native';
import { DAILY_CHECKIN_BOX } from '@ola/shared/constants';
import {
  dailyCheckinMonthNumber,
  dailyCheckinNextGiftSlot,
  dailyCheckinNextMonthLabel,
  dailyCheckinTaskName,
  dailyCheckinTodayKind,
  dailyCheckinTodaySlot,
} from '@ola/shared/lib';
import type { DailyCheckinStatus } from '@ola/shared/types';
import { ItemGrantIcon } from '@components/ui/ItemGrantMarks';
import { TEXT_PRIMARY, TEXT_SECONDARY, WARNING, WARNING_INK, WARNING_SOFT } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { CHECKIN_GOLD_INK, CHECKIN_GOLD_SOFT } from '../constants';
import { DAILY_CHECKIN_IMAGES } from '../dailyCheckinAssets';
import { boxImage } from '../utils';
import { DailyCheckinRewardList } from './DailyCheckinRewardList';

interface DailyCheckinTodayCardProps {
  status: DailyCheckinStatus;
  busy: boolean;
  onCheckIn: () => void;
  onOpen: () => void;
  onGoTask: () => void;
  onVerifyEmail: () => void;
}

function ActionButton({ tone, busy, onPress, children }: { tone: 'green' | 'orange'; busy: boolean; onPress: () => void; children: string }) {
  const colors = useThemeColors();
  return (
    <Pressable
      onPress={onPress}
      disabled={busy}
      className="mt-3 h-11 items-center justify-center rounded-lg active:opacity-85"
      style={{ backgroundColor: tone === 'green' ? colors.primary : WARNING, opacity: busy ? 0.6 : 1 }}
    >
      {busy ? <ActivityIndicator color="#ffffff" /> : <Text className="text-base font-bold text-white">{children}</Text>}
    </Pressable>
  );
}

function Notice({ tone, title, hint }: { tone: 'orange' | 'green'; title: string; hint?: string }) {
  const colors = useThemeColors();
  const ink = tone === 'orange' ? WARNING_INK : colors.primaryDark;
  return (
    <View
      className="mt-3 flex-row gap-2 rounded-lg px-3 py-2"
      style={{ backgroundColor: tone === 'orange' ? WARNING_SOFT : colors.primaryLight }}
    >
      {tone === 'orange' ? (
        <Image source={DAILY_CHECKIN_IMAGES.task} style={{ width: 16, height: 16, marginTop: 2 }} resizeMode="contain" />
      ) : (
        <Text className="text-sm font-bold" style={{ color: ink }}>
          ✓
        </Text>
      )}
      <View className="min-w-0 flex-1">
        <Text className="text-sm font-semibold" style={{ color: ink }}>
          {title}
        </Text>
        {hint != null && (
          <Text className="text-sm" style={{ color: ink }}>
            {hint}
          </Text>
        )}
      </View>
    </View>
  );
}

function Badge({ label, icon }: { label: string; icon?: boolean }) {
  return (
    <View className="flex-row items-center gap-1 rounded-full px-2 py-0.5" style={{ backgroundColor: CHECKIN_GOLD_SOFT }}>
      {icon === true && <Image source={DAILY_CHECKIN_IMAGES.vipBadge} style={{ width: 12, height: 12 }} resizeMode="contain" />}
      <Text style={{ fontSize: 11, fontWeight: '700', color: CHECKIN_GOLD_INK }}>{label}</Text>
    </View>
  );
}

export function DailyCheckinTodayCard({ status, busy, onCheckIn, onOpen, onGoTask, onVerifyEmail }: DailyCheckinTodayCardProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const kind = dailyCheckinTodayKind(status);
  const slot = dailyCheckinTodaySlot(status);
  const month = dailyCheckinMonthNumber(status);
  const box = slot?.box ?? DAILY_CHECKIN_BOX.none;
  const hasBox = box !== DAILY_CHECKIN_BOX.none;
  const taskName = dailyCheckinTaskName(t, status.todayTask?.code);
  const nextGift = dailyCheckinNextGiftSlot(status);
  const vipHint =
    slot?.requireVip === true ? (
      <Text className="mt-2 text-xs" style={{ color: CHECKIN_GOLD_INK }}>
        {t('dailyCheckin.today.vipHint')}
      </Text>
    ) : null;

  if (kind === 'completed') {
    return (
      <View className="items-center">
        <Text className="text-center text-base font-bold" style={{ color: colors.primaryDark }}>
          {t('dailyCheckin.today.completedTitle', { count: status.count, total: status.slotCount, month })}
        </Text>
        <Text className="mt-1 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
          {t('dailyCheckin.today.completedHint', { date: dailyCheckinNextMonthLabel(status) })}
        </Text>
        {status.todayResult != null && status.todayResult.length > 0 && (
          <View className="mt-3 w-full">
            <DailyCheckinRewardList items={status.todayResult} />
          </View>
        )}
      </View>
    );
  }

  const checkedLine = (
    <Text className="text-sm" style={{ color: colors.primaryDark }}>
      ✓ {t('dailyCheckin.today.checkedIn')}
    </Text>
  );

  function boxRow(title: string, lines: ReactNode, locked = false) {
    return (
      <View className="mt-3 flex-row items-center gap-3">
        <View className="h-16 w-16 items-center justify-center rounded-xl" style={{ backgroundColor: CHECKIN_GOLD_SOFT }}>
          {hasBox ? (
            <Image source={boxImage(box)} style={{ width: 48, height: 48 }} resizeMode="contain" />
          ) : (
            <Text className="text-2xl font-bold" style={{ color: TEXT_SECONDARY }}>
              {status.slot}
            </Text>
          )}
          {locked && (
            <View style={{ position: 'absolute', right: 4, bottom: 4 }}>
              <ItemGrantIcon kind="lock" size={16} />
            </View>
          )}
        </View>
        <View className="min-w-0 flex-1">
          <Text className="text-base font-bold" style={{ color: TEXT_PRIMARY }}>
            {title}
          </Text>
          {lines}
        </View>
      </View>
    );
  }

  const secretTitle = hasBox ? t('dailyCheckin.today.secretTitle') : t('dailyCheckin.today.noGiftTitle', { slot: status.slot });
  let body: ReactNode;
  switch (kind) {
    case 'checkin':
      body = (
        <>
          {boxRow(
            secretTitle,
            <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
              {hasBox ? t('dailyCheckin.today.secretHint') : t('dailyCheckin.today.noGiftHint')}
            </Text>
          )}
          <ActionButton tone="green" busy={busy} onPress={onCheckIn}>
            {t('dailyCheckin.actions.checkIn')}
          </ActionButton>
        </>
      );
      break;
    case 'verifyEmail':
      body = (
        <>
          {boxRow(
            secretTitle,
            <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('dailyCheckin.today.emailTitle')}
            </Text>
          )}
          <Notice tone="orange" title={t('dailyCheckin.today.emailTitle')} hint={t('dailyCheckin.today.emailGuide')} />
          <ActionButton tone="orange" busy={false} onPress={onVerifyEmail}>
            {t('dailyCheckin.actions.verifyEmail')}
          </ActionButton>
        </>
      );
      break;
    case 'noGift':
      body = boxRow(
        t('dailyCheckin.today.noGiftTitle', { slot: status.slot }),
        <>
          {checkedLine}
          <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
            {nextGift != null ? t('dailyCheckin.today.nextGift', { slot: nextGift }) : t('dailyCheckin.today.noMoreGift')}
          </Text>
        </>
      );
      break;
    case 'task':
      body = (
        <>
          {boxRow(
            t('dailyCheckin.today.lockedTitle'),
            <>
              {checkedLine}
              <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
                {t('dailyCheckin.today.lockedHint')}
              </Text>
            </>,
            true
          )}
          <Notice tone="orange" title={t('dailyCheckin.today.taskTitle', { task: taskName })} hint={t('dailyCheckin.today.taskHint')} />
          {vipHint}
          <ActionButton tone="orange" busy={false} onPress={onGoTask}>
            {t('dailyCheckin.actions.goTask')}
          </ActionButton>
        </>
      );
      break;
    case 'open':
      body = (
        <>
          {boxRow(t('dailyCheckin.today.readyTitle'), checkedLine)}
          <Notice tone="green" title={t('dailyCheckin.today.taskDone', { task: taskName })} />
          {vipHint}
          <ActionButton tone="green" busy={busy} onPress={onOpen}>
            {t('dailyCheckin.actions.open')}
          </ActionButton>
        </>
      );
      break;
    default:
      body = (
        <>
          <Text className="mt-3 text-sm font-semibold" style={{ color: 'rgba(0,0,0,0.7)' }}>
            {t('dailyCheckin.today.openedTitle')}
          </Text>
          <View className="mt-2">
            <DailyCheckinRewardList items={status.todayResult ?? slot?.items ?? []} />
          </View>
          {status.slot < status.slotCount && (
            <Text className="mt-3 text-center text-xs" style={{ color: TEXT_SECONDARY }}>
              {t('dailyCheckin.today.comeBack', { slot: status.slot + 1 })}
            </Text>
          )}
        </>
      );
  }

  return (
    <View>
      <View className="flex-row flex-wrap items-center gap-2">
        <Text className="text-base font-bold" style={{ color: TEXT_PRIMARY }}>
          {t('dailyCheckin.today.heading', { slot: status.slot })}
        </Text>
        {box === DAILY_CHECKIN_BOX.big && <Badge label={t('dailyCheckin.today.bigBadge')} />}
        {slot?.requireVip === true && <Badge label={t('dailyCheckin.today.vipBadge')} icon />}
      </View>
      {body}
    </View>
  );
}

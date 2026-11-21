import { useEffect, useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Animated, Easing, Image, Text, View } from 'react-native';
import { DAILY_CHECKIN_BOX, DAILY_CHECKIN_SLOT_STATUS } from '@ola/shared/constants';
import { dailyCheckinBestReward, dailyCheckinDayLabel, dailyCheckinSlotHint } from '@ola/shared/lib';
import type { DailyCheckinNotice, DailyCheckinOpened, DailyCheckinSlot } from '@ola/shared/types';
import { DialogButton } from '@components/ui/Dialog';
import { TEXT_FAINT, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { CHECKIN_GOLD_INK, CHECKIN_GOLD_SOFT, CHECKIN_SHAKE_MS } from '../constants';
import { DAILY_CHECKIN_IMAGES } from '../dailyCheckinAssets';
import { boxImage } from '../utils';
import { DailyCheckinRewardImage } from './DailyCheckinRewardImage';
import { DailyCheckinRewardList } from './DailyCheckinRewardList';

export function DailyCheckinCard({ children, footer }: { children: ReactNode; footer?: ReactNode }) {
  return (
    <View
      className="w-full overflow-hidden bg-white"
      style={{ borderRadius: 16, shadowColor: '#000', shadowOpacity: 0.3, shadowRadius: 20, shadowOffset: { width: 0, height: 6 }, elevation: 8 }}
    >
      <View className="px-4 pb-2 pt-4">{children}</View>
      {footer != null && <View className="flex-row gap-2 px-3 pb-3">{footer}</View>}
    </View>
  );
}

export function DailyCheckinSlotPanel({ slot, onClose }: { slot: DailyCheckinSlot; onClose: () => void }) {
  const { t } = useTranslation();
  const hasBox = slot.box !== DAILY_CHECKIN_BOX.none;
  const claimed = slot.status === DAILY_CHECKIN_SLOT_STATUS.claimed;
  const missed = slot.status === DAILY_CHECKIN_SLOT_STATUS.missed;
  const title = !hasBox
    ? t('dailyCheckin.slot.title', { slot: slot.slot })
    : slot.box === DAILY_CHECKIN_BOX.big
      ? t('dailyCheckin.slot.bigTitle')
      : t('dailyCheckin.slot.secretTitle');
  return (
    <DailyCheckinCard footer={<DialogButton onPress={onClose}>{t('dailyCheckin.actions.close')}</DialogButton>}>
      <View className="items-center">
        <Text className="text-sm font-semibold" style={{ color: TEXT_SECONDARY }}>
          {t('dailyCheckin.slot.title', { slot: slot.slot })}
        </Text>
        {hasBox && !claimed && (
          <Image source={boxImage(slot.box, missed)} style={{ width: 80, height: 80, marginTop: 8 }} resizeMode="contain" />
        )}
        {!claimed && (
          <Text className="mt-2 text-base font-bold" style={{ color: TEXT_PRIMARY }}>
            {title}
          </Text>
        )}
        <Text className="mt-1 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
          {dailyCheckinSlotHint(t, slot)}
        </Text>
        {slot.requireVip && hasBox && !claimed && (
          <View className="mt-2 flex-row items-center gap-1">
            <Image source={DAILY_CHECKIN_IMAGES.vipBadge} style={{ width: 16, height: 16 }} resizeMode="contain" />
            <Text className="text-sm font-semibold" style={{ color: CHECKIN_GOLD_INK }}>
              {t('dailyCheckin.slot.vip')}
            </Text>
          </View>
        )}
        {claimed && slot.items != null && (
          <View className="mt-3 w-full">
            <DailyCheckinRewardList items={slot.items} />
          </View>
        )}
        {slot.checkedInOn != null && (
          <Text className="mt-3 text-xs" style={{ color: TEXT_FAINT }}>
            {t('dailyCheckin.slot.checkedInOn', { date: dailyCheckinDayLabel(slot.checkedInOn) })}
          </Text>
        )}
      </View>
    </DailyCheckinCard>
  );
}

export function DailyCheckinOpenedPanel({ opened, onClose }: { opened: DailyCheckinOpened; onClose: () => void }) {
  const { t } = useTranslation();
  const [revealed, setRevealed] = useState(false);
  const shake = useRef(new Animated.Value(0)).current;
  const burst = useRef(new Animated.Value(0)).current;
  const best = dailyCheckinBestReward(opened.items);
  const big = opened.box === DAILY_CHECKIN_BOX.big;

  useEffect(() => {
    const animation = Animated.sequence([
      Animated.timing(shake, { toValue: 1, duration: CHECKIN_SHAKE_MS, easing: Easing.linear, useNativeDriver: true }),
    ]);
    animation.start(({ finished }) => {
      if (!finished) return;
      setRevealed(true);
      Animated.spring(burst, { toValue: 1, friction: 5, tension: 120, useNativeDriver: true }).start();
    });
    return () => animation.stop();
  }, [shake, burst]);

  const rotate = shake.interpolate({
    inputRange: [0, 0.15, 0.3, 0.45, 0.6, 0.8, 1],
    outputRange: ['0deg', '-9deg', '8deg', '-7deg', '6deg', '-3deg', '0deg'],
  });
  const burstScale = burst.interpolate({ inputRange: [0, 1], outputRange: [0.4, 1] });

  return (
    <DailyCheckinCard
      footer={
        <DialogButton variant="green" disabled={!revealed} onPress={onClose}>
          {t('dailyCheckin.actions.great')}
        </DialogButton>
      }
    >
      <View className="items-center">
        <View className="h-28 w-28 items-center justify-center rounded-full" style={{ backgroundColor: CHECKIN_GOLD_SOFT }}>
          {revealed && best != null ? (
            <Animated.View style={{ transform: [{ scale: burstScale }], opacity: burst }}>
              <DailyCheckinRewardImage reward={best} size={80} />
            </Animated.View>
          ) : (
            <Animated.Image source={boxImage(opened.box)} style={{ width: 80, height: 80, transform: [{ rotate }] }} resizeMode="contain" />
          )}
        </View>
        <Text className="mt-2 text-lg font-bold" style={{ color: TEXT_PRIMARY }}>
          {big ? t('dailyCheckin.opened.titleBig', { slot: opened.slot }) : t('dailyCheckin.opened.title', { slot: opened.slot })}
        </Text>
        {revealed && (
          <>
            <Text className="mt-1 text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('dailyCheckin.opened.subtitle')}
            </Text>
            <View className="mt-3 w-full">
              <DailyCheckinRewardList items={opened.items} />
            </View>
          </>
        )}
      </View>
    </DailyCheckinCard>
  );
}

interface DailyCheckinNoticePanelProps {
  notice: DailyCheckinNotice;
  onClose: () => void;
  onVerifyEmail: () => void;
}

export function DailyCheckinNoticePanel({ notice, onClose, onVerifyEmail }: DailyCheckinNoticePanelProps) {
  const { t } = useTranslation();
  if (notice === 'vipRequired') {
    return (
      <DailyCheckinCard footer={<DialogButton onPress={onClose}>{t('dailyCheckin.actions.close')}</DialogButton>}>
        <View className="items-center">
          <Image source={DAILY_CHECKIN_IMAGES.vipBadge} style={{ width: 56, height: 56 }} resizeMode="contain" />
          <Text className="mt-2 text-base font-bold" style={{ color: TEXT_PRIMARY }}>
            {t('dailyCheckin.vipDialog.title')}
          </Text>
          <Text className="mt-1 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
            {t('dailyCheckin.vipDialog.message')}
          </Text>
        </View>
      </DailyCheckinCard>
    );
  }
  return (
    <DailyCheckinCard
      footer={
        <>
          <DialogButton onPress={onClose}>{t('dailyCheckin.actions.close')}</DialogButton>
          <DialogButton variant="green" onPress={onVerifyEmail}>
            {t('dailyCheckin.actions.verifyEmail')}
          </DialogButton>
        </>
      }
    >
      <Text className="text-base font-bold" style={{ color: TEXT_PRIMARY }}>
        {t('dailyCheckin.emailDialog.title')}
      </Text>
      <Text className="mt-1 text-sm" style={{ color: TEXT_PRIMARY }}>
        {t('dailyCheckin.emailDialog.message')}
      </Text>
      <Text className="mt-1 text-sm" style={{ color: TEXT_SECONDARY }}>
        {t('dailyCheckin.today.emailGuide')}
      </Text>
    </DailyCheckinCard>
  );
}

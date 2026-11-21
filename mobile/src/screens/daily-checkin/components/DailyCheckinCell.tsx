import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Animated, Easing, Image, Pressable, Text, View, type ImageSourcePropType } from 'react-native';
import { DAILY_CHECKIN_BOX, DAILY_CHECKIN_SLOT_STATUS } from '@ola/shared/constants';
import type { DailyCheckinSlot } from '@ola/shared/types';
import { ItemGrantIcon } from '@components/ui/ItemGrantMarks';
import { TEXT_FAINT, TEXT_SECONDARY, WARNING } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { CHECKIN_WIGGLE_MS, CHECKIN_WIGGLE_REST_MS } from '../constants';
import { boxImage, cellToneStyle, openedBoxImage } from '../utils';

interface DailyCheckinCellProps {
  slot: DailyCheckinSlot;
  size: number;
  onSelect: (slot: DailyCheckinSlot) => void;
}

const STATUS = DAILY_CHECKIN_SLOT_STATUS;
const BADGE = { position: 'absolute', top: -5, right: -5, width: 18, height: 18, borderRadius: 9, alignItems: 'center', justifyContent: 'center' } as const;

function CellBadge({ slot }: { slot: DailyCheckinSlot }) {
  const colors = useThemeColors();
  if (slot.status === STATUS.claimed || slot.status === STATUS.none) {
    return (
      <View style={[BADGE, { backgroundColor: colors.primary }]}>
        <Text style={{ color: '#ffffff', fontSize: 11, fontWeight: '700' }}>✓</Text>
      </View>
    );
  }
  if (slot.status === STATUS.missed) {
    return (
      <View style={[BADGE, { backgroundColor: 'rgba(0,0,0,0.35)' }]}>
        <Text style={{ color: '#ffffff', fontSize: 10, fontWeight: '700' }}>✕</Text>
      </View>
    );
  }
  if (slot.status === STATUS.pending) {
    return (
      <View style={[BADGE, { backgroundColor: WARNING }]}>
        <Text style={{ color: '#ffffff', fontSize: 10, fontWeight: '700' }}>…</Text>
      </View>
    );
  }
  if (slot.status === STATUS.outOfReach) {
    return (
      <View style={{ position: 'absolute', right: 3, bottom: 3 }}>
        <ItemGrantIcon kind="lock" size={12} />
      </View>
    );
  }
  return null;
}

function WigglingBox({ source, size }: { source: ImageSourcePropType; size: number }) {
  const progress = useRef(new Animated.Value(0)).current;
  useEffect(() => {
    const loop = Animated.loop(
      Animated.sequence([
        Animated.timing(progress, { toValue: 1, duration: CHECKIN_WIGGLE_MS, easing: Easing.linear, useNativeDriver: true }),
        Animated.delay(CHECKIN_WIGGLE_REST_MS),
      ]),
    );
    loop.start();
    return () => loop.stop();
  }, [progress]);
  const rotate = progress.interpolate({
    inputRange: [0, 0.17, 0.33, 0.5, 0.67, 0.83, 1],
    outputRange: ['0deg', '-10deg', '9deg', '-7deg', '5deg', '-2deg', '0deg'],
  });
  return (
    <Animated.Image
      source={source}
      style={{ width: size, height: size, transformOrigin: 'bottom', transform: [{ rotate }] }}
      resizeMode="contain"
    />
  );
}

export function DailyCheckinCell({ slot, size, onSelect }: DailyCheckinCellProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const hasBox = slot.box !== DAILY_CHECKIN_BOX.none;
  const opened = slot.status === STATUS.claimed;
  const missed = slot.status === STATUS.missed;
  const dimmed = slot.status === STATUS.outOfReach;
  const checked = opened || slot.status === STATUS.none;
  const waiting = slot.status === STATUS.today || slot.status === STATUS.pending;
  const boxSize = Math.round(size * (slot.box === DAILY_CHECKIN_BOX.big ? 0.72 : 0.58));

  return (
    <Pressable
      onPress={() => onSelect(slot)}
      accessibilityLabel={t('dailyCheckin.slot.title', { slot: slot.slot })}
      className="items-center justify-center active:opacity-80"
      style={[{ width: size, height: size, borderRadius: 8 }, cellToneStyle(slot, colors)]}
    >
      {hasBox && (
        <Text style={{ position: 'absolute', left: 4, top: 1, fontSize: 9, fontWeight: '600', color: 'rgba(0,0,0,0.45)' }}>
          {slot.slot}
        </Text>
      )}
      {hasBox && waiting ? (
        <WigglingBox source={boxImage(slot.box)} size={boxSize} />
      ) : hasBox ? (
        <Image
          source={opened ? openedBoxImage(slot.box) : boxImage(slot.box, missed)}
          style={{ width: boxSize, height: boxSize, opacity: dimmed ? 0.4 : 1 }}
          resizeMode="contain"
        />
      ) : (
        <Text
          className="text-base font-bold"
          style={{ color: checked ? colors.primaryDark : slot.status === STATUS.outOfReach ? TEXT_FAINT : TEXT_SECONDARY }}
        >
          {slot.slot}
        </Text>
      )}
      <CellBadge slot={slot} />
    </Pressable>
  );
}

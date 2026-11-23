import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { DAILY_CHECKIN_BOX, DAILY_CHECKIN_SLOT_STATUS } from '@ola/shared/constants';
import type { DailyCheckinSlot } from '@ola/shared/types';
import { TEXT_SECONDARY, WARNING } from '@constants';
import { DAILY_CHECKIN_IMAGES } from '../dailyCheckinAssets';
import { useThemeColors } from '@hooks/useThemeColors';
import { boxImage, cellToneStyle, openedBoxImage } from '../utils';
import { WigglingImage } from './WigglingImage';

interface DailyCheckinCellProps {
  slot: DailyCheckinSlot;
  size: number;
  onSelect: (slot: DailyCheckinSlot) => void;
}

const STATUS = DAILY_CHECKIN_SLOT_STATUS;
const BADGE = { position: 'absolute', top: -5, right: -5, width: 18, height: 18, borderRadius: 9, alignItems: 'center', justifyContent: 'center' } as const;
const TASK_BADGE = { top: -6, right: -6, width: 20, height: 20, borderRadius: 10, borderWidth: 1, borderColor: WARNING, backgroundColor: '#ffffff' } as const;

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
      <View style={[BADGE, TASK_BADGE]}>
        <Image source={DAILY_CHECKIN_IMAGES.task} style={{ width: 14, height: 14 }} resizeMode="contain" />
      </View>
    );
  }
  return null;
}

export function DailyCheckinCell({ slot, size, onSelect }: DailyCheckinCellProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const hasBox = slot.box !== DAILY_CHECKIN_BOX.none;
  const opened = slot.status === STATUS.claimed;
  const missed = slot.status === STATUS.missed;
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
        <WigglingImage source={boxImage(slot.box)} size={boxSize} />
      ) : hasBox ? (
        <Image
          source={opened ? openedBoxImage(slot.box) : boxImage(slot.box, missed)}
          style={{ width: boxSize, height: boxSize }}
          resizeMode="contain"
        />
      ) : (
        <Text
          className="text-sm font-bold"
          style={{ color: checked ? colors.primaryDark : TEXT_SECONDARY }}
        >
          {slot.slot}
        </Text>
      )}
      <CellBadge slot={slot} />
    </Pressable>
  );
}

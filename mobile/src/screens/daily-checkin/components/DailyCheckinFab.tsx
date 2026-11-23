import { useTranslation } from 'react-i18next';
import { Pressable, Text, View, type ViewStyle } from 'react-native';
import Svg, { Path } from 'react-native-svg';
import { useDailyCheckinFab } from '@ola/shared/stores/daily-checkin/useDailyCheckinFab';
import { ERROR, WARNING } from '@constants';
import { DAILY_CHECKIN_IMAGES } from '../dailyCheckinAssets';
import { WigglingImage } from './WigglingImage';

const FAB_SIZE = 56;
const CLOSE_SIZE = 22;

export function DailyCheckinFab({ style }: { style?: ViewStyle }) {
  const { t } = useTranslation();
  const { kind, open, hide } = useDailyCheckinFab();
  if (kind == null) return null;
  const label = t(`dailyCheckin.fab.${kind}`);

  return (
    <View style={[{ position: 'absolute', width: FAB_SIZE, height: FAB_SIZE }, style]}>
      <Pressable
        onPress={open}
        accessibilityLabel={label}
        className="items-center justify-center active:opacity-80"
        style={{
          width: FAB_SIZE,
          height: FAB_SIZE,
          borderRadius: FAB_SIZE / 2,
          backgroundColor: '#ffffff',
          borderWidth: 2,
          borderColor: '#ffcdd2',
          elevation: 4,
          shadowColor: '#000',
          shadowOpacity: 0.25,
          shadowRadius: 4,
          shadowOffset: { width: 0, height: 2 },
        }}
      >
        <WigglingImage source={DAILY_CHECKIN_IMAGES.menu} size={40} />
      </Pressable>
      <View
        pointerEvents="none"
        style={{ position: 'absolute', left: -20, right: -20, bottom: -8, alignItems: 'center' }}
      >
        <View
          style={{
            backgroundColor: kind === 'checkin' ? ERROR : WARNING,
            borderRadius: 999,
            borderWidth: 1.5,
            borderColor: '#ffffff',
            paddingHorizontal: 8,
            paddingVertical: 1,
          }}
        >
          <Text numberOfLines={1} style={{ color: '#ffffff', fontSize: 10.5, fontWeight: '700' }}>
            {label}
          </Text>
        </View>
      </View>
      <Pressable
        onPress={hide}
        accessibilityLabel={t('dailyCheckin.fab.hide')}
        hitSlop={8}
        className="items-center justify-center"
        style={{
          position: 'absolute',
          top: -6,
          right: -6,
          width: CLOSE_SIZE,
          height: CLOSE_SIZE,
          borderRadius: CLOSE_SIZE / 2,
          backgroundColor: '#ffffff',
          borderWidth: 1,
          borderColor: 'rgba(0,0,0,0.1)',
          elevation: 3,
          shadowColor: '#000',
          shadowOpacity: 0.18,
          shadowRadius: 2,
          shadowOffset: { width: 0, height: 1 },
        }}
      >
        <Svg width={9} height={9} viewBox="0 0 10 10">
          <Path d="M1.5 1.5l7 7M8.5 1.5l-7 7" stroke="rgba(0,0,0,0.45)" strokeWidth={1.8} strokeLinecap="round" />
        </Svg>
      </Pressable>
    </View>
  );
}

import { useTranslation } from 'react-i18next';
import {
  Image,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  View,
  useWindowDimensions,
} from 'react-native';
import { OlaModal } from '@components/ui/OlaModal';
import { formatKen } from '@ola/shared/lib';
import type { WheelPlayerOption, WheelPlayerSegment } from '@ola/shared/types';
import { VipIconImage } from '@screens/vip/components/VipIconImage';
import { assetRatio } from '@screens/games/pen/penUi';
import { wheelAssets, wheelGiftListAssets } from './spinWheelAssets';
import { giftOptionVisual } from './spinWheelReward';
import {
  GIFT_AMOUNT_STYLE,
  GIFT_SUBTITLE_STYLE,
  GIFT_TITLE_STYLE,
  TEXT_SHADOW,
} from './spinWheelStyles';

const GOLD = '#ffd24a';

const CARD_STYLE = {
  borderRadius: 16,
  borderWidth: 2,
  borderColor: GOLD,
  backgroundColor: '#3457c4',
} as const;

const CLOSE_SIZE = 44;
const CLOSE_OVERHANG = 10;
const WHEEL_ICON_SIZE = 48;

interface GiftListDialogProps {
  segments: WheelPlayerSegment[];
  onClose: () => void;
}

function KenRandomCard({ segment }: { segment: WheelPlayerSegment }) {
  const { t } = useTranslation();
  return (
    <View
      style={{
        ...CARD_STYLE,
        flexDirection: 'row',
        alignItems: 'center',
        gap: 12,
        paddingHorizontal: 12,
        paddingVertical: 12,
      }}
    >
      <Image source={wheelAssets.spinCoin} style={{ width: 64, height: 64 }} resizeMode="contain" />
      <View style={{ flex: 1, alignItems: 'center', gap: 4 }}>
        <Text
          numberOfLines={1}
          style={[
            { fontSize: 18, fontWeight: '800', color: '#ffffff', textTransform: 'uppercase' },
            TEXT_SHADOW,
          ]}
        >
          {t('wheelGame.kenRandomTitle')}
        </Text>
        <Text
          numberOfLines={1}
          adjustsFontSizeToFit
          minimumFontScale={0.7}
          style={[{ fontSize: 20, fontWeight: '800' }, GIFT_AMOUNT_STYLE]}
        >
          {t('wheelGame.kenRange', {
            min: formatKen(segment.kenMin ?? 0),
            max: formatKen(segment.kenMax ?? 0),
          })}
        </Text>
      </View>
    </View>
  );
}

function GiftOptionCell({ option }: { option: WheelPlayerOption }) {
  const { t } = useTranslation();
  const visual = giftOptionVisual(t, option);
  return (
    <View
      style={{
        ...CARD_STYLE,
        flexGrow: 1,
        flexBasis: '47%',
        minHeight: 64,
        flexDirection: 'row',
        alignItems: 'center',
        gap: 8,
        paddingHorizontal: 8,
        paddingVertical: 8,
      }}
    >
      <View
        style={{
          width: 48,
          height: 48,
          borderRadius: 24,
          borderWidth: 2,
          borderColor: GOLD,
          backgroundColor: '#26409e',
          alignItems: 'center',
          justifyContent: 'center',
          overflow: 'hidden',
        }}
      >
        {visual.vipTypeId != null ? (
          <VipIconImage typeId={visual.vipTypeId} size={44} rounded />
        ) : visual.icon != null ? (
          <Image source={visual.icon} style={{ width: 34, height: 34 }} resizeMode="contain" />
        ) : null}
      </View>
      <Text
        style={[
          { flex: 1, textAlign: 'center', fontSize: 13, fontWeight: '800', color: '#ffffff' },
          TEXT_SHADOW,
        ]}
      >
        {visual.text}
      </Text>
    </View>
  );
}

function VipRandomSection({ segment }: { segment: WheelPlayerSegment }) {
  const { t } = useTranslation();
  const options = segment.options ?? [];
  return (
    <View style={{ alignItems: 'center', gap: 10 }}>
      <View
        style={{
          borderRadius: 999,
          borderWidth: 2,
          borderColor: GOLD,
          backgroundColor: '#1ec9a0',
          paddingHorizontal: 32,
          paddingVertical: 6,
        }}
      >
        <Text
          style={[
            { fontSize: 16, fontWeight: '800', color: '#ffffff', textTransform: 'uppercase' },
            TEXT_SHADOW,
          ]}
        >
          {t('wheelGame.vipRandomTitle')}
        </Text>
      </View>
      <View style={{ width: '100%', flexDirection: 'row', flexWrap: 'wrap', gap: 10 }}>
        {options.map((option, index) => (
          <GiftOptionCell key={`${segment.id}-${index}`} option={option} />
        ))}
      </View>
    </View>
  );
}

function GiftListHeader() {
  const { t } = useTranslation();
  return (
    <View
      style={{
        borderRadius: 16,
        borderWidth: 2,
        borderColor: GOLD,
        paddingHorizontal: WHEEL_ICON_SIZE + 8,
        paddingVertical: 10,
        alignItems: 'center',
      }}
    >
      <Image
        source={wheelAssets.wheelIcon}
        style={{
          position: 'absolute',
          left: 4,
          top: '50%',
          marginTop: -WHEEL_ICON_SIZE / 2,
          width: WHEEL_ICON_SIZE,
          height: WHEEL_ICON_SIZE,
        }}
        resizeMode="contain"
      />
      <Text
        numberOfLines={1}
        adjustsFontSizeToFit
        minimumFontScale={0.7}
        style={[{ fontSize: 20, fontWeight: '800' }, GIFT_TITLE_STYLE]}
      >
        {t('wheelGame.giftListTitle')}
      </Text>
      <Text
        numberOfLines={1}
        adjustsFontSizeToFit
        minimumFontScale={0.7}
        style={[{ fontSize: 10, fontWeight: '800' }, GIFT_SUBTITLE_STYLE]}
      >
        {t('wheelGame.giftListSubtitle')}
      </Text>
      <Image
        source={wheelAssets.wheelIcon}
        style={{
          position: 'absolute',
          right: 4,
          top: '50%',
          marginTop: -WHEEL_ICON_SIZE / 2,
          width: WHEEL_ICON_SIZE,
          height: WHEEL_ICON_SIZE,
        }}
        resizeMode="contain"
      />
    </View>
  );
}

export function GiftListDialog({ segments, onClose }: GiftListDialogProps) {
  const { t } = useTranslation();
  const { width: windowWidth, height: windowHeight } = useWindowDimensions();

  const randomSegments = segments.filter(
    (segment) =>
      segment.kind === 'ken_random' ||
      (segment.kind === 'vip_random' && (segment.options?.length ?? 0) > 0)
  );

  const panelWidth = Math.min(windowWidth - 24, 420) - CLOSE_OVERHANG;
  const closeMarkWidth = CLOSE_SIZE * 0.42;
  const closeMarkHeight = closeMarkWidth / assetRatio(wheelGiftListAssets.closeMark);

  return (
    <OlaModal transparent animationType="fade" visible onRequestClose={onClose}>
      <View
        style={{
          flex: 1,
          alignItems: 'center',
          justifyContent: 'center',
          backgroundColor: 'rgba(0,0,0,0.55)',
          paddingHorizontal: 12,
        }}
      >
        <Pressable style={StyleSheet.absoluteFill} onPress={onClose} />
        <View
          style={{
            maxHeight: windowHeight * 0.86,
            paddingTop: CLOSE_OVERHANG,
            paddingRight: CLOSE_OVERHANG,
          }}
        >
          <View
            style={{
              width: panelWidth,
              flexShrink: 1,
              borderRadius: 28,
              borderWidth: 3,
              borderColor: GOLD,
              backgroundColor: '#3555c6',
              padding: 12,
              gap: 12,
            }}
          >
            <GiftListHeader />

            {randomSegments.length === 0 ? (
              <Text
                style={[
                  {
                    paddingVertical: 40,
                    textAlign: 'center',
                    fontSize: 14,
                    fontWeight: '700',
                    color: '#ffffff',
                  },
                  TEXT_SHADOW,
                ]}
              >
                {t('wheelGame.giftListEmpty')}
              </Text>
            ) : (
              <ScrollView
                style={{ flexShrink: 1 }}
                contentContainerStyle={{ gap: 12 }}
                indicatorStyle="white"
              >
                {randomSegments.map((segment) =>
                  segment.kind === 'ken_random' ? (
                    <KenRandomCard key={segment.id} segment={segment} />
                  ) : (
                    <VipRandomSection key={segment.id} segment={segment} />
                  )
                )}
              </ScrollView>
            )}
          </View>

          <Pressable
            accessibilityLabel={t('wheelGame.close')}
            onPress={onClose}
            style={{
              position: 'absolute',
              right: 0,
              top: 0,
              width: CLOSE_SIZE,
              height: CLOSE_SIZE,
            }}
          >
            <Image
              source={wheelGiftListAssets.closeButton}
              style={{
                position: 'absolute',
                left: 0,
                top: 0,
                width: CLOSE_SIZE,
                height: CLOSE_SIZE,
              }}
              resizeMode="contain"
            />
            <Image
              source={wheelGiftListAssets.closeMark}
              style={{
                position: 'absolute',
                left: (CLOSE_SIZE - closeMarkWidth) / 2,
                top: (CLOSE_SIZE - closeMarkHeight) / 2,
                width: closeMarkWidth,
                height: closeMarkHeight,
              }}
              resizeMode="contain"
            />
          </Pressable>
        </View>
      </View>
    </OlaModal>
  );
}

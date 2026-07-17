import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Image,
  Modal,
  Pressable,
  StyleSheet,
  Text,
  View,
  useWindowDimensions,
  type ImageSourcePropType,
} from 'react-native';
import type { WheelSpinResult } from '@ola/shared/types';
import { VipIconImage } from '@screens/vip/components/VipIconImage';
import { assetRatio } from '@screens/games/pen/penUi';
import { wheelAssets } from './spinWheelAssets';
import { formatRewardKen, isKenKind, isVipDaysKind } from './spinWheelReward';

const REWARD_ICON_SIZE = 96;

interface ResolvedReward {
  icon: ReactNode;
  label: string;
  labelSize: number;
}

interface SpinResultDialogProps {
  result: WheelSpinResult;
  onClose: () => void;
}

function RewardIconImage({ source }: { source: ImageSourcePropType }) {
  return (
    <Image
      source={source}
      style={{ width: REWARD_ICON_SIZE, height: REWARD_ICON_SIZE }}
      resizeMode="contain"
    />
  );
}

export function SpinResultDialog({ result, onClose }: SpinResultDialogProps) {
  const { t } = useTranslation();
  const { width: windowWidth } = useWindowDimensions();

  const resolveReward = (): ResolvedReward => {
    if (!result.isWin) {
      return {
        icon: <RewardIconImage source={wheelAssets.rewardMiss} />,
        label: t('wheelGame.miss'),
        labelSize: 24,
      };
    }
    if (isKenKind(result.segmentKind)) {
      return {
        icon: <RewardIconImage source={wheelAssets.spinCoin} />,
        label: `${formatRewardKen(result.kenAmount ?? 0)} KEN`,
        labelSize: 24,
      };
    }
    if (isVipDaysKind(result.segmentKind)) {
      return {
        icon: <RewardIconImage source={wheelAssets.rewardVipDays} />,
        label: t('wheelGame.vipDays', { n: result.vipDays ?? 0 }),
        labelSize: 24,
      };
    }
    return {
      icon:
        typeof result.vipTypeId === 'number' ? (
          <VipIconImage typeId={result.vipTypeId} size={REWARD_ICON_SIZE} rounded />
        ) : (
          <RewardIconImage source={wheelAssets.rewardVipDays} />
        ),
      label: result.rewardLabel ?? t('wheelGame.rewardTitle'),
      labelSize: 16,
    };
  };

  const reward = resolveReward();
  const panelWidth = Math.min(320, windowWidth * 0.82);
  const panelHeight = (panelWidth * 1448) / 1086;
  const markWidth = 44 * 0.42;

  return (
    <Modal transparent animationType="fade" visible onRequestClose={onClose}>
      <View
        style={{
          flex: 1,
          alignItems: 'center',
          justifyContent: 'center',
          backgroundColor: 'rgba(0,0,0,0.55)',
          paddingHorizontal: 24,
        }}
      >
        <Pressable style={StyleSheet.absoluteFill} onPress={onClose} />
        <View style={{ width: panelWidth, height: panelHeight }}>
          <Image
            source={wheelAssets.resultPopupFrame}
            style={{ position: 'absolute', left: 0, top: 0, width: panelWidth, height: panelHeight }}
            resizeMode="stretch"
          />
          <Pressable
            accessibilityLabel={t('wheelGame.close')}
            onPress={onClose}
            style={{
              position: 'absolute',
              right: panelWidth * 0.01,
              top: panelHeight * 0.04,
              width: 44,
              height: 44,
              zIndex: 10,
            }}
          >
            <Image
              source={wheelAssets.resultCloseFrame}
              style={{ position: 'absolute', left: 0, top: 0, width: 44, height: 44 }}
              resizeMode="contain"
            />
            <Image
              source={wheelAssets.resultCloseMark}
              style={{
                position: 'absolute',
                left: (44 - markWidth) / 2,
                top: (44 - markWidth / assetRatio(wheelAssets.resultCloseMark)) / 2,
                width: markWidth,
                height: markWidth / assetRatio(wheelAssets.resultCloseMark),
              }}
              resizeMode="contain"
            />
          </Pressable>
          <View
            style={{
              position: 'absolute',
              left: 0,
              right: 0,
              top: panelHeight * 0.19,
              paddingHorizontal: 40,
            }}
          >
            <Text
              style={{
                textAlign: 'center',
                fontSize: 20,
                lineHeight: 25,
                fontWeight: '800',
                textTransform: 'uppercase',
                color: '#e0348b',
              }}
            >
              {result.isWin ? t('wheelGame.rewardTitle') : t('wheelGame.missTitle')}
            </Text>
          </View>
          <View
            style={{
              position: 'absolute',
              left: 0,
              right: 0,
              top: panelHeight * 0.45,
              alignItems: 'center',
              gap: 8,
              paddingHorizontal: 32,
            }}
          >
            {reward.icon}
            <Text
              numberOfLines={2}
              style={{
                textAlign: 'center',
                fontSize: reward.labelSize,
                fontWeight: '800',
                color: '#e0348b',
              }}
            >
              {reward.label}
            </Text>
          </View>
        </View>
      </View>
    </Modal>
  );
}

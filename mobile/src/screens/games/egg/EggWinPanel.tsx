import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Animated, Easing, Image, Pressable, Text, View } from 'react-native';
import type { EggDrawResult } from '@ola/shared/types';
import { useEggGameStore } from '@ola/shared/stores/eggGameStore';
import { VipIconImage } from '@screens/vip/components/VipIconImage';
import { eggAssets } from './eggAssets';

const CARD_H = 250;
const BTN_H = 42;
const ICON_BOX = 88;
const APPEAR_MS = 220;

interface EggWinPanelProps {
  result: EggDrawResult;
  width: number;
  height: number;
}

function RewardIcon({ result }: { result: EggDrawResult }) {
  if (result.categoryType === 'ken') {
    return (
      <Image
        source={eggAssets.kenCoin}
        style={{ width: ICON_BOX, height: ICON_BOX }}
        resizeMode="contain"
      />
    );
  }
  if (result.categoryType === 'vip_days') {
    return (
      <Image
        source={eggAssets.vipDays}
        style={{ width: ICON_BOX, height: ICON_BOX }}
        resizeMode="contain"
      />
    );
  }
  if (result.vipTypeId != null) {
    return <VipIconImage typeId={result.vipTypeId} size={ICON_BOX} rounded />;
  }
  return null;
}

export function EggWinPanel({ result, width, height }: EggWinPanelProps) {
  const { t } = useTranslation();
  const closeWin = useEggGameStore((s) => s.closeWin);
  const scale = useRef(new Animated.Value(0.8)).current;

  useEffect(() => {
    Animated.timing(scale, {
      toValue: 1,
      duration: APPEAR_MS,
      easing: Easing.out(Easing.cubic),
      useNativeDriver: true,
    }).start();
  }, [scale]);

  const cardW = Math.min(300, width - 40);
  const btnW = cardW - 44;

  const title = result.isSuperLucky ? t('eggGame.winModal.superTitle') : t('eggGame.winModal.title');
  const label =
    result.categoryType === 'ken' && result.kenAmount
      ? t('eggGame.winModal.ken', { ken: result.kenAmount })
      : result.categoryType === 'vip_days' && result.vipDays
        ? t('eggGame.winModal.vipDays', { days: result.vipDays })
        : (result.rewardLabel ?? t('eggGame.winModal.defaultLabel'));

  return (
    <View
      style={{
        position: 'absolute',
        left: 0,
        top: 0,
        width,
        height,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: 'rgba(0,0,0,0.22)',
      }}
    >
      <Animated.View
        style={{
          width: cardW,
          height: CARD_H,
          borderRadius: 18,
          borderWidth: 2,
          borderColor: '#ffe0a3',
          backgroundColor: '#ffffff',
          alignItems: 'center',
          transform: [{ scale }],
        }}
      >
        <View
          style={{
            position: 'absolute',
            left: 0,
            right: 0,
            top: 32 - 12,
            alignItems: 'center',
          }}
        >
          <Text style={{ fontSize: 20, fontWeight: '700', color: '#5e3c20', textAlign: 'center' }}>
            {title}
          </Text>
        </View>
        <View
          style={{
            position: 'absolute',
            left: 0,
            right: 0,
            top: 112 - ICON_BOX / 2,
            alignItems: 'center',
          }}
        >
          <RewardIcon result={result} />
        </View>
        <View
          style={{
            position: 'absolute',
            left: 18,
            right: 18,
            top: 176 - 22,
            alignItems: 'center',
          }}
        >
          <Text
            numberOfLines={2}
            style={{ fontSize: 18, fontWeight: '700', color: '#1f8a3b', textAlign: 'center' }}
          >
            {label}
          </Text>
        </View>
        <Pressable
          onPress={closeWin}
          style={{
            position: 'absolute',
            bottom: 34 - BTN_H / 2,
            width: btnW,
            height: BTN_H,
            borderRadius: BTN_H / 2,
            backgroundColor: '#7cb342',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          <Text style={{ fontSize: 16, fontWeight: '700', color: '#ffffff' }}>
            {t('eggGame.winModal.ok')}
          </Text>
        </Pressable>
      </Animated.View>
    </View>
  );
}

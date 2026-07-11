import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, TextInput, View, useWindowDimensions } from 'react-native';
import { formatVnd } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { PenSide } from '@ola/shared/types';
import { penAssets, penShootAssets } from './penAssets';
import {
  PenDirectionPicker,
  PenKenRow,
  PenModalActions,
  PenModalShell,
  penPickerWidth,
  type PenDirLayout,
} from './penModalParts';
import { PEN_COLORS } from './penUi';

const QUICK_BETS = [1000, 2000, 5000, 10000, 20000, 50000, 100000, 200000, 500000];

const SHOOT_DIR_LAYOUT: PenDirLayout = {
  buttonAspect: 1116 / 1332,
  arrowTop: 0.44,
  arrowWidth: 0.82,
  arrowInset: 0.05,
  centerTop: 0.48,
  centerWidth: 0.33,
  centerInset: 0.05,
  markBottom: 0.04,
  markWidth: 0.23,
  tabAspect: 1319 / 400,
  tabWidth: 0.5,
};

interface PenShootModalProps {
  ken: number;
  amount: number;
  submitting?: boolean;
  onTopUp: () => void;
  onConfirm: (payload: { side: PenSide; betAmount: number }) => void;
  onClose: () => void;
}

export function PenShootModal({
  ken,
  amount,
  submitting,
  onTopUp,
  onConfirm,
  onClose,
}: PenShootModalProps) {
  const { t } = useTranslation();
  const { width: windowWidth } = useWindowDimensions();
  const push = useToastStore((s) => s.push);
  const [direction, setDirection] = useState<PenSide | null>(null);
  const [thousands, setThousands] = useState(String(Math.floor(amount / 1000)));

  const betAmount = Number(thousands) * 1000;
  const overBalance = betAmount > ken;

  const handleConfirm = () => {
    if (!direction) {
      push('error', t('penGame.errChooseDirection'));
      return;
    }
    if (!betAmount || betAmount < 1000) {
      push('error', t('penGame.errBetMin'));
      return;
    }
    if (overBalance) {
      push('error', t('penGame.errInsufficientKen'));
      return;
    }
    onConfirm({ side: direction, betAmount });
  };

  return (
    <PenModalShell
      panelAspect={960 / 1639}
      titleIcon={penShootAssets.ball}
      title={t('penGame.shoot')}
      closeBtn={penShootAssets.closeBtn}
      closeIcon={penShootAssets.closeIcon}
      onClose={onClose}
    >
      <PenKenRow ken={ken} onTopUp={onTopUp} />

      <Text
        style={{
          marginTop: '3%',
          fontSize: 16,
          fontWeight: '600',
          color: 'rgba(255,255,255,0.9)',
        }}
      >
        {t('penGame.chooseDirection')}
      </Text>

      <PenDirectionPicker
        value={direction}
        onSelect={setDirection}
        selected={penShootAssets.dir.selected}
        unselected={penShootAssets.dir.unselected}
        center={{ left: penShootAssets.panelBall, right: penShootAssets.panelBall }}
        layout={SHOOT_DIR_LAYOUT}
        width={penPickerWidth(windowWidth)}
      />

      <Text
        style={{
          marginTop: '2%',
          fontSize: 16,
          fontWeight: '600',
          color: 'rgba(255,255,255,0.9)',
        }}
      >
        {t('penGame.kenAmount')}
      </Text>

      <View
        style={{
          marginTop: '2%',
          width: '72%',
          flexDirection: 'row',
          alignItems: 'center',
          gap: 8,
          borderRadius: 12,
          borderWidth: 1,
          borderColor: overBalance ? PEN_COLORS.red : 'rgba(255,255,255,0.15)',
          backgroundColor: 'rgba(0,0,0,0.2)',
          paddingHorizontal: 16,
          paddingVertical: 6,
        }}
      >
        <Image source={penAssets.kenIcon} style={{ width: 28, height: 28 }} resizeMode="contain" />
        <View
          style={{
            flex: 1,
            minWidth: 0,
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          <TextInput
            accessibilityLabel={t('penGame.kenAmount')}
            value={thousands === '' ? '' : formatVnd(Number(thousands))}
            onChangeText={(text) => setThousands(text.replace(/\D/g, ''))}
            keyboardType="number-pad"
            placeholder="0"
            placeholderTextColor="rgba(255,255,255,0.4)"
            style={{
              minWidth: 28,
              padding: 0,
              textAlign: 'right',
              fontSize: 24,
              fontWeight: '700',
              color: '#ffffff',
            }}
          />
          <Text style={{ fontSize: 24, fontWeight: '700', color: '#ffffff' }}>.000</Text>
        </View>
      </View>

      <View
        style={{
          marginTop: '2%',
          width: '88%',
          flexDirection: 'row',
          flexWrap: 'wrap',
          gap: 8,
        }}
      >
        {QUICK_BETS.map((bet) => {
          const active = betAmount === bet;
          const disabled = bet > ken;
          return (
            <Pressable
              key={bet}
              disabled={disabled}
              onPress={() => setThousands(String(bet / 1000))}
              style={({ pressed }) => [{
                flexBasis: '30%',
                flexGrow: 1,
                alignItems: 'center',
                borderRadius: 8,
                borderWidth: 1,
                paddingVertical: 4,
                borderColor: active ? '#8dffab' : 'rgba(255,255,255,0.15)',
                backgroundColor: active ? 'rgba(55,200,79,0.25)' : 'rgba(0,0,0,0.2)',
                opacity: disabled ? 0.35 : 1,
                transform: [{ scale: pressed ? 0.95 : 1 }],
              }]}
            >
              <Text
                style={{
                  fontSize: 14,
                  fontWeight: '700',
                  color: active ? '#ffffff' : 'rgba(255,255,255,0.8)',
                }}
              >
                {formatVnd(bet)}
              </Text>
            </Pressable>
          );
        })}
      </View>

      <PenModalActions
        style={{ marginTop: 'auto', paddingTop: '3%' }}
        cancelBg={penShootAssets.cancelBtn}
        confirmBg={penShootAssets.confirmBtn}
        onCancel={onClose}
        onConfirm={handleConfirm}
        confirmDisabled={submitting || overBalance}
      />
    </PenModalShell>
  );
}

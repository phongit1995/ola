import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Text, View } from 'react-native';
import { formatVnd } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { PenSide } from '@ola/shared/types';
import { penAssets, penCatchAssets } from './penAssets';
import {
  PenDirectionPicker,
  PenKenRow,
  PenModalActions,
  PenModalShell,
  type PenDirLayout,
} from './penModalParts';

const CATCH_DIR_LAYOUT: PenDirLayout = {
  buttonAspect: 1082 / 1220,
  arrowTop: '46%',
  arrowWidth: '56%',
  arrowInset: '2%',
  centerTop: '48%',
  centerWidth: '40%',
  centerInset: '4%',
  markBottom: '4%',
  markWidth: '22%',
  tabAspect: 1063 / 360,
  tabWidth: '50%',
};

interface PenCatchModalProps {
  ken: number;
  betAmount: number;
  submitting?: boolean;
  onTopUp: () => void;
  onConfirm: (side: PenSide) => void;
  onClose: () => void;
}

export function PenCatchModal({
  ken,
  betAmount,
  submitting,
  onTopUp,
  onConfirm,
  onClose,
}: PenCatchModalProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [direction, setDirection] = useState<PenSide | null>(null);

  const handleConfirm = () => {
    if (!direction) {
      push('error', t('penGame.errChooseCatchDirection'));
      return;
    }
    onConfirm(direction);
  };

  return (
    <PenModalShell
      panelAspect={943 / 1250}
      titleIcon={penCatchAssets.gloveEffect}
      titleIconHeight={56}
      title={t('penGame.catchTitle')}
      closeBtn={penCatchAssets.closeBtn}
      closeIcon={penCatchAssets.closeIcon}
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
        {t('penGame.chooseCatchDirection')}
      </Text>

      <PenDirectionPicker
        value={direction}
        onSelect={setDirection}
        selected={penCatchAssets.dir.selected}
        unselected={penCatchAssets.dir.unselected}
        center={{ left: penCatchAssets.gloveLeft, right: penCatchAssets.gloveRight }}
        layout={CATCH_DIR_LAYOUT}
      />

      <View style={{ marginTop: 'auto', alignItems: 'center', gap: 4, paddingTop: '4%' }}>
        <Text style={{ fontSize: 16, fontWeight: '600', color: 'rgba(255,255,255,0.9)' }}>
          {t('penGame.catchBet')}
        </Text>
        <View style={{ flexDirection: 'row', alignItems: 'center', gap: 8 }}>
          <Image source={penAssets.kenIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
          <Text style={{ fontSize: 24, fontWeight: '700', color: '#ffffff' }}>
            {formatVnd(betAmount)}
          </Text>
        </View>
      </View>

      <PenModalActions
        style={{ marginTop: '3%' }}
        cancelBg={penCatchAssets.cancelBtn}
        confirmBg={penCatchAssets.confirmBtn}
        onCancel={onClose}
        onConfirm={handleConfirm}
        confirmDisabled={submitting}
      />
    </PenModalShell>
  );
}

import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { vipName } from '@ola/shared/lib';
import type { VipIconInstance } from '@ola/shared/types';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { VipIconImage } from './VipIconImage';

interface VipRowProps {
  icon: VipIconInstance;
  onSelect: () => void;
}

export function VipRow({ icon, onSelect }: VipRowProps) {
  const { t } = useTranslation();
  const stateKey =
    icon.isUsing ? 'vip.stateInUse' : icon.isLocked ? 'vip.stateLocked' : 'vip.stateAvailable';
  return (
    <Pressable
      onPress={onSelect}
      className="active:bg-black/5"
      style={{ height: 72, backgroundColor: 'rgba(255,255,255,0.8)' }}
    >
      <View className="flex-1 flex-row items-center px-4">
        <VipIconImage typeId={icon.typeId} size={40} rounded />
        <View className="ml-2 justify-center">
          <Text className="text-base" style={{ color: TEXT_PRIMARY }}>{vipName(icon.typeId)}</Text>
          <Text className="mt-0.5 text-xs" style={{ color: TEXT_SECONDARY }}>{t(stateKey)}</Text>
        </View>
      </View>
      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />
    </Pressable>
  );
}

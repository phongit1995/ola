import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { vipName } from '@ola/shared/lib';
import type { VipIconInstance } from '@ola/shared/types';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { VipIconImage } from './VipIconImage';

interface VipRowProps {
  icon: VipIconInstance;
  selectMode: boolean;
  selected: boolean;
  selectable: boolean;
  onSelect: () => void;
  onToggle: () => void;
}

export function VipRow({ icon, selectMode, selected, selectable, onSelect, onToggle }: VipRowProps) {
  const { t } = useTranslation();
  const stateKey =
    icon.isUsing ? 'vip.stateInUse' : icon.isLocked ? 'vip.stateLocked' : 'vip.stateAvailable';
  const disabled = selectMode && !selectable;
  return (
    <Pressable
      onPress={selectMode ? onToggle : onSelect}
      disabled={disabled}
      className={disabled ? '' : 'active:bg-black/5'}
      style={{ height: 72, backgroundColor: 'rgba(255,255,255,0.8)', opacity: disabled ? 0.5 : 1 }}
    >
      <View className="flex-1 flex-row items-center px-4">
        {selectMode && (
          <View
            className="mr-3 items-center justify-center rounded"
            style={{
              width: 20,
              height: 20,
              borderWidth: 1,
              borderColor: selected ? '#7cb342' : 'rgba(0,0,0,0.3)',
              backgroundColor: selected ? '#7cb342' : '#ffffff',
            }}
          >
            {selected && <Text className="text-xs font-bold text-white">✓</Text>}
          </View>
        )}
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

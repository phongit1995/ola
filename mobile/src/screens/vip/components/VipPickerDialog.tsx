import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, View } from 'react-native';
import { formatKen } from '@ola/shared/lib';
import { Dialog } from '@components/ui/Dialog';
import { PRIMARY, TEXT_SECONDARY } from '@constants';
import type { PickerItem } from '../interface';
import { VipIconImage } from './VipIconImage';

interface VipPickerDialogProps {
  visible: boolean;
  selectedKey: string;
  items: PickerItem[];
  onSelect: (item: PickerItem) => void;
  onClose: () => void;
}

export function VipPickerDialog({
  visible,
  selectedKey,
  items,
  onSelect,
  onClose,
}: VipPickerDialogProps) {
  const { t } = useTranslation();
  return (
    <Dialog visible={visible} title={t('vip.buy.pickVipTitle')} onClose={onClose}>
      {items.length === 0 ? (
        <Text className="py-8 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
          {t('vip.buy.shopEmpty')}
        </Text>
      ) : (
        <ScrollView style={{ maxHeight: 420 }}>
          <View className="flex-row flex-wrap">
            {items.map((item) => {
              const selected = item.key === selectedKey;
              return (
                <Pressable
                  key={item.key}
                  onPress={() => {
                    onSelect(item);
                    onClose();
                  }}
                  className="items-center gap-1 rounded p-2 active:bg-black/5"
                  style={{
                    width: '33.33%',
                    backgroundColor: selected ? 'rgba(124,179,66,0.1)' : 'transparent',
                    borderWidth: 1,
                    borderColor: selected ? PRIMARY : 'transparent',
                  }}
                >
                  <VipIconImage typeId={item.typeId} size={44} />
                  <Text
                    numberOfLines={2}
                    className="text-center text-[11px] leading-tight"
                    style={{ color: 'rgba(0,0,0,0.7)' }}
                  >
                    {item.name}
                  </Text>
                  {item.price != null && (
                    <Text className="text-[11px] font-medium" style={{ color: PRIMARY }}>
                      {formatKen(item.price)} KEN
                    </Text>
                  )}
                </Pressable>
              );
            })}
          </View>
        </ScrollView>
      )}
    </Dialog>
  );
}

import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Modal, Pressable, Text, View } from 'react-native';
import type { RoomFilters } from '@ola/shared/types';

const FILTER_KEYS = [
  { key: 'showAll', labelKey: 'room.filterShowAll' },
  { key: 'media', labelKey: 'room.filterMedia' },
  { key: 'female', labelKey: 'room.filterFemale' },
  { key: 'male', labelKey: 'room.filterMale' },
  { key: 'flexible', labelKey: 'room.filterFlexible' },
] as const satisfies ReadonlyArray<{ key: keyof RoomFilters; labelKey: string }>;

interface RoomFilterDialogProps {
  visible: boolean;
  value: RoomFilters;
  onApply: (value: RoomFilters) => void;
  onClose: () => void;
}

function Checkbox({ checked }: { checked: boolean }) {
  return (
    <View
      className="h-5 w-5 items-center justify-center rounded"
      style={{
        borderWidth: 2,
        borderColor: checked ? '#7cb342' : 'rgba(0,0,0,0.38)',
        backgroundColor: checked ? '#7cb342' : 'transparent',
      }}
    >
      {checked && <Text className="text-xs font-bold text-white">✓</Text>}
    </View>
  );
}

export function RoomFilterDialog({ visible, value, onApply, onClose }: RoomFilterDialogProps) {
  const { t } = useTranslation();
  const [draft, setDraft] = useState(value);

  useEffect(() => {
    if (visible) setDraft(value);
  }, [visible, value]);

  function toggle(key: keyof RoomFilters) {
    setDraft((current) => ({ ...current, [key]: !current[key] }));
  }

  return (
    <Modal visible={visible} transparent animationType="fade" onRequestClose={onClose}>
      <Pressable className="flex-1 items-center justify-center bg-black/40 px-8" onPress={onClose}>
        <Pressable className="w-full max-w-md rounded-2xl bg-white p-4" onPress={() => undefined}>
          <Text className="mb-2 text-base font-semibold" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {t('room.filterTitle')}
          </Text>
          {FILTER_KEYS.map(({ key, labelKey }) => (
            <Pressable
              key={key}
              onPress={() => toggle(key)}
              className="flex-row items-center gap-2 py-2"
            >
              <Checkbox checked={draft[key]} />
              <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
                {t(labelKey)}
              </Text>
            </Pressable>
          ))}
          <View className="mt-2 flex-row justify-end gap-2">
            <Pressable onPress={onClose} className="rounded-full px-4 py-2">
              <Text className="text-sm font-semibold" style={{ color: 'rgba(0,0,0,0.54)' }}>
                {t('dialog.cancel')}
              </Text>
            </Pressable>
            <Pressable onPress={() => onApply(draft)} className="rounded-full bg-ola-primary px-4 py-2">
              <Text className="text-sm font-semibold text-white">{t('dialog.accept')}</Text>
            </Pressable>
          </View>
        </Pressable>
      </Pressable>
    </Modal>
  );
}

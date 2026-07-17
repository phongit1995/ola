import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import type { RoomFilters } from '@ola/shared/types';
import { Dialog, DialogButton } from '@components/ui/Dialog';

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
    <Dialog
      visible={visible}
      title={t('room.filterTitle')}
      onClose={onClose}
      footer={
        <>
          <DialogButton variant="green" onPress={() => onApply(draft)}>
            {t('dialog.accept')}
          </DialogButton>
          <DialogButton onPress={onClose}>{t('dialog.cancel')}</DialogButton>
        </>
      }
    >
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
    </Dialog>
  );
}

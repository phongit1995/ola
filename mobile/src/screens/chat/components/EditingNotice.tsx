import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { DIVIDER } from '@constants';

interface EditingNoticeProps {
  onCancel: () => void;
}

export function EditingNotice({ onCancel }: EditingNoticeProps) {
  const { t } = useTranslation();

  return (
    <View
      className="flex-row items-center gap-2 px-3 py-1.5"
      style={{ borderTopWidth: 1, borderTopColor: DIVIDER, backgroundColor: '#f1f8e9' }}
    >
      <Text className="flex-1 text-sm" style={{ color: 'rgba(0,0,0,0.7)' }}>
        {t('chat.editingHint')}
      </Text>
      <Pressable onPress={onCancel} className="px-2">
        <Text className="text-base text-ola-ink-soft">✕</Text>
      </Pressable>
    </View>
  );
}

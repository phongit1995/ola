import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import Clipboard from '@react-native-clipboard/clipboard';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';

export function CopyRow({ label, value }: { label: string; value: string }) {
  const colors = useThemeColors();
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);

  function copyValue() {
    Clipboard.setString(value);
    push('info', t('ken.buy.copied'));
  }

  return (
    <View
      className="flex-row items-center py-2"
      style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.08)' }}
    >
      <View className="min-w-0 flex-1">
        <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>{label}</Text>
        <Text className="text-sm font-medium" style={{ color: TEXT_PRIMARY }} numberOfLines={1}>
          {value}
        </Text>
      </View>
      <Pressable
        onPress={copyValue}
        className="ml-2 shrink-0 rounded px-2 py-1 active:bg-black/5"
        style={{ borderWidth: 1, borderColor: DIVIDER }}
      >
        <Text className="text-xs" style={{ color: colors.primary }}>{t('common.copy')}</Text>
      </Pressable>
    </View>
  );
}

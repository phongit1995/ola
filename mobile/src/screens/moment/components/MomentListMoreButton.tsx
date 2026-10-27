import { useTranslation } from 'react-i18next';
import { Pressable, Text } from 'react-native';
import { useThemeColors } from '@hooks/useThemeColors';

interface MomentListMoreButtonProps {
  loading: boolean;
  onPress: () => Promise<void>;
}

export function MomentListMoreButton({
  loading,
  onPress,
}: MomentListMoreButtonProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <Pressable
      accessibilityRole="button"
      disabled={loading}
      onPress={() => void onPress()}
      className="items-center py-2.5 active:bg-black/5"
      style={{ opacity: loading ? 0.5 : 1 }}
    >
      <Text
        className="text-base font-semibold"
        style={{ color: colors.primary }}
      >
        {t('moment.viewersMore')}
      </Text>
    </Pressable>
  );
}

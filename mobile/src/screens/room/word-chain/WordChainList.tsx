import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, Text, View } from 'react-native';
import { Avatar } from '@components/ui/Avatar';
import { useThemeColors } from '@hooks/useThemeColors';

export const WORD_CHAIN_ROW_DIVIDER = 'rgba(0,0,0,0.06)';

export function WordChainUserRow({
  name,
  avatar,
  highlighted,
  divider = true,
  leading,
  trailing,
  children,
}: {
  name: string;
  avatar?: string;
  highlighted: boolean;
  divider?: boolean;
  leading?: ReactNode;
  trailing: ReactNode;
  children: ReactNode;
}) {
  const colors = useThemeColors();
  return (
    <View
      className="flex-row items-center gap-2 px-3 py-2"
      style={{
        backgroundColor: highlighted ? colors.primaryLight : undefined,
        borderTopWidth: divider ? 1 : 0,
        borderTopColor: WORD_CHAIN_ROW_DIVIDER,
      }}
    >
      {leading}
      <Avatar name={name} uri={avatar} size={36} />
      <View className="min-w-0 flex-1">{children}</View>
      {trailing}
    </View>
  );
}

export function WordChainListStatus({
  loading,
  failed,
  emptyText,
  errorText,
  onRetry,
}: {
  loading: boolean;
  failed: boolean;
  emptyText: string;
  errorText: string;
  onRetry: () => void;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <View className="min-h-0 flex-1 items-center justify-center gap-2 px-4">
      {loading ? (
        <ActivityIndicator color={colors.primary} size="large" />
      ) : failed ? (
        <>
          <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {errorText}
          </Text>
          <Pressable onPress={onRetry} className="rounded-full px-4 py-1.5 active:bg-black/5">
            <Text className="text-sm font-medium" style={{ color: colors.primaryInk }}>
              {t('wordChain.retry')}
            </Text>
          </Pressable>
        </>
      ) : (
        <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
          {emptyText}
        </Text>
      )}
    </View>
  );
}

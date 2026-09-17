import type { ReactNode } from 'react';
import { Image, Pressable, Text, View, type ImageSourcePropType } from 'react-native';
import { withAlpha } from '@ola/shared/lib';
import { useAppTypography } from '@components/AppFontProvider';
import { useThemeColors } from '@hooks/useThemeColors';

export const ROW_BORDER = 'rgba(0,0,0,0.06)';

export function SectionIcon({ src }: { src: ImageSourcePropType }) {
  const resolved = Image.resolveAssetSource(src);
  const ratio = resolved != null && resolved.height > 0 ? resolved.width / resolved.height : 1;
  return <Image source={src} style={{ height: 16, width: 16 * ratio }} resizeMode="contain" />;
}

export function ToggleSwitch({
  on,
  disabled = false,
  onChange,
}: {
  on: boolean;
  disabled?: boolean;
  onChange: () => void;
}) {
  const colors = useThemeColors();
  return (
    <Pressable
      accessibilityRole="switch"
      accessibilityState={{ checked: on, disabled }}
      disabled={disabled}
      onPress={onChange}
      className="shrink-0 rounded-full"
      style={{
        width: 48,
        height: 28,
        backgroundColor: on ? colors.primary : 'rgba(0,0,0,0.2)',
        opacity: disabled ? 0.4 : 1,
      }}
    >
      <View
        className="absolute rounded-full bg-white"
        style={{
          top: 2,
          left: on ? 22 : 2,
          width: 24,
          height: 24,
          shadowColor: '#000',
          shadowOpacity: 0.15,
          shadowRadius: 2,
          shadowOffset: { width: 0, height: 1 },
          elevation: 2,
        }}
      />
    </Pressable>
  );
}

export function Segmented<T extends string>({
  value,
  options,
  onChange,
}: {
  value: T;
  options: { value: T; label: string }[];
  onChange: (value: T) => void;
}) {
  const { multiplier: fontMultiplier } = useAppTypography();
  const colors = useThemeColors();
  return (
    <View
      className="shrink-0 flex-row rounded-lg bg-white"
      style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.1)', padding: 2 }}
    >
      {options.map((option) => {
        const selected = value === option.value;
        return (
          <Pressable
            key={option.value}
            onPress={() => onChange(option.value)}
            className="rounded-md"
            style={{
              paddingHorizontal: 10,
              paddingVertical: 4,
              backgroundColor: selected ? colors.primary : 'transparent',
            }}
          >
            <Text
              style={{
                fontSize: 13 * fontMultiplier,
                lineHeight: 17 * fontMultiplier,
                color: selected ? '#ffffff' : 'rgba(0,0,0,0.7)',
                fontWeight: selected ? '600' : '400',
              }}
            >
              {option.label}
            </Text>
          </Pressable>
        );
      })}
    </View>
  );
}

export function SettingRow({
  label,
  hint,
  last,
  children,
}: {
  label: string;
  hint?: string;
  last?: boolean;
  children: ReactNode;
}) {
  return (
    <View
      className="flex-row items-center justify-between gap-3 px-4 py-3"
      style={last === true ? undefined : { borderBottomWidth: 1, borderBottomColor: ROW_BORDER }}
    >
      <View className="min-w-0 flex-1">
        <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.8)' }}>
          {label}
        </Text>
        {hint != null && hint !== '' && (
          <Text className="mt-0.5 text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
            {hint}
          </Text>
        )}
      </View>
      {children}
    </View>
  );
}

export function LinkRow({
  label,
  value,
  last,
  onPress,
}: {
  label: string;
  value?: string;
  last?: boolean;
  onPress: () => void;
}) {
  return (
    <Pressable
      accessibilityRole="button"
      onPress={onPress}
      className="flex-row items-center justify-between gap-3 px-4 py-3 active:bg-black/5"
      style={last === true ? undefined : { borderBottomWidth: 1, borderBottomColor: ROW_BORDER }}
    >
      <Text className="min-w-0 flex-1 text-sm" style={{ color: 'rgba(0,0,0,0.8)' }}>
        {label}
      </Text>
      {value != null && value !== '' && (
        <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.5)' }}>
          {value}
        </Text>
      )}
      <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.35)' }}>
        ›
      </Text>
    </Pressable>
  );
}

export function SettingsCard({
  icon,
  index,
  title,
  children,
}: {
  icon: ReactNode;
  index?: number;
  title: string;
  children: ReactNode;
}) {
  const colors = useThemeColors();
  return (
    <View
      className="overflow-hidden rounded-2xl bg-white"
      style={{
        borderWidth: 1,
        borderColor: 'rgba(0,0,0,0.05)',
        shadowColor: '#000',
        shadowOpacity: 0.05,
        shadowRadius: 2,
        shadowOffset: { width: 0, height: 1 },
        elevation: 1,
      }}
    >
      <View
        className="flex-row items-center gap-2 px-4 py-3"
        style={{
          borderBottomWidth: 1,
          borderBottomColor: ROW_BORDER,
          backgroundColor: withAlpha(colors.primary, 0.05),
        }}
      >
        {icon}
        <Text className="text-base font-bold" style={{ color: colors.primary }}>
          {index != null ? `${index}. ${title}` : title}
        </Text>
      </View>
      <View>{children}</View>
    </View>
  );
}

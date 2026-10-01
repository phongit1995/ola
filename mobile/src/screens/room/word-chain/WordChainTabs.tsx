import { Pressable, Text, View } from 'react-native';
import { useThemeColors } from '@hooks/useThemeColors';

interface TabItem<T extends string> {
  key: T;
  label: string;
}

interface WordChainTabsProps<T extends string> {
  items: readonly TabItem<T>[];
  value: T;
  onChange: (key: T) => void;
  variant: 'segmented' | 'chips';
}

const SEGMENT_SHADOW = {
  shadowColor: '#000',
  shadowOpacity: 0.12,
  shadowRadius: 2,
  shadowOffset: { width: 0, height: 1 },
  elevation: 1,
};

export function WordChainTabs<T extends string>({
  items,
  value,
  onChange,
  variant,
}: WordChainTabsProps<T>) {
  const colors = useThemeColors();
  if (variant === 'segmented') {
    return (
      <View
        className="flex-row rounded-full p-1"
        style={{ backgroundColor: 'rgba(0,0,0,0.06)' }}
      >
        {items.map((item) => {
          const active = item.key === value;
          return (
            <Pressable
              key={item.key}
              accessibilityRole="tab"
              accessibilityState={{ selected: active }}
              onPress={() => onChange(item.key)}
              className="flex-1 items-center rounded-full py-1.5"
              style={active ? [{ backgroundColor: '#ffffff' }, SEGMENT_SHADOW] : undefined}
            >
              <Text
                className="text-sm font-medium"
                style={{ color: active ? colors.primaryInk : 'rgba(0,0,0,0.54)' }}
              >
                {item.label}
              </Text>
            </Pressable>
          );
        })}
      </View>
    );
  }
  return (
    <View className="flex-row flex-wrap" style={{ gap: 6 }}>
      {items.map((item) => {
        const active = item.key === value;
        return (
          <Pressable
            key={item.key}
            accessibilityRole="button"
            accessibilityState={{ selected: active }}
            onPress={() => onChange(item.key)}
            className="rounded-full px-3 py-1"
            style={{ backgroundColor: active ? colors.primary : 'rgba(0,0,0,0.05)' }}
          >
            <Text
              className="text-xs font-medium"
              style={{ color: active ? colors.onPrimary : 'rgba(0,0,0,0.6)' }}
            >
              {item.label}
            </Text>
          </Pressable>
        );
      })}
    </View>
  );
}

import { Text, View } from 'react-native';

export function ScreenPlaceholder({ title }: { title: string }) {
  return (
    <View className="flex-1 items-center justify-center bg-white">
      <Text className="text-base text-neutral-500">{title}</Text>
    </View>
  );
}

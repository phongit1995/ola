import { Image, Text, View } from 'react-native';
import { colorForName } from '@ola/shared/lib';

interface AvatarProps {
  name: string;
  uri?: string;
  size?: number;
}

export function Avatar({ name, uri, size = 48 }: AvatarProps) {
  const style = { width: size, height: size, borderRadius: size / 2 };
  if (uri != null && uri !== '') {
    return <Image source={{ uri }} style={style} />;
  }
  const initial = name.trim().charAt(0).toUpperCase() || '?';
  return (
    <View
      className="items-center justify-center"
      style={[style, { backgroundColor: colorForName(name) }]}
    >
      <Text className="font-semibold text-white" style={{ fontSize: size * 0.4 }}>
        {initial}
      </Text>
    </View>
  );
}

import { Image, Text, View } from 'react-native';
import { colorForName } from '@ola/shared/lib';

interface AvatarProps {
  name: string;
  uri?: string;
  size?: number;
  rounded?: boolean;
  color?: string;
}

export function Avatar({ name, uri, size = 48, rounded = true, color }: AvatarProps) {
  const style = { width: size, height: size, borderRadius: rounded ? size / 2 : 0 };
  if (uri != null && uri !== '') {
    return <Image source={{ uri }} style={style} />;
  }
  const initial = name.trim().charAt(0).toUpperCase() || '?';
  return (
    <View
      className="items-center justify-center"
      style={[style, { backgroundColor: color ?? colorForName(name) }]}
    >
      <Text className="font-medium text-white" style={{ fontSize: size * 0.45 }}>
        {initial}
      </Text>
    </View>
  );
}

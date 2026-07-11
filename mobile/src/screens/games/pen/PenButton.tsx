import type { ReactNode } from 'react';
import {
  Image,
  Pressable,
  Text,
  type ImageSourcePropType,
  type StyleProp,
  type TextStyle,
  type ViewStyle,
} from 'react-native';
import { PenBg, penTextShadow } from './penUi';

interface PenButtonProps {
  bg: ImageSourcePropType;
  label?: string;
  icon?: ImageSourcePropType;
  iconNode?: ReactNode;
  iconSize?: number;
  gap?: number;
  onPress?: () => void;
  disabled?: boolean;
  style?: StyleProp<ViewStyle>;
  labelStyle?: StyleProp<TextStyle>;
}

export function PenButton({
  bg,
  label,
  icon,
  iconNode,
  iconSize = 20,
  gap = 8,
  onPress,
  disabled = false,
  style,
  labelStyle,
}: PenButtonProps) {
  return (
    <Pressable
      onPress={onPress}
      disabled={disabled}
      style={({ pressed }) => [
        {
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'center',
          gap,
          opacity: disabled ? 0.6 : 1,
          transform: [{ scale: pressed ? 0.95 : 1 }],
        },
        style,
      ]}
    >
      <PenBg source={bg} />
      {iconNode}
      {icon != null && iconNode == null && (
        <Image
          source={icon}
          style={{ width: iconSize, height: iconSize }}
          resizeMode="contain"
        />
      )}
      {label != null && (
        <Text style={[{ color: '#ffffff', fontWeight: '700' }, penTextShadow, labelStyle]}>
          {label}
        </Text>
      )}
    </Pressable>
  );
}

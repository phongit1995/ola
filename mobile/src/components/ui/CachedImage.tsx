import type { ReactNode } from 'react';
import { View } from 'react-native';
import type { StyleProp, ViewStyle } from 'react-native';
import FastImage, {
  type ImageStyle,
  type OnLoadEvent,
  type Priority,
  type ResizeMode,
} from '@d11/react-native-fast-image';

interface CachedImageProps {
  uri?: string | null;
  placeholder?: number;
  style?: StyleProp<ImageStyle>;
  resizeMode?: ResizeMode;
  placeholderResizeMode?: ResizeMode;
  tintColor?: string;
  priority?: Priority;
  onSize?: (size: { width: number; height: number }) => void;
}

export function CachedImage({
  uri,
  placeholder,
  style,
  resizeMode = 'cover',
  placeholderResizeMode,
  tintColor,
  priority = FastImage.priority.normal,
  onSize,
}: CachedImageProps) {
  if (uri != null && uri !== '') {
    return (
      <FastImage
        source={{ uri, priority }}
        style={style}
        resizeMode={resizeMode}
        tintColor={tintColor}
        onLoad={onSize != null ? (e: OnLoadEvent) => onSize(e.nativeEvent) : undefined}
      />
    );
  }
  if (placeholder != null) {
    return (
      <FastImage
        source={placeholder}
        style={style}
        resizeMode={placeholderResizeMode ?? resizeMode}
        tintColor={tintColor}
      />
    );
  }
  return <View style={style as StyleProp<ViewStyle>} />;
}

interface CachedImageBackgroundProps {
  uri?: string | null;
  style?: StyleProp<ImageStyle>;
  resizeMode?: ResizeMode;
  children?: ReactNode;
}

export function CachedImageBackground({
  uri,
  style,
  resizeMode = 'cover',
  children,
}: CachedImageBackgroundProps) {
  if (uri != null && uri !== '') {
    return (
      <FastImage
        source={{ uri, priority: FastImage.priority.normal }}
        style={style}
        resizeMode={resizeMode}
      >
        {children}
      </FastImage>
    );
  }
  return <View style={style as StyleProp<ViewStyle>}>{children}</View>;
}

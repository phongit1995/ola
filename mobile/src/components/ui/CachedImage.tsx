import { useState, type ReactNode } from 'react';
import { ActivityIndicator, StyleSheet, View } from 'react-native';
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
  showLoader?: boolean;
  loadingIndicatorColor?: string;
  onSize?: (size: { width: number; height: number }) => void;
}

type RemoteImageStatus = {
  uri: string;
  value: 'loading' | 'loaded' | 'error';
};

const DEFAULT_LOADING_INDICATOR_COLOR = '#7cb342';

function loadingOverlay(show: boolean, color: string): ReactNode {
  if (!show) return null;
  return (
    <View pointerEvents="none" style={styles.loadingOverlay}>
      <ActivityIndicator size="small" color={color} />
    </View>
  );
}

export function CachedImage({
  uri,
  placeholder,
  style,
  resizeMode = 'cover',
  placeholderResizeMode,
  tintColor,
  priority = FastImage.priority.normal,
  showLoader = false,
  loadingIndicatorColor = DEFAULT_LOADING_INDICATOR_COLOR,
  onSize,
}: CachedImageProps) {
  const [remoteStatus, setRemoteStatus] = useState<RemoteImageStatus | null>(null);

  if (uri != null && uri !== '') {
    const status = remoteStatus?.uri === uri ? remoteStatus.value : 'loading';
    if (status === 'error') {
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
      return <View style={[styles.loadingSurface, style as StyleProp<ViewStyle>]} />;
    }

    return (
      <FastImage
        source={{ uri, priority }}
        defaultSource={placeholder}
        style={[status === 'loading' && styles.loadingSurface, style]}
        resizeMode={
          status === 'loading' && placeholder != null
            ? (placeholderResizeMode ?? resizeMode)
            : resizeMode
        }
        tintColor={tintColor}
        transition={FastImage.transition.fade}
        onLoadStart={() => setRemoteStatus({ uri, value: 'loading' })}
        onLoad={(e: OnLoadEvent) => {
          setRemoteStatus({ uri, value: 'loaded' });
          onSize?.(e.nativeEvent);
        }}
        onError={() => setRemoteStatus({ uri, value: 'error' })}
      >
        {loadingOverlay(showLoader && status === 'loading' && placeholder == null, loadingIndicatorColor)}
      </FastImage>
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
  placeholder?: number;
  placeholderResizeMode?: ResizeMode;
  showLoader?: boolean;
  loadingIndicatorColor?: string;
  children?: ReactNode;
}

export function CachedImageBackground({
  uri,
  style,
  resizeMode = 'cover',
  placeholder,
  placeholderResizeMode,
  showLoader = false,
  loadingIndicatorColor = DEFAULT_LOADING_INDICATOR_COLOR,
  children,
}: CachedImageBackgroundProps) {
  const [remoteStatus, setRemoteStatus] = useState<RemoteImageStatus | null>(null);

  if (uri != null && uri !== '') {
    const status = remoteStatus?.uri === uri ? remoteStatus.value : 'loading';
    if (status === 'error') {
      if (placeholder != null) {
        return (
          <FastImage
            source={placeholder}
            style={style}
            resizeMode={placeholderResizeMode ?? resizeMode}
          >
            {children}
          </FastImage>
        );
      }
      return (
        <View style={[styles.loadingSurface, style as StyleProp<ViewStyle>]}>{children}</View>
      );
    }

    return (
      <FastImage
        source={{ uri, priority: FastImage.priority.normal }}
        defaultSource={placeholder}
        style={[status === 'loading' && styles.loadingSurface, style]}
        resizeMode={
          status === 'loading' && placeholder != null
            ? (placeholderResizeMode ?? resizeMode)
            : resizeMode
        }
        transition={FastImage.transition.fade}
        onLoadStart={() => setRemoteStatus({ uri, value: 'loading' })}
        onLoad={() => setRemoteStatus({ uri, value: 'loaded' })}
        onError={() => setRemoteStatus({ uri, value: 'error' })}
      >
        {loadingOverlay(showLoader && status === 'loading' && placeholder == null, loadingIndicatorColor)}
        {children}
      </FastImage>
    );
  }
  if (placeholder != null) {
    return (
      <FastImage
        source={placeholder}
        style={style}
        resizeMode={placeholderResizeMode ?? resizeMode}
      >
        {children}
      </FastImage>
    );
  }
  return <View style={style as StyleProp<ViewStyle>}>{children}</View>;
}

const styles = StyleSheet.create({
  loadingSurface: {
    backgroundColor: 'rgba(0,0,0,0.06)',
  },
  loadingOverlay: {
    position: 'absolute',
    inset: 0,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

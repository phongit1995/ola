import { View, type ImageStyle, type StyleProp, type ViewStyle } from 'react-native';
import FastImage, { type FastImageProps } from '@d11/react-native-fast-image';
import { avatarFrameById } from '@ola/shared/lib/avatarFrame';

interface AvatarFrameImageProps {
  frameId: string;
  size: number;
  style?: StyleProp<ViewStyle>;
}

function frameImageStyle(size: number): FastImageProps['style'] {
  const style: StyleProp<ImageStyle> = { width: size, height: size };
  return style as FastImageProps['style'];
}

export function AvatarFrameImage({ frameId, size, style }: AvatarFrameImageProps) {
  const frame = avatarFrameById(frameId);
  return (
    <View pointerEvents="none" style={[{ width: size, height: size }, style]}>
      {frame != null && (
        <FastImage
          source={{ uri: frame.url }}
          resizeMode={FastImage.resizeMode.contain}
          style={frameImageStyle(size)}
        />
      )}
    </View>
  );
}

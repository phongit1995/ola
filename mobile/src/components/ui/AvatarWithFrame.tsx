import { View } from 'react-native';
import { avatarFrameById } from '@ola/shared/lib/avatarFrame';
import { avatarFrameLayout, canShowAvatarFrame } from '@ola/shared/lib';
import { Avatar } from './Avatar';
import { AvatarFrameImage } from './AvatarFrameImage';

const DEFAULT_AVATAR_SIZE = 48;

interface AvatarWithFrameProps {
  name: string;
  uri?: string;
  size?: number;
  rounded?: boolean;
  color?: string;
  showLoader?: boolean;
  frameId?: string | null;
}

export function AvatarWithFrame({
  name,
  uri,
  size = DEFAULT_AVATAR_SIZE,
  rounded = true,
  color,
  showLoader,
  frameId,
}: AvatarWithFrameProps) {
  const frame = canShowAvatarFrame(size, frameId) ? avatarFrameById(frameId) : undefined;
  if (frame == null) {
    return (
      <Avatar
        name={name}
        uri={uri}
        size={size}
        rounded={rounded}
        color={color}
        showLoader={showLoader}
      />
    );
  }
  const { frameSize, avatarSize, frameOffset } = avatarFrameLayout(size);
  return (
    <View
      style={{ width: size, height: size, alignItems: 'center', justifyContent: 'center' }}
    >
      <Avatar
        name={name}
        uri={uri}
        size={avatarSize}
        rounded={rounded}
        color={color}
        showLoader={showLoader}
      />
      <AvatarFrameImage
        frameId={frame.id}
        size={frameSize}
        style={{ position: 'absolute', left: frameOffset, top: frameOffset }}
      />
    </View>
  );
}

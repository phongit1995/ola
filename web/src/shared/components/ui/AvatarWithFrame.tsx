import { visibleAvatarFrame } from '@ola/shared/lib/avatarFrame';
import { avatarFrameLayout } from '@lib';
import { Avatar } from './Avatar';

const DEFAULT_AVATAR_SIZE = 40;

interface AvatarWithFrameProps {
  name: string;
  color: string;
  size?: number;
  src?: string;
  rounded?: boolean;
  frameId?: string | null;
}

export function AvatarWithFrame({
  name,
  color,
  size = DEFAULT_AVATAR_SIZE,
  src,
  rounded = true,
  frameId,
}: AvatarWithFrameProps) {
  const frame = visibleAvatarFrame(size, frameId);
  if (frame == null) {
    return (
      <Avatar
        name={name}
        color={color}
        size={size}
        src={src}
        rounded={rounded}
      />
    );
  }
  const { frameSize, avatarSize, frameOffset } = avatarFrameLayout(size);
  return (
    <span
      className="relative flex shrink-0 items-center justify-center"
      style={{ width: size, height: size }}
    >
      <Avatar
        name={name}
        color={color}
        size={avatarSize}
        src={src}
        rounded={rounded}
      />
      <img
        src={frame.url}
        alt=""
        loading="lazy"
        decoding="async"
        draggable={false}
        className="pointer-events-none absolute max-w-none select-none"
        style={{
          width: frameSize,
          height: frameSize,
          left: frameOffset,
          top: frameOffset,
        }}
      />
    </span>
  );
}

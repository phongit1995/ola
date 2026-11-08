import { FRAME_THUMB_SIZE } from '../constants';
import { avatarFrameById } from '@ola/shared/lib/avatarFrame';

interface AvatarFrameThumbProps {
  frameId: string;
  size?: number;
}

export function AvatarFrameThumb({
  frameId,
  size = FRAME_THUMB_SIZE,
}: AvatarFrameThumbProps) {
  const url = avatarFrameById(frameId)?.url;
  if (url == null) {
    return (
      <span
        className="shrink-0 rounded-full bg-black/12"
        style={{ width: size, height: size }}
      />
    );
  }
  return (
    <img
      src={url}
      alt=""
      loading="lazy"
      decoding="async"
      draggable={false}
      className="shrink-0 object-contain"
      style={{ width: size, height: size }}
    />
  );
}

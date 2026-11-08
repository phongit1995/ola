import {
  AVATAR_FRAME_HOLE_RATIO,
  AVATAR_FRAME_MIN_SLOT,
  AVATAR_FRAME_SCALE,
} from '../constants/avatarFrame';

export interface AvatarFrameLayout {
  frameSize: number;
  avatarSize: number;
  frameOffset: number;
}

export function avatarFrameLayout(slot: number): AvatarFrameLayout {
  const frameSize = slot * AVATAR_FRAME_SCALE;
  return {
    frameSize,
    avatarSize: frameSize * AVATAR_FRAME_HOLE_RATIO,
    frameOffset: (slot - frameSize) / 2,
  };
}

export function canShowAvatarFrame(slot: number, frameId: string | null | undefined): boolean {
  return frameId != null && frameId !== '' && slot >= AVATAR_FRAME_MIN_SLOT;
}

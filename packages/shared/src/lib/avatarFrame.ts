import avatarFrames from './avatarFrames.json';
import type { AvatarFrame } from '../types/lib.type';

export type { AvatarFrame } from '../types/lib.type';

export const AVATAR_FRAMES: readonly AvatarFrame[] = avatarFrames;

const AVATAR_FRAMES_BY_ID = new Map(AVATAR_FRAMES.map((frame) => [frame.id, frame]));

export function avatarFrameById(id: string | null | undefined): AvatarFrame | undefined {
  if (id == null || id === '') return undefined;
  return AVATAR_FRAMES_BY_ID.get(id);
}

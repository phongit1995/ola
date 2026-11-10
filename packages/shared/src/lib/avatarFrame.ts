import avatarFrames from './avatarFrames.json';
import type { AvatarFrame } from '../types/lib.type';
import { canShowAvatarFrame } from './avatarFrameLayout';

export type { AvatarFrame } from '../types/lib.type';

export const AVATAR_FRAMES: readonly AvatarFrame[] = avatarFrames;

const AVATAR_FRAMES_BY_ID = new Map(AVATAR_FRAMES.map((frame) => [frame.id, frame]));

export function avatarFrameById(id: string | null | undefined): AvatarFrame | undefined {
  if (id == null || id === '') return undefined;
  return AVATAR_FRAMES_BY_ID.get(id);
}

export function visibleAvatarFrame(slot: number, frameId: string | null | undefined): AvatarFrame | undefined {
  return canShowAvatarFrame(slot, frameId) ? avatarFrameById(frameId) : undefined;
}

export function avatarFrameLabel(frameId: string): string {
  const name = avatarFrameById(frameId)?.name ?? '';
  return name !== '' ? name : `#${frameId}`;
}

import { ownedAvatarFrameKey } from '../../lib/avatarFrame';
import type { AvatarFrameStoreResult } from '../../types/api/avatarFrame.type';

export function mergeAvatarFramePage(
  current: AvatarFrameStoreResult,
  next: AvatarFrameStoreResult,
): AvatarFrameStoreResult {
  const loaded = new Set(current.items.map(ownedAvatarFrameKey));
  return {
    ...next,
    items: [...current.items, ...next.items.filter((item) => !loaded.has(ownedAvatarFrameKey(item)))],
  };
}

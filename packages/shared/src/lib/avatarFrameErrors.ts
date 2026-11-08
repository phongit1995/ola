import { AVATAR_FRAME_ERROR_CODE } from '../constants/avatarFrame';
import { toApiError } from './apiError';

export type AvatarFrameErrorKey =
  | 'avatarFrame.errors.itemUnavailable'
  | 'avatarFrame.errors.priceChanged'
  | 'avatarFrame.errors.alreadyOwned'
  | 'avatarFrame.errors.receiverOwns'
  | 'avatarFrame.errors.notOwned'
  | 'avatarFrame.errors.inUse'
  | 'avatarFrame.errors.vipRequired'
  | 'avatarFrame.errors.insufficientKen'
  | 'avatarFrame.errors.wrongPassword'
  | 'avatarFrame.errors.receiverNotFound'
  | 'avatarFrame.errors.selfTarget'
  | 'avatarFrame.errors.blocked'
  | 'avatarFrame.errors.privateStore'
  | 'avatarFrame.errors.failed';

const AVATAR_FRAME_ERROR_KEYS: Record<string, AvatarFrameErrorKey> = {
  [AVATAR_FRAME_ERROR_CODE.shopItemNotFound]: 'avatarFrame.errors.itemUnavailable',
  [AVATAR_FRAME_ERROR_CODE.priceChanged]: 'avatarFrame.errors.priceChanged',
  [AVATAR_FRAME_ERROR_CODE.alreadyOwned]: 'avatarFrame.errors.alreadyOwned',
  [AVATAR_FRAME_ERROR_CODE.receiverOwns]: 'avatarFrame.errors.receiverOwns',
  [AVATAR_FRAME_ERROR_CODE.notOwned]: 'avatarFrame.errors.notOwned',
  [AVATAR_FRAME_ERROR_CODE.inUse]: 'avatarFrame.errors.inUse',
  [AVATAR_FRAME_ERROR_CODE.vipRequired]: 'avatarFrame.errors.vipRequired',
  [AVATAR_FRAME_ERROR_CODE.insufficientKen]: 'avatarFrame.errors.insufficientKen',
  [AVATAR_FRAME_ERROR_CODE.wrongPassword]: 'avatarFrame.errors.wrongPassword',
  [AVATAR_FRAME_ERROR_CODE.receiverNotFound]: 'avatarFrame.errors.receiverNotFound',
  [AVATAR_FRAME_ERROR_CODE.selfTarget]: 'avatarFrame.errors.selfTarget',
  [AVATAR_FRAME_ERROR_CODE.blocked]: 'avatarFrame.errors.blocked',
  [AVATAR_FRAME_ERROR_CODE.privateStore]: 'avatarFrame.errors.privateStore',
};

export function avatarFrameErrorKey(error: unknown): AvatarFrameErrorKey {
  const code = toApiError(error).code;
  return (code && AVATAR_FRAME_ERROR_KEYS[code]) || 'avatarFrame.errors.failed';
}

export function isAvatarFramePrivateStoreError(error: unknown): boolean {
  return toApiError(error).code === AVATAR_FRAME_ERROR_CODE.privateStore;
}

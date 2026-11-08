import type { AvatarFrameHistoryTab, AvatarFramePrivacy } from '../types/api/avatarFrame.type';

export const AVATAR_FRAME_SCALE = 1.2;
export const AVATAR_FRAME_HOLE_RATIO = 0.66;
export const AVATAR_FRAME_MIN_SLOT = 24;
export const AVATAR_FRAME_STORE_PAGE_SIZE = 50;
export const AVATAR_FRAME_HISTORY_PAGE_SIZE = 20;

export const AVATAR_FRAME_PRIVACY = {
  public: 0,
  friends: 1,
  private: 2,
} as const satisfies Record<string, AvatarFramePrivacy>;

export const AVATAR_FRAME_PRIVACY_OPTIONS = [
  { value: AVATAR_FRAME_PRIVACY.public, labelKey: 'avatarFrame.privacyPublic' },
  { value: AVATAR_FRAME_PRIVACY.friends, labelKey: 'avatarFrame.privacyFriends' },
  { value: AVATAR_FRAME_PRIVACY.private, labelKey: 'avatarFrame.privacyPrivate' },
] as const satisfies readonly { value: AvatarFramePrivacy; labelKey: string }[];

export const AVATAR_FRAME_HISTORY_TABS = [
  { key: 'purchases', labelKey: 'avatarFrame.history.tabPurchases' },
  { key: 'transfers', labelKey: 'avatarFrame.history.tabTransfers' },
] as const satisfies readonly { key: AvatarFrameHistoryTab; labelKey: string }[];

export const AVATAR_FRAME_ERROR_CODE = {
  shopItemNotFound: 'AVATAR_FRAME_SHOP_ITEM_NOT_FOUND',
  priceChanged: 'AVATAR_FRAME_PRICE_CHANGED',
  alreadyOwned: 'AVATAR_FRAME_ALREADY_OWNED',
  receiverOwns: 'AVATAR_FRAME_RECEIVER_OWNS',
  notOwned: 'AVATAR_FRAME_NOT_OWNED',
  inUse: 'AVATAR_FRAME_IN_USE',
  vipRequired: 'AVATAR_FRAME_VIP_REQUIRED',
  insufficientKen: 'AVATAR_FRAME_INSUFFICIENT_KEN',
  wrongPassword: 'AVATAR_FRAME_WRONG_PASSWORD',
  receiverNotFound: 'AVATAR_FRAME_RECEIVER_NOT_FOUND',
  selfTarget: 'AVATAR_FRAME_SELF_TARGET',
  blocked: 'AVATAR_FRAME_BLOCKED',
  privateStore: 'AVATAR_FRAME_PRIVATE_STORE',
} as const;

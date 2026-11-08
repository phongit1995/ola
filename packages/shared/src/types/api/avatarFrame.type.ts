export type AvatarFramePrivacy = 0 | 1 | 2;

export type AvatarFrameSource = 'purchase' | 'gift' | 'transfer' | 'gift_code';

export type AvatarFramePurchaseSource = 'purchase' | 'gift';

export interface AvatarFrameShopItem {
  id: string;
  frameId: string;
  kenPrice: number;
  isActive: boolean;
  sortOrder: number;
  owned: boolean;
}

export interface AvatarFrameShopResult {
  total: number;
  items: AvatarFrameShopItem[];
}

export interface BuyAvatarFrameResult {
  frameId: string;
  kenSpent: number;
  kenBalance: number;
}

export interface GiftAvatarFrameResult {
  receiverUsername: string;
  frameId: string;
  kenSpent: number;
  kenBalance: number;
}

export interface OwnedAvatarFrame {
  frameId: string;
  source: AvatarFrameSource;
  acquiredAt: string;
  isEquipped: boolean;
}

export interface AvatarFrameStoreResult {
  userId: string;
  equippedFrameId: string | null;
  vipActive: boolean;
  privacy: AvatarFramePrivacy;
  total: number;
  limit: number;
  offset: number;
  items: OwnedAvatarFrame[];
}

export interface EquipAvatarFrameResult {
  equippedFrameId: string | null;
}

export interface AvatarFrameUserBrief {
  id: string;
  username: string;
  fullName?: string;
}

export interface AvatarFramePurchaseItem {
  id: string;
  frameId: string;
  kenPrice: number;
  source: AvatarFramePurchaseSource;
  buyer: AvatarFrameUserBrief;
  recipient?: AvatarFrameUserBrief;
  createdAt: string;
}

export interface AvatarFramePurchaseHistoryResult {
  total: number;
  limit: number;
  offset: number;
  items: AvatarFramePurchaseItem[];
}

export interface AvatarFrameTransferItem {
  id: string;
  frameId: string;
  from: AvatarFrameUserBrief;
  to: AvatarFrameUserBrief;
  createdAt: string;
}

export interface AvatarFrameTransferHistoryResult {
  total: number;
  limit: number;
  offset: number;
  items: AvatarFrameTransferItem[];
}

export type AvatarFrameHistoryTab = 'purchases' | 'transfers';

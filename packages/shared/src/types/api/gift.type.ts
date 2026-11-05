export type GiftSource = 'chat' | 'profile';

export type GiftLeaderboardType = 'sender' | 'receiver';

export type GiftLeaderboardPeriod = 'week' | 'month' | 'all';

export type GiftHistoryDirection = 'received' | 'sent';

export type GiftAnimationKey =
  | 'fly'
  | 'drop'
  | 'spin'
  | 'zoom'
  | 'float'
  | 'swing'
  | 'pop'
  | 'flip'
  | 'heartbeat'
  | 'jelly'
  | 'tornado'
  | 'slide';

export type GiftAnimationSetting = GiftAnimationKey | 'random';

export interface Gift {
  id: string;
  name: string;
  nameEn?: string;
  imageUrl: string;
  kenPrice: number;
  charmPoints: number;
  animation?: GiftAnimationSetting;
  senderCharmPercent?: number;
}

export interface GiftSettings {
  enabled: boolean;
  quantityOptions: number[];
  quantityMax: number;
  noteMaxLength: number;
  confirmOverKen: number;
}

export interface GiftCatalog {
  items: Gift[];
  settings: GiftSettings;
}

export interface SendGiftRequest {
  giftId: string;
  receiverId: string;
  quantity: number;
  note?: string;
  source: GiftSource;
  clientRequestId: string;
}

export interface SendGiftResult {
  transactionId: string;
  gift: Gift;
  receiverId: string;
  quantity: number;
  totalKen: number;
  charmPoints: number;
  senderCharmPoints?: number;
  note?: string;
  kenBalance: number;
  receiverCharm: number;
  conversationId?: string;
  messageId?: string;
  createdAt: string;
}

export interface GiftMessageMetadata {
  transactionId: string;
  giftId: string;
  giftName: string;
  giftNameEn?: string;
  imageUrl: string;
  animation?: GiftAnimationSetting;
  quantity: number;
  charmPoints: number;
  senderCharmPoints?: number;
  note?: string;
}

export interface GiftUserBrief {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  gender?: string;
  vipUsed?: string | null;
  vipEndTime?: string | null;
}

export interface GiftWallItem {
  gift: Gift;
  quantity: number;
}

export interface GiftWall {
  userId: string;
  charm: number;
  totalGifts: number;
  items: GiftWallItem[];
}

export interface GiftHistoryItem {
  id: string;
  counterparty: GiftUserBrief;
  giftId: string;
  giftName: string;
  giftImageUrl: string;
  giftAnimation?: GiftAnimationSetting;
  quantity: number;
  totalKen: number;
  charmPoints: number;
  senderCharmPoints?: number;
  note?: string;
  source: GiftSource;
  createdAt: string;
}

export interface GiftHistoryResult {
  items: GiftHistoryItem[];
  nextCursor?: string;
}

export interface GiftHistoryParams {
  cursor?: string;
  limit?: number;
}

export interface GiftLeaderboardEntry {
  rank: number;
  user: GiftUserBrief;
  value: number;
}

export interface GiftLeaderboardResult {
  type: GiftLeaderboardType;
  period: GiftLeaderboardPeriod;
  items: GiftLeaderboardEntry[];
  me: { rank: number; value: number };
}

export interface GiftLeaderboardParams {
  type: GiftLeaderboardType;
  period: GiftLeaderboardPeriod;
  limit?: number;
}

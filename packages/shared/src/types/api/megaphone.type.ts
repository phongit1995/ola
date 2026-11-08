export interface MegaphoneSender {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  gender?: string;
  vipUsed?: string | null;
  vipEndTime?: string | null;
  avatarFrameId?: string | null;
}

export type MegaphoneType = 'message' | 'gift';

export interface MegaphoneGift {
  id: string;
  name: string;
  nameEn?: string;
  imageUrl: string;
  quantity: number;
}

export interface Megaphone {
  id: string;
  type: MegaphoneType;
  sender: MegaphoneSender;
  receiver?: MegaphoneSender;
  gift?: MegaphoneGift;
  content: string;
  showAt: string;
  displaySeconds: number;
  expiresAt: string;
  createdAt: string;
}

export interface MegaphoneConfig {
  enabled: boolean;
  kenPrice: number;
  maxLength: number;
  displaySeconds: number;
  liveMinutes: number;
  cooldownSeconds: number;
  dailyLimit: number;
  todayCount: number;
  cooldownRemaining: number;
  queueWaitSeconds: number;
}

export type MegaphoneAppConfig = Omit<MegaphoneConfig, 'todayCount' | 'cooldownRemaining' | 'queueWaitSeconds'>;

export interface SendMegaphoneRequest {
  content: string;
  clientRequestId: string;
}

export interface SendMegaphoneResult {
  megaphone: Megaphone;
  kenBalance: number;
  waitSeconds: number;
}

export interface MegaphoneHistoryParams {
  cursor?: string;
  limit?: number;
}

export interface MegaphoneHistoryResult {
  items: Megaphone[];
  nextCursor?: string;
}

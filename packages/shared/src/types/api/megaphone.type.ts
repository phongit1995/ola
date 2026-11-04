export interface MegaphoneSender {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  gender?: string;
  vipUsed?: string | null;
  vipEndTime?: string | null;
}

export interface Megaphone {
  id: string;
  sender: MegaphoneSender;
  content: string;
  showAt: string;
  displaySeconds: number;
  createdAt: string;
}

export interface MegaphoneConfig {
  enabled: boolean;
  kenPrice: number;
  maxLength: number;
  displaySeconds: number;
  cooldownSeconds: number;
  dailyLimit: number;
  todayCount: number;
  cooldownRemaining: number;
  queueWaitSeconds: number;
}

export interface SendMegaphoneRequest {
  content: string;
  clientRequestId: string;
}

export interface SendMegaphoneResult {
  megaphone: Megaphone;
  kenBalance: number;
  waitSeconds: number;
}

export interface MegaphoneActiveResult {
  items: Megaphone[];
  serverTime: string;
}

export interface MegaphoneHistoryParams {
  cursor?: string;
  limit?: number;
}

export interface MegaphoneHistoryResult {
  items: Megaphone[];
  nextCursor?: string;
}
